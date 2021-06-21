        %% graph
        HoursofaDay=1:48;
        HoursofaDay=HoursofaDay';
        t = tiledlayout(3,3);
        % comparison grid vs grid+DR
        ax1 = nexttile;
        plot(ax1,HoursofaDay,All_Power_grid_DR_sum,':r',HoursofaDay,All_Power_grid_sum,'k','LineWidth',3)
        legend(ax1,'grid+DR','grid')

        ax2 = nexttile;
        plot(ax2,HoursofaDay,All_Power_grid_PV_sum,':r',HoursofaDay,All_Power_grid_sum,'k','LineWidth',3);
        legend(ax2,'grid+PV','grid')

        ax3 = nexttile;
        plot(ax3,HoursofaDay,All_Power_grid_PV_ESS_sum,':r',HoursofaDay,All_Power_grid_PV_sum,'k','LineWidth',3);
        legend(ax3,'grid+PV+ESS','grid+PV')
        
        ax4 = nexttile;
        plot(ax4,HoursofaDay,All_Power_grid_EV_DR_V2G_sum,':r',HoursofaDay,All_Power_grid_EV_V2G_sum,'k','LineWidth',3);
        legend(ax4,'grid+EV+DR&V2G','grid+EV&V2G')

        ax5 = nexttile;
        plot(ax5,HoursofaDay,All_Power_grid_PV_EV_V2G_sum,':r',HoursofaDay,All_Power_grid_EV_V2G_sum,'k','LineWidth',3);
        legend(ax5,'grid+PV+EV&V2G','grid+EV&V2G')
        

        ax6 = nexttile;
        plot(ax6,HoursofaDay,All_Power_grid_EV_DR_V2G_sum,':r',HoursofaDay,All_Power_grid_EV_DR_nonV2G_sum,'k','LineWidth',3);
        legend(ax6,'grid+EV+DR&V2G','grid+EV+DR&nonV2G')

        ax7 = nexttile;
        plot(ax7,HoursofaDay,V2G,':r',HoursofaDay,nonV2G,'k','LineWidth',3);
        legend(ax7,'only EV&V2G','only EV&nonV2G')
        
        ax8 = nexttile;
        plot(ax8,HoursofaDay,All_Power_grid_PV_EV_V2G_sum,':r',HoursofaDay,All_Power_grid_PV_EV_nonV2G_sum,'k','LineWidth',3);
        legend(ax8,'grid+PV+EV&V2G','grid+PV+EV&nonV2G')

          
        
        ax9 = nexttile;
        plot(ax9,HoursofaDay,All_Power_grid_PV_EV_DR_V2G_sum,':r',HoursofaDay,All_Power_grid_PV_EV_DR_nonV2G_sum,'k','LineWidth',3);
        legend(ax9,'grid+PV+EV+DR&V2G','grid+PV+EV+DR&nonV2G')

        linkaxes([ax1,ax2,ax3],'x');
        linkaxes([ax1,ax2,ax3],'y');
        linkaxes([ax4,ax5,ax6],'x');
        linkaxes([ax4,ax5,ax6],'y');
        linkaxes([ax7,ax8,ax9],'x');
        linkaxes([ax7,ax8,ax9],'y');
        t.Padding = 'none';
        t.TileSpacing = 'none';

        % Add shared title and axis labels
        title(t,'Power On Bus Bar')
        xlabel(t,'time(h)')
        ylabel(t,'Power(kW)')
        a=sum(All_Power_grid_PV_EV_V2G_sum)
        b=sum(All_Power_grid_PV_EV_nonV2G_sum)