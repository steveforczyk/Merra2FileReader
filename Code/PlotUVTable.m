function PlotUVTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the six UV tables
% These are U10 U2 U50 (East wind components at 3 altitudes
% An the corresponding V10 V2 and V50 tables
% Written By: Stephen Forczyk
% Created: June 03,2023
% Revised: ----
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global U10MTable U10MTT;
global U10M10 U10M25 U10M50 U10M75 U10M90 U10M100 U10MLow U10MHigh U10MNaN U10MValues;
global U2MTable U2MTT;
global U2M10 U2M25 U2M50 U2M75 U2M90 U2M100 U2MLow U2MHigh U2MNaN U2MValues;
global U50MTable U50MTT;
global U50M10 U50M25 U50M50 U50M75 U50M90 U50M100 U50MLow U50MHigh U50MNaN U50MValues;
global V10MTable V10MTT;
global V10M10 V10M25 V10M50 V10M75 V10M90 V10M100 V10MLow V10MHigh V10MNaN V10MValues;
global V2MTable V2MTT;
global V2M10 V2M25 V2M50 V2M75 V2M90 V2M100 V2MLow V2MHigh V2MNaN V2MValues;
global V50MTable V50MTT;
global V50M10 V50M25 V50M50 V50M75 V50M90 V50M100 V50MLow V50MHigh V50MNaN V50MValues;
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
if(ikind==22)
    plot(U10MTT.Time,U10MTT.U10M25,'b',U10MTT.Time,U10MTT.U10M50,'g',...
        U10MTT.Time,U10MTT.U10M75,'k',U10MTT.Time,U10MTT.U10M90,'r');
elseif(ikind==23)
    plot(U2MTT.Time,U2MTT.U2M25,'b',U2MTT.Time,U2MTT.U2M50,'g',...
    U2MTT.Time,U2MTT.U2M75,'k',U2MTT.Time,U2MTT.U2M90,'r');
elseif(ikind==24)
    plot(U50MTT.Time,U50MTT.U50M25,'b',U50MTT.Time,U50MTT.U50M50,'g',...
    U50MTT.Time,U50MTT.U50M75,'k',U50MTT.Time,U50MTT.U50M90,'r');
elseif(ikind==25)
    plot(V10MTT.Time,V10MTT.V10M25,'b',V10MTT.Time,V10MTT.V10M50,'g',...
    V10MTT.Time,V10MTT.V10M75,'k',V10MTT.Time,V10MTT.V10M90,'r');
elseif(ikind==26)
    plot(V2MTT.Time,V2MTT.V2M25,'b',V2MTT.Time,V2MTT.V2M50,'g',...
    V2MTT.Time,V2MTT.V2M75,'k',V2MTT.Time,V2MTT.V2M90,'r');
elseif(ikind==27)
    plot(V50MTT.Time,V50MTT.V50M25,'b',V50MTT.Time,V50MTT.V50M50,'g',...
    V50MTT.Time,V50MTT.V50M75,'k',V50MTT.Time,V50MTT.V50M90,'r');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==22)
    hl=legend('U10M 25 ptile','U10M 50 ptile','U10M 75 ptile','U10M 90 ptile');
elseif(ikind==23)
    hl=legend('U2M 25 ptile','U2M 50 ptile','U2M 75 ptile','U2M 90 ptile');
elseif(ikind==24)
    hl=legend('U50M 25 ptile','U50M 50 ptile','U50M 75 ptile','U50M 90 ptile');
elseif(ikind==25)
    hl=legend('V10M 25 ptile','V10M 50 ptile','V10M 75 ptile','V10M 90 ptile');
elseif(ikind==26)
    hl=legend('V2M 25 ptile','V2M 50 ptile','V2M 75 ptile','V2M 90 ptile');
elseif(ikind==27)
    hl=legend('V50M 25 ptile','V50M 50 ptile','V50M 75 ptile','V50M 90 ptile');
end
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);

if(ikind==22)
    ylabel('U10M','FontWeight','bold','FontSize',12);
elseif(ikind==23)
    ylabel('U2M','FontWeight','bold','FontSize',12);
elseif(ikind==24)
    ylabel('U50M','FontWeight','bold','FontSize',12);
elseif(ikind==25)
    ylabel('V10M','FontWeight','bold','FontSize',12);
elseif(ikind==26)
    ylabel('V2M','FontWeight','bold','FontSize',12);
elseif(ikind==27)
    ylabel('V50M','FontWeight','bold','FontSize',12);
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
    if(ikind==22)
        sectionstr=strcat('U10M','-Map');
    elseif(ikind==23)
        sectionstr=strcat('U2M','-Map');
    elseif(ikind==24)
        sectionstr=strcat('U50M','-Map');
    elseif(ikind==25)
        sectionstr=strcat('V10M','-Map');
    elseif(ikind==26)
        sectionstr=strcat('V2M','-Map');
    elseif(ikind==27)
        sectionstr=strcat('V50M','-Map');
    end
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    if(ikind==22)
        pdftxtstr=strcat(' U10M Map For File-',Merra2ShortFileName);
    elseif(ikind==23)
        pdftxtstr=strcat(' U2M For File-',Merra2ShortFileName);
    elseif(ikind==24)
        pdftxtstr=strcat(' U50M For File-',Merra2ShortFileName);
    elseif(ikind==25)
        pdftxtstr=strcat(' V10M For File-',Merra2ShortFileName);
    elseif(ikind==26)
        pdftxtstr=strcat(' V2M For File-',Merra2ShortFileName);
    elseif(ikind==27)
        pdftxtstr=strcat(' V50M For File-',Merra2ShortFileName);
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
    if((ikind>=22) || (ikind<=24))
        parastr2='This metric is the value of the East Wind Component.';
        parastr3='The expected data range for this dataset is from 0 to 50 m/s.';
    else
        parastr2='This metric is the value of the North Wind Component .';
        parastr3='The expected data range for this dataset is from 0 to 50 m/s.';
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