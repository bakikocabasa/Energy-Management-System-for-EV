function [BatteryCapasity,NumberofElectricVehicle]=Batteries(k)
NumberofElectricVehicle=1;
while mod(NumberofElectricVehicle,5)~=0
while k==0
    disp('You haven`t choose any selection,please choose one.')
    k=menu('Please select the vehicle brands in the area','BMWi3-Ford-Nissan-Toyota-Fiat-Hyundai','Ford-Nissan-Toyota-Fiat-Hyundai','Nissan-Toyota-Fiat-Hyundai','Ford-Toyota-Fiat-Hyundai','Ford-Nissan-Fiat-Hyundai','Tesla-Ferrari-BMWi3-Günsel-TOGG-Ford-Nissan-Toyota-Fiat-Hyundai');
end
if k==1
    disp('car brands in the area is BMWi3-Ford-Nissan-Toyota-Fiat-BMWi3 ')
%     BatteryCapasityPossibilities=[10 20 30 40 50 10];
    Ford=input('Ford arac sayisini giriniz=');
    Nissan=input('Nissan arac sayisini giriniz=');
    Toyota=input('Toyota arac sayisini giriniz=');
    Fiat=input('Fiat arac sayisini giriniz=');
    Hyundai=input('Hyundai arac sayisini giriniz=');
    BMWi3=input('BMWi3 arac sayisini giriniz=');
    BatteryCapasity=[linspace(33,33,Ford),linspace(40,40,Nissan),linspace(41.8,41.8,Toyota),linspace(24,24,Fiat),linspace(36,36,Hyundai),linspace(27.2,27.2,BMWi3)];
    NumberofElectricVehicle=Ford+Nissan+Toyota+Fiat+Hyundai+BMWi3;

elseif k==2
    disp('car brands in the area is Ford-Nissan-Toyota-Fiat-Hyundai ')
%     BatteryCapasityPossibilities=[10 20 30 40 50];
    Ford=input('Ford arac sayisini giriniz=');
    Nissan=input('Nissan arac sayisini giriniz=');
    Toyota=input('Toyota arac sayisini giriniz=');
    Fiat=input('Fiat arac sayisini giriniz=');
    BMWi3=input('BMWi3 arac sayisini giriniz=');
    BatteryCapasity=[linspace(33,33,Ford),linspace(40,40,Nissan),linspace(41.8,41.8,Toyota),linspace(24,24,Fiat),linspace(27.2,27.2,BMWi3)];
    NumberofElectricVehicle=Ford+Nissan+Toyota+Fiat+BMWi3;
elseif k==3
    disp('car brands in the area is Nissan-Toyota-Fiat-Hyundai ')
%     BatteryCapasityPossibilities=[20 30 40 50];
    Nissan=input('Nissan arac sayisini giriniz=');
    Toyota=input('Toyota arac sayisini giriniz=');
    Fiat=input('Fiat arac sayisini giriniz=');
    Hyundai=input('Hyundai arac sayisini giriniz=');
    BatteryCapasity=[linspace(40,40,Nissan),linspace(41.8,41.8,Toyota),linspace(24,24,Fiat),linspace(64,64,Hyundai)];
    NumberofElectricVehicle=Nissan+Toyota+Fiat+Hyundai;
elseif  k==4
    disp('car brands in the area is Ford-Toyota-Fiat-Hyundai ')
%     BatteryCapasityPossibilities=[10 30 40 50];
    Ford=input('Ford arac sayisini giriniz=');
    Toyota=input('Toyota arac sayisini giriniz=');
    Fiat=input('Fiat arac sayisini giriniz=');
    Hyundai=input('Hyundai arac sayisini giriniz=');
    BatteryCapasity=[linspace(33,33,Ford),linspace(41.8,41.8,Toyota),linspace(24,24,Fiat),linspace(64,64,Hyundai)];
    NumberofElectricVehicle=Ford+Toyota+Fiat+Hyundai;

elseif k==5
    disp('car brands in the area is Ford-Nissan-Fiat-Hyundai ')
%     BatteryCapasityPossibilities=[30 30 40 50];
    Ford=input('Ford arac sayisini giriniz=');
    Nissan=input('Nissan arac sayisini giriniz=');
    Fiat=input('Fiat arac sayisini giriniz=');
    Hyundai=input('Hyundai arac sayisini giriniz=');
    BatteryCapasity=[linspace(33,33,Ford),linspace(40,40,Nissan),linspace(24,24,Fiat),linspace(64,64,Hyundai)];
    NumberofElectricVehicle=Ford+Nissan+Fiat+Hyundai;
elseif k==6
    disp('car brands in the area is Tesla-Ferrari-BMWi3-Günsel-TOGG-Ford-Nissan-Toyota-Fiat-Hyundai ')
%     BatteryCapasityPossibilities=[10 20 30 40 50 10 20 30 40 35];
    Ford=input('Ford arac sayisini giriniz=');
    Nissan=input('Nissan arac sayisini giriniz=');
    Toyota=input('Toyota arac sayisini giriniz=');
    Fiat=input('Fiat arac sayisini giriniz=');
    Hyundai=input('Hyundai arac sayisini giriniz=');
    BMWi3=input('BMWi3 arac sayisini giriniz=');
    Gunsel=input('Gunsel arac sayisini giriniz=');
    TOGG=input('TOGG arac sayisini giriniz=');
    Ferrari=input('Ferrari arac sayisini giriniz=');
    RenaultZoe=input('Tesla arac sayisini giriniz=');
    NumberofElectricVehicle=Ford+Nissan+Toyota+Fiat+Hyundai+BMWi3+Gunsel+TOGG+Ferrari+RenaultZoe;
    BatteryCapasity=[linspace(33,33,Ford),linspace(40,40,Nissan),linspace(41.8,41.8,Toyota),linspace(24,24,Fiat),linspace(64,64,Hyundai),linspace(27.2,27.2,BMWi3),linspace(80,80,Gunsel),linspace(80,80,TOGG),linspace(90,90,Ferrari),linspace(41,41,RenaultZoe)];
else
    while k==0
        disp('Secim yapmadiniz lutfen bir secenegi isaretleyiniz')
        k=menu('Please select the vehicle brands in the area','BMWi3-Ford-Nissan-Toyota-Fiat-Hyundai','Ford-Nissan-Toyota-Fiat-Hyundai','Nissan-Toyota-Fiat-Hyundai','Ford-Toyota-Fiat-Hyundai','Ford-Nissan-Fiat-Hyundai','Tesla-Ferrari-BMWi3-Günsel-TOGG-Ford-Nissan-Toyota-Fiat-Hyundai');
        
    end
end
% while mod(NumberofElectricVehicle)~=0
% return
% end
    
% L=length(BatteryCapasityPossibilities);
% a=randi([1,L],1,NumberofElectricVehicle);
% % a=round(a);
% BatteryCapasity=BatteryCapasityPossibilities(1,a);
if mod(NumberofElectricVehicle,5)~=0
    disp('lutfen toplam arac sayisi 5 in kati olacak sekilde degerler giriniz')
end
%% elde ettigim degerlerin sirali bir sekilde olmamasini istedigimden...
% [sayi]=genetic_algorithm(NumberofElectricVehicle);
% sayi=[1,sayi];
% BatteryCapasity=BatteryCapasity(1,sayi);
end