function PlotSeaSaltCumilativeTable(titlestr,ikind2,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the Sea Salt Cumilative table for a selected
% variable. The table is set up to plot the values for 6 Regions of
% Interest across the columns. The first ROI Column is for the World while
% the remaining 5 columns of for user seelected/default regions
% The unit is measurenebt is changed from kg/m^2/sec to
% TerraGm per day for the selected regions to make it easier to read the result
% 
% 
%
% Written By: Stephen Forczyk
% Created: Oct 19,2023
% Revised: ----

% Classification: Public Domain


global SelectedSeaMaskData;
global Merra2WorkingSeaMask1 Merra2WorkingSeaMask2 Merra2WorkingSeaMask3;
global Merra2WorkingSeaMask4 Merra2WorkingSeaMask5;
global SeaSaltDryDepAllBins WSeaSaltDryDepAllBins;
global SeaSaltSumDepROI6 WSeaSaltSumDepROI6;
global SeaSaltSumDepROI7 WSeaSaltSumDepROI7;
global SeaSaltSumDepROI8 WSeaSaltSumDepROI8;
global SeaSaltSumDepROI9 WSeaSaltSumDepROI9;
global SeaSaltSumDepROI10 WSeaSaltSumDepROI10;
global SSDPSumTable SSDPSumTT;

global iLogo LogoFileName1 LogoFileName2;
global numtimeslice;
global iCityPlot maxCities;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;

global PascalsToMilliBars PascalsToPsi;
global numtimeslice TimeSlices;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global numlat numlon Rpix latlim lonlim rasterSize;
global yd md dd;
global DustSizeGroups SeaSaltSizeGroups;
global iBlackCarbon iDust iOrganicCarbon iSeaSalt iSulfate iAllAerosols;
global iSeaSaltCalc iDustCalc;

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
if(ikind2==1066)
    plot(SSDPSumTT.Time,SSDPSumTT.World,'b',SSDPSumTT.Time,SSDPSumTT.ROIName6,'g',...
        SSDPSumTT.Time,SSDPSumTT.ROIName7,'k',SSDPSumTT.Time,SSDPSumTT.ROIName8,'r',...
        SSDPSumTT.Time,SSDPSumTT.ROIName9,'c',SSDPSumTT.Time,SSDPSumTT.ROIName10,'r+');
    hl=legend('World','ROIName6','ROIName7','ROIName8','ROIName9','ROIName10');
    ylabel('Sea Salt Deposition TG/Day','FontWeight','bold','FontSize',12);
    sectionstr=strcat('SSDP','-Map');
    pdftxtstr=strcat(' SSDP Map For File-',Merra2ShortFileName);
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
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
        headingstr1=strcat('Tabular Analysis Results For-','Sulfure Dioxide Aerosols');
        chapter = Chapter("Title",headingstr1);
    end
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
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
   
    if(ikind2==1066)
        parastr2='This metric is the value of the Sea Salt Dry Deposition Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
     if(ikind2==1066)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SSDPSumTT.Properties.RowTimes);
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
        Hdrs{1,4}='World';
        Hdrs{1,5}='ROIName6';
        Hdrs{1,6}='ROIName7';
        Hdrs{1,7}='ROIName8';
        Hdrs{1,8}='ROIName9';
        Hdrs{1,9}='ROIName10';
        Col1=SSDPSumTable.World;
        Col2=SSDPSumTable.ROIName6;
        Col3=SSDPSumTable.ROIName7;
        Col4=SSDPSumTable.ROIName8;
        Col5=SSDPSumTable.ROIName9;
        Col6=SSDPSumTable.ROIName10;
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
            NumberFormat("%3.2f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr='Merra2-SSDP-Cumilative Salt Deposition';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above cumiliative daily deposition of Sea Salt.';
        parastr602=' Quoted Desposition if for Combined 5 size bins each day';
%         parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     end

end
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end
