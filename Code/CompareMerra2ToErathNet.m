% This script will read and process EarthData (Lightning Counts along with
% Merra2 COT Data)
% This script deals with the daily averaged output of the ErathNetwork
% lightning files to get Lightning Density and compares it to the COT data
% derived from the Merra2 project in order to see if there is a correlation
% between the two
%
% Written By: Stephen Forczyk
% Created: Mar 31,2023
% Revised: ----
% Classification: Pubic Domain

%% Set Up Globals
global SelectedFile EarthLightning EarthDataFileDate;
global SelectedMerraFiles SelectedErathFiles;
global numSelectedMerraFiles numSelectedErathFiles;
global Results StatsComparison;
global TauCli200hPA1Day TauCli300hPA1Day TauCli400hPA1Day;
global TauCli200hPA1Day30Deg TauCli300hPA1Day30Deg TauCli400hPA1Day30Deg;
global TauCli200hPA1Day55Deg TauCli300hPA1Day55Deg TauCli400hPA1Day55Deg;
global MerraLightningGridCounts55 MerraLightningGridCounts30;
global CorrelationTable CorrelationTT;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons COThighlimit;
global CountyBoundaryFile;
global CountyBoundaries StateFIPSFile;
global StateFIPSCodes NationalCountiesShp;
global USAStatesShapeFileList USAStatesFileName;
global UrbanAreasShapeFile NorthAmericaLakes FireSummaryFile;
global idebug isavefiles iDemFlag;
global iPrimeRoads iCountyRoads iCommonRoads iStateRecRoads iUSRoads iStateRoads;
global iLakes;
global NumProcFiles ProcFileList;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc;
global JpegCounter JpegFileList;
global ImageProcessPresent iGOES;
global iReport ifixedImagePaths;
global iSubMean iCheckConfig;
global MonthDayStr MonthDayYearStr;
global WorldCityFileName World200TopCities;
global iCityPlot maxCities;
global PressureFileName;
global numFlashes90 numFlashes55 numFlashes30 maxPixelCount;
global MerraLatGrid MerraLonGrid MerraLightningGridCounts;
global FlashCountsTable FlashCountsTT;
global SelectedFiles numSelectedFiles path1;
global westEdge eastEdge northEdge southEdge;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName;

global matpath datapath rawdatapath enhancedmatpath erathpath;
global jpegpath tiffpath moviepath savepath merra2path;
global excelpath ascpath citypath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath dtedpath;
global northamericalakespath logpath pdfpath govjpegpath;

global shapefilepath Countryshapepath figpath pressurepath averaged1Daypath;
global mappath gridpath countyshapepath nationalshapepath summarypath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
global baseimagepath selectedImageFolder prefpath;
global pwd;
%% Set Up Fixed Paths
% Set up some fixed paths for the data. Set the present working directory
% to where the this code is located
pret=which('ReadMerra2Data.m');
[islash]=strfind(pret,'\');
numslash=length(islash);
is=1;
ie=islash(2);
pwd=pret(is:ie);
%matlabpath=strcat(pwd,'Matlab_Data\');
matlabpath='D:\Goes16\Matlab_Data\';
mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
dtedpath='F:\DTED\';
citypath='D:\Forczyk\Map_Data\World_Cities\';
WorldCityFileName='WorldTopCitiesList.mat';
CalendarFileName='CalendarDays.mat';
PressureFileName='Merra2PressureData.mat';
pressurepath='K:\Merra-2\netCDF\Dataset09\Matlab_Files\';
shapefilepath='D:\Goes16\ShapeFiles\';
countyshapepath='D:\Forczyk\Map_Data\MAT_Files_Geographic\';
CountyBoundaryFile='CountyBoundingBoxes';
nationalshapepath='D:\Forczyk\Map_Data\NationalShapeFiles\';
NationalCountiesShp='cb_2018_us_county_500k.shp';
UrbanAreasShapeFile='cb_2018_us_ua10M_500k.shp';
USAStatesFileName='USAStatesShapeFileMapListRev4.mat';
USshapefilepath='D:\Forczyk\Map_Data\USStateShapeFiles\';
northamericalakespath='D:\Forczyk\Map_Data\Natural_Earth\Ten_Meter_Physical\';
NorthAmericaLakes='ne_10m_lakes_north_america.shp';
jpegpath='K:\Merra-2\netCDF\Dataset09\Jpeg_Corr\';
pdfpath='D:\Goes16\Imagery\Aug26_2020\PDF_Files\';
prefpath='D:\Goes16\Preference_Files\';
govjpegpath='D:\Goes16\Documents\Jpeg\';
figpath='D:\Goes16\Imagery\Oct_FigFiles\';
logpath='K:\ISS_LIS\Data\Data2021\EarthData\Log_Files\';
summarypath='D:\Goes16\Summary_Files\';
tiffpath='D:\Forczyk\Map_Data\InterstateSigns\';
FireSummaryFile='SummaryFileData.mat';
baseimagepath='F:\GOES16\Imagery\';
Countryshapepath='D:\Forczyk\Map_Data\CountryShapefiles\';
gridpath='D:\Goes16\Grids\';
averaged1Daypath='K:\Merra-2\netCDF\Dataset09\Matlab_Files1DayAvg\';
datapath='K:\ISS_LIS\Data\Data2021\EarthData\Mat_Files\';
rawdatapath='K:\ISS_LIS\Data\Data2021\EarthData\Raw_Data\';
merra2path='K:\Merra-2\netCDF\Dataset09\Enhanced_Matlab_Files\';
erathpath='K:\ISS_LIS\Data\Data2021\EarthData\Erath_Daily_Summaries\';
%% Set Flags and default values
% Set some flags to control program execution
iCreatePDFReport=0;
JpegCounter=0;
isavefiles=0;
idebug=0;
ifixedImagePaths=1;
iSubMean=1;
iCityPlot=1;
maxCities=30;
minTauValue=3;
westEdge=-180;
eastEdge=179.8;
northEdge=55;
southEdge=-55;
isavefiles=1;
iplotfiles=0;
numFlashes90=0;
numFlashes55=0;
numFlashes30=0;
% Set the row numbers for thr -55/+55 North south latitude in the Merra
% Grid
indx55s=71;
indx55n=291;
nlats55=indx55n-indx55s+1;
% Do the same for -30/+30
indx30s=121;
indx30n=241;
nlats30=indx30n-indx30s+1;
nlons30=576;
nlons55=nlons30;
TauCli200hPA1Day30Deg=zeros(nlons30,nlats30);
TauCli300hPA1Day30Deg=zeros(nlons30,nlats30);
TauCli400hPA1Day30Deg=zeros(nlons30,nlats30);
TauCli200hPA1Day55Deg=zeros(nlons55,nlats55);
TauCli300hPA1Day55Deg=zeros(nlons55,nlats55);
TauCli400hPA1Day55Deg=zeros(nlons55,nlats55);
MerraLightningGridCounts30=zeros(nlons30,nlats30);
MerraLightningGridCounts55=zeros(nlons55,nlats55);
%% Set Up the MerraLatGrid and MerraLon Grid
MerraLatGrid=-90:.5:90;
MerraLatGrid=MerraLatGrid';
MerraLonGrid=-180:.625:179.375;
MerraLonGrid=MerraLonGrid';
MerraLightningGridCounts=zeros(576,361);
Results=cell(1,1);
Results{1,1}='FileNum';
Results{1,2}='FileName';
Results{1,3}='NumFlashes90';
Results{1,4}='NumFlashes55';
Results{1,5}='NumFlashes30';
Results{1,6}='maxPixelCount';
Results{1,7}='Date';
Results{1,8}='Compare Merra Ligtning grid for Equality';
StatsComparison=cell(1,1);
StatsComparison{1,1}='Date';
StatsComparison{1,2}='ErathFileName';
StatsComparison{1,3}='Merra2FileName';
StatsComparison{1,4}='Corr @ 200hPA 90 Deg';
StatsComparison{1,5}='Corr @ 300hPA 90 Deg';
StatsComparison{1,6}='Corr @ 400hPA 90 Deg';
StatsComparison{1,7}='Corr @ 200hPA 55 Deg';
StatsComparison{1,8}='Corr @ 300hPA 55 Deg';
StatsComparison{1,9}='Corr @ 400hPA 55 Deg';
StatsComparison{1,10}='Corr @ 200hPA 30 Deg';
StatsComparison{1,11}='Corr @ 300hPA 30 Deg';
StatsComparison{1,12}='Corr @ 400hPA 30 Deg';
%% Set Up Log File
% Start writing a log file and Also look at the current stored image paths
% file
%eval(['cd ' logpath(1:length(logpath)-1)]);
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Run GOES 16 Run at-',startruntime);
logfilename=startruntime;
logfiledbl=double(logfilename);
% find the blank space in the date and replace it with a '-' to make a
% legalfilename
[iblank]=find(logfiledbl==32);
numblank=length(iblank);
for n=1:numblank
    is=iblank(n);
    ie=is;
    logfilename(is:ie)='-';
end
[icolon]=strfind(logfilename,':');
numcolon=length(icolon);
for n=1:numcolon
    is=icolon(n);
    ie=is;
    logfilename(is:ie)='-';
end
datetimestr=logfilename;
logfilename=strcat('EarthDataProcessing-',logfilename);
eval(['cd ' logpath(1:length(logpath)-1)]);
fid=fopen(logfilename,'w');
fprintf(fid,'%50s\n',startrunstr);
%% Read Some needed data files related to calendar data and selected shape file names as well as pressure levels
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
load(CalendarFileName);
load('StandardAtmosphere.mat');
% Load in the CountyBoundaryFiles
eval(['cd ' countyshapepath(1:length(countyshapepath)-1)]);
load('CountyBoundingBoxes.mat');
% Load in the list of USAStateShapeFiles
load(USAStatesFileName);
% Set up some colors that will be used in later plots
SetUpExtraColors()
% Load in the List of World Cities
eval(['cd ' citypath(1:length(citypath)-1)]);
load(WorldCityFileName);
SetUpExtraColors();
%% Call some routines that will create nice plot window sizes and locations
% Establish selected run parameters
imachine=2;
if(imachine==1)
    widd=720;
    lend=580;
    widd2=1000;
    lend2=700;
elseif(imachine==2)
    widd=1080;
    lend=812;
    widd2=1000;
    lend2=700;
elseif(imachine==3)
    widd=1296;
    lend=974;
    widd2=1200;
    lend2=840;
end
% Set a specific color order
set(0,'DefaultAxesColorOrder',[1 0 0;
    1 1 0;0 1 0;0 0 1;0.75 0.50 0.25;
    0.5 0.75 0.25; 0.25 1 0.25;0 .50 .75]);
% Set up some defaults for a PowerPoint presentationwhos
scaling='true';
stretching='false';
padding=[75 75 75 75];
igrid=1;
% Set up paramters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datestr(now);
igo=1;
NumProcFiles=0;
FlashCounts90Frame=zeros(n,1);
FlashCounts55Frame=zeros(n,1);
FlashCounts30Frame=zeros(n,1);
FlashFrameDate=zeros(n,1);

% Navigate to the location of the Erathdata and load many files
eval(['cd ' erathpath(1:length(erathpath)-1)]);
[SelectedErathFiles,path1]=uigetfile('*wgrids.mat','Select Many Erath Files',...
            'MultiSelect', 'on');
SelectedErathFiles=SelectedErathFiles';
numSelectedErathFiles=length(SelectedErathFiles);
% Now load the corresponding Merra2 Data
eval(['cd ' merra2path(1:length(merra2path)-1)]);
[SelectedMerraFiles,path2]=uigetfile('*.mat','Select Many Merra2-COT Files',...
            'MultiSelect', 'on');
SelectedMerraFiles=SelectedMerraFiles';
numSelectedMerraFiles=length(SelectedMerraFiles);
a1=isequal(numSelectedErathFiles,numSelectedMerraFiles);
if(a1~=1)
    dispstr=strcat('Help!-The Number of Erath Files is-',num2str(numSelectedErathFiles),'-while the number of Merra2 files=',...
        num2str(numSelectedMerraFiles));
    disp(dispstr)
else
    dispstr=strcat('Good to go-','the number of Selected Files of each type is=',num2str(numSelectedErathFiles));
    disp(dispstr);
end
numSelectedFiles=numSelectedMerraFiles;
Correlation200hPA90=zeros(numSelectedFiles,1);
Correlation300hPA90=zeros(numSelectedFiles,1);
Correlation400hPA90=zeros(numSelectedFiles,1);
Correlation200hPA55=zeros(numSelectedFiles,1);
Correlation300hPA55=zeros(numSelectedFiles,1);
Correlation400hPA55=zeros(numSelectedFiles,1);
Correlation200hPA30=zeros(numSelectedFiles,1);
Correlation300hPA30=zeros(numSelectedFiles,1);
Correlation400hPA30=zeros(numSelectedFiles,1);
for n=1:numSelectedFiles
    nowErathFile=SelectedErathFiles{n,1};
    nowMerraFile=SelectedMerraFiles{n,1};
% load the ErathFile 
    eval(['cd ' erathpath(1:length(erathpath)-1)]);
    load(nowErathFile);
    dispstr=strcat('Loaded Erath File-',nowErathFile);
    disp(dispstr)
% load the MerraFile 
    eval(['cd ' merra2path(1:length(merra2path)-1)]);
    load(nowMerraFile);
    dispstr=strcat('Loaded Merra2 COT File-',nowMerraFile);
    disp(dispstr)
    ab=1;
% Now calculate the correlation for the 200 hPA,300 hPA and 400 hPA data
% for the full earth or 90 deg
    Corr200hPA=corr2(TauCli200hPA1Day',MerraLightningGridCounts');
    Corr300hPA=corr2(TauCli300hPA1Day',MerraLightningGridCounts');
    Corr400hPA=corr2(TauCli400hPA1Day',MerraLightningGridCounts');
    Correlation200hPA90(n,1)=Corr200hPA;
    Correlation300hPA90(n,1)=Corr300hPA;
    Correlation400hPA90(n,1)=Corr400hPA;
% Set up 4 arrays to just hold the +/-55 Deg data
[nrows,ncols]=size(TauCli200hPA1Day);
    for ii=1:nrows
        for jj=1:nlats55
           nx=ii;
           ny=jj+indx55s-1;
           TauCli200hPA1Day55Deg(ii,jj)=TauCli200hPA1Day(nx,ny);
           TauCli300hPA1Day55Deg(ii,jj)=TauCli300hPA1Day(nx,ny);
           TauCli400hPA1Day55Deg(ii,jj)=TauCli400hPA1Day(nx,ny);
           MerraLightningGridCounts55(ii,jj)=MerraLightningGridCounts(nx,ny);
        end
    end
% Now calculate the correlation for the 200 hPA,300 hPA and 400 hPA data
% for the full earth or 55 deg
    Corr200hPA55=corr2(TauCli200hPA1Day55Deg',MerraLightningGridCounts55');
    Corr300hPA55=corr2(TauCli300hPA1Day55Deg',MerraLightningGridCounts55');
    Corr400hPA55=corr2(TauCli400hPA1Day55Deg',MerraLightningGridCounts55');
    Correlation200hPA55(n,1)=Corr200hPA55;
    Correlation300hPA55(n,1)=Corr300hPA55;
    Correlation400hPA55(n,1)=Corr400hPA55;
% Set up 4 arrays to just hold the +/-30 Deg data
    for ii=1:nrows
        for jj=1:nlats30
           nx=ii;
           ny=jj+indx30s-1;
           TauCli200hPA1Day30Deg(ii,jj)=TauCli200hPA1Day(nx,ny);
           TauCli300hPA1Day30Deg(ii,jj)=TauCli300hPA1Day(nx,ny);
           TauCli400hPA1Day30Deg(ii,jj)=TauCli400hPA1Day(nx,ny);
           MerraLightningGridCounts30(ii,jj)=MerraLightningGridCounts(nx,ny);
        end
    end
% Now compute the the correlation at 30 Deg
% for the full earth or 55 deg
    Corr200hPA30=corr2(TauCli200hPA1Day30Deg',MerraLightningGridCounts30');
    Corr300hPA30=corr2(TauCli300hPA1Day30Deg',MerraLightningGridCounts30');
    Corr400hPA30=corr2(TauCli400hPA1Day30Deg',MerraLightningGridCounts30');
    Correlation200hPA30(n,1)=Corr200hPA30;
    Correlation300hPA30(n,1)=Corr300hPA30;
    Correlation400hPA30(n,1)=Corr400hPA30;
    StatsComparison{1+n,1}='Jul01';
    StatsComparison{1+n,2}=nowErathFile;
    StatsComparison{1+n,3}=nowMerraFile;
    StatsComparison{1+n,4}=Corr200hPA;
    StatsComparison{1+n,5}=Corr300hPA;
    StatsComparison{1+n,6}=Corr400hPA;
    StatsComparison{1+n,7}=Corr200hPA55;
    StatsComparison{1+n,8}=Corr300hPA55;
    StatsComparison{1+n,9}=Corr400hPA55;
    StatsComparison{1+n,10}=Corr200hPA30;
    StatsComparison{1+n,11}=Corr300hPA30;
    StatsComparison{1+n,12}=Corr400hPA30;
    ab=2;

  

end

%     end
 % Write a set of Tables and Time Tables
    if(n==numSelectedFiles)
        stime=datetime(2019,9,1);
        timestep=caldays(1);
        CorrelationTable=table(Correlation200hPA90(:,1),Correlation300hPA90(:,1),Correlation400hPA90(:,1),...
            Correlation200hPA55(:,1),Correlation300hPA55(:,1),Correlation400hPA55(:,1),...
            Correlation200hPA30(:,1),Correlation300hPA30(:,1),Correlation400hPA30(:,1),...
            'VariableNames',{'Corr200hPA90Deg','Corr300hPA90Deg','Corr400hPA90Deg',...
            'Corr200hPA55Deg','Corr300hPA55Deg','Corr400hPA55Deg',...
            'Corr200hPA30Deg','Corr300hPA30Deg','Corr400hPA30Deg'});
        CorrelationTT = table2timetable(CorrelationTable,'TimeStep',timestep,'StartTime',stime);
        eval(['cd ' merra2path(1:length(merra2path)-1)]);
        save Sep2019CrossCorrData CorrelationTable CorrelationTT
    end
% Plot the data for the Full Earth
itype=1;
titlestr='Correlation Of COT TO Lightning Density-Full Earth-Sep 2019';
figstr='Jul2019-FullEarth-LightingVsCOT';
PlotLightningDensityVsCOTCorelation(itype,titlestr,figstr)
itype=2;
titlestr='Correlation Of COT TO Lightning Density-To 55 Deg Lat-Sep 2019';
figstr='Jul2019-55DegLat-LightingVsCOT';
PlotLightningDensityVsCOTCorelation(itype,titlestr,figstr)
itype=3;
titlestr='Correlation Of COT TO Lightning Density-To 30 Deg Lat-Sep 2019';
figstr='Jul2019-30DegLat-LightingVsCOT';
PlotLightningDensityVsCOTCorelation(itype,titlestr,figstr)
ab=1;
% Now Plot this table
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
plot(CorrelationTT.Time,CorrelationTT.Corr200hPA90Deg,'r',CorrelationTT.Time,CorrelationTT.Corr300hPA90Deg,'g',...
    CorrelationTT.Time,CorrelationTT.Corr400hPA90Deg,'b');
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
hl=legend('COT at 200 hPA','COT and 300 hPA','COT and 400 hPA');
titlestr='Correlation Of Erath Lightning to COT Full Earth';
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
ylabelstr='CAPE-J/Kg';
ylabel('Correlation-COT Vs Flash Desnity','FontWeight','bold','FontSize',12);
figstr='FullEarthCorrelation-Sep2019.jpg';
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
ab=1;
close('all')
if(iplotfiles==1)
% Now plot this data on a map-use 90 degree sectors
% This is sector 1
% Navigate to the location of the data and load one file
    eval(['cd ' datapath(1:length(datapath)-1)]);
    [SelectedFile,path1]=uigetfile('*.mat','Select ONE Data File',...
                'MultiSelect', 'off');
    % Now load this file in
    load(SelectedFile);
    dispstr=strcat('Loaded EarthDataFile-',SelectedFile);
    disp(dispstr)
    itype=3;
    westEdge=-90;
    eastEdge=0;
    filenamelen=length(SelectedFile);
    ShortFileName=SelectedFile(1:filenamelen-4);
    titlestr=strcat('Sector1-EarthMap-',ShortFileName,'.jpg');
    DisplayEarthLightning(itype,titlestr)
    % This is sector 2
    itype=3;
    westEdge=0;
    eastEdge=90;
    filenamelen=length(SelectedFile);
    ShortFileName=SelectedFile(1:filenamelen-4);
    titlestr=strcat('Sector2-EarthMap-',ShortFileName,'.jpg');
    DisplayEarthLightning(itype,titlestr)
    % This is sector 3
    itype=3;
    westEdge=90;
    eastEdge=180;
    filenamelen=length(SelectedFile);
    ShortFileName=SelectedFile(1:filenamelen-4);
    titlestr=strcat('Sector3-EarthMap-',ShortFileName,'.jpg');
    DisplayEarthLightning(itype,titlestr)
    % This is sector 4
    itype=3;
    westEdge=-180;
    eastEdge=-90;
    filenamelen=length(SelectedFile);
    ShortFileName=SelectedFile(1:filenamelen-4);
    titlestr=strcat('Sector4-EarthMap-',ShortFileName,'.jpg');
    DisplayEarthLightning(itype,titlestr)
end

endruntime=deblank(datestr(now));
endrunstr=strcat('Finished Merra 2 Analysis Run at-',endruntime);

fprintf(fid,'%s\n',endrunstr);
fclose(fid);