function PlotTotalFracCloudTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is the first attempt at plotting the High Cloud Fraction  Table Values
%  Later this may be rewritten to handle multiple types of tables
%
% Written By: Stephen Forczyk
% Created: April 11,2023
% Revised: April 16,2023 added capability to add this to the PDF Report
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global AlbedoTable AlbedoTT CLDHGHTable CLDHGHTT CLDTOTTable CLDTOTTT;
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
plot(CLDTOTTT.Time,CLDTOTTT.CLDTOT10,'b',CLDTOTTT.Time,CLDTOTTT.CLDTOT50,'g',...
    CLDTOTTT.Time,CLDTOTTT.CLDTOT70,'c',CLDTOTTT.Time,CLDTOTTT.CLDTOT90,'r');
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
hl=legend('Tot CLD Frac 10 ptile','Tot CLD Frac 50 ptile','Tot CLD Frac 70 ptile','Tot CLD Frac 90 ptile');
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
ylabel('Monthly Tot Cloud Frac Average','FontWeight','bold','FontSize',12);
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
    sectionstr=strcat('CLOUDTOT','-Map');
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(' CLOUDTOT Map For File-',Merra2ShortFileName);
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
    parastr2='This metric is a monthly average of the total cloud fraction at all levels.';
    parastr3='The valid data range for this dataset is from 0 to 1 and is dimensionless .';
    parastr9=strcat(parastr1,parastr2,parastr3);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end

end
close('all')
end