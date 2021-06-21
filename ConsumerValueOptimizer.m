function [grid_PV_ESS,grid_PV_ESS_DR,All_Power_grid_PV_ESS_DR,All_Power_grid_PV_ESS,All_Power_grid_EV_DR_nonV2G,All_Power_grid_EV_nonV2G,grid_EV_nonV2G,grid_EV_DR_nonV2G,grid_PV_EV_DR_nonV2G,All_Power_grid_PV_EV_DR_nonV2G,grid_PV_EV_DR_V2G,All_Power_grid_PV_EV_DR_V2G,grid_PV_EV_V2G,All_Power_grid_PV_EV_V2G,grid_PV_EV_nonV2G,All_Power_grid_PV_EV_nonV2G,grid_PV_DR,All_Power_grid_PV_DR,All_Power_grid_EV_DR_V2G,grid_EV_DR_V2G,All_Power_grid_EV_V2G,grid_EV_V2G,All_Power_grid_PV,grid_PV,Optimized_House_grid_PV_EV_V2G,Optimized_House_grid_PV_EV_nonV2G,Optimized_House_grid_PV,Optimized_House_grid_EV_V2G,Optimized_House_grid_EV_DR_V2G,Optimized_House_grid_PV_DR,Optimized_House_grid_PV_EV_DR_V2G,Optimized_House_grid_PV_EV_DR_nonV2G,Optimized_House_grid_PV_ESS_DR,Optimized_House_grid_PV_ESS,Optimized_Uni,Optimized_AVM,Optimized_Hospital,Optimized_Social_Facilities,Optimized_Organized_industry,Optimized_Industrial_Factory]=ConsumerValueOptimizer(SOC_by_time,TamSaat,BatteryCapasity,excelSoc,bigdata_Houses,bigdata_Uni,bigdata_AVM,bigdata_Hospital,bigdata_Social_Facilities,bigdata_Organized_industry,bigdata_Industrial_Factory,bigdata_Houses_pv,bigdata_Uni_pv,bigdata_AVM_pv,bigdata_Hospital_pv,bigdata_Social_Facilities_pv,bigdata_Organized_industry_pv,bigdata_Industrial_Factory_pv,excelPowerbyTime,excelPowerbyTime2,NumberofElectricVehicle,bigdata_Houses_DR,charge_power)
tic
[House,~]=size(bigdata_Houses);
[Uni,~]=size(bigdata_Uni);
[AVM,~]=size(bigdata_AVM);
[Hospital,~]=size(bigdata_Hospital);
[Social_Facilities,~]=size(bigdata_Social_Facilities);
[Organized_industry,~]=size(bigdata_Organized_industry);
[Industrial_Factory,~]=size(bigdata_Industrial_Factory);   
[~,rest_of_houses]=size(NumberofElectricVehicle+1:House);

if bigdata_AVM==0
    bigdata_AVM=[];
    AVM=0;
end
if bigdata_Houses==0
    bigdata_Houses=[];
    House=0;
end
if bigdata_Uni==0
    bigdata_Uni=[];
    Uni=0;
end
if bigdata_Hospital==0
    bigdata_Hospital=[];
    Hospital=0;
end
if bigdata_Social_Facilities==0
    bigdata_Social_Facilities=[];
    Social_Facilities=0;
end
if bigdata_Organized_industry==0
    bigdata_Organized_industry=[];
    Organized_industry=0;
end
if bigdata_Industrial_Factory==0
    bigdata_Industrial_Factory=[];
    Industrial_Factory=0;
end

Optimized_House_grid_PV_EV_V2G=cell(NumberofElectricVehicle,1);
Optimized_House_grid_PV_EV_nonV2G=cell(NumberofElectricVehicle,1);
Optimized_House_grid_PV=cell(House,1);
Optimized_House_grid_PV_ESS=cell(House,1);
Optimized_House_grid_PV_ESS_DR=cell(House,1);
Optimized_House_grid_EV_V2G=cell(NumberofElectricVehicle,1);
Optimized_House_grid_EV_DR_V2G=cell(NumberofElectricVehicle,1);
Optimized_House_grid_PV_DR=cell(House,1);
Optimized_House_grid_PV_EV_DR_V2G=cell(NumberofElectricVehicle,1);
Optimized_House_grid_PV_EV_DR_nonV2G=cell(NumberofElectricVehicle,1);

% All_Power_grid_EV_nonV2G
% All_Power_grid_EV_DR_nonV2G
    if NumberofElectricVehicle>0
sell_price=[0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.15,0.15,0.15,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.15,0.15,0.15,0.15,0.15,0.15,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.13,0.15,0.15,0.15,0.15,0.15,0.15,0.13,0.13];
% sell_price=ones(1,72)*0.65;
a=ones(1,8);
a=diag(a);
buy_price=[0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.04,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.09,0.09,0.09,0.09,0.09,0.04,0.04,0.04];

for k=1:House
    pv_pro_PV(k,:)=bigdata_Houses_pv(k,1:72);
    p_other_PV(k,:)=bigdata_Houses(k,1:72);
    p_other_DR_PV(k,:)=bigdata_Houses_DR(k,1:72);
end
for i=1:NumberofElectricVehicle
  
    p_other(i,:)=bigdata_Houses(i,1:72);
    p_other_DR(i,:)=bigdata_Houses_DR(i,1:72);
    pv_pro(i,:)=bigdata_Houses_pv(i,1:72);
    initial_SOC(1,i)=excelSoc(i,2);
    desired_SOC(1,i)=excelSoc(i,1);
    ev_capacity(1,i)=BatteryCapasity(1,i);
    desired_time(1,i)=TamSaat(1,2*i-1);
    initial_time(1,i)=TamSaat(1,2*i);
    ev_demand(i,:)=excelPowerbyTime(i,:);
    ev_bat_ch_grid2(i,:)=max(excelPowerbyTime(i,:));
    SOC_nonV2G(i,:)=SOC_by_time(i,:);
    ChargePower(1,i)=charge_power(1,i);

    %% grid_EV_nonV2G
    
    All_Power_grid_EV_nonV2G(i,:)=(ev_demand(i,:)+p_other(i,:));
    grid_EV_nonV2G(i,:)=All_Power_grid_EV_nonV2G(i,:).*buy_price(:,1)';
%     All_Power_grid_EV_nonV2G=All_Power_grid_EV_nonV2G';
    
    %% grid_EV_DR_nonV2G
    All_Power_grid_EV_DR_nonV2G(i,:)=(ev_demand(i,:)+p_other_DR(i,:));
    grid_EV_DR_nonV2G(i,:)=All_Power_grid_EV_nonV2G(i,:).*buy_price(:,1)';
%     All_Power_grid_EV_DR_nonV2G=All_Power_grid_EV_DR_nonV2G';
end

    %% grid_EV_V2G
    [Optimized_House_grid_EV_V2G,grid_EV_V2G,All_Power_grid_EV_V2G]=grid_EV_V2G_opt(All_Power_grid_EV_nonV2G,bigdata_Houses,excelPowerbyTime,initial_time,desired_time,p_other,ev_capacity,initial_SOC,desired_SOC,buy_price,sell_price,NumberofElectricVehicle);   
    %% grid_EV_DR_V2G
    [Optimized_House_grid_EV_DR_V2G,grid_EV_DR_V2G,All_Power_grid_EV_DR_V2G]=grid_EV_V2G_opt(All_Power_grid_EV_nonV2G,bigdata_Houses,excelPowerbyTime,initial_time,desired_time,p_other_DR,ev_capacity,initial_SOC,desired_SOC,buy_price,sell_price,NumberofElectricVehicle);
    
    %% grid_PV_EV_nonV2G
    [Optimized_House_grid_PV_EV_nonV2G,grid_PV_EV_nonV2G,All_Power_grid_PV_EV_nonV2G]=grid_PV_EV_nonV2G_opt(p_other,pv_pro,ev_demand,SOC_nonV2G,buy_price,sell_price,NumberofElectricVehicle);
    
   
    %% grid_PV_EV_DR_nonV2G
    [Optimized_House_grid_PV_EV_DR_nonV2G,grid_PV_EV_DR_nonV2G,All_Power_grid_PV_EV_DR_nonV2G]=grid_PV_EV_nonV2G_opt(p_other_DR,pv_pro,ev_demand,SOC_nonV2G,buy_price,sell_price,NumberofElectricVehicle);  

    %% grid_PV_EV_V2G

    [Optimized_House_grid_PV_EV_V2G,grid_PV_EV_V2G,All_Power_grid_PV_EV_V2G]=grid_PV_EV_V2G_opt(All_Power_grid_PV_EV_nonV2G,bigdata_Houses,excelPowerbyTime,initial_time,desired_time,p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC,buy_price,sell_price,NumberofElectricVehicle);
    
    %% grid_PV_EV_DR_V2G
    [Optimized_House_grid_PV_EV_DR_V2G,grid_PV_EV_DR_V2G,All_Power_grid_PV_EV_DR_V2G]=grid_PV_EV_V2G_opt(All_Power_grid_PV_EV_nonV2G,bigdata_Houses,excelPowerbyTime,initial_time,desired_time,p_other_DR,pv_pro,ev_capacity,initial_SOC,desired_SOC,buy_price,sell_price,NumberofElectricVehicle);
         

%% grid+PV

    [Optimized_House_grid_PV,grid_PV,All_Power_grid_PV]=grid_PV_opt(p_other_PV,pv_pro_PV,buy_price,sell_price,House);
    %% grid+PV+DR
    [Optimized_House_grid_PV_DR,grid_PV_DR,All_Power_grid_PV_DR]=grid_PV_opt(p_other_DR_PV,pv_pro_PV,buy_price,sell_price,House);
    %% grid+PV+ESS
    [Optimized_House_grid_PV_ESS,grid_PV_ESS,All_Power_grid_PV_ESS]=grid_PV_ESS_opt(p_other_PV,pv_pro_PV,buy_price,sell_price,House);
      %% grid+PV+ESS+DR
    [Optimized_House_grid_PV_ESS_DR,grid_PV_ESS_DR,All_Power_grid_PV_ESS_DR]=grid_PV_ESS_opt(p_other_DR_PV,pv_pro_PV,buy_price,sell_price,House);
   
    end

   Optimized_Uni   = cell(Uni,1);
        if Uni>0
for i=1:Uni
    p_other=bigdata_Uni(i,1:72);
    pv_pro=bigdata_Uni_pv(i,1:72);
    [A]=mosek(p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC);
    a0 = A;
    Optimized_Uni{i} = a0;
end
        end
 Optimized_AVM   = cell(AVM,1);
            if AVM>0
for i=1:AVM
    p_other=bigdata_AVM(i,1:72);
    pv_pro=bigdata_AVM_pv(i,1:72);
    [A]=mosek(p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC);
    a0 = A;
    Optimized_AVM{i} = a0;
end
            end
    Optimized_Hospital   = cell(Hospital,1);
                if Hospital>0
for i=1:Hospital
    p_other=bigdata_Hospital(i,1:72);
    pv_pro=bigdata_Hospital_pv(i,1:72);
    [A]=mosek(p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC);
    a0 = A;
    Optimized_Hospital{i} = a0;
end
                end
    Optimized_Social_Facilities   = cell(Social_Facilities,1);
                    if Social_Facilities>0
for i=1:Social_Facilities
    p_other=bigdata_Social_Facilities(i,1:72);
    pv_pro=bigdata_Social_Facilities_pv(i,1:72);
    [A]=mosek(p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC);
    a0 = A;
    Optimized_Social_Facilities{i} = a0;
end
                    end
    Optimized_Organized_industry   = cell(Organized_industry,1);
                        if Organized_industry>0
for i=1:Organized_industry
    p_other=bigdata_Organized_industry(i,1:72);
    pv_pro=bigdata_Organized_industry_pv(i,1:72);
    [A]=mosek(p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC);
    a0 = A;
    Optimized_Organized_industry{i} = a0;
end
                        end
   Optimized_Industrial_Factory   = cell(Industrial_Factory,1); 
                            if Industrial_Factory>0
for i=1:Industrial_Factory
    p_other=bigdata_Industrial_Factory(i,1:72);
    pv_pro=bigdata_Industrial_Factory_pv(i,1:72);
    [A]=mosek(p_other,pv_pro,ev_capacity,initial_SOC,desired_SOC);
    a0 = A;
    Optimized_Industrial_Factory{i} = a0;
end
                            end
toc
end