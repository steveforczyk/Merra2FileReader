function PlotQV10MTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the PS Table Values
% 
%
% Written By: Stephen Forczyk
% Created: May 24,2023
% Revised: ----
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global QV10MTable QV10MTT QV2MTable QV2MTT;
global QV10M10 QV10M25 QV10M50 QV10M75 QV10M90 QV10M100 QV10MLow QV10MHigh QV10MNaN QV10MValues;
global QV2M10 QV2M25 QV2M50 QV2M75 QV2M90 QV2M100 QV2MLow QV2MHigh QV2MNaN QV2MValues;
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
if(ikind==5)
    plot(QV10MTT.Time,QV10MTT.QV10M25,'b',QV10MTT.Time,QV10MTT.QV10M50,'g',...
        QV10MTT.Time,QV10MTT.QV10M75,'k',QV10MTT.Time,QV10MTT.QV10M90,'r');
elseif(ikind==6)
    plot(QV2MTT.Time,QV2MTT.QV2M25,'b',QV2MTT.Time,QV2MTT.QV2M50,'g',...
        QV2MTT.Time,QV2MTT.QV2M75,'k',QV2MTT.Time,QV2MTT.QV2M90,'r');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==5)
    hl=legend('QV10M 25 ptile','QV10M 50 ptile','QV10M 75 ptile','QV10M 90 ptile');
elseif(ikind==6)
    hl=legend('QV2M 25 ptile','QV2M 50 ptile','QV2M 75 ptile','QV2M 90 ptile');
end
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);

if(ikind==5)
    ylabel('QV10M','FontWeight','bold','FontSize',12);
elseif(ikind==6)
    ylabel('QV2M','FontWeight','bold','FontSize',12);
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
    if(ikind==5)
        sectionstr=strcat('QV10M','-Map');
    elseif(ikind==6)
        sectionstr=strcat('QV2M','-Map');
    end
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(' QV Map For File-',Merra2ShortFileName);
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
    parastr2='This metric is the value of the specific humidity.';
    parastr3='The expected data range for this dataset is from 0 to 1 in kg/kg.';
    parastr9=strcat(parastr1,parastr2,parastr3);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
close('all')
end