    function LB=LOWboundriesCom(distribution,q,NumberofElectricVehicle)

            disp('calisan personel sabah 07.00 ile 18.00 arasinda aracini sarj etmektedir')
            disp('gelen musteriler sabah 09.00 ile 17.00 arasinda sarjdan faydalanmaktadir')
            disp('gece sarj olan sirket araclari aksam 18.00 ile sabah 08.00 arasinda sarjdan faydalanmaktadir')
            disp('hastane ve otellerdeki hastalar/musteriler tum gun sarjdan faydalanmaktadir')
            disp('ticari ve binek araclar hizli sarjdan tum gun faydalanabilmektedir')    

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
        disp('%60-0-20-20-0')
        percentage=[0.6 0 0.2 0.2 0];
        while q==0
                    disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
                    q=menu('Ticari bolgedeki elektrikli arac kullanan tuketicilerin dagilim yuzdesini giriniz(calisanlar-kahvaltiya gelen musteriler-ogle yemegine gelen musteriler-aksam yemegine gelen musteriler-rastgele gelen musteri): ','%50-20-20-5-5','%50-10-10-20-10','%50-10-10-10-20');
        end
end
    x=NumberofElectricVehicle*(1-percentage(1,5))+1; 
    t=NumberofElectricVehicle*(1-percentage(1,4))+1;
    z=NumberofElectricVehicle*(1-percentage(1,3))+1;
    y=NumberofElectricVehicle;
    
            if distribution==1 %% only university 5- numaral? e?itim kurumlar? ticari ofislerde benzer bir yük profiligöstermekte olup ?arj talep süreleri uzun ,?arj talep enerjileri dü?üktür
        %% gelen ogrenciler, ogretim gorevlileri ve personeller, ziyaretciler, kampus ici ulasim araclari, hizli sarj
        %% desired
        desired=[randi([80,85],1,NumberofElectricVehicle*percentage(1,1)) randi([75,90],1,NumberofElectricVehicle*percentage(1,2)) randi([80,90],1,NumberofElectricVehicle*percentage(1,3)) randi([75,89],1,NumberofElectricVehicle*percentage(1,4)) randi([70,85],1,NumberofElectricVehicle*percentage(1,5))]; 
        %% initial
        initial=[randi([55,65],1,NumberofElectricVehicle*percentage(1,1)) randi([55,65],1,NumberofElectricVehicle*percentage(1,2)) randi([60,70],1,NumberofElectricVehicle*percentage(1,3)) randi([25,35],1,NumberofElectricVehicle*percentage(1,4)) randi([40,55],1,NumberofElectricVehicle*percentage(1,5))];
        %% departure
        departure=[randi([700,1000],1,NumberofElectricVehicle*percentage(1,1)) randi([960,1020],1,NumberofElectricVehicle*percentage(1,2)) randi([460,1030],1,NumberofElectricVehicle*percentage(1,3)) randi([1800,1900],1,NumberofElectricVehicle*percentage(1,4)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,5))];
        %% arrival
        arrival=[randi([500,590],1,NumberofElectricVehicle*percentage(1,1)) randi([480,540],1,NumberofElectricVehicle*percentage(1,2)) departure(1,z:t)-randi([60,240],1,NumberofElectricVehicle*percentage(1,3)) randi([1020,1320],1,NumberofElectricVehicle*percentage(1,4)) departure(1,x:y)-randi([40,65],1,NumberofElectricVehicle*percentage(1,5))];
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% calisanlar, ziyaretciler, gece sarj olan sirket araclari, ------cinemalar------, hizli sarj vardiyali calisanlar eklenebilir
            elseif distribution==2 %%only AVM 1- numaral?  kullan?c? tipleri genellikle çal??ma saatleri içerisinde EV'lerinin ?arj talebini kar??larlar.?arj süreleri uzun olup ?arj enerji talepleri nispeten küçüktür.
        %% desired
        desired=[randi([80,85],1,NumberofElectricVehicle*percentage(1,1)) randi([65,80],1,NumberofElectricVehicle*percentage(1,2)) randi([90,95],1,NumberofElectricVehicle*percentage(1,3)) randi([65,75],1,NumberofElectricVehicle*percentage(1,4)) randi([80,85],1,NumberofElectricVehicle*percentage(1,5))]; 
        %% initial
        initial=[randi([25,35],1,NumberofElectricVehicle*percentage(1,1)) randi([35,45],1,NumberofElectricVehicle*percentage(1,2)) randi([10,20],1,NumberofElectricVehicle*percentage(1,3)) randi([35,45],1,NumberofElectricVehicle*percentage(1,4)) randi([5,15],1,NumberofElectricVehicle*percentage(1,5))];
        %% departure
        departure=[randi([970,1030],1,NumberofElectricVehicle*percentage(1,1)) randi([850,950],1,NumberofElectricVehicle*percentage(1,2)) randi([1070,1090],1,NumberofElectricVehicle*percentage(1,3)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,4)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,5))];
        %% arrival
        arrival=[randi([430,480],1,NumberofElectricVehicle*percentage(1,1)) randi([770,800],1,NumberofElectricVehicle*percentage(1,2)) randi([970,1030],1,NumberofElectricVehicle*percentage(1,3)) departure(1,t:y)-randi([40,60],1,NumberofElectricVehicle*percentage(1,4)) departure(1,x:y)-randi([40,65],1,NumberofElectricVehicle*percentage(1,5))];
        
        %% calisanlar, ziyaretciler, gece sarj olan hastane araclari, urun teslimat eden sirket araclari, hizli sarj
            elseif distribution==3 %%only Hostpital  6-numaral? kullan?c? profilindeki  hastahaneler çal??an personel EV talep profili aç?s?ndan ?arj talep süresi uzun olmakla birlikte ?arj talep enerjileri dü?üktür.Bununla birlikte hasta EV ?arj talep profili aç?s?ndan k?sa süreli ?arj talebi ve bununla ters orant?l? bir enerji talep büyüklü?ü görülmektedir. 
        %% desired
        desired=[randi([80,85],1,NumberofElectricVehicle*percentage(1,1)) randi([65,80],1,NumberofElectricVehicle*percentage(1,2)) randi([90,95],1,NumberofElectricVehicle*percentage(1,3)) randi([65,75],1,NumberofElectricVehicle*percentage(1,4)) randi([80,85],1,NumberofElectricVehicle*percentage(1,5))]; 
        %% initial
        initial=[randi([25,35],1,NumberofElectricVehicle*percentage(1,1)) randi([35,45],1,NumberofElectricVehicle*percentage(1,2)) randi([10,20],1,NumberofElectricVehicle*percentage(1,3)) randi([35,45],1,NumberofElectricVehicle*percentage(1,4)) randi([5,15],1,NumberofElectricVehicle*percentage(1,5))];
        %% departure
        departure=[randi([970,1030],1,NumberofElectricVehicle*percentage(1,1)) randi([850,950],1,NumberofElectricVehicle*percentage(1,2)) randi([1070,1090],1,NumberofElectricVehicle*percentage(1,3)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,4)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,5))];
        %% arrival
        arrival=[randi([430,480],1,NumberofElectricVehicle*percentage(1,1)) randi([770,800],1,NumberofElectricVehicle*percentage(1,2)) randi([970,1030],1,NumberofElectricVehicle*percentage(1,3)) departure(1,t:y)-randi([40,60],1,NumberofElectricVehicle*percentage(1,4)) departure(1,x:y)-randi([40,65],1,NumberofElectricVehicle*percentage(1,5))];
        
        %% calisanlar, Mü?teriler, gece sarj olan sirket araclari, urun teslimat eden sirket araclari, hizli sarj 
            elseif distribution==4 %%only Social Facilities  1- numaral?  kullan?c? tipleri genellikle çal??ma saatleri içerisinde EV'lerinin ?arj talebini kar??larlar.?arj süreleri uzun olup ?arj enerji talepleri nispeten küçüktür.  2- numaral? mü?teri profili EV ?arj talebi genelde 09:00-17:00 saatleri aras?nda, ?arj talep zamanlar? belirsiz ve k?sad?r.Ancak ?arj talep enerjileri nispeten büyüktür.
        %% desired
        desired=[randi([80,85],1,NumberofElectricVehicle*percentage(1,1)) randi([65,80],1,NumberofElectricVehicle*percentage(1,2)) randi([90,95],1,NumberofElectricVehicle*percentage(1,3)) randi([65,75],1,NumberofElectricVehicle*percentage(1,4)) randi([80,85],1,NumberofElectricVehicle*percentage(1,5))]; 
        %% initial
        initial=[randi([25,35],1,NumberofElectricVehicle*percentage(1,1)) randi([35,45],1,NumberofElectricVehicle*percentage(1,2)) randi([10,20],1,NumberofElectricVehicle*percentage(1,3)) randi([35,45],1,NumberofElectricVehicle*percentage(1,4)) randi([5,15],1,NumberofElectricVehicle*percentage(1,5))];
        %% departure
        departure=[randi([970,1030],1,NumberofElectricVehicle*percentage(1,1)) randi([850,950],1,NumberofElectricVehicle*percentage(1,2)) randi([1070,1090],1,NumberofElectricVehicle*percentage(1,3)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,4)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,5))];
        %% arrival
        arrival=[randi([430,480],1,NumberofElectricVehicle*percentage(1,1)) randi([770,800],1,NumberofElectricVehicle*percentage(1,2)) randi([970,1030],1,NumberofElectricVehicle*percentage(1,3)) departure(1,t:y)-randi([40,60],1,NumberofElectricVehicle*percentage(1,4)) departure(1,x:y)-randi([40,65],1,NumberofElectricVehicle*percentage(1,5))];
        
        %% calisanlar, ziyaretciler, gece sarj olan sirket araclari, urun teslimat eden sirket calisanlari, hizli sarj 
            elseif distribution==5 %%only Organized Industry  1 numaral?  kullan?c? tipleri genellikle çal??ma saatleri içerisinde EV'lerinin ?arj talebini kar??larlar.?arj süreleri uzun olup ?arj enerji talepleri nispeten küçüktür.  2- numaral? mü?teri profili EV ?arj talebi genelde 09:00-17:00 saatleri aras?nda, ?arj talep zamanlar? belirsiz ve k?sad?r.Ancak ?arj talep enerjileri nispeten büyüktür.
        %% desired
        desired=[randi([80,85],1,NumberofElectricVehicle*percentage(1,1)) randi([65,80],1,NumberofElectricVehicle*percentage(1,2)) randi([90,95],1,NumberofElectricVehicle*percentage(1,3)) randi([65,75],1,NumberofElectricVehicle*percentage(1,4)) randi([80,85],1,NumberofElectricVehicle*percentage(1,5))]; 
        %% initial
        initial=[randi([25,35],1,NumberofElectricVehicle*percentage(1,1)) randi([35,45],1,NumberofElectricVehicle*percentage(1,2)) randi([10,20],1,NumberofElectricVehicle*percentage(1,3)) randi([35,45],1,NumberofElectricVehicle*percentage(1,4)) randi([5,15],1,NumberofElectricVehicle*percentage(1,5))];
        %% departure
        departure=[randi([970,1030],1,NumberofElectricVehicle*percentage(1,1)) randi([850,950],1,NumberofElectricVehicle*percentage(1,2)) randi([1070,1090],1,NumberofElectricVehicle*percentage(1,3)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,4)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,5))];
        %% arrival
        arrival=[randi([430,480],1,NumberofElectricVehicle*percentage(1,1)) randi([770,800],1,NumberofElectricVehicle*percentage(1,2)) randi([970,1030],1,NumberofElectricVehicle*percentage(1,3)) departure(1,t:y)-randi([40,60],1,NumberofElectricVehicle*percentage(1,4)) departure(1,x:y)-randi([40,65],1,NumberofElectricVehicle*percentage(1,5))];
        
        if x>0
                    disp('x isletmeleri y adet')
        end
            else %%
                
            end
            
%         %% desired
%         desired=[randi([80,85],1,NumberofElectricVehicle*percentage(1,1)) randi([65,80],1,NumberofElectricVehicle*percentage(1,2)) randi([90,95],1,NumberofElectricVehicle*percentage(1,3)) randi([65,75],1,NumberofElectricVehicle*percentage(1,4)) randi([80,85],1,NumberofElectricVehicle*percentage(1,5))]; 
%         %% initial
%         initial=[randi([25,35],1,NumberofElectricVehicle*percentage(1,1)) randi([35,45],1,NumberofElectricVehicle*percentage(1,2)) randi([10,20],1,NumberofElectricVehicle*percentage(1,3)) randi([35,45],1,NumberofElectricVehicle*percentage(1,4)) randi([5,15],1,NumberofElectricVehicle*percentage(1,5))];
%         %% departure
%         departure=[randi([970,1030],1,NumberofElectricVehicle*percentage(1,1)) randi([850,950],1,NumberofElectricVehicle*percentage(1,2)) randi([1070,1090],1,NumberofElectricVehicle*percentage(1,3)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,4)) randi([100,1900],1,NumberofElectricVehicle*percentage(1,5))];
%         %% arrival
%         arrival=[randi([430,480],1,NumberofElectricVehicle*percentage(1,1)) randi([770,800],1,NumberofElectricVehicle*percentage(1,2)) randi([970,1030],1,NumberofElectricVehicle*percentage(1,3)) departure(1,t:y)-randi([40,60],1,NumberofElectricVehicle*percentage(1,4)) departure(1,x:y)-randi([40,65],1,NumberofElectricVehicle*percentage(1,5))];
        %% LB
        if distribution~=6
            for a=1:NumberofElectricVehicle
            LB(:,4*a-3)=desired(:,a);
            LB(:,4*a-2)=initial(:,a);
            LB(:,4*a-1)=departure(:,a);
            LB(:,4*a)=arrival(:,a);
            end
        end
end  

