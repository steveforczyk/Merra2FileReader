function PlotTimeSeriesRasterCount(ts,figstr,vartextstr)
% This will create a specialized timeseries plot of the number of rasters
% that exceeded a specified value of the CloudOpticalThickness or COT
% Written By; Stephen Forczyk
% Created: Oct 27,2022
% Revised: 
% Classification: None
global COTThresh;

global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global fid;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath ;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;

% Now create a line a timesries plot
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gca,'Position',[.16 .18  .70 .70]);
plot(ts);
set(gca,'XGrid','on','YGrid','on');
set(gca,'FontWeight','bold')
set(gca,'XTickLabelRotation',90);
%
set(gca,'XMinorGrid','on')
grid minor
% Set up the axis for writing at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.18;
ty1=.07;
txtstr1=strcat('COT Threshold=',num2str(COTThresh),vartextstr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10,'Color','r');
% tx2=.18;
% ty2=.06;
% txtstr2=strcat('Observations Taken at Site-',SiteName,...
%     '-Location=',SiteCharName);
% txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
% tx3=.18;
% ty3=.02;
% txtstr3=strcat('UTCStart Time=',UTCStartStr,'-UTCEndTime=',UTCEndStr);
% txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',10);
set(newaxesh,'Visible','Off');
pause(chart_time);
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all')

end


