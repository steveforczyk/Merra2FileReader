function DisplayMonthlyAvgTemps(titlestr)
% This function will plot the monthly average temperature changes
% Currently the plot expect data for 12 months and 10 Regions
%
% Written By: Stephen Forczyk
% Created: Jan 3,2024
% Revised: -----
% Classification: Public Domain/Unclassified

global PredTempStart PredTempEnd PredTempChng;
global MonthLabels RegionLabels;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global jpegpath govjpegpath;
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 LogoFileName2;

jpegpath='K:\Merra-2\netCDF\Dataset03\Jpeg_Test\';
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
iLogo=1;
LogoFileName1='Merra2-LogoB.jpg';
% Set up parameters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=7;

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
imagesc(PredTempChng);
% MonthLabels=cell(12,1);
% MonthLabels{1,1}='Jan';
% MonthLabels{2,1}='Feb';
% MonthLabels{3,1}='Mar';
% MonthLabels{4,1}='Apr';
% MonthLabels{5,1}='May';
% MonthLabels{6,1}='Jun';
% MonthLabels{7,1}='Jul';
% MonthLabels{8,1}='Aug';
% MonthLabels{9,1}='Sep';
% MonthLabels{10,1}='Oct';
% MonthLabels{11,1}='Nov';
% MonthLabels{12,1}='Dec';
% RegionLabels=cell(10,1);
% RegionLabels{1,1}='Germany';
% RegionLabels{2,1}='Finland';
% RegionLabels{3,1}='UK';
% RegionLabels{4,1}='Sudan';
% RegionLabels{5,1}='South-Africa';
% RegionLabels{6,1}='India';
% RegionLabels{7,1}='Australia';
% RegionLabels{8,1}='California';
% RegionLabels{9,1}='Texas';
% RegionLabels{10,1}='Peru';

set(gca,'YTick',[1 2 3 4 5 6 7 8 9 10 11 12]);
set(gca,'YTickLabels',MonthLabels);
set(gca,'XTickLabels',RegionLabels);
set(gca,'XTickLabelRotation',90);
hc=colorbar;
hc.Label.String='Temp Change Dec C';

ht=title(titlestr);
ab=1;
%% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .1,.04,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
%% Save the chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
end