function PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the Organic Carbon data results.
% The unit is measuremenetn is frequently changed from kg/m^2/sec to
% femotogm/m^2/sec to make it easier to read the result
% and easier to read result
% 
%
% Written By: Stephen Forczyk
% Created: June 27,2023
% Revised: June 28-30 added more variables
% Revised: July 15,2023 added OCSV and OCWT variables

% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global OCDP001S OCDP002S OCEM001S OCEM002S;
global OCDP00110 OCDP00125 OCDP00150 OCDP00175 OCDP00190 OCDP00195 OCDP00198 OCDP001100;
global OCDP001Low OCDP001High OCDP001NaN OCDP001Values;
global OCDP001Table OCDP001TT OCDP002Table OCDP002TT;
global OCEM001Table OCEM001TT OCEM002Table OCEM002TT OCEMANTable OCEMANTT;
global OCEMBBTable OCEMBBTT OCEMBGTable OCEMBGTT OCEMBFTable OCEMBFTT;
global OCHYPHIL10 OCHYPHIL25 OCHYPHIL50 OCHYPHIL75 OCHYPHIL90 OCHYPHIL95 OCHYPHIL98 OCHYPHIL100;
global OCHYPHILLow OCHYPHILHigh OCHYPHILNaN OCHYPHILValues;
global OCSD00110 OCSD00125 OCSD00150 OCSD00175 OCSD00190 OCSD00195 OCSD00198 OCSD001100;
global OCSD001Low OCSD001High OCSD001NaN OCSD001Values;
global OCSD001Table OCSD001TT OCSD002Table OCSD002TT;
global OCWT001Table OCWT001TT;
global OCWT002Table OCWT002TT;
global OCHYPHILTable OCHYPHILTT;
global OCSV001Table OCSV001TT;
global OCSV002Table OCSV002TT;
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
if(ikind==45)
    plot(OCDP001TT.Time,OCDP001TT.OCDP00175,'b',OCDP001TT.Time,OCDP001TT.OCDP00190,'g',...
        OCDP001TT.Time,OCDP001TT.OCDP00195,'k',OCDP001TT.Time,OCDP001TT.OCDP00198,'r');
    hl=legend('OCDP001 75 ptile','OCDP001 90 ptile','OCDP001 55 ptile','OCDP001 98 ptile');
    ylabel('OCDP001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCDP001','-Map');
    pdftxtstr=strcat(' OCDP001 Map For File-',Merra2ShortFileName);
elseif(ikind==46)
    plot(OCDP002TT.Time,OCDP002TT.OCDP00275,'b',OCDP002TT.Time,OCDP002TT.OCDP00290,'g',...
    OCDP002TT.Time,OCDP002TT.OCDP00295,'k',OCDP002TT.Time,OCDP002TT.OCDP00298,'r');
    hl=legend('OCDP002 75 ptile','OCDP002 90 ptile','OCDP002 55 ptile','OCDP002 98 ptile');
    ylabel('OCDP002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCDP002','-Map');
    pdftxtstr=strcat(' OCDP002 Map For File-',Merra2ShortFileName);
elseif(ikind==47)
    plot(OCEM001TT.Time,OCEM001TT.OCEM00175,'b',OCEM001TT.Time,OCEM001TT.OCEM00190,'g',...
    OCEM001TT.Time,OCEM001TT.OCEM00195,'k',OCEM001TT.Time,OCEM001TT.OCEM00198,'r');
    hl=legend('OCEM001 75 ptile','OCEM001 90 ptile','OCEM001 95 ptile','OCEM001 98 ptile');
    ylabel('OCEM001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCEM001','-Map');
    pdftxtstr=strcat(' OCEM001 Map For File-',Merra2ShortFileName);
elseif(ikind==48)
    plot(OCEM002TT.Time,OCEM002TT.OCEM00275,'b',OCEM002TT.Time,OCEM002TT.OCEM00290,'g',...
    OCEM002TT.Time,OCEM002TT.OCEM00295,'k',OCEM002TT.Time,OCEM002TT.OCEM00298,'r');
    hl=legend('OCEM002 75 ptile','OCEM002 90 ptile','OCEM002 95 ptile','OCEM002 98 ptile');
    ylabel('OCEM002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCEM002','-Map');
    pdftxtstr=strcat(' OCEM002 Map For File-',Merra2ShortFileName);
 elseif(ikind==49)
    plot(OCEMANTT.Time,OCEMANTT.OCEMAN75,'b',OCEMANTT.Time,OCEMANTT.OCEMAN90,'g',...
    OCEMANTT.Time,OCEMANTT.OCEMAN95,'k',OCEMANTT.Time,OCEMANTT.OCEMAN98,'r');
    hl=legend('OCEMAN 75 ptile','OCEMAN 90 ptile','OCEMAN 95 ptile','OCEMAN 98 ptile');
    ylabel('OCEMAN-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCEMAN','-Map');
    pdftxtstr=strcat(' OCEMAN Map For File-',Merra2ShortFileName);
 elseif(ikind==50)
    plot(OCEMBBTT.Time,OCEMBBTT.OCEMBB75,'b',OCEMBBTT.Time,OCEMBBTT.OCEMBB90,'g',...
    OCEMBBTT.Time,OCEMBBTT.OCEMBB95,'k',OCEMBBTT.Time,OCEMBBTT.OCEMBB98,'r');
    hl=legend('OCEMBB 75 ptile','OCEMBB 90 ptile','OCEMBB 95 ptile','OCEMBB 98 ptile');
    ylabel('OCEMBB-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCEMBB','-Map');
    pdftxtstr=strcat(' OCEMBB Map For File-',Merra2ShortFileName);
 elseif(ikind==51)
    plot(OCEMBFTT.Time,OCEMBFTT.OCEMBF75,'b',OCEMBFTT.Time,OCEMBFTT.OCEMBF90,'g',...
    OCEMBFTT.Time,OCEMBFTT.OCEMBF95,'k',OCEMBFTT.Time,OCEMBFTT.OCEMBF98,'r');
    hl=legend('OCEMBF 75 ptile','OCEMBF 90 ptile','OCEMBF 95 ptile','OCEMBF 98 ptile');
    ylabel('OCEMBF-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCEMBF','-Map');
    pdftxtstr=strcat(' OCEMBF Map For File-',Merra2ShortFileName);
 elseif(ikind==52)
    plot(OCEMBGTT.Time,OCEMBGTT.OCEMBG75,'b',OCEMBGTT.Time,OCEMBGTT.OCEMBG90,'g',...
    OCEMBGTT.Time,OCEMBGTT.OCEMBG95,'k',OCEMBGTT.Time,OCEMBGTT.OCEMBG98,'r');
    hl=legend('OCEMBG 75 ptile','OCEMBG 90 ptile','OCEMBG 95 ptile','OCEMBG 98 ptile');
    ylabel('OCEMBG-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCEMBG','-Map');
    pdftxtstr=strcat(' OCEMBG Map For File-',Merra2ShortFileName);
 elseif(ikind==53)
    plot(OCHYPHILTT.Time,OCHYPHILTT.OCHYPHIL75,'b',OCHYPHILTT.Time,OCHYPHILTT.OCHYPHIL90,'g',...
    OCHYPHILTT.Time,OCHYPHILTT.OCHYPHIL95,'k',OCHYPHILTT.Time,OCHYPHILTT.OCHYPHIL98,'r');
    hl=legend('OCHYPHIL 75 ptile','OCHYPHIL 90 ptile','OCHYPHIL 95 ptile','OCHYPHIL 98 ptile');
    ylabel('OCHYPHIL-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCHYPHIL','-Map');
    pdftxtstr=strcat('OCHYPHIL Map For File-',Merra2ShortFileName);
 elseif(ikind==54)
    plot(OCSD001TT.Time,OCSD001TT.OCSD00175,'b',OCSD001TT.Time,OCSD001TT.OCSD00190,'g',...
    OCSD001TT.Time,OCSD001TT.OCSD00195,'k',OCSD001TT.Time,OCSD001TT.OCSD00198,'r');
    hl=legend('OCSD001 75 ptile','OCSD001 90 ptile','OCSD001 95 ptile','OCSD001 98 ptile');
    ylabel('OCSD001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCSD001','-Map');
    pdftxtstr=strcat('OCSD001 Map For File-',Merra2ShortFileName);
 elseif(ikind==55)
    plot(OCSD002TT.Time,OCSD002TT.OCSD00275,'b',OCSD002TT.Time,OCSD002TT.OCSD00290,'g',...
    OCSD002TT.Time,OCSD002TT.OCSD00295,'k',OCSD002TT.Time,OCSD002TT.OCSD00298,'r');
    hl=legend('OCSD002 75 ptile','OCSD002 90 ptile','OCSD002 95 ptile','OCSD002 98 ptile');
    ylabel('OCSD002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCSD002','-Map');
    pdftxtstr=strcat('OCSD002 Map For File-',Merra2ShortFileName);
 elseif(ikind==56)
    plot(OCSV001TT.Time,OCSV001TT.OCSV00175,'b',OCSV001TT.Time,OCSV001TT.OCSV00190,'g',...
    OCSV001TT.Time,OCSV001TT.OCSV00195,'k',OCSV001TT.Time,OCSV001TT.OCSV00198,'r');
    hl=legend('OCSV001 75 ptile','OCSV001 90 ptile','OCSV001 95 ptile','OCSV001 98 ptile');
    ylabel('OCSV001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCSV001','-Map');
    pdftxtstr=strcat('OCSV001 Map For File-',Merra2ShortFileName);
 elseif(ikind==57)
    plot(OCSV002TT.Time,OCSV002TT.OCSV00275,'b',OCSV002TT.Time,OCSV002TT.OCSV00290,'g',...
    OCSV002TT.Time,OCSV002TT.OCSV00295,'k',OCSV002TT.Time,OCSV002TT.OCSV00298,'r');
    hl=legend('OCSV002 75 ptile','OCSV002 90 ptile','OCSV002 95 ptile','OCSV002 98 ptile');
    ylabel('OCSV002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCSV002','-Map');
    pdftxtstr=strcat('OCSV002 Map For File-',Merra2ShortFileName);
 elseif(ikind==58)
    plot(OCWT001TT.Time,OCWT001TT.OCWT00175,'b',OCWT001TT.Time,OCWT001TT.OCWT00190,'g',...
    OCWT001TT.Time,OCWT001TT.OCWT00195,'k',OCWT001TT.Time,OCWT001TT.OCWT00198,'r');
    hl=legend('OCWT001 75 ptile','OCWT001 90 ptile','OCWT001 95 ptile','OCWT001 98 ptile');
    ylabel('OCWT001-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCWT001','-Map');
    pdftxtstr=strcat('OCWT001 Map For File-',Merra2ShortFileName);
 elseif(ikind==59)
    plot(OCWT002TT.Time,OCWT002TT.OCWT00275,'b',OCWT002TT.Time,OCWT002TT.OCWT00290,'g',...
    OCWT002TT.Time,OCWT002TT.OCWT00295,'k',OCWT002TT.Time,OCWT002TT.OCWT00298,'r');
    hl=legend('OCWT002 75 ptile','OCWT002 90 ptile','OCWT002 95 ptile','OCWT002 98 ptile');
    ylabel('OCWT002-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
    sectionstr=strcat('OCWT002','-Map');
    pdftxtstr=strcat('OCWT002 Map For File-',Merra2ShortFileName);
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
        headingstr1=strcat('Tabular Analysis Results For-','Dry Organic Carbon Data');
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
    if(ikind==45)
        parastr2='This metric is the value of the Dry Organic Carbon Deposition Bin 01.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==46)
        parastr2='This metric is the value of the Dry Organic Carbon Deposition Bin 02.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==47)
        parastr2='This metric is the value of the Organic Carbon Emission Bin 01.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==48)
        parastr2='This metric is the value of the Organic Carbon Emission Bin 02.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==49)
        parastr2='This metric is the value of the Organic Carbon Antropogenic Emission.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==50)
        parastr2='This metric is the value of the Organic Carbon Biomass Burning Emission.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==51)
        parastr2='This metric is the value of the Organic Carbon Biofuel Emission.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==52)
        parastr2='This metric is the value of the Organic Carbon Biogenic Emission.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==53)
        parastr2='This metric is the value of the Organic Carbon Hydrophobic to Hydrophilic emission.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==54)
        parastr2='This metric is the value of the Organic Carbon Sedimentation Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==55)
        parastr2='This metric is the value of the Organic Carbon Sedimentation Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==56)
        parastr2='This metric is the value of the Organic Carbon Convective Scavenging for Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Convective scavenging removes aerosol particles from the atmosphere.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==57)
        parastr2='This metric is the value of the Organic Carbon Convective Scavenging for Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Convective scavenging removes aerosol particles from the atmosphere.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==58)
        parastr2='This metric is the value of the Organic Wet Carbon Deposition Bin 001.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==59)
        parastr2='This metric is the value of the Organic Wet Carbon Deposition Bin 002.';
        parastr3=' The expected data is well under a femtogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(ikind==45)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCDP001TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCDP0150';
        Hdrs{1,5}='OCDP0175';
        Hdrs{1,6}='OCDP0190';
        Hdrs{1,7}='OCDP0195';
        Hdrs{1,8}='OCDP0198';
        Hdrs{1,9}='OCDP01100';
        Col1=OCDP001Table.OCDP00150;
        Col2=OCDP001Table.OCDP00175;
        Col3=OCDP001Table.OCDP00190;
        Col4=OCDP001Table.OCDP00195;
        Col5=OCDP001Table.OCDP00198;
        Col6=OCDP001Table.OCDP001100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Organic Carbon Bin001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCDP001Table over the selected data range.';
        parastr602=' OCDP001 is the dry organic black carbon deposition for bin 01 ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==46)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCDP002TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCDP0250';
        Hdrs{1,5}='OCDP0275';
        Hdrs{1,6}='OCDP0290';
        Hdrs{1,7}='OCDP0295';
        Hdrs{1,8}='OCDP0298';
        Hdrs{1,9}='OCDP02100';
        Col1=OCDP002Table.OCDP00250;
        Col2=OCDP002Table.OCDP00275;
        Col3=OCDP002Table.OCDP00290;
        Col4=OCDP002Table.OCDP00295;
        Col5=OCDP002Table.OCDP00298;
        Col6=OCDP002Table.OCDP002100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Dry Organic Carbon Bin002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCDP002Table over the selected data range.';
        parastr602=' OCDP002 is the dry organic black carbon deposition for bin 02 ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==47)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCEM001TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCEM0150';
        Hdrs{1,5}='OCEM0175';
        Hdrs{1,6}='OCEM0190';
        Hdrs{1,7}='OCEM0195';
        Hdrs{1,8}='OCEM0198';
        Hdrs{1,9}='OCEM01100';
        Col1=OCEM001Table.OCEM00150;
        Col2=OCEM001Table.OCEM00175;
        Col3=OCEM001Table.OCEM00190;
        Col4=OCEM001Table.OCEM00195;
        Col5=OCEM001Table.OCEM00198;
        Col6=OCEM001Table.OCEM001100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Emission Bin001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCEM001Table over the selected data range.';
        parastr602=' OCEM001 is the dry organic black carbon emission for bin 01 ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==48)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCEM002TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCEM0250';
        Hdrs{1,5}='OCEM0275';
        Hdrs{1,6}='OCEM0290';
        Hdrs{1,7}='OCEM0295';
        Hdrs{1,8}='OCEM0298';
        Hdrs{1,9}='OCEM02100';
        Col1=OCEM002Table.OCEM00250;
        Col2=OCEM002Table.OCEM00275;
        Col3=OCEM002Table.OCEM00290;
        Col4=OCEM002Table.OCEM00295;
        Col5=OCEM002Table.OCEM00298;
        Col6=OCEM002Table.OCEM002100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Emission Bin002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCEM002Table over the selected data range.';
        parastr602=' OCEM002 is the dry organic black carbon emission for bin 01 ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==49)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCEMANTT.Properties.RowTimes);
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
        Hdrs{1,4}='OCEMN50';
        Hdrs{1,5}='OCEMN75';
        Hdrs{1,6}='OCEMN90';
        Hdrs{1,7}='OCEMN95';
        Hdrs{1,8}='OCEMN98';
        Hdrs{1,9}='OCEMN100';
        Col1=OCEMANTable.OCEMAN50;
        Col2=OCEMANTable.OCEMAN75;
        Col3=OCEMANTable.OCEMAN90;
        Col4=OCEMANTable.OCEMAN95;
        Col5=OCEMANTable.OCEMAN98;
        Col6=OCEMANTable.OCEMAN100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Antro EmissionFor=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCEMANTable over the selected data range.';
        parastr602=' OCEMAN is the organic black carbon antropogenic emission  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==50)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCEMBBTT.Properties.RowTimes);
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
        Hdrs{1,4}='OCEMB50';
        Hdrs{1,5}='OCEMB75';
        Hdrs{1,6}='OCEMB90';
        Hdrs{1,7}='OCEMB95';
        Hdrs{1,8}='OCEMB98';
        Hdrs{1,9}='OCEMB100';
        Col1=OCEMBBTable.OCEMBB50;
        Col2=OCEMBBTable.OCEMBB75;
        Col3=OCEMBBTable.OCEMBB90;
        Col4=OCEMBBTable.OCEMBB95;
        Col5=OCEMBBTable.OCEMBB98;
        Col6=OCEMBBTable.OCEMBB100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Biomass Burning Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCEMBBTable over the selected data range.';
        parastr602=' OCEMBB is the organic carbon burning biomass emission  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==51)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCEMBFTT.Properties.RowTimes);
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
        Hdrs{1,4}='OCEMBF50';
        Hdrs{1,5}='OCEMBF75';
        Hdrs{1,6}='OCEMBF90';
        Hdrs{1,7}='OCEMBF95';
        Hdrs{1,8}='OCEMBF98';
        Hdrs{1,9}='OCEMBF100';
        Col1=OCEMBFTable.OCEMBF50;
        Col2=OCEMBFTable.OCEMBF75;
        Col3=OCEMBFTable.OCEMBF90;
        Col4=OCEMBFTable.OCEMBF95;
        Col5=OCEMBFTable.OCEMBF98;
        Col6=OCEMBFTable.OCEMBF100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Biofuel Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCEMBFTable over the selected data range.';
        parastr602=' OCEMBF is the organic carbon biofuel emission  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==52)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCEMBGTT.Properties.RowTimes);
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
        Hdrs{1,4}='OCEMG50';
        Hdrs{1,5}='OCEMG75';
        Hdrs{1,6}='OCEMG90';
        Hdrs{1,7}='OCEMG95';
        Hdrs{1,8}='OCEMG98';
        Hdrs{1,9}='OCEMG100';
        Col1=OCEMBGTable.OCEMBG50;
        Col2=OCEMBGTable.OCEMBG75;
        Col3=OCEMBGTable.OCEMBG90;
        Col4=OCEMBGTable.OCEMBG95;
        Col5=OCEMBGTable.OCEMBG98;
        Col6=OCEMBGTable.OCEMBG100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Biogenic Burning Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCEMBGTable over the selected data range.';
        parastr602=' OCEMBG is the organic carbon biogenic emission  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==53)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCHYPHILTT.Properties.RowTimes);
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
        Hdrs{1,4}='OCHY50';
        Hdrs{1,5}='OCHY75';
        Hdrs{1,6}='OCHY90';
        Hdrs{1,7}='OCHY95';
        Hdrs{1,8}='OCHY98';
        Hdrs{1,9}='OCHY100';
        Col1=OCHYPHILTable.OCHYPHIL50;
        Col2=OCHYPHILTable.OCHYPHIL75;
        Col3=OCHYPHILTable.OCHYPHIL90;
        Col4=OCHYPHILTable.OCHYPHIL95;
        Col5=OCHYPHILTable.OCHYPHIL98;
        Col6=OCHYPHILTable.OCHYPHIL100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Hydrophobic to HydroPhilic Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCHYPHILTable over the selected data range.';
        parastr602=' OCHYPHIL is the organic carbon hydrophobic to hydrophilic emission  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==54)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCSD001TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCSD50';
        Hdrs{1,5}='OCSD75';
        Hdrs{1,6}='OCSD90';
        Hdrs{1,7}='OCSD95';
        Hdrs{1,8}='OCSD98';
        Hdrs{1,9}='OCSD100';
        Col1=OCSD001Table.OCSD00150;
        Col2=OCSD001Table.OCSD00175;
        Col3=OCSD001Table.OCSD00190;
        Col4=OCSD001Table.OCSD00195;
        Col5=OCSD001Table.OCSD00198;
        Col6=OCSD001Table.OCSD001100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Sedimentation Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCSD001Table over the selected data range.';
        parastr602=' OCSD001 is the organic carbon seimentation in Bin 001  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==55)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCSD002TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCSD50';
        Hdrs{1,5}='OCSD75';
        Hdrs{1,6}='OCSD90';
        Hdrs{1,7}='OCSD95';
        Hdrs{1,8}='OCSD98';
        Hdrs{1,9}='OCSD100';
        Col1=OCSD002Table.OCSD00250;
        Col2=OCSD002Table.OCSD00275;
        Col3=OCSD002Table.OCSD00290;
        Col4=OCSD002Table.OCSD00295;
        Col5=OCSD002Table.OCSD00298;
        Col6=OCSD002Table.OCSD002100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Sedimentation Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCSD002Table over the selected data range.';
        parastr602=' OCSD002 is the organic carbon sedimentation in Bin 002  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==56)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCSV001TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCSV50';
        Hdrs{1,5}='OCSV75';
        Hdrs{1,6}='OCSV90';
        Hdrs{1,7}='OCSV95';
        Hdrs{1,8}='OCSV98';
        Hdrs{1,9}='OCSV100';
        Col1=OCSV001Table.OCSV00150;
        Col2=OCSV001Table.OCSV00175;
        Col3=OCSV001Table.OCSV00190;
        Col4=OCSV001Table.OCSV00195;
        Col5=OCSV001Table.OCSV00198;
        Col6=OCSV001Table.OCSV001100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Scavenging Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCSV001Table over the selected data range.';
        parastr602=' OCSV001 is the organic carbon scavenging in Bin 001  ';
        parastr603=' Scavenging due to convective currents removes organic carbon aerosols .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==57)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCSV002TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCSV50';
        Hdrs{1,5}='OCSV75';
        Hdrs{1,6}='OCSV90';
        Hdrs{1,7}='OCSV95';
        Hdrs{1,8}='OCSV98';
        Hdrs{1,9}='OCSV100';
        Col1=OCSV002Table.OCSV00250;
        Col2=OCSV002Table.OCSV00275;
        Col3=OCSV002Table.OCSV00290;
        Col4=OCSV002Table.OCSV00295;
        Col5=OCSV002Table.OCSV00298;
        Col6=OCSV002Table.OCSV002100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Carbon Scavenging Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCSV002Table over the selected data range.';
        parastr602=' OCSV002 is the organic carbon scavenging in Bin 002  ';
        parastr603=' Scavenging due to convective currents removes organic carbon aerosols .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==58)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCWT001TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCWT50';
        Hdrs{1,5}='OCWT75';
        Hdrs{1,6}='OCWT90';
        Hdrs{1,7}='OCWT95';
        Hdrs{1,8}='OCWT98';
        Hdrs{1,9}='OCWT100';
        Col1=OCWT001Table.OCWT00150;
        Col2=OCWT001Table.OCWT00175;
        Col3=OCWT001Table.OCWT00190;
        Col4=OCWT001Table.OCWT00195;
        Col5=OCWT001Table.OCWT00198;
        Col6=OCWT001Table.OCWT001100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Wet Deposition Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCWT001Table over the selected data range.';
        parastr602=' OCWT001 is the organic wet carbon deposition  in Bin 001  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);

      elseif(ikind==59)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(OCWT002TT.Properties.RowTimes);
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
        Hdrs{1,4}='OCWT50';
        Hdrs{1,5}='OCWT75';
        Hdrs{1,6}='OCWT90';
        Hdrs{1,7}='OCWT95';
        Hdrs{1,8}='OCWT98';
        Hdrs{1,9}='OCWT100';
        Col1=OCWT002Table.OCWT00250;
        Col2=OCWT002Table.OCWT00275;
        Col3=OCWT002Table.OCWT00290;
        Col4=OCWT002Table.OCWT00295;
        Col5=OCWT002Table.OCWT00298;
        Col6=OCWT002Table.OCWT002100;
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
            NumberFormat("%1.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Organic Wet Deposition Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the OCWT002Table over the selected data range.';
        parastr602=' OCWT002 is the organic wet carbon deposition  in Bin 002  ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);



    end
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end