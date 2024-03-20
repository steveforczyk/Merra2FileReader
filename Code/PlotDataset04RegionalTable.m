function PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function plots some timetables created by Dataset04
% For features that are calculated for a single region
% Written By: Stephen Forczyk
% Created: March 2,2024
% Revised: March 3,2024 added Algeria Table
% Revised: March 4-5,2024 added tables up to SaudiTempsTT
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;

global idebug iScale;
global LonS LatS TimeS iTimeSlice ;
global EFLUXICES EFLUXWTRS FRSEAICES HFLUXICES HFLUXWTRS;
global LWGNTICES LWGNTWTRS SWGNTICES SWGNTWTRS;
global PRECSNOOCNS QV10MS RAINOCNS  integrateRate;
global T10MS TAUXICES TAUXWTRS TAUYICES TAUYWTRS;

global AfricaTempsTable AfricaTempsTT AlgeriaTempsTable AlgeriaTempsTT;
global ChadTempsTable ChadTempsTT EgyptTempsTable EgyptTempsTT;
global LibyaTempsTable LibyaTempsTT AngolaTempTable AngolaTempsTT;
global NigeriaTempsTable NigeriaTempsTT KenyaTempsTable KenyaTempsTT;
global MozambiqueTempsTT EthiopiaTempsTT MadagascarTempsTT SouthAfricaTempsTT;
global CDRTempsTT  CARTempsTT  NamibiaTempsTT SomaliaTempsTT SudanTempsTT;
global SaudiTempsTT IranTempsTT IraqTempsTT JordanTempsTT SyriaTempsTT;
global TurkeyTempsTT PakistanTempsTT AfganistanTempsTT IndiaTempsTT;



global RasterLats RasterLons Rpix;
global framecounter numSelectedFiles;
global westEdge eastEdge northEdge southEdge;
global yd md dd;

global Merra2ShortFileName;
global numtimeslice TimeSlices;
global Years Months Days;
global iTimeSlice iPress42;

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
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');

set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==40)
    plot(AfricaTempsTT.Time,AfricaTempsTT.Ptile25,'b',AfricaTempsTT.Time,AfricaTempsTT.Ptile50,'g',...
        AfricaTempsTT.Time,AfricaTempsTT.Ptile75,'k',AfricaTempsTT.Time,AfricaTempsTT.Ptile99,'r--o'); 
elseif(ikind==41)
    plot(AlgeriaTempsTT.Time,AlgeriaTempsTT.Ptile25,'b',AlgeriaTempsTT.Time,AlgeriaTempsTT.Ptile50,'g',...
        AlgeriaTempsTT.Time,AlgeriaTempsTT.Ptile75,'k',AlgeriaTempsTT.Time,AlgeriaTempsTT.Ptile99,'r--o'); 
elseif(ikind==42)
    plot(ChadTempsTT.Time,ChadTempsTT.Ptile25,'b',ChadTempsTT.Time,ChadTempsTT.Ptile50,'g',...
        ChadTempsTT.Time,ChadTempsTT.Ptile75,'k',ChadTempsTT.Time,ChadTempsTT.Ptile99,'r--o'); 
elseif(ikind==43)
    plot(EgyptTempsTT.Time,EgyptTempsTT.Ptile25,'b',EgyptTempsTT.Time,EgyptTempsTT.Ptile50,'g',...
        EgyptTempsTT.Time,EgyptTempsTT.Ptile75,'k',EgyptTempsTT.Time,EgyptTempsTT.Ptile99,'r--o'); 
elseif(ikind==44)
    plot(LibyaTempsTT.Time,LibyaTempsTT.Ptile25,'b',LibyaTempsTT.Time,LibyaTempsTT.Ptile50,'g',...
        LibyaTempsTT.Time,LibyaTempsTT.Ptile75,'k',LibyaTempsTT.Time,LibyaTempsTT.Ptile99,'r--o');
elseif(ikind==45)
    plot(AngolaTempsTT.Time,AngolaTempsTT.Ptile25,'b',AngolaTempsTT.Time,AngolaTempsTT.Ptile50,'g',...
        AngolaTempsTT.Time,AngolaTempsTT.Ptile75,'k',AngolaTempsTT.Time,AngolaTempsTT.Ptile99,'r--o'); 
elseif(ikind==46)
    plot(NigeriaTempsTT.Time,NigeriaTempsTT.Ptile25,'b',NigeriaTempsTT.Time,NigeriaTempsTT.Ptile50,'g',...
        NigeriaTempsTT.Time,NigeriaTempsTT.Ptile75,'k',NigeriaTempsTT.Time,NigeriaTempsTT.Ptile99,'r--o'); 
elseif(ikind==47)
    plot(KenyaTempsTT.Time,KenyaTempsTT.Ptile25,'b',KenyaTempsTT.Time,KenyaTempsTT.Ptile50,'g',...
        KenyaTempsTT.Time,KenyaTempsTT.Ptile75,'k',KenyaTempsTT.Time,KenyaTempsTT.Ptile99,'r--o'); 
elseif(ikind==48)
    plot(MozambiqueTempsTT.Time,MozambiqueTempsTT.Ptile25,'b',MozambiqueTempsTT.Time,MozambiqueTempsTT.Ptile50,'g',...
        MozambiqueTempsTT.Time,MozambiqueTempsTT.Ptile75,'k',MozambiqueTempsTT.Time,MozambiqueTempsTT.Ptile99,'r--o'); 
elseif(ikind==49)
    plot(EthiopiaTempsTT.Time,EthiopiaTempsTT.Ptile25,'b',EthiopiaTempsTT.Time,EthiopiaTempsTT.Ptile50,'g',...
        EthiopiaTempsTT.Time,EthiopiaTempsTT.Ptile75,'k',EthiopiaTempsTT.Time,EthiopiaTempsTT.Ptile99,'r--o');
elseif(ikind==50)
    plot(MadagascarTempsTT.Time,MadagascarTempsTT.Ptile25,'b',MadagascarTempsTT.Time,MadagascarTempsTT.Ptile50,'g',...
        MadagascarTempsTT.Time,MadagascarTempsTT.Ptile75,'k',MadagascarTempsTT.Time,MadagascarTempsTT.Ptile99,'r--o'); 
elseif(ikind==51)
    plot(SouthAfricaTempsTT.Time,SouthAfricaTempsTT.Ptile25,'b',SouthAfricaTempsTT.Time,SouthAfricaTempsTT.Ptile50,'g',...
        SouthAfricaTempsTT.Time,SouthAfricaTempsTT.Ptile75,'k',SouthAfricaTempsTT.Time,SouthAfricaTempsTT.Ptile99,'r--o'); 
elseif(ikind==52)
    plot(CDRTempsTT.Time,CDRTempsTT.Ptile25,'b',CDRTempsTT.Time,CDRTempsTT.Ptile50,'g',...
        CDRTempsTT.Time,CDRTempsTT.Ptile75,'k',CDRTempsTT.Time,CDRTempsTT.Ptile99,'r--o');
elseif(ikind==53)
    plot(CARTempsTT.Time,CARTempsTT.Ptile25,'b',CARTempsTT.Time,CARTempsTT.Ptile50,'g',...
        CARTempsTT.Time,CARTempsTT.Ptile75,'k',CARTempsTT.Time,CARTempsTT.Ptile99,'r--o'); 
elseif(ikind==54)
    plot(NamibiaTempsTT.Time,NamibiaTempsTT.Ptile25,'b',NamibiaTempsTT.Time,NamibiaTempsTT.Ptile50,'g',...
        NamibiaTempsTT.Time,NamibiaTempsTT.Ptile75,'k',NamibiaTempsTT.Time,NamibiaTempsTT.Ptile99,'r--o'); 
elseif(ikind==55)
    plot(SomaliaTempsTT.Time,SomaliaTempsTT.Ptile25,'b',SomaliaTempsTT.Time,SomaliaTempsTT.Ptile50,'g',...
        SomaliaTempsTT.Time,SomaliaTempsTT.Ptile75,'k',SomaliaTempsTT.Time,SomaliaTempsTT.Ptile99,'r--o'); 
elseif(ikind==56)
    plot(SudanTempsTT.Time,SudanTempsTT.Ptile25,'b',SudanTempsTT.Time,SudanTempsTT.Ptile50,'g',...
        SudanTempsTT.Time,SudanTempsTT.Ptile75,'k',SudanTempsTT.Time,SudanTempsTT.Ptile99,'r--o'); 
elseif(ikind==57)
    plot(SaudiTempsTT.Time,SaudiTempsTT.Ptile25,'b',SaudiTempsTT.Time,SaudiTempsTT.Ptile50,'g',...
        SaudiTempsTT.Time,SaudiTempsTT.Ptile75,'k',SaudiTempsTT.Time,SaudiTempsTT.Ptile99,'r--o'); 
elseif(ikind==58)
    plot(IranTempsTT.Time,IranTempsTT.Ptile25,'b',IranTempsTT.Time,IranTempsTT.Ptile50,'g',...
        IranTempsTT.Time,IranTempsTT.Ptile75,'k',IranTempsTT.Time,IranTempsTT.Ptile99,'r--o'); 
elseif(ikind==59)
    plot(IraqTempsTT.Time,IraqTempsTT.Ptile25,'b',IraqTempsTT.Time,IraqTempsTT.Ptile50,'g',...
        IraqTempsTT.Time,IraqTempsTT.Ptile75,'k',IraqTempsTT.Time,IraqTempsTT.Ptile99,'r--o'); 
elseif(ikind==60)
    plot(JordanTempsTT.Time,JordanTempsTT.Ptile25,'b',JordanTempsTT.Time,JordanTempsTT.Ptile50,'g',...
        JordanTempsTT.Time,JordanTempsTT.Ptile75,'k',JordanTempsTT.Time,JordanTempsTT.Ptile99,'r--o'); 
elseif(ikind==61)
    plot(SyriaTempsTT.Time,SyriaTempsTT.Ptile25,'b',SyriaTempsTT.Time,SyriaTempsTT.Ptile50,'g',...
        SyriaTempsTT.Time,SyriaTempsTT.Ptile75,'k',SyriaTempsTT.Time,SyriaTempsTT.Ptile99,'r--o'); 
elseif(ikind==62)
    plot(TurkeyTempsTT.Time,TurkeyTempsTT.Ptile25,'b',TurkeyTempsTT.Time,TurkeyTempsTT.Ptile50,'g',...
        TurkeyTempsTT.Time,TurkeyTempsTT.Ptile75,'k',TurkeyTempsTT.Time,TurkeyTempsTT.Ptile99,'r--o'); 
elseif(ikind==63)
    plot(PakistanTempsTT.Time,PakistanTempsTT.Ptile25,'b',PakistanTempsTT.Time,PakistanTempsTT.Ptile50,'g',...
        PakistanTempsTT.Time,PakistanTempsTT.Ptile75,'k',PakistanTempsTT.Time,PakistanTempsTT.Ptile99,'r--o'); 
elseif(ikind==64)
    plot(AfganistanTempsTT.Time,AfganistanTempsTT.Ptile25,'b',AfganistanTempsTT.Time,AfganistanTempsTT.Ptile50,'g',...
        AfganistanTempsTT.Time,AfganistanTempsTT.Ptile75,'k',AfganistanTempsTT.Time,AfganistanTempsTT.Ptile99,'r--o'); 
elseif(ikind==65)
    plot(IndiaTempsTT.Time,IndiaTempsTT.Ptile25,'b',IndiaTempsTT.Time,IndiaTempsTT.Ptile50,'g',...
        IndiaTempsTT.Time,IndiaTempsTT.Ptile75,'k',IndiaTempsTT.Time,IndiaTempsTT.Ptile99,'r--o'); 
end
% Set Up the Time string for the time slice selected
if(iTimeSlice==1)
    TimeStr='-00-Hrs-GMT';
elseif(iTimeSlice==2)
    TimeStr='-01-Hrs-GMT';
elseif(iTimeSlice==3)
    TimeStr='-02-Hrs-GMT';
elseif(iTimeSlice==4)
    TimeStr='-03-Hrs-GMT';
elseif(iTimeSlice==5)
    TimeStr='-04-Hrs-GMT';
elseif(iTimeSlice==6)
    TimeStr='-05-Hrs-GMT';
elseif(iTimeSlice==7)
    TimeStr='-06-Hrs-GMT';
elseif(iTimeSlice==8)
    TimeStr='-07-Hrs-GMT';
elseif(iTimeSlice==9)
    TimeStr='-08-Hrs-GMT';
elseif(iTimeSlice==10)
    TimeStr='-09-Hrs-GMT';
elseif(iTimeSlice==11)
    TimeStr='-10-Hrs-GMT';
elseif(iTimeSlice==12)
    TimeStr='-11-Hrs-GMT';   
elseif(iTimeSlice==13)
    TimeStr='-12-Hrs-GMT';
elseif(iTimeSlice==14)
    TimeStr='-13-Hrs-GMT';
elseif(iTimeSlice==15)
    TimeStr='-14-Hrs-GMT';
elseif(iTimeSlice==16)
    TimeStr='-15-Hrs-GMT';
elseif(iTimeSlice==17)
    TimeStr='-16-Hrs-GMT';
elseif(iTimeSlice==18)
    TimeStr='-17-Hrs-GMT'; 
elseif(iTimeSlice==19)
    TimeStr='-18-Hrs-GMT';
elseif(iTimeSlice==20)
    TimeStr='-19-Hrs-GMT';
elseif(iTimeSlice==21)
    TimeStr='-20-Hrs-GMT';
elseif(iTimeSlice==22)
    TimeStr='-21-Hrs-GMT';
elseif(iTimeSlice==23)
    TimeStr='-22-Hrs-GMT';
elseif(iTimeSlice==24)
    TimeStr='-23-Hrs-GMT';      
end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);

if(ikind==40)
    hl=legend('Africa Air Temps 25 PTile','Africa Air Temps 50 PTile','Africa Air Temps 75 PTile',...
        'Africa Air Temps 99 PTile','Location','best');
elseif(ikind==41)
     hl=legend('Algeria Air Temps 25 PTile','Algeria Air Temps 50 PTile','Algeria Air Temps 75 PTile',...
        'Algeria Air Temps 99 PTile','Location','best'); 
elseif(ikind==42)
     hl=legend('Chad Air Temps 25 PTile','Chad Air Temps 50 PTile','Chad Air Temps 75 PTile',...
        'Chad Air Temps 99 PTile','Location','best'); 
elseif(ikind==43)
     hl=legend('Egypt Air Temps 25 PTile','Egypyt Air Temps 50 PTile','Egypt Air Temps 75 PTile',...
        'Egypt Air Temps 99 PTile','Location','best');
elseif(ikind==44)
     hl=legend('Libya Air Temps 25 PTile','Libya Air Temps 50 PTile','Libya Air Temps 75 PTile',...
        'Libya Air Temps 99 PTile','Location','best');
elseif(ikind==45)
     hl=legend('Angola Air Temps 25 PTile','Angola Air Temps 50 PTile','Angola Air Temps 75 PTile',...
        'Angola Air Temps 99 PTile','Location','best');
elseif(ikind==46)
     hl=legend('Nigeria Air Temps 25 PTile','Nigeria Air Temps 50 PTile','Nigeria Air Temps 75 PTile',...
        'Nigeria Air Temps 99 PTile','Location','best');
elseif(ikind==47)
     hl=legend('Kenya Air Temps 25 PTile','Kenya Air Temps 50 PTile','Kenya Air Temps 75 PTile',...
        'Kenya Air Temps 99 PTile','Location','best');
elseif(ikind==48)
     hl=legend('Mozambique Air Temps 25 PTile','Mozambique Air Temps 50 PTile','Mozambique Air Temps 75 PTile',...
        'Mozambique Air Temps 99 PTile','Location','best');
elseif(ikind==49)
     hl=legend('Ethiopia Air Temps 25 PTile','Ethiopia Air Temps 50 PTile','Ethiopia Air Temps 75 PTile',...
        'Ethiopia Air Temps 99 PTile','Location','best');
elseif(ikind==50)
     hl=legend('Madagascar Air Temps 25 PTile','Madagascar Air Temps 50 PTile','Madagascar Air Temps 75 PTile',...
        'Madagascar Air Temps 99 PTile','Location','best');
elseif(ikind==51)
     hl=legend('South Africa Air Temps 25 PTile','South Africa Air Temps 50 PTile','South Africa Air Temps 75 PTile',...
        'South Africa Air Temps 99 PTile','Location','best');
elseif(ikind==52)
     hl=legend('CDR Air Temps 25 PTile','CDR Air Temps 50 PTile','CDR Air Temps 75 PTile',...
        'CDR Air Temps 99 PTile','Location','best');
elseif(ikind==53)
     hl=legend('CAR Air Temps 25 PTile','CAR Air Temps 50 PTile','CAR Air Temps 75 PTile',...
        'CAR Air Temps 99 PTile','Location','best');
elseif(ikind==54)
     hl=legend('Namibia Air Temps 25 PTile','Namibia Air Temps 50 PTile','Namibia Air Temps 75 PTile',...
        'Namibia Air Temps 99 PTile','Location','best');
elseif(ikind==55)
     hl=legend('Somalia Air Temps 25 PTile','Somalia Air Temps 50 PTile','Somalia Air Temps 75 PTile',...
        'Somalia Air Temps 99 PTile','Location','best');
elseif(ikind==56)
     hl=legend('Sudan Air Temps 25 PTile','Sudan Air Temps 50 PTile','Sudan Air Temps 75 PTile',...
        'Sudan Air Temps 99 PTile','Location','best');
elseif(ikind==57)
     hl=legend('Saudi Air Temps 25 PTile','Saudi Air Temps 50 PTile','Saudi Air Temps 75 PTile',...
        'Saudi Air Temps 99 PTile','Location','best');
elseif(ikind==58)
     hl=legend('Iran Air Temps 25 PTile','Iran Air Temps 50 PTile','Iran Air Temps 75 PTile',...
        'Iran Air Temps 99 PTile','Location','best');
elseif(ikind==59)
     hl=legend('Iraq Air Temps 25 PTile','Iraq Air Temps 50 PTile','Iraq Air Temps 75 PTile',...
        'Iraq Air Temps 99 PTile','Location','best');
elseif(ikind==60)
     hl=legend('Jordan Air Temps 25 PTile','Jordan Air Temps 50 PTile','Jordan Air Temps 75 PTile',...
        'Jordan Air Temps 99 PTile','Location','best');
elseif(ikind==61)
     hl=legend('Syria Air Temps 25 PTile','Syria Air Temps 50 PTile','Syria Air Temps 75 PTile',...
        'Syria Air Temps 99 PTile','Location','best');
elseif(ikind==62)
     hl=legend('Turkey Air Temps 25 PTile','Turkey Air Temps 50 PTile','Turkey Air Temps 75 PTile',...
        'Turkey Air Temps 99 PTile','Location','best');
elseif(ikind==63)
     hl=legend('Pakistan Air Temps 25 PTile','Pakistan Air Temps 50 PTile','Pakistan Air Temps 75 PTile',...
        'Pakistan Air Temps 99 PTile','Location','best');
elseif(ikind==64)
     hl=legend('Afganistan Air Temps 25 PTile','Afganistan Air Temps 50 PTile','Afganistan Air Temps 75 PTile',...
        'Afganistan Air Temps 99 PTile','Location','best');
elseif(ikind==65)
     hl=legend('India Air Temps 25 PTile','India Air Temps 50 PTile','India Air Temps 75 PTile',...
        'India Air Temps 99 PTile','Location','best');
end

ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
if(ikind==40)
    ylabel('Africa Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==41)
    ylabel('Algeria Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==42)
    ylabel('Chad Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==43)
    ylabel('Egypt Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==44)
    ylabel('Libya Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==45)
    ylabel('Nigeria Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==46)
    ylabel('Nigeria Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==47)
    ylabel('Kenya Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==48)
    ylabel('Mozambique Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==49)
    ylabel('Ethiopia Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==50)
    ylabel('MadagascarAir Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==51)
    ylabel('South Africa Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==52)
    ylabel('CDR Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==53)
    ylabel('CAR Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==54)
    ylabel('Namibia Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==55)
    ylabel('Somalia Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==56)
    ylabel('Sudan Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==57)
    ylabel('Saudi Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==58)
    ylabel('Iran Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==59)
    ylabel('Iraq Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==60)
    ylabel('Jordan Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==61)
    ylabel('Syria Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==62)
    ylabel('Turkey Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==63)
    ylabel('Pakistan Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==64)
    ylabel('Afganistan Air Temps Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==65)
    ylabel('India Air Temps Deg-C','FontWeight','bold','FontSize',12);


end

%% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .1,.04,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
%% Add data to PDF Report
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
    if(iNewChapter)
        headingstr1='Tabular Analysis Global Results Dataset03';
        chapter = Chapter("Title",headingstr1);
    end
    if(ikind==1)
        sectionstr=strcat('Geopotential Height','-Whole World','-Map');
    elseif(ikind==2)
        sectionstr=strcat('Ozone Ratio','-Whole World','-Map');
    elseif(ikind==3)
        sectionstr=strcat('Surface Pressure','-Whole World','-Map');
    elseif(ikind==4)
        sectionstr=strcat('Specific Humidity','-Whole World','-Map');
    elseif(ikind==5)
        sectionstr=strcat('Sea Level Pressure','-Whole World','-Map');
    elseif(ikind==6)
        sectionstr=strcat('Air Temperature','-Whole World','-Map');
    elseif(ikind==7)
        sectionstr=strcat('East Wind','-Whole World','-Map');
    elseif(ikind==8)
        sectionstr=strcat('North Wind','-Whole World','-Map');
    end    
    add(chapter,Section(sectionstr));
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(' Dateset03 Variables-',Merra2ShortFileName);
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
    if(ikind==1)
        parastr2='This is the monthly averaged Geopotential Height over the globe.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==2)
        parastr2='This is the montly average ozone mixing ratio over the globe.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==3)
        parastr2='This is the montly average surface pressure over the globe.';
        parastr3=' Data displayed if for a local surface height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=' Variations in the local surface height are the big driver.';
    elseif(ikind==4)
        parastr2='This is the monthly averaged specific humidity over the study period.';
        parastr3=' Data displayed if for one pressure level over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=' Moisture content drives atmospheric dynamics.';
    elseif(ikind==5)
        parastr2='This is the monthly averaged sea level pressure over the study period.';
        parastr3=' Data displayed if for sea levelpressure over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=' This compares the pressure at a consistent level but has gaps where the ground is higher than sea level.';
    elseif(ikind==6)
        parastr2='This is monthly averaged air temp over the earth for the study period.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==7)
        parastr2='This is monthly averaged east wind over the earth for the study period.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==8)
        parastr2='This is monthly averaged north wind over the earth for the study period.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(ikind==1)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(HSTT.Properties.RowTimes);
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
        Hdrs{1,4}='HS01';
        Hdrs{1,5}='HS25';
        Hdrs{1,6}='HS50';
        Hdrs{1,7}='HS75';
        Hdrs{1,8}='HS90';
        Hdrs{1,9}='HS100';
        Col1=HSTable.HS01;
        Col2=HSTable.HS25;
        Col3=HSTable.HS50;
        Col4=HSTable.HS75;
        Col5=HSTable.HS90;
        Col6=HSTable.HS100;
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
            NumberFormat("%5.2f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global Geopotential Height';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Geopotential Height over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==2)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(O3STT.Properties.RowTimes);
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
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='O3S01';
        Hdrs{1,5}='O3S25';
        Hdrs{1,6}='O3S50';
        Hdrs{1,7}='O3S75';
        Hdrs{1,8}='O3S90';
        Hdrs{1,9}='O3S100';
        Col1=O3STable.O3S01;
        Col2=O3STable.O3S25;
        Col3=O3STable.O3S50;
        Col4=O3STable.O3S75;
        Col5=O3STable.O3S90;
        Col6=O3STable.O3S100;
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
            NumberFormat("%8.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Average Ozone Ratio';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Ozone Ratio over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' The Mixing Ratio is in units of kg/kg.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==3)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(PSSTT.Properties.RowTimes);
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
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='PSS01';
        Hdrs{1,5}='PSS25';
        Hdrs{1,6}='PSS50';
        Hdrs{1,7}='PSS75';
        Hdrs{1,8}='PSS90';
        Hdrs{1,9}='PSS100';
        Col1=PSSTable.PSS01;
        Col2=PSSTable.PSS25;
        Col3=PSSTable.PSS50;
        Col4=PSSTable.PSS75;
        Col5=PSSTable.PSS90;
        Col6=PSSTable.PSS100;
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
            NumberFormat("%8.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Average Surface Pressure';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged surface pressure over the globe.';
        parastr602=' The values shown are for a single time and the local surface height not a pressure level ';
        parastr603=' The the surface pressure is in units of Pa.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==4)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(QVSTT.Properties.RowTimes);
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
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='QVS01';
        Hdrs{1,5}='QVS25';
        Hdrs{1,6}='QVS50';
        Hdrs{1,7}='QVS75';
        Hdrs{1,8}='QVS90';
        Hdrs{1,9}='QVS100';
        Col1=QVSTable.QVS01;
        Col2=QVSTable.QVS25;
        Col3=QVSTable.QVS50;
        Col4=QVSTable.QVS75;
        Col5=QVSTable.QVS90;
        Col6=QVSTable.QVS100;
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
            NumberFormat("%4.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Specific Humidity';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows monthly averaged specific humidity values over the world.';
        parastr602=' The values shown are for a single time and the local surface height not a pressure level ';
        parastr603=' The the surface pressure is in units of Pa.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609); 
     elseif(ikind==5)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SLPSTT.Properties.RowTimes);
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
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SLPS01';
        Hdrs{1,5}='SLPS25';
        Hdrs{1,6}='SLPS50';
        Hdrs{1,7}='SLPS75';
        Hdrs{1,8}='SLPS90';
        Hdrs{1,9}='SLPS100';
        Col1=SLPSTable.SLPS01;
        Col2=SLPSTable.SLPS25;
        Col3=SLPSTable.SLPS50;
        Col4=SLPSTable.SLPS75;
        Col5=SLPSTable.SLPS90;
        Col6=SLPSTable.SLPS100;
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
            NumberFormat("%4.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Sea Level Pressure';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows monthly averaged sea level pressure  over the world.';
        parastr602=' The values shown are for a single time at sea level not a pressure level ';
        parastr603=' The the sea level pressure is in units of Pa.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609); 
     elseif(ikind==6)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(TSTT.Properties.RowTimes);
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
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='TS01';
        Hdrs{1,5}='TS25';
        Hdrs{1,6}='TS50';
        Hdrs{1,7}='TS75';
        Hdrs{1,8}='TS90';
        Hdrs{1,9}='TS100';
        Col1=TSTable.TS01;
        Col2=TSTable.TS25;
        Col3=TSTable.TS50;
        Col4=TSTable.TS75;
        Col5=TSTable.TS90;
        Col6=TSTable.TS100;
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
            NumberFormat("%4.1f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global Temp';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Temperature over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Temperature units are in Deg-C.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==7)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(USTT.Properties.RowTimes);
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
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='US01';
        Hdrs{1,5}='US25';
        Hdrs{1,6}='US50';
        Hdrs{1,7}='US75';
        Hdrs{1,8}='US90';
        Hdrs{1,9}='US100';
        Col1=USTable.US01;
        Col2=USTable.US25;
        Col3=USTable.US50;
        Col4=USTable.US75;
        Col5=USTable.US90;
        Col6=USTable.US100;
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
            NumberFormat("%4.1f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global East Wind';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged East Wind over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Wind Magnitude is units are m/sec';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==8)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(VSTT.Properties.RowTimes);
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
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='VS01';
        Hdrs{1,5}='VS25';
        Hdrs{1,6}='VS50';
        Hdrs{1,7}='VS75';
        Hdrs{1,8}='VS90';
        Hdrs{1,9}='VS100';
        Col1=VSTable.VS01;
        Col2=VSTable.VS25;
        Col3=VSTable.VS50;
        Col4=VSTable.VS75;
        Col5=VSTable.VS90;
        Col6=VSTable.VS100;
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
            NumberFormat("%4.1f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global North Wind';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged North Wind over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Wind Magnitude is units are m/sec';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);


     end




    if(iCloseChapter==1)
        add(rpt,chapter);
    end
end
    close('all')
end