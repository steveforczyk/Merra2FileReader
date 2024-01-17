function PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the Sulfur Dioxide Table.
% The unit is measuremenetn is frequently changed from kg/m^2/sec to
% femotogm/m^2/sec to make it easier to read the result
% and easier to read result
% 
%
% Written By: Stephen Forczyk
% Created: June 30,2023
% Revised: Jul 1-9,2023 added many variable to plot list

% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global SO2MAN10 SO2MAN25 SO2MAN50 SO2MAN75 SO2MAN90 SO2MAN95 SO2MAN98 SO2MAN100;
global SO2MANLow SO2MANHigh SO2MANNaN SO2MANValues;
global SO2MANTable SO2MANTT SO2MBBTable SO2MBBTT;
global SO2MBB10 SO2MBB25 SO2MBB50 SO2MBB75 SO2MBB90 SO2MBB95 SO2MBB98 SO2MBB100;
global SO2MBBLow SO2MBBHigh SO2MBBNaN SO2MBBValues;
global SO2EMVE10 SO2EMVE25 SO2EMVE50 SO2EMVE75 SO2EMVE90 SO2EMVE95 SO2EMVE98 SO2EMVE100;
global SO2EMVELow SO2EMVEHigh SO2EMVENaN SO2EMVEValues;
global SO2EMVETable SO2EMVETT;
global SO2EMVN10 SO2EMVN25 SO2EMVN50 SO2EMVN75 SO2EMVN90 SO2EMVN95 SO2EMVN98 SO2EMVN100;
global SO2EMVNLow SO2EMVNHigh SO2EMVNNaN SO2EMVNValues;
global SO2EMVNTable SO2EMVNTT;
global SO4EMAN10 SO4EMAN25 SO4EMAN50 SO4EMAN75 SO4EMAN90 SO4EMAN95 SO4EMAN98 SO4EMAN100;
global SO4EMANLow SO4EMANHigh SO4EMANNaN SO4EMANValues;
global SO4EMANTable SO4EMANTT;
global SUDP00110 SUDP00125 SUDP00150 SUDP00175 SUDP00190 SUDP00195 SUDP00198 SUDP001100;
global SUDP001Low SUDP001High SUDP001NaN SUDP001Values;
global SUDP001Table SUDP001TT;
global SUDP00210 SUDP00225 SUDP00250 SUDP00275 SUDP00290 SUDP00295 SUDP00298 SUDP002100;
global SUDP002Low SUDP002High SUDP002NaN SUDP002Values;
global SUDP002Table SUDP002TT;
global SUDP00310 SUDP00325 SUDP00350 SUDP00375 SUDP00390 SUDP00395 SUDP00398 SUDP003100;
global SUDP003Low SUDP003High SUDP003NaN SUDP003Values;
global SUDP003Table SUDP003TT;
global SUDP00410 SUDP00425 SUDP00450 SUDP00475 SUDP00490 SUDP00495 SUDP00498 SUDP004100;
global SUDP004Low SUDP004High SUDP004NaN SUDP004Values;
global SUDP004Table SUDP004TT;
global SUEM00110 SUEM00125 SUEM00150 SUEM00175 SUEM00190 SUEM00195 SUEM00198 SUEM001100;
global SUEM001Low SUEM001High SUEM001NaN SUEM001Values;
global SUEM001Table SUEM001TT;
global SUEM00210 SUEM00225 SUEM00250 SUEM00275 SUEM00290 SUEM00295 SUEM00298 SUEM002100;
global SUEM002Low SUEM002High SUEM002NaN SUEM002Values;
global SUEM002Table SUEM002TT;
global SUEM00310 SUEM00325 SUEM00350 SUEM00375 SUEM00390 SUEM00395 SUEM00398 SUEM003100;
global SUEM003Low SUEM003High SUEM003NaN SUEM003Values;
global SUEM003Table SUEM003TT;
global SUEM00410 SUEM00425 SUEM00450 SUEM00475 SUEM00490 SUEM00495 SUEM00498 SUEM004100;
global SUEM004Low SUEM004High SUEM004NaN SUEM004Values;
global SUEM004Table SUEM004TT;
global SUPMSA10 SUPMSA25 SUPMSA50 SUPMSA75 SUPMSA90 SUPMSA95 SUPMSA98 SUPMSA100;
global SUPMSALow SUPMSAHigh SUPMSANaN SUPMSAValues;
global SUPMSATable SUPMSATT;
global SUPSO210 SUPSO225 SUPSO250 SUPSO275 SUPSO290 SUPSO295 SUPSO298 SUPSO2100;
global SUPSO2Low SUPSO2High SUPSO2NaN SUPSO2Values;
global SUPSO2Table SUPSO2TT;
global SUPSO4AQ10 SUPSO4AQ25 SUPSO4AQ50 SUPSO4AQ75 SUPSO4AQ90 SUPSO4AQ95 SUPSO4AQ98 SUPSO4AQ100;
global SUPSO4AQLow SUPSO4AQHigh SUPSO4AQNaN SUPSO4AQValues;
global SUPSO4AQTable SUPSO4AQTT;
global SUPSO4GTable SUPSO4GTT;
global SUPSO4WTTable SUPSO4WTTT;
global SUSD001Table SUSD001TT;
global SUSD002Table SUSD002TT;
global SUSD003Table SUSD003TT;
global SUSD004Table SUSD004TT;
global SUSD005Table SUSD005TT;
global SUSV001Table SUSV001TT;
global SUSV002Table SUSV002TT;
global SUSV003Table SUSV003TT;
global SUSV004Table SUSV004TT;
global SUSV005Table SUSV005TT;
global SUWT001Table SUWT001TT;
global SUWT002Table SUWT002TT;
global SUWT003Table SUWT003TT;
global SUWT004Table SUWT004TT;
global Merra2ShortFileName;
global numtimeslice TimeSlices;
global Years Months Days;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie;
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global matpath datapath;
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;

global shapefilepath Countryshapepath figpath pressurepath averaged1Daypath;
global mappath gridpath countyshapepath nationalshapepath summarypath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;

global pwd;
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
end

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(ikind==60)
    plot(SO2MANTT.Time,SO2MANTT.SO2MAN75,'b',SO2MANTT.Time,SO2MANTT.SO2MAN90,'g',...
        SO2MANTT.Time,SO2MANTT.SO2MAN95,'k',SO2MANTT.Time,SO2MANTT.SO2MAN98,'r');
    hl=legend('SO2EMAN 75 ptile','SO2EMAN 90 ptile','SO2EMAN 95 ptile','SO2EMAN 98 ptile');
    ylabel('SO2EMAN-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SO2EMAN','-Map');
    pdftxtstr=strcat(' SO2EMAN Map For File-',Merra2ShortFileName);
elseif(ikind==61)
     plot(SO2MBBTT.Time,SO2MBBTT.SO2MB75,'b',SO2MBBTT.Time,SO2MBBTT.SO2MB90,'g',...
        SO2MBBTT.Time,SO2MBBTT.SO2MB95,'k',SO2MBBTT.Time,SO2MBBTT.SO2MB98,'r');
    hl=legend('SO2EMBB 75 ptile','SO2EMBB 90 ptile','SO2EMBB 95 ptile','SO2EMBB 98 ptile');
    ylabel('SO2EMBB-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SO2EMBB','-Map');
    pdftxtstr=strcat(' SO2EMBB Map For File-',Merra2ShortFileName); 
elseif(ikind==62)
     plot(SO2EMVETT.Time,SO2EMVETT.SO2MVE75,'b',SO2EMVETT.Time,SO2EMVETT.SO2MVE90,'g',...
        SO2EMVETT.Time,SO2EMVETT.SO2MVE95,'k',SO2EMVETT.Time,SO2EMVETT.SO2MVE98,'r');
    hl=legend('SO2EMVE 75 ptile','SO2EMVE 90 ptile','SO2EMVE 95 ptile','SO2EMVE 98 ptile');
    ylabel('SO2EMVE-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SO2EMVE','-Map');
    pdftxtstr=strcat(' SO2EMVE Map For File-',Merra2ShortFileName); 
elseif(ikind==63)
     plot(SO2EMVNTT.Time,SO2EMVNTT.SO2MVN75,'b',SO2EMVNTT.Time,SO2EMVNTT.SO2MVN90,'g',...
        SO2EMVNTT.Time,SO2EMVNTT.SO2MVN95,'k',SO2EMVNTT.Time,SO2EMVNTT.SO2MVN98,'r');
    hl=legend('SO2EMVN 75 ptile','SO2EMVN 90 ptile','SO2EMVN 95 ptile','SO2EMVN 98 ptile');
    ylabel('SO2EMVN-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SO2EMVN','-Map');
    pdftxtstr=strcat(' SO2EMVN Map For File-',Merra2ShortFileName); 
elseif(ikind==64)
     plot(SO4EMANTT.Time,SO4EMANTT.SO4MAN75,'b',SO4EMANTT.Time,SO4EMANTT.SO4MAN90,'g',...
        SO4EMANTT.Time,SO4EMANTT.SO4MAN95,'k',SO4EMANTT.Time,SO4EMANTT.SO4MAN98,'r');
    hl=legend('SO4EMAN 75 ptile','SO4EMAN 90 ptile','SO4EMAN 95 ptile','SO4EMAN 98 ptile');
    ylabel('SO2EMVN-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SO4EMAN','-Map');
    pdftxtstr=strcat(' SO4EMAN Map For File-',Merra2ShortFileName); 
elseif(ikind==93)
     plot(SUDP001TT.Time,SUDP001TT.SUDP00175,'b',SUDP001TT.Time,SUDP001TT.SUDP00190,'g',...
        SUDP001TT.Time,SUDP001TT.SUDP00195,'k',SUDP001TT.Time,SUDP001TT.SUDP00198,'r');
    hl=legend('SUDP001 75 ptile','SUDP001 90 ptile','SUDP001 95 ptile','SUDP001 98 ptile');
    ylabel('SUDP001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUDP001','-Map');
    pdftxtstr=strcat(' SUDP001 Map For File-',Merra2ShortFileName); 
elseif(ikind==94)
     plot(SUDP002TT.Time,SUDP002TT.SUDP00275,'b',SUDP002TT.Time,SUDP002TT.SUDP00290,'g',...
        SUDP002TT.Time,SUDP002TT.SUDP00295,'k',SUDP002TT.Time,SUDP002TT.SUDP00298,'r');
    hl=legend('SUDP002 75 ptile','SUDP002 90 ptile','SUDP002 95 ptile','SUDP002 98 ptile');
    ylabel('SUDP002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUDP002','-Map');
    pdftxtstr=strcat(' SUDP002 Map For File-',Merra2ShortFileName); 
elseif(ikind==95)
     plot(SUDP003TT.Time,SUDP003TT.SUDP00375,'b',SUDP003TT.Time,SUDP003TT.SUDP00390,'g',...
        SUDP003TT.Time,SUDP003TT.SUDP00395,'k',SUDP003TT.Time,SUDP003TT.SUDP00398,'r');
    hl=legend('SUDP003 75 ptile','SUDP003 90 ptile','SUDP003 95 ptile','SUDP003 98 ptile');
    ylabel('SUDP003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUDP003','-Map');
    pdftxtstr=strcat(' SUDP003 Map For File-',Merra2ShortFileName); 
elseif(ikind==96)
     plot(SUDP004TT.Time,SUDP004TT.SUDP00475,'b',SUDP004TT.Time,SUDP004TT.SUDP00490,'g',...
        SUDP004TT.Time,SUDP004TT.SUDP00495,'k',SUDP004TT.Time,SUDP004TT.SUDP00498,'r');
    hl=legend('SUDP004 75 ptile','SUDP004 90 ptile','SUDP004 95 ptile','SUDP004 98 ptile');
    ylabel('SUDP004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUDP004','-Map');
    pdftxtstr=strcat(' SUDP004 Map For File-',Merra2ShortFileName);
elseif(ikind==97)
     plot(SUEM001TT.Time,SUEM001TT.SUEM00175,'b',SUEM001TT.Time,SUEM001TT.SUEM00190,'g',...
        SUEM001TT.Time,SUEM001TT.SUEM00195,'k',SUEM001TT.Time,SUEM001TT.SUEM00198,'r');
    hl=legend('SUEM001 75 ptile','SUEM001 90 ptile','SUEM001 95 ptile','SUEM001 98 ptile');
    ylabel('SUEM001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUEM001','-Map');
    pdftxtstr=strcat(' SUEM001 Map For File-',Merra2ShortFileName); 
elseif(ikind==98)
     plot(SUEM002TT.Time,SUEM002TT.SUEM00275,'b',SUEM002TT.Time,SUEM002TT.SUEM00290,'g',...
        SUEM002TT.Time,SUEM002TT.SUEM00295,'k',SUEM002TT.Time,SUEM002TT.SUEM00298,'r');
    hl=legend('SUEM002 75 ptile','SUEM002 90 ptile','SUEM002 95 ptile','SUEM002 98 ptile');
    ylabel('SUEM002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUEM002','-Map');
    pdftxtstr=strcat(' SUEM002 Map For File-',Merra2ShortFileName);
elseif(ikind==99)
     plot(SUEM003TT.Time,SUEM003TT.SUEM00375,'b',SUEM003TT.Time,SUEM003TT.SUEM00390,'g',...
        SUEM003TT.Time,SUEM003TT.SUEM00395,'k',SUEM003TT.Time,SUEM003TT.SUEM00398,'r');
    hl=legend('SUEM003 75 ptile','SUEM003 90 ptile','SUEM003 95 ptile','SUEM003 98 ptile');
    ylabel('SUEM003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUEM003','-Map');
    pdftxtstr=strcat(' SUEM003 Map For File-',Merra2ShortFileName); 
elseif(ikind==100)
     plot(SUEM004TT.Time,SUEM004TT.SUEM00475,'b',SUEM004TT.Time,SUEM004TT.SUEM00490,'g',...
        SUEM004TT.Time,SUEM004TT.SUEM00495,'k',SUEM004TT.Time,SUEM004TT.SUEM00498,'r');
    hl=legend('SUEM004 75 ptile','SUEM004 90 ptile','SUEM004 95 ptile','SUEM004 98 ptile');
    ylabel('SUEM004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUEM004','-Map');
    pdftxtstr=strcat(' SUEM004 Map For File-',Merra2ShortFileName);
elseif(ikind==101)
     plot(SUPMSATT.Time,SUPMSATT.SUPMSA75,'b',SUPMSATT.Time,SUPMSATT.SUPMSA90,'g',...
        SUPMSATT.Time,SUPMSATT.SUPMSA95,'k',SUPMSATT.Time,SUPMSATT.SUPMSA98,'r');
    hl=legend('SUPMSA 75 ptile','SUPMSA 90 ptile','SUPMSA 95 ptile','SUPMSA 98 ptile');
    ylabel('SUPMSA-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUPMSA','-Map');
    pdftxtstr=strcat(' SUPMSA Map For File-',Merra2ShortFileName);
elseif(ikind==102)
     plot(SUPSO2TT.Time,SUPSO2TT.SUPSO275,'b',SUPSO2TT.Time,SUPSO2TT.SUPSO290,'g',...
        SUPSO2TT.Time,SUPSO2TT.SUPSO295,'k',SUPSO2TT.Time,SUPSO2TT.SUPSO298,'r');
    hl=legend('SUPSO2 75 ptile','SUPSO2 90 ptile','SUPSO2 95 ptile','SUPSO2 98 ptile');
    ylabel('SUPSO2-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUPSO2','-Map');
    pdftxtstr=strcat(' SUPSO2 Map For File-',Merra2ShortFileName); 
elseif(ikind==103)
     plot(SUPSO4AQTT.Time,SUPSO4AQTT.SUPSO4AQ75,'b',SUPSO4AQTT.Time,SUPSO4AQTT.SUPSO4AQ90,'g',...
        SUPSO4AQTT.Time,SUPSO4AQTT.SUPSO4AQ95,'k',SUPSO4AQTT.Time,SUPSO4AQTT.SUPSO4AQ98,'r');
    hl=legend('SUPSO4AQ 75 ptile','SUPSO4AQ 90 ptile','SUPSO4AQ 95 ptile','SUPSO4AQ 98 ptile');
    ylabel('SUPSO4AQ-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUPS04AQ','-Map');
    pdftxtstr=strcat(' SUPS04AQ Map For File-',Merra2ShortFileName); 
elseif(ikind==104)
     plot(SUPSO4GTT.Time,SUPSO4GTT.SUPSO4G75,'b',SUPSO4GTT.Time,SUPSO4GTT.SUPSO4G90,'g',...
        SUPSO4GTT.Time,SUPSO4GTT.SUPSO4G95,'k',SUPSO4GTT.Time,SUPSO4GTT.SUPSO4G98,'r');
    hl=legend('SUPSO4G 75 ptile','SUPSO4G 90 ptile','SUPSO4G 95 ptile','SUPSO4G 98 ptile');
    ylabel('SUPSO4G-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUPSO4G','-Map');
    pdftxtstr=strcat(' SUPSO4G Map For File-',Merra2ShortFileName); 
elseif(ikind==105)
     plot(SUPSO4WTTT.Time,SUPSO4WTTT.SUPSO4WT75,'b',SUPSO4WTTT.Time,SUPSO4WTTT.SUPSO4WT90,'g',...
        SUPSO4WTTT.Time,SUPSO4WTTT.SUPSO4WT95,'k',SUPSO4WTTT.Time,SUPSO4WTTT.SUPSO4WT98,'r');
    hl=legend('SUPSO4WT 75 ptile','SUPSO4WT 90 ptile','SUPSO4WT 95 ptile','SUPSO4WT 98 ptile');
    ylabel('SUPSO4WT-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUPSO4WT','-Map');
    pdftxtstr=strcat(' SUPSO4WT Map For File-',Merra2ShortFileName); 
elseif(ikind==106)
     plot(SUSD001TT.Time,SUSD001TT.SUSD00175,'b',SUSD001TT.Time,SUSD001TT.SUSD00190,'g',...
        SUSD001TT.Time,SUSD001TT.SUSD00195,'k',SUSD001TT.Time,SUSD001TT.SUSD00198,'r');
    hl=legend('SUSD001 75 ptile','SUSD001 90 ptile','SUSD001 95 ptile','SUSD001 98 ptile');
    ylabel('SUSD001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSD001','-Map');
    pdftxtstr=strcat(' SUSD001 Map For File-',Merra2ShortFileName); 
elseif(ikind==107)
     plot(SUSD002TT.Time,SUSD002TT.SUSD00275,'b',SUSD002TT.Time,SUSD002TT.SUSD00290,'g',...
        SUSD002TT.Time,SUSD002TT.SUSD00295,'k',SUSD002TT.Time,SUSD002TT.SUSD00298,'r');
    hl=legend('SUSD002 75 ptile','SUSD002 90 ptile','SUSD002 95 ptile','SUSD002 98 ptile');
    ylabel('SUSD002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSD002','-Map');
    pdftxtstr=strcat(' SUSD002 Map For File-',Merra2ShortFileName); 
elseif(ikind==108)
     plot(SUSD003TT.Time,SUSD003TT.SUSD00375,'b',SUSD003TT.Time,SUSD003TT.SUSD00390,'g',...
        SUSD003TT.Time,SUSD003TT.SUSD00395,'k',SUSD003TT.Time,SUSD003TT.SUSD00398,'r');
    hl=legend('SUSD003 75 ptile','SUSD003 90 ptile','SUSD003 95 ptile','SUSD003 98 ptile');
    ylabel('SUSD003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSD003','-Map');
    pdftxtstr=strcat(' SUSD003 Map For File-',Merra2ShortFileName);
elseif(ikind==109)
     plot(SUSD004TT.Time,SUSD004TT.SUSD00475,'b',SUSD004TT.Time,SUSD004TT.SUSD00490,'g',...
        SUSD004TT.Time,SUSD004TT.SUSD00495,'k',SUSD004TT.Time,SUSD004TT.SUSD00498,'r');
    hl=legend('SUSD004 75 ptile','SUSD004 90 ptile','SUSD004 95 ptile','SUSD004 98 ptile');
    ylabel('SUSD004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSD004','-Map');
    pdftxtstr=strcat(' SUSD004 Map For File-',Merra2ShortFileName);
elseif(ikind==110)
     plot(SUSV001TT.Time,SUSV001TT.SUSV00175,'b',SUSV001TT.Time,SUSV001TT.SUSV00190,'g',...
        SUSV001TT.Time,SUSV001TT.SUSV00195,'k',SUSV001TT.Time,SUSV001TT.SUSV00198,'r');
    hl=legend('SUSV001 75 ptile','SUSV001 90 ptile','SUSV001 95 ptile','SUSV001 98 ptile');
    ylabel('SUSV001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSV001','-Map');
    pdftxtstr=strcat(' SUSV001 Map For File-',Merra2ShortFileName);
elseif(ikind==111)
     plot(SUSV002TT.Time,SUSV002TT.SUSV00275,'b',SUSV002TT.Time,SUSV002TT.SUSV00290,'g',...
        SUSV002TT.Time,SUSV002TT.SUSV00295,'k',SUSV002TT.Time,SUSV002TT.SUSV00298,'r');
    hl=legend('SUSV002 75 ptile','SUSV002 90 ptile','SUSV002 95 ptile','SUSV002 98 ptile');
    ylabel('SUSV002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSV002','-Map');
    pdftxtstr=strcat(' SUSV002 Map For File-',Merra2ShortFileName); 
elseif(ikind==112)
     plot(SUSV003TT.Time,SUSV003TT.SUSV00375,'b',SUSV003TT.Time,SUSV003TT.SUSV00390,'g',...
        SUSV003TT.Time,SUSV003TT.SUSV00395,'k',SUSV003TT.Time,SUSV003TT.SUSV00398,'r');
    hl=legend('SUSV003 75 ptile','SUSV003 90 ptile','SUSV003 95 ptile','SUSV003 98 ptile');
    ylabel('SUSV003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSV003','-Map');
    pdftxtstr=strcat(' SUSV003 Map For File-',Merra2ShortFileName); 
elseif(ikind==113)
     plot(SUSV004TT.Time,SUSV004TT.SUSV00475,'b',SUSV004TT.Time,SUSV004TT.SUSV00490,'g',...
        SUSV004TT.Time,SUSV004TT.SUSV00495,'k',SUSV004TT.Time,SUSV004TT.SUSV00498,'r');
    hl=legend('SUSV004 75 ptile','SUSV004 90 ptile','SUSV004 95 ptile','SUSV004 98 ptile');
    ylabel('SUSV004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUSV004','-Map');
    pdftxtstr=strcat(' SUSV004 Map For File-',Merra2ShortFileName);
elseif(ikind==114)
     plot(SUWT001TT.Time,SUWT001TT.SUWT00175,'b',SUWT001TT.Time,SUWT001TT.SUWT00190,'g',...
        SUWT001TT.Time,SUWT001TT.SUWT00195,'k',SUWT001TT.Time,SUWT001TT.SUWT00198,'r');
    hl=legend('SUWT001 75 ptile','SUWT001 90 ptile','SUWT001 95 ptile','SUWT001 98 ptile');
    ylabel('SUWT001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUWT001','-Map');
    pdftxtstr=strcat(' SUWT001 Map For File-',Merra2ShortFileName);
elseif(ikind==115)
     plot(SUWT002TT.Time,SUWT002TT.SUWT00275,'b',SUWT002TT.Time,SUWT002TT.SUWT00290,'g',...
        SUWT002TT.Time,SUWT002TT.SUWT00295,'k',SUWT002TT.Time,SUWT002TT.SUWT00298,'r');
    hl=legend('SUWT002 75 ptile','SUWT002 90 ptile','SUWT002 95 ptile','SUWT002 98 ptile');
    ylabel('SUWT002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUWT002','-Map');
    pdftxtstr=strcat(' SUWT002 Map For File-',Merra2ShortFileName); 
elseif(ikind==116)
     plot(SUWT003TT.Time,SUWT003TT.SUWT00375,'b',SUWT003TT.Time,SUWT003TT.SUWT00390,'g',...
        SUWT003TT.Time,SUWT003TT.SUWT00395,'k',SUWT003TT.Time,SUWT003TT.SUWT00398,'r');
    hl=legend('SUWT003 75 ptile','SUWT003 90 ptile','SUWT003 95 ptile','SUWT003 98 ptile');
    ylabel('SUWT003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUWT003','-Map');
    pdftxtstr=strcat(' SUWT003 Map For File-',Merra2ShortFileName); 
elseif(ikind==117)
     plot(SUWT004TT.Time,SUWT004TT.SUWT00475,'b',SUWT004TT.Time,SUWT004TT.SUWT00490,'g',...
        SUWT004TT.Time,SUWT004TT.SUWT00495,'k',SUWT004TT.Time,SUWT004TT.SUWT00498,'r');
    hl=legend('SUWT004 75 ptile','SUWT004 90 ptile','SUWT004 95 ptile','SUWT004 98 ptile');
    ylabel('SUWT004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SUWT004','-Map');
    pdftxtstr=strcat(' SUWT004 Map For File-',Merra2ShortFileName); 
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);

% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .1,.04,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
figstr=strcat(titlestr,'.jpg');
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
    if(iNewChapter)
        headingstr1=strcat('Tabular Analysis Results For-','Sulfure Dioxide Aerosols');
        chapter = Chapter("Title",headingstr1);
    end
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftext = Text(pdftxtstr);
    pdftext.Color = 'red';
    image.Caption = pdftext;
    nhighs=floor(nhigh/2.5);
    nwids=floor(nwid/2.5);
    heightstr=strcat(num2str(nhighs),'px');
    widthstr=strcat(num2str(nwids),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
% Now add some text -start by decribing the with a basic description of the
% variable being plotted
    parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
    if(ikind==60)
        parastr2='This metric is the value of the SO2 Antropogenic Emissions.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==61)
        parastr2='This metric is the value of the SO2 Biomass Burning.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';  
    elseif(ikind==62)
        parastr2='This metric is the value of the SO2 Explosive Volcanic Emissions.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';  
    elseif(ikind==63)
        parastr2='This metric is the value of the SO2 Non Explosive Volcanic Emissions.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';  
    elseif(ikind==64)
        parastr2='This metric is the value of the SO4 Antropogenic Emissions.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation'; 
    elseif(ikind==93)
        parastr2='This metric is the value of the Sulfur Dry Deposition Bin 01.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';  
    elseif(ikind==94)
        parastr2='This metric is the value of the  Sulfur Dry Deposition Bin 02.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation'; 
    elseif(ikind==95)
        parastr2='This metric is the value of the  Sulfur Dry Deposition Bin 03.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';  
    elseif(ikind==96)
        parastr2='This metric is the value of the  Sulfur Dry Deposition Bin 04.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==97)
        parastr2='This metric is the value of the  Sulfur Emission Bin 01.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==98)
        parastr2='This metric is the value of the  Sulfur Emission Bin 02.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==99)
        parastr2='This metric is the value of the  Sulfur Emission Bin 03.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==100)
        parastr2='This metric is the value of the  Sulfur Emission Bin 04.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==101)
        parastr2='This metric is the value of the  MSA Prod DMS Oxidation.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==102)
        parastr2='This metric is the value of the  SO2 Prod DMS Oxidation.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==103)
        parastr2='This metric is the value of the SO4 From Aqueous SO2  Oxidation.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==104)
        parastr2='This metric is the value of the SO4 From Gaseous SO2  Oxidation.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==105)
        parastr2='This metric is the value of the SO4 From Aqueous SO2  Oxidation.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==106)
        parastr2='This metric is the value of the Sulfate settling in Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==107)
        parastr2='This metric is the value of the Sulfate settling in Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==108)
        parastr2='This metric is the value of the Sulfate settling in Bin 003.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==109)
        parastr2='This metric is the value of the Sulfate settling in Bin 004.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==110)
        parastr2='This metric is the value of the Sulfate Convective Scavenging in Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==111)
        parastr2='This metric is the value of the Sulfate Convective Scavenging in Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==112)
        parastr2='This metric is the value of the Sulfate Convective Scavenging in Bin 003.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==113)
        parastr2='This metric is the value of the Sulfate Convective Scavenging in Bin 004.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==114)
        parastr2='This metric is the value of the Sulfate Wet Deposition in Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==115)
        parastr2='This metric is the value of the Sulfate Wet Deposition in Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==116)
        parastr2='This metric is the value of the Sulfate Wet Deposition in Bin 003.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==117)
        parastr2='This metric is the value of the Sulfate Wet Deposition in Bin 004.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    end
   
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(ikind==60)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SO2MANTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO2MN50';
        Hdrs{1,5}='SO2MN75';
        Hdrs{1,6}='SO2MN90';
        Hdrs{1,7}='SO2MN95';
        Hdrs{1,8}='SO2MN98';
        Hdrs{1,9}='SO2MN100';
        Col1=SO2MANTable.SO2MAN50;
        Col2=SO2MANTable.SO2MAN75;
        Col3=SO2MANTable.SO2MAN90;
        Col4=SO2MANTable.SO2MAN95;
        Col5=SO2MANTable.SO2MAN98;
        Col6=SO2MANTable.SO2MAN100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO2 Antropogenic Emissions For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SO2MANTable over the selected data range.';
        parastr602=' SO2EMAN is the SO2 Antropogenic Emissions ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
    elseif(ikind==61)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SO2MBBTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO2MB50';
        Hdrs{1,5}='SO2MB75';
        Hdrs{1,6}='SO2MB90';
        Hdrs{1,7}='SO2MB95';
        Hdrs{1,8}='SO2MB98';
        Hdrs{1,9}='SO2MB100';
        Col1=SO2MBBTable.SO2MB50;
        Col2=SO2MBBTable.SO2MB75;
        Col3=SO2MBBTable.SO2MB90;
        Col4=SO2MBBTable.SO2MB95;
        Col5=SO2MBBTable.SO2MB98;
        Col6=SO2MBBTable.SO2MB100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO2 Burning Biomass Emissions For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SO2EMVETable over the selected data range.';
        parastr602=' SO2EMVE is the SO2 Explosive Volcanic Emissions ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==62)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SO2EMVETT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO2VE50';
        Hdrs{1,5}='SO2VE75';
        Hdrs{1,6}='SO2VE90';
        Hdrs{1,7}='SO2VE95';
        Hdrs{1,8}='SO2VE98';
        Hdrs{1,9}='SO2VE100';
        Col1=SO2EMVETable.SO2MVE50;
        Col2=SO2EMVETable.SO2MVE75;
        Col3=SO2EMVETable.SO2MVE90;
        Col4=SO2EMVETable.SO2MVE95;
        Col5=SO2EMVETable.SO2MVE98;
        Col6=SO2EMVETable.SO2MVE100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO2  Explosive Volcanic Emissions For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SO2EMVETable over the selected data range.';
        parastr602=' SO2EMVE is the SO2 Explosive Volcanic Emissions ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==63)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SO2EMVNTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO2VN50';
        Hdrs{1,5}='SO2VN75';
        Hdrs{1,6}='SO2VN90';
        Hdrs{1,7}='SO2VN95';
        Hdrs{1,8}='SO2VN98';
        Hdrs{1,9}='SO2VN100';
        Col1=SO2EMVNTable.SO2MVN50;
        Col2=SO2EMVNTable.SO2MVN75;
        Col3=SO2EMVNTable.SO2MVN90;
        Col4=SO2EMVNTable.SO2MVN95;
        Col5=SO2EMVNTable.SO2MVN98;
        Col6=SO2EMVNTable.SO2MVN100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO2 Non Explosive Volcanic Emissions For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SO2EMVNTable over the selected data range.';
        parastr602=' SO2EMVN is the SO2 Non Explosive Volcanic Emissions ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==64)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SO4EMANTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO4EM50';
        Hdrs{1,5}='SO4EM75';
        Hdrs{1,6}='SO4EM90';
        Hdrs{1,7}='SO4EM95';
        Hdrs{1,8}='SO4EM98';
        Hdrs{1,9}='SO4EM100';
        Col1=SO4EMANTable.SO4MAN50;
        Col2=SO4EMANTable.SO4MAN75;
        Col3=SO4EMANTable.SO4MAN90;
        Col4=SO4EMANTable.SO4MAN95;
        Col5=SO4EMANTable.SO4MAN98;
        Col6=SO4EMANTable.SO4MAN100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO4 Non AntropogenicEmissions For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SO4EMANTable over the selected data range.';
        parastr602=' SO4EMAN is the SO4 Antropogenic Emissions ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==93)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUDP001TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUDP0150';
        Hdrs{1,5}='SUDP0175';
        Hdrs{1,6}='SUDP0190';
        Hdrs{1,7}='SUDP0195';
        Hdrs{1,8}='SUDP0198';
        Hdrs{1,9}='SUDP01100';
        Col1=SUDP001Table.SUDP00150;
        Col2=SUDP001Table.SUDP00175;
        Col3=SUDP001Table.SUDP00190;
        Col4=SUDP001Table.SUDP00195;
        Col5=SUDP001Table.SUDP00198;
        Col6=SUDP001Table.SUDP001100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Sulfur Deposition For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUDP001Table over the selected data range.';
        parastr602=' SUDP001 is the Dry Sulfure Deposition in Bin 01 ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==94)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUDP002TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUDP0250';
        Hdrs{1,5}='SUDP0275';
        Hdrs{1,6}='SUDP0290';
        Hdrs{1,7}='SUDP0295';
        Hdrs{1,8}='SUDP0298';
        Hdrs{1,9}='SUDP02100';
        Col1=SUDP002Table.SUDP00250;
        Col2=SUDP002Table.SUDP00275;
        Col3=SUDP002Table.SUDP00290;
        Col4=SUDP002Table.SUDP00295;
        Col5=SUDP002Table.SUDP00298;
        Col6=SUDP002Table.SUDP002100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Sulfur Deposition For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUDP002Table over the selected data range.';
        parastr602=' SUDP002 is the Dry Sulfure Deposition in Bin 02 ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==95)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUDP003TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUDP0350';
        Hdrs{1,5}='SUDP0375';
        Hdrs{1,6}='SUDP0390';
        Hdrs{1,7}='SUDP0395';
        Hdrs{1,8}='SUDP0398';
        Hdrs{1,9}='SUDP03100';
        Col1=SUDP003Table.SUDP00350;
        Col2=SUDP003Table.SUDP00375;
        Col3=SUDP003Table.SUDP00390;
        Col4=SUDP003Table.SUDP00395;
        Col5=SUDP003Table.SUDP00398;
        Col6=SUDP003Table.SUDP003100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Sulfur Deposition For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUDP003Table over the selected data range.';
        parastr602=' SUDP003 is the Dry Sulfure Deposition in Bin 03. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==96)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUDP004TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUDP0450';
        Hdrs{1,5}='SUDP0475';
        Hdrs{1,6}='SUDP0490';
        Hdrs{1,7}='SUDP0495';
        Hdrs{1,8}='SUDP0498';
        Hdrs{1,9}='SUDP04100';
        Col1=SUDP004Table.SUDP00450;
        Col2=SUDP004Table.SUDP00475;
        Col3=SUDP004Table.SUDP00490;
        Col4=SUDP004Table.SUDP00495;
        Col5=SUDP004Table.SUDP00498;
        Col6=SUDP004Table.SUDP004100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Sulfur Deposition For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUDP004Table over the selected data range.';
        parastr602=' SUDP004 is the Dry Sulfure Deposition in Bin 04. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==97)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUEM001TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUEM0150';
        Hdrs{1,5}='SUEM0175';
        Hdrs{1,6}='SUEM0190';
        Hdrs{1,7}='SUEM0195';
        Hdrs{1,8}='SUEM0198';
        Hdrs{1,9}='SUEM01100';
        Col1=SUEM001Table.SUEM00150;
        Col2=SUEM001Table.SUEM00175;
        Col3=SUEM001Table.SUEM00190;
        Col4=SUEM001Table.SUEM00195;
        Col5=SUEM001Table.SUEM00198;
        Col6=SUEM001Table.SUEM001100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfur Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUEM001Table over the selected data range.';
        parastr602=' SUEM001 is the Sulfur Emission in Bin 01. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==98)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUEM002TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUEM0250';
        Hdrs{1,5}='SUEM0275';
        Hdrs{1,6}='SUEM0290';
        Hdrs{1,7}='SUEM0295';
        Hdrs{1,8}='SUEM0298';
        Hdrs{1,9}='SUEM02100';
        Col1=SUEM002Table.SUEM00250;
        Col2=SUEM002Table.SUEM00275;
        Col3=SUEM002Table.SUEM00290;
        Col4=SUEM002Table.SUEM00295;
        Col5=SUEM002Table.SUEM00298;
        Col6=SUEM002Table.SUEM002100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);
                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfur Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUEM002Table over the selected data range.';
        parastr602=' SUEM002 is the Sulfur Emission in Bin 02. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==99)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUEM003TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUEM0350';
        Hdrs{1,5}='SUEM0375';
        Hdrs{1,6}='SUEM0390';
        Hdrs{1,7}='SUEM0395';
        Hdrs{1,8}='SUEM0398';
        Hdrs{1,9}='SUEM03100';
        Col1=SUEM003Table.SUEM00350;
        Col2=SUEM003Table.SUEM00375;
        Col3=SUEM003Table.SUEM00390;
        Col4=SUEM003Table.SUEM00395;
        Col5=SUEM003Table.SUEM00398;
        Col6=SUEM003Table.SUEM003100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfur Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUEM003Table over the selected data range.';
        parastr602=' SUEM003 is the Sulfur Emission in Bin 03. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==100)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUEM004TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUEM0450';
        Hdrs{1,5}='SUEM0475';
        Hdrs{1,6}='SUEM0490';
        Hdrs{1,7}='SUEM0495';
        Hdrs{1,8}='SUEM0498';
        Hdrs{1,9}='SUEM04100';
        Col1=SUEM004Table.SUEM00450;
        Col2=SUEM004Table.SUEM00475;
        Col3=SUEM004Table.SUEM00490;
        Col4=SUEM004Table.SUEM00495;
        Col5=SUEM004Table.SUEM00498;
        Col6=SUEM004Table.SUEM004100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfur Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUEM004Table over the selected data range.';
        parastr602=' SUEM004 is the Sulfur Emission in Bin 04. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==101)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUPMSATT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUPMSA50';
        Hdrs{1,5}='SUPMSA75';
        Hdrs{1,6}='SUPMSA90';
        Hdrs{1,7}='SUPMSA95';
        Hdrs{1,8}='SUPMSA98';
        Hdrs{1,9}='SUPMSA100';
        Col1=SUPMSATable.SUPMSA50;
        Col2=SUPMSATable.SUPMSA75;
        Col3=SUPMSATable.SUPMSA90;
        Col4=SUPMSATable.SUPMSA95;
        Col5=SUPMSATable.SUPMSA98;
        Col6=SUPMSATable.SUPMSA100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfur MSA Oxidation For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUPMSATable over the selected data range.';
        parastr602=' SUPMSA is related to the ensemble Sulfur Oxidation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==102)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUPSO2TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUPSO250';
        Hdrs{1,5}='SUPSO275';
        Hdrs{1,6}='SUPSO290';
        Hdrs{1,7}='SUPSO295';
        Hdrs{1,8}='SUPSO298';
        Hdrs{1,9}='SUPSO2100';
        Col1=SUPSO2Table.SUPSO250;
        Col2=SUPSO2Table.SUPSO275;
        Col3=SUPSO2Table.SUPSO290;
        Col4=SUPSO2Table.SUPSO295;
        Col5=SUPSO2Table.SUPSO298;
        Col6=SUPSO2Table.SUPSO2100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO2 DMS Oxidation For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUPSO2Table over the selected data range.';
        parastr602=' SUPSO2 is related to the ensemble SO2 for DMS Oxidation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==103)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUPSO4AQTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO4AQ50';
        Hdrs{1,5}='SO4AQ75';
        Hdrs{1,6}='SO4AQ90';
        Hdrs{1,7}='SO4AQ95';
        Hdrs{1,8}='SO4AQ98';
        Hdrs{1,9}='SO4AQ100';
        Col1=SUPSO4AQTable.SUPSO4AQ50;
        Col2=SUPSO4AQTable.SUPSO4AQ75;
        Col3=SUPSO4AQTable.SUPSO4AQ90;
        Col4=SUPSO4AQTable.SUPSO4AQ95;
        Col5=SUPSO4AQTable.SUPSO4AQ98;
        Col6=SUPSO4AQTable.SUPSO4AQ100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO4 From S02 Oxidation For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUPSO4AQTable over the selected data range.';
        parastr602=' SUPSO4AQ is related to the ensemble SO4 from SO2 Oxidation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==104)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUPSO4GTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO4G50';
        Hdrs{1,5}='SO4G75';
        Hdrs{1,6}='SO4G90';
        Hdrs{1,7}='SO4G95';
        Hdrs{1,8}='SO4G98';
        Hdrs{1,9}='SO4G100';
        Col1=SUPSO4GTable.SUPSO4G50;
        Col2=SUPSO4GTable.SUPSO4G75;
        Col3=SUPSO4GTable.SUPSO4G90;
        Col4=SUPSO4GTable.SUPSO4G95;
        Col5=SUPSO4GTable.SUPSO4G98;
        Col6=SUPSO4GTable.SUPSO4G100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO4 From S02 Gaseous Oxidation For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUPSO4GTable over the selected data range.';
        parastr602=' SUPSO4G is related to the ensemble SO4 from SO2 Gaseous Oxidation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==105)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUPSO4WTTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SO4WT50';
        Hdrs{1,5}='SO4WT75';
        Hdrs{1,6}='SO4WT90';
        Hdrs{1,7}='SO4WT95';
        Hdrs{1,8}='SO4WT98';
        Hdrs{1,9}='SO4WT100';
        Col1=SUPSO4WTTable.SUPSO4WT50;
        Col2=SUPSO4WTTable.SUPSO4WT75;
        Col3=SUPSO4WTTable.SUPSO4WT90;
        Col4=SUPSO4WTTable.SUPSO4WT95;
        Col5=SUPSO4WTTable.SUPSO4WT98;
        Col6=SUPSO4WTTable.SUPSO4WT100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SO4 From S02 Aqueous Oxidation For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUPSO4WTTable over the selected data range.';
        parastr602=' SUPSO4WT is related to the ensemble SO4 from SO2 Aqueous Oxidation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==106)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSD001TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSD0150';
        Hdrs{1,5}='SUSD0175';
        Hdrs{1,6}='SUSD0190';
        Hdrs{1,7}='SUSD0195';
        Hdrs{1,8}='SUSD0198';
        Hdrs{1,9}='SUSD01100';
        Col1=SUSD001Table.SUSD00150;
        Col2=SUSD001Table.SUSD00175;
        Col3=SUSD001Table.SUSD00190;
        Col4=SUSD001Table.SUSD00195;
        Col5=SUSD001Table.SUSD00198;
        Col6=SUSD001Table.SUSD001100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Sedimentation Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSD001Table over the selected data range.';
        parastr602=' SUSD001 is related to the ensemble Sulfate Sedimentation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==107)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSD002TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSD0250';
        Hdrs{1,5}='SUSD0275';
        Hdrs{1,6}='SUSD0290';
        Hdrs{1,7}='SUSD0295';
        Hdrs{1,8}='SUSD0298';
        Hdrs{1,9}='SUSD02100';
        Col1=SUSD002Table.SUSD00250;
        Col2=SUSD002Table.SUSD00275;
        Col3=SUSD002Table.SUSD00290;
        Col4=SUSD002Table.SUSD00295;
        Col5=SUSD002Table.SUSD00298;
        Col6=SUSD002Table.SUSD002100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Sedimentation Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSD002Table over the selected data range.';
        parastr602=' SUSD002 is related to the ensemble Sulfate Sedimentation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==108)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSD003TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSD0350';
        Hdrs{1,5}='SUSD0375';
        Hdrs{1,6}='SUSD0390';
        Hdrs{1,7}='SUSD0395';
        Hdrs{1,8}='SUSD0398';
        Hdrs{1,9}='SUSD03100';
        Col1=SUSD003Table.SUSD00350;
        Col2=SUSD003Table.SUSD00375;
        Col3=SUSD003Table.SUSD00390;
        Col4=SUSD003Table.SUSD00395;
        Col5=SUSD003Table.SUSD00398;
        Col6=SUSD003Table.SUSD003100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Sedimentation Bin 003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSD003Table over the selected data range.';
        parastr602=' SUSD003 is related to the ensemble Sulfate Sedimentation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==109)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSD004TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSD0450';
        Hdrs{1,5}='SUSD0475';
        Hdrs{1,6}='SUSD0490';
        Hdrs{1,7}='SUSD0495';
        Hdrs{1,8}='SUSD0498';
        Hdrs{1,9}='SUSD04100';
        Col1=SUSD004Table.SUSD00450;
        Col2=SUSD004Table.SUSD00475;
        Col3=SUSD004Table.SUSD00490;
        Col4=SUSD004Table.SUSD00495;
        Col5=SUSD004Table.SUSD00498;
        Col6=SUSD004Table.SUSD004100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Sedimentation Bin 004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSD004Table over the selected data range.';
        parastr602=' SUSD004 is related to the ensemble Sulfate Sedimentation. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==110)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSV001TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSV0150';
        Hdrs{1,5}='SUSV0175';
        Hdrs{1,6}='SUSV0190';
        Hdrs{1,7}='SUSV0195';
        Hdrs{1,8}='SUSV0198';
        Hdrs{1,9}='SUSV01100';
        Col1=SUSV001Table.SUSV00150;
        Col2=SUSV001Table.SUSV00175;
        Col3=SUSV001Table.SUSV00190;
        Col4=SUSV001Table.SUSV00195;
        Col5=SUSV001Table.SUSV00198;
        Col6=SUSV001Table.SUSV001100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Convective Scavenging Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSV001Table over the selected data range.';
        parastr602=' SUSV001 is related to the ensemble Sulfate Convective scavenging. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==111)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSV002TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSV0250';
        Hdrs{1,5}='SUSV0275';
        Hdrs{1,6}='SUSV0290';
        Hdrs{1,7}='SUSV0295';
        Hdrs{1,8}='SUSV0298';
        Hdrs{1,9}='SUSV02100';
        Col1=SUSV002Table.SUSV00250;
        Col2=SUSV002Table.SUSV00275;
        Col3=SUSV002Table.SUSV00290;
        Col4=SUSV002Table.SUSV00295;
        Col5=SUSV002Table.SUSV00298;
        Col6=SUSV002Table.SUSV002100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Convective Scavenging Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSV002Table over the selected data range.';
        parastr602=' SUSV002 is related to the ensemble Sulfate Convective scavenging. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==112)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSV003TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSV0350';
        Hdrs{1,5}='SUSV0375';
        Hdrs{1,6}='SUSV0390';
        Hdrs{1,7}='SUSV0395';
        Hdrs{1,8}='SUSV0398';
        Hdrs{1,9}='SUSV03100';
        Col1=SUSV003Table.SUSV00350;
        Col2=SUSV003Table.SUSV00375;
        Col3=SUSV003Table.SUSV00390;
        Col4=SUSV003Table.SUSV00395;
        Col5=SUSV003Table.SUSV00398;
        Col6=SUSV003Table.SUSV003100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Convective Scavenging Bin 003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSV003Table over the selected data range.';
        parastr602=' SUSV003 is related to the ensemble Sulfate Convective scavenging. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==113)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUSV004TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUSV0450';
        Hdrs{1,5}='SUSV0475';
        Hdrs{1,6}='SUSV0490';
        Hdrs{1,7}='SUSV0495';
        Hdrs{1,8}='SUSV0498';
        Hdrs{1,9}='SUSV04100';
        Col1=SUSV004Table.SUSV00450;
        Col2=SUSV004Table.SUSV00475;
        Col3=SUSV004Table.SUSV00490;
        Col4=SUSV004Table.SUSV00495;
        Col5=SUSV004Table.SUSV00498;
        Col6=SUSV004Table.SUSV004100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Convective Scavenging Bin 004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUSV004Table over the selected data range.';
        parastr602=' SUSV004 is related to the ensemble Sulfate Convective scavenging. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==114)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUWT001TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUWT0150';
        Hdrs{1,5}='SUWT0175';
        Hdrs{1,6}='SUWT0190';
        Hdrs{1,7}='SUWT0195';
        Hdrs{1,8}='SUWT0198';
        Hdrs{1,9}='SUWT01100';
        Col1=SUWT001Table.SUWT00150;
        Col2=SUWT001Table.SUWT00175;
        Col3=SUWT001Table.SUWT00190;
        Col4=SUWT001Table.SUWT00195;
        Col5=SUWT001Table.SUWT00198;
        Col6=SUWT001Table.SUWT001100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Wet Deposition Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUWT001Table over the selected data range.';
        parastr602=' SUWT001 is related to the Sulfate Wet deposition. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==115)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUWT002TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUWT0250';
        Hdrs{1,5}='SUWT0275';
        Hdrs{1,6}='SUWT0290';
        Hdrs{1,7}='SUWT0295';
        Hdrs{1,8}='SUWT0298';
        Hdrs{1,9}='SUWT02100';
        Col1=SUWT002Table.SUWT00250;
        Col2=SUWT002Table.SUWT00275;
        Col3=SUWT002Table.SUWT00290;
        Col4=SUWT002Table.SUWT00295;
        Col5=SUWT002Table.SUWT00298;
        Col6=SUWT002Table.SUWT002100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Wet Deposition Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUWT002Table over the selected data range.';
        parastr602=' SUWT002 is related to the Sulfate Wet deposition. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==116)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUWT003TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUWT0350';
        Hdrs{1,5}='SUWT0375';
        Hdrs{1,6}='SUWT0390';
        Hdrs{1,7}='SUWT0395';
        Hdrs{1,8}='SUWT0398';
        Hdrs{1,9}='SUWT03100';
        Col1=SUWT003Table.SUWT00350;
        Col2=SUWT003Table.SUWT00375;
        Col3=SUWT003Table.SUWT00390;
        Col4=SUWT003Table.SUWT00395;
        Col5=SUWT003Table.SUWT00398;
        Col6=SUWT003Table.SUWT003100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Wet Deposition Bin 003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUWT003Table over the selected data range.';
        parastr602=' SUWT003 is related to the Sulfate Wet deposition. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==117)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SUWT004TT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SUWT0450';
        Hdrs{1,5}='SUWT0475';
        Hdrs{1,6}='SUWT0490';
        Hdrs{1,7}='SUWT0495';
        Hdrs{1,8}='SUWT0498';
        Hdrs{1,9}='SUWT04100';
        Col1=SUWT004Table.SUWT00450;
        Col2=SUWT004Table.SUWT00475;
        Col3=SUWT004Table.SUWT00490;
        Col4=SUWT004Table.SUWT00495;
        Col5=SUWT004Table.SUWT00498;
        Col6=SUWT004Table.SUWT004100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Sulfate Wet Deposition Bin 004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SUWT004Table over the selected data range.';
        parastr602=' SUWT003 is related to the Sulfate Wet deposition. ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);





    end
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end