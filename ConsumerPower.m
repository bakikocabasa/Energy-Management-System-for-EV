function [bigdata_Houses,bigdata_Uni,bigdata_AVM,bigdata_Hospital,bigdata_Social_Facilities,bigdata_Organized_industry,bigdata_Industrial_Factory,bigdata_Houses_pv,bigdata_Uni_pv,bigdata_AVM_pv,bigdata_Hospital_pv,bigdata_Social_Facilities_pv,bigdata_Organized_industry_pv,bigdata_Industrial_Factory_pv]=ConsumerPower(o,House,Uni,AVM,Hospital,Social_Facilities,Organized_industry,Industrial_Factory,distribution,population,pv_penetration)
bigdata_Houses=0;
bigdata_Uni=0;
bigdata_AVM=0;
bigdata_Hospital=0;
bigdata_Social_Facilities=0;
bigdata_Organized_industry=0;
bigdata_Industrial_Factory=0;
bigdata_Houses_pv=0;
bigdata_Uni_pv=0;
bigdata_AVM_pv=0;
bigdata_Hospital_pv=0;
bigdata_Social_Facilities_pv=0;
bigdata_Organized_industry_pv=0;
bigdata_Industrial_Factory_pv=0;

global NumberofElectricVehicle


basevalues_House=[0.12
            0.09
            0.08
            0.07
            0.07
            0.08
            0.27
            0.26
            0.24
            0.175
            0.145
            0.215
            0.245
            0.23
            0.17
            0.16
            0.18
            0.28
            0.51
            0.825
            0.85
            0.785
            0.445
            0.22
            0.12
            0.09
            0.08
            0.07
            0.07
            0.08
            0.27
            0.26
            0.24
            0.175
            0.145
            0.215
            0.245
            0.23
            0.17
            0.16
            0.18
            0.28
            0.51
            0.825
            0.85
            0.785
            0.445
            0.22
            0.12
            0.09
            0.08
            0.07
            0.07
            0.08
            0.27
            0.26
            0.24
            0.175
            0.145
            0.215
            0.245
            0.23
            0.17
            0.16
            0.18
            0.28
            0.51
            0.825
            0.85
            0.785
            0.445
            0.22];
basevalues_Com=[2.1
                2.1
                2
                2
                2.2
                2
                3
                4.2
                6
                6
                6.4
                6.5
                6.4
                6
                6.2
                6.3
                6.1
                6.5
                6.7
                5
                4.2
                4.5
                3.8
                2
                2.1
                2.1
                2
                2
                2.2
                2
                3
                4.2
                6
                6
                6.4
                6.5
                6.4
                6
                6.2
                6.3
                6.1
                6.5
                6.7
                5
                4.2
                4.5
                3.8
                2
                2.1
                2.1
                2
                2
                2.2
                2
                3
                4.2
                6
                6
                6.4
                6.5
                6.4
                6
                6.2
                6.3
                6.1
                6.5
                6.7
                5
                4.2
                4.5
                3.8
                2];       
basevalues_Ind=[74.4
                68.4
                73.2
                67.2
                57.6
                67.2
                61.2
                66
                72
                78
                84
                88.8
                92.4
                93.6
                91.2
                87.6
                81.6
                78
                73.68
                69.6
                72
                74.4
                72.84
                78
                74.4
                68.4
                73.2
                67.2
                57.6
                67.2
                61.2
                66
                72
                78
                84
                88.8
                92.4
                93.6
                91.2
                87.6
                81.6
                78
                73.68
                69.6
                72
                74.4
                72.84
                78
                74.4
                68.4
                73.2
                67.2
                57.6
                67.2
                61.2
                66
                72
                78
                84
                88.8
                92.4
                93.6
                91.2
                87.6
                81.6
                78
                73.68
                69.6
                72
                74.4
                72.84
                78];

pv_input=[
0
0
0
0
0
0
0.49
2.73
4.41
5.39
5.88
6.02
5.95
5.53
4.13
3.15
2.23
1.05
0
0
0
0
0
0
0
0
0
0
0
0
0.49
2.73
4.41
5.39
5.88
6.02
5.95
5.53
4.13
3.15
2.23
1.05
0
0
0
0
0
0
0
0
0
0
0
0
0.49
2.73
4.41
5.39
5.88
6.02
5.95
5.53
4.13
3.15
2.23
1.05
0
0
0
0
0
0];




bigdata_diff_Houses=randi([90 110],72,House)/100+population(1:House,4*NumberofElectricVehicle+1)'.*randi([-1 1],72,House)/100; % %90 veya %110 olacak sekilde degistiriyor.
bigdata_diff_Uni=randi([80 120],72,Uni)/100+population(1:Uni,4*NumberofElectricVehicle+1)'.*randi([-1 1],72,Uni)/100;
bigdata_diff_AVM=randi([70 120],72,AVM)/100+population(1:AVM,4*NumberofElectricVehicle+1)'.*randi([-1 1],72,AVM)/100;
bigdata_diff_Hospital=randi([80 120],72,Hospital)/100+population(1:Hospital,4*NumberofElectricVehicle+1)'.*randi([-1 1],72,Hospital)/100;
bigdata_diff_Social_Facilities=randi([80 120],72,Social_Facilities)/100+population(1:Social_Facilities,4*NumberofElectricVehicle+1)'.*randi([-1 1],72,Social_Facilities)/100;
bigdata_diff_Organized_industry=randi([80 120],72,Organized_industry)/100+population(1:Organized_industry,4*NumberofElectricVehicle+1)'.*randi([-1 1],72,Organized_industry)/100;
bigdata_diff_Industrial_Factory=randi([70 140],72,Industrial_Factory)/100+population(1:Industrial_Factory,4*NumberofElectricVehicle+1)'.*randi([-1 1],72,Industrial_Factory)*1.5;


% for i=1:24
%     if pv_pro(i,:)>0
%         pv_pro(i,:)=randi([90 110],24,House)/100+population(1:House,4*NumberofElectricVehicle+1)'.*randi([-1 1],24,House)/100;

if o==1
bigdata_Houses=basevalues_House.*bigdata_diff_Houses;
pu=[0	0	0	0	0	0	0.063238791	0.511964915	0.749138016	1.018153868	1.0224203	1.061992679	1.030899001	0.732870551	0.47002527	0.315508556	0.15894215	0	0	0	0	0	0	0 0	0	0	0	0	0	0.063238791	0.511964915	0.749138016	1.018153868	1.0224203	1.061992679	1.030899001	0.732870551	0.47002527	0.315508556	0.15894215	0	0	0	0	0	0	0 0	0	0	0	0	0	0.063238791	0.511964915	0.749138016	1.018153868	1.0224203	1.061992679	1.030899001	0.732870551	0.47002527	0.315508556	0.15894215	0	0	0	0	0	0	0];
demand=sum(bigdata_Houses)
peak_demand=max(demand);
peak_pv=peak_demand*pv_penetration;
% [x,v] = randfixedsum(n,m,s,a,b)
[x,v] = randfixedsum(House,1,peak_pv,0,10);
bigdata_Houses_pv=x.*pu;
    elseif o==2 %commercial
        if distribution==1
                        bigdata_Uni=basevalues_Com.*bigdata_diff_Uni;
                        bigdata_Uni_pv=pv_input.*bigdata_diff_Uni*10;
            elseif distribution==2
                                      bigdata_AVM=basevalues_Com.*bigdata_diff_AVM;  
                                      bigdata_AVM_pv=pv_input.*bigdata_diff_AVM*15;
                elseif distribution==3
                                        bigdata_Hospital=basevalues_Com.*bigdata_diff_Hospital; 
                                        bigdata_Hospital_pv=pv_input.*bigdata_diff_Hospital*15;
                 elseif distribution==4
                                                bigdata_Social_Facilities=basevalues_Com.*bigdata_diff_Social_Facilities;
                                                bigdata_Social_Facilities_pv=pv_input.*bigdata_diff_Social_Facilities*10;
                     elseif distribution==5
                                                        bigdata_Organized_industry=basevalues_Com.*bigdata_diff_Organized_industry;
                                                        bigdata_Organized_industry_pv=pv_input.*bigdata_diff_Organized_industry*35;
                            elseif distribution==6 %multicase

                                     if AVM>0  %%duruma gore olusacak degerler
                                                                                bigdata_AVM=basevalues_Com.*bigdata_diff_AVM;
                                                                                bigdata_AVM_pv=pv_input.*bigdata_diff_AVM*15;
                                     end
                                                if Uni>0
                                                                                                        bigdata_Uni=basevalues_Com.*bigdata_diff_Uni;
                                                                                                        bigdata_Hospital_pv=pv_input.*bigdata_diff_Hospital*10;
                                                end        
                                            
                                                        if Hospital>0
                                                                                                                        bigdata_Hospital=basevalues_Com.*bigdata_diff_Hospital;
                                                                                                                        bigdata_Hospital_pv=pv_input.*bigdata_diff_Hospital*15;
                                                        end
                                                    
                                                                if Social_Facilities>0
                                                                                                                                        bigdata_Social_Facilities=basevalues_Com.*bigdata_diff_Social_Facilities;   
                                                                                                                                        bigdata_Social_Facilities_pv=pv_input.*bigdata_diff_Social_Facilities*10;
                                                                end  
                                                                            if Organized_industry>0
                                                                                                                                                                bigdata_Organized_industry=basevalues_Com.*bigdata_diff_Organized_industry;
                                                                                                                                                                bigdata_Organized_industry_pv=pv_input.*bigdata_diff_Organized_industry*35;
                                                                            end
                                            
        end
                elseif o==3 
                                                bigdata_Industrial_Factory=basevalues_Ind.*bigdata_diff_Industrial_Factory;
                                                bigdata_Industrial_Factory_pv=pv_input.*bigdata_diff_Industrial_Factory*50;
end

bigdata_Houses=abs(bigdata_Houses');
bigdata_Uni=abs(bigdata_Uni');
bigdata_AVM=abs(bigdata_AVM');
bigdata_Hospital=abs(bigdata_Hospital');
bigdata_Social_Facilities=abs(bigdata_Social_Facilities');
bigdata_Organized_industry=abs(bigdata_Organized_industry');
bigdata_Industrial_Factory=abs(bigdata_Industrial_Factory');

bigdata_Uni_pv=abs(bigdata_Uni_pv');
bigdata_AVM_pv=(bigdata_AVM_pv');
bigdata_Hospital_pv=(bigdata_Hospital_pv');
bigdata_Social_Facilities_pv=(bigdata_Social_Facilities_pv');
bigdata_Organized_industry_pv=(bigdata_Organized_industry_pv');
bigdata_Industrial_Factory_pv=(bigdata_Industrial_Factory_pv');



