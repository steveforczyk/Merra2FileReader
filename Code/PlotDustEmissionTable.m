function PlotDustEmissionTable(titlestr,iDustID,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the Dust data results.
% Is the Black Dry Dust Deposition density in kg/m2/sec * 1E-15 to produce a
% and easier to read result
% 
%
% Written By: Stephen Forczyk
% Created: July 31,2023
% Revised: Aug 1,2023 added formatted tables output to pdf
% The first table shows the contributions from a single country
% The second table shows the whole world values
% Revised: Aug 7,2023 added another column to table to include Sum of all
% Bins
% Revised: Aug 14,2023 added another table for Dust Sedimentation


% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global DustEmissionAllBins DustEmissionAllTable DustEmissionAllTT DustROICountry;
global WDustEmissionAllBins WDustEmissionAllTable WDustEmissionAllTT;
global DustDepositionAllTT WDustDepositionAllTT DustDepositionAllTable WDustDepositionAllTable;
global DustSedimentationAllTable WDustSedimentationAllTable;
global DustSedimentationAllTT WDustSedimentationAllTT;
global ROIArea ROIPts ROIFracPts numgridpts Merra2WorkingMask;

global Merra2ShortFileName;
global numtimeslice TimeSlices;
global Years Months Days;

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
[nrowsg,ncolsg]=size(Merra2WorkingMask);
numgridpts=nrowsg*ncolsg;
ROIFracPts=ROIPts/numgridpts;
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(iDustID==1)
    plot(DustEmissionAllTT.Time,DustEmissionAllTT.Bin001,'b',DustEmissionAllTT.Time,DustEmissionAllTT.Bin002,'g',...
        DustEmissionAllTT.Time,DustEmissionAllTT.Bin003,'k',DustEmissionAllTT.Time,DustEmissionAllTT.Bin004,'c',...
        DustEmissionAllTT.Time,DustEmissionAllTT.Bin005,'r',DustEmissionAllTT.Time,DustEmissionAllTT.Sum,'r+'); 
elseif(iDustID==2)
        plot(WDustEmissionAllTT.Time,WDustEmissionAllTT.Bin001,'b',WDustEmissionAllTT.Time,WDustEmissionAllTT.Bin002,'g',...
        WDustEmissionAllTT.Time,WDustEmissionAllTT.Bin003,'k',WDustEmissionAllTT.Time,WDustEmissionAllTT.Bin004,'c',...
        WDustEmissionAllTT.Time,WDustEmissionAllTT.Bin005,'r',WDustEmissionAllTT.Time,WDustEmissionAllTT.Sum,'r+');
elseif(iDustID==3)
        plot(DustDepositionAllTT.Time,DustDepositionAllTT.Bin001,'b',DustDepositionAllTT.Time,DustDepositionAllTT.Bin002,'g',...
        DustDepositionAllTT.Time,DustDepositionAllTT.Bin003,'k',DustDepositionAllTT.Time,DustDepositionAllTT.Bin004,'c',...
        DustDepositionAllTT.Time,DustDepositionAllTT.Bin005,'r',DustDepositionAllTT.Time,DustDepositionAllTT.Sum,'r--o'); 
elseif(iDustID==4)
        plot(WDustDepositionAllTT.Time,WDustDepositionAllTT.Bin001,'b',WDustDepositionAllTT.Time,WDustDepositionAllTT.Bin002,'g',...
        WDustDepositionAllTT.Time,WDustDepositionAllTT.Bin003,'k',WDustDepositionAllTT.Time,WDustDepositionAllTT.Bin004,'c',...
        WDustDepositionAllTT.Time,WDustDepositionAllTT.Bin005,'r',WDustDepositionAllTT.Time,WDustDepositionAllTT.Sum,'r--o'); 
elseif(iDustID==5)
        plot(DustSedimentationAllTT.Time,DustSedimentationAllTT.Bin001,'b',DustSedimentationAllTT.Time,DustSedimentationAllTT.Bin002,'g',...
        DustSedimentationAllTT.Time,DustSedimentationAllTT.Bin003,'k',DustSedimentationAllTT.Time,DustSedimentationAllTT.Bin004,'c',...
        DustSedimentationAllTT.Time,DustSedimentationAllTT.Bin005,'r',DustSedimentationAllTT.Time,DustSedimentationAllTT.Sum,'r--o'); 
elseif(iDustID==6)
        plot(WDustSedimentationAllTT.Time,WDustSedimentationAllTT.Bin001,'b',WDustSedimentationAllTT.Time,WDustSedimentationAllTT.Bin002,'g',...
        WDustSedimentationAllTT.Time,WDustSedimentationAllTT.Bin003,'k',WDustSedimentationAllTT.Time,WDustSedimentationAllTT.Bin004,'c',...
        WDustSedimentationAllTT.Time,WDustSedimentationAllTT.Bin005,'r',WDustSedimentationAllTT.Time,WDustSedimentationAllTT.Sum,'r--o'); 
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(iDustID==1)
    hl=legend('Dust Emiss Bin001','Dust Emiss Bin002','Dust Emiss Bin003','Dust Emiss Bin004',...
        'Dust Emiss Bin005','Sum All Bins');
elseif(iDustID==2)
        hl=legend('World Dust Emiss Bin001','World Dust Emiss Bin002','World Dust Emiss Bin003','World Dust Emiss Bin004',...
        'World Dust Emiss Bin005','Sum All Bins');
elseif(iDustID==3)
        hl=legend('Dust Depo Bin001','Dust Depo Bin002','Dust Depo Bin003','Dust Depo Bin004',...
        'Dust Depo Bin005','Sum All Bins');
elseif(iDustID==4)
        hl=legend('World Dust Depo Bin001','World Dust Depo Bin002','World Dust Depo Bin003','World Dust Depo Bin004',...
        'World Dust Depo Bin005','Sum All Bins');
elseif(iDustID==5)
        hl=legend('Dust Sed Bin001','Dust Sed Bin002','Dust Sed Bin003','Sed Depo Bin004',...
        'Dust Sed Bin005','Sum All Bins');
elseif(iDustID==6)
        hl=legend('World Dust Sed Bin001','World Dust Sed Bin002','World Dust Sed Bin003','World Dust Sed Bin004',...
        'World Dust Sed Bin005','Sum All Bins');
end

ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
if(iDustID<3)
    ylabel('Dust Emission-Tgm/day','FontWeight','bold','FontSize',12); 
elseif((iDustID==3) || (iDustID==4))
    ylabel('Dust Deposition-Tgm/day','FontWeight','bold','FontSize',12); 
elseif((iDustID==5) || (iDustID==6))
    ylabel('Dust Sedimentation-Tgm/day','FontWeight','bold','FontSize',12); 
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
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
    if(iNewChapter)
        headingstr1=strcat('Tabular Analysis Results For  Dust Data For-',DustROICountry);
        chapter = Chapter("Title",headingstr1);
    end
    if(iDustID==1)
        sectionstr=strcat('Dust Emission-',DustROICountry,'-Map');
    elseif(iDustID==2)
        sectionstr=strcat('Dust Emission','-Whole World','-Map');
    elseif(iDustID==3)
        sectionstr=strcat('Dust Deposition-',DustROICountry,'-Map');
    elseif(iDustID==4)
        sectionstr=strcat('Dust Deposition','-Whole World','-Map');
    elseif(iDustID==5)
        sectionstr=strcat('Dust Sedimentation-',DustROICountry,'-Map');
    elseif(iDustID==6)
        sectionstr=strcat('Dust Sedimentation','-Whole World','-Map');
    end    
    add(chapter,Section(sectionstr));
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(' Dust Emission All Bins-',Merra2ShortFileName);
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
    if(iDustID==1)
        parastr2='This is the sum of Dust Emissions over the study period.';
        parastr3=' Each of the 5 bins are treated separately with the particle size increasing from Bin 1 thru Bin 5.';
        parastr4=' The Emission values are for the selected country.';
        parastr5=' Dust Emission affects the energy balance of the earth.';
    elseif(iDustID==2)
        parastr2='This is the sum of Dust Emissions over the study period.';
        parastr3=' Each of the 5 bins are treated separately with the particle size increasing from Bin 1thru Bin 5.';
        parastr4=' The Emission values are for the entire world.';
        parastr5=' Dust Emission affects the energy balance of the earth';
    elseif(iDustID==3)
        parastr2='This is the sum of Dust Deposition over the study period.';
        parastr3=' Each of the 5 bins are treated separately with the particle size increasing from Bin 1 thru Bin 5.';
        parastr4=' The Deposition values are for the selected country.';
        parastr5=' Dust Deposition reduces the dust in the atmosphere.';
    elseif(iDustID==4)
        parastr2='This is the sum of Dust Deposition over the study period.';
        parastr3=' Each of the 5 bins are treated separately with the particle size increasing from Bin 1 thru Bin 5.';
        parastr4=' The Deposition values are for the entire world';
        parastr5=' Dust Deposition reduces the dust in the atmosphere.';
    elseif(iDustID==5)
        parastr2='This is the sum of Dust Sedimentation over the study period.';
        parastr3=' Each of the 5 bins are treated separately with the particle size increasing from Bin 1 thru Bin 5.';
        parastr4=' The Sedimentation values are for the selected country.';
        parastr5=' Dust Sedimentation reduces the dust in the atmosphere.';
    elseif(iDustID==6)
        parastr2='This is the sum of Dust Sedimentation over the study period.';
        parastr3=' Each of the 5 bins are treated separately with the particle size increasing from Bin 1 thru Bin 5.';
        parastr4=' The Sedimentation values are for the entire world';
        parastr5=' Dust Sedimentation reduces the dust in the atmosphere.';
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
     if(iDustID==1)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DustEmissionAllTT.Properties.RowTimes);
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
        Hdrs{1,4}='Bin001';
        Hdrs{1,5}='Bin002';
        Hdrs{1,6}='Bin003';
        Hdrs{1,7}='Bin004';
        Hdrs{1,8}='Bin005';
        Hdrs{1,9}='SUM';
        Col1=DustEmissionAllTable.Bin001;
        Col2=DustEmissionAllTable.Bin002;
        Col3=DustEmissionAllTable.Bin003;
        Col4=DustEmissionAllTable.Bin004;
        Col5=DustEmissionAllTable.Bin005;
        Col6=DustEmissionAllTable.Sum;
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
            NumberFormat("%4.3f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr=strcat('Merra2 Daily Dust Emission For-',DustROICountry);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the DustEmissionAllTable over the selected date range.';
        parastr602=strcat(' DustEmissionAll is the sum for a single country-',DustROICountry,'-over the specified time period of the files ');
        parastr603=strcat(' Typical values are on the order of TGrams/day and the country in question has-',num2str(ROIFracPts,4),'-of all grid points.');
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
        parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605,parastr606);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(iDustID==2)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(WDustEmissionAllTT.Properties.RowTimes);
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
        Hdrs{1,4}='Bin001';
        Hdrs{1,5}='Bin002';
        Hdrs{1,6}='Bin003';
        Hdrs{1,7}='Bin004';
        Hdrs{1,8}='Bin005';
        Hdrs{1,9}='Sum';
        Col1=WDustEmissionAllTable.Bin001;
        Col2=WDustEmissionAllTable.Bin002;
        Col3=WDustEmissionAllTable.Bin003;
        Col4=WDustEmissionAllTable.Bin004;
        Col5=WDustEmissionAllTable.Bin005;
        Col6=WDustEmissionAllTable.Sum;
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
            NumberFormat("%4.3f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Daily Dust Emission For The World';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the WDustEmissionAllTable over the selected data range.';
        parastr602=' DustEmissionAll is the sum for the entire world over the specified time period of the files ';
        parastr603=' Typical values are on the order of TGrams/day.';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
        parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605,parastr606);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(iDustID==3)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DustEmissionAllTT.Properties.RowTimes);
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
        Hdrs{1,4}='Bin001';
        Hdrs{1,5}='Bin002';
        Hdrs{1,6}='Bin003';
        Hdrs{1,7}='Bin004';
        Hdrs{1,8}='Bin005';
        Hdrs{1,9}='Sum';
        Col1=DustEmissionAllTable.Bin001;
        Col2=DustEmissionAllTable.Bin002;
        Col3=DustEmissionAllTable.Bin003;
        Col4=DustEmissionAllTable.Bin004;
        Col5=DustEmissionAllTable.Bin005;
        Col6=DustEmissionAllTable.Sum;
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
            NumberFormat("%3.4e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Daily Dust Emission For One Country';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the DustEmissionAllTable over the selected data range.';
        parastr602=' DustEmissionAll is the sum for the selected country over the specified time period of the files ';
        parastr603=' Typical values are on the order of TGrams/day.';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
        parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605,parastr606);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(iDustID==4)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(WDustDepositionAllTT.Properties.RowTimes);
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
        Hdrs{1,4}='Bin001';
        Hdrs{1,5}='Bin002';
        Hdrs{1,6}='Bin003';
        Hdrs{1,7}='Bin004';
        Hdrs{1,8}='Bin005';
        Hdrs{1,9}='Sum';
        Col1=WDustDepositionAllTable.Bin001;
        Col2=WDustDepositionAllTable.Bin002;
        Col3=WDustDepositionAllTable.Bin003;
        Col4=WDustDepositionAllTable.Bin004;
        Col5=WDustDepositionAllTable.Bin005;
        Col6=WDustDepositionAllTable.Sum;
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
            NumberFormat("%3.4e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Daily Dust Deposition For The World';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the WDustDepositionAllTable over the selected data range.';
        parastr602=' WDustDepositionAll is the sum for the entire world over the specified time period of the files ';
        parastr603=' Typical values are on the order of TGrams/day.';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
        parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605,parastr606);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(iDustID==5)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DustSedimentationAllTT.Properties.RowTimes);
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
        Hdrs{1,4}='Bin001';
        Hdrs{1,5}='Bin002';
        Hdrs{1,6}='Bin003';
        Hdrs{1,7}='Bin004';
        Hdrs{1,8}='Bin005';
        Hdrs{1,9}='Sum';
        Col1=DustSedimentationAllTable.Bin001;
        Col2=DustSedimentationAllTable.Bin002;
        Col3=DustSedimentationAllTable.Bin003;
        Col4=DustSedimentationAllTable.Bin004;
        Col5=DustSedimentationAllTable.Bin005;
        Col6=DustSedimentationAllTable.Sum;
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
            NumberFormat("%3.2e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Daily Dust Sedimentatiom For One Country';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the DustSedimentationAllTable over the selected data range.';
        parastr602=' DustSedimentationAll is the sum for just one country over the specified time period of the files ';
        parastr603=' Typical values are on the order of TGrams/day.';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
        parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605,parastr606);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609)     
     elseif(iDustID==6)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(WDustSedimentationAllTT.Properties.RowTimes);
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
        Hdrs{1,4}='Bin001';
        Hdrs{1,5}='Bin002';
        Hdrs{1,6}='Bin003';
        Hdrs{1,7}='Bin004';
        Hdrs{1,8}='Bin005';
        Hdrs{1,9}='Sum';
        Col1=WDustSedimentationAllTable.Bin001;
        Col2=WDustSedimentationAllTable.Bin002;
        Col3=WDustSedimentationAllTable.Bin003;
        Col4=WDustSedimentationAllTable.Bin004;
        Col5=WDustSedimentationAllTable.Bin005;
        Col6=WDustSedimentationAllTable.Sum;
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
            NumberFormat("%3.4e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Daily Dust Sedimentatiom For The Whole World';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the WDustSedimentationAllTable over the selected data range.';
        parastr602=' WDustSedimentationAll is the sum for the entire world over the specified time period of the files ';
        parastr603=' Typical values are on the order of TGrams/day.';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
        parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605,parastr606);
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