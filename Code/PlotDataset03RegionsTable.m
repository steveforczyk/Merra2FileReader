function PlotDataset03RegionsTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function plots some timetables created by Dataset03
% that are of masked geographic regions.Currently there are 10 defined
% regions and more could be added later

% Written By: Stephen Forczyk
% Created: Dec 9,2023
% Revised: Dec 11,2023 added specific humidity data
% Revised: Dec 12,2023 added Ozone Mixing Ratio

% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global TSTable TSTT HSTable HSTT O3STable O3STT SLPSTable SLPSTT;
global QVSTable QVSTT PSSTable PSSTT USTable USTT VSTable VSTT;
global ROIArea ROIPts ROIFracPts numgridpts Merra2WorkingMask;
global TSStats TSStatsTable TSSTT TSStats2Table TSS2TT;
global QVStats QVStatsTable QVStatTT QVStats2Table QVStat2TT;
global O3Stats O3StatsTable O3StatTT O3Stats2Table O3Stat2TT;

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

if(iTimeSlice==1)
    TimeStr='-00-Hrs-GMT';
elseif(iTimeSlice==2)
    TimeStr='-06-Hrs-GMT';
elseif(iTimeSlice==3)
    TimeStr='-12-Hrs-GMT';
elseif(iTimeSlice==4)
    TimeStr='-18-Hrs-GMT';
end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(ikind==10)
    plot(TSSTT.Time,TSSTT.Germany,'b',TSSTT.Time,TSSTT.Finland,'g',...
        TSSTT.Time,TSSTT.UK,'k',TSSTT.Time,TSSTT.Sudan,'c',...
        TSSTT.Time,TSSTT.SouthAfrica,'r'); 
elseif(ikind==11)
    plot(TSS2TT.Time,TSS2TT.India,'b',TSS2TT.Time,TSS2TT.Australia,'g',...
        TSS2TT.Time,TSS2TT.California,'k',TSS2TT.Time,TSS2TT.Texas,'c',...
        TSS2TT.Time,TSS2TT.Peru,'r'); 
elseif(ikind==12)
    plot(QVStatTT.Time,QVStatTT.Germany,'b',QVStatTT.Time,QVStatTT.Finland,'g',...
        QVStatTT.Time,QVStatTT.UK,'k',QVStatTT.Time,QVStatTT.Sudan,'c',...
        QVStatTT.Time,QVStatTT.SouthAfrica,'r'); 
elseif(ikind==13)
    plot(QVStat2TT.Time,QVStat2TT.India,'b',QVStat2TT.Time,QVStat2TT.Australia,'g',...
        QVStat2TT.Time,QVStat2TT.California,'k',QVStat2TT.Time,QVStat2TT.Texas,'c',...
        QVStat2TT.Time,QVStat2TT.Peru,'r');
elseif(ikind==14)
    plot(O3StatTT.Time,O3StatTT.Germany,'b',O3StatTT.Time,O3StatTT.Finland,'g',...
        O3StatTT.Time,O3StatTT.UK,'k',O3StatTT.Time,O3StatTT.Sudan,'c',...
        O3StatTT.Time,O3StatTT.SouthAfrica,'r'); 
elseif(ikind==15)
    plot(O3Stat2TT.Time,O3Stat2TT.India,'b',O3Stat2TT.Time,O3Stat2TT.Australia,'g',...
        O3Stat2TT.Time,O3Stat2TT.California,'k',O3Stat2TT.Time,O3Stat2TT.Texas,'c',...
        O3Stat2TT.Time,O3Stat2TT.Peru,'r');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==10)
    hl=legend('Median Temp-Germany','Median Temp-Finland','Median Temp-UK','Median Temp-Sudan',...
        'Median Temp-South Africa');
elseif(ikind==11)
    hl=legend('Median Temp-India','Median Temp-Australia','Median Temp-California','Median Temp-Texas',...
        'Median Temp-Peru');
elseif(ikind==12)
    hl=legend('Median QV-Germany','Median QV-Finland','Median QV-UK','Median QV-Sudan',...
        'Median QV-South Africa');
elseif(ikind==13)
    hl=legend('Median QV-India','Median QV-Australia','Median QV-California','Median QV-Texas',...
        'Median QV-Peru');
elseif(ikind==14)
    hl=legend('Median O3 Ratio-Germany','Median O3 Ratio-Finland','Median O3 Ratio-UK','Median O3 Ratio-Sudan',...
        'Median O3 Ratio-South Africa');
elseif(ikind==15)
    hl=legend('Median O3 Ratio-India','Median O3 Ratio-Australia','Median O3 Ratio-California','Median O3 Ratio-Texas',...
        'Median O3 Ratio-Peru');
end

ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
if(ikind==10)
    ylabel('Median Temp Deg-C','FontWeight','bold','FontSize',12); 
elseif(ikind==11)
    ylabel('Median Temp Deg-C','FontWeight','bold','FontSize',12); 
elseif(ikind==12)
    ylabel('Median QV kg/kg','FontWeight','bold','FontSize',12); 
elseif(ikind==13)
    ylabel('Median QV kg/kg','FontWeight','bold','FontSize',12); 
elseif(ikind==14)
    ylabel('Median O3 Ratio kg/kg','FontWeight','bold','FontSize',12); 
elseif(ikind==15)
    ylabel('Median O3 Ratio kg/kg','FontWeight','bold','FontSize',12); 
end

%% Add a logo
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
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
%% Add data to PDF Report
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
    if(iNewChapter)
        headingstr1='Tabular Analysis Regional Results From Dataset03';
        chapter = Chapter("Title",headingstr1);
    end
    if(ikind==10)
        sectionstr=strcat('Median Temps Regions 1-5','-Whole World','-Map');
    elseif(ikind==11)
        sectionstr=strcat('Median Temps Regions 6-10','-Whole World','-Map');
    elseif(ikind==12)
        sectionstr=strcat('Median QV Regions 1-5','-Whole World','-Map');
    elseif(ikind==13)
        sectionstr=strcat('Median QV Regions 6-20','-Whole World','-Map');
    elseif(ikind==14)
        sectionstr=strcat('Median O3 Ratio Regions 1-5','-Whole World','-Map');
    elseif(ikind==15)
        sectionstr=strcat('Median O3 Ratio Regions 6-20','-Whole World','-Map');
    end    
    add(chapter,Section(sectionstr));
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr='Dateset03-Median Regional Temps';
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
    parastr1='This data is the median temperature for defined regions';
    if(ikind==10)
        parastr2='Chart shows region 1 median Temps.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==11)
        parastr2='Chart shows region 2 median Temps.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2)); 
    elseif(ikind==12)
        parastr2='Chart shows region 1 median QV weighted by area.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));     
    elseif(ikind==13)
        parastr2='Chart shows region 2 median QV weighted by area.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2)); 
    elseif(ikind==14)
        parastr2='Chart shows region 1 median O3 weighted by area.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));     
    elseif(ikind==15)
        parastr2='Chart shows region 2 median O3 weighted by area.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));  
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(ikind==10)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(TSSTT.Properties.RowTimes);
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
        Hdrs{1,4}='Germany';
        Hdrs{1,5}='Finland';
        Hdrs{1,6}='UK';
        Hdrs{1,7}='Sudan';
        Hdrs{1,8}='SouthAfrica';
        Col1=TSStatsTable.Germany;
        Col2=TSStatsTable.Finland;
        Col3=TSStatsTable.UK;
        Col4=TSStatsTable.Sudan;
        Col5=TSStatsTable.SouthAfrica;
        myCellArray=cell(nrows,5);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:5
                myCellArray{i,j+3}=myArray(i,j+3);               
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%6.2f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Region 1 Temperatures';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Air Temps over defined regions.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters-note that values were weighted by the area of each reporting cell.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==11)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(TSS2TT.Properties.RowTimes);
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
        Hdrs{1,4}='India';
        Hdrs{1,5}='Australia';
        Hdrs{1,6}='California';
        Hdrs{1,7}='Texas';
        Hdrs{1,8}='Peru';
        Col1=TSStats2Table.India;
        Col2=TSStats2Table.Australia;
        Col3=TSStats2Table.California;
        Col4=TSStats2Table.Texas;
        Col5=TSStats2Table.Peru;
        myCellArray=cell(nrows,5);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:5
                myCellArray{i,j+3}=myArray(i,j+3);               
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%6.2f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Region 2 Temperatures';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Air Temps over defined regions.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters-note that values were weighted by the area of each reporting cell.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==12)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(QVStatTT.Properties.RowTimes);
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
        Hdrs{1,4}='Germany';
        Hdrs{1,5}='Finland';
        Hdrs{1,6}='UK';
        Hdrs{1,7}='Sudan';
        Hdrs{1,8}='SouthAfrica';
        Col1=QVStatsTable.Germany;
        Col2=QVStatsTable.Finland;
        Col3=QVStatsTable.UK;
        Col4=QVStatsTable.Sudan;
        Col5=QVStatsTable.SouthAfrica;
        myCellArray=cell(nrows,5);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:5
                myCellArray{i,j+3}=myArray(i,j+3);               
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%6.4f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Region 1 Specific Humidity';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Specfic Humidity over defined regions.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters-note that values were weighted by the area of each reporting cell.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==13)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(QVStat2TT.Properties.RowTimes);
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
        Hdrs{1,4}='India';
        Hdrs{1,5}='Australia';
        Hdrs{1,6}='California';
        Hdrs{1,7}='Texas';
        Hdrs{1,8}='Peru';
        Col1=QVStats2Table.India;
        Col2=QVStats2Table.Australia;
        Col3=QVStats2Table.California;
        Col4=QVStats2Table.Texas;
        Col5=QVStats2Table.Peru;
        myCellArray=cell(nrows,5);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:5
                myCellArray{i,j+3}=myArray(i,j+3);               
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%6.4f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Region 2 Specific Humidity';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Specfic Humidity over defined regions.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters-note that values were weighted by the area of each reporting cell.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==14)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(O3StatTT.Properties.RowTimes);
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
        Hdrs{1,4}='Germany';
        Hdrs{1,5}='Finland';
        Hdrs{1,6}='UK';
        Hdrs{1,7}='Sudan';
        Hdrs{1,8}='SouthAfrica';
        Col1=O3StatsTable.Germany;
        Col2=O3StatsTable.Finland;
        Col3=O3StatsTable.UK;
        Col4=O3StatsTable.Sudan;
        Col5=O3StatsTable.SouthAfrica;
        myCellArray=cell(nrows,5);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:5
                myCellArray{i,j+3}=myArray(i,j+3);               
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%6.4e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Region 1 Ozone Mixing Ratio';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged O3 Mixing Ratio over defined regions.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters-note that values were weighted by the area of each reporting cell.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==15)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(O3Stat2TT.Properties.RowTimes);
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
        Hdrs{1,4}='India';
        Hdrs{1,5}='Australia';
        Hdrs{1,6}='California';
        Hdrs{1,7}='Texas';
        Hdrs{1,8}='Peru';
        Col1=O3Stats2Table.India;
        Col2=O3Stats2Table.Australia;
        Col3=O3Stats2Table.California;
        Col4=O3Stats2Table.Texas;
        Col5=O3Stats2Table.Peru;
        myCellArray=cell(nrows,5);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:5
                myCellArray{i,j+3}=myArray(i,j+3);               
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%6.4e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Region 2 O3 Mixing Ratio';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged O3 Mixing Ratio over defined regions.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters-note that values were weighted by the area of each reporting cell.';
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