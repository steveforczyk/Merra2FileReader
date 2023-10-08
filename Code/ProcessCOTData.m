% This script will be the executive routine to create timeseries plots
% for 67 available minths of COT Data
% data from a Welch Array of PSD data according to sensor site and time 
%
% Created: Oct 27,2022 
% Written By: Stephen Forczyk
% Revised: -------
% Classification:Unclassified
%
global Year Month Day Hr Minutes Seconds SiteName SiteCharName;
global FileYear FileMonth FileDay FileHour FileMinutes FileSeconds;
global HighCOTData timevals COTThresh;

global fid fid2 fid3;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global outputpath outputfile jpegpath;

% Set up System Data
outputpath='K:\Merra-2\netCDF\Dataset08\Matlab_Files\';
outputfile='COTData2017Thru2022.mat';
jpegpath='K:\Merra-2\netCDF\Dataset08\Jpeg_Files\';
% Set values for selected variables
timevals=cell(67,1);
timevals{1,1}='03/31/17';
timevals{2,1}='04/30/17';
timevals{3,1}='05/31/17';
timevals{4,1}='06/30/17';
timevals{5,1}='07/31/17';
timevals{6,1}='08/31/17';
timevals{7,1}='09/30/17';
timevals{8,1}='10/31/17';
timevals{9,1}='11/30/17';
timevals{10,1}='12/31/17';
timevals{11,1}='01/31/18';
timevals{12,1}='02/28/18';
timevals{13,1}='03/31/18';
timevals{14,1}='04/30/18';
timevals{15,1}='05/31/18';
timevals{16,1}='06/30/18';
timevals{17,1}='07/31/18';
timevals{18,1}='08/31/18';
timevals{19,1}='09/30/18';
timevals{20,1}='10/31/18';
timevals{21,1}='11/30/18';
timevals{22,1}='12/31/18';
timevals{23,1}='01/31/19';
timevals{24,1}='02/28/19';
timevals{25,1}='03/31/19';
timevals{26,1}='04/30/19';
timevals{27,1}='05/31/19';
timevals{28,1}='06/30/19';
timevals{29,1}='07/31/19';
timevals{30,1}='08/31/19';
timevals{31,1}='09/30/19';
timevals{32,1}='10/31/19';
timevals{33,1}='11/30/19';
timevals{34,1}='12/31/19';
timevals{35,1}='01/31/20';
timevals{36,1}='02/29/20';
timevals{37,1}='03/31/20';
timevals{38,1}='04/30/20';
timevals{39,1}='05/31/20';
timevals{40,1}='06/30/20';
timevals{41,1}='07/31/20';
timevals{42,1}='08/31/20';
timevals{43,1}='09/30/20';
timevals{44,1}='10/31/20';
timevals{45,1}='11/30/20';
timevals{46,1}='12/31/20';
timevals{47,1}='01/31/21';
timevals{48,1}='02/28/21';
timevals{49,1}='03/31/21';
timevals{50,1}='04/30/21';
timevals{51,1}='05/31/21';
timevals{52,1}='06/30/21';
timevals{53,1}='07/31/21';
timevals{54,1}='08/31/21';
timevals{55,1}='09/30/21';
timevals{56,1}='10/31/21';
timevals{57,1}='11/30/21';
timevals{58,1}='12/31/21';
timevals{59,1}='01/31/22';
timevals{60,1}='02/28/22';
timevals{61,1}='03/31/22';
timevals{62,1}='04/30/22';
timevals{63,1}='05/31/22';
timevals{64,1}='06/30/22';
timevals{65,1}='07/31/22';
timevals{66,1}='08/31/22';
timevals{67,1}='09/30/22';
COTThresh=3;
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
timevals=cell(67,1);
% Set a specific color order
set(0,'DefaultAxesColorOrder',[1 0 0;
    1 1 0;0 1 0;0 0 1;0.75 0.50 0.25;
    0.5 0.75 0.25; 0.25 1 0.25;0 .50 .75]);
% Set up some defaults for a PowerPoint presentationwhos
scaling='true';
stretching='false';
padding=[75 75 75 75];
igrid=1;
% Set up paramaters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datestr(now);
igo=1;
% Load the original Data file
eval(['cd ' outputpath(1:length(outputpath)-1)]);
load(outputfile,'HighCOTData');
dispstr=strcat('Loaded Data From COT Data file-',outputfile);
disp(dispstr);
[nrowsp,ncols]=size(HighCOTData);
% First set up a timeseries for the Rasters above threshold
data1=HighCOTData.NumberOfRasters;
ts1 = timeseries(data1,1:67);
ts1.Name='Number COT Rasters Above Threshold';
ts1.TimeInfo.Units = 'months';
ts1.TimeInfo.StartDate = '31-Mar-2017';
ts1.TimeInfo.Format = 'mmm dd, yy'; 
ts1.Time = ts1.Time - ts1.Time(1); 
figstr='MonthlyAveragedHighCOTRasters-2017-2022.jpg';
vartextstr='-Plot Shows Number of Rasters That Exceeded COT Threshold';
PlotTimeSeriesRasterCount(ts1,figstr,vartextstr)
% Second set up a timeseries for the Area if the high rasters in millions
% of sq km
data2=HighCOTData.CoveredArea/1E6;
ts2 = timeseries(data2,1:67);
ts2.Name='Area Sum COT Rasters Above Threshold-Millions Of Sq Km';
ts2.TimeInfo.Units = 'months';
ts2.TimeInfo.StartDate = '31-Mar-2017';
ts2.TimeInfo.Format = 'mmm dd, yy'; 
ts2.Time = ts1.Time - ts1.Time(1); 
ab=1;
figstr='MonthlyAveragedCOTRasterAreasSum-2017-2022.jpg';
vartextstr='-Plot Shows Sum Of Areas Of Rasters That Exceeded Threhsold-millions-sqkm';
PlotTimeSeriesRasterCount(ts2,figstr,vartextstr)
% Finally set up a timeseries for the fraction of the earth area covered by
% the high rasters

data3=HighCOTData.FractionOfEarth;
ts3 = timeseries(data3,1:67);
ts3.Name='COT Rasters Above Threshold-Fraction Of Earth Surface';
ts3.TimeInfo.Units = 'months';
ts3.TimeInfo.StartDate = '31-Mar-2017';
ts3.TimeInfo.Format = 'mmm dd, yy'; 
ts3.Time = ts1.Time - ts1.Time(1); 
vartextstr='-Plot Shows fraction of earth area covered by high COT rasters';
figstr='MonthlyAveragedCOTFractionOfEarthArea-2017-2022.jpg';
PlotTimeSeriesRasterCount(ts3,figstr,vartextstr)

ab=2;
