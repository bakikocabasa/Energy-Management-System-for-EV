function [LB,m]=Multioption(q1,q2,q3,q4,q5,House,AVM,Uni,Hospital,Social_Facilities,NumberofElectricVehicle)
%%
a=zeros(1,5);
percentage1=a;
percentage2=a;
percentage3=a;
percentage4=a;
percentage5=a;

desired1=0; desired2=0; desired3=0; desired4=0; desired5=0;
initial1=0; initial2=0; initial3=0; initial4=0; initial5=0; 
departure1=0; departure2=0; departure3=0; departure4=0; departure5=0;
arrival1=0; arrival2=0; arrival3=0; arrival4=0; arrival5=0; 
%%
if q1==1
        disp('%20-20-20-20-20')
        percentage1=[0.2 0.2 0.2 0.2 0.2];
    elseif q1==2
        disp('%40-20-20-20-0')
        percentage1=[0.4 0.2 0.2 0.2 0];
    elseif q1==3
        disp('%40-0-20-20-20')
        percentage1=[0.4 0 0.2 0.2 0.2];
    elseif q1==4
        disp('%60-0-20-20-0')
        percentage1=[0.6 0 0.2 0.2 0];
        while q1==0
                    disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
                    q1=menu('Ticari bolgedeki elektrikli arac kullanan tuketicilerin dagilim yuzdesini giriniz(calisanlar-kahvaltiya gelen musteriler-ogle yemegine gelen musteriler-aksam yemegine gelen musteriler-rastgele gelen musteri): ','%50-20-20-5-5','%50-10-10-20-10','%50-10-10-10-20');
        end
end
%%
    if q2==1
        disp('%20-20-20-20-20')
        percentage2=[0.2 0.2 0.2 0.2 0.2];
    elseif q2==2
        disp('%40-20-20-20-0')
        percentage2=[0.4 0.2 0.2 0.2 0];
    elseif q2==3
        disp('%40-0-20-20-20')
        percentage2=[0.4 0 0.2 0.2 0.2];
    elseif q2==4
        disp('%60-0-20-20-0')
        percentage2=[0.6 0 0.2 0.2 0];
        while q2==0
                    disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
                    q2=menu('Ticari bolgedeki elektrikli arac kullanan tuketicilerin dagilim yuzdesini giriniz(calisanlar-kahvaltiya gelen musteriler-ogle yemegine gelen musteriler-aksam yemegine gelen musteriler-rastgele gelen musteri): ','%50-20-20-5-5','%50-10-10-20-10','%50-10-10-10-20');
        end
    end
    %%
if q3==1
        disp('%20-20-20-20-20')
        percentage3=[0.2 0.2 0.2 0.2 0.2];
    elseif q3==2
        disp('%40-20-20-20-0')
        percentage3=[0.4 0.2 0.2 0.2 0];
    elseif q3==3
        disp('%40-0-20-20-20')
        percentage3=[0.4 0 0.2 0.2 0.2];
    elseif q3==4
        disp('%60-0-20-20-0')
        percentage3=[0.6 0 0.2 0.2 0];
        while q3==0
                    disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
                    q3=menu('Ticari bolgedeki elektrikli arac kullanan tuketicilerin dagilim yuzdesini giriniz(calisanlar-kahvaltiya gelen musteriler-ogle yemegine gelen musteriler-aksam yemegine gelen musteriler-rastgele gelen musteri): ','%50-20-20-5-5','%50-10-10-20-10','%50-10-10-10-20');
        end
end
%%
if q4==1
        disp('%20-20-20-20-20')
        percentage4=[0.2 0.2 0.2 0.2 0.2];
    elseif q4==2
        disp('%40-20-20-20-0')
        percentage4=[0.4 0.2 0.2 0.2 0];
    elseif q4==3
        disp('%40-0-20-20-20')
        percentage4=[0.4 0 0.2 0.2 0.2];
    elseif q4==4
        disp('%60-0-20-20-0')
        percentage4=[0.6 0 0.2 0.2 0];
        while q4==0
                    disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
                    q4=menu('Ticari bolgedeki elektrikli arac kullanan tuketicilerin dagilim yuzdesini giriniz(calisanlar-kahvaltiya gelen musteriler-ogle yemegine gelen musteriler-aksam yemegine gelen musteriler-rastgele gelen musteri): ','%50-20-20-5-5','%50-10-10-20-10','%50-10-10-10-20');
        end
end
%%
if q5==1
        disp('%20-20-20-20-20')
        percentage5=[0.2 0.2 0.2 0.2 0.2];
    elseif q5==2
        disp('%40-20-20-20-0')
        percentage5=[0.4 0.2 0.2 0.2 0];
    elseif q5==3
        disp('%40-0-20-20-20')
        percentage5=[0.4 0 0.2 0.2 0.2];
    elseif q5==4
        disp('%60-0-20-20-0')
        percentage5=[0.6 0 0.2 0.2 0];
            while q5==0
                    disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
                    q5=menu('Ticari bolgedeki elektrikli arac kullanan tuketicilerin dagilim yuzdesini giriniz(calisanlar-kahvaltiya gelen musteriler-ogle yemegine gelen musteriler-aksam yemegine gelen musteriler-rastgele gelen musteri): ','%50-20-20-5-5','%50-10-10-20-10','%50-10-10-10-20');
            end
end
%%
   
        rate1=(House)/(House+AVM+Uni+Hospital+Social_Facilities); 
        rate2=(AVM)/(House+AVM+Uni+Hospital+Social_Facilities);
        rate3=(Uni)/(House+AVM+Uni+Hospital+Social_Facilities);
        rate4=(Hospital)/(House+AVM+Uni+Hospital+Social_Facilities);
        rate5=(Social_Facilities)/(House+AVM+Uni+Hospital+Social_Facilities);
        
        sonoran=NumberofElectricVehicle.*[percentage1.*rate1;percentage2.*rate2;percentage3.*rate3;percentage4.*rate4;percentage5.*rate5];
%       sonoran=fix(sonoran)

        sonoran=round(sonoran);

        a=sum(sonoran);
        b=sum(a);
        c=max(sonoran);
       

        cikanfark=b-NumberofElectricVehicle;

        [row, col] = find(ismember(sonoran, max(sonoran(:))));

        sonoran(row,col)=sonoran(row,col)-cikanfark;
%         sonoran
        
%%
 %bu sayilar aralarda olusan h?zl? sarj durumlarindaki kisa sürenin cikarilmas? icin gerekli olan terimlerin yerlerini bulmayi sagliyor, mesela ilk 20 arac normalken hizli sarj durumu olan 21-25. araclar?n?n terimleri bu formüllerle bulunabilir, ilk terimde +1 olmas? 20 ye kadar olan sayilarin bulunup 21.sayidan baslamasini saglar, -1 ise aradaki arac sayisini ekledigimizde 26 olmasin 25 olsun diye      
for i=1:5
    z(i,1)=sonoran(i,1)+sonoran(i,2)+sonoran(i,3)+1;
    t(i,1)=z(i,1)+sonoran(i,4)-1;
    x(i,1)=sonoran(i,1)+sonoran(i,2)+sonoran(i,3)+sonoran(i,4)+1;
    y(i,1)=x(i,1)+sonoran(i,5)-1;
    
end 
% x
% y
% z
% t
        %% gelen ogrenciler, ogretim gorevlileri ve personeller, ziyaretciler, kampus ici ulasim araclari, hizli sarj
            if House>0 %% only university 5- numaral? e?itim kurumlar? ticari ofislerde benzer bir yük profiligöstermekte olup ?arj talep süreleri uzun ,?arj talep enerjileri dü?üktür
        % desired
        desired1=[randi([80,85],1,sonoran(1,1)) randi([75,90],1,sonoran(1,2)) randi([75,89],1,sonoran(1,3)) randi([80,90],1,sonoran(1,4)) randi([70,85],1,sonoran(1,5))]; 
        % initial
        initial1=[randi([55,65],1,sonoran(1,1)) randi([55,65],1,sonoran(1,2)) randi([25,35],1,sonoran(1,3)) randi([60,70],1,sonoran(1,4)) randi([40,55],1,sonoran(1,5))];
        % departure
        departure1=[randi([700,1000],1,sonoran(1,1)) randi([960,1020],1,sonoran(1,2)) randi([1800,1900],1,sonoran(1,3)) randi([460,1030],1,sonoran(1,4)) randi([100,1900],1,sonoran(1,5))];
        % arrival
        arrival1=[randi([500,590],1,sonoran(1,1)) randi([480,540],1,sonoran(1,2)) randi([1020,1320],1,sonoran(1,3)) departure1(1,z(1,1):(t(1,1)))-randi([60,240],1,sonoran(1,4))  departure1(1,x(1,1):y(1,1))-randi([40,65],1,sonoran(1,5))];
%         [~, m]=size(desired1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        %% calisanlar, ziyaretciler, gece sarj olan sirket araclari, ------cinemalar------, hizli sarj
            if AVM>0 %%only AVM 1- numaral?  kullan?c? tipleri genellikle çal??ma saatleri içerisinde EV'lerinin ?arj talebini kar??larlar.?arj süreleri uzun olup ?arj enerji talepleri nispeten küçüktür.
        % desired
        desired2=[randi([80,85],1,sonoran(2,1)) randi([65,80],1,sonoran(2,2)) randi([90,95],1,sonoran(2,3)) randi([65,75],1,sonoran(2,4)) randi([80,85],1,sonoran(2,5))]; 
        % initial
        initial2=[randi([25,35],1,sonoran(2,1)) randi([35,45],1,sonoran(2,2)) randi([10,20],1,sonoran(2,3)) randi([35,45],1,sonoran(2,4)) randi([5,15],1,sonoran(2,5))];
        % departure
        departure2=[randi([970,1030],1,sonoran(2,1)) randi([850,950],1,sonoran(2,2)) randi([1070,1090],1,sonoran(2,3)) randi([100,1900],1,sonoran(2,4)) randi([100,1900],1,sonoran(2,5))];
        % arrival
        arrival2=[randi([430,480],1,sonoran(2,1)) randi([770,800],1,sonoran(2,2)) randi([970,1030],1,sonoran(2,3)) departure2(1,z(2,1):t(2,1))-randi([40,60],1,sonoran(2,4)) departure2(1,x(2,1):y(2,1))-randi([40,65],1,sonoran(2,5))];
%          [~, m]=size(desired2);
            end
        %% calisanlar, ziyaretciler, gece sarj olan hastane araclari, urun teslimat eden sirket araclari, hizli sarj
            if Uni>0 %%only Hostpital  6-numaral? kullan?c? profilindeki  hastahaneler çal??an personel EV talep profili aç?s?ndan ?arj talep süresi uzun olmakla birlikte ?arj talep enerjileri dü?üktür.Bununla birlikte hasta EV ?arj talep profili aç?s?ndan k?sa süreli ?arj talebi ve bununla ters orant?l? bir enerji talep büyüklü?ü görülmektedir. 
        % desired
        desired3=[randi([80,85],1,sonoran(3,1)) randi([65,80],1,sonoran(3,2)) randi([90,95],1,sonoran(3,3)) randi([65,75],1,sonoran(3,4)) randi([80,85],1,sonoran(3,5))]; 
        % initial
        initial3=[randi([25,35],1,sonoran(3,1)) randi([35,45],1,sonoran(3,2)) randi([10,20],1,sonoran(3,3)) randi([35,45],1,sonoran(3,4)) randi([5,15],1,sonoran(3,5))];
        % departure
        departure3=[randi([970,1030],1,sonoran(3,1)) randi([850,950],1,sonoran(3,2)) randi([1070,1090],1,sonoran(3,3)) randi([100,1900],1,sonoran(3,4)) randi([100,1900],1,sonoran(3,5))];
        % arrival
        arrival3=[randi([430,480],1,sonoran(3,1)) randi([770,800],1,sonoran(3,2)) randi([970,1030],1,sonoran(3,3)) departure3(1,z(3,1):t(3,1))-randi([40,60],1,sonoran(3,4)) departure3(1,x(3,1):y(3,1))-randi([40,65],1,sonoran(3,5))];
%         [~, m]=size(desired3);
            end
        %% calisanlar, ziyaretciler, gece sarj olan sirket araclari, urun teslimat eden sirket araclari, hizli sarj 
            if Hospital>0 %%only Social Facilities  1- numaral?  kullan?c? tipleri genellikle çal??ma saatleri içerisinde EV'lerinin ?arj talebini kar??larlar.?arj süreleri uzun olup ?arj enerji talepleri nispeten küçüktür.  2- numaral? mü?teri profili EV ?arj talebi genelde 09:00-17:00 saatleri aras?nda, ?arj talep zamanlar? belirsiz ve k?sad?r.Ancak ?arj talep enerjileri nispeten büyüktür.
        % desired
        desired4=[randi([80,85],1,sonoran(4,1)) randi([65,80],1,sonoran(4,2)) randi([90,95],1,sonoran(4,3)) randi([65,75],1,sonoran(4,4)) randi([80,85],1,sonoran(4,5))]; 
        % initial
        initial4=[randi([25,35],1,sonoran(4,1)) randi([35,45],1,sonoran(4,2)) randi([10,20],1,sonoran(4,3)) randi([35,45],1,sonoran(4,4)) randi([5,15],1,sonoran(4,5))];
        % departure
        departure4=[randi([970,1030],1,sonoran(4,1)) randi([850,950],1,sonoran(4,2)) randi([1070,1090],1,sonoran(4,3)) randi([100,1900],1,sonoran(4,4)) randi([100,1900],1,sonoran(4,5))];
        % arrival
        arrival4=[randi([430,480],1,sonoran(4,1)) randi([770,800],1,sonoran(4,2)) randi([970,1030],1,sonoran(4,3)) departure4(1,z(4,1):t(4,1))-randi([40,60],1,sonoran(4,4)) departure4(1,x(4,1):y(4,1))-randi([40,65],1,sonoran(4,5))];
%      [~, m]=size(desired4);
            end
        %% calisanlar, ziyaretciler, gece sarj olan sirket araclari, urun teslimat eden sirket calisanlari, hizli sarj 
            if Social_Facilities>0 %%only Organized Industry  1 numaral?  kullan?c? tipleri genellikle çal??ma saatleri içerisinde EV'lerinin ?arj talebini kar??larlar.?arj süreleri uzun olup ?arj enerji talepleri nispeten küçüktür.  2- numaral? mü?teri profili EV ?arj talebi genelde 09:00-17:00 saatleri aras?nda, ?arj talep zamanlar? belirsiz ve k?sad?r.Ancak ?arj talep enerjileri nispeten büyüktür.
        % desired
        desired5=[randi([80,85],1,sonoran(5,1)) randi([65,80],1,sonoran(5,2)) randi([90,95],1,sonoran(5,3)) randi([65,75],1,sonoran(5,4)) randi([80,85],1,sonoran(5,5))]; 
        % initial
        initial5=[randi([25,35],1,sonoran(5,1)) randi([35,45],1,sonoran(5,2)) randi([10,20],1,sonoran(5,3)) randi([35,45],1,sonoran(5,4)) randi([5,15],1,sonoran(5,5))];
        % departure
        departure5=[randi([970,1030],1,sonoran(5,1)) randi([850,950],1,sonoran(5,2)) randi([1070,1090],1,sonoran(5,3)) randi([100,1900],1,sonoran(5,4)) randi([100,1900],1,sonoran(5,5))];
        % arrival
        arrival5=[randi([430,480],1,sonoran(5,1)) randi([770,800],1,sonoran(5,2)) randi([970,1030],1,sonoran(5,3)) departure5(1,z(5,1):t(5,1))-randi([40,60],1,sonoran(5,4)) departure5(1,x(5,1):y(5,1))-randi([40,65],1,sonoran(5,5))];
%         [~, m]=size(desired5);
            end
        %% 
% if isempty(desired1)
%     desired1=zeros(1,m);
% end
% if isempty(desired2)
%     desired2=zeros(1,m);
% end
% if isempty(desired3)
%     desired3=zeros(1,m);
% end
% if isempty(desired4)
%     desired4=zeros(1,m);
% end
% if isempty(desired5)
%     desired5=zeros(1,m);
% end
    
desired=[desired1 desired2 desired3 desired4 desired5];
desired(desired == 0) = [];
initial=[initial1 initial2 initial3 initial4 initial5];
initial(initial == 0) = [];
departure=[departure1 departure2 departure3 departure4 departure5];
departure(departure == 0) = [];
arrival=[arrival1 arrival2 arrival3 arrival4 arrival5];
arrival(arrival == 0) = []; % 0 olan tum degerlerin yerine bosluk konuldugunda degerler silinmis oluyor, toplama yaptigim icin 0 olan degerler matrisi genisletiyor

%% LB
[~, m]=size(desired);
        for a=1:NumberofElectricVehicle
        LB(:,4*a-3)=desired(:,a);
        LB(:,4*a-2)=initial(:,a);
        LB(:,4*a-1)=departure(:,a);
        LB(:,4*a)=arrival(:,a);

        end
