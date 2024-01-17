% This script will create a File that has the Pressure Height versus
% actual height based on Standard atmosphere model

% Written By: Stephen Forczyk
% Created: Nov 14,2023
% Revised: -----

% Classification: Unclassified/Public Domain
global EnhancedPressureLevel42 EnhancedPressureLevel72;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath jpegpath;

% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;

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
logpath='H:\Goes16\Imagery\Oct22_2017\Log_Files\'; %This really needs to be set later!!!

%% Read Some needed data files related to calendar data and selected shape file names as well as pressure levels
% Load in the Pressure data vs Level
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
load(PressureFileName);
[nrows42,ncols42]=size(PressureLevel42);
EnhancedPressureLevel42=zeros(nrows42,4);
z=1000*PressureLevel42(:,3);
[rho,a,T,P,nu,h,sigma] = atmos(z,'Units','SI');
for n=1:nrows42
    EnhancedPressureLevel42(n,1)=PressureLevel42(n,1);
    EnhancedPressureLevel42(n,2)=PressureLevel42(n,2);
    EnhancedPressureLevel42(n,3)=PressureLevel42(n,3);
    EnhancedPressureLevel42(n,4)=rho(n);
end
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
%% Now plot the key Standard Atmosphere data
titlestr='StandardAtmosphere-PressureVsDensity';
PlotKeyStandardAtmosphereData(titlestr)
