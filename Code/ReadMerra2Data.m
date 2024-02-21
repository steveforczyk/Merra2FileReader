% This executive script is to read a wide range of Merra-2 Data products
% Created: Aug 1,2022
% Written By: Stephen Forczyk
% Revised: Aug 7,2022 to plot entire world using a georeferencing object
%          and to plot country borders using plot3m
% Revised: Mar-Apr 2023 extensive changes made to add capabilities to
% process different types of Merra2 data
% Revised: Sep 17,2023 deactived CreateMerra2Aerosol Diagnostic Report
%          due to errors added dialog to load pre calculated Political 
% Revised: Sept 19,2023 problems with CreateMerra2Aerosol Diagnostic Report
% Revised: Oct 10,2023 Brought under Git Control Using Remote Repo
% Revised: Oct 10,2023 Add Sea Mask Files
% Revised: Oct 27-Oct 30 added ReadDatatset03 code
% fixed
% Revised: Jan 2024 added routine to compute avergage changes in Air Temp
% and specific humidity across the 1980 thru 2023 period
% Revised: Jan 17,2024 made a few revisions to run code on new PC
% Revised: Jan 24,2024 started adding code to process Dataset04
% Classification: Unclassified/Public Domain
%% Set Up Globals
global Datasets;
global BandDataS MetaDataS;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons COThighlimit;
global iSelectSet3;
global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevelUsed PressureLabels42 PressureLabels72 framecounter;
global TauCliMeansArray MeansTable MeansTimeTable;
global VariableTableBC VariableTableHdr;
global DataSetLinks TimeSlices iTimeSlice;
global PascalsToMilliBars PascalsToPsi;
global DustSizeGroups BlackCarbonSizeGroups SeaSaltSizeGroups;
global DustROICountry MaskList MaskChoices  MaskFileName ;
global SeaMaskFileName SeaBoundaryFiles SeaMaskChoices numSelectedSeaMasks;
global SelectedSeaMaskData SortedSBF indexSBF;
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
global Dataset3Masks;
global Merra2WorkingSeaBoundary1Lat Merra2WorkingSeaBoundary1Lon Merra2WorkingSeaBoundary1Area;
global Merra2WorkingSeaBoundary2Lat Merra2WorkingSeaBoundary2Lon Merra2WorkingSeaBoundary2Area;
global Merra2WorkingSeaBoundary3Lat Merra2WorkingSeaBoundary3Lon Merra2WorkingSeaBoundary3Area;
global Merra2WorkingSeaBoundary4Lat Merra2WorkingSeaBoundary4Lon Merra2WorkingSeaBoundary4Area;
global Merra2WorkingSeaBoundary5Lat Merra2WorkingSeaBoundary5Lon Merra2WorkingSeaBoundary5Area;
global SeaSaltVarCorr;
global Dataset3TempChanges;

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
global MovieFlags;
global MonthDayStr MonthDayYearStr YearMonthStr YearMonthStrStart YearMonthStrEnd;
global WorldCityFileName World200TopCities;
global iCityPlot maxCities;
global PressureFileName ;
global SelectedFiles numSelectedFiles path1;
global iLogo LogoFileName1 LogoFileName2;
global iSeaOnly iLandOnly integrateRate;
global iPostProcessDataset3;
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
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath;
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
global HS10 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S10 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;
global brightblue;
%% Control Flags DataSet 2
global iBlackCarbon iDust iOrganicCarbon iSeaSalt iSulfate iAllAerosols;
global iSeaSaltCalc iDustCalc;

clc;
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
%prefpath='D:\Goes16\Preference_Files\';
govjpegpath='K:\Merra-2\gov_jpeg\';
figpath='D:\Goes16\Imagery\Oct_FigFiles\';
logpath='H:\Goes16\Imagery\Oct22_2017\Log_Files\'; %This really needs to be set later!!!
tiffpath='D:\Forczyk\Map_Data\InterstateSigns\';
Countryshapepath='D:\Forczyk\Map_Data\CountryShapefiles\';
gridpath='D:\Goes16\Grids\';
oceanmappath='K:\Merra-2\Matlab_Maps_Oceans\';
antarcticpath='K:\NSDIC\Map_Data\Antarctica\';
antarcticshapefile='yk702xd7587.shp';
%% Set Flags and default values
% Set some flags to control program execution
iCreatePDFReport=0;
iSkipReportFrames=2;
iSkipDisplayFrames=2;
JpegCounter=0;
isavefiles=0;
idebug=0;
icurvefit=1;
ifixedImagePaths=1;
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
iPress42=1;
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
LogoFileName2='CDT_Logo4.jpg';
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
DataSetLinks{1,1}='Designator';
DataSetLinks{1,2}='Hyperlink';
DataSetLinks{1,3}='DataSet Num';
DataSetLinks{1,4}='Data Frequency';
DataSetLinks{1,5}='DOI';
DataSetLinks{2,1}='M2IUNXASM_5.12.4';
DataSetLinks{2,2}='';
DataSetLinks{2,3}='1';
DataSetLinks{2,4}='Monthly Diurnal Mean';
DataSetLinks{2,5}='10.5067/BOJSTZAO2L8R';
DataSetLinks{3,1}='M2T1NXADG_5.12.4 ';
DataSetLinks{3,2}='';
DataSetLinks{3,3}='2';
DataSetLinks{3,4}='Hourly,Time-averaged';
DataSetLinks{3,5}='10.5067/HM00OHQBHKTP';
DataSetLinks{4,1}='M2T1NXOCN_5.12.4 ';
DataSetLinks{4,2}='';
DataSetLinks{4,3}='4';
DataSetLinks{4,4}='Hourly-Time Averaged';
DatasetLinks{4,5}='10.5067/Y67YQ1L3ZZ4R';
DataSetLinks{5,1}=' ';
DataSetLinks{5,2}='';
DataSetLinks{5,3}='4';
DataSetLinks{5,4}='';
DataSetLinks{6,1}=' ';
DataSetLinks{6,2}='';
DataSetLinks{6,3}='5';
DataSetLinks{6,4}='';
DataSetLinks{7,1}=' ';
DataSetLinks{7,2}='';
DataSetLinks{7,3}='6';
DataSetLinks{7,4}='';
DataSetLinks{8,1}=' ';
DataSetLinks{8,2}='';
DataSetLinks{8,3}='7';
DataSetLinks{8,4}='';
DataSetLinks{9,1}='M2TMNXRAD_5.12.4';
DataSetLinks{9,2}='https://disc.gsfc.nasa.gov/datasets/M2TMNXRAD_5.12.4/summary?keywords=M2TMNXRAD_5.12.4';
DataSetLinks{9,3}='8';
DataSetLinks{9,4}='Monthly Mean';
DataSetLinks{9,5}='10.5067/OU3HJDS973O0';
DataSetLinks{10,1}=' ';
DataSetLinks{10,2}='';
DataSetLinks{10,3}='9';
DataSetLinks{10,4}='';
RCOEFFLabels=cell(5,1);
RCOEFFLabels{1,1}='Albedo';
RCOEFFLabels{2,1}='CLDHGH';
RCOEFFLabels{3,1}='EMIS';
RCOEFFLabels{4,1}='LWGAB';
RCOEFFLabels{5,1}='LWGEM';
RCOEFFLabels{6,1}='SWGDN';
RCOEFFLabels{7,1}='TAUHGH';
RCOEFFLabels{8,1}='TS';
DustSizeGroups=zeros(8,2);% units are microns
DustSizeGroups(1,1)=0.1;
DustSizeGroups(1,2)=0.18;
DustSizeGroups(2,1)=0.18;
DustSizeGroups(2,2)=0.30;
DustSizeGroups(3,1)=0.30;
DustSizeGroups(3,2)=0.60;
DustSizeGroups(4,1)=0.60;
DustSizeGroups(4,2)=1.00;
DustSizeGroups(5,1)=1.00;
DustSizeGroups(5,2)=1.80;
DustSizeGroups(6,1)=1.80;
DustSizeGroups(6,2)=3.00;
DustSizeGroups(7,1)=3.00;
DustSizeGroups(7,2)=6.00;
DustSizeGroups(8,1)=6.00;
DustSizeGroups(8,2)=10.00;
SeaSaltSizeGroups=zeros(5,2);% units are in microns
SeaSaltSizeGroups(1,1)=0.03;
SeaSaltSizeGroups(1,2)=0.1;
SeaSaltSizeGroups(2,1)=0.1;
SeaSaltSizeGroups(2,2)=0.5;
SeaSaltSizeGroups(3,1)=0.5;
SeaSaltSizeGroups(3,2)=1.5;
SeaSaltSizeGroups(4,1)=1.5;
SeaSaltSizeGroups(4,2)=5.0;
SeaSaltSizeGroups(5,1)=5.0;
SeaSaltSizeGroups(5,2)=10.0;
MaskList=cell(13,3);
MaskList{1,1}='AfricaMask.mat';
MaskList{1,2}='Merra2AfricaMask';
MaskList{1,3}='Africa';
MaskList{2,1}='AlgeriaMask.mat';
MaskList{2,2}='Merra2AlgeriaMask';
MaskList{2,3}='Algeria';
MaskList{3,1}='AsiaMask.mat';
MaskList{3,2}='Merra2AsiaMask';
MaskList{3,3}='Asia';
MaskList{4,1}='AustraliaMask.mat';
MaskList{4,2}='Merra2AustraliaMask';
MaskList{4,3}='Australia';
MaskList{5,1}='ChinaMask.mat';
MaskList{5,2}='Merra2ChinaMask';
MaskList{5,3}='China';
MaskList{6,1}='EuropeMask.mat';
MaskList{6,2}='Merra2EuropeMask';
MaskList{6,3}='Europe';
MaskList{7,1}='IndiaMask.mat';
MaskList{7,2}='Merra2IndiaMask';
MaskList{7,3}='India';
MaskList{8,1}='MauritaniaMask.mat';
MaskList{8,2}='Merra2MauritaniaMask';
MaskList{8,3}='Mauritania';
MaskList{9,1}='MoroccoMask.mat';
MaskList{9,2}='Merra2MoroccoMask';
MaskList{9,3}='Morocco';
MaskList{10,1}='NigeriaMask.mat';
MaskList{10,2}='Merra2NigeriaMask';
MaskList{10,3}='Nigeria';
MaskList{11,1}='NorthAmericaMask.mat';
MaskList{11,2}='Merra2NorthAmericaMask';
MaskList{11,3}='NorthAmerica';
MaskList{12,1}='SouthAmericaMask.mat';
MaskList{12,2}='Merra2SouthAmericaMask';
MaskList{12,3}='SouthAmerica';
MaskList{13,1}='USAMask.mat';
MaskList{13,2}='Merra2USAMask';
MaskList{13,3}='USA';
MaskList{14,1}='MauritaniaMask.mat';
MaskList{14,2}='Merra2MauritaniaMask';
MaskList{14,3}='Mauritania';
MaskList{15,1}='SudanMask.mat';
MaskList{15,2}='Merra2SudanMask';
MaskList{15,3}='Sudan';
MaskList{16,1}='ChadMask.mat';
MaskList{16,2}='Merra2ChadMask';
MaskList{16,3}='Chad';
MaskList{17,1}='NigerMask.mat';
MaskList{17,2}='Merra2CNigerMask';
MaskList{17,3}='Niger';
MaskList{18,1}='CameroonMask.mat';
MaskList{18,2}='Merra2CameroonMask';
MaskList{18,3}='Cameroon';
MaskList{19,1}='EgyptMask.mat';
MaskList{19,2}='Merra2EgyptMask';
MaskList{19,3}='Egypt';
MaskList{20,1}='LibyaMask.mat';
MaskList{20,2}='Merra2LibyaMask';
MaskList{20,3}='Libya';
MaskChoices=cell(242,1);
SelectedMaskData=cell(5,3);
SelectedMaskData{1,1}='EuropeMask.mat';
SelectedMaskData{1,2}='Merra2EuropeMask';
SelectedMaskData{1,3}='Europe';
SelectedMaskData{2,1}='AustraliaMask.mat';
SelectedMaskData{2,2}='Merra2AustraliaMask';
SelectedMaskData{2,3}='Australia';
SelectedMaskData{3,1}='NorthAmericaMask.mat';
SelectedMaskData{3,2}='Merra2NorthAmericaMask';
SelectedMaskData{3,3}='NorthAmerica';
SelectedMaskData{4,1}='SouthAmericaMask.mat';
SelectedMaskData{4,2}='Merra2SouthAmericaMask';
SelectedMaskData{4,3}='SouthAmerica';
SelectedMaskData{5,1}='AsiaMask.mat';
SelectedMaskData{5,2}='Merra2AsiaMask';
SelectedMaskData{5,3}='Asia';
SeaMaskChoices=cell(101,1);
SeaMaskChoices{1,1}='SouthAtlanticOcean';
SeaMaskChoices{2,1}='SouthPacificOcean';
SeaMaskChoices{3,1}='IndianOcean';
SeaMaskChoices{4,1}='NorthAtlanticOcean';
SeaMaskChoices{5,1}='NorthPacificOcean';
SelectedSeaMaskData=cell(5,3);
SelectedSeaMaskData{1,1}='SouthAtlanticOceanMask.mat';
SelectedSeaMaskData{1,2}='Merra2SouthAtlanticOceanMask';
SelectedSeaMaskData{1,3}='SouthAtlanticOcean';
SelectedSeaMaskData{2,1}='SouthPacificOceanMask.mat';
SelectedSeaMaskData{2,2}='Merra2SouthPacificOceanMask';
SelectedSeaMaskData{2,3}='SouthPacificOcean';
SelectedSeaMaskData{3,1}='IndianOceanMask.mat';
SelectedSeaMaskData{3,2}='Merra2IndianOceanMask';
SelectedSeaMaskData{3,3}='IndianOcean';
SelectedSeaMaskData{4,1}='NorthAtlanticOceanMask.mat';
SelectedSeaMaskData{4,2}='Merra2NorthAtlanticOceanMask';
SelectedSeaMaskData{4,3}='NorthAtlanticOcean';
SelectedSeaMaskData{5,1}='ArcticOceanMask.mat';
SelectedSeaMaskData{5,2}='Merra2ArcticOceanMask';
SelectedSeaMaskData{5,3}='ArticOcean';
SeaSaltVarCorr=cell(1,4);
SeaSaltVarCorr{1,1}='FrameCounter';
SeaSaltVarCorr{1,2}='SSDP Vs SSEM';
SeaSaltVarCorr{1,3}='SSDP Vs SSSD';
SeaSaltVarCorr{1,4}='SSEM Vs SSSD';
%% Control Flags-Dataset 02
iBlackCarbon=0;
iDust=0;
iOrganicCarbon=0;
iSeaSalt=1;
iSulfate=0;
iAllAerosols=0;
iPrintTimingInfo=1;
iDustCalc=2;% Calculate Dust emission
iSeaSaltCalc=1;%Calculate Sea Salt totals
DustROICountry='Sudan';
%% Control Flags Dataset 03
iMonthForPDF=1;
%% Control Flags Dataset04
integrateRate=0;
iScale=1;
viewAZ=-80;
viewEL=30;
viewAZInc=2;
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
% fid=fopen(logfilename,'w');
% dispstr=strcat('Opened Log file-',logfilename,'-for writing');
% disp(dispstr);
% fprintf(fid,'%50s\n',startrunstr);

%% User chose to go with fixed "default file path" set these up
if(ifixedImagePaths==1)
    ipathstr1='User has selected the option to go with default image file paths';
%    fprintf(fid,'%s\n',ipathstr1);
    Merra2DataPaths=cell(1,1);
    Merra2DataPaths{1,1}='K:\Merra-2\netCDF\Dataset01\Data\';
    Merra2DataPaths{2,1}='K:\Merra-2\netCDF\Dataset02\Data\';
    Merra2DataPaths{3,1}='K:\Merra-2\netCDF\Dataset03\Data\';
    Merra2DataPaths{4,1}='K:\Merra-2\netCDF\Dataset04\Data\';
    Merra2DataPaths{5,1}='K:\Merra-2\netCDF\Dataset05\Data\';
    Merra2DataPaths{6,1}='K:\Merra-2\netCDF\Dataset06\Data\';
    Merra2DataPaths{7,1}='K:\Merra-2\netCDF\Dataset07\Data\';
    Merra2DataPaths{8,1}='K:\Merra-2\netCDF\Dataset08\Data\';
    Merra2DataPaths{9,1}='K:\Merra-2\netCDF\Dataset09\Data\';
    Merra2DataPaths{10,1}='K:\Merra-2\netCDF\Dataset09\Data\';
    Merra2DataPaths{11,1}='K:\Merra-2\netCDF\Dataset09\Matlab_Files1DayAvg\';
    jpegpath='K:\Merra-2\Jpeg\';
    pdfpath='K:\Merra-2\PDF_Reports\';
    logpath='K:\Merra-2\Log_Files\';
%% user chose to run with small distribution set of Image Data
elseif(ifixedImagePaths==2)% This choice is to be used in testing files that will be part of the distribution
else
%% User chose to add a new Image File data (different day) make these paths
% Now set the image paths to the selected folder adding any missing
% subfolders as required
    [output1,output2] = SetImageFolders();
end
MapFormFactor=[];
%% Set up Dateset Names
Datasets=cell(1,1);
Datasets{1,1}='Dataset01-Monthly Diurnal M2IUNXASM';
Datasets{2,1}='Dataset02-Hourly Time Averaged M2T1NXADG';
Datasets{3,1}='Dataset03-Instantaneous M2IUNPANA';
Datasets{4,1}='Dataset04-Hourly Time Averaged M2T1NXOCN';
Datasets{5,1}='Dataset05';
Datasets{6,1}='Dataset06';
Datasets{7,1}='Dataset07';
Datasets{8,1}='Dataset08-Monthly Rad Diagnostics';
Datasets{9,1}='Dataset09-COT-3Hr-Test Mode';
Datasets{10,1}='Dataset09-COT-3Hr to 1Day';
Datasets{11,1}='Dataset09-Daily Mean COT';
Datasets{12,1}='STOP RUN';
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
chart_time=3;
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
toolbox='MATLAB Report Generator';
[RptGenPresent] = ToolboxChecker(toolbox);
toolbox='Image Processing Toolbox';
[ImageProcessPresent]=ToolboxChecker(toolbox);
%% This is the main executive loop of the routine
while igo>0 % This setup up a loop to processing various file until user decides to STOP RUN
    [indx,tf] = listdlg('PromptString',{'Select type of data to read'},...
    'SelectionMode','single','ListString',Datasets,'ListSize',[360,300]);
    a1=isempty(indx);
    if(a1==1)
        igo=0;
    else
        igo=1;
    end
    if(indx==1)
        logfilename=strcat('Merra2LogFileIndx1-',logfilename,'.txt');
        pdfpath='K:\Merra-2\netCDF\Dataset01\PDF_Files\';
    elseif(indx==2)
        logfilename=strcat('Merra2LogFileIndx2-',logfilename,'.txt');
        pdfpath='K:\Merra-2\netCDF\Dataset02\PDF_Files\';
    elseif(indx==3)
        logfilename=strcat('Merra2LogFileIndx3-',logfilename,'.txt');
        pdfpath='K:\Merra-2\netCDF\Dataset03\PDF_Files\';
    elseif(indx==4)
        logfilename=strcat('Merra2LogFileIndx4-',logfilename,'.txt');
        pdfpath='K:\Merra-2\netCDF\Dataset04\PDF_Files\';
    end
    eval(['cd ' logpath(1:length(logpath)-1)]);
    fid=fopen(logfilename,'w');
    dispstr=strcat('Opened Log file-',logfilename,'-for writing');
    disp(dispstr);
    fprintf(fid,'%50s\n',startrunstr);
    if(indx==2)
        pdfpath='K:\Merra-2\netCDF\Dataset02\PDF_Files\';
%     elseif(indx==3)
%         pdfpath='K:\Merra-2\netCDF\Dataset03\PDF_Files\';
%     end
%% Get the Run Configuration Data
        if(iCheckConfig==1)
            SpecifyMatlabConfiguration('ReadMerra2Data.m');
        end
    end

%% Start a PDF report if requested by user and user has the Matlab Report
% Generator Package Installed
    if((iCreatePDFReport==1) && (RptGenPresent==1))
        import mlreportgen.dom.*;
        import mlreportgen.report.*;
        import mlreportgen.utils.*
        CreateMerra2ReportHeaderRev1;
    else
%        fprintf(fid,'%s\n','No PDF report will be created for this run');
    end
    if(indx==1)
        jpegpath='K:\Merra-2\netCDF\Dataset01\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset01\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset01\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset01\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset01\Matlab_Files\';
        tablepath='K:\Merra-2\netCDF\Dataset01\Tables\';
        logfilename=strcat('Merra2LogFileIndx1-',logfilename,'.txt');
        isavefiles=0;
        TimeSlices=cell(24,1);
        TimeSlices{1,1}='0 HRS GMT';
        TimeSlices{2,1}='1 HRS GMT';
        TimeSlices{3,1}='2 HRS GMT';
        TimeSlices{4,1}='3 HRS GMT';
        TimeSlices{5,1}='4 HRS GMT';
        TimeSlices{6,1}='5 HRS GMT';
        TimeSlices{7,1}='6 HRS GMT';
        TimeSlices{8,1}='7 HRS GMT';
        TimeSlices{9,1}='8 HRS GMT';
        TimeSlices{10,1}='9 HRS GMT';
        TimeSlices{11,1}='10 HRS GMT';
        TimeSlices{12,1}='11 HRS GMT';
        TimeSlices{13,1}='12 HRS GMT';
        TimeSlices{14,1}='13 HRS GMT';
        TimeSlices{15,1}='14 HRS GMT';
        TimeSlices{16,1}='15 HRS GMT';
        TimeSlices{17,1}='16 HRS GMT';
        TimeSlices{18,1}='17 HRS GMT';
        TimeSlices{19,1}='18 HRS GMT';
        TimeSlices{20,1}='19 HRS GMT';
        TimeSlices{21,1}='20 HRS GMT';
        TimeSlices{22,1}='21 HRS GMT';
        TimeSlices{23,1}='22 HRS GMT';
        TimeSlices{24,1}='23 HRS GMT';
        VariableTable=cell(120,5);
        VariableTableHdr=cell(1,5);

        eval(['cd ' logpath(1:length(logpath)-1)]);
%        fid=fopen(logfilename,'w');
%         dispstr=strcat('Opened Log file-',logfilename,'-for writing');
%         disp(dispstr);
%        fprintf(fid,'%50s\n',startrunstr);
        if((iCreatePDFReport~=1) || (RptGenPresent~=1))
            fprintf(fid,'%s\n','No PDF report will be created for this run');
        end
%% Start a PDF report if requested by user and user has the Matlab Report
%Generator Package Installed
%         if((iCreatePDFReport==1) && (RptGenPresent==1))
%             import mlreportgen.dom.*;
%             import mlreportgen.report.*;
%             import mlreportgen.utils.*
%             CreateMerra2ReportHeader
%         else
%             fprintf(fid,'%s\n','No PDF report will be created for this run');
%         end
    elseif(indx==2)
        jpegpath='K:\Merra-2\netCDF\Dataset02\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset02\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset02\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset02\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset02\Matlab_Files\'; 
        tablepath='K:\Merra-2\netCDF\Dataset02\Tables\';
        logfilename=strcat('Merra2LogFileIndx2-',logfilename,'.txt');
        TimeSlices=cell(24,1);
        TimeSlices{1,1}='0 HRS GMT';
        TimeSlices{2,1}='1 HRS GMT';
        TimeSlices{3,1}='2 HRS GMT';
        TimeSlices{4,1}='3 HRS GMT';
        TimeSlices{5,1}='4 HRS GMT';
        TimeSlices{6,1}='5 HRS GMT';
        TimeSlices{7,1}='6 HRS GMT';
        TimeSlices{8,1}='7 HRS GMT';
        TimeSlices{9,1}='8 HRS GMT';
        TimeSlices{10,1}='9 HRS GMT';
        TimeSlices{11,1}='10 HRS GMT';
        TimeSlices{12,1}='11 HRS GMT';
        TimeSlices{13,1}='12 HRS GMT';
        TimeSlices{14,1}='13 HRS GMT';
        TimeSlices{15,1}='14 HRS GMT';
        TimeSlices{16,1}='15 HRS GMT';
        TimeSlices{17,1}='16 HRS GMT';
        TimeSlices{18,1}='17 HRS GMT';
        TimeSlices{19,1}='18 HRS GMT';
        TimeSlices{20,1}='19 HRS GMT';
        TimeSlices{21,1}='20 HRS GMT';
        TimeSlices{22,1}='21 HRS GMT';
        TimeSlices{23,1}='22 HRS GMT';
        TimeSlices{24,1}='23 HRS GMT';
        eval(['cd ' logpath(1:length(logpath)-1)]);
        if((iCreatePDFReport~=1) || (RptGenPresent~=1))
            fprintf(fid,'%s\n','No PDF report will be created for this run');
        else
            CreateMerra2AerosolDiagnosticsReport
        end

    elseif(indx==3)
        jpegpath='K:\Merra-2\netCDF\Dataset03\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset03\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset03\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset03\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset03\Matlab_Files\';  
        tablepath='K:\Merra-2\netCDF\Dataset03\Tables\';
        logfilename=strcat('Merra2LogFileIndx3-',logfilename,'.txt');
        TimeSlices=cell(4,1);
        TimeSlices{1,1}='0 HRS GMT';
        TimeSlices{2,1}='6 HRS GMT';
        TimeSlices{3,1}='12 HRS GMT';
        TimeSlices{4,1}='18 HRS GMT';
 % Select a pressure level for 3 and 4 arrays
        PressureLabels42=cell(41,1);
        for ii=1:42
            htkm=PressureLevel42(ii,3);
            PressureLabels42{ii,1}=strcat('Level-',num2str(ii),'-Alt-km-',num2str(htkm));
        end
        [iPress,~] = listdlg('PromptString',{'Select one pressure level to process'},...
        'SelectionMode','single','ListString',PressureLabels42,'ListSize',[360,300]);
        a1=isempty(iPress);
        if(a1==1)
            iPress42=6;
        else
            iPress42=iPress;
        end        
        ab=2;
  % Select a Time Slice  for 3 and 4 d arrays
         [iTimeS,~] = listdlg('PromptString',{'Select one time slice to process'},...
        'SelectionMode','single','ListString',TimeSlices,'ListSize',[360,300]);
         a1=isempty(iTimeS);
         if(a1==1)
            iTimeSlice=2;
         else
            iTimeSlice=iTimeS;
         end
         ab=2;
     elseif(indx==4)
        jpegpath='K:\Merra-2\netCDF\Dataset04\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset04\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset04\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset04\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset04\Matlab_Files\';
        tablepath='K:\Merra-2\netCDF\Dataset04\Tables\';
        logfilename=strcat('Merra2LogFileIndx4-',logfilename,'.txt');
     elseif(indx==5)
        jpegpath='K:\Merra-2\netCDF\Dataset04\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset04\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset04\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset04\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset04\Matlab_Files\'; 
        logfilename=strcat('Merra2LogFileIndx5-',logfilename,'.txt');
     elseif(indx==6)
        jpegpath='K:\Merra-2\netCDF\Dataset04\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset04\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset04\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset04\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset04\Matlab_Files\';
        logfilename=strcat('Merra2LogFileIndx6-',logfilename,'.txt');
     elseif(indx==7)
        jpegpath='K:\Merra-2\netCDF\Dataset07\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset07\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset07\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset07\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset07\Matlab_Files\'; 
        logfilename=strcat('Merra2LogFileIndx7-',logfilename,'.txt');
      elseif(indx==8)
        jpegpath='K:\Merra-2\netCDF\Dataset08\Jpeg_Files\';
        %pdfpath='K:\Merra-2\netCDF\Dataset08\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset08\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset08\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset08\Matlab_Files\';
        tablepath='K:\Merra-2\netCDF\Dataset08\Tables\';
        pdfpath='K:\Merra-2\netCDF\Dataset08\PDF_Files\';
        logfilename=strcat('Merra2LogFileIndx8-',logfilename,'.txt');
      elseif(indx==9)
        jpegpath='K:\Merra-2\netCDF\Dataset09\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset09\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset09\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset09\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset09\Matlab_Files\';  
        logfilename=strcat('Merra2LogFileIndx9-',logfilename,'.txt');
      elseif(indx==10)
        jpegpath='K:\Merra-2\netCDF\Dataset09\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset09\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset09\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset09\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset09\Matlab_Files\';  
        logfilename=strcat('Merra2LogFileIndx10-',logfilename,'.txt');
      elseif(indx==11)
        jpegpath='K:\Merra-2\netCDF\Dataset09\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset09\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset09\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset09\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset09\MatlabDailyMeans\';  
        logfilename=strcat('Merra2LogFileIndx10-',logfilename,'.txt');
    end
    if(indx>11)
        igo=0;
    end
    if(igo==0)
        break
    end
eval(['cd ' logpath(1:length(logpath)-1)]);
fid=fopen(logfilename,'w');
fprintf(fid,'%50s\n',startrunstr);
Merra2Path=Merra2DataPaths{indx,1};
% Get the Configuration Data
if(iCheckConfig==1)
    SpecifyMatlabConfiguration('ReadMerra2Data.m');
end
% Go to the expected path
    eval(['cd ' Merra2Path(1:length(Merra2Path)-1)]);
    if(indx==1)% M2IUNXASM_5.12.4
        [Merra2FileNames,nowpath] = uigetfile('*.nc4','Select Multiple Files', ...
        'MultiSelect', 'on');
        Merra2FileNames=Merra2FileNames';
        numSelectedFiles=length(Merra2FileNames);
        [NewFileList] = SortMonthlyFilesInTimeOrder(Merra2FileNames);
        Merra2FileNames=NewFileList;
        fprintf(fid,'\n');
        fprintf(fid,'%s\n','----- List of Files to Be processed-----');
        for nn=1:numSelectedFiles
            nowFile=Merra2FileNames{nn,1};
            filestr='File Num';
            fprintf(fid,'%s\n',nowFile);
        end
        fprintf(fid,'%s\n','----- End List of Files to Be processed-----');
        numtimeslice=1;
        testFile=Merra2FileNames{1,1};
        testFileEnd=Merra2FileNames{numSelectedFiles,1};
        [iper]=strfind(testFile,'.');
        is=iper(2)+1;
        ie=iper(3)-1;
        YearMonthStr=testFile(is:ie);
        YearMonthStrStart=YearMonthStr;
        YearMonthStrEnd=testFileEnd(is:ie);
        framecounter=0;
        [islice,tf] = listdlg('PromptString',{'Select time slice to process'},...
        'SelectionMode','single','ListString',TimeSlices,'ListSize',[360,300]);
        a1=isempty(indx);
        if(a1==1)
            numtimeslice=1;
        else
            numtimeslice=islice;
        end
        fprintf(fid,'\n');
        fprintf(fid,'%s\n','----- Time Slice to Be Processed-----');
        tslicestr=strcat('Time Slice Selected For Processing-',num2str(islice));
        fprintf(fid,'%s\n',tslicestr);
        tslicestr2=char(TimeSlices{numtimeslice,1});
        tslicestr3=strcat('This corresponds to a time of-',tslicestr2);
        fprintf(fid,'%s\n',tslicestr3);
        fprintf(fid,'\n');
        framecounter=0;
        testFile=Merra2FileNames{1,1};
        testFileEnd=Merra2FileNames{numSelectedFiles,1};
        [iper]=strfind(testFile,'.');
        is=iper(2)+1;
        ie=iper(3)-1;
        if(iMovie>0)
            YearMonthStr=testFile(is:ie);
            YearMonthStrStart=YearMonthStr;
            YearMonthStrEnd=testFileEnd(is:ie);
            TempMovieName4=strcat('SurfacePressure-',YearMonthStr,'-Fr-',num2str(numSelectedFiles),'-ts-',num2str(islice),'.mp4');
            TempMovieName5=strcat('SH-10m-',YearMonthStr,'-Fr-',num2str(numSelectedFiles),'-ts-',num2str(islice),'.mp4');
            TempMovieName6=strcat('SH-2m-',YearMonthStr,'-Fr-',num2str(numSelectedFiles),'-ts-',num2str(islice),'.mp4');
            TempMovieName7=strcat('SLP-',YearMonthStr,'-Fr-',num2str(numSelectedFiles),'-ts-',num2str(islice),'.mp4');
            eval(['cd ' moviepath(1:length(moviepath)-1)]);
            if(MovieFlags(4,1)==1)
                vTemp4 = VideoWriter(TempMovieName4,'MPEG-4');
                vTemp4.Quality=100;
                vTemp4.FrameRate=3;
                open(vTemp4);
            end
            if(MovieFlags(5,1)==1)
                vTemp5 = VideoWriter(TempMovieName5,'MPEG-4');
                vTemp5.Quality=100;
                vTemp5.FrameRate=3;
                open(vTemp5);
            end
            if(MovieFlags(6,1)==1)
                vTemp6 = VideoWriter(TempMovieName6,'MPEG-4');
                vTemp6.Quality=100;
                vTemp6.FrameRate=3;
                open(vTemp6);
            end
            if(MovieFlags(7,1)==1)
                vTemp7 = VideoWriter(TempMovieName7,'MPEG-4');
                vTemp7.Quality=100;
                vTemp7.FrameRate=3;
                open(vTemp7);
            end

        end
        for n=1:numSelectedFiles
            framecounter=framecounter+1;
            nowFile=Merra2FileNames{n,1};
            [iper]=strfind(nowFile,'.');
            is=iper(2)+1;
            ie=iper(3)-1;
            YearMonthStr=nowFile(is:ie);  
            ReadDataset01(nowFile,nowpath)
            dispstr=strcat('Finished Processing File-',nowFile,'-which is file-',num2str(n),...
                '-of-',num2str(numSelectedFiles),'-Files');
            disp(dispstr)
        end
        if((iMovie>0) && (MovieFlags(4,1)==1))
            close(vTemp4);
        end
        if((iMovie>0) && (MovieFlags(5,1)==1))
            close(vTemp5);
        end
        if((iMovie>0) && (MovieFlags(6,1)==1))
            close(vTemp6);
        end
        if((iMovie>0) && (MovieFlags(7,1)==1))
            close(vTemp7);
        end
        igo=0;
%% Process Data from M2T1NXADG_5.12.4
    elseif(indx==2)% M2T1NXADG_5.12.4
        [Merra2FileNames,nowpath] = uigetfile('*.nc4','Select Multiple Files', ...
        'MultiSelect', 'on');
        a1=isempty(Merra2FileNames);
        if(a1==0)
        Merra2FileNames=Merra2FileNames';
        numSelectedFiles=length(Merra2FileNames);
        [NewFileList] = SortMonthlyFilesInTimeOrder(Merra2FileNames);
        Merra2FileNames=NewFileList;
 %       profile on
        fprintf(fid,'\n');
        fprintf(fid,'%s\n','----- List of Files to Be processed-----');
        for nn=1:numSelectedFiles
            nowFile=Merra2FileNames{nn,1};
            filestr='File Num';
            fprintf(fid,'%s\n',nowFile);
        end
        fprintf(fid,'%s\n','----- End List of Files to Be processed-----');
        ab=1;
        framecounter=0;
        [islice,~] = listdlg('PromptString',{'Select time slice to process'},...
        'SelectionMode','single','ListString',TimeSlices,'ListSize',[360,300]);
        a1=isempty(indx);
        if(a1==1)
            numtimeslice=1;
        else
            numtimeslice=islice;
        end
        fprintf(fid,'\n');
        fprintf(fid,'%s\n','----- Time Slice to Be Processed-----');
        tslicestr=strcat('Time Slice Selected For Processing-',num2str(islice));
        fprintf(fid,'%s\n',tslicestr);
        tslicestr2=char(TimeSlices{numtimeslice,1});
        tslicestr3=strcat('This corresponds to a time of-',tslicestr2);
        fprintf(fid,'%s\n',tslicestr3);
        fprintf(fid,'\n');
        testFile=Merra2FileNames{1,1};
        testFileEnd=Merra2FileNames{numSelectedFiles,1};
        [iper]=strfind(testFile,'.');
        is=iper(2)+1;
        ie=iper(3)-1;
        YearMonthStr=testFile(is:ie);
        YearMonthStrStart=YearMonthStr;
        YearMonthStrEnd=testFileEnd(is:ie);
 % Load in the Mask File
        eval(['cd ' maskpath(1:length(maskpath)-1)])
        load(MaskFileName,'MaskList')
        ab=2;
 % Set up the dialog to ask the user which masks to use (1-5 masks)
        for jj=1:242
            MaskChoices{jj,1}=char(MaskList{jj,3});
        end
        [imask,~] = listdlg('PromptString',{'Select up to 5 Land area masks'},...
        'SelectionMode','multiple','ListString',MaskChoices,'ListSize',[360,300]);
        ab=3;
        a1=isempty(imask);
        if(a1==0)
            numSelectedMasks=length(imask);
            if(numSelectedMasks>5)
                numSelectedMasks=5;
            end
            for jj=1:numSelectedMasks
                inds=imask(1,jj);
                SelectedMaskData{jj,1}=MaskList{inds,1};
                SelectedMaskData{jj,2}=MaskList{inds,2};
                SelectedMaskData{jj,3}=MaskList{inds,3};
            end
            if(numSelectedMasks<5)
                numSelectedMasks=5;
            end
        else
            numSelectedMasks=5;
        end
        ROIName1=char(SelectedMaskData{1,3});
        ROIName2=char(SelectedMaskData{2,3});
        ROIName3=char(SelectedMaskData{3,3});
        ROIName4=char(SelectedMaskData{4,3});
        ROIName5=char(SelectedMaskData{5,3});
  fprintf(fid,'%s\n','----- Land Surface Masks Selected-----');
  roistr1=strcat('ROI Name 1=',ROIName1);
  fprintf(fid,'%s\n',roistr1);
  roistr2=strcat('ROI Name 2=',ROIName2);
  fprintf(fid,'%s\n',roistr2);
  roistr3=strcat('ROI Name 3=',ROIName3);
  fprintf(fid,'%s\n',roistr3);
  roistr4=strcat('ROI Name 4=',ROIName4);
  fprintf(fid,'%s\n',roistr4);
  roistr5=strcat('ROI Name 5=',ROIName5);
  fprintf(fid,'%s\n',roistr5);
  fprintf(fid,'%s\n','----- End Of Land Surface Masks Selected-----');
% Load these 5 masks in now
% Start With Mask 1
    maskFile=char(SelectedMaskData{1,1});
    maskVar=char(SelectedMaskData{1,2});
    load(maskFile,maskVar);
    Merra2WorkingMask1=eval(maskVar);
    DustROICountry=char(SelectedMaskData{1,3});
% Continue With Mask 2
    maskFile2=char(SelectedMaskData{2,1});
    maskVar2=char(SelectedMaskData{2,2});
    load(maskFile2,maskVar2);
    Merra2WorkingMask2=eval(maskVar2);
% Continue With Mask 3
    maskFile3=char(SelectedMaskData{3,1});
    maskVar3=char(SelectedMaskData{3,2});
    load(maskFile3,maskVar3);
    Merra2WorkingMask3=eval(maskVar3);
% Continue With Mask 4
    maskFile4=char(SelectedMaskData{4,1});
    maskVar4=char(SelectedMaskData{4,2});
    load(maskFile4,maskVar4);
    Merra2WorkingMask4=eval(maskVar4);
% Finish With Mask 5
    maskFile5=char(SelectedMaskData{5,1});
    maskVar5=char(SelectedMaskData{5,2});
    load(maskFile5,maskVar5);
    Merra2WorkingMask5=eval(maskVar5);
% Load in the Sea Area Masks if the iSeaSalt option is set to 1
   if(iSeaSalt>0)
 % Load in the Sea Mask File
        eval(['cd ' oceanmappath(1:length(oceanmappath)-1)]);
        load(SeaMaskFileName,'SeaBoundaryFiles','SeaMaskChoices','SortedSBF','indexSBF');
        ab=2;
 % Set up the dialog to ask the user which  seamasks to use (1-5 masks)
        [imask,~] = listdlg('PromptString',{'Select up to 5 Sea area masks'},...
        'SelectionMode','multiple','ListString',SeaMaskChoices,'ListSize',[360,300]);
        ab=3;
        a1=isempty(imask);
        if(a1==0)
            numUserSelectedSeaMasks=length(imask);
            numSelectedSeaMasks=numUserSelectedSeaMasks;
            if(numUserSelectedSeaMasks>5)
                numUserSelectedSeaMasks=5;
            end
            for jj=1:numUserSelectedSeaMasks
                inds=imask(1,jj);
                SelectedSeaMaskData{jj,1}=SortedSBF{inds,7};
                merra2maskname=char(SortedSBF{inds,2});
                merra2maskname=strcat('Merra2',merra2maskname,'Mask');
                SelectedSeaMaskData{jj,2}=merra2maskname;
                SelectedSeaMaskData{jj,3}=SortedSBF{inds,2};
                SelectedSeaMaskData{jj,4}=SortedSBF{inds,3};
            end
            if(numSelectedMasks<5)
                numSelectedMasks=5;
            end
        else
            numSelectedMasks=5;
        end
   end
   ROIName6=char(SelectedSeaMaskData{1,3});
   ROIName7=char(SelectedSeaMaskData{2,3});
   ROIName8=char(SelectedSeaMaskData{3,3});
   ROIName9=char(SelectedSeaMaskData{4,3});
   ROIName10=char(SelectedSeaMaskData{5,3});
  fprintf(fid,'%s\n','----- Sea Surface Masks Selected-----');
  sm01a=char(SelectedSeaMaskData{1,1});
  sm01b=char(SelectedSeaMaskData{1,2});
  sm01c=char(SelectedSeaMaskData{1,3});
  sm01d=char(SelectedSeaMaskData{1,4});
  sm01=strcat('Mask1-',sm01a,'-',sm01b,'-',sm01c,'-',sm01d);
  fprintf(fid,'%s\n',sm01);
  sm02a=char(SelectedSeaMaskData{2,1});
  sm02b=char(SelectedSeaMaskData{2,2});
  sm02c=char(SelectedSeaMaskData{2,3});
  sm02d=char(SelectedSeaMaskData{2,4});
  sm02=strcat('Mask2-',sm02a,'-',sm02b,'-',sm02c,'-',sm02d);
  fprintf(fid,'%s\n',sm02);
  sm03a=char(SelectedSeaMaskData{3,1});
  sm03b=char(SelectedSeaMaskData{3,2});
  sm03c=char(SelectedSeaMaskData{3,3});
  sm03d=char(SelectedSeaMaskData{3,4});
  sm03=strcat('Mask3-',sm03a,'-',sm03b,'-',sm03c,'-',sm03d);
  fprintf(fid,'%s\n',sm03);
  sm04a=char(SelectedSeaMaskData{4,1});
  sm04b=char(SelectedSeaMaskData{4,2});
  sm04c=char(SelectedSeaMaskData{4,3});
  sm04d=char(SelectedSeaMaskData{4,4});
  sm04=strcat('Mask4-',sm04a,'-',sm04b,'-',sm04c,'-',sm04d);
  fprintf(fid,'%s\n',sm04);
  sm05a=char(SelectedSeaMaskData{5,1});
  sm05b=char(SelectedSeaMaskData{5,2});
  sm05c=char(SelectedSeaMaskData{5,3});
  sm05d=char(SelectedSeaMaskData{5,4});
  sm05=strcat('Mask5-',sm05a,'-',sm05b,'-',sm05c,'-',sm05d);
  fprintf(fid,'%s\n',sm05);
  roistr6=strcat('ROI Name 6=',ROIName6);
  fprintf(fid,'%s\n',roistr6);
  roistr7=strcat('ROI Name 7=',ROIName7);
  fprintf(fid,'%s\n',roistr7);
  roistr8=strcat('ROI Name 8=',ROIName8);
  fprintf(fid,'%s\n',roistr8);
  roistr9=strcat('ROI Name 9=',ROIName9);
  fprintf(fid,'%s\n',roistr9);
  roistr10=strcat('ROI Name 10=',ROIName10);
  fprintf(fid,'%s\n',roistr10);
  fprintf(fid,'%s\n','----- End Sea Surface Masks Selected-----');
% Load these 5 masks in now
% Start With Mask 1 if one was defined
if(numUserSelectedSeaMasks>=1)
    eval(['cd ' watermaskpath(1:length(watermaskpath)-1)])
    maskFile=char(SelectedSeaMaskData{1,1});
    maskVar=char(SelectedSeaMaskData{1,2});
    maskVar2=char(SelectedSeaMaskData{1,4});
    load(maskFile,maskVar);
    Merra2WorkingSeaMask1=eval(maskVar);
    eval(['cd ' oceanmappath(1:length(oceanmappath)-1)]);
    load(maskVar2,'seaLat','seaLon','seaArea')
    Merra2WorkingSeaBoundary1Lat=seaLat;
    Merra2WorkingSeaBoundary1Lon=seaLon;
    Merra2WorkingSeaBoundary1Area=seaArea;
end
% Continue With Mask 2  
if(numUserSelectedSeaMasks>=2)
    eval(['cd ' watermaskpath(1:length(watermaskpath)-1)])
    maskFile=char(SelectedSeaMaskData{2,1});
    maskVar=char(SelectedSeaMaskData{2,2});
    maskVar2=char(SelectedSeaMaskData{2,4});
    load(maskFile,maskVar);
    Merra2WorkingSeaMask2=eval(maskVar);
    eval(['cd ' oceanmappath(1:length(oceanmappath)-1)]);
    load(maskVar2,'seaLat','seaLon','seaArea')
    Merra2WorkingSeaBoundary2Lat=seaLat;
    Merra2WorkingSeaBoundary2Lon=seaLon;
    Merra2WorkingSeaBoundary2Area=seaArea;
end
% Continue With Mask 3
if(numUserSelectedSeaMasks>=3)
    eval(['cd ' watermaskpath(1:length(watermaskpath)-1)])
    maskFile=char(SelectedSeaMaskData{3,1});
    maskVar=char(SelectedSeaMaskData{3,2});
    maskVar2=char(SelectedSeaMaskData{3,4});
    load(maskFile,maskVar);
    Merra2WorkingSeaMask3=eval(maskVar);
    eval(['cd ' oceanmappath(1:length(oceanmappath)-1)])
    load(maskVar2,'seaLat','seaLon','seaArea')
    Merra2WorkingSeaBoundary3Lat=seaLat;
    Merra2WorkingSeaBoundary3Lon=seaLon;
    Merra2WorkingSeaBoundary3Area=seaArea;
end
% Continue With Mask 4
if(numUserSelectedSeaMasks>=4)
    eval(['cd ' watermaskpath(1:length(watermaskpath)-1)])
    maskFile=char(SelectedSeaMaskData{4,1});
    maskVar=char(SelectedSeaMaskData{4,2});
    maskVar2=char(SelectedSeaMaskData{4,4});
    load(maskFile,maskVar);
    Merra2WorkingSeaMask4=eval(maskVar);
    eval(['cd ' oceanmappath(1:length(oceanmappath)-1)])
    load(maskVar2,'seaLat','seaLon','seaArea')
    Merra2WorkingSeaBoundary4Lat=seaLat;
    Merra2WorkingSeaBoundary4Lon=seaLon;
    Merra2WorkingSeaBoundary4Area=seaArea;
else
   eval(['cd ' watermaskpath(1:length(watermaskpath)-1)]) 

   maskFile='NorthAtlanticOceanMask.mat';
   maskVar=['Merra2NorthAtlanticOcean' ...
       'Mask'];
   maskVar2=char(SortedSBF{75,3});
   load(maskFile,maskVar);
   Merra2WorkingSeaMask5=eval(maskVar);
   eval(['cd ' oceanmappath(1:length(oceanmappath)-1)]);
   load(maskVar2,'seaLat','seaLon','seaArea')
   Merra2WorkingSeaBoundary4Lat=seaLat;
   Merra2WorkingSeaBoundary4Lon=seaLon;
   Merra2WorkingSeaBoundary4Area=seaArea;   
end
% Finish With Mask 5
if(numUserSelectedSeaMasks>=5)
    eval(['cd ' watermaskpath(1:length(watermaskpath)-1)])
    maskFile=char(SelectedSeaMaskData{5,1});
    maskVar=char(SelectedSeaMaskData{5,2});
    maskVar2=char(SelectedSeaMaskData{5,4});
    load(maskFile,maskVar);
    Merra2WorkingSeaMask5=eval(maskVar);
    eval(['cd ' oceanmappath(1:length(oceanmappath)-1)]);
    load(maskVar2,'seaLat','seaLon','seaArea')
    Merra2WorkingSeaBoundary5Lat=seaLat;
    Merra2WorkingSeaBoundary5Lon=seaLon;
    Merra2WorkingSeaBoundary5Area=seaArea;
else
   eval(['cd ' watermaskpath(1:length(watermaskpath)-1)]) 
   maskFile='ArcticOceanMask.mat';
   maskVar='Merra2ArcticOceanMask';
   maskVar2=char(SortedSBF{8,3});
   load(maskFile,maskVar);
   Merra2WorkingSeaMask5=eval(maskVar);
   eval(['cd ' oceanmappath(1:length(oceanmappath)-1)]);
   load(maskVar2,'seaLat','seaLon','seaArea')
   Merra2WorkingSeaBoundary5Lat=seaLat;
   Merra2WorkingSeaBoundary5Lon=seaLon;
   Merra2WorkingSeaBoundary5Area=seaArea;
end
    ab=2;
        for n=1:numSelectedFiles
            framecounter=framecounter+1;
            nowFile=Merra2FileNames{n,1};
            [iper]=strfind(nowFile,'.');
            is=iper(2)+1;
            ie=iper(3)-1;
            YearMonthStr=nowFile(is:ie);  
            ReadDataset02(nowFile,nowpath)
            dispstr=strcat('Finished Processing File-',nowFile,'-which is file-',num2str(n),...
                '-of-',num2str(numSelectedFiles),'-Files');
            disp(dispstr)
        end
        else
            igo=0;
        end
        igo=0;
 %% Process Data from M2IUNPANA_5.12.4
    elseif(indx==3)% M2IUNPANA_5.12.4
            Dataset3TempChanges=zeros(12,10);
 % Add in Country Masks-(Pre Selected List)
            Dataset3Masks=cell(10,1);
            ROIName1='Germany';
            ROIName2='Finland';
            ROIName3='UK';
            ROIName4='Sudan';
            ROIName5='SouthAfrica';
            ROIName6='India';
            ROIName7='Australia';
            ROIName8='California';
            ROIName9='Texas';
            ROIName10='Peru';
            Dataset3Masks{1,1}='Germany';
            Dataset3Masks{2,1}='Finland';
            Dataset3Masks{3,1}='UK';
            Dataset3Masks{4,1}='Sudan';
            Dataset3Masks{5,1}='SouthAfrica';
            Dataset3Masks{6,1}='India';
            Dataset3Masks{7,1}='Australia';
            Dataset3Masks{8,1}='California';
            Dataset3Masks{9,1}='Texas';
            Dataset3Masks{10,1}='Peru';
        if(iPostProcessDataset3<1)
            [Merra2FileNames,nowpath] = uigetfile('*.nc4','Select Multiple Files', ...
            'MultiSelect', 'on');
            Merra2FileNames=Merra2FileNames';
            numSelectedFiles=length(Merra2FileNames);
            [NewFileList] = SortMonthlyFilesInTimeOrder(Merra2FileNames);
            Merra2FileNames=NewFileList;
            numSelectedFiles=length(Merra2FileNames);
            fprintf(fid,'\n');
            fprintf(fid,'%s\n','----- List of Files to Be processed-----');
            for nn=1:numSelectedFiles
                nowFile=Merra2FileNames{nn,1};
                filestr='File Num';            
                fprintf(fid,'%s\n',nowFile);
            end       
            fprintf(fid,'%s\n','----- End List of Files to Be processed-----');
            tpstr=strcat('Process time-',TimeSlices{iTimeSlice,1});
            pslice=iPress42;
            heightkm=PressureLevel42(iPress42,3);
            prslevlstr=strcat('Pressure Level-',num2str(iPress),'-Height Km=',num2str(heightkm));
            fprintf(fid,'%s\n',tpstr);
            fprintf(fid,'%s\n',prslevlstr);
            fprintf(fid,'\n');
%  Add the intro section of the PDF report for this dataset
            if((iCreatePDFReport==1) && (RptGenPresent==1))
                CreateMerra2Dataset03Report
            end
%% Set Up the masks that are needed
            SetUpDataset3RegionalMasks()
            bypass=1;
% Now start looping thru the selected files
            for nn=1:numSelectedFiles
                nowFile=Merra2FileNames{nn,1}; 
                framecounter=framecounter+1;
                ReadDataset03Rev1(nowFile,nowpath)
                dispstr=strcat('Finished Processing File-',nowFile,'-which is file-',num2str(nn),...
                    '-of-',num2str(numSelectedFiles),'-Files');
                disp(dispstr)
            end
        end
        if(iPostProcessDataset3==1)
            eval(['cd ' tablepath(1:length(tablepath)-1)]) 
            if(iSelectSet3==1)
               [TableFile,nowpath] = uigetfile('*CombinedTSSTables.mat','Select One Avg Temp File', ...
                'MultiSelect', 'off');
            elseif(iSelectSet3==2)
               [TableFile2,nowpath] = uigetfile('*CombinedQVSTables.mat','Select One Avg Specific Humidity File', ...
                'MultiSelect', 'off');
            end
            if(iSelectSet3==1)
                PerformAirTemperatureCurvefits()
            elseif(iSelectSet3==2)
                PerformSpecificHumidityCurvefits()
            elseif(iSelectSet3==3)
                 [TableFile,nowpath] = uigetfile('*CombinedTSSTables.mat','Select One Avg Temp File', ...
                'MultiSelect', 'off');
                [TableFile2,nowpath] = uigetfile('*CombinedQVSTables.mat','Select One Avg Specific Humidity File', ...
                'MultiSelect', 'off');
                PerformAirTemperatureCurvefits()
                PerformSpecificHumidityCurvefits()

            end
        end
        igo=0;
    elseif(indx==4)% M2T1NXOCN
        jpegpath='K:\Merra-2\netCDF\Dataset04\Jpeg_Files\';
        pdfpath='K:\Merra-2\netCDF\Dataset04\PDF_Files\';
        logpath='K:\Merra-2\netCDF\Dataset04\Log_Files\';
        moviepath='K:\Merra-2\netCDF\Dataset04\Movies\';
        savepath='K:\Merra-2\netCDF\Dataset04\Matlab_Files\';
        tablepath='K:\Merra-2\netCDF\Dataset04\Tables\';
        logfilename=strcat('Merra2LogFileIndx1-',logfilename,'.txt');
        isavefiles=2;% Set to this value to save some partial run data
                     % for quiver function test !
        [Merra2FileNames,nowpath] = uigetfile('*.nc4','Select Multiple Files', ...
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
            
            [NewFileList] = SortMonthlyFilesInTimeOrder(Merra2FileNames);
        end
        Merra2FileNames=NewFileList;
        Merra2FileName=char(Merra2FileNames{1,1});
        prefixString='NPIceFraction';
        [TempMovieName4A] = CreateMovieFileName(prefixString,Merra2FileName);
        prefixString='SPIceFraction';
        [TempMovieName4B] = CreateMovieFileName(prefixString,Merra2FileName);
        prefixString='WindVector';
        [TempMovieName30] = CreateMovieFileName(prefixString,Merra2FileName);
 % Select A Time slice for extra analysis and most plots
        TimeSlices=cell(24,1);
        TimeSlices{1,1}='0 HRS GMT';
        TimeSlices{2,1}='1 HRS GMT';
        TimeSlices{3,1}='2 HRS GMT';
        TimeSlices{4,1}='3 HRS GMT';
        TimeSlices{5,1}='4 HRS GMT';
        TimeSlices{6,1}='5 HRS GMT';
        TimeSlices{7,1}='6 HRS GMT';
        TimeSlices{8,1}='7 HRS GMT';
        TimeSlices{9,1}='8 HRS GMT';
        TimeSlices{10,1}='9 HRS GMT';
        TimeSlices{11,1}='10 HRS GMT';
        TimeSlices{12,1}='11 HRS GMT';
        TimeSlices{13,1}='12 HRS GMT';
        TimeSlices{14,1}='13 HRS GMT';
        TimeSlices{15,1}='14 HRS GMT';
        TimeSlices{16,1}='15 HRS GMT';
        TimeSlices{17,1}='16 HRS GMT';
        TimeSlices{18,1}='17 HRS GMT';
        TimeSlices{19,1}='18 HRS GMT';
        TimeSlices{20,1}='19 HRS GMT';
        TimeSlices{21,1}='20 HRS GMT';
        TimeSlices{22,1}='21 HRS GMT';
        TimeSlices{23,1}='22 HRS GMT';
        TimeSlices{24,1}='23 HRS GMT';
        [iTimeS,~] = listdlg('PromptString',{'Select a Time Slice For Most Studies'},...
        'SelectionMode','single','ListString',TimeSlices,'ListSize',[360,300]);
        a1=isempty(iTimeS);
         if(a1==1)
            iTimeSlice=2;
         else
            iTimeSlice=iTimeS;
         end
         HourValue=iTimeSlice-1;
         MinValue=0;
         SecValue=0;
 % Now start looping thru the selected files
       eval(['cd ' moviepath(1:length(moviepath)-1)]);
%       TempMovieName='ArcticIce';
       vTemp4A = VideoWriter(TempMovieName4A,'MPEG-4');
       vTemp4A.Quality=100;
       vTemp4A.FrameRate=3;
       open(vTemp4A);
       vTemp4B = VideoWriter(TempMovieName4B,'MPEG-4');
       vTemp4B.Quality=100;
       vTemp4B.FrameRate=3;
       open(vTemp4B);
       vTemp30 = VideoWriter(TempMovieName30,'MPEG-4');
       vTemp30.Quality=100;
       vTemp30.FrameRate=3;
       open(vTemp30);
       framecounter=0;
        for nn=1:numSelectedFiles
            nowFile=Merra2FileNames{nn,1}; 
            framecounter=framecounter+1;
            ReadDataset04(nowFile,nowpath)
            dispstr=strcat('Finished Processing File-',nowFile,'-which is file-',num2str(nn),...
                '-of-',num2str(numSelectedFiles),'-Files');
            disp(dispstr)
        end
         close(vTemp4A);
         close(vTemp4B);
         close(vTemp30);
    igo=0;
    elseif(indx==7)
        ReadDataset07() 
    elseif(indx==8)% M2TMNXRAD_5.12.4
        [Merra2FileNames,nowpath] = uigetfile('*.nc4','Select Multiple Files', ...
        'MultiSelect', 'on');
        Merra2FileNames=Merra2FileNames';
        numSelectedFiles=length(Merra2FileNames);
        [NewFileList] = SortMonthlyFilesInTimeOrder(Merra2FileNames);
        Merra2FileNames=NewFileList;
        profile on
        fprintf(fid,'\n');
        fprintf(fid,'%s\n','----- List of Files to Be processed-----');
        for nn=1:numSelectedFiles
            nowFile=Merra2FileNames{nn,1};
            filestr='File Num';
            fprintf(fid,'%s\n',nowFile);
        end
        fprintf(fid,'%s\n','----- End List of Files to Be processed-----');
        framecounter=0;
        testFile=Merra2FileNames{1,1};
        testFileEnd=Merra2FileNames{numSelectedFiles,1};
        [iper]=strfind(testFile,'.');
        is=iper(2)+1;
        ie=iper(3)-1;
        if(iMovie>0)
            YearMonthStr=testFile(is:ie);
            YearMonthStrStart=YearMonthStr;
            YearMonthStrEnd=testFileEnd(is:ie);
            TempMovieName=strcat('Albedo-',YearMonthStr,'-Fr-',num2str(numSelectedFiles),'.mp4');
            TempMovieName17=strcat('LWGNT-',YearMonthStr,'-Fr-',num2str(numSelectedFiles),'.mp4');
            TempMovieName34=strcat('TauHigh-',YearMonthStr,'-Fr-',num2str(numSelectedFiles),'.mp4');
            eval(['cd ' moviepath(1:length(moviepath)-1)]);
            vTemp = VideoWriter(TempMovieName,'MPEG-4');
            vTemp.Quality=100;
            vTemp.FrameRate=3;
            open(vTemp);
            vTemp17 = VideoWriter(TempMovieName17,'MPEG-4');
            vTemp17.Quality=100;
            vTemp17.FrameRate=2;
            open(vTemp17);
            vTemp34 = VideoWriter(TempMovieName34,'MPEG-4');
            vTemp34.Quality=100;
            vTemp34.FrameRate=3;
            open(vTemp34);
        end
        ab=1;
        for nn=1:numSelectedFiles
            nowFile=Merra2FileNames{nn,1};
            framecounter=framecounter+1;
            dispstr=strcat('Now Reading File-',nowFile,'-which is file#',num2str(nn),'-of-',num2str(numSelectedFiles),'-Total Files');
            disp(dispstr)
            ReadMonthlyMeanRadDiagnostics(nowFile,nowpath) 
        end
        if(iMovie>0)
            close(vTemp);
            close(vTemp17);
            close(vTemp34);
        end
 % Plot TimeTables Specific to this item
 % Start with the Surface Albedo
    titlestr=strcat('Monthly-Averaged-SurfaceAlebedo-',num2str(yd));
    ikind=1;
    iAddToReport=1;
    iNewChapter=1;
    iCloseChapter=0;
    PlotAlebedoTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Surface Albedo Near IR Diffuse Data
    titlestr=strcat('Monthly-Averaged-SurfaceNIRAlebedo-',num2str(yd));
    ikind=2;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotAlebedoNIRDTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter);
 % Continue with the Surface Albedo Near IR Beam Data
    titlestr=strcat('Monthly-Averaged-SurfaceNIRAlebedo-',num2str(yd));
    ikind=3;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotAlebedoNIRDRTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter);
 % Continue with the Surface Albedo Visible Diffuse Data
    titlestr=strcat('Monthly-Averaged-SurfaceVisDiff-',num2str(yd));
    ikind=4;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotAlebedoVisDiffuseTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Surface Albedo Visible Beam Data
    titlestr=strcat('Monthly-Averaged-SurfaceVisDiff-',num2str(yd));
    ikind=5;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotAlebedoVisBeamTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the High Cloud Fraction
    titlestr=strcat('Monthly-Averaged-HighCloudFraction-',num2str(yd));
    ikind=6;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotHighCloudTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Low Cloud Fraction
    titlestr=strcat('Monthly-Averaged-LowCloudFraction-',num2str(yd));
    ikind=7;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLowCloudTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Mid Cloud Fraction
    titlestr=strcat('Monthly-Averaged-MidCloudFraction-',num2str(yd));
    ikind=8;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotMidCloudTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Total Cloud Fraction
    titlestr=strcat('Monthly-Averaged-TotalCloudFraction-',num2str(yd));
    ikind=9;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotTotalFracCloudTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Longwave Surface Absorption
    titlestr=strcat('Monthly-Averaged-LW-SurfaceAbs-',num2str(yd));
    ikind=13;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWGABTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Longwave Surface Absorption For Clear Sky
    titlestr=strcat('Monthly-Averaged-LW-SurfaceAbs-CLR',num2str(yd));
    ikind=14;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWGABCLRTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  % Continue with the Longwave Surface Absorption For Clear Sky No Aerosol
    titlestr=strcat('Monthly-Averaged-LW-SurfaceAbs-CLR',num2str(yd));
    ikind=15;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWGABCLRCLNTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Longwave Surface emitted from surface (LWGEM)
    titlestr=strcat('Monthly-Averaged-LW-Surface-Flux-',num2str(yd));
    ikind=16;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWGEMTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Longwave Surface Net Downwards flux (LWGNT)
    titlestr=strcat('Monthly-Averaged-LW-Surface-Flux-',num2str(yd));
    ikind=17;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWGNTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Longwave Surface Net Downwards Clear Skyflux (LWGNT)
    titlestr=strcat('Monthly-Averaged-LW-Surface-Flux-',num2str(yd));
    ikind=18;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWGNTCLRTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Longwave Surface Net Downwards Clear Skyflux/No Aerosol (LWGNT)
    titlestr=strcat('Monthly-Averaged-LW-Surface-Flux-',num2str(yd));
    ikind=19;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWGNTCLRCLNTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the LW upwelling flux at TOA (LWTUP)
    titlestr=strcat('Monthly-Averaged-LW-Uowelling-Flux-',num2str(yd));
    ikind=20;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWUPTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the LW upwelling flux at TOA (LWTUPCLR)
    titlestr=strcat('Monthly-Averaged-LW-Upwelling-ClearSky-Flux-',num2str(yd));
    ikind=21;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWUPTCLRTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the LW upwelling flux at TOA (LWTUPCLRCLN)
    titlestr=strcat('Monthly-Averaged-LW-Upwelling-ClearSky-No-Aero-Flux-',num2str(yd));
    ikind=22;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotLWUPTCLRCLNTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the surface incoming short wave flux (SWGDN)
    titlestr=strcat('Monthly-Averaged-Surface-Incoming-SW-Flux-',num2str(yd));
    ikind=23;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWDGNTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the surface incoming short wave flux (SWGNT)
    titlestr=strcat('Monthly-Averaged-SW-DownwardsFlux--',num2str(yd));
    ikind=25;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWGNTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the surface incoming short wave flux with no aerosol (SWGNTCLN)
    titlestr=strcat('Monthly-Averaged-SW-DownwardsFlux-NoAero-',num2str(yd));
    ikind=26;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWGNCLNTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the surface incoming short wave flux and a clear sky (SWGNTCLR)
    titlestr=strcat('Monthly-Averaged-SW-DownwardsFlux-ClearSky-',num2str(yd));
    ikind=27;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWGNCLRTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the surface incoming short wave flux and a clear sky /No Aero (SWGNTCLRCLN)
    titlestr=strcat('Monthly-Averaged-SW-DownwardsFlux-ClearSky-NoAero',num2str(yd));
    ikind=28;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWGNCLRCLNTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Toa Incoming Shortwave Flux
    titlestr=strcat('Monthly-Averaged-TOA-IncomingSW-Flux-',num2str(yd));
    ikind=29;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWDTNTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Toa Net Shortwave Flux
    titlestr=strcat('Monthly-Averaged-TOA-NetSW-Flux-',num2str(yd));
    ikind=30;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWTNTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Toa Net Shortwave Flux No Aero
    titlestr=strcat('Monthly-Averaged-TOA-NetSW-Flux-NoAero',num2str(yd));
    ikind=31;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWTNTCLNTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Toa Net Shortwave Flux Clear Sky
    titlestr=strcat('Monthly-Averaged-TOA-NetSW-Flux-ClearSky',num2str(yd));
    ikind=32;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWTNTCLRTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  % Continue with the Toa Net Shortwave Flux Clear Sky/No Aero Table
    titlestr=strcat('Monthly-Averaged-TOA-NetSW-Flux-ClearSky-No-Aero',num2str(yd));
    ikind=33;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotSWTNTCLRCLNTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the High Cloud Optical Thickness
    titlestr=strcat('Monthly-Averaged-HighCloud-Optical-Thickness-',num2str(yd));
    ikind=34;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotTAUHGHTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)% Check this
 % Continue with the Low Cloud Optical Thickness
    titlestr=strcat('Monthly-Averaged-LowCloud-Optical-Thickness-',num2str(yd));
    ikind=35;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotTAULOWTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Mid Cloud Optical Thickness
    titlestr=strcat('Monthly-Averaged-MidCloud-Optical-Thickness-',num2str(yd));
    ikind=36;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotTAUMIDTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  % Continue with the Tot Cloud Optical Thickness
    titlestr=strcat('Monthly-Averaged-TotCloud-Optical-Thickness-',num2str(yd));
    ikind=37;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    PlotTAUTOTTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  % Continue with the T Skin
    titlestr=strcat('Monthly-Averaged-Skin-Temp-',num2str(yd));
    ikind=39;
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=1;
    PlotTSTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Save CorrelationSummaryFile    
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='RCOEFFHist RCOEFFLabels';
    MatFileName=strcat('Dataset8-Correlations',YearMonthStrStart,'-',YearMonthStrEnd,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    corrstr=strcat('Created Dataset8 Correlation Table-','Contains Correlation Data For 5 Variables-');
    fprintf(fid,'%s\n',corrstr);
 %% Write Correlation file to Logfile
 % Now pick out one frame of data 
    for mm=1:numSelectedFiles
        RCOEFF(:,:)=RCOEFFHist(:,:,mm);
        labelstr=strcat(RCOEFFLabels{1,1},'----',RCOEFFLabels{2,1},'----',...
            RCOEFFLabels{3,1},'------',RCOEFFLabels{4,1},'-----',RCOEFFLabels{5,1},'-----',...
            RCOEFFLabels{6,1},'------',RCOEFFLabels{7,1},'-----',RCOEFFLabels{8,1});
        blankstr='*******';
        idstr=strcat('Correlation File for Month-',num2str(mm,2));
        fprintf(fid,'%s\n',idstr);
        fprintf(fid,'%s %s\n',blankstr,labelstr);
        for ii=1:8
            fprintf(fid,'%6s',RCOEFFLabels{ii,1});
            fprintf(fid,'%+8.4f  %+8.4f  %+8.4f  %+8.4f %+8.4f  %+8.4f  %+8.4f  %+8.4f\n',RCOEFF(ii,1),RCOEFF(ii,2),RCOEFF(ii,3),RCOEFF(ii,4),RCOEFF(ii,5),...
                RCOEFF(ii,6),RCOEFF(ii,7),RCOEFF(ii,8));
        end
    end
    fprintf(fid,'\n');
    igo=0;
    elseif(indx==9)
        isavefiles=2;
        iCityPlot=0;
        ReadDailyCOTData()
    elseif(indx==10)
        isavefiles=2;
        iCityPlot=0;
        TempMovieName='COT1DayDataSep2019.mp4';
        eval(['cd ' moviepath(1:length(moviepath)-1)]);
        vTemp = VideoWriter(TempMovieName,'MPEG-4');
        vTemp.Quality=100;
        vTemp.FrameRate=3;
        open(vTemp);
        eval(['cd ' Merra2Path(1:length(Merra2Path)-1)]);
        [SelectedFiles,path1]=uigetfile('*nc4','Select Many Data Files',...
            'MultiSelect', 'on');
        SelectedFiles=SelectedFiles';
        numSelectedFiles=length(SelectedFiles);
        dispstr=strcat('Open movie=',TempMovieName,'-which will have-',num2str(numSelectedFiles),'-Frames');
        disp(dispstr)
 % Print out list of files to analyze
        fprintf(fid,'\n');
        fprintf(fid,'%s\n','*****List Of Files to Process*****');
        for kk=1:numSelectedFiles
            nowFile=SelectedFiles{kk,1};
            fprintf(fid,'%s\n',nowFile);
        end
        fprintf(fid,'%s\n','*****EndList Of Files to Process*****');
        for mx=1:numSelectedFiles
            framecounter=framecounter+1;
            nowFile=SelectedFiles{mx,1};
            nc_filenamesuf=nowFile;
            Merra2FileName=nc_filenamesuf;
            Merra2FileName=RemoveUnderScores(Merra2FileName);
            nc_filename=strcat(path1,nc_filenamesuf);
            disp('****************');
            dispstr=strcat('Now processing file-',Merra2FileName,'-which is file-',num2str(mx),'-of-',num2str(numSelectedFiles));
            disp(dispstr)
            ReadDailyCOTDataTo1Day(nc_filename); 
            disp('****************');
        end
        close(vTemp);
        dispstr=strcat('Finished creating movie=',TempMovieName,'-which had-',num2str(numSelectedFiles),'-Frames');
        disp(dispstr)
        igo=0;
    elseif(indx==11)
        eval(['cd ' Merra2Path(1:length(Merra2Path)-1)]);
        [SelectedFiles,path1]=uigetfile('*.mat','Select Many Data Files',...
            'MultiSelect', 'on');
        SelectedFiles=SelectedFiles';
        numSelectedFiles=length(SelectedFiles);
        ab=1;
        TauCliMeansArray=zeros(numSelectedFiles,5);
        for n=1:numSelectedFiles
            nowFile=SelectedFiles{n,1};
            dispstr=strcat('Now Processing File-',nowFile);
            disp(dispstr);
            [iper]=strfind(nowFile,'.');
            is=iper(2)+1;
            ie=iper(3)-1;
            YearMonthDayStr=nowFile(is:ie);
            ymd=str2double(YearMonthDayStr);
            monthnum=str2double(YearMonthDayStr(5:6));
            [monthstr] = ConvertMonthNumToStr(monthnum);
            yearstr=YearMonthDayStr(1:4);
            daystr=YearMonthDayStr(7:8);
            year=str2double(yearstr);
            day=str2double(daystr);
            if(n==1)
                stime=datetime(year,monthnum,day);
                timestep=caldays(1);
            end
            MatFileName=strcat(monthstr,'-',yearstr,'-MeanCOTvsDate.mat');
            load(nowFile)
            for k=1:4
                TauData(:,:)=TauCliSel1Day(:,:,k);
                [ihigh,jhigh]=find(TauData>0);
                numhigh=length(ihigh);
                ArrayVals=zeros(numhigh,1);
                for mm=1:numhigh
                    nrow=ihigh(mm,1);
                    ncol=jhigh(mm,1);
                    ArrayVals(mm,1)=TauData(nrow,ncol);
                    meanVal=mean(ArrayVals);                   
                end
                TauCliMeansArray(n,k+1)=meanVal;

            end
            TauCliMeansArray(n,1)=n;
        end
        MeansTable=table(TauCliMeansArray(:,1),TauCliMeansArray(:,2),TauCliMeansArray(:,3),...
            TauCliMeansArray(:,4),TauCliMeansArray(:,5),...
            'VariableNames',{'Day Of Month','200hPA','300hPA','400hPA','500hPA'});
        MeansTimeTable = table2timetable(MeansTable,'TimeStep',timestep,'StartTime',stime);
        eval(['cd ' savepath(1:length(savepath)-1)]);
        actionstr='save';
        varstr='MeansTable MeansTimeTable';
        qualstr='-v7.3';
        [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
        eval(cmdString)
        dispstr=strcat('Wrote Matlab File-',MatFileName);
        disp(dispstr);

        igo=0;

    elseif(indx==78)
        [selpath]=uigetdir(prefpath,'Select One Folder to set path');
        [islash]=strfind(selpath,'\');
        numslash=length(islash);
        selpathlen=length(selpath);
        is=1;
        ie=islash(3);
        baseimagepath=selpath(is:ie);
        if(numslash==3)
           is=ie+1;
           ie=selpathlen;
           selectedImageFolder=selpath(is:ie);
        elseif(numslash>3)
            ab=2;
            is=ie+1;
            ie=islash(4)-1;
            selectedImageFolder=selpath(is:ie);
        end
        SetImageFoldersRev1()
        ab=1;
    end

end
%% Plot Selected TimeTables
%% Print out the File Timing Info
if((iPrintTimingInfo==1) && (framecounter>2) && (NumProcFiles>3))
    fprintf(fid,'%s\n','Print Out Saved Jpeg File Data');
    for k=1:NumProcFiles
        str1=char(ProcFileList{1+k,1});
        str2=char(ProcFileList{1+k,2});
        timeval=ProcFileList{1+k,3};
        str4=char(ProcFileList{1+k,4});
        fprintf(fid, '%s   %s   %',str1,str2);
        fprintf(fid,'%8.2f',timeval);
        fprintf(fid,'  %14s\n',str4);
    end
end
%% Run closeout
endruntime=deblank(datestr(now));
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