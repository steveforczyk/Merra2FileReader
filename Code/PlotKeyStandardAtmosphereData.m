function PlotKeyStandardAtmosphereData(titlestr)
% This routine will plot the atmospheric pressure and density versus level
% Written By: Stephen Forczyk
% Created: Nov 14,2023
% Revised: 
% Classification: Unclassified
global EnhancedPressureLevel42;


global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath jpegpath govjpegpath;

xp(:,1)=EnhancedPressureLevel42(:,2);
yp1(:,1)=EnhancedPressureLevel42(:,3);
yp2(:,1)=EnhancedPressureLevel42(:,4);
% Now create a line plot of the cumilative distribution
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gca,'Position',[.16 .18  .70 .70]);
left_color=[0 0 1];
right_color=[1 0 0];
set(movie_figure1,'defaultAxesColorOrder',[left_color; right_color]);
ax=gca;
yyaxis left
h1=plot(xp,yp1,'b');
ax.XDir = 'reverse';
ax.YColor=[0 0 1];
xlabel('Pressure-Pa','FontWeight','bold');
ylabelstr='Alt-Km';
ylabel(ylabelstr,'FontWeight','bold','Color','b');
set(gca,'FontWeight','bold');
ht=title(titlestr);
set(ht,'FontWeight','bold');
yyaxis right
h2=plot(xp,yp2,'r');
ax.XDir = 'reverse';
ax.YColor=[1 0 0];
ylabelstr='Atmospheric Density km/m^3';
ylabel(ylabelstr,'FontWeight','bold','Color','r');
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','GridColor',[0 0 0]);
set(gca,'YGrid','on','GridColor',[0 0 0]);
ab=1;
% Set up the axis for writing at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.18;
ty1=.10;
txtstr1='Chart plots altitude in km and air density against pressure level';
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
tx2=.18;
ty2=.06;
txtstr2='Data assumes standard temperature and uses the 42 levels used by the Merra2 data assimulation';
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
tx2=.18;
ty2=.06;

set(newaxesh,'Visible','Off');
pause(chart_time);
% Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all')
dispstr=strcat('Chart-',figstr,'-saved to govjpegfolder');
disp(dispstr)
end
