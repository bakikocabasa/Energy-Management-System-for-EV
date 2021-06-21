function [Optimized_House_grid_PV_EV_V2G,grid_PV_EV_V2G,All_Power_grid_PV_EV_V2G]=grid_PV_EV_V2G_opt(All_Power_grid_PV_EV_nonV2G,bigdata_Houses,excelPowerbyTime,initial_time,desired_time,p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC,buy_price,sell_price,NumberofElectricVehicle)
u_grid=binvar(72,NumberofElectricVehicle);
u_bat_ev=binvar(72,NumberofElectricVehicle);
grid=sdpvar(72,NumberofElectricVehicle,'full','real');
pv_used=sdpvar(72,NumberofElectricVehicle,'full','real');
pv_sold=sdpvar(72,NumberofElectricVehicle,'full','real');
sell=sdpvar(72,NumberofElectricVehicle,'full','real');
buy=sdpvar(72,NumberofElectricVehicle,'full','real');
ev_bat_sold=sdpvar(72,NumberofElectricVehicle,'full','real');
ev_bat_ch_pv=sdpvar(72,NumberofElectricVehicle,'full','real');
ev_bat_used=sdpvar(72,NumberofElectricVehicle,'full','real');
ev_bat_ch_grid=sdpvar(72,NumberofElectricVehicle,'full','real');
ev_bat=sdpvar(72,NumberofElectricVehicle,'full','real');
ev_bat_disch=sdpvar(72,NumberofElectricVehicle,'full','real');
ev_bat_ch=sdpvar(72,NumberofElectricVehicle,'full','real');
power_on_bus=sdpvar(72,NumberofElectricVehicle,'full','real');
midsum=sdpvar(72,NumberofElectricVehicle,'full','real');
max_power_limit=sdpvar(72,1,'full','real');
eff=0.95;
initial_time2=initial_time+24;
desired_time2=desired_time+24;
initial_SOC2=initial_SOC;
desired_SOC2=desired_SOC;
p_other=p_other';
pv_pro=pv_pro';
buy_price=buy_price';
sell_price=sell_price';
discharge_max=0.5;
%%%%%%%%%%%%%%%%


sebekenonv2g=sum(All_Power_grid_PV_EV_nonV2G);
sebekemax=max(sebekenonv2g)-2;

const=[];
const=[const,max_power_limit==sum(buy,2)];
const=[const,max_power_limit<=sebekemax]; %deneme yapiliyor 16.02 trafo sinirlamasi
% const=[const,-5<=max_power_limit-all_power_nonv2g<=5];

for i=1:NumberofElectricVehicle
    ev_Charge_max(i,1)=max(excelPowerbyTime(i,:));
    ev_Charge_max(i,1)=ev_Charge_max(i,1)*1.2;
    for t=1:72
        const=[const,ev_bat_ch(t,i) <= ev_Charge_max(i,1)*u_bat_ev(t,i)]; 
        const=[const,buy(t,i) <= sebekemax*u_grid(t,i)]; 
        const=[const,sell(t,i) <= sebekemax*(1-u_grid(t,i))]; 
        
const=[const,ev_bat_used(t,i) <= ev_bat_disch(t,i)];
const=[const,ev_bat_disch(t,i) <= discharge_max*(1-u_bat_ev(t,i))]; 
const=[const,ev_bat_ch_pv(t,i) <= pv_pro(t,i)];
const=[const, initial_SOC(1,i) <= ev_bat(t,i)]; %ba?lang?çtan itibaren %20 degisim olabilir 
const=[const,pv_used(t,i) <= pv_pro(t,i)];
const=[const,pv_sold(t,i) <= pv_pro(t,i)];
const=[const,buy(t,i) == grid(t,i)+ev_bat_ch_grid(t,i)];
const=[const,pv_used(t,i)+pv_sold(t,i)+ev_bat_ch_pv(t,i) == pv_pro(t,i)];
const=[const,const,sell(t,i) == pv_sold(t,i)+ev_bat_sold(t,i)];
const=[const,ev_bat_ch_pv(t,i)+ev_bat_ch_grid(t,i) == ev_bat_ch(t,i)*eff];
const=[const,grid(t,i)+pv_used(t,i)+ev_bat_used(t,i)==p_other(t,i)];
const=[const,ev_bat_sold(t,i)+ev_bat_used(t,i) == ev_bat_disch(t,i)*eff];
const=[const,ev_bat(t,i)<=desired_SOC(1,i)];
const=[const,0 <= [grid(t,i) pv_used(t,i)  pv_sold(t,i)  sell(t,i) buy(t,i) midsum(t,i) ev_bat_ch(t,i) ev_bat_disch(t,i) ev_bat_ch_grid(t,i) ev_bat_ch_pv(t,i) ev_bat_sold(t,i) ev_bat_used(t,i) power_on_bus(t,i)] <= 1000];
    end
end

for i=1:NumberofElectricVehicle
const=[const,ev_bat(1:initial_time(1,i)-1,i)==initial_SOC(1,i)]; % arac?n ba?lang?ç yüzdesi ile de?i?cek bu sayi
const=[const,ev_bat(initial_time(1,i),i)==initial_SOC(1,i)];
const=[const,ev_bat_used(1:initial_time(1,i),i)==0];
const=[const,ev_bat_sold(1:initial_time(1,i),i)==0];
const=[const,ev_bat(initial_time2(1,i),i)==initial_SOC2(1,i)];
const=[const,ev_bat(desired_time(1,i),i) == desired_SOC(1,i)]; %%
const=[const,ev_bat(desired_time2(1,i),i) == desired_SOC2(1,i)];%%
const=[const,ev_bat(desired_time(1,i)+1:initial_time2(1,i)-1,i) == desired_SOC(1,i)];
const=[const,ev_bat_disch(desired_time(1,i)+1:initial_time2(1,i)-1,i) == 0];
const=[const,ev_bat_ch(desired_time(1,i)+1:initial_time2(1,i)-1,i) == 0];
const=[const,ev_bat_used(initial_time2(1,i),i) == 0];
const=[const,[ev_bat_ch(desired_time2(1,i)+1:72,i) ev_bat_used(desired_time2(1,i)+1:72,i) ev_bat_disch(desired_time2(1,i)+1:72,i) ]==0];
const=[const,ev_bat_disch(desired_time(1,i)+1:initial_time2(1,i)-1)==0];
const=[const,ev_bat(desired_time2+1:72,i)==ev_bat(desired_time2(1,i),i)];
const=[const,ev_bat_disch(initial_time2(1,i),i) == 0]; %%%%
const=[const,ev_bat_ch(1:initial_time(1,i)-1,i) == 0]; 
const=[const,ev_bat_disch(1:initial_time(1,i)-1,i) == 0]; 
const=[const,ev_bat(initial_time(1,i)+1:desired_time(1,i),i) == ev_bat(initial_time(1,i):desired_time(1,i)-1,i)+(ev_bat_ch(initial_time(1,i)+1:desired_time(1,i),i)*eff-ev_bat_disch(initial_time(1,i)+1:desired_time(1,i),i))/ev_capacity(1,i)*100];%% aracin giris saati ile degisecek
const=[const,ev_bat(initial_time2(1,i)+1:desired_time2(1,i),i) == ev_bat(initial_time2(1,i):desired_time2(1,i)-1,i)+(ev_bat_ch(initial_time2(1,i)+1:desired_time2(1,i),i)*eff-ev_bat_disch(initial_time2(1,i)+1:desired_time2(1,i),i))/ev_capacity(1,i)*100];%% aracin giris saati ile degisecek
for t=2:72
% const=[const,-1<= buy(t,i)-buy(t-1,i) <=1.3 ];
% midsum(1,i)=sum(buy(t,i).*buy_price(t,1))-sum(sell(t,i).*sell_price(t,1),2);
midsum(1,i)=sum(buy(t,i).*buy_price(t,1)-sell(t,i).*sell_price(t,1)-sum(buy(t,i)-buy(t-1,i)));
% midsum(1,i)=buy(t,i)-buy(t-1,i);
end
end
% midsum=sum(sum(buy,2).*buy_price-sum(sell,2).*sell_price);
total_cost_grid_PV_EV_V2G=midsum;
% total_cost_grid_PV_EV_V2G=sum(midsum,2);

%optimization
options = sdpsettings('solver','cplex');
sol = solvesdp(const,total_cost_grid_PV_EV_V2G,options);
% sol = solvesdp(const,deneme,options);

for i=1:NumberofElectricVehicle
    
A = table([value(pv_pro(:,i))],[value(p_other(:,i))],[value(grid(:,i))],[value(pv_used(:,i))],[value(pv_sold(:,i))],[value(sell(:,i))],[value(ev_bat_disch(:,i))],[value(ev_bat_ch_grid(:,i))],[value(ev_bat_ch_pv(:,i))],[value(ev_bat(:,i))],[value(buy(:,i))],...
    'VariableNames',{ 'pv_pro' 'p_other' 'grid' 'pv_used' 'pv_sold'  'sell' 'ev_bat_disch' 'ev_bat_ch_grid' 'ev_bat_ch_pv' 'ev_bat' 'buy'},...
    'RowNames',{'1AM' '2AM' '3AM' '4AM' '5AM' '6AM' '7AM' '8AM' '9AM' '10AM' '11AM' '12PM' '13PM' '14PM' '15PM' '16PM' '17PM' '18PM' '19PM' '20PM' '21PM' '22PM' '23PM' '00AM' '1AM(2)' '2AM(2)' '3AM(2)' '4AM(2)' '5AM(2)' '6AM(2)' '7AM(2)' '8AM(2)' '9AM(2)' '10AM(2)' '11AM(2)' '12PM(2)' '13PM(2)' '14PM(2)' '15PM(2)' '16PM(2)' '17PM(2)' '18PM(2)' '19PM(2)' '20PM(2)' '21PM(2)' '22PM(2)' '23PM(2)' '00AM(2)' '1AM(3)' '2AM(3)' '3AM(3)' '4AM(3)' '5AM(3)' '6AM(3)' '7AM(3)' '8AM(3)' '9AM(3)' '10AM(3)' '11AM(3)' '12PM(3)' '13PM(3)' '14PM(3)' '15PM(3)' '16PM(3)' '17PM(3)' '18PM(3)' '19PM(3)' '20PM(3)' '21PM(3)' '22PM(3)' '23PM(3)' '00AM(3)'});
total_cost_grid_PV_EV_V2G = table([value(midsum(1,i))],...
                 'VariableNames',{'total_cost_V2G'},...
                 'RowNames',{'baking'});
    a0 = A;
    Optimized_House_grid_PV_EV_V2G{i,1} = a0;
    grid_PV_EV_V2G(i,1)=total_cost_grid_PV_EV_V2G;
    All_Power_grid_PV_EV_V2G(i,:)=value(buy(:,i)');
%     fark(i,1)=sum(All_Power_grid_PV_EV_nonV2G(i,initial_time(1,i):desired_time(1,i)))-sum(All_Power_grid_PV_EV_V2G(i,initial_time(1,i):desired_time(1,i)));
   
%       for t=initial_time(1,i):desired_time(1,i)
%           All_Power_grid_PV_EV_V2G(i,t)=All_Power_grid_PV_EV_V2G(i,t)+fark(i,1)/(desired_time(1,i)-initial_time(1,i)+1);
%       end
end

if sol.problem == 0
solution = value(total_cost_grid_PV_EV_V2G);
else
 disp('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
