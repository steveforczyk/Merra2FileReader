function  DisplayMerra2SeaIceFractionPolarRev1(iProj,IceAreaWorld,IceAreaNP,IceAreaSP,titlestr)
% This will plot the Sea Surface ice fraction for the Merra 2 data
% product
% 
% Written By: Stephen Forczyk
% Created: Feb 15,2024
% Revised: Feb 20,2024 added provision to add Antarctic Ocean 
% base locations to map
% Classification: Unclassified

global crsS F17_ICECONS timeS xS yS SeaIceConc SeaIceConc1D;
global SeaIceConcValid SeaIceConcValidSort Merra2ShortFileName;
global RasterLats RasterLons GridFileName GeoSpatialS Rpix;
global seaicealllats seaiceabove65N;
global val01 val05 val10 val25 val50 val75 val90 val95 val99;
global idebug isavefiles framecounter;
global iLogo LogoFileName1 LogoFileName2;
global westEdge eastEdge  northEdge southEdge;
% additional paths needed for mapping
global matpath1 mappath govjpegpath;
global jpegpath fid gridpath geotiffpath;
global NSIDCDataPaths datapath NSIDCFileName;
global iCityPlot framecounter;
global BaseNames BaseLats BaseLons BaseType BasePop BaseCountry;
global sourceURL iFastSave;
global NorthPoleFile NPolePOI Merra2POI maxPOI;


global MonthDayStr MonthDayYearStr;
global YearMonthDayStr1 iTimeSlice TimeSlices;
global WorldCityFileName World200TopCities;
global iCityPlot maxCities Merra2Cities Merra2WorldCities;
global selpath selYear FileList numFiles ShortFileList naveragedframes;
global FinalAvailFiles DateTag;

global iSubMean iSubMean1;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter;
global JpegCounter JpegFileList;
global RasterLats RasterLons;

global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath ;
global jpegpath tiffpath2;
global excelpath;
global savepath antarcticpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
% additional paths needed for mapping
global antarcticpath antarcticshapefile;
global gridpath;
global matpath1 mappath moviepath;
global canadapath stateshapepath topopath;
global militarypath;
global figpath screencapturepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;
global vTemp TempMovieName iMovie;
global vTemp4A vTemp4B TempMovieName4A TempMovieName4B;
persistent S0 SouthPoleLat SouthPoleLon;
persistent S1 SouthOceanLat SouthOceanLon;
persistent S2  NorthOceanLat NorthOceanLon;
persistent USALat USALon CanadaCDTLat CanadaCDTLon;
persistent AsiaLat AsiaLon EuropeLat EuropeLon;
persistent GreenLandLat GreenLandLon;
persistent GreenLandCDTLat GreenLandCDTLon
persistent USACDTLat USACDTLon RussiaCDTLat RussiaCDTLon;
persistent NorwayLat NorwayLon SwedenLat SwedenLon FinlandLat FinlandLon;
persistent IcelandLat IcelandLon;
global brightblue sandyellow amber articlime antiquewhite rose alabaster;
global apricot pink begonia blond;
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*
end
Yearstr=YearMonthDayStr1(1:4);
Monthstr=YearMonthDayStr1(5:6);
Daystr=YearMonthDayStr1(7:8);
Hourstr=char(TimeSlices{iTimeSlice,1});
desc='Sea Ice Frac NP';
if(framecounter==1)
    fprintf(fid,'%s\n','------- Start Sea Ice Coverage Plot ------');
end
sandyellow=[0.823 0.666 .427];
amber=[.792 .412 .141];
articlime=[.815 1.00 .078];
antiquewhite=[.98 .921 .843];
rose=[1.00 .011  .243];
alabaster=[.949 .941 .902];
apricot=[.984 .807 .694];
pink=[1.00 .596  .60];
begonia=[.980 .431 .474];
blond=[.980 .941 .745];
%brighblue=[0 0.5 .8];
%brightblue=[0, 150, 255];
% Get some statistics on the Sea Ice Concentration-for all grid points
[nrows,ncols]=size(SeaIceConc);
numvals=nrows*ncols;
SeaIceConc1D=reshape(SeaIceConc,numvals,1);
SeaIceNaN=isnan(SeaIceConc1D);
numNaN=sum(SeaIceNaN);
[ilow]=find(SeaIceConc1D<0);
a1=isempty(ilow);
if(a1==0)
    numlow=length(ilow);
else
    numlow=0;
end
numgood=numvals-numNaN-numlow;
SeaIceConcValid=zeros(numgood,1);
ngood=0;
for i=1:numvals
    nowval=SeaIceConc1D(i,1);
    a1=isnan(nowval);
    if((nowval>=0) && (nowval<=.99) && (a1==0))
        ngood=ngood+1;
        SeaIceConcValid(ngood,1)=nowval;
    end
end
SeaIceConcValidSort=sort(SeaIceConcValid);
num01=round(.01*numgood);
num05=round(.05*numgood);
num10=round(.10*numgood);
num25=round(.25*numgood);
num50=round(.50*numgood);
num75=round(.75*numgood);
num90=round(.90*numgood);
num95=round(.95*numgood);
num99=round(.99*numgood);
val01=SeaIceConcValidSort(num01,1);
val05=SeaIceConcValidSort(num05,1);
val10=SeaIceConcValidSort(num10,1);
val25=SeaIceConcValidSort(num25,1);
val50=SeaIceConcValidSort(num50,1);
val75=SeaIceConcValidSort(num75,1);
val90=SeaIceConcValidSort(num90,1);
val95=SeaIceConcValidSort(num95,1);
val99=SeaIceConcValidSort(num99,1);
if(framecounter==1)
    fprintf(fid,'%s\n','----- Basic Stats in Sea Ice Coverage Fraction-----');
    fprintf(fid,'%30s\n',' Per Centile    Coverage Fraction');
    fprintf(fid,'%10s %16.4f\n','01',val01);
    fprintf(fid,'%10s %16.4f\n','05',val05);
    fprintf(fid,'%10s %16.4f\n','10',val10);
    fprintf(fid,'%10s %16.4f\n','25',val25);
    fprintf(fid,'%10s %16.4f\n','50',val50);
    fprintf(fid,'%10s %16.4f\n','75',val75);
    fprintf(fid,'%10s %16.4f\n','90',val90);
    fprintf(fid,'%10s %16.4f\n','95',val95);
    fprintf(fid,'%10s %16.4f\n','99',val99);
    fprintf(fid,'%s\n','----- End Stats in Sea Ice Coverage Fraction-----');
end
% Get the area of the valid pixels
pixelarea=25*25; % sq m
seaicealllats=0;
iadd=0;
for i=1:numgood
    nowval=SeaIceConcValid(i,1);
    if((nowval>=0) && (nowval<1))
        iadd=iadd+1;
        nowArea=nowval*pixelarea;
        seaicealllats=seaicealllats+nowArea;
    end
end
% Now calculate the area just for the pixels above 65 N
seaiceabove65N=0;
numabove65N=0;
for i=1:nrows
    for j=1:ncols
        nowLat=RasterLats(i,j);
        nowval=SeaIceConc(i,j);
        if((nowval>=0) && (nowval<=1.0))
            if(nowLat>=65)
                numabove65N=numabove65N+1;
                seaiceabove65N=seaiceabove65N+nowval*pixelarea;
            end
        end
    end
end
if(framecounter==1)
    fprintf(fid,'%s  %16.1f   %s\n','Sea Ice Coverage All Areas------',seaicealllats,'-In Sq Km');
    fprintf(fid,'%s  %16.1f   %s\n','Sea Ice Coverage All Above 65 N-',seaiceabove65N,'-In Sq Km');
    fprintf(fid,'%s  %8d\n','Total Number of Pixels in DataSet-',numvals);
    fprintf(fid,'%s  %8d\n','Number of NaN values in Dataset---',numNaN);
    fprintf(fid,'%s  %8d\n','Number of low values in Dataset---',numlow);
    fprintf(fid,'%s  %8d\n','Number of valid values in Dataset-',numgood);
end
% Now replace the zero values in the SeaIce Conc near zero to just below
% zero for plot purposes
[nrows,ncols]=size(SeaIceConc);
numAdjVals=0;
for i=1:nrows
    for j=1:ncols
        nowVal=SeaIceConc(i,j);
        if(nowVal<.02)
           SeaIceConc(i,j)=NaN;
           numAdjVals=numAdjVals+1;
        end
    end
end
%% Fetch the map limits
westEdge=min(-180);
eastEdge=max(180);
southEdge=min(-90);
northEdge=max(90);
maplimitstr1='****Map Limits Follow*****';
maplimitstr2=strcat('WestEdge=',num2str(westEdge,7),'-EastEdge=',num2str(eastEdge));
maplimitstr3=strcat('SouthEdge=',num2str(southEdge,7),'-NorthEdge=',num2str(northEdge));
maplimitstr4='****Map Limits End*****';
% fprintf(fid,'%s\n',maplimitstr1);
% fprintf(fid,'%s\n',maplimitstr2);
% fprintf(fid,'%s\n',maplimitstr3);
% fprintf(fid,'%s\n',maplimitstr4);
if(iProj==2)
    southEdge=19;
    northEdge=50;
    westEdge=-130;
    eastEdge=-60;
end
if(iProj==3)
    southEdge=-60;
    northEdge=20;
    westEdge=-110;
    eastEdge=-40;
end
if(iProj==4)
    southEdge=5;
    northEdge=40;
    westEdge=60;
    eastEdge=100;
end
if(iProj==5)
    southEdge=20;
    northEdge=70;
    westEdge=-15;
    eastEdge=60;
end
if(iProj==6)
    southEdge=15;
    northEdge=60;
    westEdge=80;
    eastEdge=140;
end
%% Set up the map axis
if(iProj==1)
    axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
        'plabellocation',[-60 -50 -40 -30 -20 -10 0 10 20 30 40 50 60],'mlabellocation',[]);
elseif(iProj==2)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0]','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);    
elseif(iProj==3)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',20,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',20);
elseif(iProj==4)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);
elseif(iProj==5)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);
elseif(iProj==6)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);
elseif(iProj==7) % Use this option for North Pole
    axesm('eqaazim','MapLatLimit',[60 90],'FontSize',10,'FontWeight','bold','plabellocation',10,'mlabellocation',20,...
        'Grid','on','GColor',[1 0 0],'MLineLocation',20,'PLineLocation',10);
    gridm on
    mlabel on
    plabel on;
    setm(gca,'MLabelParallel',5);
    Proj='equazim';
elseif(iProj==8) % Use this option for South Pole
    axesm('eqaazim','MapLatLimit',[-90 -60],'FontSize',10,'FontWeight','bold','plabellocation',10,'mlabellocation',20,...
        'Grid','on','GColor',[0.0 0 0],'MLineLocation',20,'PLineLocation',10);
    gridm on
    mlabel on
    plabel on;
    setm(gca,'MLabelParallel',5);
    Proj='equazim';
end
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
setm(gca,'galtitude',1.5)
maxval2=2;
minval=-0.05;
maxval=1.1;
zlimits=[minval maxval];
incsize=(maxval-minval)/256;
minConc=min(min(SeaIceConc));
meanConC=mean(mean(SeaIceConc));
ab=1;
%% Plot the Sea Ice Concentration
geoshow(SeaIceConc',Rpix,'DisplayType','surface');
demcmap('inc',[maxval minval],incsize);
hc=colorbar;
hc.Label.String='Sea Ice Coverage Fraction';
hc.Label.FontWeight='bold';
set(hc,'FontWeight','bold')
% Save the data if framecounter =1 and iProj=7
if((framecounter==1) && (iProj==7))
    MatFileName='SeaIceConc.mat';
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='Merra2ShortFileName framecounter';
    varstr2=' SeaIceConc Rpix hor1 vert1 widd lend';
    varstr=strcat(varstr1,varstr2);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr);
    ab=1;
end

%% load the country borders and plot them
eval(['cd ' mappath(1:length(mappath)-1)]);
if(iProj<7)
    load('USAHiResBoundaries.mat','USALat','USALon');
    plot3m(USALat,USALon,maxval2,'r');
    load('CanadaBoundaries.mat','CanadaLat','CanadaLon');
    plot3m(CanadaLat,CanadaLon,maxval2,'r');
    load('AsiaHiResBoundaries.mat','AsiaLat','AsiaLon');
    plot3m(AsiaLat,AsiaLon,maxval2,'r');
    load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');
    plot3m(EuropeLat,EuropeLon,maxval2,'r');
    load('AfricaHiResBoundaries.mat','AfricaLat','AfricaLon');
    plot3m(AfricaLat,AfricaLon,maxval2,'r');
    load('SouthAmericaHiResBoundaries.mat','SouthAmericaLat','SouthAmericaLon');
    plot3m(SouthAmericaLat,SouthAmericaLon,maxval2,'r');
    load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
    plot3m(AustraliaLat,AustraliaLon,maxval2,'r');
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
    load('SaudiBoundaries.mat','SaudiLat','SaudiLon');
    plot3m(SaudiLat,SaudiLon,'r');
    load('TurkeyBoundaries.mat','TurkeyLat','TurkeyLon');
    plot3m(TurkeyLat,TurkeyLon,'r');
    load('IranBoundaries.mat','IranLat','IranLon');
    plot3m(IranLat,IranLon,'r');
    load('IraqBoundaries.mat','IraqLat','IraqLon');
    plot3m(IraqLat,IraqLon,'r');
    load('YemenBoundaries.mat','YemenLat','YemenLon');
    plot3m(YemenLat,YemenLon,'r');
    load('OmanBoundaries.mat','OmanLat','OmanLon');
    plot3m(OmanLat,OmanLon,'r');
    load('SyriaBoundaries.mat','SyriaLat','SyriaLon');
    plot3m(SyriaLat,SyriaLon,'r');
    load('LebanonBoundaries.mat','LebanonLat','LebanonLon');
    plot3m(LebanonLat,LebanonLon,'r');
elseif(iProj==7)
    eval(['cd ' antarcticpath(1:length(antarcticpath)-1)]);% antarctica land
    OceanFile='ne_10m_ocean.shp';
    a1=isempty(NorthOceanLat);
    a2=isempty(GreenLandCDTLat);
    if((a1==1) || (a2==1))
        S2=shaperead(OceanFile,'UseGeoCoords',true);
        NorthOceanLat=S2.Lat;
        NorthOceanLon=S2.Lon;
        patchesm(NorthOceanLat,NorthOceanLon,brightblue);
    %    load('GreenLandBoundariesRed4.mat','GreenLandLat','GreenLandLon')
        load('GreenLandCDTBoundaries.mat','GreenLandCDTLat','GreenLandCDTLon')
        patchesm(GreenLandCDTLat,GreenLandCDTLon,alabaster);
        eval(['cd ' mappath(1:length(mappath)-1)]);
       % load('USAHiResBoundaries.mat','USACDTLat','USACDTLon');
        load('USACDTBoundaries.mat','USACDTLat','USACDTLon');
        patchesm(USACDTLat,USACDTLon,maxval2,begonia)
      %  load('CanadaBoundariesRed4.mat','CanadaCDTLat','CanadaCDTLon');
        load('CanadaCDTBoundaries.mat','CanadaCDTLat','CanadaCDTLon');
        patchesm(CanadaCDTLat,CanadaCDTLon,maxval2,blond);
        %load('AsiaLowResBoundaries.mat','AsiaLat','AsiaLon');
        patchesm(AsiaLat,AsiaLon,maxval2,apricot);
        load('RussiaCDTBoundaries.mat','RussiaCDTLat','RussiaCDTLon');
        patchesm(RussiaCDTLat,RussiaCDTLon,maxval2,apricot);
%         load('EuropeLowResBoundaries.mat','EuropeLat','EuropeLon'); 
%         patchesm(EuropeLat,EuropeLon,maxval2,pink);
        load('SwedenBoundariesRed8.mat','SwedenLat','SwedenLon')
        patchesm(SwedenLat,SwedenLon,maxval2,apricot);
        load('FinlandBoundariesRed4.mat','FinlandLat','FinlandLon')
        patchesm(FinlandLat,FinlandLon,maxval2,begonia);
        load('NorwayBoundariesRed.mat','NorwayLat','NorwayLon')
        patchesm(NorwayLat,NorwayLon,maxval2,pink);
        load('IcelandBoundaries.mat','IcelandLat','IcelandLon')
        patchesm(IcelandLat,IcelandLon,maxval2,blond);
        ab=1;
    else
        patchesm(NorthOceanLat,NorthOceanLon,brightblue);
        patchesm(GreenLandCDTLat,GreenLandCDTLon,alabaster);
        patchesm(USACDTLat,USACDTLon,maxval2,begonia)
        patchesm(CanadaCDTLat,CanadaCDTLon,maxval2,blond);
        patchesm(RussiaCDTLat,RussiaCDTLon,maxval2,apricot);
%        patchesm(EuropeLat,EuropeLon,maxval2,pink); 
        patchesm(SwedenLat,SwedenLon,maxval2,apricot);
        patchesm(FinlandLat,FinlandLon,maxval2,begonia);
        patchesm(NorwayLat,NorwayLon,maxval2,pink);
        patchesm(IcelandLat,IcelandLon,maxval2,blond);
    end
    ab=1;
%     if(framecounter==1)
%         eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
%         JpegFileName=['Merra2NPBasemap' '.jpg'];
%         GeoTiffFileName=['Merra2NPBasemap' '.tif'];
%         baseframe=getframe(gca);
%         imgdata=baseframe.cdata;
%         figstr2=JpegFileName;
%         actionstr='print';
%         typestr='-djpeg';
%         [cmdString]=MyStrcat2(actionstr,typestr,figstr2);
%         eval(cmdString);
%         dispstr=strcat('Saved Image To File-',figstr2,'-at location-',geotiffpath);
%         disp(dispstr)
%         RGB=imread(JpegFileName);
%         latlim = [southEdge northEdge];
%         lonlim = [westEdge eastEdge];
%         [RSize1,RSize2,depth]=size(RGB);% Old version
% %        [RSize1,RSize2,depth]=size(imgdata);% new version
%         rasterSize = [RSize1 RSize2];
%         R1 = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
%             'RowsStartFrom','west');
%        geotiffwrite(GeoTiffFileName, RGB, R1);% old version
% %       geotiffwrite(GeoTiffFileName, imgdata, R1);
%     end
elseif(iProj==8)
% This is a large dataset with the result stored as a persistent variable
% only load it once to save time
    a1=isempty(SouthPoleLat);
    if(a1==1)% Not previously loaded so load it now
        eval(['cd ' antarcticpath(1:length(antarcticpath)-1)]);% antarctica land
        S0=shaperead(antarcticshapefile,'UseGeoCoords',true);
        SouthPoleLat=S0.Lat;
        SouthPoleLon=S0.Lon;
        S1=shaperead('iho.shp','UseGeoCoords',true);
        SouthOceanLat=S1.Lat;
        SouthOceanLon=S1.Lon;
    end
%    plot3m(SouthPoleLat,SouthPoleLon,maxval2,'r');
    patchesm(SouthOceanLat,SouthOceanLon,brightblue);
    patchesm(SouthPoleLat,SouthPoleLon,[0.7 0.7 0.7]);
% Added bases as points
    load('AntarcticBases.mat');
    hold on
    sz=50;
    scatterm(BaseLats,BaseLons,sz,'r','filled','diamond');
    for nn=1:12
        nowText=char(BaseNames{nn,1});
        textm(BaseLats(nn,1)+.2,BaseLons(nn,1)-.2,nowText);
    end
    hold off
    ab=1;
end% end loop of projection types


%% Add Points Of Interest to the plot if desired
if(iProj==7)
    maxPOI=height(NPolePOI);
    Merra2POI= table2cell(NPolePOI);
    ab=1;
    for k=1:maxPOI
        nowName=char(Merra2POI{k,1});
        namelen=length(nowName);
        if(namelen>7)
            nowName=nowName(1:7);
        end
        nowLat=Merra2POI{k,3};
        nowLon=Merra2POI{k,4};
        nowRank=Merra2POI{k,6};
        if(nowRank<2)
            plot3m(nowLat,nowLon,11,'r+');
            textm(nowLat,nowLon+3,11,nowName,'Color','blue','FontSize',8);
        end
    end
end
title(titlestr)
hold off
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
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.10;
txtstr1=strcat('Year',Yearstr,'-Month-',Monthstr,'-Day-',Daystr,'-Hour-',Hourstr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
tx2=.10;
ty2=.07;
txtstr2=strcat('1 ptile =',num2str(val01,6),'//-50 ptile =',num2str(val50,6),...
    '//-99 ptile=',num2str(val99,6),'//-',desc);
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
tx3=.10;
ty3=.04;
txtstr3=strcat('World Ice Area-',num2str(IceAreaWorld,4),'-North Pole Ice-',...
   num2str(IceAreaNP,4),'- South Pole Ice-',num2str(IceAreaSP,4),'-sq km' );
txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',10);
set(newaxesh,'Visible','Off');
% Grab a frame for the movie just for the North Pole
% if(iProj==7)
%     frame=getframe(gcf);
%     writeVideo(vTemp4A,frame);
% elseif(iProj==8)
%     frame=getframe(gcf);
%     writeVideo(vTemp4B,frame);
% end
% Save this chart
figstr=strcat(titlestr,'.jpg');
figstr2=strcat(titlestr,'.tiff');
if(iFastSave==0)
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr);
    eval(cmdString);    
else
% Try a screencapture
    eval(['cd ' tiffpath2(1:length(tiffpath2)-1)]);
    screencapture('handle',gcf,'target',figstr2);
end
pause(chart_time)
close('all');
% dispstr=strcat('Saved file-',figstr,'-to folder-',jpegpath);
% disp(dispstr)
if((iCreatePDFReport==1) && (RptGenPresent==1))

end
pause(chart_time);
if(framecounter==1)
    fprintf(fid,'%s\n','------- Finished Sea Ice Coverage Plot ------');
end

end

