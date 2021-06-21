function [Optimized_House_grid_PV_EV_nonV2G,grid_PV_EV_nonV2G,All_Power_grid_PV_EV_nonV2G]=grid_PV_EV_nonV2G_opt(p_other,pv_pro,ev_demand,SOC_nonV2G,buy_price,sell_price,NumberofElectricVehicle) %elektrikli tasit koordinasyonu yok

peak_pwr=100;

eff=0.95;
ev_demand=ev_demand';
p_other=p_other';
p_other2=p_other;
p_other=ev_demand+p_other;
pv_pro=pv_pro';
buy_price=buy_price';
sell_price=sell_price';
SOC_nonV2G=SOC_nonV2G';
%degiskenler tanimlanir
u_grid=binvar(72,NumberofElectricVehicle);

grid=sdpvar(72,NumberofElectricVehicle,'full','real');
pv_used=sdpvar(72,NumberofElectricVehicle,'full','real');
pv_sold=sdpvar(72,NumberofElectricVehicle,'full','real');
sell=sdpvar(72,NumberofElectricVehicle,'full','real');
buy=sdpvar(72,NumberofElectricVehicle,'full','real');
midsum=sdpvar(72,NumberofElectricVehicle,'full','real');
%sinirlar belirtilir
const=[];
 for i=1:NumberofElectricVehicle
    
%      midsum(1,i)=sum(buy(:,1).*buy_price(:,1))-sum(sell(:,1).*sell_price(:,1));
    for t=1:1:72
const=[const,pv_used(t,i) <= pv_pro(t,i)];  
const=[const,pv_sold(t,i) <= pv_pro(t,i)];
const=[const,buy(t,i) <= peak_pwr*u_grid(t,i)]; 
const=[const,sell(t,i) <= peak_pwr*(1-u_grid(t,i))]; 
const=[const,0 <= [grid(t,i) pv_used(t,i) pv_sold(t,i)  sell(t,i) buy(t,i) midsum(t,i)] <= 1000];
const=[const,pv_used(t,i)+pv_sold(t,i) == pv_pro(t,i)];
const=[const,grid(t,i)+pv_used(t,i)==p_other(t,i)];
const=[const,const,sell(t,i) == pv_sold(t,i)];
const=[const,buy(t,i) == grid(t,i)];


    end
for t=2:72
% const=[const,-1<= buy(t,i)-buy(t-1,i) <=1.3 ];
% midsum(1,i)=sum(buy(t,i).*buy_price(t,1))-sum(sell(t,i).*sell_price(t,1),2);
midsum(1,i)=sum(buy(t,i).*buy_price(t,1))-sum(sell(t,i).*sell_price(t,1))-sum(buy(t,i)-buy(t-1,i)) ;
% midsum(1,i)=buy(t,i)-buy(t-1,i);
end
 end

total_cost_grid_PV_EV_nonV2G=midsum;

%optimizasyon sureci baslar
options = sdpsettings('solver','cplex');
sol = solvesdp(const,total_cost_grid_PV_EV_nonV2G,options);
% sol = solvesdp(const,deneme,options);
%sonuclar olusur ve tabloya aktarilir

for i=1:NumberofElectricVehicle
    
B = table([value(pv_pro(:,i))],[value(p_other2(:,i))],[value(grid(:,i))],[value(pv_used(:,i))],[value(pv_sold(:,i))],[value(sell(:,i))],[value(SOC_nonV2G(:,i))],[value(buy(:,i))],[value(ev_demand(:,i))],...
    'VariableNames',{ 'pv_pro' 'p_other' 'grid' 'pv_used' 'pv_sold' 'sell' 'ev_bat' 'buy' 'ev_bat_ch_grid'},...
    'RowNames',{'1AM' '2AM' '3AM' '4AM' '5AM' '6AM' '7AM' '8AM' '9AM' '10AM' '11AM' '12PM' '13PM' '14PM' '15PM' '16PM' '17PM' '18PM' '19PM' '20PM' '21PM' '22PM' '23PM' '00AM' '1AM(2)' '2AM(2)' '3AM(2)' '4AM(2)' '5AM(2)' '6AM(2)' '7AM(2)' '8AM(2)' '9AM(2)' '10AM(2)' '11AM(2)' '12PM(2)' '13PM(2)' '14PM(2)' '15PM(2)' '16PM(2)' '17PM(2)' '18PM(2)' '19PM(2)' '20PM(2)' '21PM(2)' '22PM(2)' '23PM(2)' '00AM(2)' '1AM(3)' '2AM(3)' '3AM(3)' '4AM(3)' '5AM(3)' '6AM(3)' '7AM(3)' '8AM(3)' '9AM(3)' '10AM(3)' '11AM(3)' '12PM(3)' '13PM(3)' '14PM(3)' '15PM(3)' '16PM(3)' '17PM(3)' '18PM(3)' '19PM(3)' '20PM(3)' '21PM(3)' '22PM(3)' '23PM(3)' '00AM(3)'});
total_cost_grid_PV_EV_nonV2G = table([value(midsum(1,i))],...
                 'VariableNames',{'total_cost_nonV2G'},...
                 'RowNames',{'baking'});
             
    b0=B;
    Optimized_House_grid_PV_EV_nonV2G{i,1}=b0;   
    grid_PV_EV_nonV2G(i,1)=total_cost_grid_PV_EV_nonV2G;
    All_Power_grid_PV_EV_nonV2G(i,:)=value(buy(:,i)');
end
%surecin duzgun isleyip islemedigi kontrol edilir
if sol.problem == 0
solution = value(total_cost_grid_PV_EV_nonV2G);
else
 disp('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
