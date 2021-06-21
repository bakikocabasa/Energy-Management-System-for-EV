function LB=LOWboundriesEnd(q,NumberofElectricVehicle)   

            disp('calisan personel saat 08.00 ile 20.00 arasinda aracini sarj etmektedir')
            disp('calisan personel saat 20.00 ile 08.00 arasinda aracini sarj etmektedir')
            disp('gelen musteriler saat 09.00 ile 17.00 arasinda sarjdan faydalanmaktadir')
            disp('gece sarj olan sirket araclari saat 18.00 ile 08.00 arasinda sarjdan faydalanmaktadir')
            disp('ticari,binek ve endustriyel araclar hizli sarjdan tum gun faydalanabilmektedir')

            if q==1
                disp('%20-20-20-20-20')
            percentage=[0.2 0.2 0.2 0.2 0.2];

            elseif q==2
                disp('%40-20-20-20-0')
            percentage=[0.4 0.2 0.2 0.2 0];

            elseif q==3
                disp('%40-0-20-20-20')
            percentage=[0.4 0 0.2 0.2 0.2];

            elseif q==4
                disp('%20-20-20-40-0')
            percentage=[0.2 0.2 0.2 0.4 0];
            
            elseif q==5
                disp('%60-0-20-20-0')
            percentage=[0.6 0 0.2 0.2 0];

            else
                while q==0
                    disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
                     q=menu('Endustriel bolgedeki elektrikli arac kullanan tuketicilerin dagilim yuzdesini giriniz(calisan personel(08.00-20.00)-calisan personel(20.00-08.00)-gelen musteriler(09.00-17.00)-gece sarj olan sirket araclari(18.00-08.00))-h?zl? ?arj: ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%20-20-20-40-0','%60-0-20-20-0');
                end

            end
   
    x=NumberofElectricVehicle*(1-percentage(1,5))+1;
    y=NumberofElectricVehicle;
    t=NumberofElectricVehicle*sum(percentage(1,1:2))+1;
    q=t+NumberofElectricVehicle*percentage(1,3)-1;

        %% desired
        desired=[randi([75,85],1,NumberofElectricVehicle*percentage(1,1))  randi([75,95],1,NumberofElectricVehicle*percentage(1,2)) randi([50,55],1,NumberofElectricVehicle*percentage(1,3)) randi([90,95],1,NumberofElectricVehicle*percentage(1,4)) randi([85,90],1,NumberofElectricVehicle*percentage(1,5))]; 
        %% initial
        initial=[randi([55,67],1,NumberofElectricVehicle*percentage(1,1)) randi([50,60],1,NumberofElectricVehicle*percentage(1,2)) randi([15,25],1,NumberofElectricVehicle*percentage(1,3)) randi([15,25],1,NumberofElectricVehicle*percentage(1,4)) randi([50,70],1,NumberofElectricVehicle*percentage(1,5)) ];
        %% departure
        departure=[randi([1070,1090],1,NumberofElectricVehicle*percentage(1,1)) randi([1190,1250],1,NumberofElectricVehicle*percentage(1,2)) randi([720,1030],1,NumberofElectricVehicle*percentage(1,3)) randi([1900,1920],1,NumberofElectricVehicle*percentage(1,4)) randi([80,1920],1,NumberofElectricVehicle*percentage(1,5)) ];
        %% arrival
        arrival=[randi([430,480],1,NumberofElectricVehicle*percentage(1,1)) randi([460,500],1,NumberofElectricVehicle*percentage(1,2)) departure(1,t:q)-randi([20,60],1,NumberofElectricVehicle*percentage(1,3)) randi([1080,1100],1,NumberofElectricVehicle*percentage(1,4))  departure(1,x:y)-randi([20,60],1,NumberofElectricVehicle*percentage(1,5))];
        %% LB
        for b=1:NumberofElectricVehicle
        LB(:,4*b-3)=[desired(:,b)];
        LB(:,4*b-2)=[initial(:,b)];
        LB(:,4*b-1)=[departure(:,b)];
        LB(:,4*b)=[arrival(:,b)];
        
end
        
end
   

