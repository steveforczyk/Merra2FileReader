function PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function plots some timetables created by Dataset03

% Written By: Stephen Forczyk
% Created: Nov 29,2023
% Revised: Nov 30,2023 added Geopotential Height Table
% Revised: Dec 01,2023 added Surface Pressure Yable
% Revised: Dec 02,2023 added Specific Humidity Table
% Revised: Dec 04,2023 added final=table for NorthWind
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global TSTable TSTT HSTable HSTT O3STable O3STT SLPSTable SLPSTT;
global QVSTable QVSTT PSSTable PSSTT USTable USTT VSTable VSTT;
global ROIArea ROIPts ROIFracPts numgridpts Merra2WorkingMask;

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
% Get the total grid points
% [nrowsg,ncolsg]=size(Merra2WorkingMask);
% numgridpts=nrowsg*ncolsg;
% ROIFracPts=ROIPts/numgridpts;
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
if(ikind==1)
    plot(HSTT.Time,HSTT.HS01,'b',HSTT.Time,HSTT.HS25,'g',...
        HSTT.Time,HSTT.HS50,'k',HSTT.Time,HSTT.HS75,'c',...
        HSTT.Time,HSTT.HS90,'r',HSTT.Time,HSTT.HS100,'r--o'); 
elseif(ikind==2)
    plot(O3STT.Time,O3STT.O3S01,'b',O3STT.Time,O3STT.O3S25,'g',...
        O3STT.Time,O3STT.O3S50,'k',O3STT.Time,O3STT.O3S75,'c',...
        O3STT.Time,O3STT.O3S90,'r',O3STT.Time,O3STT.O3S100,'r--o'); 
elseif(ikind==3)
    plot(PSSTT.Time,PSSTT.PSS01,'b',PSSTT.Time,PSSTT.PSS25,'g',...
        PSSTT.Time,PSSTT.PSS50,'k',PSSTT.Time,PSSTT.PSS75,'c',...
        PSSTT.Time,PSSTT.PSS90,'r',PSSTT.Time,PSSTT.PSS100,'r--o');
elseif(ikind==4)
    plot(QVSTT.Time,QVSTT.QVS01,'b',QVSTT.Time,QVSTT.QVS25,'g',...
        QVSTT.Time,QVSTT.QVS50,'k',QVSTT.Time,QVSTT.QVS75,'c',...
        QVSTT.Time,QVSTT.QVS90,'r',QVSTT.Time,QVSTT.QVS100,'r--o'); 
elseif(ikind==5)
    plot(SLPSTT.Time,SLPSTT.SLPS01,'b',SLPSTT.Time,SLPSTT.SLPS25,'g',...
        SLPSTT.Time,SLPSTT.SLPS50,'k',SLPSTT.Time,SLPSTT.SLPS75,'c',...
        SLPSTT.Time,SLPSTT.SLPS90,'r',SLPSTT.Time,SLPSTT.SLPS100,'r--o'); 
elseif(ikind==6)
    plot(TSTT.Time,TSTT.TS01,'b',TSTT.Time,TSTT.TS25,'g',...
        TSTT.Time,TSTT.TS50,'k',TSTT.Time,TSTT.TS75,'c',...
        TSTT.Time,TSTT.TS90,'r',TSTT.Time,TSTT.TS100,'r--o'); 
elseif(ikind==7)
    plot(USTT.Time,USTT.US01,'b',USTT.Time,USTT.US25,'g',...
        USTT.Time,USTT.US50,'k',USTT.Time,USTT.US75,'c',...
        USTT.Time,USTT.US90,'r',USTT.Time,USTT.US100,'r--o'); 
elseif(ikind==8)
    plot(VSTT.Time,VSTT.VS01,'b',VSTT.Time,VSTT.VS25,'g',...
        VSTT.Time,VSTT.VS50,'k',VSTT.Time,VSTT.VS75,'c',...
        VSTT.Time,VSTT.VS90,'r',VSTT.Time,VSTT.VS100,'r--o'); 
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==1)
    hl=legend('Global Geopoten 1 PTile','Global Geopoten 25 PTile','Global Geopoten 50 PTile','Global Geopoten 75 PTile',...
        'Global Geopoten 90 PTile','Global Geopoten 100 PTile');
elseif(ikind==2)
        hl=legend('Global Ozone Ratio 1 Ptile','Global Ozone Ratio 25 Ptile','Global Ozone Ratio 50 Ptile','Global Ozone Ratio 75 Ptile',...
        'Global Ozone Ratio 90 Ptile','Global Ozone Ratio 100 Ptile');
elseif(ikind==3)
        hl=legend('Global Surface Press 1 Ptile','Global Surface Press 25 Ptile','Global Surface Press 50 Ptile',...
        'Global Surface Press 75 Ptile','Global Surface Press 90 Ptile','Global Surface Press 100 Ptile');
elseif(ikind==4)
        hl=legend('Global Surface QV 1 Ptile','Global Surface QV 25 Ptile','Global Surface QV 50 Ptile','Global Surface QV 75 Ptile',...
        'Global Surface QV 90 Ptile','Global Surface QV 100 Ptile');
elseif(ikind==5)
        hl=legend('Global  SLP 1 Ptile','Global  SLP 25 Ptile','Global  SLP 50 Ptile','Global  SLP 75 Ptile',...
        'Global SLP 90 Ptile','Global  SLP 100 Ptile');
elseif(ikind==6)
        hl=legend('Global Temp 1 Ptile','Global Temp 25 Ptile','Global Temp 50 Ptile','Global Temp 75 Ptile',...
        'Global Temp 90 Ptile','Global Temp 100 PTile');
elseif(ikind==7)
        hl=legend('Global East Wind 1 Ptile','Global East Wind 25 Ptile','Global East Wind 50 Ptile','Global East Wind 75 Ptile',...
        'Global East Wind 90 Ptile','Global East Wind 100 PTile');

elseif(ikind==8)
        hl=legend('Global North Wind 1 Ptile','Global North Wind 25 Ptile','Global North Wind 50 Ptile','Global North Wind 75 Ptile',...
        'Global North Wind 90 Ptile','Global North Wind 100 PTile');

end

ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
if(ikind==1)
    ylabel('Geopotential Height-meters','FontWeight','bold','FontSize',12); 
elseif(ikind==2)
    ylabel('Ozone Mixing Ratio kg/kg','FontWeight','bold','FontSize',12); 
elseif(ikind==3)
    ylabel('Surface Pressure Pa','FontWeight','bold','FontSize',12); 
elseif(ikind==4)
    ylabel('Specific Humidity kg/kg','FontWeight','bold','FontSize',12); 
elseif(ikind==5)
    ylabel('Sea Level Pressure Pa','FontWeight','bold','FontSize',12); 
elseif(ikind==6)
    ylabel('Air Temp Deg-C','FontWeight','bold','FontSize',12); 
elseif(ikind==7)
    ylabel('East Wind m/s','FontWeight','bold','FontSize',12); 
elseif(ikind==8)
    ylabel('North Wind m/s','FontWeight','bold','FontSize',12); 
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