function PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the Seal Salt Table.
% The unit is measuremenetn is frequently changed from kg/m^2/sec to
% femotogm/m^2/sec to make it easier to read the result
% and easier to read result
% 
%
% Written By: Stephen Forczyk
% Created: July 2,2023
% Revised: ----

% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global SSDP00110 SSDP00125 SSDP00150 SSDP00175 SSDP00190 SSDP00195 SSDP00198 SSDP001100;
global SSDP001Low SSDP001High SSDP001NaN SSDP001Values;
global SSDP001Table SSDP001TT;
global SSDP00210 SSDP00225 SSDP00250 SSDP00275 SSDP00290 SSDP00295 SSDP00298 SSDP002100;
global SSDP002Low SSDP002High SSDP002NaN SSDP002Values;
global SSDP002Table SSDP002TT SSDP003Table SSDP003TT SSDP004Table SSDP004TT SSDP005Table SSDP005TT;
global SSEM00110 SSEM00125 SSEM00150 SSEM00175 SSEM00190 SSEM00195 SSEM00198 SSEM001100;
global SSEM001Low SSEM001High SSEM001NaN SSEM001Values;
global SSEM001Table SSEM001TT;
global SSEM00210 SSEM00225 SSEM00250 SSEM00275 SSEM00290 SSEM00295 SSEM00298 SSEM002100;
global SSEM002Low SSEM002High SSEM002NaN SSEM002Values;
global SSEM002Table SSEM002TT;
global SSEM00310 SSEM00325 SSEM00350 SSEM00375 SSEM00390 SSEM00395 SSEM00398 SSEM003100;
global SSEM003Low SSEM003High SSEM003NaN SSEM003Values;
global SSEM003Table SSEM003TT;
global SSEM00410 SSEM00425 SSEM00450 SSEM00475 SSEM00490 SSEM00495 SSEM00498 SSEM004100;
global SSEM004Low SSEM004High SSEM004NaN SSEM004Values;
global SSEM004Table SSEM004TT;
global SSEM00510 SSEM00525 SSEM00550 SSEM00575 SSEM00590 SSEM00595 SSEM00598 SSEM005100;
global SSEM005Low SSEM005High SSEM005NaN SSEM005Values;
global SSEM005Table SSEM005TT;
global SSEXTTFM10 SSEXTTFM25 SSEXTTFM50 SSEXTTFM75 SSEXTTFM90 SSEXTTFM95 SSEXTTFM98 SSEXTTFM100;
global SSEXTTFMLow SSEXTTFMHigh SSEXTTFMNaN SSEXTTFMValues;
global SSEXTTFMTable SSEXTTFMTT;
global SSSCATFM10 SSSCATFM25 SSSCATFM50 SSSCATFM75 SSSCATFM90 SSSCATFM95 SSSCATFM98 SSSCATFM100;
global SSSCATFMLow SSSCATFMHigh SSSCATFMNaN SSSCATFMValues;
global SSSCATFMTable SSSCATFMTT;
global SSSD00110 SSSD00125 SSSD00150 SSSD00175 SSSD00190 SSSD00195 SSSD00198 SSSD001100;
global SSSD001Low SSSD001High SSSD001NaN SSSD001Values;
global SSSD001Table SSSD001TT;
global SSSD00210 SSSD00225 SSSD00250 SSSD00275 SSSD00290 SSSD00295 SSSD00298 SSSD002100;
global SSSD002Low SSSD002High SSSD002NaN SSSD002Values;
global SSSD002Table SSSD002TT;
global SSSD00310 SSSD00325 SSSD00350 SSSD00375 SSSD00390 SSSD00395 SSSD00398 SSSD003100;
global SSSD003Low SSSD003High SSSD003NaN SSSD003Values;
global SSSD003Table SSSD003TT;
global SSSD00410 SSSD00425 SSSD00450 SSSD00475 SSSD00490 SSSD00495 SSSD00498 SSSD004100;
global SSSD004Low SSSD004High SSSD004NaN SSSD004Values;
global SSSD004Table SSSD004TT;
global SSSD00510 SSSD00525 SSSD00550 SSSD00575 SSSD00590 SSSD00595 SSSD00598 SSSD005100;
global SSSD005Low SSSD005High SSSD005NaN SSSD005Values;
global SSSD005Table SSSD005TT;
global SSSV00110 SSSV00125 SSSV00150 SSSV00175 SSSV00190 SSSV00195 SSSV00198 SSSV001100;
global SSSV001Low SSSV001High SSSV001NaN SSSV001Values;
global SSSV001Table SSSV001TT;
global SSSV00210 SSSV00225 SSSV00250 SSSV00275 SSSV00290 SSSV00295 SSSV00298 SSSV002100;
global SSSV002Low SSSV002High SSSV002NaN SSSV002Values;
global SSSV002Table SSSV002TT;
global SSSV00310 SSSV00325 SSSV00350 SSSV00375 SSSV00390 SSSV00395 SSSV00398 SSSV003100;
global SSSV003Low SSSV003High SSSV003NaN SSSV003Values;
global SSSV003Table SSSV003TT;
global SSSV00410 SSSV00425 SSSV00450 SSSV00475 SSSV00490 SSSV00495 SSSV00498 SSSV004100;
global SSSV004Low SSSV004High SSSV004NaN SSSV004Values;
global SSSV004Table SSSV004TT;
global SSSV00510 SSSV00525 SSSV00550 SSSV00575 SSSV00590 SSSV00595 SSSV00598 SSSV005100;
global SSSV005Low SSSV005High SSSV005NaN SSSV005Values;
global SSSV005Table SSSV005TT;
global SSWT00110 SSWT00125 SSWT00150 SSWT00175 SSWT00190 SSWT00195 SSWT00198 SSWT001100;
global SSWT001Low SSWT001High SSWT001NaN SSWT001Values;
global SSWT001Table SSWT001TT;
global SSWT00210 SSWT00225 SSWT00250 SSWT00275 SSWT00290 SSWT00295 SSWT00298 SSWT002100;
global SSWT002Low SSWT002High SSWT002NaN SSWT002Values;
global SSWT002Table SSWT002TT;
global SSWT00310 SSWT00325 SSWT00350 SSWT00375 SSWT00390 SSWT00395 SSWT00398 SSWT003100;
global SSWT003Low SSWT003High SSWT003NaN SSWT003Values;
global SSWT003Table SSWT003TT;
global SSWT00410 SSWT00425 SSWT00450 SSWT00475 SSWT00490 SSWT00495 SSWT00498 SSWT004100;
global SSWT004Low SSWT004High SSWT004NaN SSWT004Values;
global SSWT004Table SSWT004TT;
global SSWT00510 SSWT00525 SSWT00550 SSWT00575 SSWT00590 SSWT00595 SSWT00598 SSWT005100;
global SSWT005Low SSWT005High SSWT005NaN SSWT005Values;
global SSWT005Table SSWT005TT
global SSAERIDXTable SSAERIDXTT;

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
if(ikind==65)
    plot(SSAERIDXTT.Time,SSAERIDXTT.SSAERIDX75,'b',SSAERIDXTT.Time,SSAERIDXTT.SSAERIDX90,'g',...
        SSAERIDXTT.Time,SSAERIDXTT.SSAERIDX95,'k',SSAERIDXTT.Time,SSAERIDXTT.SSAERIDX98,'r');
    hl=legend('SSAERIDX 75 ptile','SSAERIDX 90 ptile','SSAERIDX 95 ptile','SSAERIDX 98 ptile');
    ylabel('SSAERIDX-scalar','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSAERIDX','-Map');
    pdftxtstr=strcat(' SSAERIDX Map For File-',Merra2ShortFileName);
elseif(ikind==66)
    plot(SSDP001TT.Time,SSDP001TT.SSDP00175,'b',SSDP001TT.Time,SSDP001TT.SSDP00190,'g',...
        SSDP001TT.Time,SSDP001TT.SSDP00195,'k',SSDP001TT.Time,SSDP001TT.SSDP00198,'r');
    hl=legend('SSDP001 75 ptile','SSDP001 90 ptile','SSDP001 95 ptile','SSDP001 98 ptile');
    ylabel('SSDP001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSDP001','-Map');
    pdftxtstr=strcat(' SSDP001 Map For File-',Merra2ShortFileName);
elseif(ikind==67)
    plot(SSDP002TT.Time,SSDP002TT.SSDP00275,'b',SSDP002TT.Time,SSDP002TT.SSDP00290,'g',...
        SSDP002TT.Time,SSDP002TT.SSDP00295,'k',SSDP002TT.Time,SSDP002TT.SSDP00298,'r');
    hl=legend('SSDP002 75 ptile','SSDP002 90 ptile','SSDP002 95 ptile','SSDP002 98 ptile');
    ylabel('SSDP002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSDP002','-Map');
    pdftxtstr=strcat(' SSDP002 Map For File-',Merra2ShortFileName);
 elseif(ikind==68)
    plot(SSDP003TT.Time,SSDP003TT.SSDP00375,'b',SSDP003TT.Time,SSDP003TT.SSDP00390,'g',...
        SSDP003TT.Time,SSDP003TT.SSDP00395,'k',SSDP003TT.Time,SSDP003TT.SSDP00398,'r');
    hl=legend('SSDP003 75 ptile','SSDP003 90 ptile','SSDP003 95 ptile','SSDP003 98 ptile');
    ylabel('SSDP003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSDP003','-Map');
    pdftxtstr=strcat(' SSDP003 Map For File-',Merra2ShortFileName);
 elseif(ikind==69)
    plot(SSDP004TT.Time,SSDP004TT.SSDP00475,'b',SSDP004TT.Time,SSDP004TT.SSDP00490,'g',...
        SSDP004TT.Time,SSDP004TT.SSDP00495,'k',SSDP004TT.Time,SSDP004TT.SSDP00498,'r');
    hl=legend('SSDP004 75 ptile','SSDP004 90 ptile','SSDP004 95 ptile','SSDP004 98 ptile');
    ylabel('SSDP004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSDP004','-Map');
    pdftxtstr=strcat(' SSDP004 Map For File-',Merra2ShortFileName);
 elseif(ikind==70)
    plot(SSDP005TT.Time,SSDP005TT.SSDP00575,'b',SSDP005TT.Time,SSDP005TT.SSDP00590,'g',...
        SSDP005TT.Time,SSDP005TT.SSDP00595,'k',SSDP005TT.Time,SSDP005TT.SSDP00598,'r');
    hl=legend('SSDP005 75 ptile','SSDP005 90 ptile','SSDP005 95 ptile','SSDP005 98 ptile');
    ylabel('SSDP005-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSDP005','-Map');
    pdftxtstr=strcat(' SSDP005 Map For File-',Merra2ShortFileName);
 elseif(ikind==71)
    plot(SSEM001TT.Time,SSEM001TT.SSEM00175,'b',SSEM001TT.Time,SSEM001TT.SSEM00190,'g',...
        SSEM001TT.Time,SSEM001TT.SSEM00195,'k',SSEM001TT.Time,SSEM001TT.SSEM00198,'r');
    hl=legend('SSEM001 75 ptile','SSEM001 90 ptile','SSEM001 95 ptile','SSEM001 98 ptile');
    ylabel('SSEM001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSEM001','-Map');
    pdftxtstr=strcat(' SSEM001 Map For File-',Merra2ShortFileName);
 elseif(ikind==72)
    plot(SSEM002TT.Time,SSEM002TT.SSEM00275,'b',SSEM002TT.Time,SSEM002TT.SSEM00290,'g',...
        SSEM002TT.Time,SSEM002TT.SSEM00295,'k',SSEM002TT.Time,SSEM002TT.SSEM00298,'r');
    hl=legend('SSEM002 75 ptile','SSEM002 90 ptile','SSEM002 95 ptile','SSEM002 98 ptile');
    ylabel('SSEM002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSEM002','-Map');
    pdftxtstr=strcat(' SSEM002 Map For File-',Merra2ShortFileName);
 elseif(ikind==73)
    plot(SSEM003TT.Time,SSEM003TT.SSEM00375,'b',SSEM003TT.Time,SSEM003TT.SSEM00390,'g',...
        SSEM003TT.Time,SSEM003TT.SSEM00395,'k',SSEM003TT.Time,SSEM003TT.SSEM00398,'r');
    hl=legend('SSEM003 75 ptile','SSEM003 90 ptile','SSEM003 95 ptile','SSEM003 98 ptile');
    ylabel('SSEM003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSEM003','-Map');
    pdftxtstr=strcat(' SSEM003 Map For File-',Merra2ShortFileName);
 elseif(ikind==74)
    plot(SSEM004TT.Time,SSEM004TT.SSEM00475,'b',SSEM004TT.Time,SSEM004TT.SSEM00490,'g',...
        SSEM004TT.Time,SSEM004TT.SSEM00495,'k',SSEM004TT.Time,SSEM004TT.SSEM00498,'r');
    hl=legend('SSEM004 75 ptile','SSEM004 90 ptile','SSEM004 95 ptile','SSEM004 98 ptile');
    ylabel('SSEM004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSEM004','-Map');
    pdftxtstr=strcat(' SSEM004 Map For File-',Merra2ShortFileName);
 elseif(ikind==75)
    plot(SSEM005TT.Time,SSEM005TT.SSEM00575,'b',SSEM005TT.Time,SSEM005TT.SSEM00590,'g',...
        SSEM005TT.Time,SSEM005TT.SSEM00595,'k',SSEM005TT.Time,SSEM005TT.SSEM00598,'r');
    hl=legend('SSEM005 75 ptile','SSEM005 90 ptile','SSEM005 95 ptile','SSEM005 98 ptile');
    ylabel('SSEM005-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSEM005','-Map');
    pdftxtstr=strcat(' SSEM005 Map For File-',Merra2ShortFileName);
 elseif(ikind==76)
    plot(SSEXTTFMTT.Time,SSEXTTFMTT.SSEXTTFM75,'b',SSEXTTFMTT.Time,SSEXTTFMTT.SSEXTTFM90,'g',...
        SSEXTTFMTT.Time,SSEXTTFMTT.SSEXTTFM95,'k',SSEXTTFMTT.Time,SSEXTTFMTT.SSEXTTFM98,'r');
    hl=legend('SSEXTTFM 75 ptile','SSEXTTFM 90 ptile','SSEXTTFM 95 ptile','SSEXTTFM 98 ptile');
    ylabel('SSEXTTFM-dimensionless','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSEXTTFM','-Map');
    pdftxtstr=strcat(' SSEXTTFM Map For File-',Merra2ShortFileName);
 elseif(ikind==77)
    plot(SSSCATFMTT.Time,SSSCATFMTT.SSSCATFM75,'b',SSSCATFMTT.Time,SSSCATFMTT.SSSCATFM90,'g',...
        SSSCATFMTT.Time,SSSCATFMTT.SSSCATFM95,'k',SSSCATFMTT.Time,SSSCATFMTT.SSSCATFM98,'r');
    hl=legend('SSSCATFM 75 ptile','SSSCATFM 90 ptile','SSSCATFM 95 ptile','SSSCATFM 98 ptile');
    ylabel('SSSCATFM-dimensionless','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSCATFM','-Map');
    pdftxtstr=strcat(' SSSCATFM Map For File-',Merra2ShortFileName);
 elseif(ikind==78)
    plot(SSSD001TT.Time,SSSD001TT.SSSD00175,'b',SSSD001TT.Time,SSSD001TT.SSSD00190,'g',...
        SSSD001TT.Time,SSSD001TT.SSSD00195,'k',SSSD001TT.Time,SSSD001TT.SSSD00198,'r');
    hl=legend('SSSD001 75 ptile','SSSD001 90 ptile','SSSD001 95 ptile','SSSD001 98 ptile');
    ylabel('SSSD001-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSD001','-Map');
    pdftxtstr=strcat(' SSSD001 Map For File-',Merra2ShortFileName);
 elseif(ikind==79)
    plot(SSSD002TT.Time,SSSD002TT.SSSD00275,'b',SSSD002TT.Time,SSSD002TT.SSSD00290,'g',...
        SSSD002TT.Time,SSSD002TT.SSSD00295,'k',SSSD002TT.Time,SSSD002TT.SSSD00298,'r');
    hl=legend('SSSD002 75 ptile','SSSD002 90 ptile','SSSD002 95 ptile','SSSD002 98 ptile');
    ylabel('SSSD002-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSD002','-Map');
    pdftxtstr=strcat(' SSSD002 Map For File-',Merra2ShortFileName);
 elseif(ikind==80)
    plot(SSSD003TT.Time,SSSD003TT.SSSD00375,'b',SSSD003TT.Time,SSSD003TT.SSSD00390,'g',...
        SSSD003TT.Time,SSSD003TT.SSSD00395,'k',SSSD003TT.Time,SSSD003TT.SSSD00398,'r');
    hl=legend('SSSD003 75 ptile','SSSD003 90 ptile','SSSD003 95 ptile','SSSD003 98 ptile');
    ylabel('SSSD003-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSD003','-Map');
    pdftxtstr=strcat(' SSSD003 Map For File-',Merra2ShortFileName);
 elseif(ikind==81)
    plot(SSSD004TT.Time,SSSD004TT.SSSD00475,'b',SSSD004TT.Time,SSSD004TT.SSSD00490,'g',...
        SSSD004TT.Time,SSSD004TT.SSSD00495,'k',SSSD004TT.Time,SSSD004TT.SSSD00498,'r');
    hl=legend('SSSD004 75 ptile','SSSD004 90 ptile','SSSD004 95 ptile','SSSD004 98 ptile');
    ylabel('SSSD004-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSD004','-Map');
    pdftxtstr=strcat(' SSSD004 Map For File-',Merra2ShortFileName);
 elseif(ikind==82)
    plot(SSSD005TT.Time,SSSD005TT.SSSD00575,'b',SSSD005TT.Time,SSSD005TT.SSSD00590,'g',...
        SSSD005TT.Time,SSSD005TT.SSSD00595,'k',SSSD005TT.Time,SSSD005TT.SSSD00598,'r');
    hl=legend('SSSD005 75 ptile','SSSD005 90 ptile','SSSD005 95 ptile','SSSD005 98 ptile');
    ylabel('SSSD005-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSD005','-Map');
    pdftxtstr=strcat(' SSSD005 Map For File-',Merra2ShortFileName);
 elseif(ikind==83)
    plot(SSSV001TT.Time,SSSV001TT.SSSV00175,'b',SSSV001TT.Time,SSSV001TT.SSSV00190,'g',...
        SSSV001TT.Time,SSSV001TT.SSSV00195,'k',SSSV001TT.Time,SSSV001TT.SSSV00198,'r');
    hl=legend('SSSV001 75 ptile','SSSV001 90 ptile','SSSV001 95 ptile','SSSV001 98 ptile');
    ylabel('SSSV001-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSV001','-Map');
    pdftxtstr=strcat(' SSSV001 Map For File-',Merra2ShortFileName);
 elseif(ikind==84)
    plot(SSSV002TT.Time,SSSV002TT.SSSV00275,'b',SSSV002TT.Time,SSSV002TT.SSSV00290,'g',...
        SSSV002TT.Time,SSSV002TT.SSSV00295,'k',SSSV002TT.Time,SSSV002TT.SSSV00298,'r');
    hl=legend('SSSV002 75 ptile','SSSV002 90 ptile','SSSV002 95 ptile','SSSV002 98 ptile');
    ylabel('SSSV002-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSV002','-Map');
    pdftxtstr=strcat(' SSSV002 Map For File-',Merra2ShortFileName);
 elseif(ikind==85)
    plot(SSSV003TT.Time,SSSV003TT.SSSV00375,'b',SSSV003TT.Time,SSSV003TT.SSSV00390,'g',...
        SSSV003TT.Time,SSSV003TT.SSSV00395,'k',SSSV003TT.Time,SSSV003TT.SSSV00398,'r');
    hl=legend('SSSV003 75 ptile','SSSV003 90 ptile','SSSV003 95 ptile','SSSV003 98 ptile');
    ylabel('SSSV003-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSV003','-Map');
    pdftxtstr=strcat(' SSSV003 Map For File-',Merra2ShortFileName);
 elseif(ikind==86)
    plot(SSSV004TT.Time,SSSV004TT.SSSV00475,'b',SSSV004TT.Time,SSSV004TT.SSSV00490,'g',...
        SSSV004TT.Time,SSSV004TT.SSSV00495,'k',SSSV004TT.Time,SSSV004TT.SSSV00498,'r');
    hl=legend('SSSV004 75 ptile','SSSV004 90 ptile','SSSV004 95 ptile','SSSV004 98 ptile');
    ylabel('SSSV004-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSV004','-Map');
    pdftxtstr=strcat(' SSSV004 Map For File-',Merra2ShortFileName);
 elseif(ikind==87)
    plot(SSSV005TT.Time,SSSV005TT.SSSV00575,'b',SSSV005TT.Time,SSSV005TT.SSSV00590,'g',...
        SSSV005TT.Time,SSSV005TT.SSSV00595,'k',SSSV005TT.Time,SSSV005TT.SSSV00598,'r');
    hl=legend('SSSV005 75 ptile','SSSV005 90 ptile','SSSV005 95 ptile','SSSV005 98 ptile');
    ylabel('SSSV005-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSSV005','-Map');
    pdftxtstr=strcat(' SSSV005 Map For File-',Merra2ShortFileName);
elseif(ikind==88)
    plot(SSWT001TT.Time,SSWT001TT.SSWT00175,'b',SSWT001TT.Time,SSWT001TT.SSWT00190,'g',...
        SSWT001TT.Time,SSWT001TT.SSWT00195,'k',SSWT001TT.Time,SSWT001TT.SSWT00198,'r');
    hl=legend('SSWT001 75 ptile','SSWT001 90 ptile','SSWT001 95 ptile','SSWT001 98 ptile');
    ylabel('SSWT001-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSWT001','-Map');
    pdftxtstr=strcat(' SSWT001 Map For File-',Merra2ShortFileName);
elseif(ikind==89)
    plot(SSWT002TT.Time,SSWT002TT.SSWT00275,'b',SSWT002TT.Time,SSWT002TT.SSWT00290,'g',...
        SSWT002TT.Time,SSWT002TT.SSWT00295,'k',SSWT002TT.Time,SSWT002TT.SSWT00298,'r');
    hl=legend('SSWT002 75 ptile','SSWT002 90 ptile','SSWT002 95 ptile','SSWT002 98 ptile');
    ylabel('SSWT002-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSWT002','-Map');
    pdftxtstr=strcat(' SSWT002 Map For File-',Merra2ShortFileName);
elseif(ikind==90)
    plot(SSWT003TT.Time,SSWT003TT.SSWT00375,'b',SSWT003TT.Time,SSWT003TT.SSWT00390,'g',...
        SSWT003TT.Time,SSWT003TT.SSWT00395,'k',SSWT003TT.Time,SSWT003TT.SSWT00398,'r');
    hl=legend('SSWT003 75 ptile','SSWT003 90 ptile','SSWT003 95 ptile','SSWT003 98 ptile');
    ylabel('SSWT003-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSWT003','-Map');
    pdftxtstr=strcat(' SSWT003 Map For File-',Merra2ShortFileName);
elseif(ikind==91)
    plot(SSWT004TT.Time,SSWT004TT.SSWT00475,'b',SSWT004TT.Time,SSWT004TT.SSWT00490,'g',...
        SSWT004TT.Time,SSWT004TT.SSWT00495,'k',SSWT004TT.Time,SSWT004TT.SSWT00498,'r');
    hl=legend('SSWT004 75 ptile','SSWT004 90 ptile','SSWT004 95 ptile','SSWT004 98 ptile');
    ylabel('SSWT004-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSWT004','-Map');
    pdftxtstr=strcat(' SSWT004 Map For File-',Merra2ShortFileName);
elseif(ikind==92)
    plot(SSWT005TT.Time,SSWT005TT.SSWT00575,'b',SSWT005TT.Time,SSWT005TT.SSWT00590,'g',...
        SSWT005TT.Time,SSWT005TT.SSWT00595,'k',SSWT005TT.Time,SSWT005TT.SSWT00598,'r');
    hl=legend('SSWT005 75 ptile','SSWT005 90 ptile','SSWT005 95 ptile','SSWT005 98 ptile');
    ylabel('SSWT005-nanogm/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSWT005','-Map');
    pdftxtstr=strcat(' SSWT005 Map For File-',Merra2ShortFileName);

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
    if(ikind==65)
        parastr2='This metric is the value of the aerosol UV TOMS index.';
        parastr3=' The expected data is between 0 tand 5.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==66)
        parastr2='This metric is the value of the Sea Salt Dry Deposition Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==67)
        parastr2='This metric is the value of the Sea Salt Dry Deposition Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==68)
        parastr2='This metric is the value of the Sea Salt Dry Deposition Bin 003.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==69)
        parastr2='This metric is the value of the Sea Salt Dry Deposition Bin 004.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==70)
        parastr2='This metric is the value of the Sea Salt Dry Deposition Bin 005.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==71)
        parastr2='This metric is the value of the Sea Salt Emission Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==72)
        parastr2='This metric is the value of the Sea Salt Emission Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==73)
        parastr2='This metric is the value of the Sea Salt Emission Bin 003.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==74)
        parastr2='This metric is the value of the Sea Salt Emission Bin 004.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==75)
        parastr2='This metric is the value of the Sea Salt Emission Bin 005.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==76)
        parastr2='This metric is the value of the Sea Salt Extinction at .55 microns.';
        parastr3=' The expected data is ranges from 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==77)
        parastr2='This metric is the value of the Sea Salt Scattering at .55 microns.';
        parastr3=' The expected data is ranges fom 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==78)
        parastr2='This metric is the value of the Sea Salt Sedimmentation Bin 01.';
        parastr3=' The expected data is ranges fom 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==79)
        parastr2='This metric is the value of the Sea Salt Sedimmentation Bin 02.';
        parastr3=' The expected data is ranges fom 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==80)
        parastr2='This metric is the value of the Sea Salt Sedimmentation Bin 03.';
        parastr3=' The expected data is ranges fom 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==81)
        parastr2='This metric is the value of the Sea Salt Sedimmentation Bin 04.';
        parastr3=' The expected data is ranges fom 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==82)
        parastr2='This metric is the value of the Sea Salt Sedimmentation Bin 05.';
        parastr3=' The expected data is ranges fom 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==83)
        parastr2='This metric is the value of the Sea Salt Convective Scavenging Bin 01.';
        parastr3=' The expected data is ranges from 0 to nanograms/m^2/sec.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==84)
        parastr2='This metric is the value of the Sea Salt Convective Scavenging Bin 02.';
        parastr3=' The expected data is ranges from 0 to nanograms/m^2/sec.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==85)
        parastr2='This metric is the value of the Sea Salt Convective Scavenging Bin 03.';
        parastr3=' The expected data is ranges from 0 to nanograms/m^2/sec.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==86)
        parastr2='This metric is the value of the Sea Salt Convective Scavenging Bin 04.';
        parastr3=' The expected data is ranges from 0 to nanograms/m^2/sec.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==87)
        parastr2='This metric is the value of the Sea Salt Convective Scavenging Bin 05.';
        parastr3=' The expected data is ranges from 0 to nanograms/m^2/sec.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==88)
        parastr2='This metric is the value of the Sea Salt Wet Deposition Bin 01.';
        parastr3=' Wet deposition is the process where aerosols are removed by precipitation.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==89)
        parastr2='This metric is the value of the Sea Salt Wet Deposition Bin 02.';
        parastr3=' Wet deposition is the process where aerosols are removed by precipitation.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==90)
        parastr2='This metric is the value of the Sea Salt Wet Deposition Bin 03.';
        parastr3=' Wet deposition is the process where aerosols are removed by precipitation.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==91)
        parastr2='This metric is the value of the Sea Salt Wet Deposition Bin 04.';
        parastr3=' Wet deposition is the process where aerosols are removed by precipitation.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    elseif(ikind==92)
        parastr2='This metric is the value of the Sea Salt Wet Deposition Bin 05.';
        parastr3=' Wet deposition is the process where aerosols are removed by precipitation.';
        parastr4=' This process is the capture of aerosols by water droplets or ice crystals.';
        parastr5=' This leads to wet deposition';
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
     if(ikind==65)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSAERIDXTT.Properties.RowTimes);
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
        Hdrs{1,4}='SAER50';
        Hdrs{1,5}='SAER75';
        Hdrs{1,6}='SAER90';
        Hdrs{1,7}='SAER95';
        Hdrs{1,8}='SAER98';
        Hdrs{1,9}='SAER100';
        Col1=SSAERIDXTable.SSAERIDX50;
        Col2=SSAERIDXTable.SSAERIDX75;
        Col3=SSAERIDXTable.SSAERIDX90;
        Col4=SSAERIDXTable.SSAERIDX95;
        Col5=SSAERIDXTable.SSAERIDX98;
        Col6=SSAERIDXTable.SSAERIDX100;
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
            NumberFormat("%3.2f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On SeaSalt UV TOMS Index For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSAERIDXTable over the selected data range.';
        parastr602=' SSAER is the Sea Salt UV TOMS Index-higher numbers mean a more dense aerosol';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==66)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSDP001TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSDP50';
        Hdrs{1,5}='SSDP75';
        Hdrs{1,6}='SSDP90';
        Hdrs{1,7}='SSDP95';
        Hdrs{1,8}='SSDP98';
        Hdrs{1,9}='SSDP100';
        Col1=SSDP001Table.SSDP00150;
        Col2=SSDP001Table.SSDP00175;
        Col3=SSDP001Table.SSDP00190;
        Col4=SSDP001Table.SSDP00195;
        Col5=SSDP001Table.SSDP00198;
        Col6=SSDP001Table.SSDP001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On SeaSalt Dry Deposiition Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSDP001Table over the selected data range.';
        parastr602=' SSDP is the Sea Salt Dry Deposition ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
    elseif(ikind==67)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSDP002TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSDP50';
        Hdrs{1,5}='SSDP75';
        Hdrs{1,6}='SSDP90';
        Hdrs{1,7}='SSDP95';
        Hdrs{1,8}='SSDP98';
        Hdrs{1,9}='SSDP100';
        Col1=SSDP002Table.SSDP00250;
        Col2=SSDP002Table.SSDP00275;
        Col3=SSDP002Table.SSDP00290;
        Col4=SSDP002Table.SSDP00295;
        Col5=SSDP002Table.SSDP00298;
        Col6=SSDP002Table.SSDP002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On SeaSalt Dry Deposiition Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSDP002Table over the selected data range.';
        parastr602=' SSDP is the Sea Salt Dry Deposition ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==68)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSDP003TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSDP50';
        Hdrs{1,5}='SSDP75';
        Hdrs{1,6}='SSDP90';
        Hdrs{1,7}='SSDP95';
        Hdrs{1,8}='SSDP98';
        Hdrs{1,9}='SSDP100';
        Col1=SSDP003Table.SSDP00350;
        Col2=SSDP003Table.SSDP00375;
        Col3=SSDP003Table.SSDP00390;
        Col4=SSDP003Table.SSDP00395;
        Col5=SSDP003Table.SSDP00398;
        Col6=SSDP003Table.SSDP003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On SeaSalt Dry Deposiition Bin 003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSDP003Table over the selected data range.';
        parastr602=' SSDP is the Sea Salt Dry Deposition ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==69)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSDP004TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSDP50';
        Hdrs{1,5}='SSDP75';
        Hdrs{1,6}='SSDP90';
        Hdrs{1,7}='SSDP95';
        Hdrs{1,8}='SSDP98';
        Hdrs{1,9}='SSDP100';
        Col1=SSDP004Table.SSDP00450;
        Col2=SSDP004Table.SSDP00475;
        Col3=SSDP004Table.SSDP00490;
        Col4=SSDP004Table.SSDP00495;
        Col5=SSDP004Table.SSDP00498;
        Col6=SSDP004Table.SSDP004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On SeaSalt Dry Deposiition Bin 004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSDP004Table over the selected data range.';
        parastr602=' SSDP is the Sea Salt Dry Deposition ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==70)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSDP005TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSDP50';
        Hdrs{1,5}='SSDP75';
        Hdrs{1,6}='SSDP90';
        Hdrs{1,7}='SSDP95';
        Hdrs{1,8}='SSDP98';
        Hdrs{1,9}='SSDP100';
        Col1=SSDP005Table.SSDP00550;
        Col2=SSDP005Table.SSDP00575;
        Col3=SSDP005Table.SSDP00590;
        Col4=SSDP005Table.SSDP00595;
        Col5=SSDP005Table.SSDP00598;
        Col6=SSDP005Table.SSDP005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On SeaSalt Dry Deposiition Bin 005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSDP005Table over the selected data range.';
        parastr602=' SSDP is the Sea Salt Dry Deposition ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==71)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSEM001TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSEM50';
        Hdrs{1,5}='SSEM75';
        Hdrs{1,6}='SSEM90';
        Hdrs{1,7}='SSEM95';
        Hdrs{1,8}='SSEM98';
        Hdrs{1,9}='SSEM100';
        Col1=SSEM001Table.SSEM00150;
        Col2=SSEM001Table.SSEM00175;
        Col3=SSEM001Table.SSEM00190;
        Col4=SSEM001Table.SSEM00195;
        Col5=SSEM001Table.SSEM00198;
        Col6=SSEM001Table.SSEM001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Emission Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSEM001Table over the selected data range.';
        parastr602=' SSEM is the Sea Salt Emission ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==72)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSEM002TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSEM50';
        Hdrs{1,5}='SSEM75';
        Hdrs{1,6}='SSEM90';
        Hdrs{1,7}='SSEM95';
        Hdrs{1,8}='SSEM98';
        Hdrs{1,9}='SSEM100';
        Col1=SSEM002Table.SSEM00250;
        Col2=SSEM002Table.SSEM00275;
        Col3=SSEM002Table.SSEM00290;
        Col4=SSEM002Table.SSEM00295;
        Col5=SSEM002Table.SSEM00298;
        Col6=SSEM002Table.SSEM002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Emission Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSEM002Table over the selected data range.';
        parastr602=' SSEM is the Sea Salt Emission ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==73)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSEM003TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSEM50';
        Hdrs{1,5}='SSEM75';
        Hdrs{1,6}='SSEM90';
        Hdrs{1,7}='SSEM95';
        Hdrs{1,8}='SSEM98';
        Hdrs{1,9}='SSEM100';
        Col1=SSEM003Table.SSEM00350;
        Col2=SSEM003Table.SSEM00375;
        Col3=SSEM003Table.SSEM00390;
        Col4=SSEM003Table.SSEM00395;
        Col5=SSEM003Table.SSEM00398;
        Col6=SSEM003Table.SSEM003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Emission Bin 003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSEM003Table over the selected data range.';
        parastr602=' SSEM is the Sea Salt Emission ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==74)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSEM004TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSEM50';
        Hdrs{1,5}='SSEM75';
        Hdrs{1,6}='SSEM90';
        Hdrs{1,7}='SSEM95';
        Hdrs{1,8}='SSEM98';
        Hdrs{1,9}='SSEM100';
        Col1=SSEM004Table.SSEM00450;
        Col2=SSEM004Table.SSEM00475;
        Col3=SSEM004Table.SSEM00490;
        Col4=SSEM004Table.SSEM00495;
        Col5=SSEM004Table.SSEM00498;
        Col6=SSEM004Table.SSEM004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Emission Bin 004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSEM004Table over the selected data range.';
        parastr602=' SSEM is the Sea Salt Emission ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==75)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSEM005TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSEM50';
        Hdrs{1,5}='SSEM75';
        Hdrs{1,6}='SSEM90';
        Hdrs{1,7}='SSEM95';
        Hdrs{1,8}='SSEM98';
        Hdrs{1,9}='SSEM100';
        Col1=SSEM005Table.SSEM00550;
        Col2=SSEM005Table.SSEM00575;
        Col3=SSEM005Table.SSEM00590;
        Col4=SSEM005Table.SSEM00595;
        Col5=SSEM005Table.SSEM00598;
        Col6=SSEM005Table.SSEM005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Emission Bin 005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSEM005Table over the selected data range.';
        parastr602=' SSEM is the Sea Salt Emission ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==76)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSEXTTFMTT.Properties.RowTimes);
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
        Hdrs{1,4}='STFM50';
        Hdrs{1,5}='STFM75';
        Hdrs{1,6}='STFM90';
        Hdrs{1,7}='STFM95';
        Hdrs{1,8}='STFM98';
        Hdrs{1,9}='STFM100';
        Col1=SSEXTTFMTable.SSEXTTFM50;
        Col2=SSEXTTFMTable.SSEXTTFM75;
        Col3=SSEXTTFMTable.SSEXTTFM90;
        Col4=SSEXTTFMTable.SSEXTTFM95;
        Col5=SSEXTTFMTable.SSEXTTFM98;
        Col6=SSEXTTFMTable.SSEXTTFM100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Extinction For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSEXTTFMTable over the selected data range.';
        parastr602=' SSEXTTFM is the Sea Salt Extinction at .55 microns ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==77)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSCATFMTT.Properties.RowTimes);
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
        Hdrs{1,4}='SSCAT50';
        Hdrs{1,5}='SSSCAT75';
        Hdrs{1,6}='SSSCAT90';
        Hdrs{1,7}='SSSCAT95';
        Hdrs{1,8}='SSSCAT98';
        Hdrs{1,9}='SSSCAT100';
        Col1=SSSCATFMTable.SSSCATFM50;
        Col2=SSSCATFMTable.SSSCATFM75;
        Col3=SSSCATFMTable.SSSCATFM90;
        Col4=SSSCATFMTable.SSSCATFM95;
        Col5=SSSCATFMTable.SSSCATFM98;
        Col6=SSSCATFMTable.SSSCATFM100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Scattering For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSCATFMTable over the selected data range.';
        parastr602=' SSSCAT is the Sea Salt scattering at .55 microns ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==78)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSD001TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSD0150';
        Hdrs{1,5}='SSD0175';
        Hdrs{1,6}='SSD0190';
        Hdrs{1,7}='SSD0195';
        Hdrs{1,8}='SSD0198';
        Hdrs{1,9}='SSD01100';
        Col1=SSSD001Table.SSSD00150;
        Col2=SSSD001Table.SSSD00175;
        Col3=SSSD001Table.SSSD00190;
        Col4=SSSD001Table.SSSD00195;
        Col5=SSSD001Table.SSSD00198;
        Col6=SSSD001Table.SSSD001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Sedimentation Bin 01 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSD001Table over the selected data range.';
        parastr602=' SSSD001 is the Sea Salt sedimentation Bin 01 . ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==79)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSD002TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSD0250';
        Hdrs{1,5}='SSD0275';
        Hdrs{1,6}='SSD0290';
        Hdrs{1,7}='SSD0295';
        Hdrs{1,8}='SSD0298';
        Hdrs{1,9}='SSD02100';
        Col1=SSSD002Table.SSSD00250;
        Col2=SSSD002Table.SSSD00275;
        Col3=SSSD002Table.SSSD00290;
        Col4=SSSD002Table.SSSD00295;
        Col5=SSSD002Table.SSSD00298;
        Col6=SSSD002Table.SSSD002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Sedimentation Bin 02 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSD002Table over the selected data range.';
        parastr602=' SSSD002 is the Sea Salt sedimentation Bin 02 . ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==80)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSD003TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSD0350';
        Hdrs{1,5}='SSD0375';
        Hdrs{1,6}='SSD0390';
        Hdrs{1,7}='SSD0395';
        Hdrs{1,8}='SSD0398';
        Hdrs{1,9}='SSD03100';
        Col1=SSSD003Table.SSSD00350;
        Col2=SSSD003Table.SSSD00375;
        Col3=SSSD003Table.SSSD00390;
        Col4=SSSD003Table.SSSD00395;
        Col5=SSSD003Table.SSSD00398;
        Col6=SSSD003Table.SSSD003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Sedimentation Bin 03 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSD003Table over the selected data range.';
        parastr602=' SSSD003 is the Sea Salt sedimentation Bin 03 . ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==81)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSD004TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSD0450';
        Hdrs{1,5}='SSD0475';
        Hdrs{1,6}='SSD0490';
        Hdrs{1,7}='SSD0495';
        Hdrs{1,8}='SSD0498';
        Hdrs{1,9}='SSD04100';
        Col1=SSSD004Table.SSSD00450;
        Col2=SSSD004Table.SSSD00475;
        Col3=SSSD004Table.SSSD00490;
        Col4=SSSD004Table.SSSD00495;
        Col5=SSSD004Table.SSSD00498;
        Col6=SSSD004Table.SSSD004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Sedimentation Bin 04 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSD004Table over the selected data range.';
        parastr602=' SSSD004 is the Sea Salt sedimentation Bin 04 . ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==82)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSD005TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSD0550';
        Hdrs{1,5}='SSD0575';
        Hdrs{1,6}='SSD0590';
        Hdrs{1,7}='SSD0595';
        Hdrs{1,8}='SSD0598';
        Hdrs{1,9}='SSD05100';
        Col1=SSSD005Table.SSSD00550;
        Col2=SSSD005Table.SSSD00575;
        Col3=SSSD005Table.SSSD00590;
        Col4=SSSD005Table.SSSD00595;
        Col5=SSSD005Table.SSSD00598;
        Col6=SSSD005Table.SSSD005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Sedimentation Bin 05 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSD005Table over the selected data range.';
        parastr602=' SSSD005 is the Sea Salt sedimentation Bin 05 . ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==83)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSV001TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSV0150';
        Hdrs{1,5}='SSV0175';
        Hdrs{1,6}='SSV0190';
        Hdrs{1,7}='SSV0195';
        Hdrs{1,8}='SSV0198';
        Hdrs{1,9}='SSV01100';
        Col1=SSSV001Table.SSSV00150;
        Col2=SSSV001Table.SSSV00175;
        Col3=SSSV001Table.SSSV00190;
        Col4=SSSV001Table.SSSV00195;
        Col5=SSSV001Table.SSSV00198;
        Col6=SSSV001Table.SSSV001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Scavenging Bin 01 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSV001Table over the selected data range.';
        parastr602=' SSSV001 is the Sea Salt convective scavenging by water droplets in Bin size 001. ';
        parastr603=' This results in wet sediment deposition .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==84)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSV002TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSV0250';
        Hdrs{1,5}='SSV0275';
        Hdrs{1,6}='SSV0290';
        Hdrs{1,7}='SSV0295';
        Hdrs{1,8}='SSV0298';
        Hdrs{1,9}='SSV02100';
        Col1=SSSV002Table.SSSV00250;
        Col2=SSSV002Table.SSSV00275;
        Col3=SSSV002Table.SSSV00290;
        Col4=SSSV002Table.SSSV00295;
        Col5=SSSV002Table.SSSV00298;
        Col6=SSSV002Table.SSSV002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Scavenging Bin 02 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSV002Table over the selected data range.';
        parastr602=' SSSV002 is the Sea Salt convective scavenging by water droplets in Bin size 002. ';
        parastr603=' This results in wet sediment deposition .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==85)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSV003TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSV0350';
        Hdrs{1,5}='SSV0375';
        Hdrs{1,6}='SSV0390';
        Hdrs{1,7}='SSV0395';
        Hdrs{1,8}='SSV0398';
        Hdrs{1,9}='SSV03100';
        Col1=SSSV003Table.SSSV00350;
        Col2=SSSV003Table.SSSV00375;
        Col3=SSSV003Table.SSSV00390;
        Col4=SSSV003Table.SSSV00395;
        Col5=SSSV003Table.SSSV00398;
        Col6=SSSV003Table.SSSV003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Scavenging Bin 03 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSV003Table over the selected data range.';
        parastr602=' SSSV003 is the Sea Salt convective scavenging by water droplets in Bin size 003. ';
        parastr603=' This results in wet sediment deposition .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==86)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSV004TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSV0450';
        Hdrs{1,5}='SSV0475';
        Hdrs{1,6}='SSV0490';
        Hdrs{1,7}='SSV0495';
        Hdrs{1,8}='SSV0498';
        Hdrs{1,9}='SSV04100';
        Col1=SSSV004Table.SSSV00450;
        Col2=SSSV004Table.SSSV00475;
        Col3=SSSV004Table.SSSV00490;
        Col4=SSSV004Table.SSSV00495;
        Col5=SSSV004Table.SSSV00498;
        Col6=SSSV004Table.SSSV004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Scavenging Bin 04 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSV004Table over the selected data range.';
        parastr602=' SSSV004 is the Sea Salt convective scavenging by water droplets in Bin size 004. ';
        parastr603=' This results in wet sediment deposition .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==87)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSSV005TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSV0550';
        Hdrs{1,5}='SSV0575';
        Hdrs{1,6}='SSV0590';
        Hdrs{1,7}='SSV0595';
        Hdrs{1,8}='SSV0598';
        Hdrs{1,9}='SSV05100';
        Col1=SSSV005Table.SSSV00550;
        Col2=SSSV005Table.SSSV00575;
        Col3=SSSV005Table.SSSV00590;
        Col4=SSSV005Table.SSSV00595;
        Col5=SSSV005Table.SSSV00598;
        Col6=SSSV005Table.SSSV005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Scavenging Bin 05 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSSV005Table over the selected data range.';
        parastr602=' SSSV005 is the Sea Salt convective scavenging by water droplets in Bin size 005. ';
        parastr603=' This results in wet sediment deposition .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==88)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSWT001TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSWT0150';
        Hdrs{1,5}='SSWT0175';
        Hdrs{1,6}='SSWT0190';
        Hdrs{1,7}='SSWT0195';
        Hdrs{1,8}='SSWT0198';
        Hdrs{1,9}='SSWT01100';
        Col1=SSWT001Table.SSWT00150;
        Col2=SSWT001Table.SSWT00175;
        Col3=SSWT001Table.SSWT00190;
        Col4=SSWT001Table.SSWT00195;
        Col5=SSWT001Table.SSWT00198;
        Col6=SSWT001Table.SSWT001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Wet Deposition Bin 01 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSWT001Table over the selected data range.';
        parastr602=' SSWT001 is the Sea Salt Wet Deposition is  process where aerosols are removed by preicipitation. ';
        parastr603=' This results in wet sediment deposition this is for Bin 01 .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==89)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSWT002TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSWT0250';
        Hdrs{1,5}='SSWT0275';
        Hdrs{1,6}='SSWT0290';
        Hdrs{1,7}='SSWT0295';
        Hdrs{1,8}='SSWT0298';
        Hdrs{1,9}='SSWT02100';
        Col1=SSWT002Table.SSWT00250;
        Col2=SSWT002Table.SSWT00275;
        Col3=SSWT002Table.SSWT00290;
        Col4=SSWT002Table.SSWT00295;
        Col5=SSWT002Table.SSWT00298;
        Col6=SSWT002Table.SSWT002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Wet Deposition Bin 02 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSWT002Table over the selected data range.';
        parastr602=' SSWT002 is the Sea Salt Wet Deposition is  process where aerosols are removed by preicipitation. ';
        parastr603=' This results in wet sediment deposition this is for Bin 02 .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==90)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSWT003TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSWT0350';
        Hdrs{1,5}='SSWT0375';
        Hdrs{1,6}='SSWT0390';
        Hdrs{1,7}='SSWT0395';
        Hdrs{1,8}='SSWT0398';
        Hdrs{1,9}='SSWT03100';
        Col1=SSWT003Table.SSWT00350;
        Col2=SSWT003Table.SSWT00375;
        Col3=SSWT003Table.SSWT00390;
        Col4=SSWT003Table.SSWT00395;
        Col5=SSWT003Table.SSWT00398;
        Col6=SSWT003Table.SSWT003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Wet Deposition Bin 03 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSWT003Table over the selected data range.';
        parastr602=' SSWT003 is the Sea Salt Wet Deposition is  process where aerosols are removed by preicipitation. ';
        parastr603=' This results in wet sediment deposition this is for Bin 03 .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==91)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSWT004TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSWT0450';
        Hdrs{1,5}='SSWT0475';
        Hdrs{1,6}='SSWT0490';
        Hdrs{1,7}='SSWT0495';
        Hdrs{1,8}='SSWT0498';
        Hdrs{1,9}='SSWT04100';
        Col1=SSWT004Table.SSWT00450;
        Col2=SSWT004Table.SSWT00475;
        Col3=SSWT004Table.SSWT00490;
        Col4=SSWT004Table.SSWT00495;
        Col5=SSWT004Table.SSWT00498;
        Col6=SSWT004Table.SSWT004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Wet Deposition Bin 04 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSWT004Table over the selected data range.';
        parastr602=' SSWT004 is the Sea Salt Wet Deposition is  process where aerosols are removed by preicipitation. ';
        parastr603=' This results in wet sediment deposition this is for Bin 04 .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==92)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSWT005TT.Properties.RowTimes);
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
        Hdrs{1,4}='SSWT0550';
        Hdrs{1,5}='SSWT0575';
        Hdrs{1,6}='SSWT0590';
        Hdrs{1,7}='SSWT0595';
        Hdrs{1,8}='SSWT0598';
        Hdrs{1,9}='SSWT05100';
        Col1=SSWT005Table.SSWT00550;
        Col2=SSWT005Table.SSWT00575;
        Col3=SSWT005Table.SSWT00590;
        Col4=SSWT005Table.SSWT00595;
        Col5=SSWT005Table.SSWT00598;
        Col6=SSWT005Table.SSWT005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Sea Salt Wet Deposition Bin 05 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the SSWT005Table over the selected data range.';
        parastr602=' SSWT005 is the Sea Salt Wet Deposition is  process where aerosols are removed by preicipitation. ';
        parastr603=' This results in wet sediment deposition this is for Bin 05 .';
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
close('all')
end