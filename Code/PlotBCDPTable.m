function PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function is plots the BCDP familiy results.
% Is the Black Carbon Deposition density in kg/m2/sec * 1E-15 to produce a
% and easier to read result
% 
%
% Written By: Stephen Forczyk
% Created: June 11,2023
% Revised: June 12 ,2023 added more variables
% Revised: Juky 14,2023 added BCSV001 and BCSV002 variables

% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global BCDP001S BCDP002S BCEM001S BCEM002S;
global BCDP00110 BCDP00125 BCDP00150 BCDP00175 BCDP00190 BCDP001100;
global BCDP001Low BCDP001High BCDP001NaN BCDP001Values;
global BCDP001Table BCDP001TT;
global BCDP00210 BCDP00225 BCDP00250 BCDP00275 BCDP00290 BCDP002100;
global BCDP002Low BCDP002High BCDP002NaN BCDP002Values;
global BCDP002Table BCDP002TT;
global BCEM00110 BCEM00125 BCEM00150 BCEM00175 BCEM00190 BCEM001100;
global BCEM001Low BCEM001High BCEM001NaN BCEM001Values;
global BCEM001Table BCEM001TT BCEM002Table BCEM002TT;
global BCEMANS;
global BCEMAN10 BCEMAN25 BCEMAN50 BCEMAN75 BCEMAN90 BCEMAN100;
global BCEMANLow  BCEMANHigh BCEMANNaN BCEMANValues;
global BCEMANTable BCEMANTT;
global BCEMBF10 BCEMBF25 BCEMBF50 BCEMBF75 BCEMBF90 BCEMBF100;
global BCEMBFLow  BCEMBFHigh BCEMBFNaN BCEMBFValues;
global BCEMBFTable BCEMBFTT;
global BCHYPHIL10 BCHYPHIL25 BCHYPHIL50 BCHYPHIL75 BCHYPHIL90 BCHYPHIL100;
global BCHYPHILFLow  BCHYPHILHigh BCHYPHILNaN BCHYPHILValues;
global BCHYPHILFTable BCHYPHILFTT;
global BCSV00110 BCSV00125 BCSV00150 BCSV00175 BCSV00190 BCSV00195 BCSV00198 BCSV001100;
global BCSV001Table BCSV001TT;
global BCSV001Low BCSV001High BCSV001NaN BCSV001Values;
global BCSV00210 BCSV00225 BCSV00250 BCSV00275 BCSV00290 BCSV00295 BCSV00298 BCSV002100;
global BCSV002Low BCSV002High BCSV002NaN BCSV002Values;
global BCSV002Table BCSV002TT;
global numtimeslice TimeSlices;
global Years Months Days;

global BCEMBB10 BCEMBB25 BCEMBB50 BCEMBB75 BCEMBB90 ;
global BCEMBBLow  BCEMBBHigh BCEMBBNaN BCEMBBValues;
global BCEMBBTable BCEMBBTT;
global BCSD00110 BCSD00125 BCSD00150 BCSD00175 BCSD00190 BCSD001100;
global BCSD001Low BCSD001High BCSD001NaN BCSD001Values;
global BCSD001Table BCSD001TT;
global BCSD00210 BCSD00225 BCSD00250 BCSD00275 BCSD00290 BCSD002100;
global BCSD002Low BCSD002High BCSD002NaN BCSD002Values;
global BCSD002Table BCSD002TT;
global BCWT001Table BCWT001TT BCWT002Table BCWT002TT;
global Merra2ShortFileName;
global yd md dd hd mind secd;

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
if(ikind==1)
    plot(BCDP001TT.Time,BCDP001TT.BCDP00175,'b',BCDP001TT.Time,BCDP001TT.BCDP00190,'g',...
        BCDP001TT.Time,BCDP001TT.BCDP00195,'k',BCDP001TT.Time,BCDP001TT.BCDP00198,'r');
elseif(ikind==2)
    plot(BCDP002TT.Time,BCDP002TT.BCDP00275,'b',BCDP002TT.Time,BCDP002TT.BCDP00290,'g',...
        BCDP002TT.Time,BCDP002TT.BCDP00295,'k',BCDP002TT.Time,BCDP002TT.BCDP00298,'r');
elseif(ikind==3)
    plot(BCEM001TT.Time,BCEM001TT.BCEM00125,'b',BCEM001TT.Time,BCEM001TT.BCEM00150,'g',...
    BCEM001TT.Time,BCEM001TT.BCEM00175,'k',BCEM001TT.Time,BCEM001TT.BCEM00190,'r');
elseif(ikind==4)
    plot(BCEM002TT.Time,BCEM002TT.BCEM00225,'b',BCEM002TT.Time,BCEM002TT.BCEM00250,'g',...
    BCEM002TT.Time,BCEM002TT.BCEM00275,'k',BCEM002TT.Time,BCEM002TT.BCEM00290,'r');
elseif(ikind==5)
    plot(BCEMANTT.Time,BCEMANTT.BCEMAN25,'b',BCEMANTT.Time,BCEMANTT.BCEMAN50,'g',...
    BCEMANTT.Time,BCEMANTT.BCEMAN75,'k',BCEMANTT.Time,BCEMANTT.BCEMAN90,'r');
elseif(ikind==6)
    plot(BCEMBBTT.Time,BCEMBBTT.BCEMBB75,'b',BCEMBBTT.Time,BCEMBBTT.BCEMBB90,'g',...
    BCEMBBTT.Time,BCEMBBTT.BCEMBB95,'k',BCEMBBTT.Time,BCEMBBTT.BCEMBB98,'r');
elseif(ikind==7)
    plot(BCEMBFTT.Time,BCEMBFTT.BCEMBF25,'b',BCEMBFTT.Time,BCEMBFTT.BCEMBF50,'g',...
    BCEMBFTT.Time,BCEMBFTT.BCEMBF75,'k',BCEMBFTT.Time,BCEMBFTT.BCEMBF90,'r');
elseif(ikind==8)
    plot(BCHYPHILFTT.Time,BCHYPHILFTT.BCHYPHIL25,'b',BCHYPHILFTT.Time,BCHYPHILFTT.BCHYPHIL50,'g',...
    BCHYPHILFTT.Time,BCHYPHILFTT.BCHYPHIL75,'k',BCHYPHILFTT.Time,BCHYPHILFTT.BCHYPHIL90,'r');
elseif(ikind==9)
    plot(BCSD001TT.Time,BCSD001TT.BCSD00125,'b',BCSD001TT.Time,BCSD001TT.BCSD00150,'g',...
    BCSD001TT.Time,BCSD001TT.BCSD00175,'k',BCSD001TT.Time,BCSD001TT.BCSD00190,'r');
elseif(ikind==10)
    plot(BCSD002TT.Time,BCSD002TT.BCSD00225,'b',BCSD002TT.Time,BCSD002TT.BCSD00250,'g',...
    BCSD002TT.Time,BCSD002TT.BCSD00275,'k',BCSD002TT.Time,BCSD002TT.BCSD00290,'r');
elseif(ikind==11)
    plot(BCSV001TT.Time,BCSV001TT.BCSV00175,'b',BCSV001TT.Time,BCSV001TT.BCSV00190,'g',...
    BCSV001TT.Time,BCSV001TT.BCSV00195,'k',BCSV001TT.Time,BCSV001TT.BCSV00198,'r');
elseif(ikind==12)
    plot(BCSV002TT.Time,BCSV002TT.BCSV00275,'b',BCSV002TT.Time,BCSV002TT.BCSV00290,'g',...
    BCSV002TT.Time,BCSV002TT.BCSV00295,'k',BCSV002TT.Time,BCSV002TT.BCSV00298,'r');
elseif(ikind==13)
    plot(BCSV001TT.Time,BCSV001TT.BCSV00175,'b',BCSV001TT.Time,BCSV001TT.BCSV00190,'g',...
    BCSV001TT.Time,BCSV001TT.BCSV00195,'k',BCSV001TT.Time,BCSV001TT.BCSV00198,'r');
elseif(ikind==14)
    plot(BCWT002TT.Time,BCWT002TT.BCWT00275,'b',BCWT002TT.Time,BCWT002TT.BCWT00290,'g',...
    BCWT002TT.Time,BCWT002TT.BCWT00295,'k',BCWT002TT.Time,BCWT002TT.BCWT00298,'r');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==1)
    hl=legend('BCDP001 75 ptile','BCDP001 90 ptile','BCDP001 95 ptile','BCDP001 98 ptile');
elseif(ikind==2)
    hl=legend('BCDP002 75 ptile','BCDP002 90 ptile','BCDP002 95 ptile','BCDP002 98 ptile');
elseif(ikind==3)
    hl=legend('BCEM001 25 ptile','BCEM00150 ptile','BCEM001 75 ptile','BCEM001 90 ptile');
elseif(ikind==4)
    hl=legend('BCEM002 25 ptile','BCEM002 50 ptile','BCEM002 75 ptile','BCEM002 90 ptile');
elseif(ikind==5)
    hl=legend('BCEMAN 25 ptile','BCEMAN 50 ptile','BCEMAN 75 ptile','BCEMAN 90 ptile');
elseif(ikind==6)
    hl=legend('BCEMBB 75 ptile','BCEMBB 90 ptile','BCEMBB 95 ptile','BCEMBB 98 ptile');
elseif(ikind==7)
    hl=legend('BCEMBF 25 ptile','BCEMBF 50 ptile','BCEMBF 75 ptile','BCEMBF 90 ptile');
elseif(ikind==8)
    hl=legend('BCHYPHIL 25 ptile','BCHYPHIL 50 ptile','BCHYPHIL 75 ptile','BCHYPHIL 90 ptile');
elseif(ikind==9)
    hl=legend('BCSD001 25 ptile','BCSD001 50 ptile','BCSD001 75 ptile','BCSD001 90 ptile');
elseif(ikind==10)
    hl=legend('BCSD002 25 ptile','BCSD002 50 ptile','BCSD002 75 ptile','BCSD002 90 ptile');
elseif(ikind==11)
    hl=legend('BCSV001 75 ptile','BCSV001 90 ptile','BCSV001 95 ptile','BCSV001 98 ptile');
elseif(ikind==12)
    hl=legend('BCSV002 75 ptile','BCSV002 90 ptile','BCSV002 95 ptile','BCSV002 98 ptile');
elseif(ikind==13)
    hl=legend('BCWT001 75 ptile','BCWT001 90 ptile','BCWT001 95 ptile','BWT001 98 ptile');
elseif(ikind==14)
    hl=legend('BCWT002 75 ptile','BCWT002 90 ptile','BCWT002 95 ptile','BWT002 98 ptile');
end
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);

if(ikind==1)
    ylabel('BCDP001-nanograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==2)
    ylabel('BCDP002-nanograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==3)
    ylabel('BCDP001-nanograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==4)
    ylabel('BCDP001-nanograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==5)
    ylabel('BCEMAN-femtograms/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==6)
    ylabel('BCEMBB-femtogm/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==7)
    ylabel('BCEMBF-femtogm/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==8)
    ylabel('BCHYPHIL-femto/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==9)
    ylabel('BCSD001-attogm/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==10)
    ylabel('BCSD002-attogm/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==11)
    ylabel('BCSV001-femtogm/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==12)
    ylabel('BCSV002-femtogm/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==13)
    ylabel('BCWT001-femtogm/m^2/sec','FontWeight','bold','FontSize',12);
elseif(ikind==14)
    ylabel('BCWT002-femtogm/m^2/sec','FontWeight','bold','FontSize',12);
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
        headingstr1=strcat('Tabular Analysis Results For','Black Carbon Data');
        chapter = Chapter("Title",headingstr1);
    end
    if(ikind==1)
        sectionstr=strcat('BCDP001','-Map');
    elseif(ikind==2)
        sectionstr=strcat('BCDP002','-Map');
    elseif(ikind==3)
        sectionstr=strcat('BCEM001','-Map');
    elseif(ikind==4)
        sectionstr=strcat('BCEM002','-Map');
    elseif(ikind==5)
        sectionstr=strcat('BCEMAN','-Map');
    elseif(ikind==6)
        sectionstr=strcat('BCEMBB','-Map');
    elseif(ikind==7)
        sectionstr=strcat('BCEMBF','-Map');
    elseif(ikind==8)
        sectionstr=strcat('BCHYPHIL','-Map');
    elseif(ikind==9)
        sectionstr=strcat('BCSD001','-Map');
    elseif(ikind==10)
        sectionstr=strcat('BCSD002','-Map');
    elseif(ikind==11)
        sectionstr=strcat('BCSV001','-Map');
    elseif(ikind==12)
        sectionstr=strcat('BCSV002','-Map');
    elseif(ikind==13)
        sectionstr=strcat('BCWT001','-Map');
    elseif(ikind==14)
        sectionstr=strcat('BCWT002','-Map');
    end
    
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    if(ikind==1)
        pdftxtstr=strcat(' BCDP01 Map For File-',Merra2ShortFileName);
    elseif(ikind==2)
        pdftxtstr=strcat(' BCDP02 Map For File-',Merra2ShortFileName);
    elseif(ikind==3)
        pdftxtstr=strcat(' BCEM01 Map For File-',Merra2ShortFileName);
    elseif(ikind==4)
        pdftxtstr=strcat(' BCEM02 Map For File-',Merra2ShortFileName);
    elseif(ikind==5)
        pdftxtstr=strcat(' BCEMAN Map For File-',Merra2ShortFileName);
    elseif(ikind==6)
        pdftxtstr=strcat(' BCEMBB Map For File-',Merra2ShortFileName);
    elseif(ikind==7)
        pdftxtstr=strcat(' BCEMBF Map For File-',Merra2ShortFileName);
    elseif(ikind==8)
        pdftxtstr=strcat(' BCHYPHIL Map For File-',Merra2ShortFileName);
    elseif(ikind==9)
        pdftxtstr=strcat(' BCSD001 Map For File-',Merra2ShortFileName);
    elseif(ikind==10)
        pdftxtstr=strcat(' BCSD002 Map For File-',Merra2ShortFileName);
    elseif(ikind==11)
        pdftxtstr=strcat(' BCSV001 Map For File-',Merra2ShortFileName);
    elseif(ikind==12)
        pdftxtstr=strcat(' BCSV002 Map For File-',Merra2ShortFileName);
    elseif(ikind==13)
        pdftxtstr=strcat(' BCWT001 Map For File-',Merra2ShortFileName);
    elseif(ikind==14)
        pdftxtstr=strcat(' BCWT002 Map For File-',Merra2ShortFileName);
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
% Now add some text -start by description with a basic description of the
% variable being plotted
    parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
    if(ikind==1)
        parastr2='This metric is the value of the Black Carbon Dry Deposition Bin 001 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==2)
        parastr2='This metric is the value of the Black Carbon Dry Deposition Bin 002 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==3)
        parastr2='This metric is the value of the Black Carbon Emission Bin 001 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==4)
        parastr2='This metric is the value of the Black Carbon Emission Bin 002 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==5)
        parastr2='This metric is the value of the Black Carbon Anthropogenic Emission .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==6)
        parastr2='This metric is the value of the Black Carbon Burning Biomass Emission .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==7)
        parastr2='This metric is the value of the Black Carbon Biofuel Emission .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==8)
        parastr2='This metric is the value of the Black Carbon Hydrophobic to hydrophilic .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==9)
        parastr2='This metric is the value of the Black Carbon Sedimentation in Bin001 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==10)
        parastr2='This metric is the value of the Black Carbon Sedimentation in Bin002 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==11)
        parastr2='This metric is the value of the Black Carbon Scavenging in Bin001 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Convective scavenging acts as a sink for black carbon aerosol particles.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==12)
        parastr2='This metric is the value of the Black Carbon Scavenging in Bin002 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Convective scavenging acts as a sink for black carbon aerosol particles.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==13)
        parastr2='This metric is the value of the Black Carbon Wet Deposition in Bin001 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    elseif(ikind==14)
        parastr2='This metric is the value of the Black Carbon Wet Deposition in Bin002 .';
        parastr3=' The expected data is well under a nanogram /m^2/sec.';
        parastr4=' Even at these low levels this can affect can affect atmospheric teperature gradiants.';
        parastr5=' In turn this can impact cloud formation';
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
  % Add Table To Report for the Burning Biomass (ikind==1)
    if(ikind==1)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCDP001TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCDP0150';
        Hdrs{1,5}='BCDP0175';
        Hdrs{1,6}='BCDP0190';
        Hdrs{1,7}='BCDP0195';
        Hdrs{1,8}='BCDP0198';
        Hdrs{1,9}='BCDP01100';
        Col1=BCDP001Table.BCDP00150;
        Col2=BCDP001Table.BCDP00175;
        Col3=BCDP001Table.BCDP00190;
        Col4=BCDP001Table.BCDP00195;
        Col5=BCDP001Table.BCDP00198;
        Col6=BCDP001Table.BCDP001100;
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
 %       tbl1.Style = [tbl1.Style {Border('solid','black','3px')}];
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Hourly Data Black Carbon Dry Deposition For Bin 01=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr101='The table above shows the distribution of the BCDP001Table over the selected data range.';
        parastr102=' BCDP001 is Dry black carbon deposition in Bin 01 which has the smallest sizes ';
        parastr103=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr109=strcat(parastr101,parastr102,parastr103);
        p109= Paragraph(parastr109);
        p109.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p109);
    elseif(ikind==2)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCDP002TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCDP0250';
        Hdrs{1,5}='BCDP0275';
        Hdrs{1,6}='BCDP0290';
        Hdrs{1,7}='BCDP0295';
        Hdrs{1,8}='BCDP0298';
        Hdrs{1,9}='BCDP02100';
        Col1=BCDP002Table.BCDP00250;% 
        Col2=BCDP002Table.BCDP00275;
        Col3=BCDP002Table.BCDP00290;
        Col4=BCDP002Table.BCDP00295;
        Col5=BCDP002Table.BCDP00298;
        Col6=BCDP002Table.BCDP002100;
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
        T2=[Hdrs;myCellArray];
        tbl2=Table(T2);
        tbl2.Style = [tbl2.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl2.TableEntriesHAlign = 'center';
        tbl2.HAlign='center';
        tbl2.ColSep = 'single';
        tbl2.RowSep = 'single';
        r = row(tbl2,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt2 = BaseTable(tbl2);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Hourly Data Black Carbon Dry Deposition For Bin02=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt2.Title = tabletitle;
        bt2.TableWidth="7in";
        add(chapter,bt2);
        parastr201='The table above shows the distribution of the BCDP002Table over the selected data range.';
        parastr202=' BCDP002 is Dry black carbon deposition in Bin 02 which has the net larger size ';
        parastr203=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr209=strcat(parastr201,parastr202,parastr203);
        p209= Paragraph(parastr209);
        p209.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p209);
     elseif(ikind==3)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCEM001TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCME0110';
        Hdrs{1,5}='BCEM0125';
        Hdrs{1,6}='BCEM0150';
        Hdrs{1,7}='BCEM0175';
        Hdrs{1,8}='BCEM0190';
        Hdrs{1,9}='BCEM01100';
        Col1=BCEM001Table.BCEM00110; 
        Col2=BCEM001Table.BCEM00125;
        Col3=BCEM001Table.BCEM00150;
        Col4=BCEM001Table.BCEM00175;
        Col5=BCEM001Table.BCEM00190;
        Col6=BCEM001Table.BCEM001100;
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
        T3=[Hdrs;myCellArray];
        tbl3=Table(T3);
        tbl3.Style = [tbl3.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl3.TableEntriesHAlign = 'center';
        tbl3.HAlign='center';
        tbl3.ColSep = 'single';
        tbl3.RowSep = 'single';
        r = row(tbl3,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt3 = BaseTable(tbl3);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Hourly Data Black Carbon Emission For Bin01=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt3.Title = tabletitle;
        bt3.TableWidth="7in";
        add(chapter,bt3);
        parastr301='The table above shows the distribution of the BCEM001Table over the selected data range.';
        parastr302=' BCEM001 is Dry black carbon deposition in Bin 01 which has the net larger size ';
        parastr303=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr309=strcat(parastr301,parastr302,parastr303);
        p309= Paragraph(parastr309);
        p309.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p309);
     elseif(ikind==4)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCEM002TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCEM0210';
        Hdrs{1,5}='BCEM0225';
        Hdrs{1,6}='BCEM0250';
        Hdrs{1,7}='BCEM0275';
        Hdrs{1,8}='BCEM0290';
        Hdrs{1,9}='BCEM02100';
        Col1=BCEM002Table.BCEM00210; 
        Col2=BCEM002Table.BCEM00225;
        Col3=BCEM002Table.BCEM00250;
        Col4=BCEM002Table.BCEM00275;
        Col5=BCEM002Table.BCEM00290;
        Col6=BCEM002Table.BCEM002100;
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
        T4=[Hdrs;myCellArray];
        tbl4=Table(T4);
        tbl4.Style = [tbl4.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl4.TableEntriesHAlign = 'center';
        tbl4.HAlign='center';
        tbl4.ColSep = 'single';
        tbl4.RowSep = 'single';
        r = row(tbl4,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt4 = BaseTable(tbl4);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Hourly Data Black Carbon Emission For Bin02=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt4.Title = tabletitle;
        bt4.TableWidth="7in";
        add(chapter,bt4);
        parastr401='The table above shows the distribution of the BCEM002Table over the selected data range.';
        parastr402=' BCEM002 is Dry black carbon deposition in Bin 02 which has the net larger size ';
        parastr403=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr409=strcat(parastr401,parastr402,parastr403);
        p409= Paragraph(parastr409);
        p409.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p409);
     elseif(ikind==5)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCEMANTT.Properties.RowTimes);
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
        Hdrs{1,4}='BCEMAN10';
        Hdrs{1,5}='BCEMAN25';
        Hdrs{1,6}='BCEMAN50';
        Hdrs{1,7}='BCEMAN75';
        Hdrs{1,8}='BCEMAN90';
        Hdrs{1,9}='BCEMAN100';
        Col1=BCEMANTable.BCEMAN10; 
        Col2=BCEMANTable.BCEMAN25;
        Col3=BCEMANTable.BCEMAN50;
        Col4=BCEMANTable.BCEMAN75;
        Col5=BCEMANTable.BCEMAN90;
        Col6=BCEMANTable.BCEMAN100;
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
        T5=[Hdrs;myCellArray];
        tbl5=Table(T5);
        tbl5.Style = [tbl5.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl5.TableEntriesHAlign = 'center';
        tbl5.HAlign='center';
        tbl5.ColSep = 'single';
        tbl5.RowSep = 'single';
        r = row(tbl5,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt5 = BaseTable(tbl5);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Hourly Data Black Carbon Antropogenic Emission For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt5.Title = tabletitle;
        bt5.TableWidth="7in";
        add(chapter,bt5);
        parastr501='The table above shows the distribution of the BCEMANTable over the selected data range.';
        parastr502=' BCEMAN is Dry black carbon antropogenic emission in over all sizes ';
        parastr503=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr509=strcat(parastr501,parastr502,parastr503);
        p509= Paragraph(parastr509);
        p509.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p509);

    elseif(ikind==6)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCEMBBTT.Properties.RowTimes);
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
        Hdrs{1,4}='BCEMB50';
        Hdrs{1,5}='BCEMB75';
        Hdrs{1,6}='BCEMB90';
        Hdrs{1,7}='BCEMB95';
        Hdrs{1,8}='BCEMB98';
        Hdrs{1,9}='BCEMB100';
        Col1=BCEMBBTable.BCEMBB50;
        Col2=BCEMBBTable.BCEMBB75;
        Col3=BCEMBBTable.BCEMBB90;
        Col4=BCEMBBTable.BCEMBB95;
        Col5=BCEMBBTable.BCEMBB98;
        Col6=BCEMBBTable.BCEMBB100;
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
        T6=[Hdrs;myCellArray];
        tbl6=Table(T6);
        tbl6.Style = [tbl6.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl6.TableEntriesHAlign = 'center';
        tbl6.HAlign='center';
        tbl6.ColSep = 'single';
        tbl6.RowSep = 'single';
        r = row(tbl6,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt6 = BaseTable(tbl6);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Burning Biomass For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt6.Title = tabletitle;
        bt6.TableWidth="7in";
        add(chapter,bt6);
        parastr601='The table above shows the distribution of the BCEMBBTable over the selected data range.';
        parastr602=' BCEMBB is the emissions due to black carbon biomass emissions ';
        parastr603=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr604=' A diurnal cycle is generally observed for these emissions.';
        parastr605=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr609=strcat(parastr601,parastr602,parastr603,parastr604,parastr605);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==7)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCEMBFTT.Properties.RowTimes);
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
        Hdrs{1,4}='BCEMBF10';
        Hdrs{1,5}='BCEMBF25';
        Hdrs{1,6}='BCEMBF50';
        Hdrs{1,7}='BCEMBF75';
        Hdrs{1,8}='BCEMBF90';
        Hdrs{1,9}='BCEMBF100';
        Col1=BCEMBFTable.BCEMBF10;
        Col2=BCEMBFTable.BCEMBF25;
        Col3=BCEMBFTable.BCEMBF50;
        Col4=BCEMBBTable.BCEMBF75;
        Col5=BCEMBBTable.BCEMBF90;
        Col6=BCEMBBTable.BCEMBF100;
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
        T7=[Hdrs;myCellArray];
        tbl7=Table(T7);
        tbl7.Style = [tbl7.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl7.TableEntriesHAlign = 'center';
        tbl7.HAlign='center';
        tbl7.ColSep = 'single';
        tbl7.RowSep = 'single';
        r = row(tbl7,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt7 = BaseTable(tbl7);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On Biofuel Emissions For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt7.Title = tabletitle;
        bt7.TableWidth="8in";
        add(chapter,bt7);
        parastr701='The table above shows the distribution of the BCEMBFTable over the selected data range.';
        parastr702=' BCEMBF is the emissions due to biofuel combustion ';
        parastr703=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr704=' A diurnal cycle is generally observed for these emissions.';
        parastr705=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr709=strcat(parastr701,parastr702,parastr703,parastr704,parastr705);
        p709= Paragraph(parastr709);
        p709.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p709);
     elseif(ikind==8)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCHYPHILFTT.Properties.RowTimes);
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
        Hdrs{1,4}='BCHPH10';
        Hdrs{1,5}='BCHPH25';
        Hdrs{1,6}='BCHPH50';
        Hdrs{1,7}='BCHPH75';
        Hdrs{1,8}='BCHPH90';
        Hdrs{1,9}='BCHPH100';
        Col1=BCHYPHILFTable.BCHYPHIL10;
        Col2=BCHYPHILFTable.BCHYPHIL25;
        Col3=BCHYPHILFTable.BCHYPHIL50;
        Col4=BCHYPHILFTable.BCHYPHIL75;
        Col5=BCHYPHILFTable.BCHYPHIL90;
        Col6=BCHYPHILFTable.BCHYPHIL100;
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
        T8=[Hdrs;myCellArray];
        tbl8=Table(T8);
        tbl8.Style = [tbl8.Style {Border('solid','black','3px'),...
            NumberFormat("%5.3f")}];
        tbl8.TableEntriesHAlign = 'center';
        tbl8.HAlign='center';
        tbl8.ColSep = 'single';
        tbl8.RowSep = 'single';
        r = row(tbl8,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt8 = BaseTable(tbl8);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On BlackCarbon HPobic To HPhylic For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt8.Title = tabletitle;
        bt8.TableWidth="8in";
        add(chapter,bt8);
        parastr801='The table above shows the distribution of the BCHYPHILFTable over the selected data range.';
        parastr802=' BCHYPHILF is the black carbon transformation from hydrophobic to hydrophilic ';
        parastr803=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr804=' A diurnal cycle is generally observed for these emissions.';
        parastr805=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr809=strcat(parastr801,parastr802,parastr803,parastr804,parastr805);
        p809= Paragraph(parastr809);
        p809.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p809);
      elseif(ikind==11)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCSV001TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCSV00150';
        Hdrs{1,5}='BCSV00175';
        Hdrs{1,6}='BCSV00190';
        Hdrs{1,7}='BCSV00195';
        Hdrs{1,8}='BCSV00198';
        Hdrs{1,9}='BCSV001100';
        Col1=BCSV001Table.BCSV00150;
        Col2=BCSV001Table.BCSV00175;
        Col3=BCSV001Table.BCSV00190;
        Col4=BCSV001Table.BCSV00195;
        Col5=BCSV001Table.BCSV00198;
        Col6=BCSV001Table.BCSV001100;
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
        T9=[Hdrs;myCellArray];
        tbl9=Table(T9);
        tbl9.Style = [tbl9.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl9.TableEntriesHAlign = 'center';
        tbl9.HAlign='center';
        tbl9.ColSep = 'single';
        tbl9.RowSep = 'single';
        r = row(tbl9,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt9 = BaseTable(tbl9);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On BlackCarbon Scavenging Bin 001 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt9.Title = tabletitle;
        bt9.TableWidth="8in";
        add(chapter,bt9);
        parastr901='The table above shows the distribution of the BCSV001Table over the selected data range.';
        parastr902=' BCSV001Table is the black carbon convective scavenging in Bin01 ';
        parastr903=' This process removes some black particles from the atmosphere .';
        parastr904=' A diurnal cycle is generally observed for these emissions.';
        parastr905=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr909=strcat(parastr901,parastr902,parastr903,parastr904,parastr905);
        p909= Paragraph(parastr909);
        p909.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p909);
      elseif(ikind==12)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCSV002TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCSV00250';
        Hdrs{1,5}='BCSV00275';
        Hdrs{1,6}='BCSV00290';
        Hdrs{1,7}='BCSV00295';
        Hdrs{1,8}='BCSV00298';
        Hdrs{1,9}='BCSV002100';
        Col1=BCSV002Table.BCSV00250;
        Col2=BCSV002Table.BCSV00275;
        Col3=BCSV002Table.BCSV00290;
        Col4=BCSV002Table.BCSV00295;
        Col5=BCSV002Table.BCSV00298;
        Col6=BCSV002Table.BCSV002100;
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
        T9=[Hdrs;myCellArray];
        tbl9=Table(T9);
        tbl9.Style = [tbl9.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl9.TableEntriesHAlign = 'center';
        tbl9.HAlign='center';
        tbl9.ColSep = 'single';
        tbl9.RowSep = 'single';
        r = row(tbl9,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt9 = BaseTable(tbl9);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On BlackCarbon Scavenging Bin 002 For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt9.Title = tabletitle;
        bt9.TableWidth="8in";
        add(chapter,bt9);
        parastr901='The table above shows the distribution of the BCSV002Table over the selected data range.';
        parastr902=' BCSV002Table is the black carbon convective scavenging in Bin02 ';
        parastr903=' This process removes some black particles from the atmosphere .';
        parastr904=' A diurnal cycle is generally observed for these emissions.';
        parastr905=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr909=strcat(parastr901,parastr902,parastr903,parastr904,parastr905);
        p909= Paragraph(parastr909);
        p909.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p909);
     elseif(ikind==13)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCWT001TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCWT00150';
        Hdrs{1,5}='BCWT00175';
        Hdrs{1,6}='BCWT00190';
        Hdrs{1,7}='BCWT00195';
        Hdrs{1,8}='BCWT00198';
        Hdrs{1,9}='BCWT001100';
        Col1=BCWT001Table.BCWT00150;
        Col2=BCWT001Table.BCWT00175;
        Col3=BCWT001Table.BCWT00190;
        Col4=BCWT001Table.BCWT00195;
        Col5=BCWT001Table.BCWT00198;
        Col6=BCWT001Table.BCWT001100;
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
        T9=[Hdrs;myCellArray];
        tbl9=Table(T9);
        tbl9.Style = [tbl9.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl9.TableEntriesHAlign = 'center';
        tbl9.HAlign='center';
        tbl9.ColSep = 'single';
        tbl9.RowSep = 'single';
        r = row(tbl9,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt9 = BaseTable(tbl9);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On BlackCarbon Wet Deposition For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt9.Title = tabletitle;
        bt9.TableWidth="8in";
        add(chapter,bt9);
        parastr901='The table above shows the distribution of the BCWT001Table over the selected data range.';
        parastr902=' BCWT001Table is the black carbon wet deposition in Bin01 ';
        parastr903=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr904=' A diurnal cycle is generally observed for these emissions.';
        parastr905=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr909=strcat(parastr901,parastr902,parastr903,parastr904,parastr905);
        p909= Paragraph(parastr909);
        p909.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p909);
      elseif(ikind==14)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(BCWT002TT.Properties.RowTimes);
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
        Hdrs{1,4}='BCWT00250';
        Hdrs{1,5}='BCWT00275';
        Hdrs{1,6}='BCWT00290';
        Hdrs{1,7}='BCWT00295';
        Hdrs{1,8}='BCWT00298';
        Hdrs{1,9}='BCWT002100';
        Col1=BCWT002Table.BCWT00250;
        Col2=BCWT002Table.BCWT00275;
        Col3=BCWT002Table.BCWT00290;
        Col4=BCWT002Table.BCWT00295;
        Col5=BCWT002Table.BCWT00298;
        Col6=BCWT002Table.BCWT002100;
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
        T9=[Hdrs;myCellArray];
        tbl9=Table(T9);
        tbl9.Style = [tbl9.Style {Border('solid','black','3px'),...
            NumberFormat("%1.3e")}];
        tbl9.TableEntriesHAlign = 'center';
        tbl9.HAlign='center';
        tbl9.ColSep = 'single';
        tbl9.RowSep = 'single';
        r = row(tbl9,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt9 = BaseTable(tbl9);
        timeslicestr=char(TimeSlices{numtimeslice,1});
        tabletitlestr=strcat('Merra2 Hourly Data On BlackCarbon Wet Deposition For=',timeslicestr);
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt9.Title = tabletitle;
        bt9.TableWidth="8in";
        add(chapter,bt9);
        parastr901='The table above shows the distribution of the BCWT002Table over the selected data range.';
        parastr902=' BCWT002Table is the black carbon wet deposition in Bin02 ';
        parastr903=' Since these originate in fires these particulates tend to get distributed evenly in the planetary boundary layer .';
        parastr904=' A diurnal cycle is generally observed for these emissions.';
        parastr905=strcat(' The current table is for-',timeslicestr,'-hours');
        parastr909=strcat(parastr901,parastr902,parastr903,parastr904,parastr905);
        p909= Paragraph(parastr909);
        p909.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p909);

    end
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end
close('all')
end