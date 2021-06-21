function [q,q1,q2,q3,q4,q5,distribution,House,AVM,Uni,Hospital,Social_Facilities,Organized_industry,Industrial_Factory]=Regions(o)
%% a
    while o==0
        disp('You are out of this world.')
        o=menu('Please select an area','Residential','Commercial','Industrial');
    end
%% a
q=0;
distribution=0;
House=0;
Uni=0;
AVM=0;
Hospital=0;
Social_Facilities=0;
Organized_industry=0;
Industrial_Factory=0;
q1=0;
q2=0;
q3=0;
q4=0;
q5=0;


%% 
if o==1
    
     disp('You are in Residential area')
     
        while House == 0
            House=input('Number of Houses?: ');
            if isempty(House)
                disp('Please write a number')
                House=0;
            end
        end
            disp('first value describes the consumers who come home around 18.00 and leave around 8.00  and second value describes the consumers who come home during the day and stay for a short time')
            q=menu('Please select the percentage of consumer distribution','%0-100','%20-80','%40-60','%60-40','%80-20','%100-0');
        
%%  
elseif o==2
    disp('You are in Commercial area')
    distribution=menu('Which facilities are in your area?','Only University','Only AVM','Only hospital','Only social facilities','Only organized industry','multioption');
                    while distribution==0
                    disp('You did not make a choice, please make a choice')
                    distribution=menu('Which facilities are in your area?','Only University','Only AVM','Only hospital','Only social facilities','Only organized industry','multioption');
                    end
%      while x ==0
        if distribution==1
            Uni=input('Number of Universities?: ');
            q=menu('Enter the distribution percentage of consumers using electric vehicles in the university(Stuff-Students-University vehicles with night charge-Random visitors -Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');

            elseif distribution==2
            AVM=input('Number of AVM?: ');
                q=menu('Enter the distribution percentage of consumers using electric vehicles in the shopping mall(Stuff-Customers-Company vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');

            elseif distribution==3
            Hospital=input('Number of hospitals?');
                q=menu('Enter the distribution percentage of consumers using electric vehicles in the hospital(Stuff-Patients and families-Emergency vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');

            elseif distribution==4
            Social_Facilities=input('Number of social facilities?: ');
                q=menu('Enter the distribution percentage of consumers using electric vehicles in the social facilities(Stuff-Customers-Facility vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');

            elseif distribution==5
            Organized_industry=input('Number of organized industries?: ');
                q=menu('Enter the distribution percentage of consumers using electric vehicles in the organized industry(Stuff-Customers-Company vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');
%%%%%%%%%%%%%% multioption ise...
            elseif distribution==6
            disp('Secmek istemediginiz tesis degerlerini 0 olarak giriniz.')
            Uni=input('Number of Universities?: ');
                 
            if Uni>0
        q1=menu('Enter the distribution percentage of consumers using electric vehicles in the university(Stuff-Students-University vehicles with night charge-Random visitors -Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');
            end
        AVM=input('Number of AVM?: ');
            if AVM>0
                q2=menu('Enter the distribution percentage of consumers using electric vehicles in the shopping mall(Stuff-Customers-Company vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');
            end        
        Hospital=input('Number of hospitals?: ');
            if Hospital>0
                q3=menu('Enter the distribution percentage of consumers using electric vehicles in the hospital(Stuff-Patients and families-Emergency vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');
            end
        Social_Facilities=input('Number of social facilities?: ');
            if Social_Facilities>0
                q4=menu('Enter the distribution percentage of consumers using electric vehicles in the social facilities(Stuff-Customers-Facility vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');
            end        
        Organized_industry=input('Number of organized industries?: ');
            if Organized_industry>0
                q5=menu('Enter the distribution percentage of consumers using electric vehicles in the organized industry(Stuff-Customers-Company vehicles with night charge-Random visitors-Fast Charging): ','%20-20-20-20-20','%40-20-20-20-0','%40-0-20-20-20','%60-0-20-20-0');
            end
%         Total_Multi=Uni+AVM+Hospital+Social_Facilities+Organized_industry;
        end
 
%             if isempty(Total_Multi)
%             Total_Multi=0;
%             end
%     end
       
%%     
    elseif o==3
    disp('You are in Industrial area')
        while Industrial_Factory == 0
            Industrial_Factory=input('Number of factories?: ');
        if isempty(Industrial_Factory)
                    disp('Please write a number')
                Industrial_Factory=0;
        end
        end

end
%%
end