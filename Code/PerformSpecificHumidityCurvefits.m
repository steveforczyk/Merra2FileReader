function PerformSpecificHumidityCurvefits()
% This function is based on the standalone script TestMerra2DataCurveFits
% and will perform curvefits to the monthly averaged Specific Humidty data
% for 10 separate regions and 12 months for the period 1980-2022
% Written By: Stephen Forczyk
% Created: Jan 8,2024
% Revised: Jan 18,2024 modified code to add additgonal plots to the
% PDF file if created.
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
global iSelectSet3;
global JanTemps FebTemps MarTemps AprTemps MayTemps JunTemps;
global JulTemps AugTemps SepTemps OctTemps NovTemps DecTemps;
global JanQV FebQV MarQV AprQV MayQV JunQV;
global JulQV AugQV SepQV OctQV NovQV DecQV;
global GofStats1 GofStats2 GofStats3 GofStats4;
global PredQVStart PredQVEnd PredQVChng;
global fitmonth fitregion;
global isavefiles MatFileName;
global MonthLabels RegionLabels;
global pslice heightkm DataCollectionTime;


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

QVSStatsFileName1='FinalCombinedQVSTables.mat';
jpegpath='K:\Merra-2\netCDF\Dataset03\Jpeg_Test2\';
%% Work on the Specific Humidity Table
% Load the QVS Stats Timetable
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    load(QVSStatsFileName1);
    MatFileName='SpecificHumidityChanges.mat';
% Get the Height of the dataset pressure level
    iPress42=PresLvl;
    pslice=iPress42;
    heightkm=PressureLevel42(iPress42,3);
    DataCollectionTime=TimeStr;
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
    GofStats3=zeros(12,10);
    GofStats4=zeros(12,10);
    PredQVStart=zeros(12,10);
    PredQVEnd=zeros(12,10);
    PredQVChng=zeros(12,10);
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
%% Now Calculate and Plot the Curve Fits
    fo=fitoptions('poly2');
    fo.Normalize='on';
%% Now Calculate and Plot the Curve Fits

% Start With Jan for Region 1
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion1,gofJanRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion1.adjrsquare;
        rmse=gofJanRegion1.rmse;
        GofStats3(1,1)=adjrsquare;
        GofStats4(1,1)=rmse;
        fitmonth=1;
        fitregion=1;
        PlotRegionalQVConfidence(FitJanQVRegion1,MeasTimes,MeasQV,ifittype,gofJanRegion1,fitconf,titlestr)
    end

  % Continue With Jan for Region 2
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion2,gofJanRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion2.adjrsquare;
        rmse=gofJanRegion2.rmse;
        GofStats3(1,2)=adjrsquare;
        GofStats4(1,2)=rmse;
        fitmonth=1;
        fitregion=2;
        PlotRegionalQVConfidence(FitJanQVRegion2,MeasTimes,MeasQV,ifittype,gofJanRegion2,fitconf,titlestr)
    end

  % Continue With Jan for Region 3
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion3,gofJanRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion3.adjrsquare;
        rmse=gofJanRegion3.rmse;
        GofStats3(1,3)=adjrsquare;
        GofStats4(1,3)=rmse;
        fitmonth=1;
        fitregion=3;
        PlotRegionalQVConfidence(FitJanQVRegion3,MeasTimes,MeasQV,ifittype,gofJanRegion3,fitconf,titlestr)
    end

  % Continue With Jan for Region 4
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion4,gofJanRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion4.adjrsquare;
        rmse=gofJanRegion4.rmse;
        GofStats3(1,4)=adjrsquare;
        GofStats4(1,4)=rmse;
        fitmonth=1;
        fitregion=4;
        PlotRegionalQVConfidence(FitJanQVRegion4,MeasTimes,MeasQV,ifittype,gofJanRegion4,fitconf,titlestr)
    end

  % Continue With Jan for Region 5
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion5,gofJanRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion5.adjrsquare;
        rmse=gofJanRegion5.rmse;
        GofStats3(1,5)=adjrsquare;
        GofStats4(1,5)=rmse;
        fitmonth=1;
        fitregion=5;
        PlotRegionalQVConfidence(FitJanQVRegion5,MeasTimes,MeasQV,ifittype,gofJanRegion5,fitconf,titlestr)
    end

  % Continue With Jan for Region 6
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion6,gofJanRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion6.adjrsquare;
        rmse=gofJanRegion6.rmse;
        GofStats3(1,6)=adjrsquare;
        GofStats4(1,6)=rmse;
        fitmonth=1;
        fitregion=6;
        PlotRegionalQVConfidence(FitJanQVRegion6,MeasTimes,MeasQV,ifittype,gofJanRegion6,fitconf,titlestr)
    end

 % Continue With Jan for Region 7
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion7,gofJanRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion7.adjrsquare;
        rmse=gofJanRegion7.rmse;
        GofStats3(1,7)=adjrsquare;
        GofStats4(1,7)=rmse;
        fitmonth=1;
        fitregion=7;
        PlotRegionalQVConfidence(FitJanQVRegion7,MeasTimes,MeasQV,ifittype,gofJanRegion7,fitconf,titlestr)
    end

  % Continue With Jan for Region 8
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion8,gofJanRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion8.adjrsquare;
        rmse=gofJanRegion8.rmse;
        GofStats3(1,8)=adjrsquare;
        GofStats4(1,8)=rmse;
        fitmonth=1;
        fitregion=8;
        PlotRegionalQVConfidence(FitJanQVRegion8,MeasTimes,MeasQV,ifittype,gofJanRegion8,fitconf,titlestr)
    end

  % Continue With Jan for Region 9
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion9,gofJanRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion9.adjrsquare;
        rmse=gofJanRegion9.rmse;
        GofStats3(1,9)=adjrsquare;
        GofStats4(1,9)=rmse;
        fitmonth=1;
        fitregion=9;
        PlotRegionalQVConfidence(FitJanQVRegion9,MeasTimes,MeasQV,ifittype,gofJanRegion9,fitconf,titlestr)
    end 

  % Continue With Jan for Region 10
    MeasTimes=TimeFrac(:,1);
    MeasQV=JanQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jan','-FitType-',num2str(ifittype));
        [FitJanQVRegion10,gofJanRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJanRegion10.adjrsquare;
        rmse=gofJanRegion10.rmse;
        GofStats3(1,10)=adjrsquare;
        GofStats4(1,10)=rmse;
        fitmonth=1;
        fitregion=10;
        PlotRegionalQVConfidence(FitJanQVRegion10,MeasTimes,MeasQV,ifittype,gofJanRegion10,fitconf,titlestr)
    end 

  % Start With Feb for Region 1
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion1,gofFebRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion1.adjrsquare;
        rmse=gofFebRegion1.rmse;
        GofStats3(2,1)=adjrsquare;
        GofStats4(2,1)=rmse;
        fitmonth=2;
        fitregion=1;
        PlotRegionalQVConfidence(FitFebQVRegion1,MeasTimes,MeasQV,ifittype,gofFebRegion1,fitconf,titlestr)
    end

  % Continue With Feb for Region 2
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion2,gofFebRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion2.adjrsquare;
        rmse=gofFebRegion2.rmse;
        GofStats3(2,2)=adjrsquare;
        GofStats4(2,2)=rmse;
        fitmonth=2;
        fitregion=2;
        PlotRegionalQVConfidence(FitFebQVRegion2,MeasTimes,MeasQV,ifittype,gofFebRegion2,fitconf,titlestr)
    end

  % Continue With Feb for Region 3
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion3,gofFebRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion3.adjrsquare;
        rmse=gofFebRegion3.rmse;
        GofStats3(2,3)=adjrsquare;
        GofStats4(2,3)=rmse;
        fitmonth=2;
        fitregion=3;
        PlotRegionalQVConfidence(FitFebQVRegion3,MeasTimes,MeasQV,ifittype,gofFebRegion3,fitconf,titlestr)
    end

  % Continue With Feb for Region 4
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion4,gofFebRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion4.adjrsquare;
        rmse=gofFebRegion4.rmse;
        GofStats3(2,4)=adjrsquare;
        GofStats4(2,4)=rmse;
        fitmonth=2;
        fitregion=4;
        PlotRegionalQVConfidence(FitFebQVRegion4,MeasTimes,MeasQV,ifittype,gofFebRegion4,fitconf,titlestr)
    end

  % Continue With Feb for Region 5
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion5,gofFebRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion5.adjrsquare;
        rmse=gofFebRegion5.rmse;
        GofStats3(2,5)=adjrsquare;
        GofStats4(2,5)=rmse;
        fitmonth=2;
        fitregion=5;
        PlotRegionalQVConfidence(FitFebQVRegion5,MeasTimes,MeasQV,ifittype,gofFebRegion5,fitconf,titlestr)
    end

  % Continue With Feb for Region 6
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion6,gofFebRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion6.adjrsquare;
        rmse=gofFebRegion6.rmse;
        GofStats3(2,6)=adjrsquare;
        GofStats4(2,6)=rmse;
        fitmonth=2;
        fitregion=6;
        PlotRegionalQVConfidence(FitFebQVRegion6,MeasTimes,MeasQV,ifittype,gofFebRegion6,fitconf,titlestr)
    end

 % Continue With Feb for Region 7
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion7,gofFebRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion7.adjrsquare;
        rmse=gofFebRegion7.rmse;
        GofStats3(2,7)=adjrsquare;
        GofStats4(2,7)=rmse;
        fitmonth=2;
        fitregion=7;
        PlotRegionalQVConfidence(FitFebQVRegion7,MeasTimes,MeasQV,ifittype,gofFebRegion7,fitconf,titlestr)
    end

  % Continue With Feb for Region 8
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion8,gofFebRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion8.adjrsquare;
        rmse=gofFebRegion8.rmse;
        GofStats3(2,8)=adjrsquare;
        GofStats4(2,8)=rmse;
        fitmonth=2;
        fitregion=8;
        PlotRegionalQVConfidence(FitFebQVRegion8,MeasTimes,MeasQV,ifittype,gofFebRegion8,fitconf,titlestr)
    end

  % Continue With Feb for Region 9
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion9,gofFebRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion9.adjrsquare;
        rmse=gofFebRegion9.rmse;
        GofStats3(2,9)=adjrsquare;
        GofStats4(2,9)=rmse;
        fitmonth=2;
        fitregion=9;
        PlotRegionalQVConfidence(FitFebQVRegion9,MeasTimes,MeasQV,ifittype,gofFebRegion9,fitconf,titlestr)
    end 

  % Continue With Feb for Region 10
    MeasTimes=TimeFrac(:,2);
    MeasQV=FebQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Feb','-FitType-',num2str(ifittype));
        [FitFebQVRegion10,gofFebRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofFebRegion10.adjrsquare;
        rmse=gofFebRegion10.rmse;
        GofStats3(2,10)=adjrsquare;
        GofStats4(2,10)=rmse;
        fitmonth=2;
        fitregion=10;
        PlotRegionalQVConfidence(FitFebQVRegion10,MeasTimes,MeasQV,ifittype,gofFebRegion10,fitconf,titlestr)
    end 

  % Start With Mar for Region 1
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion1,gofMarRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion1.adjrsquare;
        rmse=gofMarRegion1.rmse;
        GofStats3(3,1)=adjrsquare;
        GofStats4(3,1)=rmse;
        fitmonth=3;
        fitregion=1;
        PlotRegionalQVConfidence(FitMarQVRegion1,MeasTimes,MeasQV,ifittype,gofMarRegion1,fitconf,titlestr)
    end

  % Continue With Mar for Region 2
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion2,gofMarRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion2.adjrsquare;
        rmse=gofMarRegion2.rmse;
        GofStats3(3,2)=adjrsquare;
        GofStats4(3,2)=rmse;
        fitmonth=3;
        fitregion=2;
        PlotRegionalQVConfidence(FitMarQVRegion2,MeasTimes,MeasQV,ifittype,gofMarRegion2,fitconf,titlestr)
    end

  % Continue With Mar for Region 3
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion3,gofMarRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion3.adjrsquare;
        rmse=gofMarRegion3.rmse;
        GofStats3(3,3)=adjrsquare;
        GofStats4(3,3)=rmse;
        fitmonth=3;
        fitregion=3;
        PlotRegionalQVConfidence(FitMarQVRegion3,MeasTimes,MeasQV,ifittype,gofMarRegion3,fitconf,titlestr)
    end

  % Continue With Mar for Region 4
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion4,gofMarRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion4.adjrsquare;
        rmse=gofMarRegion4.rmse;
        GofStats3(3,4)=adjrsquare;
        GofStats4(3,4)=rmse;
        fitmonth=3;
        fitregion=4;
        PlotRegionalQVConfidence(FitMarQVRegion4,MeasTimes,MeasQV,ifittype,gofMarRegion4,fitconf,titlestr)
    end

  % Continue With Mar for Region 5
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion5,gofMarRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion5.adjrsquare;
        rmse=gofMarRegion5.rmse;
        GofStats3(3,5)=adjrsquare;
        GofStats4(3,5)=rmse;
        fitmonth=3;
        fitregion=5;
        PlotRegionalQVConfidence(FitMarQVRegion5,MeasTimes,MeasQV,ifittype,gofMarRegion5,fitconf,titlestr)
    end

  % Continue With Mar for Region 6
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion6,gofMarRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion6.adjrsquare;
        rmse=gofMarRegion6.rmse;
        GofStats3(3,6)=adjrsquare;
        GofStats4(3,6)=rmse;
        fitmonth=3;
        fitregion=6;
        PlotRegionalQVConfidence(FitMarQVRegion6,MeasTimes,MeasQV,ifittype,gofMarRegion6,fitconf,titlestr)
    end

 % Continue With Mar for Region 7
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion7,gofMarRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion7.adjrsquare;
        rmse=gofMarRegion7.rmse;
        GofStats3(3,7)=adjrsquare;
        GofStats4(3,7)=rmse;
        fitmonth=3;
        fitregion=7;
        PlotRegionalQVConfidence(FitMarQVRegion7,MeasTimes,MeasQV,ifittype,gofMarRegion7,fitconf,titlestr)
    end

  % Continue With Mar for Region 8
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion8,gofMarRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion8.adjrsquare;
        rmse=gofMarRegion8.rmse;
        GofStats3(3,8)=adjrsquare;
        GofStats4(3,8)=rmse;
        fitmonth=3;
        fitregion=8;
        PlotRegionalQVConfidence(FitMarQVRegion8,MeasTimes,MeasQV,ifittype,gofMarRegion8,fitconf,titlestr)
    end

  % Continue With Feb for Region 9
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion9,gofMarRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion9.adjrsquare;
        rmse=gofMarRegion9.rmse;
        GofStats3(3,9)=adjrsquare;
        GofStats4(3,9)=rmse;
        fitmonth=3;
        fitregion=9;
        PlotRegionalQVConfidence(FitMarQVRegion9,MeasTimes,MeasQV,ifittype,gofMarRegion9,fitconf,titlestr)
    end 

  % Continue With Mar for Region 10
    MeasTimes=TimeFrac(:,3);
    MeasQV=MarQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Mar','-FitType-',num2str(ifittype));
        [FitMarQVRegion10,gofMarRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMarRegion10.adjrsquare;
        rmse=gofMarRegion10.rmse;
        GofStats3(3,10)=adjrsquare;
        GofStats4(3,10)=rmse;
        fitmonth=3;
        fitregion=10;
        PlotRegionalQVConfidence(FitMarQVRegion10,MeasTimes,MeasQV,ifittype,gofMarRegion10,fitconf,titlestr)
    end 

  % Start With Apr for Region 1
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion1,gofAprRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion1.adjrsquare;
        rmse=gofAprRegion1.rmse;
        GofStats3(4,1)=adjrsquare;
        GofStats4(4,1)=rmse;
        fitmonth=4;
        fitregion=1;
        PlotRegionalQVConfidence(FitAprQVRegion1,MeasTimes,MeasQV,ifittype,gofAprRegion1,fitconf,titlestr)
    end

  % Continue With Apr for Region 2
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion2,gofAprRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion2.adjrsquare;
        rmse=gofAprRegion2.rmse;
        GofStats3(4,2)=adjrsquare;
        GofStats4(4,2)=rmse;
        fitmonth=4;
        fitregion=2;
        PlotRegionalQVConfidence(FitAprQVRegion2,MeasTimes,MeasQV,ifittype,gofAprRegion2,fitconf,titlestr)
    end

  % Continue With Apr for Region 3
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion3,gofAprRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion3.adjrsquare;
        rmse=gofAprRegion3.rmse;
        GofStats3(4,3)=adjrsquare;
        GofStats4(4,3)=rmse;
        fitmonth=4;
        fitregion=3;
        PlotRegionalQVConfidence(FitAprQVRegion3,MeasTimes,MeasQV,ifittype,gofAprRegion3,fitconf,titlestr)
    end

  % Continue With Apr for Region 4
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion4,gofAprRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion4.adjrsquare;
        rmse=gofAprRegion4.rmse;
        GofStats3(4,4)=adjrsquare;
        GofStats4(4,4)=rmse;
        fitmonth=4;
        fitregion=4;
        PlotRegionalQVConfidence(FitAprQVRegion4,MeasTimes,MeasQV,ifittype,gofAprRegion4,fitconf,titlestr)
    end

  % Continue With Apr for Region 5
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion5,gofAprRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion5.adjrsquare;
        rmse=gofAprRegion5.rmse;
        GofStats3(4,5)=adjrsquare;
        GofStats4(4,5)=rmse;
        fitmonth=4;
        fitregion=5;
        PlotRegionalQVConfidence(FitAprQVRegion5,MeasTimes,MeasQV,ifittype,gofAprRegion5,fitconf,titlestr)
    end

  % Continue With Apr for Region 6
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion6,gofAprRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion6.adjrsquare;
        rmse=gofAprRegion6.rmse;
        GofStats3(4,6)=adjrsquare;
        GofStats4(4,6)=rmse;
        fitmonth=4;
        fitregion=6;
        PlotRegionalQVConfidence(FitAprQVRegion6,MeasTimes,MeasQV,ifittype,gofAprRegion6,fitconf,titlestr)
    end

 % Continue With Apr for Region 7
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion7,gofAprRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion7.adjrsquare;
        rmse=gofAprRegion7.rmse;
        GofStats3(4,7)=adjrsquare;
        GofStats4(4,7)=rmse;
        fitmonth=4;
        fitregion=7;
        PlotRegionalQVConfidence(FitAprQVRegion7,MeasTimes,MeasQV,ifittype,gofAprRegion7,fitconf,titlestr)
    end

  % Continue With Apr for Region 8
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion8,gofAprRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion8.adjrsquare;
        rmse=gofAprRegion8.rmse;
        GofStats3(4,8)=adjrsquare;
        GofStats4(4,8)=rmse;
        fitmonth=4;
        fitregion=8;
        PlotRegionalQVConfidence(FitAprQVRegion8,MeasTimes,MeasQV,ifittype,gofAprRegion8,fitconf,titlestr)
    end

  % Continue With Apr for Region 9
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion9,gofAprRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion9.adjrsquare;
        rmse=gofAprRegion9.rmse;
        GofStats3(4,9)=adjrsquare;
        GofStats4(4,9)=rmse;
        fitmonth=4;
        fitregion=9;
        PlotRegionalQVConfidence(FitAprQVRegion9,MeasTimes,MeasQV,ifittype,gofAprRegion9,fitconf,titlestr)
    end 

  % Continue With Apr for Region 10
    MeasTimes=TimeFrac(:,4);
    MeasQV=AprQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Apr','-FitType-',num2str(ifittype));
        [FitAprQVRegion10,gofAprRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAprRegion10.adjrsquare;
        rmse=gofAprRegion10.rmse;
        GofStats3(4,10)=adjrsquare;
        GofStats4(4,10)=rmse;
        fitmonth=4;
        fitregion=10;
        PlotRegionalQVConfidence(FitAprQVRegion10,MeasTimes,MeasQV,ifittype,gofAprRegion10,fitconf,titlestr)
    end

  % Start With May for Region 1
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion1,gofMayRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion1.adjrsquare;
        rmse=gofMayRegion1.rmse;
        GofStats3(5,1)=adjrsquare;
        GofStats4(5,1)=rmse;
        fitmonth=5;
        fitregion=1;
        PlotRegionalQVConfidence(FitMayQVRegion1,MeasTimes,MeasQV,ifittype,gofMayRegion1,fitconf,titlestr)
    end

  % Continue With May for Region 2
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion2,gofMayRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion2.adjrsquare;
        rmse=gofMayRegion2.rmse;
        GofStats3(5,2)=adjrsquare;
        GofStats4(5,2)=rmse;
        fitmonth=5;
        fitregion=2;
        PlotRegionalQVConfidence(FitMayQVRegion2,MeasTimes,MeasQV,ifittype,gofMayRegion2,fitconf,titlestr)
    end

  % Continue With May for Region 3
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion3,gofMayRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion3.adjrsquare;
        rmse=gofMayRegion3.rmse;
        GofStats3(5,3)=adjrsquare;
        GofStats4(5,3)=rmse;
        fitmonth=5;
        fitregion=3;
        PlotRegionalQVConfidence(FitMayQVRegion3,MeasTimes,MeasQV,ifittype,gofMayRegion3,fitconf,titlestr)
    end

  % Continue With May for Region 4
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion4,gofMayRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion4.adjrsquare;
        rmse=gofMayRegion4.rmse;
        GofStats3(5,4)=adjrsquare;
        GofStats4(5,4)=rmse;
        fitmonth=5;
        fitregion=4;
        PlotRegionalQVConfidence(FitMayQVRegion4,MeasTimes,MeasQV,ifittype,gofMayRegion4,fitconf,titlestr)
    end

  % Continue With May for Region 5
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion5,gofMayRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion5.adjrsquare;
        rmse=gofMayRegion5.rmse;
        GofStats3(5,5)=adjrsquare;
        GofStats4(5,5)=rmse;
        fitmonth=5;
        fitregion=5;
        PlotRegionalQVConfidence(FitMayQVRegion5,MeasTimes,MeasQV,ifittype,gofMayRegion5,fitconf,titlestr)
    end

  % Continue With May for Region 6
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion6,gofMayRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion6.adjrsquare;
        rmse=gofMayRegion6.rmse;
        GofStats3(5,6)=adjrsquare;
        GofStats4(5,6)=rmse;
        fitmonth=5;
        fitregion=6;
        PlotRegionalQVConfidence(FitMayQVRegion6,MeasTimes,MeasQV,ifittype,gofMayRegion6,fitconf,titlestr)
    end

 % Continue With May for Region 7
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion7,gofMayRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion7.adjrsquare;
        rmse=gofMayRegion7.rmse;
        GofStats3(5,7)=adjrsquare;
        GofStats4(5,7)=rmse;
        fitmonth=5;
        fitregion=7;
        PlotRegionalQVConfidence(FitMayQVRegion7,MeasTimes,MeasQV,ifittype,gofMayRegion7,fitconf,titlestr)
    end

  % Continue With May for Region 8
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion8,gofMayRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion8.adjrsquare;
        rmse=gofMayRegion8.rmse;
        GofStats3(5,8)=adjrsquare;
        GofStats4(5,8)=rmse;
        fitmonth=5;
        fitregion=8;
        PlotRegionalQVConfidence(FitMayQVRegion8,MeasTimes,MeasQV,ifittype,gofMayRegion8,fitconf,titlestr)
    end

  % Continue With May for Region 9
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion9,gofMayRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion9.adjrsquare;
        rmse=gofMayRegion9.rmse;
        GofStats3(5,9)=adjrsquare;
        GofStats4(5,9)=rmse;
        fitmonth=5;
        fitregion=9;
        PlotRegionalQVConfidence(FitMayQVRegion9,MeasTimes,MeasQV,ifittype,gofMayRegion9,fitconf,titlestr)
    end 

  % Continue With May for Region 10
    MeasTimes=TimeFrac(:,5);
    MeasQV=MayQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-May','-FitType-',num2str(ifittype));
        [FitMayQVRegion10,gofMayRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofMayRegion10.adjrsquare;
        rmse=gofMayRegion10.rmse;
        GofStats3(5,10)=adjrsquare;
        GofStats4(5,10)=rmse;
        fitmonth=5;
        fitregion=10;
        PlotRegionalQVConfidence(FitMayQVRegion10,MeasTimes,MeasQV,ifittype,gofMayRegion10,fitconf,titlestr)
    end 

  % Start With Jun for Region 1
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion1,gofJunRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion1.adjrsquare;
        rmse=gofJunRegion1.rmse;
        GofStats3(6,1)=adjrsquare;
        GofStats4(6,1)=rmse;
        fitmonth=6;
        fitregion=1;
        PlotRegionalQVConfidence(FitJunQVRegion1,MeasTimes,MeasQV,ifittype,gofJunRegion1,fitconf,titlestr)
    end

  % Continue With June for Region 2
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion2,gofJunRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion2.adjrsquare;
        rmse=gofJunRegion2.rmse;
        GofStats3(6,2)=adjrsquare;
        GofStats4(6,2)=rmse;
        fitmonth=6;
        fitregion=2;
        PlotRegionalQVConfidence(FitJunQVRegion2,MeasTimes,MeasQV,ifittype,gofJunRegion2,fitconf,titlestr)
    end

  % Continue With Jun for Region 3
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion3,gofJunRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion3.adjrsquare;
        rmse=gofJunRegion3.rmse;
        GofStats3(6,3)=adjrsquare;
        GofStats4(6,3)=rmse;
        fitmonth=6;
        fitregion=3;
        PlotRegionalQVConfidence(FitJunQVRegion3,MeasTimes,MeasQV,ifittype,gofJunRegion3,fitconf,titlestr)
    end

  % Continue With Jun for Region 4
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion4,gofJunRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion4.adjrsquare;
        rmse=gofJunRegion4.rmse;
        GofStats3(6,4)=adjrsquare;
        GofStats4(6,4)=rmse;
        fitmonth=6;
        fitregion=4;
        PlotRegionalQVConfidence(FitJunQVRegion4,MeasTimes,MeasQV,ifittype,gofJunRegion4,fitconf,titlestr)
    end

  % Continue With Jun for Region 5
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion5,gofJunRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion5.adjrsquare;
        rmse=gofJunRegion5.rmse;
        GofStats3(6,5)=adjrsquare;
        GofStats4(6,5)=rmse;
        fitmonth=6;
        fitregion=5;
        PlotRegionalQVConfidence(FitJunQVRegion5,MeasTimes,MeasQV,ifittype,gofJunRegion5,fitconf,titlestr)
    end

  % Continue With Jun for Region 6
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion6,gofJunRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion6.adjrsquare;
        rmse=gofJunRegion6.rmse;
        GofStats3(6,6)=adjrsquare;
        GofStats4(6,6)=rmse;
        fitmonth=6;
        fitregion=6;
        PlotRegionalQVConfidence(FitJunQVRegion6,MeasTimes,MeasQV,ifittype,gofJunRegion6,fitconf,titlestr)
    end

 % Continue With Jun for Region 7
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion7,gofJunRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion7.adjrsquare;
        rmse=gofJunRegion7.rmse;
        GofStats3(6,7)=adjrsquare;
        GofStats4(6,7)=rmse;
        fitmonth=6;
        fitregion=7;
        PlotRegionalQVConfidence(FitJunQVRegion7,MeasTimes,MeasQV,ifittype,gofJunRegion7,fitconf,titlestr)
    end

  % Continue With Jun for Region 8
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion8,gofJunRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion8.adjrsquare;
        rmse=gofJunRegion8.rmse;
        GofStats3(6,8)=adjrsquare;
        GofStats4(6,8)=rmse;
        fitmonth=6;
        fitregion=8;
        PlotRegionalQVConfidence(FitJunQVRegion8,MeasTimes,MeasQV,ifittype,gofJunRegion8,fitconf,titlestr)
    end

  % Continue With Jun for Region 9
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion9,gofJunRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion9.adjrsquare;
        rmse=gofJunRegion9.rmse;
        GofStats3(6,9)=adjrsquare;
        GofStats4(6,9)=rmse;
        fitmonth=6;
        fitregion=9;
        PlotRegionalQVConfidence(FitJunQVRegion9,MeasTimes,MeasQV,ifittype,gofJunRegion9,fitconf,titlestr)
    end 

 % Continue With Jun for Region 10
    MeasTimes=TimeFrac(:,6);
    MeasQV=JunQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jun','-FitType-',num2str(ifittype));
        [FitJunQVRegion10,gofJunRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJunRegion10.adjrsquare;
        rmse=gofJunRegion10.rmse;
        GofStats3(6,10)=adjrsquare;
        GofStats4(6,10)=rmse;
        fitmonth=6;
        fitregion=10;
        PlotRegionalQVConfidence(FitJunQVRegion10,MeasTimes,MeasQV,ifittype,gofJunRegion10,fitconf,titlestr)
    end 

  % Start With Jul for Region 1
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion1,gofJulRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion1.adjrsquare;
        rmse=gofJulRegion1.rmse;
        GofStats3(7,1)=adjrsquare;
        GofStats4(7,1)=rmse;
        fitmonth=7;
        fitregion=1;
        PlotRegionalQVConfidence(FitJulQVRegion1,MeasTimes,MeasQV,ifittype,gofJulRegion1,fitconf,titlestr)
    end

  % Continue With Jul for Region 2
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion2,gofJulRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion2.adjrsquare;
        rmse=gofJulRegion2.rmse;
        GofStats3(7,2)=adjrsquare;
        GofStats4(7,2)=rmse;
        fitmonth=7;
        fitregion=2;
        PlotRegionalQVConfidence(FitJulQVRegion2,MeasTimes,MeasQV,ifittype,gofJulRegion2,fitconf,titlestr)
    end

  % Continue With Jul for Region 3
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion3,gofJulRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion3.adjrsquare;
        rmse=gofJulRegion3.rmse;
        GofStats3(7,3)=adjrsquare;
        GofStats4(7,3)=rmse;
        fitmonth=7;
        fitregion=3;
        PlotRegionalQVConfidence(FitJulQVRegion3,MeasTimes,MeasQV,ifittype,gofJulRegion3,fitconf,titlestr)
    end

  % Continue With Jul for Region 4
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion4,gofJulRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion4.adjrsquare;
        rmse=gofJulRegion4.rmse;
        GofStats3(7,4)=adjrsquare;
        GofStats4(7,4)=rmse;
        fitmonth=7;
        fitregion=4;
        PlotRegionalQVConfidence(FitJulQVRegion4,MeasTimes,MeasQV,ifittype,gofJulRegion4,fitconf,titlestr)
    end

  % Continue With Jul for Region 5
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion5,gofJulRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion5.adjrsquare;
        rmse=gofJulRegion5.rmse;
        GofStats3(7,5)=adjrsquare;
        GofStats4(7,5)=rmse;
        fitmonth=7;
        fitregion=5;
        PlotRegionalQVConfidence(FitJulQVRegion5,MeasTimes,MeasQV,ifittype,gofJulRegion5,fitconf,titlestr)
    end

  % Continue With Jul for Region 6
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion6,gofJulRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion6.adjrsquare;
        rmse=gofJulRegion6.rmse;
        GofStats3(7,6)=adjrsquare;
        GofStats4(7,6)=rmse;
        fitmonth=7;
        fitregion=6;
        PlotRegionalQVConfidence(FitJulQVRegion6,MeasTimes,MeasQV,ifittype,gofJulRegion6,fitconf,titlestr)
    end

 % Continue With Jul for Region 7
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion7,gofJulRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion7.adjrsquare;
        rmse=gofJulRegion7.rmse;
        GofStats3(7,7)=adjrsquare;
        GofStats4(7,7)=rmse;
        fitmonth=7;
        fitregion=7;
        PlotRegionalQVConfidence(FitJulQVRegion7,MeasTimes,MeasQV,ifittype,gofJulRegion7,fitconf,titlestr)
    end

  % Continue With Jul for Region 8
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion8,gofJulRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion8.adjrsquare;
        rmse=gofJulRegion8.rmse;
        GofStats3(7,8)=adjrsquare;
        GofStats4(7,8)=rmse;
        fitmonth=7;
        fitregion=8;
        PlotRegionalQVConfidence(FitJulQVRegion8,MeasTimes,MeasQV,ifittype,gofJulRegion8,fitconf,titlestr)
    end

  % Continue With Jul for Region 9
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion9,gofJulRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion9.adjrsquare;
        rmse=gofJulRegion9.rmse;
        GofStats3(7,9)=adjrsquare;
        GofStats4(7,9)=rmse;
        fitmonth=7;
        fitregion=9;
        PlotRegionalQVConfidence(FitJulQVRegion9,MeasTimes,MeasQV,ifittype,gofJulRegion9,fitconf,titlestr)
    end 

 % Continue With Jul for Region 10
    MeasTimes=TimeFrac(:,7);
    MeasQV=JulQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Jul','-FitType-',num2str(ifittype));
        [FitJulQVRegion10,gofJulRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofJulRegion10.adjrsquare;
        rmse=gofJulRegion10.rmse;
        GofStats3(7,10)=adjrsquare;
        GofStats4(7,10)=rmse;
        fitmonth=7;
        fitregion=10;
        PlotRegionalQVConfidence(FitJulQVRegion10,MeasTimes,MeasQV,ifittype,gofJulRegion10,fitconf,titlestr)
    end

  % Start With Aug for Region 1
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion1,gofAugRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion1.adjrsquare;
        rmse=gofAugRegion1.rmse;
        GofStats3(8,1)=adjrsquare;
        GofStats4(8,1)=rmse;
        fitmonth=8;
        fitregion=1;
        PlotRegionalQVConfidence(FitAugQVRegion1,MeasTimes,MeasQV,ifittype,gofAugRegion1,fitconf,titlestr)
    end

  % Continue With Aug for Region 2
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion2,gofAugRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion2.adjrsquare;
        rmse=gofAugRegion2.rmse;
        GofStats3(8,2)=adjrsquare;
        GofStats4(8,2)=rmse;
        fitmonth=8;
        fitregion=2;
        PlotRegionalQVConfidence(FitAugQVRegion2,MeasTimes,MeasQV,ifittype,gofAugRegion2,fitconf,titlestr)
    end

  % Continue With Aug for Region 3
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion3,gofAugRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion3.adjrsquare;
        rmse=gofAugRegion3.rmse;
        GofStats3(8,3)=adjrsquare;
        GofStats4(8,3)=rmse;
        fitmonth=8;
        fitregion=3;
        PlotRegionalQVConfidence(FitAugQVRegion3,MeasTimes,MeasQV,ifittype,gofAugRegion3,fitconf,titlestr)
    end

  % Continue With Aug for Region 4
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion4,gofAugRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion4.adjrsquare;
        rmse=gofAugRegion4.rmse;
        GofStats3(8,4)=adjrsquare;
        GofStats4(8,4)=rmse;
        fitmonth=8;
        fitregion=4;
        PlotRegionalQVConfidence(FitAugQVRegion4,MeasTimes,MeasQV,ifittype,gofAugRegion4,fitconf,titlestr)
    end

  % Continue With Aug for Region 5
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion5,gofAugRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion5.adjrsquare;
        rmse=gofAugRegion5.rmse;
        GofStats3(8,5)=adjrsquare;
        GofStats4(8,5)=rmse;
        fitmonth=8;
        fitregion=5;
        PlotRegionalQVConfidence(FitAugQVRegion5,MeasTimes,MeasQV,ifittype,gofAugRegion5,fitconf,titlestr)
    end

  % Continue With Aug for Region 6
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion6,gofAugRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion6.adjrsquare;
        rmse=gofAugRegion6.rmse;
        GofStats3(8,6)=adjrsquare;
        GofStats4(8,6)=rmse;
        fitmonth=8;
        fitregion=6;
        PlotRegionalQVConfidence(FitAugQVRegion6,MeasTimes,MeasQV,ifittype,gofAugRegion6,fitconf,titlestr)
    end

 % Continue With Aug for Region 7
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion7,gofAugRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion7.adjrsquare;
        rmse=gofAugRegion7.rmse;
        GofStats3(8,7)=adjrsquare;
        GofStats4(8,7)=rmse;
        fitmonth=8;
        fitregion=7;
        PlotRegionalQVConfidence(FitAugQVRegion7,MeasTimes,MeasQV,ifittype,gofAugRegion7,fitconf,titlestr)
    end

  % Continue With Aug for Region 8
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion8,gofAugRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion8.adjrsquare;
        rmse=gofAugRegion8.rmse;
        GofStats3(8,8)=adjrsquare;
        GofStats4(8,8)=rmse;
        fitmonth=8;
        fitregion=8;
        PlotRegionalQVConfidence(FitAugQVRegion8,MeasTimes,MeasQV,ifittype,gofAugRegion8,fitconf,titlestr)
    end

  % Continue With Aug for Region 9
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion9,gofAugRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion9.adjrsquare;
        rmse=gofAugRegion9.rmse;
        GofStats3(8,9)=adjrsquare;
        GofStats4(8,9)=rmse;
        fitmonth=8;
        fitregion=9;
        PlotRegionalQVConfidence(FitAugQVRegion9,MeasTimes,MeasQV,ifittype,gofAugRegion9,fitconf,titlestr)
    end 

 % Continue With Aug for Region 10
    MeasTimes=TimeFrac(:,8);
    MeasQV=AugQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Aug','-FitType-',num2str(ifittype));
        [FitAugQVRegion10,gofAugRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofAugRegion10.adjrsquare;
        rmse=gofAugRegion10.rmse;
        GofStats3(8,10)=adjrsquare;
        GofStats4(8,10)=rmse;
        fitmonth=8;
        fitregion=10;
        PlotRegionalQVConfidence(FitAugQVRegion10,MeasTimes,MeasQV,ifittype,gofAugRegion10,fitconf,titlestr)
    end 

  % Start With Sep for Region 1
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion1,gofSepRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion1.adjrsquare;
        rmse=gofSepRegion1.rmse;
        GofStats3(9,1)=adjrsquare;
        GofStats4(9,1)=rmse;
        fitmonth=9;
        fitregion=1;
        PlotRegionalQVConfidence(FitSepQVRegion1,MeasTimes,MeasQV,ifittype,gofSepRegion1,fitconf,titlestr)
    end

  % Continue With Sep for Region 2
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion2,gofSepRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion2.adjrsquare;
        rmse=gofSepRegion2.rmse;
        GofStats3(9,2)=adjrsquare;
        GofStats4(9,2)=rmse;
        fitmonth=9;
        fitregion=2;
        PlotRegionalQVConfidence(FitSepQVRegion2,MeasTimes,MeasQV,ifittype,gofSepRegion2,fitconf,titlestr)
    end

  % Continue With Sep for Region 3
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion3,gofSepRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion3.adjrsquare;
        rmse=gofSepRegion3.rmse;
        GofStats3(9,3)=adjrsquare;
        GofStats4(9,3)=rmse;
        fitmonth=9;
        fitregion=3;
        PlotRegionalQVConfidence(FitSepQVRegion3,MeasTimes,MeasQV,ifittype,gofSepRegion3,fitconf,titlestr)
    end

  % Continue With Sep for Region 4
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion4,gofSepRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion4.adjrsquare;
        rmse=gofSepRegion4.rmse;
        GofStats3(9,4)=adjrsquare;
        GofStats4(9,4)=rmse;
        fitmonth=9;
        fitregion=4;
        PlotRegionalQVConfidence(FitSepQVRegion4,MeasTimes,MeasQV,ifittype,gofSepRegion4,fitconf,titlestr)
    end

  % Continue With Sep for Region 5
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion5,gofSepRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion5.adjrsquare;
        rmse=gofSepRegion5.rmse;
        GofStats3(9,5)=adjrsquare;
        GofStats4(9,5)=rmse;
        fitmonth=9;
        fitregion=5;
        PlotRegionalQVConfidence(FitSepQVRegion5,MeasTimes,MeasQV,ifittype,gofSepRegion5,fitconf,titlestr)
    end

  % Continue With Sep for Region 6
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion6,gofSepRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion6.adjrsquare;
        rmse=gofSepRegion6.rmse;
        GofStats3(9,6)=adjrsquare;
        GofStats4(9,6)=rmse;
        fitmonth=9;
        fitregion=6;
        PlotRegionalQVConfidence(FitSepQVRegion6,MeasTimes,MeasQV,ifittype,gofSepRegion6,fitconf,titlestr)
    end

 % Continue With Sep for Region 7
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion7,gofSepRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion7.adjrsquare;
        rmse=gofSepRegion7.rmse;
        GofStats3(9,7)=adjrsquare;
        GofStats4(9,7)=rmse;
        fitmonth=9;
        fitregion=7;
        PlotRegionalQVConfidence(FitSepQVRegion7,MeasTimes,MeasQV,ifittype,gofSepRegion7,fitconf,titlestr)
    end

  % Continue With Sep for Region 8
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion8,gofSepRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion8.adjrsquare;
        rmse=gofSepRegion8.rmse;
        GofStats3(9,8)=adjrsquare;
        GofStats4(9,8)=rmse;
        fitmonth=9;
        fitregion=8;
        PlotRegionalQVConfidence(FitSepQVRegion8,MeasTimes,MeasQV,ifittype,gofSepRegion8,fitconf,titlestr)
    end

  % Continue With Sep for Region 9
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion9,gofSepRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion9.adjrsquare;
        rmse=gofSepRegion9.rmse;
        GofStats3(9,9)=adjrsquare;
        GofStats4(9,9)=rmse;
        fitmonth=9;
        fitregion=9;
        PlotRegionalQVConfidence(FitSepQVRegion9,MeasTimes,MeasQV,ifittype,gofSepRegion9,fitconf,titlestr)
    end 

 % Continue With Sep for Region 10
    MeasTimes=TimeFrac(:,9);
    MeasQV=SepQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Sep','-FitType-',num2str(ifittype));
        [FitSepQVRegion10,gofSepRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofSepRegion10.adjrsquare;
        rmse=gofSepRegion10.rmse;
        GofStats3(9,10)=adjrsquare;
        GofStats4(9,10)=rmse;
        fitmonth=9;
        fitregion=10;
        PlotRegionalQVConfidence(FitSepQVRegion10,MeasTimes,MeasQV,ifittype,gofSepRegion10,fitconf,titlestr)
    end 

  % Start With Oct for Region 1
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion1,gofOctRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion1.adjrsquare;
        rmse=gofOctRegion1.rmse;
        GofStats3(10,1)=adjrsquare;
        GofStats4(10,1)=rmse;
        fitmonth=10;
        fitregion=1;
        PlotRegionalQVConfidence(FitOctQVRegion1,MeasTimes,MeasQV,ifittype,gofOctRegion1,fitconf,titlestr)
    end

  % Continue With Oct for Region 2
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion2,gofOctRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion2.adjrsquare;
        rmse=gofOctRegion2.rmse;
        GofStats3(10,2)=adjrsquare;
        GofStats4(10,2)=rmse;
        fitmonth=10;
        fitregion=2;
        PlotRegionalQVConfidence(FitOctQVRegion2,MeasTimes,MeasQV,ifittype,gofOctRegion2,fitconf,titlestr)
    end

  % Continue With Oct for Region 3
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion3,gofOctRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion3.adjrsquare;
        rmse=gofOctRegion3.rmse;
        GofStats3(10,3)=adjrsquare;
        GofStats4(10,3)=rmse;
        fitmonth=10;
        fitregion=3;
        PlotRegionalQVConfidence(FitOctQVRegion3,MeasTimes,MeasQV,ifittype,gofOctRegion3,fitconf,titlestr)
    end

  % Continue With Oct for Region 4
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion4,gofOctRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion4.adjrsquare;
        rmse=gofOctRegion4.rmse;
        GofStats3(10,4)=adjrsquare;
        GofStats4(10,4)=rmse;
        fitmonth=10;
        fitregion=4;
        PlotRegionalQVConfidence(FitOctQVRegion4,MeasTimes,MeasQV,ifittype,gofOctRegion4,fitconf,titlestr)
    end

  % Continue With Oct for Region 5
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion5,gofOctRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion5.adjrsquare;
        rmse=gofOctRegion5.rmse;
        GofStats3(10,5)=adjrsquare;
        GofStats4(10,5)=rmse;
        fitmonth=10;
        fitregion=5;
        PlotRegionalQVConfidence(FitOctQVRegion5,MeasTimes,MeasQV,ifittype,gofOctRegion5,fitconf,titlestr)
    end

  % Continue With Oct for Region 6
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion6,gofOctRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion6.adjrsquare;
        rmse=gofOctRegion6.rmse;
        GofStats3(10,6)=adjrsquare;
        GofStats4(10,6)=rmse;
        fitmonth=10;
        fitregion=6;
        PlotRegionalQVConfidence(FitOctQVRegion6,MeasTimes,MeasQV,ifittype,gofOctRegion6,fitconf,titlestr)
    end

 % Continue With Oct for Region 7
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion7,gofOctRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion7.adjrsquare;
        rmse=gofOctRegion7.rmse;
        GofStats3(10,7)=adjrsquare;
        GofStats4(10,7)=rmse;
        fitmonth=10;
        fitregion=7;
        PlotRegionalQVConfidence(FitOctQVRegion7,MeasTimes,MeasQV,ifittype,gofOctRegion7,fitconf,titlestr)
    end

  % Continue With Oct for Region 8
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion8,gofOctRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion8.adjrsquare;
        rmse=gofOctRegion8.rmse;
        GofStats3(10,8)=adjrsquare;
        GofStats4(10,8)=rmse;
        fitmonth=10;
        fitregion=8;
        PlotRegionalQVConfidence(FitOctQVRegion8,MeasTimes,MeasQV,ifittype,gofOctRegion8,fitconf,titlestr)
    end

  % Continue With Oct for Region 9
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion9,gofOctRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion9.adjrsquare;
        rmse=gofOctRegion9.rmse;
        GofStats3(10,9)=adjrsquare;
        GofStats4(10,9)=rmse;
        fitmonth=10;
        fitregion=9;
        PlotRegionalQVConfidence(FitOctQVRegion9,MeasTimes,MeasQV,ifittype,gofOctRegion9,fitconf,titlestr)
    end 

 % Continue With Oct for Region 10
    MeasTimes=TimeFrac(:,10);
    MeasQV=OctQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Oct','-FitType-',num2str(ifittype));
        [FitOctQVRegion10,gofOctRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofOctRegion10.adjrsquare;
        rmse=gofOctRegion10.rmse;
        GofStats3(10,10)=adjrsquare;
        GofStats4(10,10)=rmse;
        fitmonth=10;
        fitregion=10;
        PlotRegionalQVConfidence(FitOctQVRegion10,MeasTimes,MeasQV,ifittype,gofOctRegion10,fitconf,titlestr)
    end 

  % Start With Nov for Region 1
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion1,gofNovRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion1.adjrsquare;
        rmse=gofNovRegion1.rmse;
        GofStats3(11,1)=adjrsquare;
        GofStats4(11,1)=rmse;
        fitmonth=11;
        fitregion=1;
        PlotRegionalQVConfidence(FitNovQVRegion1,MeasTimes,MeasQV,ifittype,gofNovRegion1,fitconf,titlestr)
    end

  % Continue With Nov for Region 2
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion2,gofNovRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion2.adjrsquare;
        rmse=gofNovRegion2.rmse;
        GofStats3(11,2)=adjrsquare;
        GofStats4(11,2)=rmse;
        fitmonth=11;
        fitregion=2;
        PlotRegionalQVConfidence(FitNovQVRegion2,MeasTimes,MeasQV,ifittype,gofNovRegion2,fitconf,titlestr)
    end

  % Continue With Nov for Region 3
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion3,gofNovRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion3.adjrsquare;
        rmse=gofNovRegion3.rmse;
        GofStats3(11,3)=adjrsquare;
        GofStats4(11,3)=rmse;
        fitmonth=11;
        fitregion=3;
        PlotRegionalQVConfidence(FitNovQVRegion3,MeasTimes,MeasQV,ifittype,gofNovRegion3,fitconf,titlestr)
    end

  % Continue With Nov for Region 4
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion4,gofNovRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion4.adjrsquare;
        rmse=gofNovRegion4.rmse;
        GofStats3(11,4)=adjrsquare;
        GofStats4(11,4)=rmse;
        fitmonth=11;
        fitregion=4;
        PlotRegionalQVConfidence(FitNovQVRegion4,MeasTimes,MeasQV,ifittype,gofNovRegion4,fitconf,titlestr)
    end

  % Continue With Nov for Region 5
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion5,gofNovRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion5.adjrsquare;
        rmse=gofNovRegion5.rmse;
        GofStats3(11,5)=adjrsquare;
        GofStats4(11,5)=rmse;
        fitmonth=11;
        fitregion=5;
        PlotRegionalQVConfidence(FitNovQVRegion5,MeasTimes,MeasQV,ifittype,gofNovRegion5,fitconf,titlestr)
    end

  % Continue With Nov for Region 6
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion6,gofNovRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion6.adjrsquare;
        rmse=gofNovRegion6.rmse;
        GofStats3(11,6)=adjrsquare;
        GofStats4(11,6)=rmse;
        fitmonth=11;
        fitregion=6;
        PlotRegionalQVConfidence(FitNovQVRegion6,MeasTimes,MeasQV,ifittype,gofNovRegion6,fitconf,titlestr)
    end

 % Continue With Nov for Region 7
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion7,gofNovRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion7.adjrsquare;
        rmse=gofNovRegion7.rmse;
        GofStats3(11,7)=adjrsquare;
        GofStats4(11,7)=rmse;
        fitmonth=11;
        fitregion=7;
        PlotRegionalQVConfidence(FitNovQVRegion7,MeasTimes,MeasQV,ifittype,gofNovRegion7,fitconf,titlestr)
    end

  % Continue With Nov for Region 8
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion8,gofNovRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion8.adjrsquare;
        rmse=gofNovRegion8.rmse;
        GofStats3(11,8)=adjrsquare;
        GofStats4(11,8)=rmse;
        fitmonth=11;
        fitregion=8;
        PlotRegionalQVConfidence(FitNovQVRegion8,MeasTimes,MeasQV,ifittype,gofNovRegion8,fitconf,titlestr)
    end

  % Continue With Nov for Region 9
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion9,gofNovRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion9.adjrsquare;
        rmse=gofNovRegion9.rmse;
        GofStats3(11,9)=adjrsquare;
        GofStats4(11,9)=rmse;
        fitmonth=11;
        fitregion=9;
        PlotRegionalQVConfidence(FitNovQVRegion9,MeasTimes,MeasQV,ifittype,gofNovRegion9,fitconf,titlestr)
    end 

 % Continue With Nov for Region 10
    MeasTimes=TimeFrac(:,11);
    MeasQV=NovQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Nov','-FitType-',num2str(ifittype));
        [FitNovQVRegion10,gofNovRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofNovRegion10.adjrsquare;
        rmse=gofNovRegion10.rmse;
        GofStats3(11,10)=adjrsquare;
        GofStats4(11,10)=rmse;
        fitmonth=11;
        fitregion=10;
        PlotRegionalQVConfidence(FitNovQVRegion10,MeasTimes,MeasQV,ifittype,gofNovRegion10,fitconf,titlestr)
    end

  % Start With Dec for Region 1
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,1);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Germany';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion1,gofDecRegion1] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion1.adjrsquare;
        rmse=gofDecRegion1.rmse;
        GofStats3(12,1)=adjrsquare;
        GofStats4(12,1)=rmse;
        fitmonth=12;
        fitregion=1;
        PlotRegionalQVConfidence(FitDecQVRegion1,MeasTimes,MeasQV,ifittype,gofDecRegion1,fitconf,titlestr)
    end

  % Continue With Dec for Region 2
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,2);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Finland';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion2,gofDecRegion2] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion2.adjrsquare;
        rmse=gofDecRegion2.rmse;
        GofStats3(12,2)=adjrsquare;
        GofStats4(12,2)=rmse;
        fitmonth=12;
        fitregion=2;
        PlotRegionalQVConfidence(FitDecQVRegion2,MeasTimes,MeasQV,ifittype,gofDecRegion2,fitconf,titlestr)
    end

  % Continue With Dec for Region 3
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,3);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='UK';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion3,gofDecRegion3] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion3.adjrsquare;
        rmse=gofDecRegion3.rmse;
        GofStats3(12,3)=adjrsquare;
        GofStats4(12,3)=rmse;
        fitmonth=12;
        fitregion=3;
        PlotRegionalQVConfidence(FitDecQVRegion3,MeasTimes,MeasQV,ifittype,gofDecRegion3,fitconf,titlestr)
    end

  % Continue With Dec for Region 4
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,4);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Sudan';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion4,gofDecRegion4] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion4.adjrsquare;
        rmse=gofDecRegion4.rmse;
        GofStats3(12,4)=adjrsquare;
        GofStats4(12,4)=rmse;
        fitmonth=12;
        fitregion=4;
        PlotRegionalQVConfidence(FitDecQVRegion4,MeasTimes,MeasQV,ifittype,gofDecRegion4,fitconf,titlestr)
    end

  % Continue With Dec for Region 5
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,5);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='SouthAfrica';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion5,gofDecRegion5] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion5.adjrsquare;
        rmse=gofDecRegion5.rmse;
        GofStats3(12,5)=adjrsquare;
        GofStats4(12,5)=rmse;
        fitmonth=12;
        fitregion=5;
        PlotRegionalQVConfidence(FitDecQVRegion5,MeasTimes,MeasQV,ifittype,gofDecRegion5,fitconf,titlestr)
    end

  % Continue With Dec for Region 6
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,6);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='India';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion6,gofDecRegion6] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion6.adjrsquare;
        rmse=gofDecRegion6.rmse;
        GofStats3(12,6)=adjrsquare;
        GofStats4(12,6)=rmse;
        fitmonth=12;
        fitregion=6;
        PlotRegionalQVConfidence(FitDecQVRegion6,MeasTimes,MeasQV,ifittype,gofDecRegion6,fitconf,titlestr)
    end

 % Continue With Dec for Region 7
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,7);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Australia';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion7,gofDecRegion7] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion7.adjrsquare;
        rmse=gofDecRegion7.rmse;
        GofStats3(12,7)=adjrsquare;
        GofStats4(12,7)=rmse;
        fitmonth=12;
        fitregion=7;
        PlotRegionalQVConfidence(FitDecQVRegion7,MeasTimes,MeasQV,ifittype,gofDecRegion7,fitconf,titlestr)
    end

  % Continue With Dec for Region 8
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,8);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='California';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion8,gofDecRegion8] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion8.adjrsquare;
        rmse=gofDecRegion8.rmse;
        GofStats3(12,8)=adjrsquare;
        GofStats4(12,8)=rmse;
        fitmonth=12;
        fitregion=8;
        PlotRegionalQVConfidence(FitDecQVRegion8,MeasTimes,MeasQV,ifittype,gofDecRegion8,fitconf,titlestr)
    end

  % Continue With Dec for Region 9
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,9);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Texas';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion9,gofDecRegion9] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion9.adjrsquare;
        rmse=gofDecRegion9.rmse;
        GofStats3(12,9)=adjrsquare;
        GofStats4(12,9)=rmse;
        fitmonth=12;
        fitregion=9;
        PlotRegionalQVConfidence(FitDecQVRegion9,MeasTimes,MeasQV,ifittype,gofDecRegion9,fitconf,titlestr)
    end 

 % Continue With Dec for Region 10
    MeasTimes=TimeFrac(:,12);
    MeasQV=DecQV(:,10);
    [MeasTimes,MeasQV] = RemoveMissingValues(MeasTimes,MeasQV);
    numvals=length(MeasTimes);
    ifittype=2;
    numvals=length(MeasTimes);
    fitconf=0.75;
    if(numvals>30)
        RegionName='Peru';
        titlestr=strcat('FittedQV-Region-',RegionName,'-Month-Dec','-FitType-',num2str(ifittype));
        [FitDecQVRegion10,gofDecRegion10] = fit(MeasTimes,MeasQV,'poly2',fo);
        adjrsquare=gofDecRegion10.adjrsquare;
        rmse=gofDecRegion10.rmse;
        GofStats3(12,10)=adjrsquare;
        GofStats4(12,10)=rmse;
        fitmonth=12;
        fitregion=10;
        PlotRegionalQVConfidence(FitDecQVRegion10,MeasTimes,MeasQV,ifittype,gofDecRegion10,fitconf,titlestr)
    end 
% Save run data


isavefiles=1;
if(isavefiles==1)
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='GofStats3 GofStats4 ';
    varstr2=' PredQVStart PredQVEnd PredQVChng';
    varstr=strcat(varstr1,varstr2);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr);
else
    dispstr=strcat('Did Not Save Matlab File-',MatFileName);
    disp(dispstr);
end
%% Plot the Avergage Specific Humidity Changes
titlestr='AvgQVChanges-1980-2020';
iAddToReport=1;
iNewChapter=1;
iCloseChapter=1;
DisplayMonthlyAvgQV(titlestr,ifittype,iAddToReport,iNewChapter,iCloseChapter)
disp('Run Complete');
end