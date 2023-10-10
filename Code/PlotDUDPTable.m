function PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the Dust data results.
% Is the Black Dry Dust Deposition density in kg/m2/sec * 1E-15 to produce a
% and easier to read result
% 
%
% Written By: Stephen Forczyk
% Created: June 15,2023
% Revised: Jun 20,2023 added formatted tables output to pdf
% Revised: Jun 21,2023 added formatted tables output to pdf
% Revised: Jun 23-24 2023 added more dust variables 21 thru 27
% Revised: Jul 13,2024 added data from DUSV001 thru DUSV005

% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global DUAERIDXTable DUAERIDXTT;
global DUDP001S DUDP002S DUDP003S DUDP004S DUDP005S;
global DUDP00110 DUDP00125 DUDP00150 DUDP00175 DUDP00190 DUDP001100;
global DUDP001Low DUDP001High DUDP001NaN DUDP001Values;
global DUDP001Table DUDP001TT;
global DUDP00210 DUDP00225 DUDP00250 DUDP00275 DUDP00290 DUDP002100;
global DUDP002Low DUDP002High DUDP002NaN DUDP002Values;
global DUDP002Table DUDP002TT
global DUDP00310 DUDP00325 DUDP00350 DUDP00375 DUDP00390 DUDP003100;
global DUDP003Low DUDP003High DUDP003NaN DUDP003Values;
global DUDP003Table DUDP003TT;
global DUDP00410 DUDP00425 DUDP00450 DUDP00475 DUDP00490 DUDP004100;
global DUDP004Low DUDP004High DUDP004NaN DUDP004Values;
global DUDP004Table DUDP004TT;
global DUDP00510 DUDP00525 DUDP00550 DUDP00575 DUDP00590 DUDP005100;
global DUDP005Low DUDP005High DUDP005NaN DUDP005Values;
global DUDP005Table DUDP005TT;
global DUEM001S ;
global DUEM00110 DUEM00125 DUEM00150 DUEM00175 DUEM00190 DUEM001100;
global DUEM001Low DUEM001High DUEM001NaN DUEM001Values;
global DUEM001Table DUEM001TT DUEM002Table DUEM002TT;
global DUEM00510 DUEM00525 DUEM00550 DUEM00575 DUEM00590 DUEM005100;
global DUEM005Low DUEM005High DUEM005NaN DUEM005Values;
global DUEM003Table DUEM003TT DUEM004Table DUEM004TT;
global DUEM005Table DUEM005TT;
global DUEXTTFMS DUSCATFMS;
global DUEXT10 DUEXT25 DUEXT50 DUEXT75 DUEXT90 DUEXT100;
global DUEXTLow DUEXTHigh DUEXTNaN DUEXTValues;
global DUEXTable DUEXTT;
global DUSCAT10 DUSCAT25 DUSCAT50 DUSCAT75 DUSCAT90 DUSCAT100;
global DUSCATLow DUSCATHigh DUSCATNaN DUSCATValues;
global DUSCATTable DUSCATTT;
global DUSD00110 DUSD00125 DUSD00150 DUSD00175 DUSD00190 DUSD00195 DUSD00198 DUSD001100;
global DUSD001Low DUSD001High DUSD001NaN DUSD001Values;
global DUSD001Table DUSD001TT DUSD002Table DUSD002TT DUSD003Table DUSD003TT;
global DUSD004Table DUSD004TT DUSD005Table DUSD005TT;
global DUSV001Table DUSV001TT DUSV002Table DUSV002TT DUSV003Table DUSV003TT;
global DUSV004Table DUSV004TT DUSV005Table DUSV005TT;
global DUWT00110 DUWT00125 DUWT00150 DUWT00175 DUWT00190 DUWT00195 DUWT00198 DUWT001100;
global DUWT001Low DUWT001High DUWT001NaN DUWT001Values;
global DUWT001Table DUWT001TT DUWT002Table DUWT002TT DUWT003Table DUWT003TT;
global DUWT004Table DUWT004TT DUWT005Table DUWT005TT;
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
if(ikind==15)
    plot(DUAERIDXTT.Time,DUAERIDXTT.DUAERIDX75,'b',DUAERIDXTT.Time,DUAERIDXTT.DUAERIDX90,'g',...
        DUAERIDXTT.Time,DUAERIDXTT.DUAERIDX95,'k',DUAERIDXTT.Time,DUAERIDXTT.DUAERIDX98,'r');    
elseif(ikind==16)
    plot(DUDP001TT.Time,DUDP001TT.DUDP00125,'b',DUDP001TT.Time,DUDP001TT.DUDP00150,'g',...
        DUDP001TT.Time,DUDP001TT.DUDP00175,'k',DUDP001TT.Time,DUDP001TT.DUDP00190,'r');
    hl=legend('DUDP001 25 ptile','DUDP001 50 ptile','DUDP001 75 ptile','DUDP001 90 ptile');
    ylabel('DUDP001-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('DUDP001','-Map');
    pdftxtstr=strcat(' DUDP001 Map For File-',Merra2ShortFileName);
elseif(ikind==17)
    plot(DUDP002TT.Time,DUDP002TT.DUDP00225,'b',DUDP002TT.Time,DUDP002TT.DUDP00250,'g',...
        DUDP002TT.Time,DUDP002TT.DUDP00275,'k',DUDP002TT.Time,DUDP002TT.DUDP00290,'r');
elseif(ikind==18)
    plot(DUDP003TT.Time,DUDP003TT.DUDP00325,'b',DUDP003TT.Time,DUDP003TT.DUDP00350,'g',...
        DUDP003TT.Time,DUDP003TT.DUDP00375,'k',DUDP003TT.Time,DUDP003TT.DUDP00390,'r');
elseif(ikind==19)
    plot(DUDP004TT.Time,DUDP004TT.DUDP00425,'b',DUDP004TT.Time,DUDP004TT.DUDP00450,'g',...
        DUDP004TT.Time,DUDP004TT.DUDP00475,'k',DUDP004TT.Time,DUDP004TT.DUDP00490,'r');
elseif(ikind==20)
    plot(DUDP005TT.Time,DUDP005TT.DUDP00525,'b',DUDP005TT.Time,DUDP005TT.DUDP00550,'g',...
        DUDP005TT.Time,DUDP005TT.DUDP00575,'k',DUDP005TT.Time,DUDP005TT.DUDP00590,'r');
elseif(ikind==21)
    plot(DUEM001TT.Time,DUEM001TT.DUEM00175,'b',DUEM001TT.Time,DUEM001TT.DUEM00190,'g',...
        DUEM001TT.Time,DUEM001TT.DUEM00195,'k',DUEM001TT.Time,DUEM001TT.DUEM00198,'r');
elseif(ikind==22)
    plot(DUEM002TT.Time,DUEM002TT.DUEM00275,'b',DUEM002TT.Time,DUEM002TT.DUEM00290,'g',...
        DUEM002TT.Time,DUEM002TT.DUEM00295,'k',DUEM002TT.Time,DUEM002TT.DUEM00298,'r');
elseif(ikind==23)
    plot(DUEM003TT.Time,DUEM003TT.DUEM00375,'b',DUEM003TT.Time,DUEM003TT.DUEM00390,'g',...
        DUEM003TT.Time,DUEM003TT.DUEM00395,'k',DUEM003TT.Time,DUEM003TT.DUEM00398,'r');
elseif(ikind==24)
    plot(DUEM004TT.Time,DUEM004TT.DUEM00475,'b',DUEM004TT.Time,DUEM004TT.DUEM00490,'g',...
        DUEM004TT.Time,DUEM004TT.DUEM00495,'k',DUEM004TT.Time,DUEM004TT.DUEM00498,'r');
elseif(ikind==25)
    plot(DUEM005TT.Time,DUEM005TT.DUEM00575,'b',DUEM005TT.Time,DUEM005TT.DUEM00590,'g',...
        DUEM005TT.Time,DUEM005TT.DUEM00595,'k',DUEM005TT.Time,DUEM005TT.DUEM00598,'r');
elseif(ikind==26)
    plot(DUEXTT.Time,DUEXTT.DUEXT25,'b',DUEXTT.Time,DUEXTT.DUEXT50,'g',...
        DUEXTT.Time,DUEXTT.DUEXT75,'k',DUEXTT.Time,DUEXTT.DUEXT90,'r');
elseif(ikind==27)
    plot(DUSCATTT.Time,DUSCATTT.DUSCAT25,'b',DUSCATTT.Time,DUSCATTT.DUSCAT50,'g',...
        DUSCATTT.Time,DUSCATTT.DUSCAT75,'k',DUSCATTT.Time,DUSCATTT.DUSCAT90,'r');
elseif(ikind==28)
    plot(DUSD001TT.Time,DUSD001TT.DUSD00175,'b',DUSD001TT.Time,DUSD001TT.DUSD00190,'g',...
        DUSD001TT.Time,DUSD001TT.DUSD00195,'k',DUSD001TT.Time,DUSD001TT.DUSD00198,'r');
elseif(ikind==29)
    plot(DUSD002TT.Time,DUSD002TT.DUSD00275,'b',DUSD002TT.Time,DUSD002TT.DUSD00290,'g',...
        DUSD002TT.Time,DUSD002TT.DUSD00295,'k',DUSD002TT.Time,DUSD002TT.DUSD00298,'r');
elseif(ikind==30)
    plot(DUSD003TT.Time,DUSD003TT.DUSD00375,'b',DUSD003TT.Time,DUSD003TT.DUSD00390,'g',...
        DUSD003TT.Time,DUSD003TT.DUSD00395,'k',DUSD003TT.Time,DUSD003TT.DUSD00398,'r');
elseif(ikind==31)
    plot(DUSD004TT.Time,DUSD004TT.DUSD00475,'b',DUSD004TT.Time,DUSD004TT.DUSD00490,'g',...
        DUSD004TT.Time,DUSD004TT.DUSD00495,'k',DUSD004TT.Time,DUSD004TT.DUSD00498,'r');
elseif(ikind==32)
    plot(DUSD005TT.Time,DUSD005TT.DUSD00575,'b',DUSD005TT.Time,DUSD005TT.DUSD00590,'g',...
        DUSD005TT.Time,DUSD005TT.DUSD00595,'k',DUSD005TT.Time,DUSD005TT.DUSD00598,'r');
elseif(ikind==33)
    plot(DUSV001TT.Time,DUSV001TT.DUSV00175,'b',DUSV001TT.Time,DUSV001TT.DUSV00190,'g',...
        DUSV001TT.Time,DUSV001TT.DUSV00195,'k',DUSV001TT.Time,DUSV001TT.DUSV00198,'r');
elseif(ikind==34)
    plot(DUSV002TT.Time,DUSV002TT.DUSV00275,'b',DUSV002TT.Time,DUSV002TT.DUSV00290,'g',...
        DUSV002TT.Time,DUSV002TT.DUSV00295,'k',DUSV002TT.Time,DUSV002TT.DUSV00298,'r');
elseif(ikind==35)
    plot(DUSV003TT.Time,DUSV003TT.DUSV00375,'b',DUSV003TT.Time,DUSV003TT.DUSV00390,'g',...
        DUSV003TT.Time,DUSV003TT.DUSV00395,'k',DUSV003TT.Time,DUSV003TT.DUSV00398,'r');
elseif(ikind==36)
    plot(DUSV004TT.Time,DUSV004TT.DUSV00475,'b',DUSV004TT.Time,DUSV004TT.DUSV00490,'g',...
        DUSV004TT.Time,DUSV004TT.DUSV00495,'k',DUSV004TT.Time,DUSV004TT.DUSV00498,'r');
elseif(ikind==37)
    plot(DUSV005TT.Time,DUSV005TT.DUSV00575,'b',DUSV005TT.Time,DUSV005TT.DUSV00590,'g',...
        DUSV005TT.Time,DUSV005TT.DUSV00595,'k',DUSV005TT.Time,DUSV005TT.DUSV00598,'r');
elseif(ikind==38)
    plot(DUWT001TT.Time,DUWT001TT.DUWT00175,'b',DUWT001TT.Time,DUWT001TT.DUWT00190,'g',...
        DUWT001TT.Time,DUWT001TT.DUWT00195,'k',DUWT001TT.Time,DUWT001TT.DUWT00198,'r');
elseif(ikind==39)
    plot(DUWT002TT.Time,DUWT002TT.DUWT00275,'b',DUWT002TT.Time,DUWT002TT.DUWT00290,'g',...
        DUWT002TT.Time,DUWT002TT.DUWT00295,'k',DUWT002TT.Time,DUWT002TT.DUWT00298,'r');
elseif(ikind==40)
    plot(DUWT003TT.Time,DUWT003TT.DUWT00375,'b',DUWT003TT.Time,DUWT003TT.DUWT00390,'g',...
        DUWT003TT.Time,DUWT003TT.DUWT00395,'k',DUWT003TT.Time,DUWT003TT.DUWT00398,'r');
elseif(ikind==41)
    plot(DUWT004TT.Time,DUWT004TT.DUWT00475,'b',DUWT004TT.Time,DUWT004TT.DUWT00490,'g',...
        DUWT004TT.Time,DUWT004TT.DUWT00495,'k',DUWT004TT.Time,DUWT004TT.DUWT00498,'r');
elseif(ikind==42)
    plot(DUWT005TT.Time,DUWT005TT.DUWT00575,'b',DUWT005TT.Time,DUWT005TT.DUWT00590,'g',...
        DUWT005TT.Time,DUWT005TT.DUWT00595,'k',DUWT005TT.Time,DUWT005TT.DUWT00598,'r');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==15)
    hl=legend('DUAERIDX 75 ptile','DUAERIDX 90 ptile','DUAERIDX 95 ptile','DUAERIDX 98 ptile');
elseif(ikind==16)
%    hl=legend('DUDP001 25 ptile','DUDP001 50 ptile','DUDP001 75 ptile','DUDP001 90 ptile');
elseif(ikind==17)
    hl=legend('DUDP002 25 ptile','DUDP002 50 ptile','DUDP002 75 ptile','DUDP002 90 ptile');
elseif(ikind==18)
    hl=legend('DUDP003 25 ptile','DUDP003 50 ptile','DUDP003 75 ptile','DUDP003 90 ptile');
elseif(ikind==19)
    hl=legend('DUDP004 25 ptile','DUDP004 50 ptile','DUDP004 75 ptile','DUDP004 90 ptile');
elseif(ikind==20)
    hl=legend('DUDP005 25 ptile','DUDP005 50 ptile','DUDP005 75 ptile','DUDP005 90 ptile');
elseif(ikind==21)
    hl=legend('DUEM001 75 ptile','DUEM001 90 ptile','DUEM001 95 ptile','DUEM001 98 ptile');
elseif(ikind==22)
    hl=legend('DUEM002 75 ptile','DUEM002 90 ptile','DUEM002 95 ptile','DUEM002 98 ptile');
elseif(ikind==23)
    hl=legend('DUEM003 75 ptile','DUEM003 90 ptile','DUEM003 95 ptile','DUEM003 98 ptile');
elseif(ikind==24)
    hl=legend('DUEM004 75 ptile','DUEM004 90 ptile','DUEM004 95 ptile','DUEM004 98 ptile');
elseif(ikind==25)
    hl=legend('DUEM005 75 ptile','DUEM004 90 ptile','DUEM004 95 ptile','DUEM004 98 ptile');
elseif(ikind==26)
    hl=legend('DUEXT 25 ptile','DUEXT 50 ptile','DUEXT 75 ptile','DUEXT 99 ptile');
elseif(ikind==27)
    hl=legend('DUSCAT 25 ptile','DUSCAT 50 ptile','DUSCAT 75 ptile','DUSCAT 99 ptile');
elseif(ikind==28)
    hl=legend('DUSD001 75 ptile','DUSD001 90 ptile','DUSD001 95 ptile','DUSD001 98 ptile');
elseif(ikind==29)
    hl=legend('DUSD002 75 ptile','DUSD002 90 ptile','DUSD002 95 ptile','DUSD002 98 ptile');
elseif(ikind==30)
    hl=legend('DUSD003 75 ptile','DUSD003 90 ptile','DUSD003 95 ptile','DUSD003 98 ptile');
elseif(ikind==31)
    hl=legend('DUSD004 75 ptile','DUSD004 90 ptile','DUSD004 95 ptile','DUSD004 98 ptile');
elseif(ikind==32)
    hl=legend('DUSD005 75 ptile','DUSD005 90 ptile','DUSD005 95 ptile','DUSD005 98 ptile');
elseif(ikind==33)
    hl=legend('DUSV001 75 ptile','DUSV001 90 ptile','DUSV001 95 ptile','DUSV001 98 ptile');
elseif(ikind==34)
    hl=legend('DUSV002 75 ptile','DUSV002 90 ptile','DUSV002 95 ptile','DUSV002 98 ptile');
elseif(ikind==35)
    hl=legend('DUSV003 75 ptile','DUSV003 90 ptile','DUSV003 95 ptile','DUSV003 98 ptile');
elseif(ikind==36)
    hl=legend('DUSV004 75 ptile','DUSV004 90 ptile','DUSV004 95 ptile','DUSV004 98 ptile');
elseif(ikind==37)
    hl=legend('DUSV005 75 ptile','DUSV005 90 ptile','DUSV005 95 ptile','DUSV005 98 ptile');
elseif(ikind==38)
    hl=legend('DUWT001 75 ptile','DUWT001 90 ptile','DUWT001 95 ptile','DUWT001 98 ptile');
elseif(ikind==39)
    hl=legend('DUWT002 75 ptile','DUWT002 90 ptile','DUWT002 95 ptile','DUWT002 98 ptile');
elseif(ikind==40)
    hl=legend('DUWT003 75 ptile','DUWT003 90 ptile','DUWT003 95 ptile','DUWT003 98 ptile');
elseif(ikind==41)
    hl=legend('DUWT004 75 ptile','DUWT004 90 ptile','DUWT004 95 ptile','DUWT004 98 ptile');
elseif(ikind==42)
    hl=legend('DUWT005 75 ptile','DUWT005 90 ptile','DUWT005 95 ptile','DUWT005 98 ptile');
end
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
if(ikind==15)
    ylabel('DUAERIDX-dimensionless','FontWeight','bold','FontSize',12);    
elseif(ikind==16)
%    ylabel('DUDP001-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==17)
    ylabel('DUDP002-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==18)
    ylabel('DUDP003-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==19)
    ylabel('DUDP004-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==20)
    ylabel('DUDP005-nanogram/m^2/sec/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==21)
    ylabel('DUEM001-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==22)
    ylabel('DUEM002-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==23)
    ylabel('DUEM003-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==24)
    ylabel('DUEM004-nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==25)
    ylabel('DUEM005--nanogram/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==26)
    ylabel('DUEXT-dimensionless','FontWeight','bold','FontSize',12);
elseif(ikind==27)
    ylabel('DUSCAT-dimensionless','FontWeight','bold','FontSize',12);
elseif(ikind==28)
    ylabel('DUSD001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==29)
    ylabel('DUSD002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==30)
    ylabel('DUSD003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==31)
    ylabel('DUSD004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==32)
    ylabel('DUSD005-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==33)
    ylabel('DUSV001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==34)
    ylabel('DUSV002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==35)
    ylabel('DUSV003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==36)
    ylabel('DUSV004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==37)
    ylabel('DUSV005-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==38)
    ylabel('DUWT001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==39)
    ylabel('DUWT002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==40)
    ylabel('DUWT003-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==41)
    ylabel('DUWT004-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==42)
    ylabel('DUWT005-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
end
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
        headingstr1=strcat('Tabular Analysis Results For-','Dry Dust Data');
        chapter = Chapter("Title",headingstr1);
    end
    if(ikind==15)
        sectionstr=strcat('DUAERIDX','-Map');    
    elseif(ikind==16)
%        sectionstr=strcat('DUDP001','-Map');
    elseif(ikind==17)
        sectionstr=strcat('DUDP002','-Map');
    elseif(ikind==18)
        sectionstr=strcat('DUDP003','-Map');
    elseif(ikind==19)
        sectionstr=strcat('DUDP004','-Map');
    elseif(ikind==20)
        sectionstr=strcat('DUDP005','-Map');
    elseif(ikind==21)
        sectionstr=strcat('DUEM001','-Map');
    elseif(ikind==22)
        sectionstr=strcat('DUEM002','-Map');
    elseif(ikind==23)
        sectionstr=strcat('DUEM003','-Map');
    elseif(ikind==24)
        sectionstr=strcat('DUEM004','-Map');
    elseif(ikind==25)
        sectionstr=strcat('DUEM005','-Map');
    elseif(ikind==26)
        sectionstr=strcat('DUEXT','-Map');
    elseif(ikind==27)
        sectionstr=strcat('DUSCAT','-Map');
    elseif(ikind==28)
        sectionstr=strcat('DUSD001','-Map');
    elseif(ikind==29)
        sectionstr=strcat('DUSD002','-Map');
    elseif(ikind==30)
        sectionstr=strcat('DUSD003','-Map');
    elseif(ikind==31)
        sectionstr=strcat('DUSD004','-Map');
    elseif(ikind==32)
        sectionstr=strcat('DUSD005','-Map');
    elseif(ikind==33)
        sectionstr=strcat('DUSV001','-Map');
    elseif(ikind==34)
        sectionstr=strcat('DUSV002','-Map');
    elseif(ikind==35)
        sectionstr=strcat('DUSV003','-Map');
    elseif(ikind==36)
        sectionstr=strcat('DUSV004','-Map');
    elseif(ikind==37)
        sectionstr=strcat('DUSV005','-Map');
    elseif(ikind==38)
        sectionstr=strcat('DUWT001','-Map');
    elseif(ikind==39)
        sectionstr=strcat('DUWT002','-Map');
    elseif(ikind==40)
        sectionstr=strcat('DUWT003','-Map');
    elseif(ikind==41)
        sectionstr=strcat('DUWT004','-Map');
    elseif(ikind==42)
        sectionstr=strcat('DUWT005','-Map');
    end
    
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    if(ikind==15)
        pdftxtstr=strcat(' DUAERIDX Map For File-',Merra2ShortFileName);     
    elseif(ikind==16)
%        pdftxtstr=strcat(' DUDP001 Map For File-',Merra2ShortFileName);
    elseif(ikind==17)
        pdftxtstr=strcat(' DUDP002 Map For File-',Merra2ShortFileName);
    elseif(ikind==18)
        pdftxtstr=strcat(' DUDP003 Map For File-',Merra2ShortFileName);
    elseif(ikind==19)
        pdftxtstr=strcat(' DUDP004 Map For File-',Merra2ShortFileName);
    elseif(ikind==20)
        pdftxtstr=strcat(' DUDP005 Map For File-',Merra2ShortFileName);
    elseif(ikind==21)
        pdftxtstr=strcat(' DUEM001 Map For File-',Merra2ShortFileName);
    elseif(ikind==22)
        pdftxtstr=strcat(' DUEM002 Map For File-',Merra2ShortFileName);
    elseif(ikind==23)
        pdftxtstr=strcat(' DUEM003 Map For File-',Merra2ShortFileName);
    elseif(ikind==24)
        pdftxtstr=strcat(' DUEM004 Map For File-',Merra2ShortFileName);
    elseif(ikind==25)
        pdftxtstr=strcat(' DUEM005 Map For File-',Merra2ShortFileName);
    elseif(ikind==26)
        pdftxtstr=strcat(' DUEXT Map For File-',Merra2ShortFileName);
    elseif(ikind==27)
        pdftxtstr=strcat(' DUSCAT Map For File-',Merra2ShortFileName);
    elseif(ikind==28)
        pdftxtstr=strcat(' DUSD001 Map For File-',Merra2ShortFileName);
    elseif(ikind==29)
        pdftxtstr=strcat(' DUSD002 Map For File-',Merra2ShortFileName);
    elseif(ikind==30)
        pdftxtstr=strcat(' DUSD003 Map For File-',Merra2ShortFileName);
    elseif(ikind==31)
        pdftxtstr=strcat(' DUSD004 Map For File-',Merra2ShortFileName);
    elseif(ikind==32)
        pdftxtstr=strcat(' DUSD005 Map For File-',Merra2ShortFileName);
    elseif(ikind==33)
        pdftxtstr=strcat(' DUSV001 Map For File-',Merra2ShortFileName);
    elseif(ikind==34)
        pdftxtstr=strcat(' DUSV002 Map For File-',Merra2ShortFileName);
    elseif(ikind==35)
        pdftxtstr=strcat(' DUSV003 Map For File-',Merra2ShortFileName);
    elseif(ikind==36)
        pdftxtstr=strcat(' DUSV004 Map For File-',Merra2ShortFileName);
    elseif(ikind==37)
        pdftxtstr=strcat(' DUSV005 Map For File-',Merra2ShortFileName);
    elseif(ikind==38)
        pdftxtstr=strcat(' DUWT001 Map For File-',Merra2ShortFileName);
    elseif(ikind==39)
        pdftxtstr=strcat(' DUWT002 Map For File-',Merra2ShortFileName);
    elseif(ikind==40)
        pdftxtstr=strcat(' DUWT003 Map For File-',Merra2ShortFileName);
    elseif(ikind==41)
        pdftxtstr=strcat(' DUWT004 Map For File-',Merra2ShortFileName);
    elseif(ikind==42)
        pdftxtstr=strcat(' DUWT005 Map For File-',Merra2ShortFileName);
    end
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
    if(ikind==15)
        parastr2='This metric is the value of the DUST TOMS UV index.';
        parastr3=' The value of this metric is a scalar with values typically in the 0-5 range';
        parastr4=' In most cases no measurements are returned.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==16)
        parastr2='This metric is the value of the Dry Dust Deposition Bin 01.';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==17)
        parastr2='This metric is the value of the Dry Dust Deposition Bin 02 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==18)
        parastr2='This metric is the value of the Dry Dust Deposition Bin 03 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==19)
        parastr2='This metric is the value of the Dry Dust Deposition Bin 04 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==20)
        parastr2='This metric is the value of the Dry Dust Deposition Band 05 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==21)
        parastr2='This metric is the value of the Dry Dust Emission Bin 01 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==22)
        parastr2='This metric is the value of the Dry Dust Emission Bin 02 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==23)
        parastr2='This metric is the value of the Dry Dust Emission Bin 03 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==24)
        parastr2='This metric is the value of the Dry Dust Emission Bin 04 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==25)
        parastr2='This metric is the value of the Dry Dust Emission Bin 05 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==26)
        parastr2='This metric is the value of Dust Extinction Coef at .55 microns.';
        parastr3=' The expected data is in the range of 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==27)
        parastr2='This metric is the value of Dust Scattering Coef at .55 microns.';
        parastr3=' The expected data is in the range of 0 to 1.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==28)
        parastr2='This metric is the value of Dust Sedimentation Bin 01.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==29)
        parastr2='This metric is the value of Dust Sedimentation Bin 02.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==30)
        parastr2='This metric is the value of Dust Sedimentation Bin 03.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==31)
        parastr2='This metric is the value of Dust Sedimentation Bin 04.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==32)
        parastr2='This metric is the value of Dust Sedimentation Bin 05.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==33)
        parastr2='This metric is the value of Dust Comvective Scavenging Bin 01.';
        parastr3=' The expected data is in the range of femtograms.';
        parastr4=' Dust Scavenging can be view as a sink for dust particles.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==34)
        parastr2='This metric is the value of Dust Comvective Scavenging Bin 02.';
        parastr3=' The expected data is in the range of femtograms.';
        parastr4=' Dust Scavenging can be view as a sink for dust particles.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==35)
        parastr2='This metric is the value of Dust Comvective Scavenging Bin 03.';
        parastr3=' The expected data is in the range of femtograms.';
        parastr4=' Dust Scavenging can be view as a sink for dust particles.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==36)
        parastr2='This metric is the value of Dust Comvective Scavenging Bin 04.';
        parastr3=' The expected data is in the range of femtograms.';
        parastr4=' Dust Scavenging can be view as a sink for dust particles.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==37)
        parastr2='This metric is the value of Dust Comvective Scavenging Bin 05.';
        parastr3=' The expected data is in the range of femtograms.';
        parastr4=' Dust Scavenging can be view as a sink for dust particles.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==38)
        parastr2='This metric is the value of Wet Dust Deposition  Bin 01.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==39)
        parastr2='This metric is the value of Wet Dust Deposition  Bin 02.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==40)
        parastr2='This metric is the value of Wet Dust Deposition  Bin 03.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==41)
        parastr2='This metric is the value of Wet Dust Deposition  Bin 04.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==42)
        parastr2='This metric is the value of Wet Dust Deposition  Bin 05.';
        parastr3=' The expected data is in the range of femtowatts.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
     if(ikind==15)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUAERIDXTT.Properties.RowTimes);
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
        Hdrs{1,4}='DUAER50';
        Hdrs{1,5}='DUAER75';
        Hdrs{1,6}='DUAER90';
        Hdrs{1,7}='DUAER95';
        Hdrs{1,8}='DUAER98';
        Hdrs{1,9}='DUAER100';
        Col1=DUAERIDXTable.DUAERIDX50;
        Col2=DUAERIDXTable.DUAERIDX75;
        Col3=DUAERIDXTable.DUAERIDX90;
        Col4=DUAERIDXTable.DUAERIDX95;
        Col5=DUAERIDXTable.DUAERIDX98;
        Col6=DUAERIDXTable.DUAERIDX100;
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
            NumberFormat("%2.3f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data Dust TOMS UV IndexFor=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the DUAERIDXTable over the selected data range.';
        parastr602=' DUAERIDX is the output of a specific TOMS sensor and is only avaailable sometimes ';
        parastr603=' Typical values are from 0 to  .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==16)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUDP001TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUDP0110';
        Hdrs{1,5}='DUDP0125';
        Hdrs{1,6}='DUDP0150';
        Hdrs{1,7}='DUDP0175';
        Hdrs{1,8}='DUDP0190';
        Hdrs{1,9}='DUDP01100';
        Col1=DUDP001Table.DUDP00110;
        Col2=DUDP001Table.DUDP00125;
        Col3=DUDP001Table.DUDP00150;
        Col4=DUDP001Table.DUDP00175;
        Col5=DUDP001Table.DUDP00190;
        Col6=DUDP001Table.DUDP001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the DUDP001Table over the selected data range.';
        parastr602=' DUDP001 is the emissions due to black carbon biomass emissions ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
    elseif(ikind==17)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUDP002TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUDP0210';
        Hdrs{1,5}='DUDP0225';
        Hdrs{1,6}='DUDP0250';
        Hdrs{1,7}='DUDP0275';
        Hdrs{1,8}='DUDP0290';
        Hdrs{1,9}='DUDP02100';
        Col1=DUDP002Table.DUDP00210;
        Col2=DUDP002Table.DUDP00225;
        Col3=DUDP002Table.DUDP00250;
        Col4=DUDP002Table.DUDP00275;
        Col5=DUDP002Table.DUDP00290;
        Col6=DUDP002Table.DUDP002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr701='The table above shows the distribution of the DUDP002Table over the selected data range.';
        parastr702=' DUDP002 is the dry dust deposition in Bin 02 ';
        parastr703=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr704=' A diurnal cycle is generally observed for these emissions.';
        parastr705=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr709=strcat(parastr701,parastr702,parastr705);
        p709= Paragraph(parastr709);
        p709.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p709);
     elseif(ikind==18)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUDP003TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUDP0310';
        Hdrs{1,5}='DUDP0325';
        Hdrs{1,6}='DUDP0350';
        Hdrs{1,7}='DUDP0375';
        Hdrs{1,8}='DUDP0390';
        Hdrs{1,9}='DUDP03100';
        Col1=DUDP003Table.DUDP00310;
        Col2=DUDP003Table.DUDP00325;
        Col3=DUDP003Table.DUDP00350;
        Col4=DUDP003Table.DUDP00375;
        Col5=DUDP003Table.DUDP00390;
        Col6=DUDP003Table.DUDP003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr801='The table above shows the distribution of the DUDP003Table over the selected data range.';
        parastr802=' DUDP003 is the dry dust deposition in Bin 03 ';
        parastr803=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr804=' A diurnal cycle is generally observed for these emissions.';
        parastr805=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr809=strcat(parastr801,parastr802,parastr805);
        p809= Paragraph(parastr809);
        p809.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p809);
     elseif(ikind==19)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUDP004TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUDP0410';
        Hdrs{1,5}='DUDP0425';
        Hdrs{1,6}='DUDP0450';
        Hdrs{1,7}='DUDP0475';
        Hdrs{1,8}='DUDP0490';
        Hdrs{1,9}='DUDP04100';
        Col1=DUDP004Table.DUDP00410;
        Col2=DUDP004Table.DUDP00425;
        Col3=DUDP004Table.DUDP00450;
        Col4=DUDP004Table.DUDP00475;
        Col5=DUDP004Table.DUDP00490;
        Col6=DUDP004Table.DUDP004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr901='The table above shows the distribution of the DUDP004Table over the selected data range.';
        parastr902=' DUDP004 is the dry dust deposition in Bin 04 ';
        parastr903=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr904=' A diurnal cycle is generally observed for these emissions.';
        parastr905=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr909=strcat(parastr901,parastr902,parastr905);
        p909= Paragraph(parastr909);
        p909.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p909);
     elseif(ikind==20)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUDP005TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUDP0510';
        Hdrs{1,5}='DUDP0525';
        Hdrs{1,6}='DUDP0550';
        Hdrs{1,7}='DUDP0575';
        Hdrs{1,8}='DUDP0590';
        Hdrs{1,9}='DUDP05100';
        Col1=DUDP005Table.DUDP00510;
        Col2=DUDP005Table.DUDP00525;
        Col3=DUDP005Table.DUDP00550;
        Col4=DUDP005Table.DUDP00575;
        Col5=DUDP005Table.DUDP00590;
        Col6=DUDP005Table.DUDP005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1001='The table above shows the distribution of the DUDP005Table over the selected data range.';
        parastr1002=' DUDP005 is the dry dust deposition in Bin 05 ';
        parastr1003=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1004=' A diurnal cycle is generally observed for these emissions.';
        parastr1005=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1009=strcat(parastr1001,parastr1002,parastr1005);
        p1009= Paragraph(parastr1009);
        p1009.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1009);
     elseif(ikind==21)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUEM001TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUEM0150';
        Hdrs{1,5}='DUEM0175';
        Hdrs{1,6}='DUEM0190';
        Hdrs{1,7}='DUEM0195';
        Hdrs{1,8}='DUEM0198';
        Hdrs{1,9}='DUEM01100';
        Col1=DUEM001Table.DUEM00150;
        Col2=DUEM001Table.DUEM00175;
        Col3=DUEM001Table.DUEM00190;
        Col4=DUEM001Table.DUEM00195;
        Col5=DUEM001Table.DUEM00198;
        Col6=DUEM001Table.DUEM001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1101='The table above shows the distribution of the DUEM001Table over the selected data range.';
        parastr1102=' DUEM001 is the dry dust emission in Bin 01 ';
        parastr1103=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1104=' A diurnal cycle is generally observed for these emissions.';
        parastr1105=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1109=strcat(parastr1101,parastr1102,parastr1105);
        p1109= Paragraph(parastr1109);
        p1109.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1109);
     elseif(ikind==22)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUEM002TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUEM0250';
        Hdrs{1,5}='DUEM0275';
        Hdrs{1,6}='DUEM0290';
        Hdrs{1,7}='DUEM0295';
        Hdrs{1,8}='DUEM0298';
        Hdrs{1,9}='DUEM02100';
        Col1=DUEM002Table.DUEM00250;
        Col2=DUEM002Table.DUEM00275;
        Col3=DUEM002Table.DUEM00290;
        Col4=DUEM002Table.DUEM00295;
        Col5=DUEM002Table.DUEM00298;
        Col6=DUEM002Table.DUEM002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1201='The table above shows the distribution of the DUEM002Table over the selected data range.';
        parastr1202=' DUEM002 is the dry dust emission in Bin 02 ';
        parastr1203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1204=' A diurnal cycle is generally observed for these emissions.';
        parastr1205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1209=strcat(parastr1201,parastr1202,parastr1205);
        p1209= Paragraph(parastr1209);
        p1209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1209);
     elseif(ikind==23)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUEM003TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUEM0350';
        Hdrs{1,5}='DUEM0375';
        Hdrs{1,6}='DUEM0390';
        Hdrs{1,7}='DUEM0395';
        Hdrs{1,8}='DUEM0398';
        Hdrs{1,9}='DUEM03100';
        Col1=DUEM003Table.DUEM00350;
        Col2=DUEM003Table.DUEM00375;
        Col3=DUEM003Table.DUEM00390;
        Col4=DUEM003Table.DUEM00395;
        Col5=DUEM003Table.DUEM00398;
        Col6=DUEM003Table.DUEM003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1301='The table above shows the distribution of the DUEM003Table over the selected data range.';
        parastr1302=' DUEM003 is the dry dust emission in Bin 03 ';
        parastr1303=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1304=' A diurnal cycle is generally observed for these emissions.';
        parastr1305=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1309=strcat(parastr1301,parastr1302,parastr1305);
        p1309= Paragraph(parastr1309);
        p1309.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1309);
     elseif(ikind==24)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUEM004TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUEM0450';
        Hdrs{1,5}='DUEM0475';
        Hdrs{1,6}='DUEM0490';
        Hdrs{1,7}='DUEM0495';
        Hdrs{1,8}='DUEM0498';
        Hdrs{1,9}='DUEM04100';
        Col1=DUEM004Table.DUEM00450;
        Col2=DUEM004Table.DUEM00475;
        Col3=DUEM004Table.DUEM00490;
        Col4=DUEM004Table.DUEM00495;
        Col5=DUEM004Table.DUEM00498;
        Col6=DUEM004Table.DUEM004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1401='The table above shows the distribution of the DUEM004Table over the selected data range.';
        parastr1402=' DUEM004 is the dry dust emission in Bin 04 ';
        parastr1403=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1404=' A diurnal cycle is generally observed for these emissions.';
        parastr1405=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1409=strcat(parastr1401,parastr1402,parastr1405);
        p1409= Paragraph(parastr1409);
        p1409.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1409);
     elseif(ikind==25)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUEM005TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUEM0550';
        Hdrs{1,5}='DUEM0575';
        Hdrs{1,6}='DUEM0590';
        Hdrs{1,7}='DUEM0595';
        Hdrs{1,8}='DUEM0598';
        Hdrs{1,9}='DUEM05100';
        Col1=DUEM005Table.DUEM00550;
        Col2=DUEM005Table.DUEM00575;
        Col3=DUEM005Table.DUEM00590;
        Col4=DUEM005Table.DUEM00595;
        Col5=DUEM005Table.DUEM00598;
        Col6=DUEM005Table.DUEM005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Dust Bin005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1501='The table above shows the distribution of the DUEM005Table over the selected data range.';
        parastr1502=' DUEM005 is the dry dust emission in Bin 05 ';
        parastr1503=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1504=' A diurnal cycle is generally observed for these emissions.';
        parastr1505=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1509=strcat(parastr1501,parastr1502,parastr1505);
        p1509= Paragraph(parastr1509);
        p1509.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1509);
     elseif(ikind==26)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUEXTT.Properties.RowTimes);
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
        Hdrs{1,4}='DUEXT10';
        Hdrs{1,5}='DUEXT25';
        Hdrs{1,6}='DUEXT50';
        Hdrs{1,7}='DUEXT75';
        Hdrs{1,8}='DUEXT90';
        Hdrs{1,9}='DUEXT100';
        Col1=DUEXTable.DUEXT10;
        Col2=DUEXTable.DUEXT25;
        Col3=DUEXTable.DUEXT50;
        Col4=DUEXTable.DUEXT75;
        Col5=DUEXTable.DUEXT90;
        Col6=DUEXTable.DUEXT100;
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
        tabletitlestr=strcat('Merra2 Hourly Data Dust Extinction For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1601='The table above shows the distribution of the DUEXTable over the selected data range.';
        parastr1602=' DUEXT is the dust extinction coefficient at .55 microns ';
        parastr1603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1604=' A diurnal cycle is generally observed for these emissions.';
        parastr1605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1609=strcat(parastr1601,parastr1602,parastr1605);
        p1609= Paragraph(parastr1609);
        p1609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1609);
     elseif(ikind==27)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSCATTT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSCAT10';
        Hdrs{1,5}='DUSCAT25';
        Hdrs{1,6}='DUSCAT50';
        Hdrs{1,7}='DUSCAT75';
        Hdrs{1,8}='DUSCAT90';
        Hdrs{1,9}='DUSCAT100';
        Col1=DUSCATTable.DUSCAT10;
        Col2=DUSCATTable.DUSCAT25;
        Col3=DUSCATTable.DUSCAT50;
        Col4=DUSCATTable.DUSCAT75;
        Col5=DUSCATTable.DUSCAT90;
        Col6=DUSCATTable.DUSCAT100;
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
            NumberFormat("%1.4f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data Dust Extinction For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1701='The table above shows the distribution of the DUSCATTable over the selected data range.';
        parastr1702=' DUSCAT is the dust scattering coefficient at .55 microns ';
        parastr1703=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1704=' A diurnal cycle is generally observed for these emissions.';
        parastr1705=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1709=strcat(parastr1701,parastr1702,parastr1705);
        p1709= Paragraph(parastr1709);
        p1709.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1709);
     elseif(ikind==28)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSD001TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSD0150';
        Hdrs{1,5}='DUSD0175';
        Hdrs{1,6}='DUSD0190';
        Hdrs{1,7}='DUSD0195';
        Hdrs{1,8}='DUSD0198';
        Hdrs{1,9}='DUSD01100';
        Col1=DUSD001Table.DUSD00150;
        Col2=DUSD001Table.DUSD00175;
        Col3=DUSD001Table.DUSD00190;
        Col4=DUSD001Table.DUSD00195;
        Col5=DUSD001Table.DUSD00198;
        Col6=DUSD001Table.DUSD001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Sedimentation Bin001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1801='The table above shows the distribution of the DUSD001Table over the selected data range.';
        parastr1802=' DUSD001 is thecdust sedientation in Bin 01 ';
        parastr1803=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1804=' A diurnal cycle is generally observed for these emissions.';
        parastr1805=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1809=strcat(parastr1801,parastr1802,parastr1805);
        p1809= Paragraph(parastr1809);
        p1809.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1809);
     elseif(ikind==29)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSD002TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSD0250';
        Hdrs{1,5}='DUSD0275';
        Hdrs{1,6}='DUSD0290';
        Hdrs{1,7}='DUSD0295';
        Hdrs{1,8}='DUSD0298';
        Hdrs{1,9}='DUSD02100';
        Col1=DUSD002Table.DUSD00250;
        Col2=DUSD002Table.DUSD00275;
        Col3=DUSD002Table.DUSD00290;
        Col4=DUSD002Table.DUSD00295;
        Col5=DUSD002Table.DUSD00298;
        Col6=DUSD002Table.DUSD002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Sedimentation Bin002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr1901='The table above shows the distribution of the DUSD002Table over the selected data range.';
        parastr1902=' DUSD002 is thecdust sedientation in Bin 02 ';
        parastr1903=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr1904=' A diurnal cycle is generally observed for these emissions.';
        parastr1905=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr1909=strcat(parastr1901,parastr1902,parastr1905);
        p1909= Paragraph(parastr1909);
        p1909.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p1909);
     elseif(ikind==30)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSD003TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSD0350';
        Hdrs{1,5}='DUSD0375';
        Hdrs{1,6}='DUSD0390';
        Hdrs{1,7}='DUSD0395';
        Hdrs{1,8}='DUSD0398';
        Hdrs{1,9}='DUSD03100';
        Col1=DUSD003Table.DUSD00350;
        Col2=DUSD003Table.DUSD00375;
        Col3=DUSD003Table.DUSD00390;
        Col4=DUSD003Table.DUSD00395;
        Col5=DUSD003Table.DUSD00398;
        Col6=DUSD003Table.DUSD003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Sedimentation Bin003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2001='The table above shows the distribution of the DUSD003Table over the selected data range.';
        parastr2002=' DUSD003 is thecdust sedientation in Bin 03 ';
        parastr2003=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2004=' A diurnal cycle is generally observed for these emissions.';
        parastr2005=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2009=strcat(parastr2001,parastr2002,parastr2005);
        p2009= Paragraph(parastr2009);
        p2009.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2009);
     elseif(ikind==31)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSD004TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSD0450';
        Hdrs{1,5}='DUSD0475';
        Hdrs{1,6}='DUSD0490';
        Hdrs{1,7}='DUSD0495';
        Hdrs{1,8}='DUSD0498';
        Hdrs{1,9}='DUSD04100';
        Col1=DUSD004Table.DUSD00450;
        Col2=DUSD004Table.DUSD00475;
        Col3=DUSD004Table.DUSD00490;
        Col4=DUSD004Table.DUSD00495;
        Col5=DUSD004Table.DUSD00498;
        Col6=DUSD004Table.DUSD004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Sedimentation Bin004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2101='The table above shows the distribution of the DUSD004Table over the selected data range.';
        parastr2102=' DUSD004 is thevdust sedimentation in Bin 04 ';
        parastr2103=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2104=' A diurnal cycle is generally observed for these emissions.';
        parastr2105=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2109=strcat(parastr2101,parastr2102,parastr2105);
        p2109= Paragraph(parastr2109);
        p2109.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2109);
      elseif(ikind==32)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSD005TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSD0550';
        Hdrs{1,5}='DUSD0575';
        Hdrs{1,6}='DUSD0590';
        Hdrs{1,7}='DUSD0595';
        Hdrs{1,8}='DUSD0598';
        Hdrs{1,9}='DUSD05100';
        Col1=DUSD005Table.DUSD00550;
        Col2=DUSD005Table.DUSD00575;
        Col3=DUSD005Table.DUSD00590;
        Col4=DUSD005Table.DUSD00595;
        Col5=DUSD005Table.DUSD00598;
        Col6=DUSD005Table.DUSD005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Sedimentation Bin005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2201='The table above shows the distribution of the DUSD005Table over the selected data range.';
        parastr2202=' DUSD005 is the dust sedimentation in Bin 05 ';
        parastr2203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2204=' A diurnal cycle is generally observed for these emissions.';
        parastr2205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2209=strcat(parastr2201,parastr2202,parastr2205);
        p2209= Paragraph(parastr2209);
        p2209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2209);
     elseif(ikind==33)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSV001TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSV0150';
        Hdrs{1,5}='DUSV0175';
        Hdrs{1,6}='DUSV0190';
        Hdrs{1,7}='DUSV0195';
        Hdrs{1,8}='DUSV0198';
        Hdrs{1,9}='DUSV01100';
        Col1=DUSV001Table.DUSV00150;
        Col2=DUSV001Table.DUSV00175;
        Col3=DUSV001Table.DUSV00190;
        Col4=DUSV001Table.DUSV00195;
        Col5=DUSV001Table.DUSV00198;
        Col6=DUSV001Table.DUSV001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Scavenging Bin001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2201='The table above shows the distribution of the DUSV001Table over the selected data range.';
        parastr2202=' DUSV001 is the dust scavenging in convective air for Bin 01 ';
        parastr2203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2204=' A diurnal cycle is generally observed for these emissions.';
        parastr2205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2209=strcat(parastr2201,parastr2202,parastr2205);
        p2209= Paragraph(parastr2209);
        p2209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2209);
      elseif(ikind==34)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSV002TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSV0250';
        Hdrs{1,5}='DUSV0275';
        Hdrs{1,6}='DUSV0290';
        Hdrs{1,7}='DUSV0295';
        Hdrs{1,8}='DUSV0298';
        Hdrs{1,9}='DUSV02100';
        Col1=DUSV002Table.DUSV00250;
        Col2=DUSV002Table.DUSV00275;
        Col3=DUSV002Table.DUSV00290;
        Col4=DUSV002Table.DUSV00295;
        Col5=DUSV002Table.DUSV00298;
        Col6=DUSV002Table.DUSV002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Scavenging Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2201='The table above shows the distribution of the DUSV002Table over the selected data range.';
        parastr2202=' DUSV002 is the dust scavenging in convective air for Bin 02 ';
        parastr2203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2204=' A diurnal cycle is generally observed for these emissions.';
        parastr2205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2209=strcat(parastr2201,parastr2202,parastr2205);
        p2209= Paragraph(parastr2209);
        p2209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2209);
      elseif(ikind==35)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSV003TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSV0350';
        Hdrs{1,5}='DUSV0375';
        Hdrs{1,6}='DUSV0390';
        Hdrs{1,7}='DUSV0395';
        Hdrs{1,8}='DUSV0398';
        Hdrs{1,9}='DUSV03100';
        Col1=DUSV003Table.DUSV00350;
        Col2=DUSV003Table.DUSV00375;
        Col3=DUSV003Table.DUSV00390;
        Col4=DUSV003Table.DUSV00395;
        Col5=DUSV003Table.DUSV00398;
        Col6=DUSV003Table.DUSV003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Scavenging Bin 003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2201='The table above shows the distribution of the DUSV003Table over the selected data range.';
        parastr2202=' DUSV003 is the dust scavenging in convective air for Bin 03 ';
        parastr2203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2204=' A diurnal cycle is generally observed for these emissions.';
        parastr2205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2209=strcat(parastr2201,parastr2202,parastr2205);
        p2209= Paragraph(parastr2209);
        p2209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2209);
      elseif(ikind==36)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSV004TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSV0450';
        Hdrs{1,5}='DUSV0475';
        Hdrs{1,6}='DUSV0490';
        Hdrs{1,7}='DUSV0495';
        Hdrs{1,8}='DUSV0498';
        Hdrs{1,9}='DUSV04100';
        Col1=DUSV004Table.DUSV00450;
        Col2=DUSV004Table.DUSV00475;
        Col3=DUSV004Table.DUSV00490;
        Col4=DUSV004Table.DUSV00495;
        Col5=DUSV004Table.DUSV00498;
        Col6=DUSV004Table.DUSV004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Scavenging Bin 004 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2201='The table above shows the distribution of the DUSV004Table over the selected data range.';
        parastr2202=' DUSV004 is the dust scavenging in convective air for Bin 04 ';
        parastr2203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2204=' A diurnal cycle is generally observed for these emissions.';
        parastr2205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2209=strcat(parastr2201,parastr2202,parastr2205);
        p2209= Paragraph(parastr2209);
        p2209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2209);
      elseif(ikind==37)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUSV005TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUSV0550';
        Hdrs{1,5}='DUSV0575';
        Hdrs{1,6}='DUSV0590';
        Hdrs{1,7}='DUSV0595';
        Hdrs{1,8}='DUSV0598';
        Hdrs{1,9}='DUSV05100';
        Col1=DUSV005Table.DUSV00550;
        Col2=DUSV005Table.DUSV00575;
        Col3=DUSV005Table.DUSV00590;
        Col4=DUSV005Table.DUSV00595;
        Col5=DUSV005Table.DUSV00598;
        Col6=DUSV005Table.DUSV005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Dust Scavenging Bin 005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2201='The table above shows the distribution of the DUSV005Table over the selected data range.';
        parastr2202=' DUSV005 is the dust scavenging in convective air for Bin 05 ';
        parastr2203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2204=' A diurnal cycle is generally observed for these emissions.';
        parastr2205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2209=strcat(parastr2201,parastr2202,parastr2205);
        p2209= Paragraph(parastr2209);
        p2209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2209);
     elseif(ikind==38)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUWT001TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUWT0150';
        Hdrs{1,5}='DUWT0175';
        Hdrs{1,6}='DUWT0190';
        Hdrs{1,7}='DUWT0195';
        Hdrs{1,8}='DUWT0198';
        Hdrs{1,9}='DUWT01100';
        Col1=DUWT001Table.DUWT00150;
        Col2=DUWT001Table.DUWT00175;
        Col3=DUWT001Table.DUWT00190;
        Col4=DUWT001Table.DUWT00195;
        Col5=DUWT001Table.DUWT00198;
        Col6=DUWT001Table.DUWT001100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Wet Dust Deposition Bin001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2801='The table above shows the distribution of the DUWT001Table over the selected data range.';
        parastr2802=' DUWT001 is the wet dust deposition in Bin 01 ';
        parastr2803=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2804=' A diurnal cycle is generally observed for these emissions.';
        parastr2805=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2809=strcat(parastr2801,parastr2802,parastr2805);
        p2809= Paragraph(parastr2809);
        p2809.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2809);
     elseif(ikind==39)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUWT002TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUWT0250';
        Hdrs{1,5}='DUWT0275';
        Hdrs{1,6}='DUWT0290';
        Hdrs{1,7}='DUWT0295';
        Hdrs{1,8}='DUWT0298';
        Hdrs{1,9}='DUWT02100';
        Col1=DUWT002Table.DUWT00250;
        Col2=DUWT002Table.DUWT00275;
        Col3=DUWT002Table.DUWT00290;
        Col4=DUWT002Table.DUWT00295;
        Col5=DUWT002Table.DUWT00298;
        Col6=DUWT002Table.DUWT002100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Wet Dust Deposition Bin002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr2901='The table above shows the distribution of the DUWT002Table over the selected data range.';
        parastr2902=' DUWT002 is the wet dust deposition in Bin 02 ';
        parastr2903=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr2904=' A diurnal cycle is generally observed for these emissions.';
        parastr2905=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr2909=strcat(parastr2901,parastr2902,parastr2905);
        p2909= Paragraph(parastr2909);
        p2909.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p2909);
      elseif(ikind==40)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUWT003TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUWT0350';
        Hdrs{1,5}='DUWT0375';
        Hdrs{1,6}='DUWT0390';
        Hdrs{1,7}='DUWT0395';
        Hdrs{1,8}='DUWT0398';
        Hdrs{1,9}='DUWT03100';
        Col1=DUWT003Table.DUWT00350;
        Col2=DUWT003Table.DUWT00375;
        Col3=DUWT003Table.DUWT00390;
        Col4=DUWT003Table.DUWT00395;
        Col5=DUWT003Table.DUWT00398;
        Col6=DUWT003Table.DUWT003100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Wet Dust Deposition Bin003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr3001='The table above shows the distribution of the DUWT003Table over the selected data range.';
        parastr3002=' DUWT003 is the wet dust deposition in Bin 03 ';
        parastr3003=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr3004=' A diurnal cycle is generally observed for these emissions.';
        parastr3005=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr3009=strcat(parastr3001,parastr3002,parastr3005);
        p3009= Paragraph(parastr3009);
        p3009.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p3009);
     elseif(ikind==41)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUWT004TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUWT0450';
        Hdrs{1,5}='DUWT0475';
        Hdrs{1,6}='DUWT0490';
        Hdrs{1,7}='DUWT0495';
        Hdrs{1,8}='DUWT0498';
        Hdrs{1,9}='DUWT04100';
        Col1=DUWT004Table.DUWT00450;
        Col2=DUWT004Table.DUWT00475;
        Col3=DUWT004Table.DUWT00490;
        Col4=DUWT004Table.DUWT00495;
        Col5=DUWT004Table.DUWT00498;
        Col6=DUWT004Table.DUWT004100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Wet Dust Deposition Bin003 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr3101='The table above shows the distribution of the DUWT004Table over the selected data range.';
        parastr3102=' DUWT004 is the wet dust deposition in Bin 04 ';
        parastr3103=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr3104=' A diurnal cycle is generally observed for these emissions.';
        parastr3105=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr3109=strcat(parastr3101,parastr3102,parastr3105);
        p3109= Paragraph(parastr3109);
        p3109.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p3109);
      elseif(ikind==42)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DUWT005TT.Properties.RowTimes);
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
        Hdrs{1,4}='DUWT0550';
        Hdrs{1,5}='DUWT0575';
        Hdrs{1,6}='DUWT0590';
        Hdrs{1,7}='DUWT0595';
        Hdrs{1,8}='DUWT0598';
        Hdrs{1,9}='DUWT05100';
        Col1=DUWT005Table.DUWT00550;
        Col2=DUWT005Table.DUWT00575;
        Col3=DUWT005Table.DUWT00590;
        Col4=DUWT005Table.DUWT00595;
        Col5=DUWT005Table.DUWT00598;
        Col6=DUWT005Table.DUWT005100;
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
        tabletitlestr=strcat('Merra2 Hourly Data On Wet Dust Deposition Bin005 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr3201='The table above shows the distribution of the DUWT005Table over the selected data range.';
        parastr3202=' DUWT005 is the wet dust deposition in Bin 05 ';
        parastr3203=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr3204=' A diurnal cycle is generally observed for these emissions.';
        parastr3205=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr3209=strcat(parastr3201,parastr3202,parastr3205);
        p3209= Paragraph(parastr3209);
        p3209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p3209);
    end
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end