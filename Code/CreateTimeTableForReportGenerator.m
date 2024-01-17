% This script will test creating a table that can be used in the Report
% generator that is really a timeseries

% Created: June 17,2023
% Written By: Stephen Forczyk
% Revised: -----
% Classification: Unclassified/Public Domain
global TableName;
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
global yd md dd;
global pwd;
global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
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
%mappath='F:\Forczyk\Map_Data\Matlab_Maps\';
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
tablepath='K:\Merra-2\netCDF\Dataset02\Spare_Tables\';
jpegpath='D:\Goes16\Imagery\Aug26_2020\Jpeg_Files\';
pdfpath='K:\Merra-2\PDF_Reports\';
govjpegpath='K:\Merra-2\gov_jpeg\';
figpath='D:\Goes16\Imagery\Oct_FigFiles\';
logpath='H:\Goes16\Imagery\Oct22_2017\Log_Files\'; %This really needs to be set later!!!
tiffpath='D:\Forczyk\Map_Data\InterstateSigns\';
Countryshapepath='D:\Forczyk\Map_Data\CountryShapefiles\';
gridpath='D:\Goes16\Grids\';
%% Set Flags and default values
% Set some flags to control program execution
iCreatePDFReport=1;
JpegCounter=0;
isavefiles=0;
idebug=0;
ifixedImagePaths=1;
iMovie=0;
TableName='BCEMBBTable19800110-5.mat';

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
%% Load in a stored table
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load(TableName)
TestRight=table2array(BCEMBBTable);
LeftCol= char(BCEMBBTT.Properties.RowTimes);
% Now convert the Left Column to a cell
[nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
Years=zeros(nrows,1);
Months=zeros(nrows,1);
Days=zeros(nrows,1);
for n=1:nrows
    nowStr=LeftCol(n,1:ncols);
    idash=strfind(nowStr,'-');
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
ab=2;
Col1=BCEMBBTable.BCEMBB10;
Col2=BCEMBBTable.BCEMBB25;
Col3=BCEMBBTable.BCEMBB50;
Col4=BCEMBBTable.BCEMBB75;
Col5=BCEMBBTable.BCEMBB90;
Col6=BCEMBBTable.BCEMBB100;
ab=2;
myCellArray=cell(nrows,6);
myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
ab=3;
T = array2table(myArray,...
    'VariableNames',{'Years','Months','Days','Col1','Col2','Col3','Col4','Col5','Col6'});
Hdrs=cell(1,9);
Hdrs{1,1}='Years';
Hdrs{1,2}='Months';
Hdrs{1,3}='Days';
Hdrs{1,4}='BCEMBB10';
Hdrs{1,5}='BCEMBB25';
Hdrs{1,6}='BCEMBB50';
Hdrs{1,7}='BCEMBB75';
Hdrs{1,8}='BCEMBB90';
Hdrs{1,9}='BCEMBB100';
for i=1:nrows
    for j=1:6
        myCellArray{i,j}=myArray(i,j+3);
    end

end

ab=4;
% LeftCell=cell(nrows,1);
% for i=1:nrows
%     LeftStr=LeftCol(i,1);
%     for j=2:ncols
%         LeftStr=strcat(LeftStr,LeftCol(i,j));
%         ab=2;
%     end
%     LeftCell{i,1}=LeftStr;
% end
% ab=1;
% [myTable]=[LeftCell,TestRight];
ab=3;
