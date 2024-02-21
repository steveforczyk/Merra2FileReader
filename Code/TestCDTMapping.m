% This script is intended to test certain mapping tasks based on the 
% Climate Data Toolbox in oder to apply them to the Merra2 datasets
% This script cocnetrates on running the examples in the CDT tollbox 

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
% Start with example 1titlestr='Globeborders-Ex01';titlestr='Globeborders-Ex01';
titlestr='Globeborders-Ex01';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
globeborders
axis tight
hold on
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
% Continue with example 2
titlestr='Globeborders-Ex02';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
globefill
hold on
globeborders('--r')
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
titlestr='Globeborders-Ex03';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
globeborders('color',[0.25 0.25 0.65],'linewidth',2,'linestyle',':','radius',5e6);
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
% Continue with example 4
titlestr='Globeborders-Ex04';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
globeimage
globeborders
view(45,20)
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
% Continue with example 5
load topo
[lon,lat] = meshgrid(0:359,-89:90);
titlestr='Globeborders-Ex05';
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
globepcolor(lat,lon,topo);
hold on
globeborders('color','k','linewidth',0.5,'linestyle','-')
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
