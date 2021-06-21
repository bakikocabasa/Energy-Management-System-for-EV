function LB=LOWboundriesRes(q,NumberofElectricVehicle)
   
if q==1
        disp('%0-100')
        percentage=[0 1];
    elseif q==2
        disp('%20-80')
        percentage=[0.2 0.8]; 
    elseif q==3
        disp('%40-60')
        percentage=[0.4 0.6];
    elseif q==4
        disp('%60-40')
        percentage=[0.6 0.4];   
    elseif q==5
        disp('%80-20')
        percentage=[0.8 0.2];   
    elseif q==6
        disp('%100-0')
       percentage=[1 0];   
    else
        while q==0
            disp('No selection is chosen,please select one of the options')
            q=menu('Please select the percentage of consumer distribution','%0-100','%20-80','%40-60','%60-40','%80-20','%100-0');
        end
end       
    x=NumberofElectricVehicle*(1-percentage(1,2))+1;
    y=NumberofElectricVehicle;
        %% desired
        desired=[randi([70,90],1,NumberofElectricVehicle*percentage(1,1)) randi([80,90],1,NumberofElectricVehicle*percentage(1,2))];
        %% initial
        initial=[randi([10,30],1,NumberofElectricVehicle*percentage(1,1)) randi([10,30],1,NumberofElectricVehicle*percentage(1,2))];
        %% departure
        departure=[randi([1700,2040],1,NumberofElectricVehicle*percentage(1,1)) randi([1000,1320],1,NumberofElectricVehicle*percentage(1,2))];
        %% arrival
        arrival=[randi([960,1200],1,NumberofElectricVehicle*percentage(1,1)) randi([400,700],1,NumberofElectricVehicle*percentage(1,2))];

        for a=1:NumberofElectricVehicle
        LB(:,4*a-3)=[desired(:,a)];
        LB(:,4*a-2)=[initial(:,a)];
        LB(:,4*a-1)=[departure(:,a)];
        LB(:,4*a)=[arrival(:,a)];
        

        
        end
        
end
   

