function  DisplayMerra2DatasetWindStress(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% This routine will display one frame of data for the US and VS
% wind components. US is in the east direction and VS in the north
% direction.
% Note the windstress function by Chad Green was for windcomponents 
% 10 meters above the ocean floor. This data is not available in Dataset as
% the lowest level in this dataset is at about 100 meters. The windstress
% will be calculated as if it were at 10 meters but the US and VS data will
% be collected from the user specified atmosphere level. Therefore the
% chart should be used for illustrative purposes only!

% Written By: Stephen Forczyk
% Based On: Windstress function by Chad Greene
% Created: Nov 8,2023
% Revised: Nov 26,2023 added borders to map
% Revised: Nov 27,2023 added code to activate PDF file chapter
% Revised: Nov 28.2023 added iSeaOny and iLandOnly flags to restrict
% processing to sea areas only(==1) or land only(==1)


% Classification: Unclassified
global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevelUsed PressureLabels42 PressureLabels72 framecounter;
global TimeSlices iTimeSlice numtimeslice;
global Merra2FileName Merra2Dat Merra2ShortFileName numSelectedFiles;

global idebug;
global LatitudesS LongitudesS LevS;
global O3S PSS QVS HS QV2MS SLPS TS T2MS;
global timeS US VS;
global HS01 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S01 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;
global PSS01 PSS25 PSS50 PSS75 PSS90 PSS100 PSSLow PSSHigh PSSNaN;
global QVS01 QVS25 QVS50 QVS75 QVS90 QVS100 QVSLow QVSHigh QVSNaN;
global SLPS01 SLPS25 SLPS50 SLPS75 SLPS90 SLPS100 SLPSLow SLPSHigh SLPSNaN;
global TS01 TS25 TS50 TS75 TS90 TS100 TSLow TSHigh TSNaN;
global US01 US25 US50 US75 US90 US100 USLow USHigh USNaN;
global VS01 VS25 VS50 VS75 VS90 VS100 VSLow VSHigh VSNaN;
global HSValues O3SValues PSSValues QVSValues SLPSValues TSValues;
global USValues VSValues;
global timeS US VS;
global LatitudesS LongitudesS RasterLats RasterLons;
global YearMonthDayStr1 YearMonthDayStr2;
global ChoiceList;
global PascalsToMilliBars PascalsToPsi;
global PSTable PSTT;

global SLPTable SLPTT;


global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;
global yd md dd;
global iCityPlot;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iSeaOnly iLandOnly;


global LatitudesS LongitudesS ;
global numSelectedFiles;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global Merra2WorkingSeaMask1 Merra2WorkingSeaMask2 Merra2WorkingSeaMask3;
global Merra2WorkingSeaMask4 Merra2WorkingSeaMask5;
global ROIName1 ROIName2 ROIName3 ROIName4 ROIName5;
global ROIName6 ROIName7 ROIName8 ROIName9 ROIName10;
global Merra2WorkingSeaBoundary1Lat Merra2WorkingSeaBoundary1Lon Merra2WorkingSeaBoundary1Area;
global Merra2WorkingSeaBoundary2Lat Merra2WorkingSeaBoundary2Lon Merra2WorkingSeaBoundary2Area;
global Merra2WorkingSeaBoundary3Lat Merra2WorkingSeaBoundary3Lon Merra2WorkingSeaBoundary3Area;
global Merra2WorkingSeaBoundary4Lat Merra2WorkingSeaBoundary4Lon Merra2WorkingSeaBoundary4Area;
global Merra2WorkingSeaBoundary5Lat Merra2WorkingSeaBoundary5Lon Merra2WorkingSeaBoundary5Area;
global SeaMaskFileName SeaBoundaryFiles SeaMaskChoices numSelectedSeaMasks;
global SelectedSeaMaskData SortedSBF indexSBF;
global SelectedMaskData numSelectedMasks numUserSelectedSeaMasks;
global heightkm;

global numtimeslice TimeSlices;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global numlat numlon Rpix latlim lonlim rasterSize;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
global yd md dd;



global westEdge eastEdge southEdge northEdge;
global vTemp TempMovieName iMovie;
global vTemp4 TempMovieName4 MovieFlags;
global vTemp5 TempMovieName5;
global vTemp6 TempMovieName6;
global vTemp7 TempMovieName7;
global vTemp17 TempMovieName17;
global vTemp34 TempmovieName34;
global vTemp4 TempMovieName4 MovieFlags;
global iLogo LogoFileName1 LogoFileName2 isaveJpeg iSkipReportFrames


global idebug iCityPlot World200TopCities maxCities ;
global DayStr YearMonthDayStr FullTimeStr;
global NumProcFiles ProcFileList iSeaSalt;

% additional paths needed for mapping
global matpath1 maskpath;
global fid isavefiles;

% additional paths needed for mapping
global matpath1 mappath ;
global savepath jpegpath pdfpath logpath moviepath tablepath;
global YearMonthStr MonthStr YearStr MonthYearStr;

global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath ;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
% additional paths needed for mapping
global gridpath;
global matpath1 mappath;
global canadapath stateshapepath topopath;
global trajpath militarypath;
global figpath screencapturepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;
global govjpegpath;

 
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*
end


% monthnum=str2double(MonthStr);
% [MonthName] = ConvertMonthNumToStr(monthnum);
if(iTimeSlice==1)
    TimeStr='-00-Hrs-GMT';
elseif(iTimeSlice==2)
    TimeStr='-06-Hrs-GMT';
elseif(iTimeSlice==3)
    TimeStr='-12-Hrs-GMT';
elseif(iTimeSlice==4)
    TimeStr='-18-Hrs-GMT';
end
% Calculate the windsress using the 100 meter height data
U10=US.values(:,:,1,iTimeSlice);
V10=VS.values(:,:,1,iTimeSlice);
heightkm=PressureLevel42(1,3);
fillvalue=US.FillValue;
U10(U10==fillvalue)=NaN;
V10(V10==fillvalue)=NaN;

desc='Geopotential Height';
units='Pa';
titlestr=strcat('WindStress-',Merra2ShortFileName,'-Heightkm=',num2str(heightkm),TimeStr);
descstr=strcat('Average Monthly Value follows for-',titlestr);
[Taux,Tauy] = windstress(U10,V10,'Density',90);
parastr4a='All Areas Included In Plot';
if(iSeaOnly==1)
    land=island(RasterLats,RasterLons);
    Taux(land)=NaN;
    Tauy(land)=NaN;
    parastr4a='Plot only includes sea areas';
end
tf=isnan(Taux);
numNaN=sum(sum(tf));
[nrows,ncols]=size(Taux);
numvals=nrows*ncols;
fracNaN=numNaN/numvals;
parastr4=strcat(parastr4a,'-NaN Fraction=',num2str(fracNaN,4));
movie_figure1=figure('position',[hor1 vert1 widd lend-70]);
set(gcf,'MenuBar','none');
set(gca,'XLim',[-200 200],'YLim',[-90 90]);
borders
hold on
quiversc(RasterLons,RasterLats,Taux,Tauy,'b');
titlestr=strcat('Windstress-',Merra2ShortFileName,TimeStr);
title(titlestr)
xlabel('Longitude','FontWeight','bold','FontSize',12);
ylabel('Longitude','FontWeight','bold','FontSize',12);
hold off

% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.08, .1,.04,]);
    [x, ~]=imread(LogoFileName1);    
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.08;
ty1=.06;
txtstr1=strcat('Date-',MonthYearStr,'-Press Level-km=',num2str(heightkm),'-Time=',TimeStr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
tx2=.08;
ty2=.03;
txtstr2=parastr4;
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
set(newaxesh,'Visible','Off');
%% Save this graphic a a jpeg file
tic;
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
figstr=strcat('WindStress','-',FullTimeStr,'-iPress42-',num2str(iPress42),TimeStr,'.jpg');
if(isaveJpeg==1)
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr);
    eval(cmdString);
    div=2.5;
    endstr=strcat('------- Finished Plotting-',varname);
    fprintf(fid,'%s\n',endstr);
    capture='print';
elseif(isaveJpeg==2)
    screencapture(gcf,[],figstr)
    div=1.6;
    capture='screengrab';
else % Not saved (do not use is PDF report is being created)


end

pause(chart_time);
elapsed_time=toc;
NumProcFiles=NumProcFiles+1;
ProcFileList{1+NumProcFiles,1}=figstr;
ProcFileList{1+NumProcFiles,2}=jpegpath;
ProcFileList{1+NumProcFiles,3}=elapsed_time;
ProcFileList{1+NumProcFiles,4}=capture;
close('all');

rem=mod(framecounter-1,iSkipReportFrames);
if((iCreatePDFReport>0) && (RptGenPresent==1)  && (iAddToReport==1) && (rem==0))
    if(iNewChapter)
        if(ikind==9)
            headingstr1=strcat('Analysis Results Windstress-',Merra2ShortFileName); 
        else
             headingstr1=strcat('Analysis Results For Other Aerosols-',Merra2ShortFileName);
        end
        chapter = Chapter("Title",headingstr1);
    end
    sectionstr=strcat(varname,'-Map');
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(varname,' For File-',Merra2ShortFileName);
    pdftext = Text(pdftxtstr);
    pdftext.Color = 'red';
    image.Caption = pdftext;
    nhighs=floor(nhigh/div);
    nwids=floor(nwid/div);
    heightstr=strcat(num2str(nhighs),'px');
    widthstr=strcat(num2str(nwids),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
% Now add some text -start by describing the with a basic description of the
% variable being plotted
    parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
    parastr2=strcat(' This metric is an monthly average for-',varname,'-at time slice-',TimeStr);
    if(ikind==9)
        parastr3='The expect data range is +/- 30 Pa.';
    else
        parastr3='unspecified';
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
end
end

