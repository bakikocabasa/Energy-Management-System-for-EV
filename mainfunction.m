function obj=mainfunction(t)

global BatteryCapasity
global NumberofElectricVehicle

for x=1:NumberofElectricVehicle
   EV(x)=((t(4*x-3)-t(4*x-2))*BatteryCapasity(1,x)/100)/(((t(4*x-1)-t(4*x))/60));
if x>1
fark=abs(EV(x)-EV(x-1));
else
 fark=EV(x);
end
end

obj=-sum(EV);
    end

