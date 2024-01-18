function  DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% This routine will display one frame of data for a single variable at one
% time slice. Multiple types of data can be plotted with this one function
% Written By: Stephen Forczyk
% Created: May 16,2023

% Revised: May 17,2023 adding variables to the plot
% Revised: May 20,2023 adding

% Classification: Unclassified
global LatitudesS LongitudesS ;
global DISPHS PSS QV10MS QV2MS SLPS T10MS T2MS;
global timeS TO3S TOXS TQIS TQLS TQVS TSS;
global TROPPBS TROPPTS TROPPVS TROPQS TROPTS;
global U10MS U2MS U50MS V10MS V2MS V50MS;
global PascalsToMilliBars PascalsToPsi;
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
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global idebug iCityPlot World200TopCities maxCities framecounter;
global YearMonthStr YearStr MonthStr DayStr YearMonthDayStr FullTimeStr;


% additional paths needed for mapping
global matpath1 mappath ;
global jpegpath savepath;
global fid isavefiles;



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
end

monthnum=str2double(MonthStr);
[MonthName] = ConvertMonthNumToStr(monthnum);

if(ikind==4)
    data=PSS.values(:,:,numtimeslice);
    fillvalue=PSS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data*PascalsToPsi;
    labelstr='SurfacePressure-Psi';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
elseif(ikind==5)
    data=QV10MS.values(:,:,numtimeslice);
    fillvalue=QV10MS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Specific Humidity @10 m kg/kg';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
elseif(ikind==6)
    data=QV2MS.values(:,:,numtimeslice);
    fillvalue=QV2MS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Specific Humidity @2 m kg/kg';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
elseif(ikind==7)
    data=SLPS.values(:,:,numtimeslice);
    fillvalue=SLPS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data*PascalsToPsi;
    labelstr='Sea Level Pressure=PSI';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==8)
    data=T10MS.values(:,:,numtimeslice);
    fillvalue=T10MS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Temp At 10 M-Deg K';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==9)
    data=T2MS.values(:,:,numtimeslice);
    fillvalue=T2MS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Temp At 2 M-Deg K';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==11)
    data=TO3S.values(:,:,numtimeslice);
    fillvalue=TO3S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Ozone Concentration In Dobsons';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==12)
    data=TOXS.values(:,:,numtimeslice);
    fillvalue=TOXS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Total Column Odd Oxygen In kg-m^2';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==13)
    data=TQIS.values(:,:,numtimeslice);
    fillvalue=TQIS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Total Precipatable Ice Water kg-m^2';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==14)
    data=TQLS.values(:,:,numtimeslice);
    fillvalue=TQLS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Total Precipatable Liquid Water kg-m^2';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==15)
    data=TQVS.values(:,:,numtimeslice);
    fillvalue=TQVS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Total Precipatable Water Vapor kg-m^2';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==16)
    data=TROPPBS.values(:,:,numtimeslice);
    fillvalue=TROPPBS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data*PascalsToPsi;
    labelstr='Tropropause Pressure Psi';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==17)
    data=TROPPTS.values(:,:,numtimeslice);
    fillvalue=TROPPTS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data*PascalsToPsi;
    labelstr='Tropropause Pressure Based On Thermal Estimate Psi';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==18)
    data=TROPPVS.values(:,:,numtimeslice);
    fillvalue=TROPPVS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data*PascalsToPsi;
    labelstr='Tropropause Pressure Based On EPV Estimate Psi';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
 elseif(ikind==19)
    data=TROPQS.values(:,:,numtimeslice);
    fillvalue=TROPQS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Tropropause Specific Humidity Using Blended TROPP';
    FullTimeStr=YearMonthStr;
  elseif(ikind==20)
    data=TROPTS.values(:,:,numtimeslice);
    fillvalue=TROPTS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Tropropause Temperature Using Blended TROPP';
    FullTimeStr=YearMonthStr;
  elseif(ikind==21)
    data=TSS.values(:,:,numtimeslice);
    fillvalue=TSS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Skin Temp';
    FullTimeStr=YearMonthStr;
end
[nrows,ncols]=size(PlotArray);

%% Set Up titles and units

% Select the variable to be used for the plot based on itype

if(ikind==1)
%     desc='Albedo';
%     units='dimensionless';
%     titlestr=strcat('Albedo For-',Merra2FileName);
%     descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==2)
%     desc='ALBNIRDF';
%     units='dimensioness';
%     titlestr=strcat('Surface Albedo NearIR Diffuse For-',Merra2FileName);
elseif(ikind==3)
%     desc='ALBNIRDR';
%     units='dimensionless';
%     titlestr=strcat('Surface Albedo Near IR Beam For-',Merra2FileName);
elseif(ikind==4)
    desc='PS';
    units='PSI';  
    titlestr=strcat('Surface Pressure For-', Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==5)
    desc='QV10M';
    units='kg/kg';  
    titlestr=strcat('Specific Humidity at 10 m For-', Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==6)
    desc='QV2M';
    units='kg/kg';  
    titlestr=strcat('Specific Humidity at 2 m-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==7)
    desc='SLP';
    units='PSI';  
    titlestr=strcat('Sea Level Pressure For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==8)
    desc='T10M';
    units='Deg-K';  
    titlestr=strcat('Temp at 10 M For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==9)
    desc='T2M';
    units='Deg-K';  
    titlestr=strcat('Temp at 2 M For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==11)
    desc='Total Column Ozone';
    units='Dobsons';  
    titlestr=strcat('Total Column Ozone Concentration For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==12)
    desc='Total Column Odd Oxygen';
    units='kg-m^2';  
    titlestr=strcat('Total Column Odd Oxygen Concentration For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==13)
    desc='Total Precipatable Ice Water ';
    units='kg-m^2';  
    titlestr=strcat('Total Precipitable Ice Water For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==14)
    desc='Total Precipatable Liquid Water';
    units='kg-m^2';  
    titlestr=strcat('Total Precipitable Liquid Water For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==15)
    desc='Total Precipatable Water Vapor';
    units='kg-m^2';  
    titlestr=strcat('Total Precipitable Water Vapor For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==16)
    desc='Tropopause Pressure';
    units='Psi';  
    titlestr=strcat('Tropopause Pressure For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==17)
    desc=' Tropopause Pressure Based On Thermal Estimate ';
    units='Psi';  
    titlestr=strcat('Tropopause Pressure Based On Thermal Estimate-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==18)
    desc=' Trop Pressure Based On EPV Estimate ';
    units='Psi';  
    titlestr=strcat('Tropopause Pressure Based On EPV Estimate For File-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==19)
    desc='Trop Specific Humidity Using Blended TROPP ';
    units='kg/kg';  
    titlestr=strcat('Trop Specific Humidity Using Blended TROPP Flux-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==20)
    desc='Trop Temperature Using Blended TROPP Estimate';
    units='Deg-K';  
    titlestr=strcat('Trop Temperature Using Blended TROPP Estimate For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==21)
    desc='Skin Temp';
    units='Deg K';  
    titlestr=strcat('Skin Temp For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==22)
    desc='Upwelling Long Wave Flux Clear Sky/No Aero';
    units='W/m^2';  
    titlestr=strcat('Upwelling Long Wave Clear Sky/No Aero Flux At TOA For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==23)
    desc='Incoming Surface Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Surface Incoming ShortWave Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==24)
    desc='Incoming Surface Clear Sky Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Surface Incoming ShortWave Clear Sky Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==25)
    desc='Surface Downwards Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Surface Downward ShortWave Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==26)
    desc='Surface Downwards Short Wave Flux No Aerosol- ';
    units='W/m^2';  
    titlestr=strcat('Surface Downward ShortWave Flux No Aerosol For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==27)
    desc='Surface Downwards Short Wave Flux Clear Sky- ';
    units='W/m^2';  
    titlestr=strcat('Surface Downward ShortWave Flux Clear Sky For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==28)
    desc='Surface Downwards Short Wave Flux Clear Sky No Aero- ';
    units='W/m^2';  
    titlestr=strcat('Surface Downward ShortWave Flux Clear Sky No Aero For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==29)
    desc='Toa Incoming Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Toa Incoming ShortWave Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==30)
    desc='Toa Net Downward Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Toa Net Downward ShortWave Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==31)
    desc='Toa Net Downward No Aero Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Toa Net Downward No Aero ShortWave Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==32)
    desc='Toa Net Downward Clear Sky Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Toa Net Downward Clear Sky ShortWave Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==33)
    desc='Toa Net Downward Clear Sky No Aero Short Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Toa Net Downward Clear Sky No Aero ShortWave Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==34)
    desc='High Cloud Optical Thickness ';
    units='-diemnsionless';  
    titlestr=strcat('High Cloud Optical Thickness For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==35)
    desc='Low Cloud Optical Thickness ';
    units='-diemnsionless';  
    titlestr=strcat('Low Cloud Optical Thickness For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==36)
    desc='Mid Cloud Optical Thickness ';
    units='-diemnsionless';  
    titlestr=strcat('Mid Cloud Optical Thickness For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==37)
    desc='TOT Cloud Optical Thickness ';
    units='-diemnsionless';  
    titlestr=strcat('Tot Cloud Optical Thickness For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==39)
    desc='Skin Temp ';
    units='-Deg-K';  
    titlestr=strcat('Skin Temp For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
end


%% Plot the Cloud Optical Thickness 
numpts=nrows*ncols;
% Calculate some stats
if((ikind==4))
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile -',desc,'=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    maxval2=20;
    [ihigh]=find(PlotArray1DS>17);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end

 elseif(ikind==5)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
    ptc1str= strcat('01 % Ptile QV10M=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile QV10M=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile QV10M=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile QV10M=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile QV10M=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for QV10M');
    [ihigh]=find(PlotArray1DS>1);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1;
    maxval2=maxval+10; 
 elseif(ikind==6)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
    ptc1str= strcat('01 % Ptile QV2M=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile QV2M=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile QV2M=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile QV2M=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile QV2M=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for QV2M');
    [ihigh]=find(PlotArray1DS>1);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1;
    maxval2=maxval+10; 
  elseif(ikind==7)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
    ptc1str= strcat('01 % Ptile SLP=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile SLP=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile SLP=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile SLP=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile SLP=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for SLP');
    [ihigh]=find(PlotArray1DS>20);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=20;
    maxval2=maxval+10; 
  elseif(ikind==8)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
    ptc1str= strcat('01 % Ptile T10M=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile T10M=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile T10M=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile T10M=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile T10M=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for T10M');
    [ihigh]=find(PlotArray1DS>500);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500;
    maxval2=maxval+10; 
  elseif(ikind==9)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
    ptc1str= strcat('01 % Ptile T2M=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile T2M=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile T2M=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile T2M=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile T2M=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for T2M');
    [ihigh]=find(PlotArray1DS>500);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500;
    maxval2=maxval+10; 
elseif(ikind==11)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TO3-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TO3-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TO3-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TO3-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TO3-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for TO3-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>1000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1000;
    maxval2=maxval+10;
 elseif(ikind==12)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TOX-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TOX-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TOX-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TOX-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TOX-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for TOX-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>1000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1000;
    maxval2=maxval+10;
 elseif(ikind==13)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TQI-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TQI-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TQI-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TQI-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TQI-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for TQI-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>10);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=10;
    maxval2=maxval+10;
elseif((ikind==14))
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TQL-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TQL-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TQL-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TQL-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TQL-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for TQL-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>10);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=10;
    maxval2=maxval+10;

elseif(ikind==15)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TQV-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TQV-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TQV-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TQV-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TQV-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>100);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100;
    maxval2=maxval+10;

  elseif((ikind==16))
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TROPPB-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TROPPB-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TROPPB-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TROPPB-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TROPPB-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>20);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=50;
    maxval2=maxval+10;

elseif(ikind==17)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TROPPT-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TROPPT-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TROPPT-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TROPPT-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TROPPT-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>20);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=50;
    maxval2=maxval+10;
elseif(ikind==18)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TROPPV-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TROPPV-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TROPPV-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TROPPV-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TROPPV-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>20);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=50;
    maxval2=maxval+10;
  elseif(ikind==19)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TROPQ-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TROPQ-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TROPQ-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TROPQ-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TROPQ-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>1);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=50;
    maxval2=maxval+10;
  elseif(ikind==20)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TROPT-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TROPT-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TROPT-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TROPT-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TROPT-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>500);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500;
    maxval2=maxval+10;

  elseif(ikind==21)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile TS-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile TS-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile TS-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile TS-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile TS-',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    [ihigh]=find(PlotArray1DS>500);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500;
    maxval2=maxval+10;

elseif(ikind==39)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    fprintf(fid,'%s\n',descstr);
    ptc1str= strcat('01 % Ptile-',desc,num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile-',desc,num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile-',desc,num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile-',desc,num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile -',desc,num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    endstr=strcat('End stats for-',desc);
    fprintf(fid,'%s\n',endstr);
    frachigh=1;
    maxval=500;
    maxval2=maxval+20; 

end

%% Fetch the map limits

if(framecounter==1)
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
if((ikind==4) || (ikind==5) || (ikind==6) || (ikind==7) || (ikind==8) || (ikind==9))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif((ikind==11) || (ikind==12) || (ikind==13) || (ikind==14) || (ikind==15) || (ikind==16))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on

elseif((ikind==17) || (ikind==18) || (ikind==19) || (ikind==20) || (ikind==21))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on


else

end
% load the country borders and plot them
eval(['cd ' mappath(1:length(mappath)-1)]);
load('USAHiResBoundaries.mat','USALat','USALon');
plot3m(USALat,USALon,maxval2,'r');
load('CanadaBoundaries.mat','CanadaLat','CanadaLon');
plot3m(CanadaLat,CanadaLon,maxval2,'r');
load('MexicoBoundaries.mat','MexicoLat','MexicoLon');
plot3m(MexicoLat,MexicoLon,maxval2,'r');
load('CubaBoundaries.mat','CubaLat','CubaLon');
plot3m(CubaLat,CubaLon,maxval2,'r');
load('DominicanRepublicBoundaries.mat','DRLat','DRLon');
plot3m(DRLat,DRLon,maxval2,'r');
load('HaitiBoundaries.mat','HaitiLat','HaitiLon');
plot3m(HaitiLat,HaitiLon,maxval2,'r');
load('BelizeBoundaries.mat','BelizeLat','BelizeLon');
plot3m(BelizeLat,BelizeLon,maxval2,'r');
load('GautemalaBoundaries.mat','GautemalaLat','GautemalaLon');
plot3m(GautemalaLat,GautemalaLon,maxval2,'r')
load('JamaicaBoundaries.mat','JamaicaLat','JamaicaLon');
plot3m(JamaicaLat,JamaicaLon,maxval2,'r');
load('NicaraguaBoundaries.mat','NicaraguaLat','NicaraguaLon');
plot3m(NicaraguaLat,NicaraguaLon,maxval2,'r')
load('HondurasBoundaries.mat','HondurasLat','HondurasLon');
plot3m(HondurasLat,HondurasLon,maxval2,'r')
load('ElSalvadorBoundaries.mat','ElSalvadorLat','ElSalvadorLon');
plot3m(ElSalvadorLat,ElSalvadorLon,maxval2,'r');
load('PanamaBoundaries.mat','PanamaLat','PanamaLon');
plot3m(PanamaLat,PanamaLon,maxval2,'r');
load('ColumbiaBoundaries.mat','ColumbiaLat','ColumbiaLon');
plot3m(ColumbiaLat,ColumbiaLon,maxval2,'r');
load('VenezuelaBoundaries.mat','VenezuelaLat','VenezuelaLon');
plot3m(VenezuelaLat,VenezuelaLon,maxval2,'r')
load('PeruBoundaries.mat','PeruLat','PeruLon');
plot3m(PeruLat,PeruLon,maxval2,'r');
load('EcuadorBoundaries.mat','EcuadorLat','EcuadorLon');
plot3m(EcuadorLat,EcuadorLon,maxval2,'r')
load('BrazilBoundaries.mat','BrazilLat','BrazilLon');
plot3m(BrazilLat,BrazilLon,maxval2,'r');
load('BoliviaBoundaries.mat','BoliviaLat','BoliviaLon');
plot3m(BoliviaLat,BoliviaLon,maxval2,'r')
load('ChileBoundaries.mat','ChileLat','ChileLon');
plot3m(ChileLat,ChileLon,maxval2,'r');
load('ArgentinaBoundaries.mat','ArgentinaLat','ArgentinaLon');
plot3m(ArgentinaLat,ArgentinaLon,maxval2,'r');
load('UruguayBoundaries.mat','UruguayLat','UruguayLon');
plot3m(UruguayLat,UruguayLon,maxval2,'r');
load('CostaRicaBoundaries.mat','CostaRicaLat','CostaRicaLon');
plot3m(CostaRicaLat,CostaRicaLon,maxval2,'r');
load('FrenchGuianaBoundaries.mat','FrenchGuianaLat','FrenchGuianaLon');
plot3m(FrenchGuianaLat,FrenchGuianaLon,maxval2,'r');
load('GuyanaBoundaries.mat','GuyanaLat','GuyanaLon');
plot3m(GuyanaLat,GuyanaLon,maxval2,'r');
load('SurinameBoundaries.mat','SurinameLat','SurinameLon');
plot3m(SurinameLat,SurinameLon,maxval2,'r');
load('SaudiBoundaries','SaudiLat','SaudiLon');
plot3m(SaudiLat,SaudiLon,maxval2,'r');
load('TurkeyBoundaries','TurkeyLat','TurkeyLon');
plot3m(TurkeyLat,TurkeyLon,maxval2,'r');
load('SyriaBoundaries','SyriaLat','SyriaLon');
plot3m(SyriaLat,SyriaLon,maxval2,'r');
load('LebanonBoundaries','LebanonLat','LebanonLon');
plot3m(LebanonLat,LebanonLon,maxval2,'r');
load('JordanBoundaries','JordanLat','JordanLon');
plot3m(JordanLat,JordanLon,maxval2,'r');
load('IranBoundaries','IranLat','IranLon');
plot3m(IranLat,IranLon,maxval2,'r');
load('IraqBoundaries','IraqLat','IraqLon');
plot3m(IraqLat,IraqLon,maxval2,'r');
load('KuwaitBoundaries','KuwaitLat','KuwaitLon');
plot3m(KuwaitLat,KuwaitLon,maxval2,'r');
load('IsraelBoundaries','IsraelLat','IsraelLon');
plot3m(IsraelLat,IsraelLon,maxval2,'r');
load('AfricaHiResBoundaries','AfricaLat','AfricaLon');
plot3m(AfricaLat,AfricaLon,maxval2,'r');
load('AsiaHiResBoundaries.mat','AsiaLat','AsiaLon');
plot3m(AsiaLat,AsiaLon,maxval2,'r');
load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');
plot3m(EuropeLat,EuropeLon,maxval2,'r');
load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
plot3m(AustraliaLat,AustraliaLon,maxval2,'r');
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
tsliceID=TimeSlices{numtimeslice,1};
txtstr1=strcat('Time Period-',FullTimeStr,'-ikind=',num2str(ikind),'-TimePeriod-',tsliceID);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.07;
ty2=.14;
if((ikind==4) || (ikind==5) || (ikind==6) || (ikind==7) || (ikind==8) || (ikind==9))
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif((ikind==11) || (ikind==12) || (ikind==13) || (ikind==14) || (ikind==15) || (ikind==16))
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif((ikind==17) || (ikind==18) || (ikind==19) || (ikind==20) || (ikind==21))
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
else
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
end
set(newaxesh,'Visible','Off');
% Grab a movie frame
 if((ikind==4) && (iMovie>0) && (MovieFlags(4,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp4,frame);
    disp('Grabbed 1 frame of movie data for ikind =4')
elseif((ikind==5) && (iMovie>0) && (MovieFlags(5,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp5,frame);
    disp('Grabbed 1 frame of movie data for ikind =5')
elseif((ikind==6) && (iMovie>0) && (MovieFlags(6,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp6,frame);
    disp('Grabbed 1 frame of movie data for ikind =6')
elseif((ikind==7) && (iMovie>0) && (MovieFlags(7,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp7,frame);
    disp('Grabbed 1 frame of movie data for ikind =7')
 else

 end
% if(ikind==21)
%     ab=1;
% end
% Save this chart
if((ikind==4) || (ikind==5) || (ikind==6) || (ikind==7) || (ikind==8) || (ikind==9))
    figstr=strcat(varname,'-',FullTimeStr,'-',num2str(numtimeslice),'.jpg');
elseif((ikind==11) || (ikind==12) || (ikind==13) || (ikind==14) || (ikind==15) || (ikind==16))
     figstr=strcat(varname,'-',FullTimeStr,'.jpg');
elseif((ikind==17) || (ikind==18) || (ikind==19) || (ikind==20) || (ikind==21))
     figstr=strcat(varname,'-',FullTimeStr,'.jpg');

end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
pause(chart_time);
endstr=strcat('------- Finished Plotting-',varname);
fprintf(fid,'%s\n',endstr);
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
    if(iNewChapter)
        headingstr1=strcat('Analysis Results For-',Merra2ShortFileName);
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
    parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
    parastr2=strcat(' This metric is a monthly average for-',varname,'.','-at time slice-',tsliceID);
    if((ikind==4) || (ikind==7))
        parastr3='The expected data range for this dataset is from 0 to 20 and is in PSI .';
    elseif((ikind==5) || (ikind==6) || (ikind==19))
        parastr3='The likely data range is from 0 to 1';
    elseif((ikind==8) || (ikind==9)|| (ikind==20) || (ikind==21))
        parastr3='The likely data range is from 200 K to 400 K';
    elseif((ikind==11))
        parastr3='The likely data range is from 0 to 1000 Dobsons';
    elseif((ikind==12) || (ikind==13) || (ikind==14) || (ikind==15))
        parastr3='The likely data range is from 0 to 1 kg-m^2';
    elseif((ikind==16) || (ikind==17) || (ikind==18))
        parastr3='The likely data range is from 0 to 20 Psi';
    elseif((ikind==30) || (ikind==31) || (ikind==32) || (ikind==33))
        parastr3='The likely data range is likely 0-2000 w/m^2';
    elseif((ikind==34) || (ikind==35) || (ikind==36) || (ikind==37))
        parastr3='The likely range of the optical thickness is 0-50 and is dimensionless';
    elseif(ikind==39)
        parastr3='The likely range of the optical thickness is 0-500 and is in Deg-K';
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

