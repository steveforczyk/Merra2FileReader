function PlotRegionalTempFit(FitTemp,MeasTimes,MeasTemps,RegionName,ifittype,gof,titlestr)
% This routine will plot the fit of a region temperature over time along
% with the actual measured data
% 
% Written By: Stephen Forczyk
% Created: Dec 14,2023
% Revised: Dec 16,2023 added Gof data to plot
% Revised: Jan 2,2024 added simple estimate of temp change in region
% by default the start data is 1980 and the end date is 2020
% Classification: Public Domain/Unclassified

global TimeFrac startYearstr endYearstr;
global PredTempStart PredTempEnd PredTempChng;
global fitmonth fitregion;
global pslice heightkm DataCollectionTime;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie;
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

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



% Determine string for fit type
if(ifittype==1)
    fitstr='Polyfit Order 1';
elseif(ifittype==2)
    fitstr='Polyfit Order 2';
end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
plot(FitTemp,MeasTimes,MeasTemps);
ht=title(titlestr);
hx=xlabel('Date-Years');
set(hx,'FontWeight','bold','FontSize',12);
hy=ylabel('Temp In Deg-C','FontWeight','bold');
set(hy,'FontWeight','bold','FontSize',12);
legend('Location','NorthEast','FontWeight','bold');
grid on
% Do a simple check on global warnming
FutureDates=(1980:40:2020).';
TempLimits=FitTemp(FutureDates);
PredTempStart(fitmonth,fitregion)=TempLimits(1,1);
PredTempEnd(fitmonth,fitregion)=TempLimits(2,1);
PredTempChng(fitmonth,fitregion)=TempLimits(2,1)-TempLimits(1,1);
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
% Add data on the goodness of fit to the bottom of the chart
adjrsquare=gof.adjrsquare;
rmse=gof.rmse;
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.05;
txtstr1=strcat('Fitted Data from-',startYearstr,'-to-',endYearstr,'-fittype-',fitstr,...
    '-Data Collection Time-',DataCollectionTime);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.10;
ty2=.02;
txtstr2=strcat('Goodness Of Fit adjusted rquare =',num2str(adjrsquare,4),'-RMSE-',num2str(rmse,4));
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
set(newaxesh,'Visible','Off');
pause(chart_time);
%close('all');
%% Save the chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
end