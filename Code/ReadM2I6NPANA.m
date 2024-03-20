% This executive script has been created t0 read a single Merra 2 Product
% This product is M2I6NPANA. Another difference is that this data has
% already been decoded by running Case 7 as definied in the ReadMerra2Data
% script. After decoded a smaller subset of the data was stored as an
% ordinary Matlab file
% Created: Mar 17,2024
% Written By: Stephen Forczyk
% Revised: 

% Classification: Unclassified/Public Domain
%% Set Up Globals
global Datasets Merra2ShortFileName;
global LogoFileName1 LogoFileName2;
global BandDataS MetaDataS;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons COThighlimit;
global iSelectSet3;
global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevelUsed PressureLabels42 PressureLabels72 framecounter;
global TauCliMeansArray MeansTable MeansTimeTable;
global VariableTableBC VariableTableHdr;
global DataSetLinks TimeSlices iTimeSlice ;
global PascalsToMilliBars PascalsToPsi;

global DustROICountry MaskList MaskChoices  MaskFileName ;
global SeaMaskFileName SeaBoundaryFiles SeaMaskChoices numSelectedSeaMasks;
global SelectedSeaMaskData SelectedLandMaskData SortedSBF indexSBF;
global SelectedMaskData numSelectedMasks numUserSelectedSeaMasks;
global Merra2FileName Merra2FileNames MapFormFactor;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global Merra2WorkingMask6 Merra2WorkingMask7;
global Merra2WorkingMask8 Merra2WorkingMask9 Merra2WorkingMask10;
global TSStats iMonthForPDF TableFile TableFile2;
global Merra2WorkingSeaMask1 Merra2WorkingSeaMask2 Merra2WorkingSeaMask3;
global Merra2WorkingSeaMask4 Merra2WorkingSeaMask5;
global ROIName1 ROIName2 ROIName3 ROIName4 ROIName5;
global ROIName6 ROIName7 ROIName8 ROIName9 ROIName10;
global Dataset3Masks Dataset4Masks SelectedMaskIndices;
global Merra2WorkingSeaBoundary1Lat Merra2WorkingSeaBoundary1Lon Merra2WorkingSeaBoundary1Area;
global Merra2WorkingSeaBoundary2Lat Merra2WorkingSeaBoundary2Lon Merra2WorkingSeaBoundary2Area;
global Merra2WorkingSeaBoundary3Lat Merra2WorkingSeaBoundary3Lon Merra2WorkingSeaBoundary3Area;
global Merra2WorkingSeaBoundary4Lat Merra2WorkingSeaBoundary4Lon Merra2WorkingSeaBoundary4Area;
global Merra2WorkingSeaBoundary5Lat Merra2WorkingSeaBoundary5Lon Merra2WorkingSeaBoundary5Area;
global SeaSaltVarCorr;
global Dataset3TempChanges;
global NorthPoleFile NPolePOI AfricaTemps;

global Merra2DataPaths Merra2Path MerraDataCollectionTimes;
global CountyBoundaryFile;
global CountyBoundaries StateFIPSFile;
global StateFIPSCodes NationalCountiesShp;
global USAStatesShapeFileList USAStatesFileName GridFileName;
global UrbanAreasShapeFile NorthAmericaLakes ;
global idebug isavefiles icurvefit;
global iPrimeRoads iCountyRoads iCommonRoads iStateRecRoads iUSRoads iStateRoads;
global iLakes;
global NumProcFiles ProcFileList iPrintTimingInfo iSkipReportFrames iSkipDisplayFrames;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global JpegCounter JpegFileList;
global ImageProcessPresent ;
global iReport ifixedImagePaths;
global iSubMean iCheckConfig isaveJpeg;
global MovieFlags iCamLight;
global MonthDayStr MonthDayYearStr YearMonthStr YearMonthStrStart YearMonthStrEnd;
global WorldCityFileName World200TopCities;
global iCityPlot maxCities Merra2Cities Merra2WorldCities;
global PressureFileName ;
global SelectedFiles numSelectedFiles path1;
global iLogo LogoFileName1 LogoFileName2;
global iSeaOnly iLandOnly integrateRate;
global iPostProcessDataset3;
global YearMonthDayStr FirstYearMonthDayStr;
global numtimeslice iScale datestubstr;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie;
global vTemp4A vTemp4B TempMovieName4A TempMovieName4B;
global vTemp30 TempMovieName30;
global vTemp17 TempMovieName17;
global vTemp34 TempMovieName34;
global vTemp4 TempMovieName4;
global vTemp5 TempMovieName5;
global vTemp6 TempMovieName6;
global vTemp7 TempMovieName7;
global RCOEFF RCOEFFHist RCOEFFLabels;

global matpath datapath maskpath watermaskpath oceanmappath;
global antarcticpath antarcticshapefile;
global jpegpath tiffpath moviepath savepath geotiffpath;
global excelpath ascpath citypath tablepath tiffpath tiffpath2;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
global viewAZ viewEL viewAZInc;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;

global shapefilepath Countryshapepath figpath pressurepath averaged1Daypath;
global mappath gridpath countyshapepath nationalshapepath codepath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
global yd md dd;
global YearValue MonthValue DayValue HourValue MinValue SecValue frameDate;
global pwd;
global iFastSave iSelectSet4;
global vTemp30 TempMovieName30;

%% Set Up Fixed Paths
% Set up some fixed paths for the data. Set the present working directory
% to where the this code is located
pret=which('ReadMerra2Data.m');
[islash]=strfind(pret,'\');
numslash=length(islash);
is=1;
ie=islash(2);
pwd=pret(is:ie);
matlabpath='K:\Merra-2\Matlab_Data\';
datapath=' K:\Merra-2\netCDF\Dataset07\Matlab_Files\';
codepath='K:\Merra-2\Code5\Code\';
mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
maskpath='K:\Merra-2\Masks\';
watermaskpath='K:\Merra-2\Water_Masks\';
MaskFileName='Merra2ConsolidatedMaskList.mat';
SeaMaskFileName='Merra2ConsolidatedWaterMasks.mat';
citypath='D:\Forczyk\Map_Data\World_Cities\';
WorldCityFileName='WorldTopCitiesList.mat';
CalendarFileName='CalendarDays.mat';
PressureFileName='Merra2PressureData.mat';
GridFileName='Merra2Grids.mat';
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
jpegpath='D:\Goes16\Imagery\Aug26_2020\Jpeg_Files\';
pdfpath='K:\Merra-2\PDF_Reports\';
geotiffpath='K:\Merra-2\Geotiff_Files\';
%prefpath='D:\Goes16\Preference_Files\';
govjpegpath='K:\Merra-2\gov_jpeg\';
figpath='D:\Goes16\Imagery\Oct_FigFiles\';
logpath='H:\Goes16\Imagery\Oct22_2017\Log_Files\'; %This really needs to be set later!!!
tiffpath='D:\Forczyk\Map_Data\InterstateSigns\';
tiffpath2='D:\Merra-2\netCDF\Dataset04\Tiff_Files\';
Countryshapepath='D:\Forczyk\Map_Data\CountryShapefiles\';
gridpath='D:\Goes16\Grids\';
oceanmappath='K:\Merra-2\Matlab_Maps_Oceans\';
antarcticpath='K:\NSDIC\Map_Data\Antarctica\';
antarcticshapefile='yk702xd7587.shp';
NorthPoleFile='NorthPolePoints.mat';
%% Set Flags and default values
% Set some flags to control program execution
iCreatePDFReport=0;
iSkipReportFrames=2;
iSkipDisplayFrames=5;
JpegCounter=0;
isavefiles=0;
idebug=0;
icurvefit=1;
ifixedImagePaths=1;
iFastSave=1;
isaveJpeg=1; % Set to 0 to not save jpegs (not recommended),1=print to save (slow)
% 2= Quick save using screencapture (recommended)
iPrintTimingInfo=1;
iMovie=0;
MovieFlags=zeros(27,1);
MovieFlags(4,1)=1;
MovieFlags(5,1)=1;
MovieFlags(6,1)=1;
MovieFlags(7,1)=1;
iSubMean=1;
iCityPlot=1;
maxCities=30;
minTauValue=3;
COThighlimit=3;
framecounter=0;
iCheckConfig=1;
iLogo=1;
iPress42=24;
iPress72=1;
iSeaOnly=0;
iLandOnly=1;
iPostProcessDataset3=1;
PascalsToMilliBars=1/1000;
PascalsToPsi=14.696/101325;
iSelectSet3=3;
% Select a Time Slice
iTimeSlice=2;
LogoFileName1='Merra2-LogoB.jpg';
LogoFileName2='CDT_Logo6.jpg';
PressureLevelUsed=cell(5,4);
PressureLevelUsed{1,1}='Index';
PressureLevelUsed{1,2}='Model Pressure-hPa';
PressureLevelUsed{1,3}='Model Altitude-km';
PressureLevelUsed{1,4}='Surrogate hPA';
PressureLevelUsed{2,1}=43;
PressureLevelUsed{2,2}=208.15;
PressureLevelUsed{2,3}=11.53;
PressureLevelUsed{2,4}=200;
PressureLevelUsed{3,1}=45;
PressureLevelUsed{3,2}=288.08;
PressureLevelUsed{3,3}=9.43;
PressureLevelUsed{3,4}=300;
PressureLevelUsed{4,1}=48;
PressureLevelUsed{4,2}=412.15;
PressureLevelUsed{4,3}=6.96;
PressureLevelUsed{4,4}=400;
PressureLevelUsed{5,1}=50;
PressureLevelUsed{5,2}=487.50;
PressureLevelUsed{5,3}=5.76;
PressureLevelUsed{5,4}=500;
DataSetLinks=cell(10,1);



%% Set up some initial data
NumProcFiles=0;
ProcFileList=cell(1,4);
ProcFileList{1,1}='File Name';
ProcFileList{1,2}='Saved Directory';
ProcFileList{1,3}='Creation Time';
ProcFileList{1,4}='Save Method';
%% Set Up Log File
% Start writing a log file and Also look at the current stored image paths
% file
%eval(['cd ' logpath(1:length(logpath)-1)]);
startruntime=deblank(datestr(now));
startrunstr=strcat('Start Run Merra2 Run at-',startruntime);
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

% eval(['cd ' logpath(1:length(logpath)-1)]);
% logfilename=strcat(logfilename,'.txt');
%pdffilename=strcat('Merra2-',datetimestr);
fid=fopen(logfilename,'w');
dispstr=strcat('Opened New Log file-',logfilename,'-for writing');
disp(dispstr);
fprintf(fid,'%50s\n',startrunstr);
MapFormFactor=[];
iReport=zeros(5,1);


%% Check to see if the Matlab Report Generator and Image Toolbox is present
toolbox='MATLAB Report Generator';
[RptGenPresent] = ToolboxChecker(toolbox);
toolbox='Image Processing Toolbox';
[ImageProcessPresent]=ToolboxChecker(toolbox);
%% Start a PDF report if requested by user and user has the Matlab Report
% Generator Package Installed
% if((iCreatePDFReport==1) && (RptGenPresent==1))
%     import mlreportgen.dom.*;
%     import mlreportgen.report.*;
%     import mlreportgen.utils.*
%     CreateMerra2ReportHeader
% else
%     fprintf(fid,'%s\n','No PDF report will be created for this run');
% end
%% Read Some needed data files related to calendar data and selected shape file names as well as pressure levels
% Load in the Pressure data vs Level
eval(['cd ' pressurepath(1:length(pressurepath)-1)]);
load(PressureFileName);
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
brightblue=[.0039 .3961 .9882];
ab=1;
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
% Set up parameters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datestr(now);
igo=1;
NumProcFiles=0;
%% Set Up Log File-text based file to store critical data about run for analysis purposes
% Start writing a log file and Also look at the current stored image paths
% file
startruntime=deblank(datestr(now));
startrunstr=strcat('Start ReadMerra2Data Run at-',startruntime);
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

%% This is the main executive loop of the routine
while igo>0 % This setup up a loop to processing various file until user decides to STOP RUN

%% Get the Run Configuration Data
%         if(iCheckConfig==1)
%             SpecifyMatlabConfiguration('ReadMerra2Data.m');
%         end

% %% Start a PDF report if requested by user and user has the Matlab Report
% % Generator Package Installed
%     if((iCreatePDFReport==1) && (RptGenPresent==1))
%         import mlreportgen.dom.*;
%         import mlreportgen.report.*;
%         import mlreportgen.utils.*
%         CreateMerra2ReportHeaderRev1;
%     else
% %        fprintf(fid,'%s\n','No PDF report will be created for this run');
%     end


%% M2I6NPANA Select the data files to load
jpegpath='K:\Merra-2\netCDF\Dataset07\Jpeg_Files\';
pdfpath='K:\Merra-2\netCDF\Dataset07\PDF_Files\';
logpath='K:\Merra-2\netCDF\Dataset07\Log_Files\';
moviepath='k:\Merra-2\netCDF\Dataset07\Movies\';
savepath='K:\Merra-2\netCDF\Dataset07\Matlab_Files\';
tablepath='K:\Merra-2\netCDF\Dataset07\Tables\';
 % Select A Time slice for extra analysis and most plots
TimeSlices=cell(4,1);
TimeSlices{1,1}='0 HRS GMT';
TimeSlices{2,1}='6 HRS GMT';
TimeSlices{3,1}='12 HRS GMT';
TimeSlices{4,1}='18 HRS GMT';
iTimeSlice=1;
iPressLvL=24;
logfilename=strcat('Merra2LogFileIndx7-',logfilename,'.txt');
isavefiles=2;% Set to this value to save some partial run data
             % for quiver function test !
eval(['cd ' datapath(1:length(datapath)-1)]);
[Merra2FileNames,nowpath] = uigetfile('*.mat','Select Multiple Files', ...
'MultiSelect', 'on');
a1=isempty(Merra2FileNames);
if(a1==0)
    Merra2FileNames=Merra2FileNames';
    numSelectedFiles=length(Merra2FileNames);
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','----- List of Files to Be processed-----');
    for nn=1:numSelectedFiles
        nowFile=Merra2FileNames{nn,1};
        filestr='File Num';
        fprintf(fid,'%s\n',nowFile);
    end
    fprintf(fid,'%s\n','----- End List of Files to Be processed-----');
end

if(iFastSave==1)
    chart_time=3;
end
isavefiles=1;
firstFile=char(Merra2FileNames{1,1});
[idash]=strfind(firstFile,'-');
numdash=length(idash);
is=idash(6)+1;
ie=idash(7)-1;
YearMonthDayStr=firstFile(is:ie);
FirstYearMonthDayStr=YearMonthDayStr;
TempMovieName30=strcat('WindComponents',YearMonthDayStr,'-Fr-',num2str(numSelectedFiles));
eval(['cd ' moviepath(1:length(moviepath)-1)]);
vTemp30 = VideoWriter(TempMovieName30,'MPEG-4');
vTemp30.Quality=100;
vTemp30.FrameRate=3;
open(vTemp30);
framecounter=0;
tic
    for nn=1:numSelectedFiles
        nowFile=Merra2FileNames{nn,1}; 
        framecounter=framecounter+1;
        [idash]=strfind(nowFile,'-');
        numdash=length(idash);
        is=idash(6)+1;
        ie=idash(7)-1;
        YearMonthDayStr=nowFile(is:ie);
        is=1;
        ie=idash(7)-1;
        Merra2ShortFileName=nowFile(is:ie);
        titlestr=strcat('WindComponents For-',YearMonthDayStr);
        ProcessWindstressData(nowFile,titlestr);
        dispstr=strcat('Finished Processing File-',nowFile,'-which is file-',num2str(nn),...
            '-of-',num2str(numSelectedFiles),'-Files');
        disp(dispstr)
    end 
close(vTemp30);
igo=0; 
end


%% Run closeout
elapsed_time=toc;
runtimestr=strcat('Run took-',num2str(elapsed_time),'-seconds to run');
endruntime=deblank(datestr(now));
fprintf(fid,'%s\n',runtimestr);
endrunstr=strcat('Finished Merra 2 Analysis Run at-',endruntime);
fprintf(fid,'%s\n',endrunstr);
fclose(fid);
% Close a PDF report if one is created
a1=exist('rpt','var');
% profile off
% profile viewer
if((iCreatePDFReport==1) && (RptGenPresent==1))

    close(rpt);
    rptview(rpt)
    dispstr=strcat('Closed PDF Report-',pdffilename);
    disp(dispstr)
else
    disp('No pdf report generated by this run');
end
% Set current directory back to the code folder
eval(['cd ' codepath(1:length(codepath)-1)]);


ab=2;