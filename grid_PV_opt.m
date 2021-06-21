function [Optimized_House_grid_PV,grid_PV,All_Power_grid_PV]=grid_PV_opt(p_other,pv_pro,buy_price,sell_price,House)



% sebeke=sum(p_other);
% sebekemax=max(sebeke);
eff=0.95;
p_other=p_other';
pv_pro=pv_pro';
buy_price=buy_price';
sell_price=sell_price';
%degiskenler tanimlanir

u_grid=binvar(72,House);
grid=sdpvar(72,House,'full','real');
pv_used=sdpvar(72,House,'full','real');
pv_sold=sdpvar(72,House,'full','real');
sell=sdpvar(72,House,'full','real');
buy=sdpvar(72,House,'full','real');
midsum=sdpvar(72,House,'full','real');
%sinirlar belirtilir
const=[];
 for i=1:House
    
    for t=1:1:72
const=[const,pv_used(t,i) <= pv_pro(t,i)];
const=[const,pv_sold(t,i) <= pv_pro(t,i)];
const=[const,buy(t,i) <= 1000000*u_grid(t,i)]; 
const=[const,sell(t,i) <= 1000000*(1-u_grid(t,i))]; 
const=[const,0 <= [grid(t,i) pv_used(t,i) pv_sold(t,i)  sell(t,i) buy(t,i) midsum(t,i)] <= 1000];
const=[const,pv_used(t,i)+pv_sold(t,i) == pv_pro(t,i)];
const=[const,grid(t,i)+pv_used(t,i)==p_other(t,i)];
const=[const,const,sell(t,i) == pv_sold(t,i)];
const=[const,buy(t,i) == grid(t,i)];
% const=[const,-1 <= buy(2:72)-buy(1:71) <=1 ];
    end
 end
 
for t=2:72
% const=[const,-1<= buy(t,i)-buy(t-1,i) <=1.3 ];
% midsum(1,i)=sum(buy(t,i).*buy_price(t,1))-sum(sell(t,i).*sell_price(t,1),2);
midsum(1,i)=sum(buy(t,i).*buy_price(t,1))-sum(sell(t,i).*sell_price(t,1))-sum(buy(t,i)-buy(t-1,i)) ;
% midsum(1,i)=buy(t,i)-buy(t-1,i);
end

total_cost_grid_PV=midsum;

% deneme=buy(2:72)-buy(1:71);
%optimizasyon sureci baslar
options = sdpsettings('solver','cplex');
sol = solvesdp(const,total_cost_grid_PV,options);
% sol = solvesdp(const,deneme,options);
%sonuclar olusur ve tabloya aktarilir

for i=1:House
    
C = table([value(pv_pro(:,i))],[value(p_other(:,i))],[value(grid(:,i))],[value(pv_used(:,i))],[value(pv_sold(:,i))],[value(sell(:,i))],[value(buy(:,i))],[value(midsum(:,i))],...
    'VariableNames',{ 'pv_pro' 'p_other' 'grid' 'pv_used' 'pv_sold'  'sell' 'buy' 'TotalCost'},...
   'RowNames',{'1AM' '2AM' '3AM' '4AM' '5AM' '6AM' '7AM' '8AM' '9AM' '10AM' '11AM' '12PM' '13PM' '14PM' '15PM' '16PM' '17PM' '18PM' '19PM' '20PM' '21PM' '22PM' '23PM' '00AM' '1AM(2)' '2AM(2)' '3AM(2)' '4AM(2)' '5AM(2)' '6AM(2)' '7AM(2)' '8AM(2)' '9AM(2)' '10AM(2)' '11AM(2)' '12PM(2)' '13PM(2)' '14PM(2)' '15PM(2)' '16PM(2)' '17PM(2)' '18PM(2)' '19PM(2)' '20PM(2)' '21PM(2)' '22PM(2)' '23PM(2)' '00AM(2)' '1AM(3)' '2AM(3)' '3AM(3)' '4AM(3)' '5AM(3)' '6AM(3)' '7AM(3)' '8AM(3)' '9AM(3)' '10AM(3)' '11AM(3)' '12PM(3)' '13PM(3)' '14PM(3)' '15PM(3)' '16PM(3)' '17PM(3)' '18PM(3)' '19PM(3)' '20PM(3)' '21PM(3)' '22PM(3)' '23PM(3)' '00AM(3)'});
total_cost_grid_PV = table([value(midsum(1,i))],...
                 'VariableNames',{'total_cost_nonV2G'},...
                 'RowNames',{'Row1'});
    j0=C;
    Optimized_House_grid_PV{i,1} = j0;
    grid_PV(i,1)=total_cost_grid_PV;
    All_Power_grid_PV(i,:)=value(buy(:,i)');
end
%surecin duzgun isleyip islemedigi kontrol edilir
if sol.problem == 0
solution = value(total_cost_grid_PV);
else
 disp('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end

