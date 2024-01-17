function PlotTROPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the TROPPB and related Table Values
% 
%
% Written By: Stephen Forczyk
% Created: May 30,2023
% Revised: May 31,2023 added more variables
% Revised: Jun 01,2023 adding more variables
% Revised: Jun 02,2023 adding TS variable
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global TQITable TQITT;
global TQI10 TQI25 TQI50 TQI75 TQI90 TQI100 TQILow TQIHigh TQINaN TQIValues;
global TQLTable TQLTT;
global TQL10 TQL25 TQL50 TQL75 TQL90 TQL100 TQLLow TQLHigh TQLNaN TQLValues;
global TQVTable TQVTT;
global TQV10 TQV25 TQV50 TQV75 TQV90 TQV100 TQVLow TQVHigh TQVNaN TQVValues;
global TROPPBTable TROPPBTT;
global TROPPB10 TROPPB25 TROPPB50 TROPPB75 TROPPB90 TROPPB100 TROPPBLow TROPPBHigh TROPPBNaN TROPPBValues;
global TROPPTTable TROPPTTT;
global TROPPT10 TROPPT25 TROPPT50 TROPPT75 TROPPT90 TROPPT100 TROPPTLow TROPPTHigh TROPPTNaN TROPPTValues;
global TROPPVTable TROPPVTT;
global TROPPV10 TROPPV25 TROPPV50 TROPPV75 TROPPV90 TROPPV100 TROPPVLow TROPPVHigh TROPPVNaN TROPPVValues;
global TROPQTable TROPQTT;
global TROPQ10 TROPQ25 TROPQ50 TROPQ75 TROPQ90 TROPQ100 TROPQLow TROPQHigh TROPQNaN TROPQValues;
global TROPTTable TROPTTT;
global TROPT10 TROPT25 TROPT50 TROPT75 TROPT90 TROPT100 TROPTLow TROPTHigh TROPTNaN TROPTValues;
global TSTable TSTT;
global TS10 TS25 TS50 TS75 TS90 TS100 TSLow TSHigh TSNaN TSValues;
global Merra2ShortFileName;

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
if(ikind==16)
    plot(TROPPBTT.Time,TROPPBTT.TROPPB25,'b',TROPPBTT.Time,TROPPBTT.TROPPB50,'g',...
        TROPPBTT.Time,TROPPBTT.TROPPB75,'k',TROPPBTT.Time,TROPPBTT.TROPPB90,'r');
elseif(ikind==17)
    plot(TROPPTTT.Time,TROPPTTT.TROPPT25,'b',TROPPTTT.Time,TROPPTTT.TROPPT50,'g',...
    TROPPTTT.Time,TROPPTTT.TROPPT75,'k',TROPPTTT.Time,TROPPTTT.TROPPT90,'r');
elseif(ikind==18)
    plot(TROPPVTT.Time,TROPPVTT.TROPPV25,'b',TROPPVTT.Time,TROPPVTT.TROPPV50,'g',...
    TROPPVTT.Time,TROPPVTT.TROPPV75,'k',TROPPVTT.Time,TROPPVTT.TROPPV90,'r');
elseif(ikind==19)
    plot(TROPQTT.Time,TROPQTT.TROPQ25,'b',TROPQTT.Time,TROPQTT.TROPQ50,'g',...
    TROPQTT.Time,TROPQTT.TROPQ75,'k',TROPQTT.Time,TROPQTT.TROPQ90,'r');
elseif(ikind==20)
    plot(TROPTTT.Time,TROPTTT.TROPT25,'b',TROPTTT.Time,TROPTTT.TROPT50,'g',...
    TROPTTT.Time,TROPTTT.TROPT75,'k',TROPTTT.Time,TROPTTT.TROPT90,'r');
elseif(ikind==21)
    plot(TSTT.Time,TSTT.TS25,'b',TSTT.Time,TSTT.TS50,'g',...
    TSTT.Time,TSTT.TS75,'k',TSTT.Time,TSTT.TS90,'r');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==16)
    hl=legend('TROPPB 25 ptile','TROPPB 50 ptile','TROPPB 75 ptile','TROPPB 90 ptile');
elseif(ikind==17)
    hl=legend('TROPPT 25 ptile','TROPPT 50 ptile','TROPPT 75 ptile','TROPPT 90 ptile');
elseif(ikind==18)
    hl=legend('TROPPV 25 ptile','TROPPV 50 ptile','TROPPV 75 ptile','TROPPV 90 ptile');
elseif(ikind==19)
    hl=legend('TROPQ 25 ptile','TROPQ 50 ptile','TROPQ 75 ptile','TROPQ 90 ptile');
elseif(ikind==20)
    hl=legend('TROPT 25 ptile','TROPT 50 ptile','TROPT 75 ptile','TROPT 90 ptile');
elseif(ikind==21)
    hl=legend('TS 25 ptile','TS 50 ptile','TS 75 ptile','TS 90 ptile');
end
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);

if(ikind==16)
    ylabel('TROPPB','FontWeight','bold','FontSize',12);
elseif(ikind==17)
    ylabel('TROPPT','FontWeight','bold','FontSize',12);
elseif(ikind==18)
    ylabel('TROPPV','FontWeight','bold','FontSize',12);
elseif(ikind==19)
    ylabel('TROPQ','FontWeight','bold','FontSize',12);
elseif(ikind==20)
    ylabel('TROPT','FontWeight','bold','FontSize',12);
elseif(ikind==21)
    ylabel('TS','FontWeight','bold','FontSize',12);
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
        headingstr1=strcat('Tabular Analysis Results For-',Merra2ShortFileName);
        chapter = Chapter("Title",headingstr1);
    end
    if(ikind==16)
        sectionstr=strcat('TROPPB','-Map');
    elseif(ikind==17)
        sectionstr=strcat('TROPPT','-Map');
    elseif(ikind==18)
        sectionstr=strcat('TROPPV','-Map');
    elseif(ikind==19)
        sectionstr=strcat('TROPQ','-Map');
    elseif(ikind==20)
        sectionstr=strcat('TROPT','-Map');
    elseif(ikind==21)
        sectionstr=strcat('TS','-Map');
    end
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    if(ikind<21)
        pdftxtstr=strcat(' TROPP Map For File-',Merra2ShortFileName);
    elseif(ikind==21)
        pdftxtstr=strcat(' TS Map For File-',Merra2ShortFileName);
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
    if(ikind<21)
        parastr2='This metric is the value of the Tropospheric pressure based on different estimation techniques .';
        parastr3='The expected data range for this dataset is from 0 to 20 in psi.';
    elseif(ikind==21)
        parastr2='This metric is the value of the earth surface temperature .';
        parastr3='The expected data range for this dataset is from 200 to 400 deg K.';
    end
    parastr9=strcat(parastr1,parastr2,parastr3);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
close('all')
end