function PlotWindQuiver(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function plots the windcomponents as a quiver plot
% Written By: Stephen Forczyk using scrips from the ClimateData Toolbox
% written by Chad Green taken from Matlab Central 
% Created: Feb 19,2024
% Revised: Feb 20,2024 added Climate Toolbox Logo and used globle Plot
% from CDT
% Revised: Feb 23,2024 added Fast save capability
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global YearMonthDayStr1;

global idebug iScale iReset iCamLight;
global LonS LatS TimeS iTimeSlice ;

global U10MTable U10MTT U10M01 U10M25 U10M50 U10M75 U10M90 U10M100 U10MNaN;
global V10MTable V10MTT V10M01 V10M25 V10M50 V10M75 V10M90 V10M100 V10MNaN;
global T10MTable T10MTT T10M01 T10M25 T10M50 T10M75 T10M90 T10M100 T10MNaN;
global QV10MTable QV10MTT QV10M01 QV10M25 QV10M50 QV10M75 QV10M90 QV10M100 QV10MNaN;
global U10 V10 TAirTempC; 
global vTemp30 TempMovieName30;
global SubSolarLat SubSolarLon;


global RasterLats RasterLons Rpix;
global framecounter numSelectedFiles;
global westEdge eastEdge northEdge southEdge;
global yd md dd;

global Merra2ShortFileName;
global numtimeslice TimeSlices;
global Years Months Days;
global iTimeSlice iPress42;
global viewAZ viewEL viewAZInc iFastSave;

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
global jpegpath tiffpath tiffpath2 moviepath savepath;
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
Yearstr=YearMonthDayStr1(1:4);
Monthstr=YearMonthDayStr1(5:6);
Daystr=YearMonthDayStr1(7:8);
Hourstr=char(TimeSlices{iTimeSlice,1});
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
lats=-90:.5:90;
lats=lats';
lons=-180:.625:179.375;
[lats,lons] = meshgrid(lats,lons);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gcf,'Color',[.1 .1 .1])
if(ikind==30)
    globepcolor(lats,lons,TAirTempC)
    globeborders('color',rgb('red'))
    cmocean('balance','pivot')
    q = globequiver(lats,lons,U10,V10,'density',75,'k');
    viewAZ=viewAZ+viewAZInc;
    view(viewAZ,viewEL);
    hc=colorbar;
    hc.Label.String='AirTemp-Deg C';
    hc.Label.FontWeight='bold';
    hc.Label.Color=[1 1 0];
    set(hc,'FontWeight','bold');
    set(hc,'Color',[1 1 0]);
    set(hc,'Position',[.8681 0.1500 0.0198 0.65]);
    set(hc,'TickLabels',[-40 -30 -20 -10 0 10 20 30 40]);
    set(hc,'Ticks',[-40 -30 -20 -10 0 10 20 30 40]);
    if(iCamLight==1)
        lightangle(SubSolarLon,SubSolarLat)
        h.FaceLighting = 'gouraud';
        h.AmbientStrength = 0.3;
        h.DiffuseStrength = 0.8;
        h.SpecularStrength = 0.9;
        h.SpecularExponent = 25;
        h.BackFaceLighting = 'unlit';
    end
    axis tight
end
ht=title(titlestr);
set(ht,'Color','y');
set(ht,'FontSize',14)

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
    ha3=axes('position',[haPos(1)+.70,haPos(2)-.05, .12,.07,]);
    [x2, ~]=imread(LogoFileName2);
    imshow(x2);
    set(ha3,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.14;
txtstr1=strcat('Year',Yearstr,'-Month-',Monthstr,'-Day-',Daystr,'-Hour-',Hourstr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12,'Color','y');
tx2=.10;
ty2=.11;
txtstr2=strcat('View Az-',num2str(viewAZ,4),'-View El-',num2str(viewEL,4));
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12,'Color','y');
tx3=.10;
ty3=.08;
txtstr3=strcat('SubSolarLat=',num2str(SubSolarLat,6),'-SubSolarLon=',num2str(SubSolarLon,6));
txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',12,'Color','y');
set(newaxesh,'Visible','Off');
frame=getframe(gcf);
writeVideo(vTemp30,frame);
pause(chart_time)
figstr=strcat(titlestr,'.jpg');
figstr2=strcat(titlestr,'.tiff');
if(iFastSave==0)
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr);
    eval(cmdString);    
else
% Try a screencapture
    eval(['cd ' tiffpath2(1:length(tiffpath2)-1)]);
    screencapture('handle',gcf,'target',figstr2);
end
pause(chart_time)
colormap('jet');
close('all');
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