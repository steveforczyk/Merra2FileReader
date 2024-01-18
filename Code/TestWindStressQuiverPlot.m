% This executive script is to test the creation of a windStress Quiver plot
% Created: Nov 13,2023
% Written By: Stephen Forczyk
% Revised: 

% Classification: Unclassified/Public Domain
%% Set Up Globals
global MatFileName;
global BandDataS MetaDataS;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons COThighlimit;
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
global Merra2WorkingSeaMask1 Merra2WorkingSeaMask2 Merra2WorkingSeaMask3;
global Merra2WorkingSeaMask4 Merra2WorkingSeaMask5;


global Merra2DataPaths Merra2Path MerraDataCollectionTimes;
global CountyBoundaryFile;
global CountyBoundaries StateFIPSFile;
global StateFIPSCodes NationalCountiesShp;
global USAStatesShapeFileList USAStatesFileName;
global UrbanAreasShapeFile NorthAmericaLakes ;
global idebug isavefiles ;

global NumProcFiles ProcFileList iPrintTimingInfo iSkipReportFrames;
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
global numtimeslice;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;


global matpath datapath maskpath watermaskpath oceanmappath;
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
global mappath gridpath countyshapepath nationalshapepath codepath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
global yd md dd;
global pwd;
global HS10 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S10 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;
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
govjpegpath='K:\Merra-2\gov_jpeg\';
jpegpath='K:\Merra-2\netCDF\Dataset03\Jpeg_Files\';
pdfpath='K:\Merra-2\netCDF\Dataset03\PDF_Files\';
logpath='K:\Merra-2\netCDF\Dataset03\Log_Files\';
moviepath='K:\Merra-2\netCDF\Dataset03\Movies\';
savepath='K:\Merra-2\netCDF\Dataset03\Matlab_Files\';  
oceanmappath='K:\Merra-2\Matlab_Maps_Oceans\';
MatFileName='WindstressData-1.mat ';
%% Set Flags and default values
% Set some flags to control program execution
iCreatePDFReport=0;
iSkipReportFrames=8;
JpegCounter=0;
isavefiles=0;
idebug=0;
ifixedImagePaths=1;
isaveJpeg=1; % Set to 0 to not save jpegs (not recommended),1=print to save (slow)
% 2= Quick save using screencapture (recommended)


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

%Load in the saved data
eval(['cd ' savepath(1:length(savepath)-1)]);
load(MatFileName);
ab=1;
%% Create Figure For Windstress data
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gca,'XLim',[-200 200],'YLim',[-90 90]);
plot(coastlon,coastlat,'r');
hold on
quiversc(RasterLons,RasterLats,Taux,Tauy,'b');
pause(5)
close('all');
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
%worldmap('World')
load coastlines
% plotm(coastlat,coastlon,'g');
% hold on
axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[-90 90],...
 'MapLonLimit',[-180 180],'meridianlabel','on','parallellabel','on','plabellocation',15,'mlabellocation',30,...
 'MLabelParallel','south','GColor',[1 1 0],'GLineWidth',1);
quiversc(RasterLons,RasterLats,Taux,Tauy,'b');
hold on
plotm(coastlat,coastlon,'g');


