All_Power_grid=bigdata_Houses(:,1:72);
All_Power_grid_DR=bigdata_Houses_DR(:,1:72);
All_Power_grid_PV=All_Power_grid_PV(:,1:48);
All_Power_grid_PV_DR=All_Power_grid_PV_DR(:,1:48);
All_Power_grid_PV_ESS=All_Power_grid_PV_ESS(:,1:48);
All_Power_grid_PV_ESS_DR=All_Power_grid_PV_ESS_DR(:,1:48);
All_Power_grid_EV_nonV2G=All_Power_grid_EV_nonV2G(:,1:48);
All_Power_grid_EV_DR_nonV2G=All_Power_grid_EV_DR_nonV2G(:,1:48);
All_Power_grid_EV_V2G=All_Power_grid_EV_V2G(:,1:48);
All_Power_grid_EV_DR_V2G=All_Power_grid_EV_DR_V2G(:,1:48);
All_Power_grid_PV_EV_nonV2G=All_Power_grid_PV_EV_nonV2G(:,1:48);
All_Power_grid_PV_EV_DR_nonV2G=All_Power_grid_PV_EV_DR_nonV2G(:,1:48);
All_Power_grid_PV_EV_V2G=All_Power_grid_PV_EV_V2G(:,1:48);
All_Power_grid_PV_EV_DR_V2G=All_Power_grid_PV_EV_DR_V2G(:,1:48);

xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid,'All_Power_grid','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_DR,'All_Power_grid_DR','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV,'All_Power_grid_PV','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_DR,'All_Power_grid_PV_DR','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_ESS,'All_Power_grid_PV_ESS','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_ESS_DR,'All_Power_grid_PV_ESS_DR','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_nonV2G,'All_Power_grid_EV_nonV2G','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_DR_nonV2G,'All_Power_grid_EV_DR_nonV2G','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_V2G,'All_Power_grid_EV_V2G','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_DR_V2G,'All_Power_grid_EV_DR_V2G','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_nonV2G,'All_Power_grid_PV_EV_nonV2G','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_DR_nonV2G,'All_Power_grid_PV_EV_DR_nonV2G','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_V2G,'All_Power_grid_PV_EV_V2G','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_DR_V2G,'All_Power_grid_PV_EV_DR_V2G','B2')


xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_sum,'BusBar','B2')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_DR_sum,'BusBar','B3')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_sum,'BusBar','B4')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_DR_sum,'BusBar','B5')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_ESS_sum,'BusBar','B6')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_ESS_DR_sum,'BusBar','B7')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_nonV2G_sum,'BusBar','B8')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_DR_nonV2G_sum,'BusBar','B9')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_V2G_sum,'BusBar','B10')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_EV_DR_V2G_sum,'BusBar','B11')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_nonV2G_sum,'BusBar','B12')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_DR_nonV2G_sum,'BusBar','B13')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_V2G_sum,'BusBar','B14')
xlswrite('alpaslanhocam_500houses_%80EV_%100PV.xlsx',All_Power_grid_PV_EV_DR_V2G_sum,'BusBar','B15')





