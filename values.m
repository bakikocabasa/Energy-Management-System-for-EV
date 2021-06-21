function [SOC_by_time,TamSaat,TotalPoweronBus,HoursofaDay,excelSoc,excelSaat,excelPowerbyTime,excelPowerbyTime2,excelEnergyDemand]=values(NumberofElectricVehicle,orneklem,BatteryCapasity,scores)
for par=1:NumberofElectricVehicle
SOC(1,2*par-1)=orneklem(1,(4*par-3)); 
SOC(1,2*par)=orneklem(1,(4*par-2));  
saatler(1,2*par-1)=orneklem(1,(4*par-1));
saatler(1,2*par)=orneklem(1,(4*par));
excelSoc(par,1)=SOC(1,2*par-1);%desired
excelSoc(par,2)=SOC(1,2*par);  %initial
EnergyDemand(1,par)=(SOC(1,2*par-1)-SOC(1,2*par))*BatteryCapasity(1,par)/100;
TotalMinutesbtwChargeandDisch(1,par)=abs(saatler(1,2*par-1)-saatler(1,2*par));
end
SOC=SOC';


%saatler
dakika=mod(saatler,60)/100;
kusuratlitamkisim=saatler/60;
TamSaat=round(kusuratlitamkisim);
% for a=1:NumberofElectricVehicle*2
%     if TamSaat(1,a)>=24
%         TamSaat(1,a)=TamSaat(1,a)-24;
%     end
% end

for aa=1:NumberofElectricVehicle
    DepartureTime(:,aa)=TamSaat(:,2*aa-1);
    ArrivalTime(:,aa)=TamSaat(:,2*aa);
    Toplam(1,aa)=TamSaat(1,2*aa-1)-TamSaat(1,2*aa);
end
global HoursofaDay   
saat=TamSaat+dakika;
PowerbyTime=zeros(NumberofElectricVehicle,72);
HoursofaDay=1:72;
PowerbyTime(1,:)=HoursofaDay;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for p=1:NumberofElectricVehicle
excelSaat(p,1)=saat(1,2*p-1); 
excelSaat(p,2)=saat(1,2*p);
if (ArrivalTime(1,p)>DepartureTime(1,p))
        for x=(ArrivalTime(1,p)+1):72
            PowerbyTime(p+1,x)=EnergyDemand(1,p)/(TotalMinutesbtwChargeandDisch(1,p)/60);
        end
        for y=1:(DepartureTime(1,p)+1)
            PowerbyTime(p+1,y)=EnergyDemand(1,p)/(TotalMinutesbtwChargeandDisch(1,p)/60);
        end
    elseif (ArrivalTime(1,p)<=DepartureTime(1,p))
%         elseif ((ArrivalTime(1,p)+1)<15) & ((ArrivalTime(1,p)+1)>=0)

        for z=(ArrivalTime(1,p)+1):(DepartureTime(1,p)+1)
            PowerbyTime(p+1,z)=EnergyDemand(1,p)/(TotalMinutesbtwChargeandDisch(1,p)/60);
        end
        
    end
end

TotalPoweronBus=zeros(1,72);

SOC_by_time=zeros(NumberofElectricVehicle,72);


for t=1:72
    TotalPoweronBus(1,t)=sum(PowerbyTime(2:NumberofElectricVehicle+1,t));
  
end
excelPowerbyTime=PowerbyTime(2:NumberofElectricVehicle+1,1:72);
excelPowerbyTime2=zeros(NumberofElectricVehicle,72);


% excelPowerbyTime(:,49:72)=excelPowerbyTime(:,1:24);
% excelPowerbyTime(:,25:48)=excelPowerbyTime(:,1:24);

excelEnergyDemand=EnergyDemand';
% TotalPoweronBus=TotalPoweronBus+FastChargingTotal;


for i=1:NumberofElectricVehicle
    [~,c]=find(excelPowerbyTime(i,:));
    excelPowerbyTime(i,(min(c)+24):(max(c)+24))=excelPowerbyTime(i,min(c):max(c));
    excelPowerbyTime(i,(min(c)+48):72)=excelPowerbyTime(i,min(c):(min(c)+72-(min(c)+48)));
    SOC_by_time(i,1)=excelSoc(i,2);
%     SOC_by_time(i,DepartureTime(1,i))=SOC(1,2*i-1);

    
    for t=2:72
SOC_by_time(i,t)=SOC_by_time(i,t-1)+excelPowerbyTime(i,t).*100/BatteryCapasity(1,i);
    SOC_by_time(i,(min(c)+24):(max(c)+24))=SOC_by_time(i,min(c):max(c));
    SOC_by_time(i,(min(c)+48):72)=SOC_by_time(i,min(c):(min(c)+72-(min(c)+48)));
        if SOC_by_time(i,t)>excelSoc(i,1)
           SOC_by_time(i,t)= excelSoc(i,1);
        end  
    end
    SOC_by_time(i,TamSaat(1,2*i-1))=excelSoc(i,1);
    SOC_by_time(i,TamSaat(1,2*i-1)+24)=excelSoc(i,1);
    SOC_by_time(i,TamSaat(1,2*i))=excelSoc(i,2);
    SOC_by_time(i,TamSaat(1,2*i)+24)=excelSoc(i,2);
    

%     for a=DepartureTime(1,i):72
% SOC_by_time(i,a)=SOC(2*i-1,1);
%     end
end



end