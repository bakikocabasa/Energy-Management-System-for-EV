clc
buy_price=[0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04];
sell_price=ones(1,72)*0.065;
buy_price=[buy_price;buy_price];
sell_price=[sell_price;sell_price];
    initial_SOC=excelSoc(1:2,2);
    desired_SOC=excelSoc(1:2,1);
    initial_SOC=initial_SOC';
    desired_SOC=desired_SOC';
    ev_capacity=BatteryCapasity(1,1:2);
    desired_time=TamSaat(1,1:2:3);
    initial_time=TamSaat(1,2:2:4);
%     ev_bat_ch_grid=excelPowerbyTime(1:2,:)';
    ev_bat_ch_grid2=max(excelPowerbyTime(1:2,:));
    SOC_nonV2G=SOC_by_time(1:2,:);
    ChargePower=charge_power(1,1:2);
    p_other=bigdata_Houses(1:2,1:72);
    pv_pro=bigdata_Houses_pv(1:2,1:72);
    
if desired_time-initial_time<=5
ch_cap=40;
else 
ch_cap=ChargePower+1; %en önemli nokta bu yüksek
end
ch_cap2=0.5;
peak_pwr=ev_bat_ch_grid2+1;
eff=0.95;
initial_time2=initial_time+24;
desired_time2=desired_time+24;
initial_SOC2=initial_SOC;
desired_SOC2=desired_SOC;
p_other=p_other';
pv_pro=pv_pro';
buy_price=buy_price';
sell_price=sell_price';

const=[];

u_grid=binvar(72,2);
grid=sdpvar(72,2,'full','real');
pv_used=sdpvar(72,2,'full','real');
pv_sold=sdpvar(72,2,'full','real');
sell=sdpvar(72,2,'full','real');
buy=sdpvar(72,2,'full','real');
midsum2=sdpvar(72,2,'full','real');

for i=1:2
for t=1:1:72

const=[const,pv_used(t,i) <= pv_pro(t,i)];
const=[const,pv_sold(t,i) <= pv_pro(t,i)];
const=[const,buy(t,i) <= peak_pwr*u_grid(t,i)]; 
const=[const,sell(t,i) <= peak_pwr*(1-u_grid(t,i))]; 

const=[const,pv_used(t,i)+pv_sold(t,i) == pv_pro(t,i)];
const=[const,grid(t,i)+pv_used(t,i)==p_other(t,i)];
const=[const,const,sell(t,i) == pv_sold(t,i)];
const=[const,buy(t,i) == grid(t,i)];
const=[const,0 <= [grid(t,i) pv_used(t,i) pv_sold(t,i) sell(t,i) buy(t,i) midsum2(t,1)] <= 1000];
 


% sol = solvesdp(const,deneme,options);

end
end

midsum2=sum(buy.*buy_price)-sum(sell.*sell_price);
grid_PV_EV_DR_V2G2=sum(midsum2);

options = sdpsettings('solver','cplex');
sol = solvesdp(const,grid_PV_EV_DR_V2G2,options);


A = table([value(pv_pro)],[value(p_other)],[value(grid)],[value(pv_used)],[value(pv_sold)],[value(sell)],[value(buy)],...
    'VariableNames',{ 'pv_pro' 'p_other' 'grid' 'pv_used' 'pv_sold'  'sell' 'buy'},...
   'RowNames',{'1AM' '2AM' '3AM' '4AM' '5AM' '6AM' '7AM' '8AM' '9AM' '10AM' '11AM' '12PM' '13PM' '14PM' '15PM' '16PM' '17PM' '18PM' '19PM' '20PM' '21PM' '22PM' '23PM' '00AM' '1AM(2)' '2AM(2)' '3AM(2)' '4AM(2)' '5AM(2)' '6AM(2)' '7AM(2)' '8AM(2)' '9AM(2)' '10AM(2)' '11AM(2)' '12PM(2)' '13PM(2)' '14PM(2)' '15PM(2)' '16PM(2)' '17PM(2)' '18PM(2)' '19PM(2)' '20PM(2)' '21PM(2)' '22PM(2)' '23PM(2)' '00AM(2)' '1AM(3)' '2AM(3)' '3AM(3)' '4AM(3)' '5AM(3)' '6AM(3)' '7AM(3)' '8AM(3)' '9AM(3)' '10AM(3)' '11AM(3)' '12PM(3)' '13PM(3)' '14PM(3)' '15PM(3)' '16PM(3)' '17PM(3)' '18PM(3)' '19PM(3)' '20PM(3)' '21PM(3)' '22PM(3)' '23PM(3)' '00AM(3)'});
% grid_PV_EV_DR_V2G2 = table([value(grid_PV_EV_DR_V2G2)],...
%                  'VariableNames',{'total_cost_V2G'},...
%                  'RowNames',{'baking'});

% midsum(t,i)=buy(t,i).*buy_price(t,i)-sell(t,i).*sell_price(t,i); 

% grid_PV_EV_DR_V2G2=sum(midsum2);

if sol.problem == 0
solution = value(grid_PV_EV_DR_V2G2);
else
 disp('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
% value(ev_bat)

