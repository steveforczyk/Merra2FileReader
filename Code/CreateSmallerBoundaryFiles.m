% This script will reduce the point count of a boundary file
% In this case every n'th point will be deleted unless it is a nan

% Written By: Stephen Forczyk
% Created: Jan 26,2023
% Revised: Feb 29,2024 performed workfor other countries
% Classification: Unclassified

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;

global matpath GOES16path;
global jpegpath tiffpath moviepath figpath;
global excelpath ascpath combinedpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath dtedpath;
global jpegpath northamericalakespath logpath pdfpath govjpegpath;
global NSIDCDataPaths datapath NSIDCFileName tablepath reducedpath;

global shapefilepath Countryshapepath figpath;
global mappath gridpath countyshapepath nationalshapepath summarypath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
global baseimagepath selectedImageFolder prefpath;
global pwd;
matlabpath='K:\NSDIC\Matlab_Data\';
mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
dtedpath='F:\DTED\';
CalendarFileName='CalendarDays.mat';
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
antarcticpath='K:\NSDIC\Map_Data\Antarctica\';
antarcticshapefile='yk702xd7587.shp';
jpegpath='K:\NSDIC\Sea_Ice\NSIDC0116\North\Jpeg_Files\';
figpath='K:\NSDIC\Sea_Ice\NSIDC0116\North\Fig_Files\';
logpath='K:\NSDIC\Sea_Ice\NSIDC0116\North\Log_Files\'; %This really needs to be set later!!!
summarypath='D:\Goes16\Summary_Files\';
tiffpath='D:\Forczyk\Map_Data\InterstateSigns\';
Countryshapepath='D:\Forczyk\Map_Data\CountryShapefiles\';
gridpath='K:\NSDIC\Sea_Ice\NSIDC0116\North\Grids\';
combinedpath='K:\NSDIC\Sea_Ice\NSIDC0051\Combined_Files\';
tablepath='K:\NSDIC\Sea_Ice\NSIDC0051\MonthlyAverageTables\';
reducedpath='K:\NSDIC\Map_Data\MatlabMapsR\';
%% Set Flags and Start Values for Variables
% Set some flags to control program execution
nfilter=4;
iDaily=0;
iWeekly=0;
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


load('FinlandBoundaries.mat','FinlandLat','FinlandLon')
ReducedFileName='FinlandBoundariesRed4.mat';
[nrows,ncols]=size(FinlandLat);
if(ncols>nrows)
    FinlandLat=FinlandLat';
    FinlandLon=FinlandLon';
end
numfullpoints=length(FinlandLat);
numretain=0;
fullnancount=sum(isnan(FinlandLat));
for n=1:numfullpoints
    nowVal=FinlandLat(n,1);
    a1=isnan(nowVal);
    R1=mod(n,nfilter);
    if(a1==1)
        numretain=numretain+1;
    elseif((R1~=0) && (a1==0))
        numretain=numretain+1;
    end
end
FinlandLatR=zeros(numretain,1);
FinlandLonR=zeros(numretain,1);
numretain2=0;
for n=1:numfullpoints
    nowVal1=FinlandLat(n,1);
    nowVal2=FinlandLon(n,1);
    a1=isnan(nowVal1);
    R1=mod(n,nfilter);
    if(a1==1)
        numretain2=numretain2+1;
        FinlandLatR(numretain2,1)=NaN;
        FinlandLonR(numretain2,1)=NaN;
    elseif((R1~=0) && (a1==0))
        numretain2=numretain2+1;
        FinlandLatR(numretain2,1)=nowVal1;
        FinlandLonR(numretain2,1)=nowVal2;
    end
end
ab=1;
eval(['cd ' reducedpath(1:length(reducedpath)-1)]);
reducednancount=sum(isnan(FinlandLatR));
FinlandLat=FinlandLatR;
FinlandLon=FinlandLonR;
% save the data to a file
actionstr='save';
varstr='FinlandLat FinlandLon numfullpoints numretain2 nfilter reducednancount fullnancount';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,ReducedFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Reduced Boundaries To File -',ReducedFileName);
disp(dispstr);
ab=2;