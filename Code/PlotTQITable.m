function PlotTQITable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the TQI and related Table Values
% 
%
% Written By: Stephen Forczyk
% Created: May 29,2023
% Revised: ----
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global TQITable TQITT;
global TQI10 TQI25 TQI50 TQI75 TQI90 TQI100 TQILow TQIHigh TQINaN TQIValues;
global TQLTable TQLTT;
global TQL10 TQL25 TQL50 TQL75 TQL90 TQL100 TQLLow TQLHigh TQLNaN TQLValues;
global TQVTable TQVTT;
global TQV10 TQV25 TQV50 TQV75 TQV90 TQV100 TQVLow TQVHigh TQVNaN TQVValues;
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
if(ikind==13)
    plot(TQITT.Time,TQITT.TQI25,'b',TQITT.Time,TQITT.TQI50,'g',...
        TQITT.Time,TQITT.TQI75,'k',TQITT.Time,TQITT.TQI90,'r');
elseif(ikind==14)
    plot(TQLTT.Time,TQLTT.TQL25,'b',TQLTT.Time,TQLTT.TQL50,'g',...
    TQLTT.Time,TQLTT.TQL75,'k',TQLTT.Time,TQLTT.TQL90,'r');
elseif(ikind==15)
    plot(TQVTT.Time,TQVTT.TQV25,'b',TQVTT.Time,TQVTT.TQV50,'g',...
    TQVTT.Time,TQVTT.TQV75,'k',TQVTT.Time,TQVTT.TQV90,'r');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==13)
    hl=legend('TQI 25 ptile','TQI 50 ptile','TQI 75 ptile','TQI 90 ptile');
elseif(ikind==14)
    hl=legend('TQL 25 ptile','TQL 50 ptile','TQL 75 ptile','TQL 90 ptile');
elseif(ikind==15)
    hl=legend('TQV 25 ptile','TQV 50 ptile','TQV 75 ptile','TQV 90 ptile');
end
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);

if(ikind==13)
    ylabel('TQI','FontWeight','bold','FontSize',12);
elseif(ikind==14)
    ylabel('TQL','FontWeight','bold','FontSize',12);
elseif(ikind==15)
    ylabel('TQV','FontWeight','bold','FontSize',12);
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
    if(ikind==13)
        sectionstr=strcat('TQI','-Map');
    elseif(ikind==14)
        sectionstr=strcat('TQL','-Map');
    elseif(ikind==15)
        sectionstr=strcat('TQV','-Map');
    end
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(' TQ Map For File-',Merra2ShortFileName);
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
    parastr2='This metric is the value of the total precipitable ice/liquid water or water vapor.';
    parastr3='The expected data range for this dataset is from 0 to 1 in kg/m^2.';
    parastr9=strcat(parastr1,parastr2,parastr3);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
close('all')
end