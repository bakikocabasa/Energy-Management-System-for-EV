function [A]=ConsumerValueOptimizer(bigdata_Houses,bigdata_Uni,bigdata_AVM,bigdata_Hospital,bigdata_Social_Facilities,bigdata_Organized_industry,bigdata_Industrial_Factory)
% bigdata_Houses=bigdata_Houses';
% bigdata_Uni=bigdata_Uni';
% bigdata_AVM=bigdata_AVM';
% bigdata_Hospital=bigdata_Hospital';
% bigdata_Social_Facilities=bigdata_Social_Facilities';
% bigdata_Organized_industry=bigdata_Organized_industry';
% bigdata_Industrial_Factory=bigdata_Industrial_Factory';

[House,n]=size(bigdata_Houses);
[Uni,n]=size(bigdata_Uni);
[AVM,n]=size(bigdata_AVM);
[Hospital,n]=size(bigdata_Hospital);
[Social_Facilities,n]=size(bigdata_Social_Facilities);
[Organized_industry,n]=size(bigdata_Organized_industry);
[Industrial_Factory,n]=size(bigdata_Industrial_Factory);

if bigdata_AVM==0
    bigdata_AVM=[];
    AVM=0;
end
if bigdata_Houses==0
    bigdata_Houses=[];
    House=0;
end
if bigdata_Uni==0
    bigdata_Uni=[];
    Uni=0;
end
if bigdata_Hospital==0
    bigdata_Hospital=[];
    Hospital=0;
end
if bigdata_Social_Facilities==0
    bigdata_Social_Facilities=[];
    Social_Facilities=0;
end
if bigdata_Organized_industry==0
    bigdata_Organized_industry=[];
    Organized_industry=0;
end
if bigdata_Industrial_Factory==0
    bigdata_Industrial_Factory=[];
    Industrial_Factory=0;
end

% p_other=[bigdata_Houses; bigdata_Uni; bigdata_AVM; bigdata_Hospital; bigdata_Social_Facilities; bigdata_Organized_industry; bigdata_Industrial_Factory];
for i=1:House
    p_x=bigdata_Houses(1,1:24);
   
end
% cd 'C:\Users\ikoca\Documents\MATLAB\YALMIP-master\solvers'
e_bat_max=12;
peak_pwr=100;
e_bat_min=2.5;
eff=0.95;
pv_pro=[1.05 5.85 9.45 11.55 12.6 12.9 12.75 11.85 8.85 6.75 2.25 2.25 0  0 0 0 0 0 0 0 0 0 0 0];
buy_price=[0.0225 0.032 0.0325 0.033 0.0345 0.035 0.0345 0.034 0.033 0.033 0.0355 0.04 0.045 0.0375 0.035 0.035 0.0325 0.03 0.03 0.02 0.01 0.005 0.0075 0.0175 ];
sell_price=[0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03];

totalconsumer=(AVM+House+Uni+Hospital+Social_Facilities+Organized_industry+Industrial_Factory);

for x=1:totalconsumer
   pv_pro(x,1:24)=pv_pro(1,:); 
   buy_price(x,1:24)=buy_price(1,:);
   sell_price(x,1:24)=sell_price(1,:);
end 
% pv_pro=pv_pro';
% buy_price=buy_price';
% sell_price=sell_price';

u_grid=binvar(totalconsumer,24);
u_bat=binvar(totalconsumer,24);
grid=sdpvar(totalconsumer,24,'full','real');
pv_used=sdpvar(totalconsumer,24,'full','real');
bat_used=sdpvar(totalconsumer,24,'full','real');
bat_t=sdpvar(totalconsumer,24,'full','real');
bat_sold=sdpvar(totalconsumer,24,'full','real');
bat_g=sdpvar(totalconsumer,24,'full','real');
pv_sold=sdpvar(totalconsumer,24,'full','real');
e_bat=sdpvar(totalconsumer,24,'full','real');
sell=sdpvar(totalconsumer,24,'full','real');
buy=sdpvar(totalconsumer,24,'full','real');
midsum=sdpvar(totalconsumer,24,'full','real');
% total_cost=sdpvar(1,1);
const=[];
const=[const,e_bat(1)==e_bat_min];
const=[const,bat_used(1)==0];
const=[const,bat_sold(1)==0];
const=[const,bat_used <= bat_g];  
const=[const,pv_used <= pv_pro];
const=[const,bat_t <= 2.5*u_bat]; 
const=[const,bat_g <= 2.5*(1-u_bat)];   
const=[const,pv_sold <= pv_pro];
const=[const,e_bat <= e_bat_max]; 
const=[const,e_bat_min <= e_bat]; 
const=[const,buy <= peak_pwr*u_grid]; 
const=[const,sell <= peak_pwr*(1-u_grid)]; 
const=[const,0 <= [grid pv_used bat_used bat_t bat_sold bat_g pv_sold e_bat sell buy midsum] <= 1000];
const=[const,pv_used+pv_sold+bat_t == pv_pro];
const=[const,grid+pv_used+bat_used==p_other];
const=[const,bat_used+bat_sold == bat_g*eff];
const=[const,e_bat(2:24) == e_bat(1:23)+bat_t(2:24)*eff-bat_g(2:24)];
const=[const,const,sell == pv_sold+bat_sold];
const=[const,buy == grid];
midsum=buy.*buy_price-sell.*sell_price; 
total_cost=sum(midsum);

%optimization
options = sdpsettings('solver','mosek');
sol = solvesdp(const,total_cost,options);


% pv_pro=
% p_other=
% grid=
% pv_used=
% bat_used=
% bat_t=
% bat_g=
% e_bat=
% pv_sold=
% bat_sold=
% sell=
% u_bat=
% u_grid=
%Value print
% for i=1:totalconsumer
%     for h=1:24
% 
%         Tables(h+(i-1)*24,1:13)=[value(pv_pro(i,h)), value(p_other(i,h)) ,value(grid(i,h)),value(pv_used(i,h)),value(bat_used(i,h)),value(bat_t(i,h)),value(bat_g(i,h)),value(e_bat(i,h)),value(pv_sold(i,h)),value(bat_sold(i,h)),value(sell(i,h)),value(u_bat(i,h)),value(u_grid(i,h))];
%     end
% end
A = table([value(pv_pro(1,1:24))'],[value(p_other(1,1:24))'],[value(grid(1,1:24))'],[value(pv_used(1,1:24))'],[value(bat_used(1,1:24))'],[value(bat_t(1,1:24))'],[value(bat_g(1,1:24))'],[value(e_bat(1,1:24))'],[value(pv_sold(1,1:24))'],[value(bat_sold(1,1:24))'],[value(sell(1,1:24))'],[value(u_bat(1,1:24))'],[value(u_grid(1,1:24))'],...
    'VariableNames',{ 'pv_pro' 'p_other' 'grid' 'pv_used' 'bat_used' 'bat_charge' 'bat_dischrge' 'e_bat' 'pv_sold' 'bat_sold' 'sell' 'u_bat' 'u_grid'},...
    'RowNames',{'1AM' '2AM' '3AM' '4AM' '5AM' '6AM' '7AM' '8AM' '9AM' '10AM' '11AM' '12PM' '13PM' '14PM' '15PM' '16PM' '17PM' '18PM' '19PM' '20PM' '21PM' '22PM' '23PM' '00AM'});



% options = sdpsettings('solver','bmibnb');
% options = sdpsettings('solver','gurobi');




if sol.problem == 0
solution = value(total_cost);
else
 display('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
value(e_bat)


