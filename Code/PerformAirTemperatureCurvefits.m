function PerformAirTemperatureCurvefits()
% This function is based on the standalone script TestMerra2DataCurveFits
% and will perform curvefits to the monthly averaged Temperature data
% for 10 separate regions and 12 months for the period 1980-2022
% Written By: Stephen Forczyk
% Created: Jan 5,2024
% Revised: Jan 17,2024 moved calculation of Tempchanges to the
% PlotRegionalTempConfidence.m function-delete call to
% PlotRegionalTempFit.m function
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
global QVSStatsFileName1;
global JanTemps FebTemps MarTemps AprTemps MayTemps JunTemps;
global JulTemps AugTemps SepTemps OctTemps NovTemps DecTemps;
global JanQV FebQV MarQV AprQV MayQV JunQV;
global JulQV AugQV SepQV OctQV NovQV DecQV;
global GofStats1 GofStats2;
global PredTempStart PredTempEnd PredTempChng;
global fitmonth fitregion;
global isavefiles MatFileName;
global MonthLabels RegionLabels;
global pslice heightkm DataCollectionTime;
global iMonthForPDF;


global Merra2ShortFileName;
global numtimeslice TimeSlices;
global Years Months Days;
global iTimeSlice iPress42 iPress72 iSelect;
global PressureLevel42 PressureLevel72 ;

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

global matpath datapath ;
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
%TempStatsFileName1='TSStatsTable199912-12-Hrs-GMT-PrsLvl-10.mat';
%TempStatsFileName2='TSStats2Table199912-12-Hrs-GMT-PrsLvl-10.mat';
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
chart_time=5;
%% Set up some Labels
MonthLabels=cell(12,1);
MonthLabels{1,1}='Jan';
MonthLabels{2,1}='Feb';
MonthLabels{3,1}='Mar';
MonthLabels{4,1}='Apr';
MonthLabels{5,1}='May';
MonthLabels{6,1}='Jun';
MonthLabels{7,1}='Jul';
MonthLabels{8,1}='Aug';
MonthLabels{9,1}='Sep';
MonthLabels{10,1}='Oct';
MonthLabels{11,1}='Nov';
MonthLabels{12,1}='Dec';
RegionLabels=cell(10,1);
RegionLabels{1,1}='Germany';
RegionLabels{2,1}='Finland';
RegionLabels{3,1}='UK';
RegionLabels{4,1}='Sudan';
RegionLabels{5,1}='South-Africa';
RegionLabels{6,1}='India';
RegionLabels{7,1}='Australia';
RegionLabels{8,1}='California';
RegionLabels{9,1}='Texas';
RegionLabels{10,1}='Peru';
iSelect=1;  
if(iSelect==1)
    TempStatsFileName1='FinalCombinedTSSTables.mat';
    MatFileName='AirTemperatureChanges.mat';
% Load the Temp Stats Timetables 1 and 2
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    load(TempStatsFileName1);
% Get the Height of the dataset pressure level
    iPress42=PresLvl;
    pslice=iPress42;
    heightkm=PressureLevel42(iPress42,3);
    DataCollectionTime=TimeStr;
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
    PredTempStart=zeros(12,10);
    PredTempEnd=zeros(12,10);
    PredTempChng=zeros(12,10);
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
    end
%% Establish if the Curve Fit toolbox is present
[CurveFitTooolBoxPresent] = ToolboxChecker('Curve Fitting Toolbox');
ab=1;
%% Now Fit the monthly data Region by Region and Month By Month
    fo=fitoptions('poly2');
    fo.Normalize='on';
    fitconf=0.75;
%    fo.Exclude=2001:2023;
%% Start with January-Region 1
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,1);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Germany';
     titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January'); titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
    [FitJanTempRegion1,gofJanRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion1.adjrsquare;
    rmse=gofJanRegion1.rmse;
    GofStats1(1,1)=adjrsquare;
    GofStats2(1,1)=rmse;
    fitmonth=1;
    fitregion=1;
%    titlestr=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-January');
%   PlotRegionalTempFit(FitJanTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion1,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion1,fitconf,titlestr2)

% Continue with Region 2
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,2);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Finland';
    [FitJanTempRegion2,gofJanRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion2.adjrsquare;
    rmse=gofJanRegion2.rmse;
    GofStats1(1,2)=adjrsquare;
    GofStats2(1,2)=rmse;
    fitmonth=1;
    fitregion=2;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion2,fitconf,titlestr2)

% Continue with Region 3
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,3);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='UK';
    [FitJanTempRegion3,gofJanRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion3.adjrsquare;
    rmse=gofJanRegion3.rmse;
    GofStats1(1,3)=adjrsquare;
    GofStats2(1,3)=rmse;
    fitmonth=1;
    fitregion=3;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion3,fitconf,titlestr2)

% Continue with Region 4
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,4);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Sudan';
    [FitJanTempRegion4,gofJanRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion4.adjrsquare;
    rmse=gofJanRegion4.rmse;
    GofStats1(1,4)=adjrsquare;
    GofStats2(1,4)=rmse;
    fitmonth=1;
    fitregion=4;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion4,fitconf,titlestr2)

% Continue with Region 5
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,5);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='SouthAfrica';
    [FitJanTempRegion5,gofJanRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion5.adjrsquare;
    rmse=gofJanRegion5.rmse;
    GofStats1(1,5)=adjrsquare;
    GofStats2(1,5)=rmse;
    fitmonth=1;
    fitregion=5;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion5,fitconf,titlestr2)

% Continue with January-Region 6
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,6);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='India';
    [FitJanTempRegion6,gofJanRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion6.adjrsquare;
    rmse=gofJanRegion6.rmse;
    GofStats1(1,6)=adjrsquare;
    GofStats2(1,6)=rmse;
    fitmonth=1;
    fitregion=6;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion6,fitconf,titlestr2)

% Continue with January-Region 7
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,7);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Australia';
    [FitJanTempRegion7,gofJanRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion7.adjrsquare;
    rmse=gofJanRegion7.rmse;
    GofStats1(1,7)=adjrsquare;
    GofStats2(1,7)=rmse;
    fitmonth=1;
    fitregion=7;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion7,fitconf,titlestr2)

% Continue with January-Region 8
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,8);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='California';
    [FitJanTempRegion8,gofJanRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion8.adjrsquare;
    rmse=gofJanRegion8.rmse;
    GofStats1(1,8)=adjrsquare;
    GofStats2(1,8)=rmse;
    fitmonth=1;
    fitregion=8;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion8,fitconf,titlestr2)

% Continue with January-Region 9
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,9);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Texas';
    [FitJanTempRegion9,gofJanRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion9.adjrsquare;
    rmse=gofJanRegion9.rmse;
    GofStats1(1,9)=adjrsquare;
    GofStats2(1,9)=rmse;
    fitmonth=1;
    fitregion=9;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion9,fitconf,titlestr2)

% Continue with January-Region 10
    MeasTimes=TimeFrac(:,1);
    MeasTemps=JanTemps(:,10);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Peru';
    [FitJanTempRegion10,gofJanRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJanRegion10.adjrsquare;
    rmse=gofJanRegion10.rmse;
    GofStats1(1,10)=adjrsquare;
    GofStats2(1,10)=rmse;
    fitmonth=1;
    fitregion=10;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JanuaryConf');
    PlotRegionalTempConfidence(FitJanTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJanRegion10,fitconf,titlestr2)

%% Continue with February-Region 1
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,1);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Germany';
    [FitFebTempRegion1,gofFebRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion1.adjrsquare;
    rmse=gofFebRegion1.rmse;
    GofStats1(2,1)=adjrsquare;
    GofStats2(2,1)=rmse;
    fitmonth=2;
    fitregion=1;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion1,fitconf,titlestr2)

% Continue with February-Region 2
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,2);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Finland';
    [FitFebTempRegion2,gofFebRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion2.adjrsquare;
    rmse=gofFebRegion2.rmse;
    GofStats1(2,2)=adjrsquare;
    GofStats2(2,2)=rmse;
    fitmonth=2;
    fitregion=2;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion2,fitconf,titlestr2)

% Continue with February-Region 3
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,3);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='UK';
    [FitFebTempRegion3,gofFebRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion3.adjrsquare;
    rmse=gofFebRegion3.rmse;
    GofStats1(2,3)=adjrsquare;
    GofStats2(2,3)=rmse;
    fitmonth=2;
    fitregion=3;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion3,fitconf,titlestr2)

% Continue with February-Region 4
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,4);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Sudan';
    [FitFebTempRegion4,gofFebRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion4.adjrsquare;
    rmse=gofFebRegion4.rmse;
    GofStats1(2,4)=adjrsquare;
    GofStats2(2,4)=rmse;
    fitmonth=2;
    fitregion=4;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion4,fitconf,titlestr2)

% Continue with February-Region 5
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,5);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='SouthAfrica';
    [FitFebTempRegion5,gofFebRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion5.adjrsquare;
    rmse=gofFebRegion5.rmse;
    GofStats1(2,5)=adjrsquare;
    GofStats2(2,5)=rmse;
    fitmonth=2;
    fitregion=5;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion5,fitconf,titlestr2)

% Continue with February-Region 6
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,6);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='India';
    [FitFebTempRegion6,gofFebRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion6.adjrsquare;
    rmse=gofFebRegion6.rmse;
    GofStats1(2,6)=adjrsquare;
    GofStats2(2,6)=rmse;
    fitmonth=2;
    fitregion=6;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion6,fitconf,titlestr2)

% Continue with February-Region 7
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,7);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Australia';
    [FitFebTempRegion7,gofFebRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion7.adjrsquare;
    rmse=gofFebRegion7.rmse;
    GofStats1(2,7)=adjrsquare;
    GofStats2(2,7)=rmse;
    fitmonth=2;
    fitregion=7;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion7,fitconf,titlestr2)

% Continue with February-Region 8
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,8);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='California';
    [FitFebTempRegion8,gofFebRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion8.adjrsquare;
    rmse=gofFebRegion8.rmse;
    GofStats1(2,8)=adjrsquare;
    GofStats2(2,8)=rmse;
    fitmonth=2;
    fitregion=8;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion8,fitconf,titlestr2)

% Continue with February-Region 9
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,9);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Texas';
    [FitFebTempRegion9,gofFebRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion9.adjrsquare;
    rmse=gofFebRegion9.rmse;
    GofStats1(2,9)=adjrsquare;
    GofStats2(2,9)=rmse;
    fitmonth=2;
    fitregion=9;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion9,fitconf,titlestr2)

% Continue with February-Region 10
    MeasTimes=TimeFrac(:,2);
    MeasTemps=FebTemps(:,10);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Peru';
    [FitFebTempRegion10,gofFebRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofFebRegion10.adjrsquare;
    rmse=gofFebRegion10.rmse;
    GofStats1(2,10)=adjrsquare;
    GofStats2(2,10)=rmse;
    fitmonth=2;
    fitregion=10;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-FebruaryConf');
    PlotRegionalTempConfidence(FitFebTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofFebRegion10,fitconf,titlestr2)

%% Continue with March-Region 1
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,1);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Germany';
    [FitMarTempRegion1,gofMarRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion1.adjrsquare;
    rmse=gofMarRegion1.rmse;
    GofStats1(3,1)=adjrsquare;
    GofStats2(3,1)=rmse;
    fitmonth=3;
    fitregion=1;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion1,fitconf,titlestr2)

% Continue with March-Region 2
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,2);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Finland';
    [FitMarTempRegion2,gofMarRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion2.adjrsquare;
    rmse=gofMarRegion2.rmse;
    GofStats1(3,2)=adjrsquare;
    GofStats2(3,2)=rmse;
    fitmonth=3;
    fitregion=2
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion2,fitconf,titlestr2)

% Continue with March-Region 3
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,3);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='UK';
    [FitMarTempRegion3,gofMarRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion2.adjrsquare;
    rmse=gofMarRegion2.rmse;
    GofStats1(3,3)=adjrsquare;
    GofStats2(3,3)=rmse;
    fitmonth=3;
    fitregion=3;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion3,fitconf,titlestr2)

% Continue with March-Region 4
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,4);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Sudan';
    [FitMarTempRegion4,gofMarRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion4.adjrsquare;
    rmse=gofMarRegion4.rmse;
    GofStats1(3,4)=adjrsquare;
    GofStats2(3,4)=rmse;
    fitmonth=3;
    fitregion=4;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion4,fitconf,titlestr2)

% Continue with March-Region 5
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,5);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='SouthAfrica';
    [FitMarTempRegion5,gofMarRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion5.adjrsquare;
    rmse=gofMarRegion5.rmse;
    GofStats1(3,5)=adjrsquare;
    GofStats2(3,5)=rmse;
    fitmonth=3;
    fitregion=5;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion5,fitconf,titlestr2)

% Continue with March-Region 6
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,6);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='India';
    [FitMarTempRegion6,gofMarRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion6.adjrsquare;
    rmse=gofMarRegion6.rmse;
    GofStats1(3,6)=adjrsquare;
    GofStats2(3,6)=rmse;
    fitmonth=3;
    fitregion=6;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion6,fitconf,titlestr2)

% Continue with March-Region 7
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,7);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Australia';
    [FitMarTempRegion7,gofMarRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion7.adjrsquare;
    rmse=gofMarRegion7.rmse;
    GofStats1(3,7)=adjrsquare;
    GofStats2(3,7)=rmse;
    fitmonth=3;
    fitregion=7;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion7,fitconf,titlestr2)

% Continue with March-Region 8
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,8);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='California';
    [FitMarTempRegion8,gofMarRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion8.adjrsquare;
    rmse=gofMarRegion8.rmse;
    GofStats1(3,8)=adjrsquare;
    GofStats2(3,8)=rmse;
    fitmonth=3;
    fitregion=8;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion8,fitconf,titlestr2)

% Continue with March-Region 9
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,9);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Texas';
    [FitMarTempRegion9,gofMarRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion9.adjrsquare;
    rmse=gofMarRegion9.rmse;
    GofStats1(3,9)=adjrsquare;
    GofStats2(3,9)=rmse;
    fitmonth=3;
    fitregion=9;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion9,fitconf,titlestr2)

% Continue with March-Region 10
    MeasTimes=TimeFrac(:,3);
    MeasTemps=MarTemps(:,10);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Peru';
    [FitMarTempRegion10,gofMarRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMarRegion10.adjrsquare;
    rmse=gofMarRegion10.rmse;
    GofStats1(3,10)=adjrsquare;
    GofStats2(3,10)=rmse;
    fitmonth=3;
    fitregion=10;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MarchConf');
    PlotRegionalTempConfidence(FitMarTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofMarRegion10,fitconf,titlestr2)

%% Continue with April-Region 1
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,1);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Germany';
    [FitAprTempRegion1,gofAprRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion1.adjrsquare;
    rmse=gofAprRegion1.rmse;
    GofStats1(4,1)=adjrsquare;
    GofStats2(4,1)=rmse;
    fitmonth=4;
    fitregion=1;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion1,fitconf,titlestr2)

% Continue with April-Region 2
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,2);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Finland';
    [FitAprTempRegion2,gofAprRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion2.adjrsquare;
    rmse=gofAprRegion2.rmse;
    GofStats1(4,2)=adjrsquare;
    GofStats2(4,2)=rmse;
    fitmonth=4;
    fitregion=2;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion2,fitconf,titlestr2)

% Continue with April-Region 3
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,3);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='UK';
    [FitAprTempRegion3,gofAprRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion2.adjrsquare;
    rmse=gofAprRegion2.rmse;
    GofStats1(4,3)=adjrsquare;
    GofStats2(4,3)=rmse;
    fitmonth=4;
    fitregion=3;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion3,fitconf,titlestr2)

% Continue with April-Region 4
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,4);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Sudan';
    [FitAprTempRegion4,gofAprRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion4.adjrsquare;
    rmse=gofAprRegion4.rmse;
    GofStats1(4,4)=adjrsquare;
    GofStats2(4,4)=rmse;
    fitmonth=4;
    fitregion=4;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion4,fitconf,titlestr2)

% Continue with Apr-Region 5
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,5);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='SouthAfrica';
    [FitAprTempRegion5,gofAprRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion5.adjrsquare;
    rmse=gofAprRegion5.rmse;
    GofStats1(4,5)=adjrsquare;
    GofStats2(4,5)=rmse;
    fitmonth=4;
    fitregion=5;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion5,fitconf,titlestr2)

% Continue with Apr-Region 6
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,6);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='India';
    [FitAprTempRegion6,gofAprRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion6.adjrsquare;
    rmse=gofAprRegion6.rmse;
    GofStats1(4,6)=adjrsquare;
    GofStats2(4,6)=rmse;
    fitmonth=4;
    fitregion=6;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion6,fitconf,titlestr2)

% Continue with April-Region 7
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,7);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Australia';
    [FitAprTempRegion7,gofAprRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion7.adjrsquare;
    rmse=gofAprRegion7.rmse;
    GofStats1(4,7)=adjrsquare;
    GofStats2(4,7)=rmse;
    fitmonth=4;
    fitregion=7;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion7,fitconf,titlestr2)

% Continue with April-Region 8
    MeasTimes=TimeFrac(:,4);
    MeasTemps=MarTemps(:,8);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='California';
    [FitAprTempRegion8,gofAprRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion8.adjrsquare;
    rmse=gofAprRegion8.rmse;
    GofStats1(4,8)=adjrsquare;
    GofStats2(4,8)=rmse;
    fitmonth=4;
    fitregion=8;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion8,fitconf,titlestr2)

% Continue with Apr-Region 9
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,9);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Texas';
    [FitAprTempRegion9,gofAprRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion9.adjrsquare;
    rmse=gofAprRegion9.rmse;
    GofStats1(4,9)=adjrsquare;
    GofStats2(4,9)=rmse;
    fitmonth=4;
    fitregion=9;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion9,fitconf,titlestr2)

% Continue with April-Region 10
    MeasTimes=TimeFrac(:,4);
    MeasTemps=AprTemps(:,10);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Peru';
    [FitAprTempRegion10,gofAprRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofAprRegion10.adjrsquare;
    rmse=gofAprRegion10.rmse;
    GofStats1(4,10)=adjrsquare;
    GofStats2(4,10)=rmse;
    fitmonth=4;
    fitregion=10;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AprilConf');
    PlotRegionalTempConfidence(FitAprTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofAprRegion10,fitconf,titlestr2)

%% Continue with May-Region 1
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,1);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Germany';
    [FitMayTempRegion1,gofMayRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion1.adjrsquare;
    rmse=gofMayRegion1.rmse;
    GofStats1(5,1)=adjrsquare;
    GofStats2(5,1)=rmse;
    fitmonth=5;
    fitregion=1;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion1,fitconf,titlestr2)

% Continue with May-Region 2
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,2);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Finland';
    [FitMayTempRegion2,gofMayRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion2.adjrsquare;
    rmse=gofMayRegion2.rmse;
    GofStats1(5,2)=adjrsquare;
    GofStats2(5,2)=rmse;
    fitmonth=5;
    fitregion=2;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion2,fitconf,titlestr2)

% Continue with May-Region 3
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,3);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='UK';
    [FitMayTempRegion3,gofMayRegion3] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion2.adjrsquare;
    rmse=gofMayRegion2.rmse;
    GofStats1(5,3)=adjrsquare;
    GofStats2(5,3)=rmse;
    fitmonth=5;
    fitregion=3;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion3,fitconf,titlestr2)

% Continue with May-Region 4
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,4);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Sudan';
    [FitMayTempRegion4,gofMayRegion4] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion4.adjrsquare;
    rmse=gofMayRegion4.rmse;
    GofStats1(5,4)=adjrsquare;
    GofStats2(5,4)=rmse;
    fitmonth=5;
    fitregion=4;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion4,fitconf,titlestr2)

% Continue with May-Region 5
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,5);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='SouthAfrica';
    [FitMayTempRegion5,gofMayRegion5] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion5.adjrsquare;
    rmse=gofMayRegion5.rmse;
    GofStats1(5,5)=adjrsquare;
    GofStats2(5,5)=rmse;
    fitmonth=5;
    fitregion=5;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion5,fitconf,titlestr2)

% Continue with May-Region 6
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,6);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='India';
    [FitMayTempRegion6,gofMayRegion6] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion6.adjrsquare;
    rmse=gofMayRegion6.rmse;
    GofStats1(5,6)=adjrsquare;
    GofStats2(5,6)=rmse;
    fitmonth=5;
    fitregion=6;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion6,fitconf,titlestr2)

% Continue with May-Region 7
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,7);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Australia';
    [FitMayTempRegion7,gofMayRegion7] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion7.adjrsquare;
    rmse=gofMayRegion7.rmse;
    GofStats1(5,7)=adjrsquare;
    GofStats2(5,7)=rmse;
    fitmonth=5;
    fitregion=7;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion7,fitconf,titlestr2)

% Continue with May-Region 8
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,8);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='California';
    [FitMayTempRegion8,gofMayRegion8] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion8.adjrsquare;
    rmse=gofMayRegion8.rmse;
    GofStats1(5,8)=adjrsquare;
    GofStats2(5,8)=rmse;
    fitmonth=5;
    fitregion=8;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion8,fitconf,titlestr2)

% Continue with May-Region 9
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,9);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Texas';
    [FitMayTempRegion9,gofMayRegion9] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion9.adjrsquare;
    rmse=gofMayRegion9.rmse;
    GofStats1(5,9)=adjrsquare;
    GofStats2(5,9)=rmse;
    fitmonth=5;
    fitregion=9;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion9,fitconf,titlestr2)

% Continue with May-Region 10
    MeasTimes=TimeFrac(:,5);
    MeasTemps=MayTemps(:,10);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Peru';
    [FitMayTempRegion10,gofMayRegion10] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofMayRegion10.adjrsquare;
    rmse=gofMayRegion10.rmse;
    GofStats1(5,10)=adjrsquare;
    GofStats2(5,10)=rmse;
    fitmonth=5;
    fitregion=10;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-MayConf');
    PlotRegionalTempConfidence(FitMayTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofMayRegion10,fitconf,titlestr2)

%% Continue with Jun-Region 1
    MeasTimes=TimeFrac(:,6);
    MeasTemps=JunTemps(:,1);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Germany';
    [FitJunTempRegion1,gofJunRegion1] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJunRegion1.adjrsquare;
    rmse=gofJunRegion1.rmse;
    GofStats1(6,1)=adjrsquare;
    GofStats2(6,1)=rmse;
    fitmonth=6;
    fitregion=1;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion1,fitconf,titlestr2)

% Continue with Jun-Region 2
    MeasTimes=TimeFrac(:,6);
    MeasTemps=JunTemps(:,2);
    [MeasTimes,MeasTemps] = RemoveMissingValues(MeasTimes,MeasTemps);
    ifittype=2;
    RegionName='Finland';
    [FitJunTempRegion2,gofJunRegion2] = fit(MeasTimes,MeasTemps,'poly2',fo);
    adjrsquare=gofJunRegion2.adjrsquare;
    rmse=gofJunRegion2.rmse;
    GofStats1(6,2)=adjrsquare;
    GofStats2(6,2)=rmse;
    fitmonth=6;
    fitregion=2;
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion2,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=3;
%    PlotRegionalTempFit(FitJunTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion3,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion3,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=4;
%    PlotRegionalTempFit(FitJunTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion4,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion4,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=5;
%    PlotRegionalTempFit(FitJunTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion5,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion5,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=6;
%    PlotRegionalTempFit(FitJunTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion6,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion6,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=7;
%    PlotRegionalTempFit(FitJunTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion7,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion7,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=8;
%    PlotRegionalTempFit(FitJunTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion8,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion8,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=9;
%    PlotRegionalTempFit(FitJunTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion9,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion9,fitconf,titlestr2)

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
    fitmonth=6;
    fitregion=10;
%    PlotRegionalTempFit(FitJunTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion10,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JuneConf');
    PlotRegionalTempConfidence(FitJunTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJunRegion10,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=1;
%    PlotRegionalTempFit(FitJulTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion1,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion1,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=2;
%    PlotRegionalTempFit(FitJulTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion2,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion2,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=3;
%    PlotRegionalTempFit(FitJulTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion3,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion3,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=4;
%    PlotRegionalTempFit(FitJulTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion4,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion4,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=5;
%    PlotRegionalTempFit(FitJulTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion5,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion5,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=6;
%    PlotRegionalTempFit(FitJulTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion6,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion6,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=7;
%    PlotRegionalTempFit(FitJulTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion7,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion7,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=8;
%    PlotRegionalTempFit(FitJulTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion8,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion8,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=9;
%    PlotRegionalTempFit(FitJulTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion9,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion9,fitconf,titlestr2)

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
    fitmonth=7;
    fitregion=10;
%    PlotRegionalTempFit(FitJulTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion10,titlestr)
    titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-JulyConf');
    PlotRegionalTempConfidence(FitJulTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofJulRegion10,fitconf,titlestr2)

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
        fitmonth=8;
        fitregion=1;
%        PlotRegionalTempFit(FitAugTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion1,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion1,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=2;
%        PlotRegionalTempFit(FitAugTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion2,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion2,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=3;
%        PlotRegionalTempFit(FitAugTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion3,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion3,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=4;
%        PlotRegionalTempFit(FitAugTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion4,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion4,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=5;
%        PlotRegionalTempFit(FitAugTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion5,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion5,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=6;
%        PlotRegionalTempFit(FitAugTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion6,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion6,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=7;
%        PlotRegionalTempFit(FitAugTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion7,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion7,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=8;
%        PlotRegionalTempFit(FitAugTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion8,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion8,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=9;
 %       PlotRegionalTempFit(FitAugTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion9,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion9,fitconf,titlestr2)
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
        fitmonth=8;
        fitregion=10;
 %       PlotRegionalTempFit(FitAugTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion10,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-AugConf');
        PlotRegionalTempConfidence(FitAugTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofAugRegion10,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=1;
 %       PlotRegionalTempFit(FitSepTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion1,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion1,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=2;
%        PlotRegionalTempFit(FitSepTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion2,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion2,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=3;
%        PlotRegionalTempFit(FitSepTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion3,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion3,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=4;
%        PlotRegionalTempFit(FitSepTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion4,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion4,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=5;
%        PlotRegionalTempFit(FitSepTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion5,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion5,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=6;
%        PlotRegionalTempFit(FitSepTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion6,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion6,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=7;
%        PlotRegionalTempFit(FitSepTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion7,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion7,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=8;
%        PlotRegionalTempFit(FitSepTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion8,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion8,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=9;
%        PlotRegionalTempFit(FitSepTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion9,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion9,fitconf,titlestr2)
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
        fitmonth=9;
        fitregion=10;
%        PlotRegionalTempFit(FitSepTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion10,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-SepConf');
        PlotRegionalTempConfidence(FitSepTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofSepRegion10,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=1;
%        PlotRegionalTempFit(FitOctTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion1,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion1,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=2;
%        PlotRegionalTempFit(FitOctTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion2,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion2,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=3;
%        PlotRegionalTempFit(FitOctTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion3,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion3,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=4;
%        PlotRegionalTempFit(FitOctTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion4,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion4,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=5;
%        PlotRegionalTempFit(FitOctTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion5,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion5,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=6;
%        PlotRegionalTempFit(FitOctTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion6,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion6,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=7;
%        PlotRegionalTempFit(FitOctTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion7,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion7,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=8;
%        PlotRegionalTempFit(FitOctTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion8,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion8,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=9;
 %       PlotRegionalTempFit(FitOctTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion9,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion9,fitconf,titlestr2)
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
        fitmonth=10;
        fitregion=10;
%        PlotRegionalTempFit(FitOctTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion10,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-OctConf');
        PlotRegionalTempConfidence(FitOctTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofOctRegion10,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=1;
%        PlotRegionalTempFit(FitNovTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion1,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion1,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=2;
 %       PlotRegionalTempFit(FitNovTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion2,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion2,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=3;
%        PlotRegionalTempFit(FitNovTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion3,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion3,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=4;
        PlotRegionalTempFit(FitNovTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion4,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion4,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=5;
  %      PlotRegionalTempFit(FitNovTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion5,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion5,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=6;
 %       PlotRegionalTempFit(FitNovTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion6,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion6,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=7;
%        PlotRegionalTempFit(FitNovTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion7,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion7,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=8;
%        PlotRegionalTempFit(FitNovTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion8,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion8,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=9;
%        PlotRegionalTempFit(FitNovTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion9,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion9,fitconf,titlestr2)
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
        fitmonth=11;
        fitregion=10;
%        PlotRegionalTempFit(FitNovTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion10,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-NovConf');
        PlotRegionalTempConfidence(FitNovTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofNovRegion10,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=1;
%        PlotRegionalTempFit(FitDecTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion1,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion1,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion1,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=2;
%        PlotRegionalTempFit(FitDecTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion2,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion2,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion2,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=3;
 %       PlotRegionalTempFit(FitDecTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion3,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion3,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion3,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=4;
  %      PlotRegionalTempFit(FitDecTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion4,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion4,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion4,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=5;
%        PlotRegionalTempFit(FitDecTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion5,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion5,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion5,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=6;
%        PlotRegionalTempFit(FitDecTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion6,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion6,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion6,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=7;
%        PlotRegionalTempFit(FitDecTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion7,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion7,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion7,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=8;
%        PlotRegionalTempFit(FitDecTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion8,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion8,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion8,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=9;
%        PlotRegionalTempFit(FitDecTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion9,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion9,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion9,fitconf,titlestr2)
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
        fitmonth=12;
        fitregion=10;
%        PlotRegionalTempFit(FitDecTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion10,titlestr)
        titlestr2=strcat('FittedTemp-Region-',RegionName,'-FitType-',num2str(ifittype),'-DecConf');
        PlotRegionalTempConfidence(FitDecTempRegion10,MeasTimes,MeasTemps,RegionName,ifittype,gofDecRegion10,fitconf,titlestr2)
    end
elseif(iSelect==2)
    QVSStatsFileName1='FinalCombinedQVSTables.mat';
    jpegpath='K:\Merra-2\netCDF\Dataset03\Jpeg_Test2\';
%% Work on the Specific Humidity Table
% Load the QVS Stats Timetable
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    load(QVSStatsFileName1);
    % Now run through the data to determine start and end points
    [nrowsTT,ncolsTT]=size(QVStatTT);
    starttime=QVStatTT.Time(1);
    startstr=char(string(starttime));
    endtime=QVStatTT.Time(nrowsTT);
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
    JanQV=zeros(numYears,10);
    FebQV=zeros(numYears,10);
    MarQV=zeros(numYears,10);
    AprQV=zeros(numYears,10);
    MayQV=zeros(numYears,10);
    JunQV=zeros(numYears,10);
    JulQV=zeros(numYears,10);
    AugQV=zeros(numYears,10);
    SepQV=zeros(numYears,10);
    OctQV=zeros(numYears,10);
    NovQV=zeros(numYears,10);
    DecQV=zeros(numYears,10);
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
        rowtime=QVStatTT.Time(i);
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
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik1=ik1+1;
            TimeFrac(ik1,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            JanQV(ik1,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            JanQV(ik1,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            JanQV(ik1,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            JanQV(ik1,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            JanQV(ik1,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            JanQV(ik1,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            JanQV(ik1,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            JanQV(ik1,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            JanQV(ik1,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            JanQV(ik1,10)=nowVal10;
        elseif(monthnum==2)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik2=ik2+1;
            TimeFrac(ik2,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            FebQV(ik2,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            FebQV(ik2,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            FebQV(ik2,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            FebQV(ik2,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            FebQV(ik2,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            FebQV(ik2,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            FebQV(ik2,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            FebQV(ik2,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            FebQV(ik2,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            FebQV(ik2,10)=nowVal10;
         elseif(monthnum==3)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik3=ik3+1;
            TimeFrac(ik3,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            MarQV(ik3,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            MarQV(ik3,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            MarQV(ik3,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            MarQV(ik3,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            MarQV(ik3,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            MarQV(ik3,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            MarQV(ik3,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            MarQV(ik3,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            MarQV(ik3,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            MarQV(ik3,10)=nowVal10;
            ab=3;
          elseif(monthnum==4)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik4=ik4+1;
            TimeFrac(ik4,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            AprQV(ik4,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            AprQV(ik4,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            AprQV(ik4,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            AprQV(ik4,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            AprQV(ik4,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            AprQV(ik4,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            AprQV(ik4,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            AprQV(ik4,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            AprQV(ik4,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            AprQV(ik4,10)=nowVal10;
            ab=4;
         elseif(monthnum==5)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik5=ik5+1;
            TimeFrac(ik5,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            MayQV(ik5,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            MayQV(ik5,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            MayQV(ik5,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            MayQV(ik5,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            MayQV(ik5,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            MayQV(ik5,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            MayQV(ik5,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            MayQV(ik5,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            MayQV(ik5,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            MayQV(ik5,10)=nowVal10;
          elseif(monthnum==6)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik6=ik6+1;
            TimeFrac(ik6,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            JunQV(ik6,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            JunQV(ik6,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            JunQV(ik6,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            JunQV(ik6,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            JunQV(ik6,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            JunQV(ik6,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            JunQV(ik6,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            JunQV(ik6,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            JunQV(ik6,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            JunQV(ik6,10)=nowVal10;
          elseif(monthnum==7)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik7=ik7+1;
            TimeFrac(ik7,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            JulQV(ik7,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            JulQV(ik7,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            JulQV(ik7,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            JulQV(ik7,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            JulQV(ik7,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            JulQV(ik7,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            JulQV(ik7,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            JulQV(ik7,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            JulQV(ik7,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            JulQV(ik7,10)=nowVal10;
            ab=7;
         elseif(monthnum==8)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik8=ik8+1;
            TimeFrac(ik8,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            AugQV(ik8,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            AugQV(ik8,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            AugQV(ik8,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            AugQV(ik8,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            AugQV(ik8,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            AugQV(ik8,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            AugQV(ik8,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            AugQV(ik8,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            AugQV(ik8,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            AugQV(ik8,10)=nowVal10;
          elseif(monthnum==9)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik9=ik9+1;
            TimeFrac(ik9,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            SepQV(ik9,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            SepQV(ik9,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            SepQV(ik9,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            SepQV(ik9,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            SepQV(ik9,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            SepQV(ik9,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            SepQV(ik9,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            SepQV(ik9,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            SepQV(ik9,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            SepQV(ik9,10)=nowVal10;
          elseif(monthnum==10)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik10=ik10+1;
            TimeFrac(ik10,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            OctQV(ik10,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            OctQV(ik10,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            OctQV(ik10,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            OctQV(ik10,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            OctQV(ik10,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            OctQV(ik10,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            OctQV(ik10,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            OctQV(ik10,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            OctQV(ik10,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            OctQV(ik10,10)=nowVal10;
          elseif(monthnum==11)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik11=ik11+1;
            TimeFrac(ik11,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            NovQV(ik11,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            NovQV(ik11,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            NovQV(ik11,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            NovQV(ik11,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            NovQV(ik11,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            NovQV(ik11,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            NovQV(ik11,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            NovQV(ik11,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            NovQV(ik11,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            NovQV(ik11,10)=nowVal10;
          elseif(monthnum==12)
            rowtime=QVStatTT.Time(i);
            rowstr=char(string(rowtime));
            [idash]=strfind(rowstr,'-');
            is=idash(2)+1;
            ie=is+3;
            rowYearstr=rowstr(is:ie);
            rowYear=str2double(rowYearstr);
            ik12=ik12+1;
            TimeFrac(ik12,monthnum)=rowYear+(monthnum-1)/12;
            nowVal1=QVStatTT.Germany(i);
            DecQV(ik12,1)=nowVal1;
            nowVal2=QVStatTT.Finland(i);
            DecQV(ik12,2)=nowVal2;
            nowVal3=QVStatTT.UK(i);
            DecQV(ik12,3)=nowVal3;
            nowVal4=QVStatTT.Sudan(i);
            DecQV(ik12,4)=nowVal4;
            nowVal5=QVStatTT.SouthAfrica(i);
            DecQV(ik12,5)=nowVal5;
            nowVal6=QVStat2TT.India(i);
            DecQV(ik12,6)=nowVal6;
            nowVal7=QVStat2TT.Australia(i);
            DecQV(ik12,7)=nowVal7;
            nowVal8=QVStat2TT.California(i);
            DecQV(ik12,8)=nowVal8;
            nowVal9=QVStat2TT.Texas(i);
            DecQV(ik12,9)=nowVal9;
            nowVal10=QVStat2TT.Peru(i);
            DecQV(ik12,10)=nowVal10;
            ab=12;
        end
    end
% Now Calculate and Plot the Curve Fits
    fo=fitoptions('poly2');
    fo.Normalize='on';
% Start With Jan for Region 1
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion1,gofJanRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion1.adjrsquare;
        rmse=gofJanRegion1.rmse;
        GofStats1(1,1)=adjrsquare;
        GofStats2(1,1)=rmse;
        PlotRegionalQVFit(FitJanQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion1,titlestr)
    end

% Continue With Jan Region 2
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion2,gofJanRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion2.adjrsquare;
        rmse=gofJanRegion2.rmse;
        GofStats1(1,2)=adjrsquare;
        GofStats2(1,2)=rmse;

        PlotRegionalQVFit(FitJanQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion2,titlestr)
    end

 % Continue With Jan Region 3
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion3,gofJanRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion3.adjrsquare;
        rmse=gofJanRegion3.rmse;
        GofStats1(1,3)=adjrsquare;
        GofStats2(1,3)=rmse;
        PlotRegionalQVFit(FitJanQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion3,titlestr)
    end

  % Continue With Jan Region 4
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion4,gofJanRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion4.adjrsquare;
        rmse=gofJanRegion4.rmse;
        GofStats1(1,4)=adjrsquare;
        GofStats2(1,4)=rmse;
        PlotRegionalQVFit(FitJanQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion4,titlestr)
    end

  % Continue With Jan Region 5
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion5,gofJanRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion5.adjrsquare;
        rmse=gofJanRegion5.rmse;
        GofStats1(1,5)=adjrsquare;
        GofStats2(1,5)=rmse;
        PlotRegionalQVFit(FitJanQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion5,titlestr)
    end

% Continue With Jan Region 6  
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion6,gofJanRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion6.adjrsquare;
        rmse=gofJanRegion6.rmse;
        GofStats1(1,6)=adjrsquare;
        GofStats2(1,6)=rmse;
        PlotRegionalQVFit(FitJanQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion6,titlestr)
    end

 % Continue With Jan Region 7  
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion7,gofJanRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion7.adjrsquare;
        rmse=gofJanRegion7.rmse;
        GofStats1(1,7)=adjrsquare;
        GofStats2(1,7)=rmse;
        PlotRegionalQVFit(FitJanQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion7,titlestr)
    end

  % Continue With Jan Region 8 
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion8,gofJanRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion8.adjrsquare;
        rmse=gofJanRegion8.rmse;
        GofStats1(1,8)=adjrsquare;
        GofStats2(1,8)=rmse;
        PlotRegionalQVFit(FitJanQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion8,titlestr)
    end

  % Continue With Jan Region 9
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion9,gofJanRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion9.adjrsquare;
        rmse=gofJanRegion9.rmse;
        GofStats1(1,9)=adjrsquare;
        GofStats2(1,9)=rmse;
        PlotRegionalQVFit(FitJanQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion9,titlestr)
    end

  % Continue With Jan Region 10
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion10,gofJanRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion10.adjrsquare;
        rmse=gofJanRegion10.rmse;
        GofStats1(1,10)=adjrsquare;
        GofStats2(1,10)=rmse;
        PlotRegionalQVFit(FitJanQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofJanRegion10,titlestr)
    end

% Start With Feb for Region 1
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion1,gofFebRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion1.adjrsquare;
        rmse=gofFebRegion1.rmse;
        GofStats1(2,1)=adjrsquare;
        GofStats2(2,1)=rmse;
        PlotRegionalQVFit(FitFebQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion1,titlestr)
    end

% Continue With Feb Region 2
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion2,gofFebRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion2.adjrsquare;
        rmse=gofFebRegion2.rmse;
        GofStats1(2,2)=adjrsquare;
        GofStats2(2,2)=rmse;
        PlotRegionalQVFit(FitFebQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion2,titlestr)
    end

 % Continue With Feb Region 3
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion3,gofFebRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion3.adjrsquare;
        rmse=gofFebRegion3.rmse;
        GofStats1(2,3)=adjrsquare;
        GofStats2(2,3)=rmse;
        PlotRegionalQVFit(FitFebQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion3,titlestr)
    end

  % Continue With Feb Region 4
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion4,gofFebRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion4.adjrsquare;
        rmse=gofFebRegion4.rmse;
        GofStats1(2,4)=adjrsquare;
        GofStats2(2,4)=rmse;
        PlotRegionalQVFit(FitFebQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion4,titlestr)
    end

  % Continue With Feb Region 5
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion5,gofFebRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion5.adjrsquare;
        rmse=gofFebRegion5.rmse;
        GofStats1(2,5)=adjrsquare;
        GofStats2(2,5)=rmse;
        PlotRegionalQVFit(FitFebQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion5,titlestr)
    end

% Continue With Feb Region 6  
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion6,gofFebRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion6.adjrsquare;
        rmse=gofFebRegion6.rmse;
        GofStats1(2,6)=adjrsquare;
        GofStats2(2,6)=rmse;
        PlotRegionalQVFit(FitFebQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion6,titlestr)
    end

 % Continue With Feb Region 7  
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion7,gofFebRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion7.adjrsquare;
        rmse=gofFebRegion7.rmse;
        GofStats1(2,7)=adjrsquare;
        GofStats2(2,7)=rmse;
        PlotRegionalQVFit(FitFebQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion7,titlestr)
    end

  % Continue With Feb Region 8 
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion8,gofFebRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion8.adjrsquare;
        rmse=gofFebRegion8.rmse;
        GofStats1(2,8)=adjrsquare;
        GofStats2(2,8)=rmse;
        PlotRegionalQVFit(FitFebQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion8,titlestr)
    end

  % Continue With Feb Region 9
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion9,gofFebRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion9.adjrsquare;
        rmse=gofFebRegion9.rmse;
        GofStats1(2,9)=adjrsquare;
        GofStats2(2,9)=rmse;
        PlotRegionalQVFit(FitFebQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion9,titlestr)
    end

  % Continue With Feb Region 10
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion10,gofFebRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion10.adjrsquare;
        rmse=gofFebRegion10.rmse;
        GofStats1(2,10)=adjrsquare;
        GofStats2(2,10)=rmse;
        PlotRegionalQVFit(FitFebQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofFebRegion10,titlestr)
    end

 % Start With Mar for Region 1
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion1,gofMarRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion1.adjrsquare;
        rmse=gofMarRegion1.rmse;
        GofStats1(3,1)=adjrsquare;
        GofStats2(3,1)=rmse;
        PlotRegionalQVFit(FitMarQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion1,titlestr)
    end

% Continue With Mar Region 2
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion2,gofMarRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion2.adjrsquare;
        rmse=gofMarRegion2.rmse;
        GofStats1(3,2)=adjrsquare;
        GofStats2(3,2)=rmse;
        PlotRegionalQVFit(FitMarQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion2,titlestr)
    end

 % Continue With Mar Region 3
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion3,gofMarRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion3.adjrsquare;
        rmse=gofMarRegion3.rmse;
        GofStats1(3,3)=adjrsquare;
        GofStats2(3,3)=rmse;
        PlotRegionalQVFit(FitMarQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion3,titlestr)
    end

  % Continue With Mar Region 4
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion4,gofMarRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion4.adjrsquare;
        rmse=gofMarRegion4.rmse;
        GofStats1(3,4)=adjrsquare;
        GofStats2(3,4)=rmse;
        PlotRegionalQVFit(FitMarQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion4,titlestr)
    end

  % Continue With Mar Region 5
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion5,gofMarRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion5.adjrsquare;
        rmse=gofMarRegion5.rmse;
        GofStats1(3,5)=adjrsquare;
        GofStats2(3,5)=rmse;
        PlotRegionalQVFit(FitMarQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion5,titlestr)
    end

% Continue With Mar Region 6  
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion6,gofMarRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion6.adjrsquare;
        rmse=gofMarRegion6.rmse;
        GofStats1(3,6)=adjrsquare;
        GofStats2(3,6)=rmse;
        PlotRegionalQVFit(FitMarQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion6,titlestr)
    end

 % Continue With Mar Region 7  
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion7,gofMarRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion7.adjrsquare;
        rmse=gofMarRegion7.rmse;
        GofStats1(3,7)=adjrsquare;
        GofStats2(3,7)=rmse;
        PlotRegionalQVFit(FitMarQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion7,titlestr)
    end

  % Continue With Mar Region 8 
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion8,gofMarRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion8.adjrsquare;
        rmse=gofMarRegion8.rmse;
        GofStats1(3,8)=adjrsquare;
        GofStats2(3,8)=rmse;
        PlotRegionalQVFit(FitMarQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion8,titlestr)
    end

  % Continue With Mar Region 9
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion9,gofMarRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion9.adjrsquare;
        rmse=gofMarRegion9.rmse;
        GofStats1(3,9)=adjrsquare;
        GofStats2(3,9)=rmse;
        PlotRegionalQVFit(FitMarQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion9,titlestr)
    end

  % Continue With Mar Region 10
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion10,gofMarRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion10.adjrsquare;
        rmse=gofMarRegion10.rmse;
        GofStats1(3,10)=adjrsquare;
        GofStats2(3,10)=rmse;
        PlotRegionalQVFit(FitMarQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofMarRegion10,titlestr)
    end

 % Start With Apr for Region 1
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion1,gofAprRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion1.adjrsquare;
        rmse=gofAprRegion1.rmse;
        GofStats1(4,1)=adjrsquare;
        GofStats2(4,1)=rmse;
        PlotRegionalQVFit(FitAprQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion1,titlestr)
    end

% Continue With Apr Region 2
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion2,gofAprRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion2.adjrsquare;
        rmse=gofAprRegion2.rmse;
        GofStats1(4,2)=adjrsquare;
        GofStats2(4,2)=rmse;
        PlotRegionalQVFit(FitAprQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion2,titlestr)
    end

 % Continue With Apr Region 3
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion3,gofAprRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion3.adjrsquare;
        rmse=gofAprRegion3.rmse;
        GofStats1(4,3)=adjrsquare;
        GofStats2(4,3)=rmse;
        PlotRegionalQVFit(FitAprQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion3,titlestr)
    end

  % Continue With Apr Region 4
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion4,gofAprRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion4.adjrsquare;
        rmse=gofAprRegion4.rmse;
        GofStats1(4,4)=adjrsquare;
        GofStats2(4,4)=rmse;
        PlotRegionalQVFit(FitAprQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion4,titlestr)
    end

  % Continue With Apr Region 5
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion5,gofAprRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion5.adjrsquare;
        rmse=gofAprRegion5.rmse;
        GofStats1(4,5)=adjrsquare;
        GofStats2(4,5)=rmse;
        PlotRegionalQVFit(FitAprQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion5,titlestr)
    end

% Continue With Apr Region 6  
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion6,gofAprRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion6.adjrsquare;
        rmse=gofAprRegion6.rmse;
        GofStats1(4,6)=adjrsquare;
        GofStats2(4,6)=rmse;
        PlotRegionalQVFit(FitAprQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion6,titlestr)
    end

 % Continue With Apr Region 7  
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion7,gofAprRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion7.adjrsquare;
        rmse=gofAprRegion7.rmse;
        GofStats1(4,7)=adjrsquare;
        GofStats2(4,7)=rmse;
        PlotRegionalQVFit(FitAprQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion7,titlestr)
    end

  % Continue With Apr Region 8 
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion8,gofAprRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion8.adjrsquare;
        rmse=gofAprRegion8.rmse;
        GofStats1(4,8)=adjrsquare;
        GofStats2(4,8)=rmse;
        PlotRegionalQVFit(FitAprQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion8,titlestr)
    end

  % Continue With Apr Region 9
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion9,gofAprRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion9.adjrsquare;
        rmse=gofAprRegion9.rmse;
        GofStats1(4,9)=adjrsquare;
        GofStats2(4,9)=rmse;
        PlotRegionalQVFit(FitAprQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion9,titlestr)
    end

  % Continue With Apr Region 10
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion10,gofAprRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion10.adjrsquare;
        rmse=gofAprRegion10.rmse;        
        GofStats1(4,10)=adjrsquare;
        GofStats2(4,10)=rmse;
        PlotRegionalQVFit(FitAprQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofAprRegion10,titlestr)
    end

  % Start With May for Region 1
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion1,gofMayRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion1.adjrsquare;
        rmse=gofMayRegion1.rmse;
        GofStats1(5,1)=adjrsquare;
        GofStats2(5,1)=rmse;
        PlotRegionalQVFit(FitMayQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion1,titlestr)
    end

% Continue With May Region 2
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion2,gofMayRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion2.adjrsquare;
        rmse=gofMayRegion2.rmse;
        GofStats1(5,2)=adjrsquare;
        GofStats2(5,2)=rmse;
        PlotRegionalQVFit(FitMayQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion2,titlestr)
    end

 % Continue With May Region 3
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion3,gofMayRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion3.adjrsquare;
        rmse=gofMayRegion3.rmse;
        GofStats1(5,3)=adjrsquare;
        GofStats2(5,3)=rmse;
        PlotRegionalQVFit(FitMayQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion3,titlestr)
    end

  % Continue With May Region 4
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion4,gofMayRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion4.adjrsquare;
        rmse=gofMayRegion4.rmse;
        GofStats1(5,4)=adjrsquare;
        GofStats2(5,4)=rmse;
        PlotRegionalQVFit(FitMayQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion4,titlestr)
    end

  % Continue With May Region 5
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion5,gofMayRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion5.adjrsquare;
        rmse=gofMayRegion5.rmse;
        GofStats1(5,5)=adjrsquare;
        GofStats2(5,5)=rmse;
        PlotRegionalQVFit(FitMayQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion5,titlestr)
    end

% Continue With May Region 6  
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion6,gofMayRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion6.adjrsquare;
        rmse=gofMayRegion6.rmse;
        GofStats1(5,6)=adjrsquare;
        GofStats2(5,6)=rmse;
        PlotRegionalQVFit(FitMayQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion6,titlestr)
    end

 % Continue With May Region 7  
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion7,gofMayRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion7.adjrsquare;
        rmse=gofMayRegion7.rmse;
        GofStats1(5,7)=adjrsquare;
        GofStats2(5,7)=rmse;
        PlotRegionalQVFit(FitMayQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion7,titlestr)
    end

  % Continue With May Region 8 
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion8,gofMayRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion8.adjrsquare;
        rmse=gofMayRegion8.rmse;
        GofStats1(5,8)=adjrsquare;
        GofStats2(5,8)=rmse;
        PlotRegionalQVFit(FitMayQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion8,titlestr)
    end

  % Continue With May Region 9
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion9,gofMayRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion9.adjrsquare;
        rmse=gofMayRegion9.rmse;
        GofStats1(5,9)=adjrsquare;
        GofStats2(5,9)=rmse;
        PlotRegionalQVFit(FitMayQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion9,titlestr)
    end

  % Continue With May Region 10
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion10,gofMayRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion10.adjrsquare;
        rmse=gofMayRegion10.rmse;        
        GofStats1(5,10)=adjrsquare;
        GofStats2(5,10)=rmse;
        PlotRegionalQVFit(FitMayQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofMayRegion10,titlestr)
    end

  % Start With June for Region 1
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-June','-FitType-',num2str(ifittype));
        [FitJunQVRegion1,gofJunRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion1.adjrsquare;
        rmse=gofJunRegion1.rmse;
        GofStats1(6,1)=adjrsquare;
        GofStats2(6,1)=rmse;
        PlotRegionalQVFit(FitJunQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion1,titlestr)
    end

% Continue With Jun Region 2
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion2,gofJunRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion2.adjrsquare;
        rmse=gofJunRegion2.rmse;
        GofStats1(6,2)=adjrsquare;
        GofStats2(6,2)=rmse;
        PlotRegionalQVFit(FitJunQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion2,titlestr)
    end

 % Continue With Jun Region 3
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion3,gofJunRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion3.adjrsquare;
        rmse=gofJunRegion3.rmse;
        GofStats1(6,3)=adjrsquare;
        GofStats2(6,3)=rmse;
        PlotRegionalQVFit(FitJunQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion3,titlestr)
    end

  % Continue With Jun Region 4
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion4,gofJunRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion4.adjrsquare;
        rmse=gofJunRegion4.rmse;
        GofStats1(6,4)=adjrsquare;
        GofStats2(6,4)=rmse;
        PlotRegionalQVFit(FitJunQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion4,titlestr)
    end

  % Continue With Jun Region 5
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion5,gofJunRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion5.adjrsquare;
        rmse=gofJunRegion5.rmse;
        GofStats1(6,5)=adjrsquare;
        GofStats2(6,5)=rmse;
        PlotRegionalQVFit(FitJunQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion5,titlestr)
    end

% Continue With Jun Region 6  
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion6,gofJunRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion6.adjrsquare;
        rmse=gofJunRegion6.rmse;
        GofStats1(6,6)=adjrsquare;
        GofStats2(6,6)=rmse;
        PlotRegionalQVFit(FitJunQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion6,titlestr)
    end

 % Continue With JUn Region 7  
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion7,gofJunRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion7.adjrsquare;
        rmse=gofJunRegion7.rmse;
        GofStats1(6,7)=adjrsquare;
        GofStats2(6,7)=rmse;
        PlotRegionalQVFit(FitJunQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion7,titlestr)
    end

  % Continue With Jun Region 8 
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion8,gofJunRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion8.adjrsquare;
        rmse=gofJunRegion8.rmse;
        GofStats1(6,8)=adjrsquare;
        GofStats2(6,8)=rmse;
        PlotRegionalQVFit(FitJunQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion8,titlestr)
    end

  % Continue With Jun Region 9
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion9,gofJunRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion9.adjrsquare;
        rmse=gofJunRegion9.rmse;
        GofStats1(6,9)=adjrsquare;
        GofStats2(6,9)=rmse;
        PlotRegionalQVFit(FitJunQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion9,titlestr)
    end

  % Continue With Jun Region 10
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion10,gofJunRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion10.adjrsquare;
        rmse=gofJunRegion10.rmse;        
        GofStats1(6,10)=adjrsquare;
        GofStats2(6,10)=rmse;
        PlotRegionalQVFit(FitJunQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofJunRegion10,titlestr)
    end

  % Start With July for Region 1
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-July','-FitType-',num2str(ifittype));
        [FitJulQVRegion1,gofJulRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion1.adjrsquare;
        rmse=gofJulRegion1.rmse;
        GofStats1(7,1)=adjrsquare;
        GofStats2(7,1)=rmse;
        PlotRegionalQVFit(FitJulQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion1,titlestr)
    end

% Continue With July Region 2
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion2,gofJulRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion2.adjrsquare;
        rmse=gofJulRegion2.rmse;
        GofStats1(7,2)=adjrsquare;
        GofStats2(7,2)=rmse;
        PlotRegionalQVFit(FitJulQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion2,titlestr)
    end

 % Continue With July Region 3
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion3,gofJulRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion3.adjrsquare;
        rmse=gofJulRegion3.rmse;
        GofStats1(7,3)=adjrsquare;
        GofStats2(7,3)=rmse;
        PlotRegionalQVFit(FitJulQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion3,titlestr)
    end

  % Continue With Jul Region 4
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion4,gofJulRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion4.adjrsquare;
        rmse=gofJulRegion4.rmse;
        GofStats1(7,4)=adjrsquare;
        GofStats2(7,4)=rmse;
        PlotRegionalQVFit(FitJulQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion4,titlestr)
    end

  % Continue With Jul Region 5
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion5,gofJulRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion5.adjrsquare;
        rmse=gofJulRegion5.rmse;
        GofStats1(7,5)=adjrsquare;
        GofStats2(7,5)=rmse;
        PlotRegionalQVFit(FitJulQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion5,titlestr)
    end

% Continue With Jul Region 6  
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion6,gofJulRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion6.adjrsquare;
        rmse=gofJulRegion6.rmse;
        GofStats1(7,6)=adjrsquare;
        GofStats2(7,6)=rmse;
        PlotRegionalQVFit(FitJulQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion6,titlestr)
    end

 % Continue With Jul Region 7  
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion7,gofJulRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion7.adjrsquare;
        rmse=gofJulRegion7.rmse;
        GofStats1(7,7)=adjrsquare;
        GofStats2(7,7)=rmse;
        PlotRegionalQVFit(FitJulQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion7,titlestr)
    end

  % Continue With Jul Region 8 
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion8,gofJulRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion8.adjrsquare;
        rmse=gofJulRegion8.rmse;
        GofStats1(7,8)=adjrsquare;
        GofStats2(7,8)=rmse;
        PlotRegionalQVFit(FitJulQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion8,titlestr)
    end

  % Continue With Jul Region 9
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion9,gofJulRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion9.adjrsquare;
        rmse=gofJulRegion9.rmse;
        GofStats1(7,9)=adjrsquare;
        GofStats2(7,9)=rmse;
        PlotRegionalQVFit(FitJulQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion9,titlestr)
    end

  % Continue With Jul Region 10
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion10,gofJulRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion10.adjrsquare;
        rmse=gofJulRegion10.rmse;        
        GofStats1(7,10)=adjrsquare;
        GofStats2(7,10)=rmse;
        PlotRegionalQVFit(FitJulQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofJulRegion10,titlestr)
    end

  % Start With Aug for Region 1
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion1,gofAugRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion1.adjrsquare;
        rmse=gofAugRegion1.rmse;
        GofStats1(8,1)=adjrsquare;
        GofStats2(8,1)=rmse;
        PlotRegionalQVFit(FitAugQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion1,titlestr)
    end

% Continue With Aug Region 2
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion2,gofAugRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion2.adjrsquare;
        rmse=gofAugRegion2.rmse;
        GofStats1(8,2)=adjrsquare;
        GofStats2(8,2)=rmse;
        PlotRegionalQVFit(FitAugQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion2,titlestr)
    end

 % Continue With Aug Region 3
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion3,gofAugRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion3.adjrsquare;
        rmse=gofAugRegion3.rmse;
        GofStats1(8,3)=adjrsquare;
        GofStats2(8,3)=rmse;
        PlotRegionalQVFit(FitAugQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion3,titlestr)
    end

  % Continue With Aug Region 4
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion4,gofAugRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion4.adjrsquare;
        rmse=gofAugRegion4.rmse;
        GofStats1(8,4)=adjrsquare;
        GofStats2(8,4)=rmse;
        PlotRegionalQVFit(FitAugQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion4,titlestr)
    end

  % Continue With Aug Region 5
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion5,gofAugRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion5.adjrsquare;
        rmse=gofAugRegion5.rmse;
        GofStats1(8,5)=adjrsquare;
        GofStats2(8,5)=rmse;
        PlotRegionalQVFit(FitAugQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion5,titlestr)
    end

% Continue With Aug Region 6  
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion6,gofAugRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion6.adjrsquare;
        rmse=gofAugRegion6.rmse;
        GofStats1(8,6)=adjrsquare;
        GofStats2(8,6)=rmse;
        PlotRegionalQVFit(FitAugQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion6,titlestr)
    end

 % Continue With Aug Region 7  
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion7,gofAugRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion7.adjrsquare;
        rmse=gofAugRegion7.rmse;
        GofStats1(8,7)=adjrsquare;
        GofStats2(8,7)=rmse;
        PlotRegionalQVFit(FitAugQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion7,titlestr)
    end

  % Continue With Aug Region 8 
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion8,gofAugRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion8.adjrsquare;
        rmse=gofAugRegion8.rmse;
        GofStats1(8,8)=adjrsquare;
        GofStats2(8,8)=rmse;
        PlotRegionalQVFit(FitAugQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion8,titlestr)
    end

  % Continue With Aug Region 9
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion9,gofAugRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion9.adjrsquare;
        rmse=gofAugRegion9.rmse;
        GofStats1(8,9)=adjrsquare;
        GofStats2(8,9)=rmse;
        PlotRegionalQVFit(FitAugQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion9,titlestr)
    end

  % Continue With Aug Region 10
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion10,gofAugRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion10.adjrsquare;
        rmse=gofAugRegion10.rmse;        
        GofStats1(8,10)=adjrsquare;
        GofStats2(8,10)=rmse;
        PlotRegionalQVFit(FitAugQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofAugRegion10,titlestr)
    end

  % Start With Sep for Region 1
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion1,gofSepRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion1.adjrsquare;
        rmse=gofSepRegion1.rmse;
        GofStats1(9,1)=adjrsquare;
        GofStats2(9,1)=rmse;
        PlotRegionalQVFit(FitSepQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion1,titlestr)
    end

% Continue With Sep Region 2
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion2,gofSepRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion2.adjrsquare;
        rmse=gofSepRegion2.rmse;
        GofStats1(9,2)=adjrsquare;
        GofStats2(9,2)=rmse;
        PlotRegionalQVFit(FitSepQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion2,titlestr)
    end

 % Continue With Sep Region 3
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion3,gofSepRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion3.adjrsquare;
        rmse=gofSepRegion3.rmse;
        GofStats1(9,3)=adjrsquare;
        GofStats2(9,3)=rmse;
        PlotRegionalQVFit(FitSepQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion3,titlestr)
    end

  % Continue With Sep Region 4
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion4,gofSepRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion4.adjrsquare;
        rmse=gofSepRegion4.rmse;
        GofStats1(9,4)=adjrsquare;
        GofStats2(9,4)=rmse;
        PlotRegionalQVFit(FitSepQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion4,titlestr)
    end

  % Continue With Sep Region 5
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion5,gofSepRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion5.adjrsquare;
        rmse=gofSepRegion5.rmse;
        GofStats1(9,5)=adjrsquare;
        GofStats2(9,5)=rmse;
        PlotRegionalQVFit(FitSepQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion5,titlestr)
    end

% Continue With Sep Region 6  
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion6,gofSepRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion6.adjrsquare;
        rmse=gofSepRegion6.rmse;
        GofStats1(9,6)=adjrsquare;
        GofStats2(9,6)=rmse;
        PlotRegionalQVFit(FitSepQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion6,titlestr)
    end

 % Continue With Sep Region 7  
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion7,gofSepRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion7.adjrsquare;
        rmse=gofSepRegion7.rmse;
        GofStats1(9,7)=adjrsquare;
        GofStats2(9,7)=rmse;
        PlotRegionalQVFit(FitSepQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion7,titlestr)
    end

  % Continue With Sep Region 8 
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion8,gofSepRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion8.adjrsquare;
        rmse=gofSepRegion8.rmse;
        GofStats1(9,8)=adjrsquare;
        GofStats2(9,8)=rmse;
        PlotRegionalQVFit(FitSepQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion8,titlestr)
    end

  % Continue With Sep Region 9
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion9,gofSepRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion9.adjrsquare;
        rmse=gofSepRegion9.rmse;
        GofStats1(9,9)=adjrsquare;
        GofStats2(9,9)=rmse;
        PlotRegionalQVFit(FitSepQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion9,titlestr)
    end

  % Continue With Sep Region 10
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion10,gofSepRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion10.adjrsquare;
        rmse=gofSepRegion10.rmse;        
        GofStats1(9,10)=adjrsquare;
        GofStats2(9,10)=rmse;
        PlotRegionalQVFit(FitSepQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofSepRegion10,titlestr)
    end

 % Start With Oct for Region 1
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion1,gofOctRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion1.adjrsquare;
        rmse=gofOctRegion1.rmse;
        GofStats1(10,1)=adjrsquare;
        GofStats2(10,1)=rmse;
        PlotRegionalQVFit(FitOctQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion1,titlestr)
    end

% Continue With Oct Region 2
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion2,gofOctRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion2.adjrsquare;
        rmse=gofOctRegion2.rmse;
        GofStats1(10,2)=adjrsquare;
        GofStats2(10,2)=rmse;
        PlotRegionalQVFit(FitOctQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion2,titlestr)
    end

 % Continue With Oct Region 3
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion3,gofOctRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion3.adjrsquare;
        rmse=gofOctRegion3.rmse;
        GofStats1(10,3)=adjrsquare;
        GofStats2(10,3)=rmse;
        PlotRegionalQVFit(FitOctQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion3,titlestr)
    end

  % Continue With Oct Region 4
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion4,gofOctRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion4.adjrsquare;
        rmse=gofOctRegion4.rmse;
        GofStats1(10,4)=adjrsquare;
        GofStats2(10,4)=rmse;
        PlotRegionalQVFit(FitOctQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion4,titlestr)
    end

  % Continue With Oct Region 5
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion5,gofOctRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion5.adjrsquare;
        rmse=gofOctRegion5.rmse;
        GofStats1(10,5)=adjrsquare;
        GofStats2(10,5)=rmse;
        PlotRegionalQVFit(FitOctQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion5,titlestr)
    end

% Continue With Oct Region 6  
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion6,gofOctRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion6.adjrsquare;
        rmse=gofOctRegion6.rmse;
        GofStats1(10,6)=adjrsquare;
        GofStats2(10,6)=rmse;
        PlotRegionalQVFit(FitOctQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion6,titlestr)
    end

 % Continue With Oct Region 7  
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion7,gofOctRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion7.adjrsquare;
        rmse=gofOctRegion7.rmse;
        GofStats1(10,7)=adjrsquare;
        GofStats2(10,7)=rmse;
        PlotRegionalQVFit(FitOctQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion7,titlestr)
    end

  % Continue With Oct Region 8 
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion8,gofOctRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion8.adjrsquare;
        rmse=gofOctRegion8.rmse;
        GofStats1(10,8)=adjrsquare;
        GofStats2(10,8)=rmse;
        PlotRegionalQVFit(FitOctQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion8,titlestr)
    end

  % Continue With Oct Region 9
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion9,gofOctRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion9.adjrsquare;
        rmse=gofOctRegion9.rmse;
        GofStats1(10,9)=adjrsquare;
        GofStats2(10,9)=rmse;
        PlotRegionalQVFit(FitOctQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion9,titlestr)
    end

  % Continue With Oct Region 10
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion10,gofOctRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion10.adjrsquare;
        rmse=gofOctRegion10.rmse;        
        GofStats1(10,10)=adjrsquare;
        GofStats2(10,10)=rmse;
        PlotRegionalQVFit(FitOctQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofOctRegion10,titlestr)
    end

  % Start With Nov for Region 1
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion1,gofNovRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion1.adjrsquare;
        rmse=gofNovRegion1.rmse;
        GofStats1(11,1)=adjrsquare;
        GofStats2(11,1)=rmse;
        PlotRegionalQVFit(FitNovQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion1,titlestr)
    end

% Continue With Nov Region 2
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion2,gofNovRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion2.adjrsquare;
        rmse=gofNovRegion2.rmse;
        GofStats1(11,2)=adjrsquare;
        GofStats2(11,2)=rmse;
        PlotRegionalQVFit(FitNovQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion2,titlestr)
    end

 % Continue With Nov Region 3
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion3,gofNovRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion3.adjrsquare;
        rmse=gofNovRegion3.rmse;
        GofStats1(11,3)=adjrsquare;
        GofStats2(11,3)=rmse;
        PlotRegionalQVFit(FitNovQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion3,titlestr)
    end

  % Continue With Nov Region 4
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion4,gofNovRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion4.adjrsquare;
        rmse=gofNovRegion4.rmse;
        GofStats1(11,4)=adjrsquare;
        GofStats2(11,4)=rmse;
        PlotRegionalQVFit(FitNovQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion4,titlestr)
    end

  % Continue With Nov Region 5
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion5,gofNovRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion5.adjrsquare;
        rmse=gofNovRegion5.rmse;
        GofStats1(11,5)=adjrsquare;
        GofStats2(11,5)=rmse;
        PlotRegionalQVFit(FitNovQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion5,titlestr)
    end

% Continue With Nov Region 6  
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion6,gofNovRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion6.adjrsquare;
        rmse=gofNovRegion6.rmse;
        GofStats1(11,6)=adjrsquare;
        GofStats2(11,6)=rmse;
        PlotRegionalQVFit(FitNovQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion6,titlestr)
    end

 % Continue With Nov Region 7  
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion7,gofNovRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion7.adjrsquare;
        rmse=gofNovRegion7.rmse;
        GofStats1(11,7)=adjrsquare;
        GofStats2(11,7)=rmse;
        PlotRegionalQVFit(FitNovQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion7,titlestr)
    end

  % Continue With Nov Region 8 
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion8,gofNovRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion8.adjrsquare;
        rmse=gofNovRegion8.rmse;
        GofStats1(11,8)=adjrsquare;
        GofStats2(11,8)=rmse;
        PlotRegionalQVFit(FitNovQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion8,titlestr)
    end

  % Continue With Nov Region 9
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion9,gofNovRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion9.adjrsquare;
        rmse=gofNovRegion9.rmse;
        GofStats1(11,9)=adjrsquare;
        GofStats2(11,9)=rmse;
        PlotRegionalQVFit(FitNovQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion9,titlestr)
    end

  % Continue With Nov Region 10
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion10,gofNovRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion10.adjrsquare;
        rmse=gofNovRegion10.rmse;        
        GofStats1(11,10)=adjrsquare;
        GofStats2(11,10)=rmse;
        PlotRegionalQVFit(FitNovQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofNovRegion10,titlestr)
    end

  % Start With Dec for Region 1
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion1,gofDecRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion1.adjrsquare;
        rmse=gofDecRegion1.rmse;
        GofStats1(12,1)=adjrsquare;
        GofStats2(12,1)=rmse;
        PlotRegionalQVFit(FitDecQVRegion1,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion1,titlestr)
    end

% Continue With Dec Region 2
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion2,gofDecRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion2.adjrsquare;
        rmse=gofDecRegion2.rmse;
        GofStats1(12,2)=adjrsquare;
        GofStats2(12,2)=rmse;
        PlotRegionalQVFit(FitDecQVRegion2,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion2,titlestr)
    end

 % Continue With Dec Region 3
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion3,gofDecRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion3.adjrsquare;
        rmse=gofDecRegion3.rmse;
        GofStats1(12,3)=adjrsquare;
        GofStats2(12,3)=rmse;
        PlotRegionalQVFit(FitDecQVRegion3,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion3,titlestr)
    end

  % Continue With Dec Region 4
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion4,gofDecRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion4.adjrsquare;
        rmse=gofDecRegion4.rmse;
        GofStats1(12,4)=adjrsquare;
        GofStats2(12,4)=rmse;
        PlotRegionalQVFit(FitDecQVRegion4,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion4,titlestr)
    end

  % Continue With Dec Region 5
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion5,gofDecRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion5.adjrsquare;
        rmse=gofDecRegion5.rmse;
        GofStats1(12,5)=adjrsquare;
        GofStats2(12,5)=rmse;
        PlotRegionalQVFit(FitDecQVRegion5,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion5,titlestr)
    end

% Continue With Dec Region 6  
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion6,gofDecRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion6.adjrsquare;
        rmse=gofDecRegion6.rmse;
        GofStats1(12,6)=adjrsquare;
        GofStats2(12,6)=rmse;
        PlotRegionalQVFit(FitDecQVRegion6,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion6,titlestr)
    end

 % Continue With Dec Region 7  
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion7,gofDecRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion7.adjrsquare;
        rmse=gofDecRegion7.rmse;
        GofStats1(12,7)=adjrsquare;
        GofStats2(12,7)=rmse;
        PlotRegionalQVFit(FitDecQVRegion7,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion7,titlestr)
    end

  % Continue With Dec Region 8 
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion8,gofDecRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion8.adjrsquare;
        rmse=gofDecRegion8.rmse;
        GofStats1(12,8)=adjrsquare;
        GofStats2(12,8)=rmse;
        PlotRegionalQVFit(FitDecQVRegion8,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion8,titlestr)
    end

  % Continue With Dec Region 9
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion9,gofDecRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion9.adjrsquare;
        rmse=gofDecRegion9.rmse;
        GofStats1(12,9)=adjrsquare;
        GofStats2(12,9)=rmse;
        PlotRegionalQVFit(FitDecQVRegion9,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion9,titlestr)
    end

  % Continue With Dec Region 10
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion10,gofDecRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion10.adjrsquare;
        rmse=gofDecRegion10.rmse;        
        GofStats1(12,10)=adjrsquare;
        GofStats2(12,10)=rmse;
        PlotRegionalQVFit(FitDecQVRegion10,MeasTimes,MeasQV,RegionName,ifittype,gofDecRegion10,titlestr)
    end
end
% Save run data
isavefiles=1;
if(isavefiles==1)
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='GofStats1 GofStats2 ';
    varstr2=' PredTempStart PredTempEnd PredTempChng';
    varstr=strcat(varstr1,varstr2);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr);
else
%     dispstr=strcat('Did Not Save Matlab File-',MatFileName);
%     disp(dispstr);
end
%% Plot the Avergage Temperature Changes
if(iSelect==1)
    titlestr='AvgAirTempChanges-1980-2020';
    iAddToReport=1;
    iNewChapter=1;
    iCloseChapter=1;
    DisplayMonthlyAvgTemps(titlestr,ifittype,iAddToReport,iNewChapter,iCloseChapter)
end
disp('Run Complete');




ab=1;