function [a,b]=multisolvedeneme_pv_ev_v2g(House,NumberofElectricVehicle,TamSaat,bigdata_Houses,bigdata_Houses_pv,BatteryCapasity,excelSoc,excelPowerbyTime,charge_power,SOC_by_time,All_Power_grid_PV_EV_nonV2G)
All_Power_grid_PV_EV_nonV2Gsum2=sum(All_Power_grid_PV_EV_nonV2G(1:House,1:48));
maxnonv2g=max(All_Power_grid_PV_EV_nonV2Gsum2);
clc
buy_price=[0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04];
sell_price=ones(1,72)*0.065;
% buy_price=[buy_price;buy_price];
% sell_price=[sell_price;sell_price];
    initial_SOC=excelSoc(1:House,2);
    desired_SOC=excelSoc(1:House,1);
    initial_SOC=initial_SOC';
    desired_SOC=desired_SOC';
    ev_capacity=BatteryCapasity(1,1:House);
    desired_time=TamSaat(1,1:2:2*House-1);
    initial_time=TamSaat(1,2:2:2*House);
%     ev_bat_ch_grid=excelPowerbyTime(1:2,:)';
for x=1:House
    ev_bat_ch_grid2(x,1)=max(excelPowerbyTime(x,:));
end
ev_bat_ch_grid2=ev_bat_ch_grid2*1.2;
    SOC_nonV2G=SOC_by_time(1:House,:);
    ChargePower=charge_power(1,1:House);
    p_other=bigdata_Houses(1:House,1:72);
    pv_pro=bigdata_Houses_pv(1:House,1:72);
    
    all_power_nonv2g=sum(bigdata_Houses(1:House,1:72)+excelPowerbyTime(1:House,1:72))';
    



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

u_grid=binvar(72,House);
u_bat_ev=binvar(72,House);
grid=sdpvar(72,House,'full','real');
pv_used=sdpvar(72,House,'full','real');
pv_sold=sdpvar(72,House,'full','real');

sell=sdpvar(72,House,'full','real');
buy=sdpvar(72,House,'full','real');
ev_bat_sold=sdpvar(72,House,'full','real');
ev_bat_ch_pv=sdpvar(72,House,'full','real');
ev_bat_used=sdpvar(72,House,'full','real');
ev_bat_ch_grid=sdpvar(72,House,'full','real');
ev_bat=sdpvar(72,House,'full','real');
ev_bat_disch=sdpvar(72,House,'full','real');
ev_bat_ch=sdpvar(72,House,'full','real');
power_on_bus=sdpvar(72,House,'full','real');
midsum=sdpvar(72,House,'full','real');
midsum2=sdpvar(72,House,'full','real');
max_power_limit=sdpvar(72,1,'full','real');

const=[const,max_power_limit==sum(buy,2)];
const=[const,max_power_limit<=maxnonv2g-1]; %deneme yapiliyor 16.02 trafo sinirlamasi
% const=[const,-5<=max_power_limit-all_power_nonv2g<=5];

for i=1:House
    
ch_cap(1,i)=ChargePower(1,i)+1; %en önemli nokta bu yüksek
peak_pwr(1,i)=ch_cap(1,i)+3;
ch_cap2=0.5;

    for t=1:1:72
         

const=[const,ev_bat_used(t,i) <= ev_bat_disch(t,i)];
const=[const,ev_bat_ch(t,i) <= ev_bat_ch_grid2(i,1)*u_bat_ev(t,i)]; 
const=[const,ev_bat_disch(t,i) <= ch_cap2*(1-u_bat_ev(t,i))]; 
const=[const,ev_bat_ch_pv(t,i) <= pv_pro(t,i)];
const=[const, initial_SOC(1,i) <= ev_bat(t,i)]; %ba?lang?çtan itibaren %10 degisim olabilir
const=[const,pv_used(t,i) <= pv_pro(t,i)];
const=[const,pv_sold(t,i) <= pv_pro(t,i)];
const=[const,buy(t,i) <= peak_pwr(1,i)*u_grid(t,i)]; 
const=[const,sell(t,i) <= peak_pwr(1,i)*(1-u_grid(t,i))]; 
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

for i=1:House
const=[const,ev_bat(1:initial_time(1,i)-1,i)==initial_SOC(1,i)]; % arac?n ba?lang?ç yüzdesi ile de?i?cek bu sayi
const=[const,ev_bat(initial_time(1,i),i)==initial_SOC(1,i)];
const=[const,ev_bat_used(1:initial_time(1,i),i)==0];
const=[const,ev_bat_sold(1:initial_time(1,i),i)==0];
% const=[const,-1<= buy(2:72,i)-buy(1:71,i) <=1.8 ];
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
midsum(1,i)=sum(buy(t,i).*buy_price(t,1))-sum(sell(t,i).*sell_price(t,1),2);
% midsum(1,i)=sum(buy(t,i).*buy_price(t,1))-sum(sell(t,i).*sell_price(t,1))-sum(buy(t,i)-buy(t-1,i)) ;
% midsum(1,i)=buy(t,i)-buy(t-1,i);
end
end
% midsum=sum(buy.*buy_price-sell.*sell_price);
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
             
end
if sol.problem == 0
solution = value(total_cost_grid_PV_EV_V2G);
else
 disp('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
all_power_v2g=sum(All_Power_grid_PV_EV_V2G(1:NumberofElectricVehicle,1:48));
 all_power_nonv2g=sum(bigdata_Houses(1:NumberofElectricVehicle,1:48)+excelPowerbyTime(1:NumberofElectricVehicle,1:48));
 plot(1:48,all_power_v2g,1:48,all_power_nonv2g)
%  a=sum(all_power_nonv2g.*buy_price(1,1:48))
%  b=sum(all_power_v2g.*buy_price(1,1:48))
All_Power_grid_EV_nonV2G2=sum(All_Power_grid_EV_nonV2G(1:House,1:48));
All_Power_grid_sum2=sum(bigdata_Houses(1:House,1:48));
All_Power_grid_PV_sum2=sum(All_Power_grid_PV(1:House,1:48));
All_Power_grid_PV_EV_nonV2Gsum2=sum(All_Power_grid_PV_EV_nonV2G(1:House,1:48));
        HoursofaDay=1:48;
        HoursofaDay=HoursofaDay';
 t = tiledlayout(3,1);
        % comparison grid vs grid+DR
        ax1 = nexttile;
        plot(ax1,HoursofaDay,All_Power_grid_sum2,':r',HoursofaDay,All_Power_grid_PV_sum2,'k','LineWidth',3)
        legend(ax1,'grid','grid+PV')

        ax2 = nexttile;
        plot(ax2,HoursofaDay,all_power_v2g,':r',HoursofaDay,All_Power_grid_PV_EV_nonV2Gsum2,'k','LineWidth',3);
        legend(ax2,'pvli v2g','pvli nonv2g')

        ax3 = nexttile;
        plot(ax3,HoursofaDay,All_Power_grid_EV_nonV2G2,':r',HoursofaDay,All_Power_grid_sum2,'k','LineWidth',3);
        legend(ax3,'pvsiz nonv2g','grid')