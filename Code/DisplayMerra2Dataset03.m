function  DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% This routine will display one frame of data for a single variable at one
% time slice and or 1 pressure slice. Multiple types of data can be plotted with this one function
% This routine is specific to the Merra 2 Dataset 3 which has a total of 12
% variables int it
% Written By: Stephen Forczyk
% Created: Nov 1,2023
% Revised: Nov 2-5 Added O3 and PS
% Revised: Nov 6,2023 take advantage of stats previously computed
% Revised: Nov 20-28 added code to activitate PDF report creation
% of figures generated in this routine

% Classification: Unclassified
global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevelUsed PressureLabels42 PressureLabels72 framecounter;
global TimeSlices iTimeSlice numtimeslice;
global Merra2FileName Merra2Dat Merra2ShortFileName numSelectedFiles;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global Merra2WorkingMask6 Merra2WorkingMask7;
global Merra2WorkingMask8 Merra2WorkingMask9 Merra2WorkingMask10;

global idebug;
global LatitudesS LongitudesS LevS;
global O3S PSS QVS HS QV2MS SLPS TS T2MS;
global HS01 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S01 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;

global PSS01 PSS25 PSS50 PSS75 PSS90 PSS100 PSSLow PSSHigh PSSNaN;
global QVS01 QVS25 QVS50 QVS75 QVS90 QVS100 QVSLow QVSHigh QVSNaN;
global SLPS01 SLPS25 SLPS50 SLPS75 SLPS90 SLPS100 SLPSLow SLPSHigh SLPSNaN;
global TS01 TS25 TS50 TS75 TS90 TS100 TSLow TSHigh TSNaN;
global US01 US25 US50 US75 US90 US100 USLow USHigh USNaN;
global VS01 VS25 VS50 VS75 VS90 VS100 VSLow VSHigh VSNaN;
global HSValues O3SValues PSSValues QVSValues SLPSValues TSValues;
global USValues VSValues;
global timeS US VS;
global LatitudesS LongitudesS ;
global YearMonthDayStr1 YearMonthDayStr2;
global ChoiceList;
global PascalsToMilliBars PascalsToPsi;
global PSTable PSTT;
global SLPTable SLPTT;


global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;
global yd md dd;
global iCityPlot;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;


global LatitudesS LongitudesS ;
global numSelectedFiles;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global Merra2WorkingSeaMask1 Merra2WorkingSeaMask2 Merra2WorkingSeaMask3;
global Merra2WorkingSeaMask4 Merra2WorkingSeaMask5;
global ROIName1 ROIName2 ROIName3 ROIName4 ROIName5;
global ROIName6 ROIName7 ROIName8 ROIName9 ROIName10;
global Merra2WorkingSeaBoundary1Lat Merra2WorkingSeaBoundary1Lon Merra2WorkingSeaBoundary1Area;
global Merra2WorkingSeaBoundary2Lat Merra2WorkingSeaBoundary2Lon Merra2WorkingSeaBoundary2Area;
global Merra2WorkingSeaBoundary3Lat Merra2WorkingSeaBoundary3Lon Merra2WorkingSeaBoundary3Area;
global Merra2WorkingSeaBoundary4Lat Merra2WorkingSeaBoundary4Lon Merra2WorkingSeaBoundary4Area;
global Merra2WorkingSeaBoundary5Lat Merra2WorkingSeaBoundary5Lon Merra2WorkingSeaBoundary5Area;
global SeaMaskFileName SeaBoundaryFiles SeaMaskChoices numSelectedSeaMasks;
global SelectedSeaMaskData SortedSBF indexSBF;
global SelectedMaskData numSelectedMasks numUserSelectedSeaMasks;
global heightkm;

global numtimeslice TimeSlices;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global numlat numlon Rpix latlim lonlim rasterSize;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
global yd md dd;



global westEdge eastEdge southEdge northEdge;
global vTemp TempMovieName iMovie;
global vTemp4 TempMovieName4 MovieFlags;
global vTemp5 TempMovieName5;
global vTemp6 TempMovieName6;
global vTemp7 TempMovieName7;
global vTemp17 TempMovieName17;
global vTemp34 TempmovieName34;
global vTemp4 TempMovieName4 MovieFlags;
global iLogo LogoFileName1 LogoFileName2 isaveJpeg iSkipReportFrames


global idebug iCityPlot World200TopCities maxCities ;
global DayStr YearMonthDayStr FullTimeStr;
global NumProcFiles ProcFileList iSeaSalt;

% additional paths needed for mapping
global matpath1 maskpath;
global fid isavefiles;

% additional paths needed for mapping
global matpath1 mappath ;
global savepath jpegpath pdfpath logpath moviepath tablepath;
global YearMonthStr MonthStr YearStr MonthYearStr;

global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
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
% additional paths needed for mapping
global gridpath;
global matpath1 mappath;
global canadapath stateshapepath topopath;
global trajpath militarypath;
global figpath screencapturepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;
global govjpegpath;

 
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*
end


% monthnum=str2double(MonthStr);
% [MonthName] = ConvertMonthNumToStr(monthnum);
if(iTimeSlice==1)
    TimeStr='-00-Hrs-GMT';
elseif(iTimeSlice==2)
    TimeStr='-06-Hrs-GMT';
elseif(iTimeSlice==3)
    TimeStr='-12-Hrs-GMT';
elseif(iTimeSlice==4)
    TimeStr='-18-Hrs-GMT';
end
if(ikind==1)
    data=HS.values(:,:,iPress42,iTimeSlice);
    heightkm=PressureLevel42(iPress42,3);
    fillvalue=HS.FillValue;
    PlotArray=HSValues;
    labelstr='meters';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Geopotential Height';
    units='meters';
    titlestr=strcat('HS-',Merra2ShortFileName,'-Heightkm=',num2str(heightkm),TimeStr);
    descstr=strcat('Average Monthly Value follows for-',titlestr);
    fracNaN=HSNaN(framecounter,1);
elseif(ikind==2)
    heightkm=PressureLevel42(iPress42,3);
    PlotArray=O3SValues;
    labelstr='Ozone Mixing Ratio';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Ozone Mixing Ratio';
    units='kg/kg';
    titlestr=strcat('O3-',Merra2ShortFileName,'-Heightkm=',num2str(heightkm),TimeStr);
    descstr=strcat('Average Monthly stats follow for-',titlestr);
    fracNaN=O3SNaN(framecounter,1);
elseif(ikind==3)
    heightkm=PressureLevel42(iPress42,3);
    PlotArray=PSSValues;
    labelstr='Surface Pressure';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Surface Pressure';
    units='kPa';
    titlestr=strcat('PSS-',Merra2ShortFileName,TimeStr);
    descstr=strcat('Average Monthly stats follow for-',titlestr);
    fracNaN=PSSNaN(framecounter,1);
elseif(ikind==4)
    heightkm=PressureLevel42(iPress42,3);
    PlotArray=QVSValues;
    labelstr='Specific Humidity (kg/kg)';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Specific Humidity';
    units='kg/kg';
    titlestr=strcat('QVS-',Merra2FileName);
    descstr=strcat('Average Monthly Stats follow for-',titlestr);
    fracNaN=QVSNaN(framecounter,1);
elseif(ikind==5)
    heightkm=0;
    PlotArray=SLPSValues;
    labelstr='Surface Level Press kPa';
    [nrows,ncols]=size(PlotArray);
    desc='SLP';
    units='kPA';
    titlestr=strcat('SLPS-',Merra2FileName);
    descstr=strcat('Average monthly stats  follow for-',titlestr);
    FullTimeStr=YearMonthStr;
    fracNaN=SLPSNaN(framecounter,1);
elseif(ikind==6)
    heightkm=PressureLevel42(iPress42,3);
    PlotArray=TSValues;
    labelstr='Air Temp (Deg-k)';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Air Temp';
    units='Deg-C';
    titlestr=strcat('TS-',Merra2FileName);
    descstr=strcat('Average Monthly Stats follow for-',titlestr);
    fracNaN=TSNaN(framecounter,1);
elseif(ikind==7)
    heightkm=PressureLevel42(iPress42,3);
    fillvalue=US.FillValue;
    USValues(USValues==fillvalue)=NaN;
    PlotArray=USValues;
    labelstr='East Wind (m/s)';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='East Wind';
    units='m/s';  
    titlestr=strcat('East Wind Component-',Merra2FileName);
    descstr=strcat('Basic monthly stats follow for-',titlestr);
    fracNaN=USNaN(framecounter,1);
elseif(ikind==8)
    heightkm=PressureLevel42(iPress42,3);
    fillvalue=VS.FillValue;
    VSValues(VSValues==fillvalue)=NaN;
    PlotArray=VSValues;
    labelstr='North Wind (m/s)';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='North Wind';
    units='m/s';  
    titlestr=strcat('North Wind Component-',Merra2FileName);
    descstr=strcat('Basic monthly stats follow for-',titlestr);
    fracNaN=VSNaN(framecounter,1);

end
[nrows,ncols]=size(PlotArray);

%% Set Calculate a few basic stats
[nrows,ncols]=size(PlotArray);
numpts=nrows*ncols;

%% Plot the Geopotential Height
% Calculate some stats
if((ikind==1))
    numpts=nrows*ncols;
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=HS01(framecounter,1);
    val25=HS25(framecounter,1);
    val50=HS50(framecounter,1);
    val75=HS75(framecounter,1);
    val90=HS90(framecounter,1);
    val100=HS100(framecounter,1);
    if(framecounter==1)
        descstr=strcat('Basic monthly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,5));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,5));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,5));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,5));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('90 % Ptile -',desc,'=',num2str(val90,5));
        fprintf(fid,'%s\n',ptc90str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval2=1000*ceil(heightkm)+1000;
    [ihigh]=find(PlotArray1DS>maxval2);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    minval=maxval2-3000;
    if(minval<0)
        minval=0;
    end
elseif(ikind==2)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=O3S01(framecounter,1);
    val25=O3S25(framecounter,1);
    val50=O3S50(framecounter,1);
    val75=O3S75(framecounter,1);
    val90=O3S90(framecounter,1);
    val100=O3S100(framecounter,1);
    if(framecounter==1)

    end
    if(framecounter==1)
        descstr=strcat('Basic monthly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('90 % Ptile -',desc,'=',num2str(val90,6));
        fprintf(fid,'%s\n',ptc90str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval2=val100;
    [ihigh]=find(PlotArray1DS>1E-5);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    minval=val01;
  elseif(ikind==3)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=PSS01(framecounter,1);
    val25=PSS25(framecounter,1);
    val50=PSS50(framecounter,1);
    val75=PSS75(framecounter,1);
    val90=PSS90(framecounter,1);
    val100=PSS100(framecounter,1);
    if(framecounter==1)
        descstr=strcat('Basic monthly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('90 % Ptile -',desc,'=',num2str(val90,6));
        fprintf(fid,'%s\n',ptc90str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval2=val100;
    [ihigh]=find(PlotArray1DS>val100);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    minval=val01;
  elseif(ikind==4)
    numpts=nrows*ncols;
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=QVS01(framecounter,1);
    val25=QVS25(framecounter,1);
    val50=QVS50(framecounter,1);
    val75=QVS75(framecounter,1);
    val90=QVS90(framecounter,1);
    val100=QVS100(framecounter,1);

    if(framecounter==1)
        descstr=strcat('Basic monthly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('90 % Ptile -',desc,'=',num2str(val90,6));
        fprintf(fid,'%s\n',ptc90str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval=val01;
    maxval2=val100;
    minval=1E-9;
    [ihigh]=find(PlotArray1DS>.3);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
 elseif(ikind==5)
    numpts=nrows*ncols;
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=SLPS01(framecounter,1);
    val25=SLPS25(framecounter,1);
    val50=SLPS50(framecounter,1);
    val75=SLPS75(framecounter,1);
    val90=SLPS90(framecounter,1);
    val100=SLPS100(framecounter,1);
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic monthly stats follow ');
        ptc1str= strcat('01 % Ptile SLP=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile SLP=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile SLP=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile SLP=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('99 % Ptile SLP=',num2str(val90,6));
        fprintf(fid,'%s\n',ptc90str);
        fprintf(fid,'%s\n',' End Stats follow for SLP');
    end
    [ihigh]=find(PlotArray1DS>120);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=118;
    maxval2=120;
    minval=floor(val01);
 elseif(ikind==6)
    numpts=nrows*ncols;
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=TS01(framecounter,1);
    val25=TS25(framecounter,1);
    val50=TS50(framecounter,1);
    val75=TS75(framecounter,1);
    val90=TS90(framecounter,1);
    val100=TS100(framecounter,1);
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for Monthly Average Data Average ');
        ptc1str= strcat('01 % Ptile TS=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile TS=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile TS=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile TS=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('90 % Ptile TS=',num2str(val90,6));
        fprintf(fid,'%s\n',ptc90str);
        fprintf(fid,'%s\n',' End Stats follow for TS');
    end
    [ihigh]=find(PlotArray1DS>100);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=100; 
    minval=-100;
  elseif(ikind==7)
    numpts=nrows*ncols;
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=US01(framecounter,1);
    val25=US25(framecounter,1);
    val50=US50(framecounter,1);
    val75=US75(framecounter,1);
    val90=US90(framecounter,1);
    val100=US100(framecounter,1);
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Monthly Stats follow ');
        ptc1str= strcat('01 % Ptile US=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile US=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile US=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile US=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('99 % Ptile US=',num2str(val90,6));
        fprintf(fid,'%s\n',ptc90str);
        fprintf(fid,'%s\n',' End Stats follow for US');
        
    end
    [ihigh]=find(PlotArray1DS>40);
    a1=isempty(ihigh);
   
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=40;
    maxval2=50; 
    minval=-40;
  elseif(ikind==8)
    numpts=nrows*ncols;
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    val01=VS01(framecounter,1);
    val25=VS25(framecounter,1);
    val50=VS50(framecounter,1);
    val75=VS75(framecounter,1);
    val90=VS90(framecounter,1);
    val100=VS100(framecounter,1);
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Monthly Stats follow ');
        ptc1str= strcat('01 % Ptile US=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile US=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile US=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile US=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc90str=strcat('99 % Ptile US=',num2str(val90,6));
        fprintf(fid,'%s\n',ptc90str);
        fprintf(fid,'%s\n',' End Stats follow for VS');
        
    end
    [ihigh]=find(PlotArray1DS>40);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=40;
    maxval2=50; 
    minval=-40;

end

%% Fetch the map limits

if(framecounter==-1)
    maplimitstr1='****Map Limits Follow*****';
    fprintf(fid,'%s\n',maplimitstr1);
    maplimitstr2=strcat('WestEdge=',num2str(westEdge,7),'-EastEdge=',num2str(eastEdge));
    fprintf(fid,'%s\n',maplimitstr2);
    maplimitstr3=strcat('SouthEdge=',num2str(southEdge,7),'-NorthEdge=',num2str(northEdge));
    fprintf(fid,'%s\n',maplimitstr3);
    maplimitstr4='****Map Limits End*****';
    fprintf(fid,'%s\n',maplimitstr4);
end
%% Set up the map axis
if(itype==1)
    axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
        'plabellocation',[-60 -50 -40 -30 -20 -10 0 10 20 30 40 50 60],'mlabellocation',[]);
elseif(itype==2)
    axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',20,'mlabellocation',30,...
     'MLabelParallel','south');    
elseif(itype==3)
    axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',15,'mlabellocation',30,...
     'MLabelParallel','south','GColor',[1 1 0],'GLineWidth',1);
end
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
colormap jet
%% Plot the cloud area fraction on the map
if((ikind==1))
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
    ab=1;

elseif(ikind==2) % This is a test to make NaN values transparent
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
    ab=1;
elseif(ikind==3)
    PlotArray=PlotArray-100;
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif(ikind==4)
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
 elseif(ikind==5)
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
    ab=1;
 elseif(ikind==6)
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
    ab=1;
 elseif(ikind==7)
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
    ab=1;
 elseif(ikind==8)
    geoimg=geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
    geoimg.FaceAlpha = 'texturemap';
    alpha (geoimg,double (~isnan (PlotArray)))
    hc = colorbar;
    hc.Label.String = units;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on

else


end
% load the country borders and plot them
eval(['cd ' mappath(1:length(mappath)-1)]);
load('USAHiResBoundaries.mat','USALat','USALon');
plot3m(USALat,USALon,maxval2,'w');
load('CanadaBoundaries.mat','CanadaLat','CanadaLon');
plot3m(CanadaLat,CanadaLon,maxval2,'w');
load('MexicoBoundaries.mat','MexicoLat','MexicoLon');
plot3m(MexicoLat,MexicoLon,maxval2,'w');
load('CubaBoundaries.mat','CubaLat','CubaLon');
plot3m(CubaLat,CubaLon,maxval2,'w');
load('DominicanRepublicBoundaries.mat','DRLat','DRLon');
plot3m(DRLat,DRLon,maxval2,'w');
load('HaitiBoundaries.mat','HaitiLat','HaitiLon');
plot3m(HaitiLat,HaitiLon,maxval2,'w');
load('BelizeBoundaries.mat','BelizeLat','BelizeLon');
plot3m(BelizeLat,BelizeLon,maxval2,'w');
load('GautemalaBoundaries.mat','GautemalaLat','GautemalaLon');
plot3m(GautemalaLat,GautemalaLon,maxval2,'w')
load('JamaicaBoundaries.mat','JamaicaLat','JamaicaLon');
plot3m(JamaicaLat,JamaicaLon,maxval2,'w');
load('NicaraguaBoundaries.mat','NicaraguaLat','NicaraguaLon');
plot3m(NicaraguaLat,NicaraguaLon,maxval2,'w')
load('HondurasBoundaries.mat','HondurasLat','HondurasLon');
plot3m(HondurasLat,HondurasLon,maxval2,'w')
load('ElSalvadorBoundaries.mat','ElSalvadorLat','ElSalvadorLon');
plot3m(ElSalvadorLat,ElSalvadorLon,maxval2,'w');
load('PanamaBoundaries.mat','PanamaLat','PanamaLon');
plot3m(PanamaLat,PanamaLon,maxval2,'w');
load('ColumbiaBoundaries.mat','ColumbiaLat','ColumbiaLon');
plot3m(ColumbiaLat,ColumbiaLon,maxval2,'w');
load('VenezuelaBoundaries.mat','VenezuelaLat','VenezuelaLon');
plot3m(VenezuelaLat,VenezuelaLon,maxval2,'w')
load('PeruBoundaries.mat','PeruLat','PeruLon');
plot3m(PeruLat,PeruLon,maxval2,'w');
load('EcuadorBoundaries.mat','EcuadorLat','EcuadorLon');
plot3m(EcuadorLat,EcuadorLon,maxval2,'w')
load('BrazilBoundaries.mat','BrazilLat','BrazilLon');
plot3m(BrazilLat,BrazilLon,maxval2,'w');
load('BoliviaBoundaries.mat','BoliviaLat','BoliviaLon');
plot3m(BoliviaLat,BoliviaLon,maxval2,'w')
load('ChileBoundaries.mat','ChileLat','ChileLon');
plot3m(ChileLat,ChileLon,maxval2,'w');
load('ArgentinaBoundaries.mat','ArgentinaLat','ArgentinaLon');
plot3m(ArgentinaLat,ArgentinaLon,maxval2,'w');
load('UruguayBoundaries.mat','UruguayLat','UruguayLon');
plot3m(UruguayLat,UruguayLon,maxval2,'w');
load('CostaRicaBoundaries.mat','CostaRicaLat','CostaRicaLon');
plot3m(CostaRicaLat,CostaRicaLon,maxval2,'w');
load('FrenchGuianaBoundaries.mat','FrenchGuianaLat','FrenchGuianaLon');
plot3m(FrenchGuianaLat,FrenchGuianaLon,maxval2,'w');
load('GuyanaBoundaries.mat','GuyanaLat','GuyanaLon');
plot3m(GuyanaLat,GuyanaLon,maxval2,'w');
load('SurinameBoundaries.mat','SurinameLat','SurinameLon');
plot3m(SurinameLat,SurinameLon,maxval2,'w');
load('SaudiBoundaries','SaudiLat','SaudiLon');
plot3m(SaudiLat,SaudiLon,maxval2,'w');
load('TurkeyBoundaries','TurkeyLat','TurkeyLon');
plot3m(TurkeyLat,TurkeyLon,maxval2,'w');
load('SyriaBoundaries','SyriaLat','SyriaLon');
plot3m(SyriaLat,SyriaLon,maxval2,'w');
load('LebanonBoundaries','LebanonLat','LebanonLon');
plot3m(LebanonLat,LebanonLon,maxval2,'w');
load('JordanBoundaries','JordanLat','JordanLon');
plot3m(JordanLat,JordanLon,maxval2,'w');
load('IranBoundaries','IranLat','IranLon');
plot3m(IranLat,IranLon,maxval2,'w');
load('IraqBoundaries','IraqLat','IraqLon');
plot3m(IraqLat,IraqLon,maxval2,'w');
load('KuwaitBoundaries','KuwaitLat','KuwaitLon');
plot3m(KuwaitLat,KuwaitLon,maxval2,'w');
load('IsraelBoundaries','IsraelLat','IsraelLon');
plot3m(IsraelLat,IsraelLon,maxval2,'w');
load('AfricaLowResBoundaries','AfricaLat','AfricaLon');
plot3m(AfricaLat,AfricaLon,maxval2,'w');
load('AsiaLowResBoundaries.mat','AsiaLat','AsiaLon');
plot3m(AsiaLat,AsiaLon,maxval2,'w');
try
    load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');

catch
    load('EuropeLowResBoundaries.mat','EuropeLat','EuropeLon');
    disp('Failed to load Hi Res Europe data use low resolution data')
    
end
plot3m(EuropeLat,EuropeLon,maxval2,'w');
load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
plot3m(AustraliaLat,AustraliaLon,maxval2,'w');
ab=2;
%% Add Cities to the plot is desired
if(iCityPlot>0)
    for k=1:maxCities
        nowLat=World200TopCities{1+k,2};
        nowLon=World200TopCities{1+k,3};
        nowName=char(World200TopCities{1+k,1});
        plot3m(nowLat,nowLon,11,'b+');
        textm(nowLat,nowLon+3,11,nowName,'Color','white','FontSize',8);
    end
end
title(titlestr)
hold off
% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.08, .1,.04,]);

    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.07;
ty1=.18;
if(ikind<9)
    txtstr1=strcat('Date-',MonthYearStr,'-Press Level-km=',num2str(heightkm),'-Time=',TimeStr);

elseif(ikind>8)
    txtstr1=strcat('Date-',MonthYearStr,'-Time=',TimeStr);
end
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.07;
ty2=.14;
if(ikind<9)
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-90 ptile=',num2str(val90,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
else
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-90 ptile=',num2str(val90,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
end
if(ikind<9)
    tx3=.07;
    ty3=.10;
    txtstr3=strcat(['Fraction Of Values that are NaN=',num2str(fracNaN,4)]);
    txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',10);
end
set(newaxesh,'Visible','Off');
if(ikind==8)
    ab=1;
end

%% Save this graphic a a jpeg file
tic;
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
if((ikind<=130))
    figstr=strcat(varname,'-',FullTimeStr,'-iPress42-',num2str(iPress42),TimeStr,'.jpg');
end
if(isaveJpeg==1)
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr);
    eval(cmdString);
    div=2.5;
    endstr=strcat('------- Finished Plotting-',varname);
    fprintf(fid,'%s\n',endstr);
    capture='print';
elseif(isaveJpeg==2)
    screencapture(gcf,[],figstr)
    div=1.6;
    capture='screengrab';
else % Not saved (do not use is PDF report is being created)


end

pause(chart_time/2);
elapsed_time=toc;
close('all');
NumProcFiles=NumProcFiles+1;
ProcFileList{1+NumProcFiles,1}=figstr;
ProcFileList{1+NumProcFiles,2}=jpegpath;
ProcFileList{1+NumProcFiles,3}=elapsed_time;
ProcFileList{1+NumProcFiles,4}=capture;
rem=mod(framecounter-1,iSkipReportFrames);

if((iCreatePDFReport>0) && (RptGenPresent==1)  && (iAddToReport==1) && (rem==0) && (ikind<9) )
    if(iNewChapter)
        if(ikind==1)
            headingstr1=strcat('Analysis Results For Geopotential Height-',Merra2ShortFileName);
        elseif(ikind==2)
            headingstr1=strcat('Analysis Results For Ozone Mixing Ratio-',Merra2ShortFileName);
        elseif(ikind==3)
             headingstr1=strcat('Analysis Results For Surface Pressure-',Merra2ShortFileName);
        elseif(ikind==4)
             headingstr1=strcat('Analysis Results For Specific Humidity-',Merra2ShortFileName);
        elseif(ikind==5)
             headingstr1=strcat('Analysis Results For Sea Level Pressure-',Merra2ShortFileName);
        elseif(ikind==6)
             headingstr1=strcat('Analysis Results For Air Temperature-',Merra2ShortFileName);
        elseif(ikind==7)
             headingstr1=strcat('Analysis Results For East Wind Component-',Merra2ShortFileName);
        elseif(ikind==8)
             headingstr1=strcat('Analysis Results For North Wind Component-',Merra2ShortFileName);

        end
        chapter = Chapter("Title",headingstr1);
    end
    sectionstr=strcat(varname,'-Map');
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(varname,' For File-',Merra2ShortFileName);
    pdftext = Text(pdftxtstr);
    pdftext.Color = 'red';
    image.Caption = pdftext;
    nhighs=floor(nhigh/div);
    nwids=floor(nwid/div);
    heightstr=strcat(num2str(nhighs),'px');
    widthstr=strcat(num2str(nwids),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
% Now add some text -start by describing the with a basic description of the
% variable being plotted
    parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
    parastr2=strcat(' This metric is an hourly average for-',varname,'-at time slice-',TimeStr);
    if(ikind==1)
        parastr3='The expected data range for this dataset is from 0 to 30 km .';
    elseif(ikind==2)
        parastr3='The expected data range for this dataset is from 0 to 1E-8.';
    elseif(ikind==3)
        parastr3='The expected data range is 0 - 120 kPa plot has 100 kPA subtracted from actual values .';
    elseif(ikind==4)
        parastr3='The expected data range is 0 to 1 kg/kg .';
    elseif(ikind==5)
        parastr3='The expected data range for this dataset is from 0 to < 110 kPA .';
    elseif(ikind==6)
        parastr3='The expected data range for this dataset is from -60 to < 60 Deg C .';
    elseif(ikind==7)
        parastr3='The expected data range for this dataset is from -30 to < 30 m/sec.';
    elseif(ikind==8)
        parastr3='The expected data range for this dataset is from -30 to < 30 m/sec.';
    else
        parastr3='unspecified';
    end

    parastr9=strcat(parastr1,parastr2,parastr3);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
end
close('all');
end

