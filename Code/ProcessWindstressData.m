function ProcessWindstressData(nowFile,titlestr)
% This function will load a single file from the M2I6NPANA dataset in order
% to look at the windstress components
% Created: Mar 18,2024
% Written By: Stephen Forczyk
% Revised: ------
% Classification: Public Domain/Unclassified
% Based On: This script drew on material taken from the Climate Data toolbox
% written by Chad Green
global U150GMT00 V150GMT00 Tau150GMT00;
global TimeSlices iTimeSlice Merra2ShortFileName;
global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevel42 iScale;
global iLogo LogoFileName LogoFileName1 LogoFileName2;
global StatsU10A u10AdjA fraclowu10A frachighu10A fracNaNu10A;
global StatsV10A v10AdjA fraclowv10A frachighv10A fracNaNv10A;
global StatsU10B u10AdjB fraclowu10B frachighu10B fracNaNu10B;
global StatsV10B v10AdjB fraclowv10B frachighv10B fracNaNv10B;
global StatsU10C u10AdjC fraclowu10C frachighu10C fracNaNu10C;
global StatsV10C v10AdjC fraclowv10C frachighv10C fracNaNv10C;
global StatsU10D u10AdjD fraclowu10D frachighu10D fracNaNu10D;
global StatsV10D v10AdjD fraclowv10D frachighv10D fracNaNv10D;
global WindVelA WindDirA WindVelB WindDirB WindVelC WindDirC WindVelD WindDirD;
global StatsWindVelA StatsWindVelB StatsWindVelC StatsWindVelD;


global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie;
global matpath datapath maskpath watermaskpath oceanmappath;
global antarcticpath antarcticshapefile;
global jpegpath tiffpath moviepath savepath geotiffpath;
global excelpath ascpath citypath tablepath tiffpath tiffpath2;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
global viewAZ viewEL viewAZInc;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;

global shapefilepath Countryshapepath figpath pressurepath averaged1Daypath;
global mappath gridpath countyshapepath nationalshapepath codepath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
global yd md dd;
global YearValue MonthValue DayValue HourValue MinValue SecValue frameDate;
global pwd;
global HS10 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S10 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;
global iFastSave iSelectSet4;
global vTemp30 YearMonthDayStr;



ab=1;
iScale=1;
% Load the selected File
eval(['cd ' datapath(1:length(datapath)-1)]);
load(nowFile,'US','VS');
% Now get the desired U V windcomponents at the desired times and Pressure
% levels
pressurelevel=PressureLevel42(iPress42,2);
pressureheightkm=PressureLevel42(iPress42,3);
titlestrorig=titlestr;
for k=1:4 % Loop over the 4 times available each day
    U150GMT00=US.values(:,:,iPress42,k);
    V150GMT00=VS.values(:,:,iPress42,k);
    u10=U150GMT00;
    v10=V150GMT00;
    [nrows,ncols]=size(u10);
    WindVel=zeros(nrows,ncols);
    WindDir=zeros(nrows,ncols);
    lowcutoff=-100;
    highcutoff=100;
    titlestr=strcat(titlestrorig,'-',char(TimeSlices(k,1)));

    for i=1:nrows
        for j=1:ncols
            ucomp=u10(i,j);
            vcomp=v10(i,j);
            a1=isnan(ucomp);
            a2=isnan(vcomp);
            if(a1==1)
                ucomp=0;
            end
            if((ucomp<lowcutoff) || (ucomp>=highcutoff))
                ucomp=0;
            end
            if(a2==1)
                vcomp=0;
            end
            if((vcomp<lowcutoff) || (vcomp>=highcutoff))
                vcomp=0;
            end
            if(k==1)
                WindVelA(i,j)=sqrt((ucomp^2) + (vcomp^2));
                WindDirA(i,j) = atan2d(vcomp,ucomp);
            elseif(k==2)
                WindVelB(i,j)=sqrt((ucomp^2) + (vcomp^2));
                WindDirB(i,j) = atan2d(vcomp,ucomp);
            elseif(k==3)
                WindVelC(i,j)=sqrt((ucomp^2) + (vcomp^2));
                WindDirC(i,j) = atan2d(vcomp,ucomp);
            elseif(k==4)
                WindVelD(i,j)=sqrt((ucomp^2) + (vcomp^2));
                WindDirD(i,j) = atan2d(vcomp,ucomp);
            end
        end
    end

    if(k==1)
        [StatsU10A,u10AdjA,fraclowu10A,frachighu10A,fracNaNu10A] = GetDistributionStatsRev7(u10,lowcutoff,highcutoff);
        [StatsV10A,v10AdjA,fraclowv10A,frachighv10A,fracNaNv10A] = GetDistributionStatsRev7(v10,lowcutoff,highcutoff);
        [StatsWindVelA,WindVelAdjA,fraclowWvel,frachighWVel,fracNaNWvel] = GetDistributionStatsRev7(WindVelA,lowcutoff,highcutoff);
        windvel50ptile=StatsWindVelA(9,3);
        windvel99ptile=StatsWindVelA(17,3);
    elseif(k==2)
        [StatsU10B,u10AdjB,fraclowu10B,frachighu10B,fracNaNu10B] = GetDistributionStatsRev7(u10,lowcutoff,highcutoff);
        [StatsV10B,v10AdjB,fraclowv10B,frachighv10B,fracNaNv10B] = GetDistributionStatsRev7(v10,lowcutoff,highcutoff);
        [StatsWindVelB,WindVelAdjB,fraclowWvel,frachighWVel,fracNaNWvel] = GetDistributionStatsRev7(WindVelB,lowcutoff,highcutoff);
        windvel50ptile=StatsWindVelB(9,3);
        windvel99ptile=StatsWindVelB(17,3);
    elseif(k==3)
        [StatsU10C,u10AdjC,fraclowu10C,frachighu10C,fracNaNu10C] = GetDistributionStatsRev7(u10,lowcutoff,highcutoff);
        [StatsV10C,v10AdjC,fraclowv10C,frachighv10C,fracNaNv10C] = GetDistributionStatsRev7(v10,lowcutoff,highcutoff);
        [StatsWindVelC,WindVelAdjC,fraclowWvel,frachighWVel,fracNaNWvel] = GetDistributionStatsRev7(WindVelC,lowcutoff,highcutoff);
        windvel50ptile=StatsWindVelC(9,3);
        windvel99ptile=StatsWindVelC(17,3);
    elseif(k==4)
        [StatsU10D,u10AdjD,fraclowu10D,frachighu10D,fracNaNu10D] = GetDistributionStatsRev7(u10,lowcutoff,highcutoff);
        [StatsV10D,v10AdjD,fraclowv10D,frachighv10D,fracNaNv10D] = GetDistributionStatsRev7(v10,lowcutoff,highcutoff);
        [StatsWindVelD,WindVelAdjD,fraclowWvel,frachighWVel,fracNaNWvel] = GetDistributionStatsRev7(WindVelD,lowcutoff,highcutoff);
        windvel50ptile=StatsWindVelD(9,3);
        windvel99ptile=StatsWindVelD(17,3);
    end
    ab=1;
    lat=-90:.5:90;
    lat=lat';
    lon=-180:.625:179.375;
    [lats,lons] = meshgrid(lat,lon);
    movie_figure1=figure('position',[hor1 vert1 widd lend]);
    set(gcf,'MenuBar','none');
    borders('countries','g')
    quiversc(lons,lats,u10,v10,'r','density',100);
    ht=title(titlestr);
    axis([-180 180 -80 80]);
    set(gca,'Color',[.1 .1 .1]);
%% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.67,haPos(2)-.09, .12,.04,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Add some text to the bottom of the frame
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
iProj=2;
    if(iProj<=3)
        tx1=.03;
        ty1=.06;
        txtstr1=strcat('Merra2-File-',nowFile,'- For Pressure Level-',num2str(pressurelevel),...
            '-which is about an altitude of-',num2str(pressureheightkm),'-km');
        txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
        tx2=tx1;
        ty2=ty1-.03;
        txtstr2=strcat('Time-',TimeSlices(k,1),'-50Ptile Wind Vel-',num2str(windvel50ptile),...
            '-99 Ptile-',num2str(windvel99ptile),'-m/sec');
        txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);

    end
set(newaxesh,'Visible','Off');
pause(chart_time)

% Grab a frame for the movie
frame=getframe(gcf);
writeVideo(vTemp30,frame);
close('all')

end
end