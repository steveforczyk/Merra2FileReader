function  DisplayMerra2TAUInCloud1DayAvg(ikind,ipress,itype,varname)
% Display the cloud optical thickness for high clouds-the data used 8 three
% hour segements to create a daily average
% Written By: Stephen Forczyk
% Created: Mar 21,2023
% Revised: -----
% Classification: Unclassified
global BandDataS MetaDataS;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons PressureLevelUsed;
global PressureLevel42 PressureLevel72;
global TauCliSel TauClwSel PossibleTimeValues SP SurfPressure1D;
global Merra2FileName Merra2ShortFileName COThighlimit;
global CloudSel1Day CfcuSel1Day TauCliSel1Day TauClwSel1Day SurfPressure1D;
global CloudSel1Day;
global framecounter;

global idebug iCityPlot;
global LonS LatS LevS timeS;
global timeS CfcuS CloudS DelpS DtrainS InCloudQIS InCloudQLS;
global PsS QiS QlS RhS TauCliS TauClwS SurfacePressure;
global YearMonthStr YearStr MonthStr DayStr YearMonthDayStr FullTimeStr;
global TAUHGHS;
global vTemp TempMovieName;

% additional paths needed for mapping
global matpath1 mappath GOES16path;
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

monthnum=str2double(MonthStr);
[MonthName] = ConvertMonthNumToStr(monthnum);
[n1,n2,n3]=size(TauCliSel1Day);
if(ikind==1)
    TAUVAL=TauCliSel1Day(:,:,ipress); 
    [nrows,ncols]=size(TAUVAL);
elseif(ikind==2)
    [nrows,ncols]=size(SurfPressure1D);
elseif(ikind==3)
    TAUVAL=TauClwSel1Day(:,:,ipress); 
    [nrows,ncols]=size(TAUVAL);
elseif(ikind==4)
    CloudyFrac=CloudSel1Day(:,:,ipress); 
    [nrows,ncols]=size(CloudyFrac);
end
ipressind=PressureLevelUsed{1+ipress,1};
ipresssurval=PressureLevelUsed{1+ipress,4};
altitudekm=PressureLevelUsed{1+ipress,3};
PossibleTimeValues=cell(8,1);
PossibleTimeValues{1,1}='01:30: GMT';
PossibleTimeValues{2,1}='04:30: GMT';
PossibleTimeValues{3,1}='07:30: GMT';
PossibleTimeValues{4,1}='10:30: GMT';
PossibleTimeValues{5,1}='13:30: GMT';
PossibleTimeValues{6,1}='16:30: GMT';
PossibleTimeValues{7,1}='19:30: GMT';
PossibleTimeValues{8,1}='22:30: GMT';
ActualTimeValue='1 Day Average';
FullTimeStr=strcat(MonthName,'-',DayStr,'-',YearStr,':',ActualTimeValue);
LonVals=LonS.values;
LatVals=LatS.values;
if((ikind==1) || (ikind==3))
    [numlons,numlats]=size(TAUVAL);
elseif(ikind==2)
    [numlons,numlats]=size(SurfPressure1D);
elseif(ikind==4)
    [numlons,numlats]=size(CloudyFrac);
end
%% Create Georeference object Rpix
latlim=[-90 90];
lonlim=[-180 180];
rasterSize=[numlats numlons];
Rpix = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','south','RowsStartFrom','west');
minTauValue=0;
fprintf(fid,'%s\n','------- Plot The Cloud Optical Thickness In Cloud ------');
minTauStr=strcat('Values with TAU less than-',num2str(minTauValue),'-are set to NaN for plot purposes');
fprintf(fid,'%s\n',minTauStr);
% Select the variable to be used for the plot based on itype
if(ikind==1)
    desc='TAU In IceCloud ';
    units='In Cloud Optical Thickness-Dimensionless';
    titlestr=strcat('COTIceCloud-1Day-Averaged@-',num2str(ipresssurval),'-bars-',Merra2FileName);
elseif(ikind==2)
    SurfPressure1D=SurfPressure1D/1E5;
    titlestr=strcat('SurfPress-1Day-Averaged-bar-',Merra2FileName);
    desc='Surface Level Atmospheric pressure';
    units='PA';
elseif(ikind==3)
    desc='TAU In Water Cloud';
    units='Optical Thickness-Dimensionless';
    titlestr=strcat('COTWaterCloud-1Day-Averaged@-',num2str(ipresssurval),'-bars-',Merra2FileName);
elseif(ikind==4)
    desc='Cloudy Fraction By Pressure Level';
    units='Cloud Fraction'; 
    titlestr=strcat('CloudyFraction1Day-Averaged@-',num2str(ipresssurval),'-',Merra2FileName);
end


%% Plot the Cloud Optical Thickness 
numpts=nrows*ncols;
% Calculate some stats
if(ikind==1)
    TAUVAL1D=reshape(TAUVAL,nrows*ncols,1);
    TAUVAL1DS=sort(TAUVAL1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=TAUVAL1DS(num01,1);
    val25=TAUVAL1DS(num25,1);
    val50=TAUVAL1DS(num50,1);
    val75=TAUVAL1DS(num75,1);
    val99=TAUVAL1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for Ice Cloud Optical Thickness 1-Day Data ');
    ptc1str= strcat('01 % Ptile Cloud Optical Thickness=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile Cloud Optical Thickness=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile Cloud Optical Thickness=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile Cloud Optical Thickness=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile Cloud Optical Thickness=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for Cloud Optical Thickness Data');
    COTActual=COThighlimit/sqrt(8);
    [ihigh]=find(TAUVAL1DS>COTActual);
    a1=isempty(ihigh);
    if(a1==1)
        numhigh=0;
    else
        numhigh=length(ihigh);
    end
    frachigh=numhigh/numpts;
    maxval=40;
    maxval2=maxval+10;
elseif(ikind==2)
    SP1D=reshape(SurfPressure1D,nrows*ncols,1);
    SP1DS=sort(SP1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=SP1DS(num01,1);
    val25=SP1DS(num25,1);
    val50=SP1DS(num50,1);
    val75=SP1DS(num75,1);
    val99=SP1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow Surface Pressure 1-Day Data ');
    ptc1str= strcat('01 % Ptile Surface Pressure=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile Surface Pressure=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile Surface Pressure=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile Surface Pressure=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Surface Pressure=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for Surface Pressure Data');
    frachigh=1;
    maxval=40;
    maxval2=maxval+10;
elseif(ikind==3)
    TAUVAL1D=reshape(TAUVAL,nrows*ncols,1);
    TAUVAL1DS=sort(TAUVAL1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=TAUVAL1DS(num01,1);
    val25=TAUVAL1DS(num25,1);
    val50=TAUVAL1DS(num50,1);
    val75=TAUVAL1DS(num75,1);
    val99=TAUVAL1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for Water Cloud Optical Thickness 1-Day Data ');
    ptc1str= strcat('01 % Ptile Cloud Optical Thickness=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile Cloud Optical Thickness=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile Cloud Optical Thickness=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile Cloud Optical Thickness=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile Cloud Optical Thickness=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for Cloud Optical Thickness Data');
    COTActual=COThighlimit/sqrt(8);
    [ihigh]=find(TAUVAL1DS>COTActual);
    a1=isempty(ihigh);
    if(a1==1)
        numhigh=0;
    else
        numhigh=length(ihigh);
    end
    frachigh=numhigh/numpts;
    maxval=40;
    maxval2=maxval+10;
elseif(ikind==4)
    CloudyFrac1D=reshape(CloudyFrac,nrows*ncols,1);
    CloudyFrac1DS=sort(CloudyFrac1D);
    num01=floor(.01*numpts);
    num25=floor(.25*numpts);
    num50=floor(.50*numpts);
    num75=floor(.75*numpts);
    num99=floor(.99*numpts);
    val01=CloudyFrac1DS(num01,1);
    val25=CloudyFrac1DS(num25,1);
    val50=CloudyFrac1DS(num50,1);
    val75=CloudyFrac1DS(num75,1);
    val99=CloudyFrac1DS(num99,1);
    fprintf(fid,'%s\n',' Basic Stats follow for Cloud Fraction 1-Day Data ');
    ptc1str= strcat('01 % Ptile Cloudy Frac=',num2str(val01,6));
    fprintf(fid,'%s\n',ptc1str);
    ptc25str=strcat('25 % Ptile Cloudy Frac=',num2str(val25,6));
    fprintf(fid,'%s\n',ptc25str);
    ptc50str=strcat('50 % Ptile Cloudy Frac=',num2str(val50,6));
    fprintf(fid,'%s\n',ptc50str);
    ptc75str=strcat('75 % Ptile Cloudy Frac=',num2str(val75,6));
    fprintf(fid,'%s\n',ptc75str);
    ptc99str=strcat('99 % Ptile Cloudy Frac=',num2str(val99,6));
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',' End Stats follow for Cloudy Frac Data');

    frachigh=1;
    maxval=40;
    maxval2=maxval+10;
end


%% Fetch the map limits
westEdge=min(LonVals);
eastEdge=max(LonVals);
southEdge=min(LatVals);
northEdge=max(LatVals);
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
%itype=2;
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
if((ikind==1) || (ikind==3))
    geoshow(TAUVAL',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = 'Cloud Optical Thickness-Dimensionless';
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif(ikind==2)
    geoshow(SurfacePressure',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = 'Surface Pressure PA';
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif(ikind==4)
    geoshow(CloudyFrac',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = 'Cloudy Frac';
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
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
        textm(nowLat,nowLon+3,11,nowName,'Color','blue','FontSize',8);
    end
end
title(titlestr)
hold off
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.18;
txtstr1=strcat('Time Period-',FullTimeStr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
if(ikind==1)
    tx2=.10;
    ty2=.14;
    txtstr2=strcat('1 ptile IceCloud Optical Thickness =',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over minimum=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
    tx3=.10;
    ty3=.10;
    txtstr3=strcat('Variable-plotted-',varname,'-AtmLevel#-',num2str(ipressind),'-ApproxAlt-',...
        num2str(altitudekm),'-km-');
    txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',12);
elseif(ikind==2)
    tx2=.10;
    ty2=.14;
    txtstr2=strcat('1 ptile Surface Pressure =',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over minimum=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
    tx3=.10;
    ty3=.10;
    txtstr3=strcat('Variable-plotted-',varname,'-At Ground Level');
    txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',12);
elseif(ikind==3)
    tx2=.10;
    ty2=.14;
    txtstr2=strcat('1 ptile WaterCloud Optical Thickness =',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over minimum=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
    tx3=.10;
    ty3=.10;
    txtstr3=strcat('Variable-plotted-',varname,'-AtmLevel#-',num2str(ipressind),'-ApproxAlt-',...
        num2str(altitudekm),'-km-');
    txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',12);
 elseif(ikind==4)
    tx2=.10;
    ty2=.14;
    txtstr2=strcat('1 ptile Cloudy Fraction =',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over minimum=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
    tx3=.10;
    ty3=.10;
    txtstr3=strcat('Variable-plotted-',varname,'-AtmLevel#-',num2str(ipressind),'-ApproxAlt-',...
        num2str(altitudekm),'-km-');
    txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',12);

end
set(newaxesh,'Visible','Off');
% Grab a movie frame
if(ikind==1)
    frame=getframe(gcf);
    writeVideo(vTemp,frame);
    disp('Grabbed 1 frame of movie data')
end
% Save this chart
if((ikind==1) || (ikind==3))
    figstr=strcat(varname,'-Atm-Level-',num2str(ipressind),'-','1DayAvg-',YearMonthDayStr,'.jpg');
elseif(ikind==2)
    figstr=strcat(varname,'-Surface-Level-1DayAvg-',YearMonthDayStr,'.jpg');
elseif(ikind==4)
    figstr=strcat(varname,'-Atm-Level-',num2str(ipressind),'-','1DayAvg-',YearMonthDayStr,'.jpg');
end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
pause(chart_time);
fprintf(fid,'%s\n','------- Finished Plotting Cloud Opacity High Clouds ------');
close('all');
end

