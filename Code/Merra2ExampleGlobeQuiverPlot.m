% This script is intended to test attempt to use the mapping example 3 in
% the globe quiver routine to plot the wind vectors over the earth for the
% Merra-2 data
% This script cocentrates on running the examples in the CDT tollbox 
% globe quiver

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;

global codepath mappath jpegpath savepath matpath;

codepath='K:\Merra-2\Code5\Code\';
mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
jpegpath='K:\Merra-2\netCDF\Dataset04\Jpeg_Files_CDT\';
savepath='K:\Merra-2\netCDF\Dataset04\';
matpath='K:\Merra-2\netCDF\Dataset04\Matlab_Files\';
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
chart_time=5;
% Load the data from the Merra2 run
FileName='PartialFile-19800101.mat';
eval(['cd ' matpath(1:length(matpath)-1)]);
load(FileName);
lat=Lats';
lon=Lons;
[lat,lon] = meshgrid(lat,lon);
ab=1;
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
globepcolor(lat,lon,TAirTempC)
globeborders('color',rgb('red'))
cmocean('balance','pivot')
q = globequiver(lat,lon,U10,V10,'density',100,'k');
axis tight
clear all
clc
