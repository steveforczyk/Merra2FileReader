% This script is intended to test certain mapping tasks based on the 
% Climate Data Toolbox in oder to apply them to the Merra2 datasets
% This script cocnetrates on running the examples in the CDT tollbox 
% globe quiver

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;

global codepath mappath jpegpath savepath;

codepath='K:\Merra-2\Code5\Code\';
mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
jpegpath='K:\Merra-2\netCDF\Dataset04\Jpeg_Files_CDT\';
savepath='K:\Merra-2\netCDF\Dataset04\';
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
%% work the Globeborders examples
% Start with example Globequiver ex01
titlestr='Globequiver-Ex01';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
[lat,lon] = cdtgrid(10);
u = zeros(size(lat));
v = ones(size(lat));
globequiver(lat,lon,u,v)
globefill
axis tight
ht=title(titlestr);
pause(chart_time)
% Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
% Continue with example 2- plot red eastwards arrows on the globe
titlestr='Globequiver-Ex02';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
[lat,lon] = cdtgrid(10);
u = ones(size(lat));
v = zeros(size(lat));
globequiver(lat,lon,u,v,'r')
globefill
axis tight
ht=title(titlestr);
pause(chart_time)
% Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all')
% Continue with example 3
titlestr='Globequiver-Ex03';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
filename = 'ERA_Interim_2017.nc';
u10 = ncread(filename,'u10'); % 10 metre U wind component
v10 = ncread(filename,'v10'); % 10 metre V wind component
sp = ncread(filename,'sp'); % surface pressure
T = ncread(filename,'t2m'); % 2 metre temperature
lat = double(ncread(filename,'latitude'));
lon = double(ncread(filename,'longitude'));
% Calculate anomalies for January:
mo = 1;
Ta = T(:,:,mo)-mean(T,3);
spa = sp(:,:,mo)-mean(sp,3);
ua = u10(:,:,mo) - mean(u10,3);
va = v10(:,:,mo) - mean(v10,3);
[lat,lon] = meshgrid(lat,lon);
globepcolor(lat,lon,Ta)
globeborders('color',rgb('gray'))
axis tight
cmocean('balance','pivot')
ht=title(titlestr);
pause(chart_time)
%Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all')
% Continue with example 4
titlestr='Globequiver-Ex04';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
filename = 'ERA_Interim_2017.nc';
u10 = ncread(filename,'u10'); % 10 metre U wind component
v10 = ncread(filename,'v10'); % 10 metre V wind component
sp = ncread(filename,'sp'); % surface pressure
T = ncread(filename,'t2m'); % 2 metre temperature
lat = double(ncread(filename,'latitude'));
lon = double(ncread(filename,'longitude'));
% Calculate anomalies for January:
mo = 1;
Ta = T(:,:,mo)-mean(T,3);
spa = sp(:,:,mo)-mean(sp,3);
ua = u10(:,:,mo) - mean(u10,3);
va = v10(:,:,mo) - mean(v10,3);
[lat,lon] = meshgrid(lat,lon);
globepcolor(lat,lon,Ta)
globeborders('color',rgb('gray'))
axis tight
cmocean('balance','pivot')
q = globequiver(lat,lon,ua,va,'k');
ht=title(titlestr);
pause(chart_time)
delete(q) % deletes the quiver arrows we just plotted above
globequiver(lat,lon,ua,va,2,'density',100,'k')
pause(chart_time)
globeborders('color',rgb('gray'))
globecontour(lat,lon,spa,10,'color',rgb('orange'))
view(-140,22)
pause(chart_time)
%Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all')
clear all