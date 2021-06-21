function [c, ceq] = sinirlar(t)

global NumberofElectricVehicle

    for a=1:NumberofElectricVehicle
    c =[t(4*a)-t(4*a-1),t(4*a-2)-t(4*a-3)];
    
    end
ceq = [];

end