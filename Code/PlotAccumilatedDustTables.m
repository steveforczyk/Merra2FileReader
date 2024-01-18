function PlotAccumilatedDustTables(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the Dust data integrated results. This is not a
% rate bu the actual summed quantity over the period of the processed files
% Is the Black Dry Dust Deposition density in kg/m2/sec * 1E-15 to produce a
% and easier to read result
% 
%
% Written By: Stephen Forczyk
% Created: Sept 20,2023
% Revised: Sept 23,2023 Added Dust Emission Table


% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global ROIName1 ROIName2 ROIName3 ROIName4 ROIName5;
global DustEmisTT DustEmisTable;
global DUDPSum DUDPSum1 DUDPSum2 DUDPSum3 DUDPSum4 DUDPSum5;
global SelectedMaskData;
global DustDepoTT DustDepoTable;
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

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(ikind==120)
    plot(DustDepoTT.Time,DustDepoTT.World,'b',DustDepoTT.Time,DustDepoTT.ROI1,'g',...
        DustDepoTT.Time,DustDepoTT.ROI2,'k',DustDepoTT.Time,DustDepoTT.ROI3,'r',...
        DustDepoTT.Time,DustDepoTT.ROI4,'k--o',DustDepoTT.Time,DustDepoTT.ROI5,'r--O'); 
elseif(ikind==121)
    plot(DustEmisTT.Time,DustDepoTT.World,'b',DustEmisTT.Time,DustEmisTT.ROI1,'g',...
        DustEmisTT.Time,DustEmisTT.ROI2,'k',DustEmisTT.Time,DustEmisTT.ROI3,'r',...
        DustEmisTT.Time,DustEmisTT.ROI4,'k--o',DustEmisTT.Time,DustEmisTT.ROI5,'r--O'); 
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==120)
    hl=legend('World',ROIName1,ROIName2,ROIName3,ROIName4,ROIName5);
elseif(ikind==121)
    hl=legend('World',ROIName1,ROIName2,ROIName3,ROIName4,ROIName5);
end
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
if(ikind==120)
    ylabel('Dry Dust Deposition-Tgm','FontWeight','bold','FontSize',12); 
elseif(ikind==121)
    ylabel('Dry Dust Emission-Tgm','FontWeight','bold','FontSize',12); 
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
        headingstr1=strcat('Total Accumilation Data-','Dry Dust Data');
        chapter = Chapter("Title",headingstr1);
    end
    if(ikind==120)
        sectionstr=strcat('DUDPSum','-Map');  
    elseif(ikind==121)
        sectionstr=strcat('DUEMSum','-Map'); 
    end    
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    if(ikind==120)
        pdftxtstr=strcat(' DUDPSum Map For -','Dry Dust Deposition Sum'); 
    elseif(ikind==121)
        pdftxtstr=strcat(' DUEMSum Map For -','Dry Dust Emission Sum'); 
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
    if(ikind==120)
        parastr2='This metric is the value of the DUDPSum.';
        parastr3=' The value of this metric is the sum of TeraGrams that was deposited in the period of interest';
        parastr4=strcat(' The Regions of interest are -ROI1 =',ROIName1,'-ROI2=',ROIName2,'-ROIName3=',ROIName3);
        parastr5=strcat('-ROIName4=',ROIName4,'-ROIName5=',ROIName5);
    elseif(ikind==121)
        parastr2='This metric is the value of the DUEMSum.';
        parastr3=' The value of this metric is the sum of TeraGrams that was emitted in the period of interest';
        parastr4=strcat(' The Regions of interest are -ROI1 =',ROIName1,'-ROI2=',ROIName2,'-ROIName3=',ROIName3);
        parastr5=strcat('-ROIName4=',ROIName4,'-ROIName5=',ROIName5);
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(ikind==120)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DustDepoTT.Properties.RowTimes);
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
        Hdrs{1,5}='ROI-1';
        Hdrs{1,6}='ROI02';
        Hdrs{1,7}='ROI-3';
        Hdrs{1,8}='ROI-4';
        Hdrs{1,9}='ROI-5';
        Col1=DustDepoTable.World;
        Col2=DustDepoTable.ROI1;
        Col3=DustDepoTable.ROI2;
        Col4=DustDepoTable.ROI3;
        Col5=DustDepoTable.ROI4;
        Col6=DustDepoTable.ROI5;
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
            NumberFormat("%2.3f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr='Merra2DryDustDeposition';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution the Dry Dust Deposition the selected data range/country areas.';
        parastr602=' DustDepoTT is the sum of the deposition over the world and 5 selected regions';
        parastr609=strcat(parastr601,parastr602);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==121)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(DustEmisTT.Properties.RowTimes);
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
        Hdrs{1,5}='ROI-1';
        Hdrs{1,6}='ROI02';
        Hdrs{1,7}='ROI-3';
        Hdrs{1,8}='ROI-4';
        Hdrs{1,9}='ROI-5';
        Col1=DustEmisTable.World;
        Col2=DustEmisTable.ROI1;
        Col3=DustEmisTable.ROI2;
        Col4=DustEmisTable.ROI3;
        Col5=DustEmisTable.ROI4;
        Col6=DustEmisTable.ROI5;
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
            NumberFormat("%2.3f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr='Merra2DryDustEmission';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the total deposition the Dry Dust Emission the selected data range/country areas.';
        parastr602=' DustEmisTT is the sum of the deposition over the world and 5 selected regions';
        parastr609=strcat(parastr601,parastr602);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);

    end
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end