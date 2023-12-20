% This script will read in an existing series of tables created by
% ReadMerra2Data and test out ocrrelation and curvefit routines
% Written By: Stephen Forczyk
% Created: Dec 13,2023
% Revised: -----
% Classification: Unclassified/Public Domain
global TimeFrac startYearstr endYearstr;
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global TSTable TSTT HSTable HSTT O3STable O3STT SLPSTable SLPSTT;
global QVSTable QVSTT PSSTable PSSTT USTable USTT VSTable VSTT;
global ROIArea ROIPts ROIFracPts numgridpts Merra2WorkingMask;
global TSStats TSStatsTable TSSTT TSStats2Table TSS2TT;
global QVStats QVStatsTable QVStatTT QVStats2Table QVStat2TT;
global O3Stats O3StatsTable O3StatTT O3Stats2Table O3Stat2TT;
global TempStatsFileName1 TempStatsFileName2;
global JanTemps FebTemps MarTemps AprTemps MayTemps JunTemps;
global JulTemps AugTemps SepTemps OctTemps NovTemps DecTemps;
global GofStats1 GofStats2;
%global gofJanRegion1 gofFebRegion1;


global Merra2ShortFileName;
global numtimeslice TimeSlices;
global Years Months Days;
global iTimeSlice iPress42;

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
global iLogo LogoFileName1 LogoFileName2;

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

jpegpath='K:\Merra-2\netCDF\Dataset03\Jpeg_Test\';
pdfpath='K:\Merra-2\netCDF\Dataset03\PDF_Files\';
logpath='K:\Merra-2\netCDF\Dataset03\Log_Files\';
moviepath='K:\Merra-2\netCDF\Dataset03\Movies\';
savepath='K:\Merra-2\netCDF\Dataset03\Matlab_Files\';  
tablepath='K:\Merra-2\netCDF\Dataset03\Tables\';
govjpegpath='K:\Merra-2\gov_jpeg\';
% Get the Median Atmospheric Temperature data stored as TimeTables
TempStatsFileName1='TSStatsTable199912-12-Hrs-GMT-PrsLvl-10.mat';
TempStatsFileName2='TSStats2Table199912-12-Hrs-GMT-PrsLvl-10.mat';
TempStatsFileName1='FinalCombinedTSSTables.mat';
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
iLogo=1;
LogoFileName1='Merra2-LogoB.jpg';
% Set up parameters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=7;

% Load the Temp Stats Timetables 1 and 2
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load(TempStatsFileName1);
%load(TempStatsFileName2);
% Now run through the data to determine start and end points
[nrowsTT,ncolsTT]=size(TSSTT);
starttime=TSSTT.Time(1);
startstr=char(string(starttime));
endtime=TSSTT.Time(nrowsTT);
endstr=char(string(endtime));
startstrlen=length(startstr);
[idash]=strfind(startstr,'-');
is=idash(2)+1;
ie=is+3;
startYearstr=startstr(is:ie);
startYear=str2double(startYearstr);
endstrlen=length(endstr);
[idash]=strfind(endstr,'-');
is=idash(2)+1;
ie=is+3;
endYearstr=endstr(is:ie);
endYear=str2double(endYearstr);
numYears=endYear-startYear+1;
% Now create arrays to hold the tempdata by Months and Regions
JanTemps=zeros(numYears,10);
FebTemps=zeros(numYears,10);
MarTemps=zeros(numYears,10);
AprTemps=zeros(numYears,10);
MayTemps=zeros(numYears,10);
JunTemps=zeros(numYears,10);
JulTemps=zeros(numYears,10);
AugTemps=zeros(numYears,10);
SepTemps=zeros(numYears,10);
OctTemps=zeros(numYears,10);
NovTemps=zeros(numYears,10);
DecTemps=zeros(numYears,10);
TimeFrac=zeros(numYears,12);
GofStats1=zeros(12,10);
GofStats2=zeros(12,10);
% Now split the data into Months and Regions
ik1=0;
ik2=0;
ik3=0;
ik4=0;
ik5=0;
ik6=0;
ik7=0;
ik8=0;
ik9=0;
ik10=0;
ik11=0;
ik12=0;
for i=1:nrowsTT
    rowtime=TSSTT.Time(i);
    rowstr=char(string(rowtime));
    [idash]=strfind(rowstr,'-');
    is=idash(2)+1;
    ie=is+3;
    rowYearstr=rowstr(is:ie);
    rowYear=str2double(rowYearstr);
    is=idash(1)+1;
    ie=is+2;
    rowMonthstr=rowstr(is:ie);
    [monthnum] = ConvertMonthStrToNumber(rowMonthstr);
    ab=2;
    if(monthnum==1)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik1=ik1+1;
        TimeFrac(ik1,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        JanTemps(ik1,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        JanTemps(ik1,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        JanTemps(ik1,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        JanTemps(ik1,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        JanTemps(ik1,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        JanTemps(ik1,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        JanTemps(ik1,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        JanTemps(ik1,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        JanTemps(ik1,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        JanTemps(ik1,10)=nowVal10;
    elseif(monthnum==2)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik2=ik2+1;
        TimeFrac(ik2,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        FebTemps(ik2,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        FebTemps(ik2,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        FebTemps(ik2,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        FebTemps(ik2,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        FebTemps(ik2,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        FebTemps(ik2,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        FebTemps(ik2,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        FebTemps(ik2,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        FebTemps(ik2,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        FebTemps(ik2,10)=nowVal10;
     elseif(monthnum==3)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik3=ik3+1;
        TimeFrac(ik3,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        MarTemps(ik3,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        MarTemps(ik3,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        MarTemps(ik3,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        MarTemps(ik3,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        MarTemps(ik3,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        MarTemps(ik3,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        MarTemps(ik3,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        MarTemps(ik3,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        MarTemps(ik3,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        MarTemps(ik3,10)=nowVal10;
      elseif(monthnum==4)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik4=ik4+1;
        TimeFrac(ik4,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        AprTemps(ik4,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        AprTemps(ik4,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        AprTemps(ik4,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        AprTemps(ik4,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        AprTemps(ik4,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        AprTemps(ik4,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        AprTemps(ik4,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        AprTemps(ik4,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        AprTemps(ik4,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        AprTemps(ik4,10)=nowVal10;
     elseif(monthnum==5)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik5=ik5+1;
        TimeFrac(ik5,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        MayTemps(ik5,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        MayTemps(ik5,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        MayTemps(ik5,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        MayTemps(ik5,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        MayTemps(ik5,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        MayTemps(ik5,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        MayTemps(ik5,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        MayTemps(ik5,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        MayTemps(ik5,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        MayTemps(ik5,10)=nowVal10;
      elseif(monthnum==6)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik6=ik6+1;
        TimeFrac(ik6,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        JunTemps(ik6,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        JunTemps(ik6,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        JunTemps(ik6,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        JunTemps(ik6,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        JunTemps(ik6,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        JunTemps(ik6,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        JunTemps(ik6,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        JunTemps(ik6,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        JunTemps(ik6,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        JunTemps(ik6,10)=nowVal10;
      elseif(monthnum==7)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik7=ik7+1;
        TimeFrac(ik7,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        JulTemps(ik7,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        JulTemps(ik7,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        JulTemps(ik7,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        JulTemps(ik7,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        JulTemps(ik7,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        JulTemps(ik7,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        JulTemps(ik7,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        JulTemps(ik7,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        JulTemps(ik7,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        JulTemps(ik7,10)=nowVal10;
     elseif(monthnum==8)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik8=ik8+1;
        TimeFrac(ik8,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        AugTemps(ik8,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        AugTemps(ik8,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        AugTemps(ik8,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        AugTemps(ik8,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        AugTemps(ik8,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        AugTemps(ik8,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        AugTemps(ik8,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        AugTemps(ik8,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        AugTemps(ik8,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        AugTemps(ik8,10)=nowVal10;
      elseif(monthnum==9)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik9=ik9+1;
        if(ik9>40)
            ab=1;
        end
        TimeFrac(ik9,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        SepTemps(ik9,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        SepTemps(ik9,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        SepTemps(ik9,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        SepTemps(ik9,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        SepTemps(ik9,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        SepTemps(ik9,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        SepTemps(ik9,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        SepTemps(ik9,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        SepTemps(ik9,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        SepTemps(ik9,10)=nowVal10;
      elseif(monthnum==10)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik10=ik10+1;
        TimeFrac(ik10,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        OctTemps(ik10,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        OctTemps(ik10,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        OctTemps(ik10,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        OctTemps(ik10,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        OctTemps(ik10,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        OctTemps(ik10,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        OctTemps(ik10,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        OctTemps(ik10,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        OctTemps(ik10,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        OctTemps(ik10,10)=nowVal10;
      elseif(monthnum==11)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik11=ik11+1;
        TimeFrac(ik11,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        NovTemps(ik11,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        NovTemps(ik11,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        NovTemps(ik11,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        NovTemps(ik11,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        NovTemps(ik11,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        NovTemps(ik11,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        NovTemps(ik11,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        NovTemps(ik11,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        NovTemps(ik11,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        NovTemps(ik11,10)=nowVal10;
      elseif(monthnum==12)
        rowtime=TSSTT.Time(i);
        rowstr=char(string(rowtime));
        [idash]=strfind(rowstr,'-');
        is=idash(2)+1;
        ie=is+3;
        rowYearstr=rowstr(is:ie);
        rowYear=str2double(rowYearstr);
        ik12=ik12+1;
        TimeFrac(ik12,monthnum)=rowYear+(monthnum-1)/12;
        nowVal1=TSSTT.Germany(i);
        DecTemps(ik12,1)=nowVal1;
        nowVal2=TSSTT.Finland(i);
        DecTemps(ik12,2)=nowVal2;
        nowVal3=TSSTT.UK(i);
        DecTemps(ik12,3)=nowVal3;
        nowVal4=TSSTT.Sudan(i);
        DecTemps(ik12,4)=nowVal4;
        nowVal5=TSSTT.SouthAfrica(i);
        DecTemps(ik12,5)=nowVal5;
        nowVal6=TSS2TT.India(i);
        DecTemps(ik12,6)=nowVal6;
        nowVal7=TSS2TT.Australia(i);
        DecTemps(ik12,7)=nowVal7;
        nowVal8=TSS2TT.California(i);
        DecTemps(ik12,8)=nowVal8;
        nowVal9=TSS2TT.Texas(i);
        DecTemps(ik12,9)=nowVal9;
        nowVal10=TSS2TT.Peru(i);
        DecTemps(ik12,10)=nowVal10;
    end
ab=3;
end
ab=4;
%% Now Fit the monthly data Region by Region and Month By Month
fo=fitoptions('poly2');
fo.Normalize='on';
%% Start with January-Region 1
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;

ab=1;
RegionName='Germany';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion1,gofJanRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion1.adjrsquare;
rmse=gofJanRegion1.rmse;
GofStats1(1,1)=adjrsquare;
GofStats2(1,1)=rmse;
PlotRegionalTempFit(FitJanTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion1,titlestr)
% Continue with Region 2
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Finland';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion2,gofJanRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion2.adjrsquare;
rmse=gofJanRegion2.rmse;
GofStats1(1,2)=adjrsquare;
GofStats2(1,2)=rmse;
PlotRegionalTempFit(FitJanTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion2,titlestr)
% Continue with Region 3
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='UK';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion3,gofJanRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion3.adjrsquare;
rmse=gofJanRegion3.rmse;
GofStats1(1,3)=adjrsquare;
GofStats2(1,3)=rmse;
PlotRegionalTempFit(FitJanTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion3,titlestr)
% Continue with Region 4
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Sudan';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion4,gofJanRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion4.adjrsquare;
rmse=gofJanRegion4.rmse;
GofStats1(1,4)=adjrsquare;
GofStats2(1,4)=rmse;
PlotRegionalTempFit(FitJanTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion4,titlestr)
% Continue with Region 5
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='SouthAfrica';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion5,gofJanRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion5.adjrsquare;
rmse=gofJanRegion5.rmse;
GofStats1(1,5)=adjrsquare;
GofStats2(1,5)=rmse;
PlotRegionalTempFit(FitJanTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion5,titlestr)
% Continue with January-Region 6
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='India';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion6,gofJanRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion6.adjrsquare;
rmse=gofJanRegion6.rmse;
GofStats1(1,6)=adjrsquare;
GofStats2(1,6)=rmse;
PlotRegionalTempFit(FitJanTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion6,titlestr)
% Continue with January-Region 7
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Australia';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion7,gofJanRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion7.adjrsquare;
rmse=gofJanRegion7.rmse;
GofStats1(1,7)=adjrsquare;
GofStats2(1,7)=rmse;
PlotRegionalTempFit(FitJanTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion7,titlestr)
% Continue with January-Region 8
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='California';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion8,gofJanRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion8.adjrsquare;
rmse=gofJanRegion8.rmse;
GofStats1(1,8)=adjrsquare;
GofStats2(1,8)=rmse;
PlotRegionalTempFit(FitJanTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion8,titlestr)
% Continue with January-Region 9
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Texas';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion9,gofJanRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion9.adjrsquare;
rmse=gofJanRegion9.rmse;
GofStats1(1,9)=adjrsquare;
GofStats2(1,9)=rmse;
PlotRegionalTempFit(FitJanTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion9,titlestr)
% Continue with January-Region 10
MeasTimes=TimeFrac(:,1);
MeasTemps=JanTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Peru';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
[FitJanTempRegion10,gofJanRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJanRegion10.adjrsquare;
rmse=gofJanRegion10.rmse;
GofStats1(1,10)=adjrsquare;
GofStats2(1,10)=rmse;
PlotRegionalTempFit(FitJanTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion10,titlestr)

%% Continue with February-Region 1
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Germany';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion1,gofFebRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion1.adjrsquare;
rmse=gofFebRegion1.rmse;
GofStats1(2,1)=adjrsquare;
GofStats2(2,1)=rmse;
PlotRegionalTempFit(FitFebTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion1,titlestr)
% Continue with February-Region 2
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Finland';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion2,gofFebRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion2.adjrsquare;
rmse=gofFebRegion2.rmse;
GofStats1(2,2)=adjrsquare;
GofStats2(2,2)=rmse;
PlotRegionalTempFit(FitFebTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion2,titlestr)
% Continue with February-Region 3
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='UK';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion3,gofFebRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion3.adjrsquare;
rmse=gofFebRegion3.rmse;
GofStats1(2,3)=adjrsquare;
GofStats2(2,3)=rmse;
PlotRegionalTempFit(FitFebTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion3,titlestr)
% Continue with February-Region 4
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Sudan';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion4,gofFebRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion4.adjrsquare;
rmse=gofFebRegion4.rmse;
GofStats1(2,4)=adjrsquare;
GofStats2(2,4)=rmse;
PlotRegionalTempFit(FitFebTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion4,titlestr)
% Continue with February-Region 5
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='SouthAfrica';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion5,gofFebRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion5.adjrsquare;
rmse=gofFebRegion5.rmse;
GofStats1(2,5)=adjrsquare;
GofStats2(2,5)=rmse;
PlotRegionalTempFit(FitFebTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion5,titlestr)
% Continue with February-Region 6
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='India';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion6,gofFebRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion6.adjrsquare;
rmse=gofFebRegion6.rmse;
GofStats1(2,6)=adjrsquare;
GofStats2(2,6)=rmse;
PlotRegionalTempFit(FitFebTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion6,titlestr)
% Continue with February-Region 7
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Australia';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion7,gofFebRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion7.adjrsquare;
rmse=gofFebRegion7.rmse;
GofStats1(2,7)=adjrsquare;
GofStats2(2,7)=rmse;
PlotRegionalTempFit(FitFebTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion7,titlestr)
% Continue with February-Region 8
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='California';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion8,gofFebRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion8.adjrsquare;
rmse=gofFebRegion8.rmse;
GofStats1(2,8)=adjrsquare;
GofStats2(2,8)=rmse;
PlotRegionalTempFit(FitFebTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion8,titlestr)
% Continue with February-Region 9
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Texas';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion9,gofFebRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion9.adjrsquare;
rmse=gofFebRegion9.rmse;
GofStats1(2,9)=adjrsquare;
GofStats2(2,9)=rmse;
PlotRegionalTempFit(FitFebTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion9,titlestr)
% Continue with February-Region 10
MeasTimes=TimeFrac(:,2);
MeasTemps=FebTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Peru';
titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-February');
[FitFebTempRegion10,gofFebRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofFebRegion10.adjrsquare;
rmse=gofFebRegion10.rmse;
GofStats1(2,10)=adjrsquare;
GofStats2(2,10)=rmse;
PlotRegionalTempFit(FitFebTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion10,titlestr)

%% Continue with March-Region 1
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Germany';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion1,gofMarRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion1.adjrsquare;
rmse=gofMarRegion1.rmse;
GofStats1(3,1)=adjrsquare;
GofStats2(3,1)=rmse;
PlotRegionalTempFit(FitMarTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion1,titlestr)

% Continue with March-Region 2
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Finland';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion2,gofMarRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion2.adjrsquare;
rmse=gofMarRegion2.rmse;
GofStats1(3,2)=adjrsquare;
GofStats2(3,2)=rmse;
PlotRegionalTempFit(FitMarTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion2,titlestr)

% Continue with March-Region 3
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='UK';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion3,gofMarRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion2.adjrsquare;
rmse=gofMarRegion2.rmse;
GofStats1(3,3)=adjrsquare;
GofStats2(3,3)=rmse;
PlotRegionalTempFit(FitMarTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion3,titlestr)

% Continue with March-Region 4
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Sudan';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion4,gofMarRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion4.adjrsquare;
rmse=gofMarRegion4.rmse;
GofStats1(3,4)=adjrsquare;
GofStats2(3,4)=rmse;
PlotRegionalTempFit(FitMarTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion4,titlestr)

% Continue with March-Region 5
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='SouthAfrica';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion5,gofMarRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion5.adjrsquare;
rmse=gofMarRegion5.rmse;
GofStats1(3,5)=adjrsquare;
GofStats2(3,5)=rmse;
PlotRegionalTempFit(FitMarTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion5,titlestr)

% Continue with March-Region 6
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='India';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion6,gofMarRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion6.adjrsquare;
rmse=gofMarRegion6.rmse;
GofStats1(3,6)=adjrsquare;
GofStats2(3,6)=rmse;
PlotRegionalTempFit(FitMarTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion6,titlestr)

% Continue with March-Region 7
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Australia';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion7,gofMarRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion7.adjrsquare;
rmse=gofMarRegion7.rmse;
GofStats1(3,7)=adjrsquare;
GofStats2(3,7)=rmse;
PlotRegionalTempFit(FitMarTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion7,titlestr)

% Continue with March-Region 8
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='California';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion8,gofMarRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion8.adjrsquare;
rmse=gofMarRegion8.rmse;
GofStats1(3,8)=adjrsquare;
GofStats2(3,8)=rmse;
PlotRegionalTempFit(FitMarTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion8,titlestr)

% Continue with March-Region 9
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Texas';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion9,gofMarRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion9.adjrsquare;
rmse=gofMarRegion9.rmse;
GofStats1(3,9)=adjrsquare;
GofStats2(3,9)=rmse;
PlotRegionalTempFit(FitMarTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion9,titlestr)

% Continue with March-Region 10
MeasTimes=TimeFrac(:,3);
MeasTemps=MarTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Peru';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-March','-FitType-',num2str(ifittype));
[FitMarTempRegion10,gofMarRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMarRegion10.adjrsquare;
rmse=gofMarRegion10.rmse;
GofStats1(3,10)=adjrsquare;
GofStats2(3,10)=rmse;
PlotRegionalTempFit(FitMarTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion10,titlestr)


%% Continue with April-Region 1
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Germany';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
[FitAprTempRegion1,gofAprRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion1.adjrsquare;
rmse=gofAprRegion1.rmse;
GofStats1(4,1)=adjrsquare;
GofStats2(4,1)=rmse;
PlotRegionalTempFit(FitMarTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion1,titlestr)

% Continue with April-Region 2
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Finland';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
[FitAprTempRegion2,gofAprRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion2.adjrsquare;
rmse=gofAprRegion2.rmse;
GofStats1(4,2)=adjrsquare;
GofStats2(4,2)=rmse;
PlotRegionalTempFit(FitAprTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion2,titlestr)

% Continue with April-Region 3
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='UK';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
[FitAprTempRegion3,gofAprRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion2.adjrsquare;
rmse=gofAprRegion2.rmse;
GofStats1(4,3)=adjrsquare;
GofStats2(4,3)=rmse;
PlotRegionalTempFit(FitAprTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion3,titlestr)

% Continue with April-Region 4
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Sudan';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
[FitAprTempRegion4,gofAprRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion4.adjrsquare;
rmse=gofAprRegion4.rmse;
GofStats1(4,4)=adjrsquare;
GofStats2(4,4)=rmse;
PlotRegionalTempFit(FitAprTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion4,titlestr)

% Continue with Apr-Region 5
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='SouthAfrica';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-April','-FitType-',num2str(ifittype));
[FitAprTempRegion5,gofAprRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion5.adjrsquare;
rmse=gofAprRegion5.rmse;
GofStats1(4,5)=adjrsquare;
GofStats2(4,5)=rmse;
PlotRegionalTempFit(FitAprTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion5,titlestr)

% Continue with Apr-Region 6
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='India';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-April','-FitType-',num2str(ifittype));
[FitAprTempRegion6,gofAprRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion6.adjrsquare;
rmse=gofAprRegion6.rmse;
GofStats1(4,6)=adjrsquare;
GofStats2(4,6)=rmse;
PlotRegionalTempFit(FitAprTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion6,titlestr)

% Continue with April-Region 7
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Australia';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-April','-FitType-',num2str(ifittype));
[FitAprTempRegion7,gofAprRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion7.adjrsquare;
rmse=gofAprRegion7.rmse;
GofStats1(4,7)=adjrsquare;
GofStats2(4,7)=rmse;
PlotRegionalTempFit(FitAprTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion7,titlestr)

% Continue with April-Region 8
MeasTimes=TimeFrac(:,4);
MeasTemps=MarTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='California';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-April','-FitType-',num2str(ifittype));
[FitAprTempRegion8,gofAprRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion8.adjrsquare;
rmse=gofAprRegion8.rmse;
GofStats1(4,8)=adjrsquare;
GofStats2(4,8)=rmse;
PlotRegionalTempFit(FitAprTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion8,titlestr)

% Continue with Apr-Region 9
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Texas';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-April','-FitType-',num2str(ifittype));
[FitAprTempRegion9,gofAprRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion9.adjrsquare;
rmse=gofAprRegion9.rmse;
GofStats1(4,9)=adjrsquare;
GofStats2(4,9)=rmse;
PlotRegionalTempFit(FitAprTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion9,titlestr)

% Continue with April-Region 10
MeasTimes=TimeFrac(:,4);
MeasTemps=AprTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Peru';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-April','-FitType-',num2str(ifittype));
[FitAprTempRegion10,gofAprRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofAprRegion10.adjrsquare;
rmse=gofAprRegion10.rmse;
GofStats1(4,10)=adjrsquare;
GofStats2(4,10)=rmse;
PlotRegionalTempFit(FitAprTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion10,titlestr)

%% Continue with May-Region 1
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Germany';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion1,gofMayRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion1.adjrsquare;
rmse=gofMayRegion1.rmse;
GofStats1(5,1)=adjrsquare;
GofStats2(5,1)=rmse;
PlotRegionalTempFit(FitMayTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion1,titlestr)

% Continue with May-Region 2
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Finland';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion2,gofMayRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion2.adjrsquare;
rmse=gofMayRegion2.rmse;
GofStats1(5,2)=adjrsquare;
GofStats2(5,2)=rmse;
PlotRegionalTempFit(FitMayTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion2,titlestr)

% Continue with May-Region 3
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='UK';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion3,gofMayRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion2.adjrsquare;
rmse=gofMayRegion2.rmse;
GofStats1(5,3)=adjrsquare;
GofStats2(5,3)=rmse;
PlotRegionalTempFit(FitMayTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion3,titlestr)

% Continue with May-Region 4
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Sudan';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion4,gofMayRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion4.adjrsquare;
rmse=gofMayRegion4.rmse;
GofStats1(5,4)=adjrsquare;
GofStats2(5,4)=rmse;
PlotRegionalTempFit(FitMayTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion4,titlestr)

% Continue with May-Region 5
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='SouthAfrica';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion5,gofMayRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion5.adjrsquare;
rmse=gofMayRegion5.rmse;
GofStats1(5,5)=adjrsquare;
GofStats2(5,5)=rmse;
PlotRegionalTempFit(FitMayTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion5,titlestr)

% Continue with May-Region 6
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='India';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion6,gofMayRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion6.adjrsquare;
rmse=gofMayRegion6.rmse;
GofStats1(5,6)=adjrsquare;
GofStats2(5,6)=rmse;
PlotRegionalTempFit(FitMayTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion6,titlestr)

% Continue with May-Region 7
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Australia';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion7,gofMayRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion7.adjrsquare;
rmse=gofMayRegion7.rmse;
GofStats1(5,7)=adjrsquare;
GofStats2(5,7)=rmse;
PlotRegionalTempFit(FitMayTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion7,titlestr)

% Continue with May-Region 8
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='California';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion8,gofMayRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion8.adjrsquare;
rmse=gofMayRegion8.rmse;
GofStats1(5,8)=adjrsquare;
GofStats2(5,8)=rmse;
PlotRegionalTempFit(FitMayTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion8,titlestr)

% Continue with May-Region 9
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Texas';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion9,gofMayRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion9.adjrsquare;
rmse=gofMayRegion9.rmse;
GofStats1(5,9)=adjrsquare;
GofStats2(5,9)=rmse;
PlotRegionalTempFit(FitMayTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion9,titlestr)

% Continue with May-Region 10
MeasTimes=TimeFrac(:,5);
MeasTemps=MayTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Peru';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
[FitMayTempRegion10,gofMayRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofMayRegion10.adjrsquare;
rmse=gofMayRegion10.rmse;
GofStats1(5,10)=adjrsquare;
GofStats2(5,10)=rmse;
PlotRegionalTempFit(FitMayTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion10,titlestr)

%% Continue with Jun-Region 1
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Germany';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
[FitJunTempRegion1,gofJunRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion1.adjrsquare;
rmse=gofJunRegion1.rmse;
GofStats1(6,1)=adjrsquare;
GofStats2(6,1)=rmse;
PlotRegionalTempFit(FitJunTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion1,titlestr)

% Continue with Jun-Region 2
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Finland';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-June','-FitType-',num2str(ifittype));
[FitJunTempRegion2,gofJunRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion2.adjrsquare;
rmse=gofJunRegion2.rmse;
GofStats1(6,2)=adjrsquare;
GofStats2(6,2)=rmse;
PlotRegionalTempFit(FitJunTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion2,titlestr)

% Continue with Jun-Region 3
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='UK';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
[FitJunTempRegion3,gofJunRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion2.adjrsquare;
rmse=gofJunRegion2.rmse;
GofStats1(6,3)=adjrsquare;
GofStats2(6,3)=rmse;
PlotRegionalTempFit(FitJunTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion3,titlestr)

% Continue with Jun-Region 4
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Sudan';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
[FitJunTempRegion4,gofJunRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion4.adjrsquare;
rmse=gofJunRegion4.rmse;
GofStats1(6,4)=adjrsquare;
GofStats2(6,4)=rmse;
PlotRegionalTempFit(FitJunTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion4,titlestr)

% Continue with Jun-Region 5
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='SouthAfrica';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-June','-FitType-',num2str(ifittype));
[FitJunTempRegion5,gofJunRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion5.adjrsquare;
rmse=gofJunRegion5.rmse;
GofStats1(6,5)=adjrsquare;
GofStats2(6,5)=rmse;
PlotRegionalTempFit(FitJunTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion5,titlestr)

% Continue with Jun-Region 6
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='India';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
[FitJunTempRegion6,gofJunRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion6.adjrsquare;
rmse=gofJunRegion6.rmse;
GofStats1(6,6)=adjrsquare;
GofStats2(6,6)=rmse;
PlotRegionalTempFit(FitJunTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion6,titlestr)

% Continue with Jun-Region 7
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Australia';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
[FitJunTempRegion7,gofJunRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion7.adjrsquare;
rmse=gofJunRegion7.rmse;
GofStats1(6,7)=adjrsquare;
GofStats2(6,7)=rmse;
PlotRegionalTempFit(FitJunTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion7,titlestr)

% Continue with Jun-Region 8
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='California';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-June','-FitType-',num2str(ifittype));
[FitJunTempRegion8,gofJunRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion8.adjrsquare;
rmse=gofJunRegion8.rmse;
GofStats1(6,8)=adjrsquare;
GofStats2(6,8)=rmse;
PlotRegionalTempFit(FitJunTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion8,titlestr)

% Continue with Jun-Region 9
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Texas';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
[FitJunTempRegion9,gofJunRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion9.adjrsquare;
rmse=gofJunRegion9.rmse;
GofStats1(6,9)=adjrsquare;
GofStats2(6,9)=rmse;
PlotRegionalTempFit(FitJunTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion9,titlestr)

% Continue with Jun-Region 10
MeasTimes=TimeFrac(:,6);
MeasTemps=JunTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Peru';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
[FitJunTempRegion10,gofJunRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJunRegion10.adjrsquare;
rmse=gofJunRegion10.rmse;
GofStats1(6,10)=adjrsquare;
GofStats2(6,10)=rmse;
PlotRegionalTempFit(FitJunTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion10,titlestr)

%% Continue with July-Region 1
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Germany';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion1,gofJulRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion1.adjrsquare;
rmse=gofJulRegion1.rmse;
GofStats1(7,1)=adjrsquare;
GofStats2(7,1)=rmse;
PlotRegionalTempFit(FitJulTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion1,titlestr)

% Continue with Jul-Region 2
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Finland';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion2,gofJulRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion2.adjrsquare;
rmse=gofJulRegion2.rmse;
GofStats1(7,2)=adjrsquare;
GofStats2(7,2)=rmse;
PlotRegionalTempFit(FitJulTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion2,titlestr)

% Continue with Jul-Region 3
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='UK';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion3,gofJulRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion2.adjrsquare;
rmse=gofJulRegion2.rmse;
GofStats1(7,3)=adjrsquare;
GofStats2(7,3)=rmse;
PlotRegionalTempFit(FitJulTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion3,titlestr)

% Continue with Jul-Region 4
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Sudan';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion4,gofJulRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion4.adjrsquare;
rmse=gofJulRegion4.rmse;
GofStats1(7,4)=adjrsquare;
GofStats2(7,4)=rmse;
PlotRegionalTempFit(FitJulTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion4,titlestr)

% Continue with Jul-Region 5
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='SouthAfrica';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion5,gofJulRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion5.adjrsquare;
rmse=gofJulRegion5.rmse;
GofStats1(7,5)=adjrsquare;
GofStats2(7,5)=rmse;
PlotRegionalTempFit(FitJulTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion5,titlestr)

% Continue with Jul-Region 6
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='India';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion6,gofJulRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion6.adjrsquare;
rmse=gofJulRegion6.rmse;
GofStats1(7,6)=adjrsquare;
GofStats2(7,6)=rmse;
PlotRegionalTempFit(FitJulTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion6,titlestr)

% Continue with Jul-Region 7
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Australia';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion7,gofJulRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion7.adjrsquare;
rmse=gofJulRegion7.rmse;
GofStats1(7,7)=adjrsquare;
GofStats2(7,7)=rmse;
PlotRegionalTempFit(FitJulTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion7,titlestr)

% Continue with Jul-Region 8
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='California';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion8,gofJulRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion8.adjrsquare;
rmse=gofJulRegion8.rmse;
GofStats1(7,8)=adjrsquare;
GofStats2(7,8)=rmse;
PlotRegionalTempFit(FitJulTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion8,titlestr)

% Continue with Jul-Region 9
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Texas';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion9,gofJulRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion9.adjrsquare;
rmse=gofJulRegion9.rmse;
GofStats1(7,9)=adjrsquare;
GofStats2(7,9)=rmse;
PlotRegionalTempFit(FitJulTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion9,titlestr)

% Continue with Jul-Region 10
MeasTimes=TimeFrac(:,7);
MeasTemps=JulTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
RegionName='Peru';
titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
[FitJulTempRegion10,gofJulRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
adjrsquare=gofJulRegion10.adjrsquare;
rmse=gofJulRegion10.rmse;
GofStats1(7,10)=adjrsquare;
GofStats2(7,10)=rmse;
PlotRegionalTempFit(FitJulTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion10,titlestr)

%% Continue with August-Region 1
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Germany';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion1,gofAugRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion1.adjrsquare;
    rmse=gofAugRegion1.rmse;
    GofStats1(8,1)=adjrsquare;
    GofStats2(8,1)=rmse;
    PlotRegionalTempFit(FitAugTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion1,titlestr)
end
% Continue with Aug-Region 2
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Finland';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion2,gofAugRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion2.adjrsquare;
    rmse=gofAugRegion2.rmse;
    GofStats1(8,2)=adjrsquare;
    GofStats2(8,2)=rmse;
    PlotRegionalTempFit(FitAugTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion2,titlestr)
end
% Continue with Aug-Region 3
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='UK';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion3,gofAugRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion2.adjrsquare;
    rmse=gofAugRegion2.rmse;
    GofStats1(8,3)=adjrsquare;
    GofStats2(8,3)=rmse;
    PlotRegionalTempFit(FitAugTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion3,titlestr)
end

% Continue with Aug-Region 4
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Sudan';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion4,gofAugRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion4.adjrsquare;
    rmse=gofAugRegion4.rmse;
    GofStats1(8,4)=adjrsquare;
    GofStats2(8,4)=rmse;
    PlotRegionalTempFit(FitAugTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion4,titlestr)
end
% Continue with Aug-Region 5
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='SouthAfrica';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion5,gofAugRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion5.adjrsquare;
    rmse=gofAugRegion5.rmse;
    GofStats1(8,5)=adjrsquare;
    GofStats2(8,5)=rmse;
    PlotRegionalTempFit(FitAugTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion5,titlestr)
end

% Continue with Aug-Region 6
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='India';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion6,gofAugRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion6.adjrsquare;
    rmse=gofAugRegion6.rmse;
    GofStats1(8,6)=adjrsquare;
    GofStats2(8,6)=rmse;
    PlotRegionalTempFit(FitAugTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion6,titlestr)
end

% Continue with Aug-Region 7
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,7);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Australia';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion7,gofAugRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion7.adjrsquare;
    rmse=gofAugRegion7.rmse;
    GofStats1(8,7)=adjrsquare;
    GofStats2(8,7)=rmse;
    PlotRegionalTempFit(FitAugTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion7,titlestr)
end

% Continue with Aug-Region 8
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,8);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='California';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion8,gofAugRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion8.adjrsquare;
    rmse=gofAugRegion8.rmse;
    GofStats1(8,8)=adjrsquare;
    GofStats2(8,8)=rmse;
    PlotRegionalTempFit(FitAugTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion8,titlestr)
end

% Continue with Aug-Region 9
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,9);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Texas';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion9,gofAugRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion9.adjrsquare;
    rmse=gofAugRegion9.rmse;
    GofStats1(8,9)=adjrsquare;
    GofStats2(8,9)=rmse;
    PlotRegionalTempFit(FitAugTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion9,titlestr)
end
% Continue with Aug-Region 10
MeasTimes=TimeFrac(:,8);
MeasTemps=AugTemps(:,10);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Peru';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
    [FitAugTempRegion10,gofAugRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAugRegion10.adjrsquare;
    rmse=gofAugRegion10.rmse;
    GofStats1(8,10)=adjrsquare;
    GofStats2(8,10)=rmse;
    PlotRegionalTempFit(FitAugTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion10,titlestr)
end

%% Continue with Sep-Region 1
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
numvals=length(MeasTimes);
if(numvals>30)
    ifittype=2;
    RegionName='Germany';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion1,gofSepRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion1.adjrsquare;
    rmse=gofSepRegion1.rmse;
    GofStats1(9,1)=adjrsquare;
    GofStats2(9,1)=rmse;
    PlotRegionalTempFit(FitSepTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion1,titlestr)
end
% Continue with Sep-Region 2
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Finland';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion2,gofSepRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion2.adjrsquare;
    rmse=gofSepRegion2.rmse;
    GofStats1(9,2)=adjrsquare;
    GofStats2(9,2)=rmse;
    PlotRegionalTempFit(FitSepTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion2,titlestr)
end

% Continue with Sep-Region 3
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='UK';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion3,gofSepRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion2.adjrsquare;
    rmse=gofSepRegion2.rmse;
    GofStats1(9,3)=adjrsquare;
    GofStats2(9,3)=rmse;
    PlotRegionalTempFit(FitSepTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion3,titlestr)
end

% Continue with Sep-Region 4
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Sudan';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion4,gofSepRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion4.adjrsquare;
    rmse=gofSepRegion4.rmse;
    GofStats1(9,4)=adjrsquare;
    GofStats2(9,4)=rmse;
    PlotRegionalTempFit(FitSepTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion4,titlestr)
end

% Continue with Sep-Region 5
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='SouthAfrica';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion5,gofSepRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion5.adjrsquare;
    rmse=gofSepRegion5.rmse;
    GofStats1(9,5)=adjrsquare;
    GofStats2(9,5)=rmse;
    PlotRegionalTempFit(FitSepTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion5,titlestr)
end

% Continue with Sep-Region 6
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='India';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion6,gofSepRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion6.adjrsquare;
    rmse=gofSepRegion6.rmse;
    GofStats1(9,6)=adjrsquare;
    GofStats2(9,6)=rmse;
    PlotRegionalTempFit(FitSepTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion6,titlestr)
end

% Continue with Sep-Region 7
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Australia';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion7,gofSepRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion7.adjrsquare;
    rmse=gofSepRegion7.rmse;
    GofStats1(9,7)=adjrsquare;
    GofStats2(9,7)=rmse;
    PlotRegionalTempFit(FitSepTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion7,titlestr)
end
% Continue with Sep-Region 8
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
numvals=length(MeasTimes);
if(numvals>30)
    ifittype=2;
    RegionName='California';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion8,gofSepRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion8.adjrsquare;
    rmse=gofSepRegion8.rmse;
    GofStats1(9,8)=adjrsquare;
    GofStats2(9,8)=rmse;
    PlotRegionalTempFit(FitSepTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion8,titlestr)
end
% Continue with Sep-Region 9
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Texas';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion9,gofSepRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion9.adjrsquare;
    rmse=gofSepRegion9.rmse;
    GofStats1(9,9)=adjrsquare;
    GofStats2(9,9)=rmse;
    PlotRegionalTempFit(FitSepTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion9,titlestr)
end

% Continue with Sep-Region 10
MeasTimes=TimeFrac(:,9);
MeasTemps=SepTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Peru';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
    [FitSepTempRegion10,gofSepRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofSepRegion10.adjrsquare;
    rmse=gofSepRegion10.rmse;
    GofStats1(9,10)=adjrsquare;
    GofStats2(9,10)=rmse;
    PlotRegionalTempFit(FitSepTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion10,titlestr)
end

%% Continue with Oct-Region 1
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Germany';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion1,gofOctRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion1.adjrsquare;
    rmse=gofOctRegion1.rmse;
    GofStats1(10,1)=adjrsquare;
    GofStats2(10,1)=rmse;
    PlotRegionalTempFit(FitOctTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion1,titlestr)
end

% Continue with Oct-Region 2
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Finland';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion2,gofOctRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion2.adjrsquare;
    rmse=gofOctRegion2.rmse;
    GofStats1(10,2)=adjrsquare;
    GofStats2(10,2)=rmse;
    PlotRegionalTempFit(FitOctTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion2,titlestr)
end

% Continue with Oct-Region 3
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='UK';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion3,gofOctRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion2.adjrsquare;
    rmse=gofOctRegion2.rmse;
    GofStats1(10,3)=adjrsquare;
    GofStats2(10,3)=rmse;
    PlotRegionalTempFit(FitOctTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion3,titlestr)
end
% Continue with Oct-Region 4
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Sudan';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion4,gofOctRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion4.adjrsquare;
    rmse=gofOctRegion4.rmse;
    GofStats1(10,4)=adjrsquare;
    GofStats2(10,4)=rmse;
    PlotRegionalTempFit(FitOctTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion4,titlestr)
end

% Continue with Oct-Region 5
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='SouthAfrica';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion5,gofOctRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion5.adjrsquare;
    rmse=gofOctRegion5.rmse;
    GofStats1(10,5)=adjrsquare;
    GofStats2(10,5)=rmse;
    PlotRegionalTempFit(FitOctTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion5,titlestr)
end
% Continue with Oct-Region 6
MeasTimes=TimeFrac(:,1);
MeasTemps=OctTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='India';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion6,gofOctRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion6.adjrsquare;
    rmse=gofOctRegion6.rmse;
    GofStats1(10,6)=adjrsquare;
    GofStats2(10,6)=rmse;
    PlotRegionalTempFit(FitOctTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion6,titlestr)
end

% Continue with Oct-Region 7
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Australia';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion7,gofOctRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion7.adjrsquare;
    rmse=gofOctRegion7.rmse;
    GofStats1(10,7)=adjrsquare;
    GofStats2(10,7)=rmse;
    PlotRegionalTempFit(FitOctTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion7,titlestr)
end

% Continue with Oct-Region 8
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='California';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion8,gofOctRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion8.adjrsquare;
    rmse=gofOctRegion8.rmse;
    GofStats1(10,8)=adjrsquare;
    GofStats2(10,8)=rmse;
    PlotRegionalTempFit(FitOctTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion8,titlestr)
end
% Continue with Oct-Region 9
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
numvals=length(MeasTimes);
if(numvals>30)
    ifittype=2;
    RegionName='Texas';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion9,gofOctRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion9.adjrsquare;
    rmse=gofOctRegion9.rmse;
    GofStats1(10,9)=adjrsquare;
    GofStats2(10,9)=rmse;
    PlotRegionalTempFit(FitOctTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion9,titlestr)
end
% Continue with Oct-Region 10
MeasTimes=TimeFrac(:,10);
MeasTemps=OctTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Peru';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
    [FitOctTempRegion10,gofOctRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofOctRegion10.adjrsquare;
    rmse=gofOctRegion10.rmse;
    GofStats1(10,10)=adjrsquare;
    GofStats2(10,10)=rmse;
    PlotRegionalTempFit(FitOctTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion10,titlestr)
end

%% Continue with Nov-Region 1
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Germany';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion1,gofNovRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion1.adjrsquare;
    rmse=gofNovRegion1.rmse;
    GofStats1(11,1)=adjrsquare;
    GofStats2(11,1)=rmse;
    PlotRegionalTempFit(FitNovTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion1,titlestr)
end

% Continue with Nov-Region 2
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Finland';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion2,gofNovRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion2.adjrsquare;
    rmse=gofNovRegion2.rmse;
    GofStats1(11,2)=adjrsquare;
    GofStats2(11,2)=rmse;
    PlotRegionalTempFit(FitNovTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion2,titlestr)
end

% Continue with Nov-Region 3
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='UK';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion3,gofNovRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion2.adjrsquare;
    rmse=gofNovRegion2.rmse;
    GofStats1(11,3)=adjrsquare;
    GofStats2(11,3)=rmse;
    PlotRegionalTempFit(FitNovTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion3,titlestr)
end

% Continue with Nov-Region 4
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Sudan';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion4,gofNovRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion4.adjrsquare;
    rmse=gofNovRegion4.rmse;
    GofStats1(11,4)=adjrsquare;
    GofStats2(11,4)=rmse;
    PlotRegionalTempFit(FitNovTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion4,titlestr)
end

% Continue with Nov-Region 5
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='SouthAfrica';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion5,gofNovRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion5.adjrsquare;
    rmse=gofNovRegion5.rmse;
    GofStats1(11,5)=adjrsquare;
    GofStats2(11,5)=rmse;
    PlotRegionalTempFit(FitNovTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion5,titlestr)
end

% Continue with Nov-Region 6
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='India';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion6,gofNovRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion6.adjrsquare;
    rmse=gofNovRegion6.rmse;
    GofStats1(11,6)=adjrsquare;
    GofStats2(11,6)=rmse;
    PlotRegionalTempFit(FitNovTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion6,titlestr)
end

% Continue with Nov-Region 7
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Australia';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion7,gofNovRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion7.adjrsquare;
    rmse=gofNovRegion7.rmse;
    GofStats1(11,7)=adjrsquare;
    GofStats2(11,7)=rmse;
    PlotRegionalTempFit(FitNovTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion7,titlestr)
end

% Continue with Nov-Region 8
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='California';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion8,gofNovRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion8.adjrsquare;
    rmse=gofNovRegion8.rmse;
    GofStats1(11,8)=adjrsquare;
    GofStats2(11,8)=rmse;
    PlotRegionalTempFit(FitNovTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion8,titlestr)
end

% Continue with Nov-Region 9
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
numvals=length(MeasTimes);
if(numvals>30)
    ifittype=2;
    RegionName='Texas';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion9,gofNovRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion9.adjrsquare;
    rmse=gofNovRegion9.rmse;
    GofStats1(11,9)=adjrsquare;
    GofStats2(11,9)=rmse;
    PlotRegionalTempFit(FitNovTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion9,titlestr)
end

% Continue with Nov-Region 10
MeasTimes=TimeFrac(:,11);
MeasTemps=NovTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Peru';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
    [FitNovTempRegion10,gofNovRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofNovRegion10.adjrsquare;
    rmse=gofNovRegion10.rmse;
    GofStats1(11,10)=adjrsquare;
    GofStats2(11,10)=rmse;
    PlotRegionalTempFit(FitNovTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion10,titlestr)
end

%% Continue with Dec-Region 1
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,1);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Germany';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion1,gofDecRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion1.adjrsquare;
    rmse=gofDecRegion1.rmse;
    GofStats1(12,1)=adjrsquare;
    GofStats2(12,1)=rmse;
    PlotRegionalTempFit(FitDecTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion1,titlestr)
end

% Continue with Dec-Region 2
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,2);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Finland';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion2,gofDecRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion2.adjrsquare;
    rmse=gofDecRegion2.rmse;
    GofStats1(12,2)=adjrsquare;
    GofStats2(12,2)=rmse;
    PlotRegionalTempFit(FitDecTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion2,titlestr)
end

% Continue with Dec-Region 3
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,3);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='UK';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion3,gofDecRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion2.adjrsquare;
    rmse=gofDecRegion2.rmse;
    GofStats1(12,3)=adjrsquare;
    GofStats2(12,3)=rmse;
    PlotRegionalTempFit(FitDecTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion3,titlestr)
end

% Continue with Dec-Region 4
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,4);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Sudan';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion4,gofDecRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion4.adjrsquare;
    rmse=gofDecRegion4.rmse;
    GofStats1(12,4)=adjrsquare;
    GofStats2(12,4)=rmse;
    PlotRegionalTempFit(FitDecTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion4,titlestr)
end

% Continue with Dec-Region 5
MeasTimes=TimeFrac(:,12);
MeasTemps=NovTemps(:,5);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='SouthAfrica';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion5,gofDecRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion5.adjrsquare;
    rmse=gofDecRegion5.rmse;
    GofStats1(12,5)=adjrsquare;
    GofStats2(12,5)=rmse;
    PlotRegionalTempFit(FitDecTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion5,titlestr)
end

% Continue with Dec-Region 6
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,6);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='India';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion6,gofDecRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion6.adjrsquare;
    rmse=gofDecRegion6.rmse;
    GofStats1(12,6)=adjrsquare;
    GofStats2(12,6)=rmse;
    PlotRegionalTempFit(FitDecTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion6,titlestr)
end

% Continue with Dec-Region 7
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,7);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Australia';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion7,gofDecRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion7.adjrsquare;
    rmse=gofDecRegion7.rmse;
    GofStats1(12,7)=adjrsquare;
    GofStats2(12,7)=rmse;
    PlotRegionalTempFit(FitDecTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion7,titlestr)
end

% Continue with Dec-Region 8
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,8);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='California';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion8,gofDecRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion8.adjrsquare;
    rmse=gofDecRegion8.rmse;
    GofStats1(12,8)=adjrsquare;
    GofStats2(12,8)=rmse;
    PlotRegionalTempFit(FitDecTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion8,titlestr)
end

% Continue with Dec-Region 9
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,9);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
numvals=length(MeasTimes);
if(numvals>30)
    ifittype=2;
    RegionName='Texas';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion9,gofDecRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion9.adjrsquare;
    rmse=gofDecRegion9.rmse;
    GofStats1(12,9)=adjrsquare;
    GofStats2(12,9)=rmse;
    PlotRegionalTempFit(FitDecTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion9,titlestr)
end

% Continue with Dec-Region 10
MeasTimes=TimeFrac(:,12);
MeasTemps=DecTemps(:,10);
[MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
ifittype=2;
numvals=length(MeasTimes);
if(numvals>30)
    RegionName='Peru';
    titlestr=strcat('FittedTemp-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
    [FitDecTempRegion10,gofDecRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofDecRegion10.adjrsquare;
    rmse=gofDecRegion10.rmse;
    GofStats1(12,10)=adjrsquare;
    GofStats2(12,10)=rmse;
    PlotRegionalTempFit(FitDecTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion10,titlestr)
end


disp('Run Complete');
ab=1;