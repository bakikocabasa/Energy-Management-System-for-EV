%gerekli on data saglanir
e_bat_max=12;
peak_pwr=100;
e_bat_min=2.5;
eff=0.95;
p_other=[0.12 0.09 0.08 0.07 0.07 0.08 0.27 0.26 0.24 0.175 0.145 0.215 0.245 0.23 0.17 0.16 0.18 0.28 0.51 0.825 0.85 0.785 0.445 0.22]*10;
pv_pro=[1.05 5.85 9.45 11.55 12.6 12.9 12.75 11.85 8.85 6.75 2.25 2.25 0  0 0 0 0 0 0 0 0 0 0 0];
buy_price=[0.0225 0.032 0.0325 0.033 0.0345 0.035 0.0345 0.034 0.033 0.033 0.0355 0.04 0.045 0.0375 0.035 0.035 0.0325 0.03 0.03 0.02 0.01 0.005 0.0075 0.0175 ];
sell_price=[0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03 0.03];
p_other=p_other';
pv_pro=pv_pro';
buy_price=buy_price';
sell_price=sell_price';
%degiskenler tanimlanir
u_grid=binvar(24,1);
u_bat=binvar(24,1);
grid=sdpvar(24,1,'full','real');
pv_used=sdpvar(24,1,'full','real');
bat_used=sdpvar(24,1,'full','real');
bat_t=sdpvar(24,1,'full','real');
bat_sold=sdpvar(24,1,'full','real');
bat_g=sdpvar(24,1,'full','real');
pv_sold=sdpvar(24,1,'full','real');
e_bat=sdpvar(24,1,'full','real');
sell=sdpvar(24,1,'full','real');
buy=sdpvar(24,1,'full','real');
midsum=sdpvar(24,1,'full','real');
%sinirlar belirtilir
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

%optimizasyon sureci baslar
options = sdpsettings('solver','mosek');
sol = solvesdp(const,total_cost,options);

%sonuclar olusur ve tabloya aktarilir
A = table([value(pv_pro)],[value(p_other)],[value(grid)],[value(pv_used)],[value(bat_used)],[value(bat_t)],[value(bat_g)],[value(e_bat)],[value(pv_sold)],[value(bat_sold)],[value(sell)],[value(u_bat)],[value(u_grid)],...
    'VariableNames',{ 'pv_pro' 'p_other' 'grid' 'pv_used' 'bat_used' 'bat_charge' 'bat_dischrge' 'e_bat' 'pv_sold' 'bat_sold' 'sell' 'u_bat' 'u_grid'},...
    'RowNames',{'1AM' '2AM' '3AM' '4AM' '5AM' '6AM' '7AM' '8AM' '9AM' '10AM' '11AM' '12PM' '13PM' '14PM' '15PM' '16PM' '17PM' '18PM' '19PM' '20PM' '21PM' '22PM' '23PM' '00AM'});
%surecin duzgun isleyip islemedigi kontrol edilir
if sol.problem == 0
solution = value(total_cost);
else
 display('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
value(e_bat)
