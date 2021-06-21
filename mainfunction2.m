function obj=mainfunction2(t)
global BatteryCapasity
global NumberofElectricVehicle
HoursofaDay=1:72;
PowerbyTime(1,:)=HoursofaDay;
for x=1:NumberofElectricVehicle
EnergyDemand(1,x)=(t(4*x-3)-t(4*x-2))*BatteryCapasity(1,x)/100;
saatler(1,2*x-1)=t(4*x-1);
saatler(1,2*x)=t(4*x);
TotalMinutesbtwChargeandDisch(1,x)=abs(saatler(1,2*x-1)-saatler(1,2*x)/60);
dakika=mod(saatler,60)/100;
kusuratlitamkisim=saatler/60;
TamSaat=round(kusuratlitamkisim);
    DepartureTime(:,x)=TamSaat(:,2*x-1);
    ArrivalTime(:,x)=TamSaat(:,2*x);  
        for z=(ArrivalTime(1,x)+1):(DepartureTime(1,x)+1)
            PowerbyTime(x+1,z)=EnergyDemand(1,x)/(TotalMinutesbtwChargeandDisch(1,x)/60);
        end
end
for t=1:72
    TotalPoweronBus(1,t)=sum(PowerbyTime(1:NumberofElectricVehicle,t));
end
for t=2:72
x=abs(TotalPoweronBus(1,t)-TotalPoweronBus(1,t-1));
end
obj=sum(x);