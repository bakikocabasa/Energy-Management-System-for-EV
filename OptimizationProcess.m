clc
clear all

cd 'C:\Users\ikoca\Desktop\Matlab Optimization\mainproject'
format bank

global BatteryCapasity
global NumberofElectricVehicle
%% area
o=menu('Please select an area','Residential','Commercial','Industrial');
[q,q1,q2,q3,q4,q5,distribution,House,AVM,Uni,Hospital,Social_Facilities,Organized_industry,Industrial_Factory]=Regions(o);

%% battery type and vehicle brand selection
disp('Battery Capasities of the brands (Tesla-Ferrari-Porsche-Günsel-TOGG-Ford-Nissan-Toyota-Fiat-Hyundai)=[33 40 41.8 24 64 93 80 80 90 100]')
k=menu('Please select the vehicle brands in the area','Porsche-Ford-Nissan-Toyota-Fiat-Hyundai','Ford-Nissan-Toyota-Fiat-BMWi3','Nissan-Toyota-Fiat-Hyundai','Ford-Toyota-Fiat-Hyundai','Ford-Nissan-Fiat-Hyundai','Tesla-Ferrari-Porsche-Günsel-TOGG-Ford-Nissan-Toyota-Fiat-Hyundai');
[BatteryCapasity,NumberofElectricVehicle]=Batteries(k);
%% Residential area
if o==1 
            LB=LOWboundriesRes(q,NumberofElectricVehicle);
            UB=UPboundries(LB,NumberofElectricVehicle);
end
%% Commercial area
        if o==2
            if distribution~=6
            LB=LOWboundriesCom(distribution,q,NumberofElectricVehicle);
            elseif distribution==6
            [LB,m]=Multioption(q1,q2,q3,q4,q5,House,AVM,Uni,Hospital,Social_Facilities,NumberofElectricVehicle);
            end
        UB=UPboundries(LB,NumberofElectricVehicle);    
        end

%% Industrial area
if o==3
    LB=LOWboundriesEnd(q,NumberofElectricVehicle);
    UB=UPboundries(LB,NumberofElectricVehicle);
end
%% Pv penetration
pv_penetration=0;
while pv_penetration==0
    disp('Please choose one of them')
    pv_penetration=menu('Please select the Pv penetration ratio','%50','%100','%150');
end
if pv_penetration==1
    pv_penetration=0.5;
elseif pv_penetration==2
    pv_penetration=1;
elseif pv_penetration==3
    pv_penetration=1.5;
end
% %% Fast charging stations
% disp('commercial and passenger vehicles can benefit from fast charging all day')
% FastChargingStation=input('Please enter the number of fast charging stations in the area(0-10): ');
% while FastChargingStation>10 || FastChargingStation==0
%     disp('Please choose one number between 1-10')
%     FastChargingStation=input('Please enter the number of fast charging stations in the area(0-10): ');
% end

LB(4*NumberofElectricVehicle+1)=1;
UB(4*NumberofElectricVehicle+1)=10;

% rng(0, 'twister');



%% Optimization block
nvars=4*NumberofElectricVehicle+1;
obj = @mainfunction;
ConsFcn = @sinirlar;
opts=optimoptions(@ga,'PopulationSize',House,'MaxGenerations',100,'EliteCount',2,'FunctionTolerance', 1e-7,'PlotFcn', @gaplotbestf); 
[t,fval,exitflag,output,population,scores] = ga(obj,nvars,[],[],[],[],LB,UB,ConsFcn,[1:nvars],opts);
%% Important values
display(output)

orneklem=population(House,:); %optimizasyon dogrulugu icin populationsize buyuk secildi ancak degerlerin islenmesi acisindan kendi orneklemimizi 200 bandindan sectik
[SOC_by_time,TamSaat,TotalPoweronBus,HoursofaDay,excelSoc,excelSaat,excelPowerbyTime,excelPowerbyTime2,excelEnergyDemand]=values(NumberofElectricVehicle,orneklem,BatteryCapasity,scores);

%% Consumer power data divider
[bigdata_Houses,bigdata_Uni,bigdata_AVM,bigdata_Hospital,bigdata_Social_Facilities,bigdata_Organized_industry,bigdata_Industrial_Factory,bigdata_Houses_pv,bigdata_Uni_pv,bigdata_AVM_pv,bigdata_Hospital_pv,bigdata_Social_Facilities_pv,bigdata_Organized_industry_pv,bigdata_Industrial_Factory_pv]=ConsumerPower(o,House,Uni,AVM,Hospital,Social_Facilities,Organized_industry,Industrial_Factory,distribution,population,pv_penetration);
HoursofaDay=HoursofaDay';


%% 
bigdata_Houses_DR=bigdata_Houses;
for i=1:6
bigdata_Houses_DR(:,17+i)=bigdata_Houses(:,17+i).*0.8;
cut(:,i)=bigdata_Houses(:,17+i).*0.2;
bigdata_Houses_DR(:,40+i)=bigdata_Houses(:,40+i).*0.8;
cut2(:,i)=bigdata_Houses(:,30+i).*0.2;
bigdata_Houses_DR(:,24+i)= bigdata_Houses_DR(:,24+i)+cut(:,i);
bigdata_Houses_DR(:,47+i)= bigdata_Houses_DR(:,47+i)+cut2(:,i);
end

for y=1:NumberofElectricVehicle
    charge_power(1,y)=max(excelPowerbyTime(y,:));
    
end

%% Consumer power optimizer
tic
pu=[0	0	0	0	0	0	0.063238791	0.511964915	0.749138016	1.018153868	1.0224203	1.061992679	1.030899001	0.732870551	0.47002527	0.315508556	0.15894215	0	0	0	0	0	0	0 0	0	0	0	0	0	0.063238791	0.511964915	0.749138016	1.018153868	1.0224203	1.061992679	1.030899001	0.732870551	0.47002527	0.315508556	0.15894215	0	0	0	0	0	0	0 0	0	0	0	0	0	0.063238791	0.511964915	0.749138016	1.018153868	1.0224203	1.061992679	1.030899001	0.732870551	0.47002527	0.315508556	0.15894215	0	0	0	0	0	0	0];
demand=sum(bigdata_Houses);
peak_demand=max(demand);
peak_pv=peak_demand*pv_penetration;
% [x,v] = randfixedsum(n,m,s,a,b)
[x,v] = randfixedsum(House,1,peak_pv,0,10);
bigdata_Houses_pv=x.*pu;
        [grid_PV_ESS,grid_PV_ESS_DR,All_Power_grid_PV_ESS_DR,All_Power_grid_PV_ESS,All_Power_grid_EV_DR_nonV2G,All_Power_grid_EV_nonV2G,grid_EV_nonV2G,grid_EV_DR_nonV2G,grid_PV_EV_DR_nonV2G,All_Power_grid_PV_EV_DR_nonV2G,grid_PV_EV_DR_V2G,All_Power_grid_PV_EV_DR_V2G,grid_PV_EV_V2G,All_Power_grid_PV_EV_V2G,grid_PV_EV_nonV2G,All_Power_grid_PV_EV_nonV2G,grid_PV_DR,All_Power_grid_PV_DR,All_Power_grid_EV_DR_V2G,grid_EV_DR_V2G,All_Power_grid_EV_V2G,grid_EV_V2G,All_Power_grid_PV,grid_PV,Optimized_House_grid_PV_EV_V2G,Optimized_House_grid_PV_EV_nonV2G,Optimized_House_grid_PV,Optimized_House_grid_EV_V2G,Optimized_House_grid_EV_DR_V2G,Optimized_House_grid_PV_DR,Optimized_House_grid_PV_EV_DR_V2G,Optimized_House_grid_PV_EV_DR_nonV2G,Optimized_House_grid_PV_ESS_DR,Optimized_House_grid_PV_ESS,Optimized_Uni,Optimized_AVM,Optimized_Hospital,Optimized_Social_Facilities,Optimized_Organized_industry,Optimized_Industrial_Factory]=ConsumerValueOptimizer(SOC_by_time,TamSaat,BatteryCapasity,excelSoc,bigdata_Houses,bigdata_Uni,bigdata_AVM,bigdata_Hospital,bigdata_Social_Facilities,bigdata_Organized_industry,bigdata_Industrial_Factory,bigdata_Houses_pv,bigdata_Uni_pv,bigdata_AVM_pv,bigdata_Hospital_pv,bigdata_Social_Facilities_pv,bigdata_Organized_industry_pv,bigdata_Industrial_Factory_pv,excelPowerbyTime,excelPowerbyTime2,NumberofElectricVehicle,bigdata_Houses_DR,charge_power)
       
        for x=1:NumberofElectricVehicle
        a(x,1)=sum(All_Power_grid_EV_DR_V2G(x,:),2);
        b(x,1)=sum(All_Power_grid_EV_V2G(x,:),2);
        c(x,1)=sum(All_Power_grid_PV_EV_DR_V2G(x,:),2);
        d(x,1)=sum(All_Power_grid_PV_EV_V2G(x,:),2);
        if a(x,1)==0
            All_Power_grid_EV_DR_V2G(x,:)=All_Power_grid_EV_DR_V2G(NumberofElectricVehicle,:);
             All_Power_grid_EV_DR_nonV2G(x,:)=All_Power_grid_EV_DR_nonV2G(NumberofElectricVehicle,:);
        end
        if b(x,1)==0
            All_Power_grid_EV_V2G(x,:)=All_Power_grid_EV_V2G(NumberofElectricVehicle,:);
            All_Power_grid_EV_nonV2G(x,:)=All_Power_grid_EV_nonV2G(NumberofElectricVehicle,:);
        end
        if c(x,1)==0
            All_Power_grid_PV_EV_DR_V2G(x,:)=All_Power_grid_PV_EV_DR_V2G(NumberofElectricVehicle,:);
            All_Power_grid_PV_EV_DR_nonV2G(x,:)=All_Power_grid_PV_EV_DR_nonV2G(NumberofElectricVehicle,:);
        end        
        if d(x,1)==0
            All_Power_grid_PV_EV_V2G(x,:)=All_Power_grid_PV_EV_V2G(NumberofElectricVehicle,:);
            All_Power_grid_PV_EV_nonV2G(x,:)=All_Power_grid_PV_EV_nonV2G(NumberofElectricVehicle,:);
        end  
        end
        % grid
        All_Power_grid_sum=sum(bigdata_Houses(:,1:48));
        All_Power_grid_DR_sum=sum(bigdata_Houses_DR(:,1:48));
        All_Power_grid_sum2=sum(bigdata_Houses(NumberofElectricVehicle+1:House,1:48));
        All_Power_grid_DR_sum2=sum(bigdata_Houses_DR(NumberofElectricVehicle+1:House,1:48));
        % grid+EV+V2G
        All_Power_grid_EV_V2G_sum=sum(All_Power_grid_EV_V2G(:,1:48))+All_Power_grid_sum2;
        All_Power_grid_EV_DR_V2G_sum=sum(All_Power_grid_EV_DR_V2G(:,1:48))+All_Power_grid_DR_sum2;
        % grid+EV+nonV2G
        All_Power_grid_EV_nonV2G_sum=sum(All_Power_grid_EV_nonV2G(:,1:48))+All_Power_grid_sum2;
        All_Power_grid_EV_DR_nonV2G_sum=sum(All_Power_grid_EV_DR_nonV2G(:,1:48))+All_Power_grid_DR_sum2;
        % grid+PV
        All_Power_grid_PV_sum=sum(All_Power_grid_PV(:,1:48));
        All_Power_grid_PV_DR_sum=sum(All_Power_grid_PV_DR(:,1:48));
        % grid+PV+ESS
        All_Power_grid_PV_ESS_sum=sum(All_Power_grid_PV_ESS(:,1:48));
        All_Power_grid_PV_ESS_DR_sum=sum(All_Power_grid_PV_ESS_DR(:,1:48));
        % grid+PV+EV+nonV2G
        nonV2G=sum(All_Power_grid_PV_EV_nonV2G(:,1:48));
        All_Power_grid_PV_EV_nonV2G_sum=sum(All_Power_grid_PV_EV_nonV2G(:,1:48))+All_Power_grid_sum2;
        All_Power_grid_PV_EV_DR_nonV2G_sum=sum(All_Power_grid_PV_EV_DR_nonV2G(:,1:48))+All_Power_grid_DR_sum2;
        % grid+PV+EV+V2G
        V2G=sum(All_Power_grid_PV_EV_V2G(:,1:48));
        All_Power_grid_PV_EV_V2G_sum=sum(All_Power_grid_PV_EV_V2G(:,1:48))+All_Power_grid_sum2;

        All_Power_grid_PV_EV_DR_V2G_sum=sum(All_Power_grid_PV_EV_DR_V2G(:,1:48))+All_Power_grid_DR_sum2;


        % grid 
%         gerek yok zaten bu deger tablo degil
        % grid+PV 
        grid_PV = table2array(grid_PV);
        grid_PV_DR=table2array(grid_PV_DR);
        % grid+PV+ESS  
        grid_PV_ESS = table2array(grid_PV_ESS);
        grid_PV_ESS_DR=table2array(grid_PV_ESS_DR);
        % grid+EV+V2G 
        grid_EV_V2G=table2array(grid_EV_V2G);
        grid_EV_DR_V2G=table2array(grid_EV_DR_V2G);
        % grid+EV+nonV2G  
%         grid_EV_nonV2G=table2array(grid_EV_nonV2G);
%         grid_EV_DR_nonV2G=table2array(grid_EV_DR_nonV2G);
        % grid+PV+EV+V2G
        grid_PV_EV_DR_V2G=table2array(grid_PV_EV_DR_V2G);
        grid_PV_EV_V2G=table2array(grid_PV_EV_V2G);
        % grid+PV+EV+nonV2G 
        grid_PV_EV_nonV2G=table2array(grid_PV_EV_nonV2G);
        grid_PV_EV_DR_nonV2G=table2array(grid_PV_EV_DR_nonV2G);

buy_price=[0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04];

            % grid
            val=bigdata_Houses.*buy_price(1,:);
            grid=sum(val,2);
            grid_max=max(grid);
            grid_min=min(grid);
            grid_mean=mean(grid);

            % grid+DR
            val2=bigdata_Houses_DR.*buy_price(1,:);
            grid_DR=sum(val2,2);
            grid_DR_max=max(grid_DR);
            grid_DR_min=min(grid_DR);
            grid_DR_mean=mean(grid_DR);

            % grid+EV+V2G
            grid_EV_V2G_max=max(grid_EV_V2G);
            grid_EV_V2G_min=min(grid_EV_V2G);
            grid_EV_V2G_mean=mean(grid_EV_V2G);

            % grid+EV+DR+V2G
            grid_EV_DR_V2G_max=max(grid_EV_DR_V2G);
            grid_EV_DR_V2G_min=min(grid_EV_DR_V2G);
            grid_EV_DR_V2G_mean=mean(grid_EV_DR_V2G);

            % grid+EV+nonV2G
            grid_EV_nonV2G=sum(grid_EV_nonV2G,2);
            grid_EV_nonV2G_max=max(grid_EV_nonV2G);
            grid_EV_nonV2G_min=min(grid_EV_nonV2G);
            grid_EV_nonV2G_mean=mean(grid_EV_nonV2G);

            % grid+EV+DR+nonV2G
            grid_EV_DR_nonV2G=sum(grid_EV_DR_nonV2G,2);
            grid_EV_DR_nonV2G_max=max(grid_EV_DR_nonV2G);
            grid_EV_DR_nonV2G_min=min(grid_EV_DR_nonV2G);
            grid_EV_DR_nonV2G_mean=mean(grid_EV_DR_nonV2G);

            % grid+PV
            grid_PV_max=max(grid_PV);
            grid_PV_min=min(grid_PV);
            grid_PV_mean=mean(grid_PV);

            % grid+PV+DR
            grid_PV_DR_max=max(grid_PV_DR);
            grid_PV_DR_min=min(grid_PV_DR);
            grid_PV_DR_mean=mean(grid_PV_DR);

            % grid+PV+ESS
            grid_PV_ESS_max=max(grid_PV_ESS);
            grid_PV_ESS_min=min(grid_PV_ESS);
            grid_PV_ESS_mean=mean(grid_PV_ESS);

            % grid+PV+ESS+DR
            grid_PV_ESS_DR_max=max(grid_PV_ESS_DR);
            grid_PV_ESS_DR_min=min(grid_PV_ESS_DR);
            grid_PV_ESS_DR_mean=mean(grid_PV_ESS_DR);

            % grid+PV+EV+nonV2G
            grid_PV_EV_nonV2G_max=max(grid_PV_EV_nonV2G);
            grid_PV_EV_nonV2G_min=min(grid_PV_EV_nonV2G);
            grid_PV_EV_nonV2G_mean=mean(grid_PV_EV_nonV2G);

            % grid+PV+EV+DR+nonV2G
            grid_PV_EV_DR_nonV2G_max=max(grid_PV_EV_DR_nonV2G);
            grid_PV_EV_DR_nonV2G_min=min(grid_PV_EV_DR_nonV2G);
            grid_PV_EV_DR_nonV2G_mean=mean(grid_PV_EV_DR_nonV2G);

           % grid+PV+EV+V2G
            grid_PV_EV_V2G_max=max(grid_PV_EV_V2G);
            grid_PV_EV_V2G_min=min(grid_PV_EV_V2G);
            grid_PV_EV_V2G_mean=mean(grid_PV_EV_V2G);

            % grid+PV+EV+DR+V2G
            grid_PV_EV_DR_V2G_max=max(grid_PV_EV_DR_V2G);
            grid_PV_EV_DR_V2G_min=min(grid_PV_EV_DR_V2G);
            grid_PV_EV_DR_V2G_mean=mean(grid_PV_EV_DR_V2G);

            
            
            
            
        % graph
        HoursofaDay=1:48;
        HoursofaDay=HoursofaDay';
        t = tiledlayout(3,3);
        % comparison grid vs grid+DR
        ax1 = nexttile;
        plot(ax1,HoursofaDay,All_Power_grid_DR_sum,':r',HoursofaDay,All_Power_grid_sum,'k','LineWidth',3)
        legend(ax1,'grid+DR','grid')

        ax2 = nexttile;
        plot(ax2,HoursofaDay,All_Power_grid_PV_sum,':r',HoursofaDay,All_Power_grid_sum,'k','LineWidth',3);
        legend(ax2,'grid+PV','grid')

        ax3 = nexttile;
        plot(ax3,HoursofaDay,All_Power_grid_PV_ESS_sum,':r',HoursofaDay,All_Power_grid_PV_sum,'k','LineWidth',3);
        legend(ax3,'grid+PV+ESS','grid+PV')
        
        ax4 = nexttile;
        plot(ax4,HoursofaDay,All_Power_grid_EV_DR_V2G_sum,':r',HoursofaDay,All_Power_grid_EV_V2G_sum,'k','LineWidth',3);
        legend(ax4,'grid+EV+DR&V2G','grid+EV&V2G')

        ax5 = nexttile;
        plot(ax5,HoursofaDay,All_Power_grid_sum,':r',HoursofaDay,All_Power_grid_EV_nonV2G_sum,'k','LineWidth',3);
        legend(ax5,'grid','grid+EV&nonV2G')
        

        ax6 = nexttile;
        plot(ax6,HoursofaDay,All_Power_grid_EV_DR_V2G_sum,':r',HoursofaDay,All_Power_grid_EV_DR_nonV2G_sum,'k','LineWidth',3);
        legend(ax6,'grid+EV+DR&V2G','grid+EV+DR&nonV2G')

        ax7 = nexttile;
        plot(ax7,HoursofaDay,V2G,':r',HoursofaDay,nonV2G,'k','LineWidth',3);
        legend(ax7,'only EV&V2G','only EV&nonV2G')
        
        ax8 = nexttile;
        plot(ax8,HoursofaDay,All_Power_grid_PV_EV_V2G_sum,':r',HoursofaDay,All_Power_grid_PV_EV_nonV2G_sum,'k','LineWidth',3);
        legend(ax8,'grid+PV+EV&V2G','grid+PV+EV&nonV2G')

          
        
        ax9 = nexttile;
        plot(ax9,HoursofaDay,All_Power_grid_PV_EV_DR_V2G_sum,':r',HoursofaDay,All_Power_grid_PV_EV_DR_nonV2G_sum,'k','LineWidth',3);
        legend(ax9,'grid+PV+EV+DR&V2G','grid+PV+EV+DR&nonV2G')

        linkaxes([ax1,ax2,ax3],'x');
        linkaxes([ax1,ax2,ax3],'y');
        linkaxes([ax4,ax5,ax6],'x');
        linkaxes([ax4,ax5,ax6],'y');
        linkaxes([ax7,ax8,ax9],'x');
        linkaxes([ax7,ax8,ax9],'y');
        t.Padding = 'none';
        t.TileSpacing = 'none';

        % Add shared title and axis labels
        title(t,'Power On Bus Bar')
        xlabel(t,'time(h)')
        ylabel(t,'Power(kW)')
        a=sum(All_Power_grid_PV_EV_V2G_sum)
        b=sum(All_Power_grid_PV_EV_nonV2G_sum)
% clear ax1 ax2 ax3 ax4 ax5 ax6 ax7 ax8 ax9
% % Move plots closer together
% xticklabels(ax1,{})
% t.TileSpacing = 'compact';
load chirp
sound(y,Fs)
toc
%% 
% if NumberofElectricVehicle==30
%     str='outputdenemesi30.xlsx';
% elseif NumberofElectricVehicle==40
%     str='outputdenemesi40.xlsx';
% elseif NumberofElectricVehicle==50
%     str='outputdenemesi50.xlsx';
% else
%     str='outputdenemesiFail.xlsx';
%     fprintf('yazdirma isleme yapilamiyor')
% end
%   
% str2='consumerpower.xlsx';
% a=zeros(1,48);
% %deneme
% if isempty(bigdata_Houses)
%     xlswrite(str2,a,'Houses','C2')
% else
%     xlswrite(str2,bigdata_Houses,'Houses','C2')
% end
% if isempty(bigdata_Uni)
%     xlswrite(str2,a,'Uni','C2')
% else
% xlswrite(str2,bigdata_Uni,'Uni','C2')
% end
% if isempty(bigdata_AVM)
%     xlswrite(str2,a,'AVM','C2')
% else
% xlswrite(str2,bigdata_AVM,'AVM','C2')
% end
% if isempty(bigdata_Hospital)
%     xlswrite(str2,a,'Hospital','C2')
% else
% xlswrite(str2,bigdata_Hospital,'Hospital','C2')
% end
% if isempty(bigdata_Social_Facilities)
%     xlswrite(str2,a,'Social_Facilities','C2')
% else
% xlswrite(str2,bigdata_Social_Facilities,'Social_Facilities','C2')
% end
% if isempty(bigdata_Organized_industry)
%     xlswrite(str2,a,'Organized_industry','C2')
% else
% xlswrite(str2,bigdata_Organized_industry,'Organized_industry','C2')
% end
% if isempty(bigdata_Industrial_Factory)
%     xlswrite(str2,a,'Industrial_Factory','C2')
% else
% xlswrite(str2,bigdata_Industrial_Factory,'Industrial_Factory','C2')
% % end
% 
% 
% %% excel overview
% xlswrite(str,excelSoc,'SOC','A2')
% xlswrite(str,excelSaat,'time','A2')
% xlswrite(str,TotalPoweronBus,'Power','A2')
% xlswrite(str,BatteryCapasity','BatteryCap','A2')
% xlswrite(str,FastCharging,'Fast Charging Stations','A3')
% xlswrite(str,excelPowerbyTime,'Final','H2')
% xlswrite(str,excelEnergyDemand,'Final','G2')

% Create object
% ExcelApp = actxserver('Excel.Application');
% Show window (optional)
% ExcelApp.Visible = 1;
% Open file located in the current folder.
% ExcelApp.Workbooks.Open(fullfile(pwd,str));
% ExcelApp.Workbooks.Open(fullfile(pwd,str2));
% ExcelApp.Run('ThisWorkBook.Macro1', SOC);

% Filename='C:\Users\ikoca\Desktop\Matlab Optimization\mainproject\consumerpower.xlsx';
% for SheetNum=1:10
%      [N, T, Raw]=xlsread(Filename, SheetNum);
%      [Raw{:, :}]=deal(NaN);
%      xlswrite(Filename, Raw, SheetNum);
% end


% if House==25
%     str='outputCOST-25.xlsx';
%     if NumberofElectricVehicle==House*0.2 && pv_penetration==0.5
%     xlswrite(str,deger,'EV-20-PV-50','A2')
%         elseif NumberofElectricVehicle==House*0.6 && pv_penetration==0.5
%             xlswrite(str,deger,'EV-20-PV-50','A2')
%                 elseif NumberofElectricVehicle==House*0.8 && pv_penetration==0.5
%                 xlswrite(str,deger,'EV-20-PV-50','A2')
%     end
% elseif NumberofElectricVehicle==100
%     str='outputCOST-100.xlsx';
% elseif NumberofElectricVehicle==500
%     str='outputCOST-500.xlsx';
% else
%     str='outputdenemesiFail.xlsx';
%     fprintf('yazdirma isleme yapilamiyor')
% end
% %% excel overview
% xlswrite(str,COST,'SOC','A2')
% xlswrite(str,excelSaat,'time','A2')
% xlswrite(str,TotalPoweronBus,'Power','A2')
