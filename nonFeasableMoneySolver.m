                  for x=1:NumberofElectricVehicle
        a(x,1)=sum(All_Power_grid_EV_DR_V2G(x,:),2);
        b(x,1)=sum(All_Power_grid_EV_V2G(x,:),2);
        c(x,1)=sum(All_Power_grid_PV_EV_DR_V2G(x,:),2);
        d(x,1)=sum(All_Power_grid_PV_EV_V2G(x,:),2);
        if a(x,1)==0
            All_Power_grid_EV_DR_V2G(x,:)=All_Power_grid_EV_DR_V2G(1,:);
             All_Power_grid_EV_DR_nonV2G(x,:)=All_Power_grid_EV_DR_nonV2G(1,:);
        end
        if b(x,1)==0
            All_Power_grid_EV_V2G(x,:)=All_Power_grid_EV_V2G(1,:);
            All_Power_grid_EV_nonV2G(x,:)=All_Power_grid_EV_nonV2G(1,:);
        end
        if c(x,1)==0
            All_Power_grid_PV_EV_DR_V2G(x,:)=All_Power_grid_PV_EV_DR_V2G(1,:);
            All_Power_grid_PV_EV_DR_nonV2G(x,:)=All_Power_grid_PV_EV_DR_nonV2G(1,:);
        end        
        if d(x,1)==0
            All_Power_grid_PV_EV_V2G(x,:)=All_Power_grid_PV_EV_V2G(1,:);
            All_Power_grid_PV_EV_nonV2G(x,:)=All_Power_grid_PV_EV_nonV2G(1,:);
        end  
        end 


            grid_EV_V2G=sum(All_Power_grid_EV_V2G.*buy_price,2);
            grid_EV_DR_V2G=sum(All_Power_grid_EV_DR_V2G.*buy_price,2);
            grid_PV_EV_V2G=sum(All_Power_grid_PV_EV_V2G.*buy_price,2);
            grid_PV_EV_DR_V2G=sum(All_Power_grid_PV_EV_DR_V2G.*buy_price,2);




            % grid+EV+V2G
            grid_EV_V2G_max=max(grid_EV_V2G);
            grid_EV_V2G_min=min(grid_EV_V2G);
            grid_EV_V2G_mean=mean(grid_EV_V2G);
            
            % grid+EV+DR+V2G
            grid_EV_DR_V2G_max=max(grid_EV_DR_V2G);
            grid_EV_DR_V2G_min=min(grid_EV_DR_V2G);
            grid_EV_DR_V2G_mean=mean(grid_EV_DR_V2G);      
            
           % grid+PV+EV+V2G
            grid_PV_EV_V2G_max=max(grid_PV_EV_V2G);
            grid_PV_EV_V2G_min=min(grid_PV_EV_V2G);
            grid_PV_EV_V2G_mean=mean(grid_PV_EV_V2G);

            % grid+PV+EV+DR+V2G
            grid_PV_EV_DR_V2G_max=max(grid_PV_EV_DR_V2G);
            grid_PV_EV_DR_V2G_min=min(grid_PV_EV_DR_V2G);
            grid_PV_EV_DR_V2G_mean=mean(grid_PV_EV_DR_V2G);            