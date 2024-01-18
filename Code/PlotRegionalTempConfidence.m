function PlotRegionalTempConfidence(FitTemp,MeasTimes,MeasTemps,RegionName,ifittype,gof,fitconf,titlestr)
% This routine will plot the fit of a region temperature over time along
% with the actual measured data along with a confidence fit
% 
% Written By: Stephen Forczyk
% Created: Dec 26,2023
% Revised: Jan 17,2024 added logic to produce chapter in PDF report
% for one selected month for all regions (this is to hold down size of PDF
% created)
% Classification: Public Domain/Unclassified

global TimeFrac startYearstr endYearstr;
global pslice heightkm DataCollectionTime;
global PredTempStart PredTempEnd PredTempChng;
global fitmonth fitregion;
global iMonthForPDF;


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


if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
end

% Determine string for fit type
if(ifittype==1)
    fitstr='Polyfit Order 1';
elseif(ifittype==2)
    fitstr='Polyfit Order 2';
end
p12 = predint(FitTemp,MeasTimes,fitconf,'observation','on');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
plot(FitTemp,MeasTimes,MeasTemps);
hold on
plot(MeasTimes,p12,'r--');
hold off
legend off
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
currentChange=TempLimits(2,1)-TempLimits(1,1);
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
ty1=.04;
txtstr1=strcat('Fitted Data from-',startYearstr,'-to-',endYearstr,'-fittype-',fitstr,...
    '-Data Collection Time-',DataCollectionTime);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
tx2=.10;
ty2=.02;
txtstr2=strcat('Goodness Of Fit adjusted rquare =',num2str(adjrsquare,4),'-RMSE-',num2str(rmse,4),...
    '-fit confidence-',num2str(fitconf),'-height-km-',num2str(heightkm),'-press level-',num2str(pslice));
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
%% Add data to PDF Report
iNewChapter=0;
iAddToReport=0;
iCloseChapter=0;
if((fitmonth==iMonthForPDF) && (fitregion<10))
    iAddToReport=1;
    iCloseChapter=0;
elseif((fitregion==10) && (fitmonth==iMonthForPDF))
    iAddToReport=1;
    iCloseChapter=1;
end
if((fitmonth==iMonthForPDF) && (fitregion==1))
    iNewChapter=1;
end
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1) && (fitmonth==iMonthForPDF))
    if(iNewChapter)
        headingstr1='Average Air Temp Changes For One Month By Region';
        chapter = Chapter("Title",headingstr1);
    end
    sectionstr=strcat('AirTemp Changes From 1980-2023','for region-',num2str(fitregion));
    add(chapter,Section(sectionstr));
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr='Dateset03-Avg Temp Changes For Selected Month and Region';
    pdftext = Text(pdftxtstr);
    pdftext.Color = 'red';
    image.Caption = pdftext;
    nhighs=floor(nhigh/2.5);
    nwids=floor(nwid/2.5);
    heightstr=strcat(num2str(nhighs),'px');
    widthstr=strcat(num2str(nwids),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
% Now add some text -start by decribing the with a basic description of the
% variable being plotted
    parastr1=strcat('This chart shows the change in  Air Temp For Month-',num2str(fitmonth),'-and region-',num2str(fitregion),'.');
    parastr2='Basically the curve fit data is used to generate a smooth estimate of the 50 percentile Air Temp values in thr selected time period.';
    parastr3=' A difference in the estimate for 2020 and 1980 is called the air temperature change.';
    parastr4=strcat('Data displayed is for time-',DataCollectionTime);
    parastr5=strcat('The selected pressure level was-',num2str(heightkm,2),'-in km.');
    parastr6='Typically a low altitude was used but in mountainous regions many NaN values can be returned.';
    parastr7=strcat(' For the month and region shown above the estimates temperature change is-',num2str(currentChange),'-Deg C.');
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5,parastr6,parastr7);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
%   fprintf(fid,'\n');
%   flagstr=strcat('fitmonth-',num2str(fitmonth),'-fitregion-',num2str(fitregion));
%   fprintf(fid,'%s\n',flagstr);
%   flagstr2=strcat('iNewChapter-',num2str(iNewChapter),'iAddToReport-',num2str(iAddToReport),...
%          '-iCloseChapter-',num2str(iCloseChapter));
%   fprintf(fid,'%s\n',flagstr2);
%              fprintf(fid,'\n');
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end
end