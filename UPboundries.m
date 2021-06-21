function UB=UPboundries(LB,NumberofElectricVehicle)
for b=1:NumberofElectricVehicle

UB(1,(4*b-3):(4*b-2))=LB(1,(4*b-3):(4*b-2))+5;
UB(1,(4*b-1):(4*b))=LB(1,(4*b-1):(4*b))+5;

end

end