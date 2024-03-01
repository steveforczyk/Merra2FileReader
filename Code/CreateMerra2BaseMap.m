function [outputArg1,outputArg2] = CreateMerra2BaseMap(iProj,icase,GeoTiffFileName)
% The purpose of this routine is to create a geotiff file than can be used
% as a basemap
%
% Created: Feb 24,2024
% Written By: Stephen M Forczyk
% Revised:----
% Classification: Unclassified/Public Domain
global crsS F17_ICECONS timeS xS yS SeaIceConc SeaIceConc1D;
global SeaIceConcValid SeaIceConcValidSort;
global RasterLats RasterLons GridFileName GeoSpatialS Rpix;
global seaicealllats seaiceabove65N;
global val01 val05 val10 val25 val50 val75 val90 val95 val99;
global idebug isavefiles;
global iLogo LogoFileName1 LogoFileName2;
global westEdge eastEdge  northEdge southEdge;
% additional paths needed for mapping
global matpath1 mappath govjpegpath;
global jpegpath fid gridpath;
global NSIDCDataPaths datapath NSIDCFileName;
global iCityPlot framecounter;
global BaseNames BaseLats BaseLons BaseType BasePop BaseCountry;
global sourceURL iFastSave;
global NorthPoleFile NPolePOI Merra2POI maxPOI;
persistent NorthOceanLat NorthOceanLon;


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
global idirector mov izoom iwindow imachine;
global matpath ;
global jpegpath tiffpath2 geotiffpath;
global excelpath;
global savepath antarcticpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
% additional paths needed for mapping
global antarcticpath antarcticshapefile;
global gridpath;
global matpath1 mappath moviepath;
global canadapath stateshapepath topopath;
global militarypath ;
global figpath screencapturepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;
global brightblue sandyellow amber articlime antiquewhite rose alabaster;
global apricot pink begonia blond;
outputArg1 =0;
outputArg2 =0;
geotiffpath='K:\Merra-2\Geotiff_Files\';
antarcticpath='K:\NSDIC\Map_Data\Antarctica\';
savepath='K:\Merra-2\netCDF\Dataset04\Matlab_Files\'; 
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
brightblue=[0 0.5 .8];
imachine=2;
widd=1080;
lend=812;
widd2=1000;
lend2=700;
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);

if(icase==1)
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
        southEdge=-90;
        northEdge=90;
        westEdge=-180;
        eastEdge=180;
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
%         axesm('eqaazim','MapLatLimit',[60 90],'FontSize',10,'FontWeight','bold','plabellocation',10,'mlabellocation',20,...
%             'Grid','on','GColor',[1 0 0],'MLineLocation',20,'PLineLocation',10);
%         gridm on
%         mlabel on
%         plabel on;
%         setm(gca,'MLabelParallel',5);
%         Proj='equazim';
    elseif(iProj==8) % Use this option for South Pole
        axesm('eqaazim','MapLatLimit',[-90 -60],'FontSize',10,'FontWeight','bold','plabellocation',10,'mlabellocation',20,...
            'Grid','on','GColor',[0.0 0 0],'MLineLocation',20,'PLineLocation',10);
        gridm on
        mlabel on
        plabel on;
        setm(gca,'MLabelParallel',5);
        Proj='equazim';
    end
%     set(gcf,'MenuBar','none');
%     set(gcf,'Position',[hor1 vert1 widd lend])
%     setm(gca,'galtitude',1.5)
    maxval2=2;
    minval=-0.05;
    maxval=1.1;
    zlimits=[minval maxval];
    incsize=(maxval-minval)/256;
    % minConc=min(min(SeaIceConc));
    % meanConC=mean(mean(SeaIceConc));
% set(gcf,'MenuBar','none');
% set(gcf,'Position',[hor1 vert1 widd lend])
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
    figure('Position',[hor1 vert1 widd lend]);
    set(gcf,'MenuBar','none');
        axesm('eqaazim','MapLatLimit',[60 90],'FontSize',10,'FontWeight','bold','plabellocation',10,'mlabellocation',20,...
        'Grid','on','GColor',[1 0 0],'MLineLocation',20,'PLineLocation',10);
    gridm on
    mlabel on
    plabel on;
    setm(gca,'MLabelParallel',5);
    Proj='equazim';
    if(a1==1)
        S2=shaperead(OceanFile,'UseGeoCoords',true);
        NorthOceanLat=S2.Lat;
        NorthOceanLon=S2.Lon;
        patchesm(NorthOceanLat,NorthOceanLon,brightblue);
        load('GreenLandBoundariesRed4.mat','GreenLandLat','GreenLandLon')
        patchesm(GreenLandLat,GreenLandLon,alabaster);
        eval(['cd ' mappath(1:length(mappath)-1)]);
        load('USAHiResBoundaries.mat','USALat','USALon');
        patchesm(USALat,USALon,maxval2,begonia)
        try
            load('CanadaBoundariesRed4.mat','CanadaLat','CanadaLon');
        catch
            load('CanadaBoundaries.mat','CanadaLat','CanadaLon');
            ab=2;
        end
        patchesm(CanadaLat,CanadaLon,maxval2,blond);
        load('AsiaLowResBoundaries.mat','AsiaLat','AsiaLon');
        patchesm(AsiaLat,AsiaLon,maxval2,apricot);
        try
            load('EuropeLowResBoundaries.mat','EuropeLat','EuropeLon');
        catch
            load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');
            ab=3;
        end
        patchesm(EuropeLat,EuropeLon,maxval2,pink); 
        eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
        JpegFileName=['Merra2NPBasemap' '.jpg'];
        GeoTiffFileName=['Merra2NPBasemap' '.tif'];
        baseframe=getframe(gca);
        imgdata=baseframe.cdata;
        figstr2=JpegFileName;
        actionstr='print';
        typestr='-djpeg';
        [cmdString]=MyStrcat2(actionstr,typestr,figstr2);
        eval(cmdString);
        dispstr=strcat('Saved Image To File-',figstr2,'-at location-',geotiffpath);
        disp(dispstr)
        RGB=imread(JpegFileName);
        latlim = [southEdge northEdge];
        lonlim = [westEdge eastEdge];
        [RSize1,RSize2,depth]=size(RGB);% Old version
%        [RSize1,RSize2,depth]=size(imgdata);% new version
        rasterSize = [RSize1 RSize2];
        R1 = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
            'RowsStartFrom','west');
        geotiffwrite(GeoTiffFileName, RGB, R1);% old version
%       geotiffwrite(GeoTiffFileName, imgdata, R1);
        ab=1;
    else

  
    end
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
ab=1;
%% This case is for a Mercator Plot
elseif(icase==2)% This case is for a Mercator Plot
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
        southEdge=-90;
        northEdge=90;
        westEdge=-180;
        eastEdge=180;
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
    maxval2=10;
    itype=2;
    if(itype==1)
        axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
            'plabellocation',[-60 -50 -40 -30 -20 -10 0 10 20 30 40 50 60],'mlabellocation',[]);
    elseif(itype==2)
        axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
         'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',20,'mlabellocation',30,...
         'MLabelParallel','south');    
    elseif(itype==3)
        axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
         'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',20,...
         'MLabelParallel','south');
    end
    set(gcf,'MenuBar','none');
    set(gcf,'Position',[hor1 vert1 widd lend])
    
    % load the country borders and plot them
    eval(['cd ' mappath(1:length(mappath)-1)]);
    load('USALowResBoundaries.mat','USALat','USALon');
    plot3m(USALat,USALon,maxval2,'r');
    load('CanadaBoundariesRed4.mat','CanadaLat','CanadaLon');
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
    load('IranBoundaries.mat','IranLat','IranLon');
    plot3m(IranLat,IranLon,maxval2,'r');
    load('IraqBoundaries.mat','IraqLat','IraqLon');
    plot3m(IraqLat,IraqLon,maxval2,'r');
    load('TurkeyBoundaries.mat','TurkeyLat','TurkeyLon');
    plot3m(TurkeyLat,TurkeyLon,maxval2,'r');
    load('SyriaBoundaries.mat','SyriaLat','SyriaLon');
    plot3m(SyriaLat,SyriaLon,maxval2,'r');
    load('SaudiBoundaries.mat','SaudiLat','SaudiLon');
    plot3m(SaudiLat,SaudiLon,maxval2,'r');
    load('LebanonBoundaries.mat','LebanonLat','LebanonLon');
    plot3m(LebanonLat,LebanonLon,maxval2,'r');
    load('OmanBoundaries.mat','OmanLat','OmanLon');
    plot3m(OmanLat,OmanLon,maxval2,'r');
    load('YemenBoundaries.mat','YemenLat','YemenLon');
    plot3m(YemenLat,YemenLon,maxval2,'r');
    load('JordanBoundaries.mat','JordanLat','JordanLon');
    plot3m(JordanLat,JordanLon,maxval2,'r');
    load('AfricaHiResBoundaries','AfricaLat','AfricaLon');
    plot3m(AfricaLat,AfricaLon,maxval2,'r');
    load('AsiaHiResBoundaries.mat','AsiaLat','AsiaLon');
    plot3m(AsiaLat,AsiaLon,maxval2,'r');
    load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');
    plot3m(EuropeLat,EuropeLon,maxval2,'r');
    load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
    plot3m(AustraliaLat,AustraliaLon,maxval2,'r');
% Now write the geo tiff file
    eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
    JpegFileName=['MercatorBaseMap2' '.jpg'];
    GeoTiffFileName=['MercatorBaseMap2' '.tif'];
    baseframe=getframe(gca);
    baseframe.colormap='jet';
    imgdata=baseframe.cdata;
    figstr2=JpegFileName;
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr2);
    eval(cmdString);
    dispstr=strcat('Saved Image To File-',figstr2,'-at location-',geotiffpath);
    disp(dispstr)
    RGB=imread(JpegFileName);
    latlim = [southEdge northEdge];
    lonlim = [westEdge eastEdge];
%    [RSize1,RSize2,depth]=size(RGB);% Old version
    [RSize1,RSize2,depth]=size(imgdata);% new version
    rasterSize = [RSize1 RSize2];
    R1 = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
        'RowsStartFrom','west');
%   geotiffwrite(GeoTiffFileName, RGB, R1);% old version
   geotiffwrite(GeoTiffFileName, imgdata, R1);
   close('all')
% Recreate the image using the basemap
    eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
    %JpegFileName=['ConusHotSpotBasemap' '.jpg'];
    %GeoTiffFileName=['ConusHotSpotBasemap' '.tif'];
    RGB=imread(JpegFileName);
    latlim = [southEdge northEdge];
    lonlim = [westEdge eastEdge];
    [RSize1,RSize2,depth]=size(RGB);
    rasterSize = [RSize1 RSize2];
    R = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
        'RowsStartFrom','west');
    set(gcf,'MenuBar','none');
    set(gcf,'Position',[hor1 vert1 widd lend])
    geoshow(imgdata,R1,'DisplayType','image');
    ab=1;
%% Add Cities to the plot is desired
iCityPlot=1;
if((iCityPlot>0))
    load("Merra2CityList.mat");
    maxCities=height(Merra2WorldCities);
    Merra2Cities= table2cell(Merra2WorldCities);
    ab=1;
    for k=1:maxCities
        nowName=char(Merra2Cities{k,2});
        namelen=length(nowName);
        if(namelen>5)
            nowName=nowName(1:5);
        end
        nowLat=Merra2Cities{k,3};
        nowLon=Merra2Cities{k,4};
        nowRank=Merra2Cities{k,9};
        if(nowRank<2)
            geoscatter(nowLat,nowLon,11,'k+');
            text(nowLat,nowLon+3,11,nowName,'Color','black','FontSize',8);
        end
    end
else
    for k=1:maxCities
        nowName=char(Merra2Cities{k,2});
        nowLat=Merra2Cities{k,3};
        nowLon=Merra2Cities{k,4};
        nowRank=Merra2Cities{k,9};
        if(nowRank<2)
            plot3m(nowLat,nowLon,11,'k+');
            textm(nowLat,nowLon+3,11,nowName,'Color','blue','FontSize',8);
        end
    end
end
elseif(icase==3)
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
        southEdge=-90;
        northEdge=90;
        westEdge=-180;
        eastEdge=180;
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
baseframe=getframe(gca);
imgdata=baseframe.cdata;
baseframe2=getframe();
imgdata2=baseframe2.cdata;
baseframe3=getframe(gcf);
imgdata3=baseframe23.cdata;
eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
JpegFileName='Merra2NPBaseMap.jpg';
GeoTiffFileName='Merra2NPBaseMap.tif';
RGB=imread(JpegFileName);
latlim = [southEdge northEdge];
lonlim = [westEdge eastEdge];
[RSize1,RSize2,depth]=size(RGB);
rasterSize = [RSize1 RSize2];
R = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
    'RowsStartFrom','west');
geoshow(RGB,R,'DisplayType','image');
%geoshow(imgdata,R,'DisplayType','image');
elseif(icase==4)% This case is for a Mercator Plot
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
        southEdge=-90;
        northEdge=90;
        westEdge=-180;
        eastEdge=180;
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
    maxval2=10;
    itype=2;
    if(itype==1)
        axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
            'plabellocation',[-60 -50 -40 -30 -20 -10 0 10 20 30 40 50 60],'mlabellocation',[]);
    elseif(itype==2)
        axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
         'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',20,'mlabellocation',30,...
         'MLabelParallel','south');    
    elseif(itype==3)
        axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
         'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',20,...
         'MLabelParallel','south');
    end
    set(gcf,'MenuBar','none');
    set(gcf,'Position',[hor1 vert1 widd lend])
    
    % load the country borders and plot them
    eval(['cd ' mappath(1:length(mappath)-1)]);
    load('USALowResBoundaries.mat','USALat','USALon');
    plot3m(USALat,USALon,maxval2,'r');
    load('CanadaBoundariesRed4.mat','CanadaLat','CanadaLon');
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
    load('IranBoundaries.mat','IranLat','IranLon');
    plot3m(IranLat,IranLon,maxval2,'r');
    load('IraqBoundaries.mat','IraqLat','IraqLon');
    plot3m(IraqLat,IraqLon,maxval2,'r');
    load('TurkeyBoundaries.mat','TurkeyLat','TurkeyLon');
    plot3m(TurkeyLat,TurkeyLon,maxval2,'r');
    load('SyriaBoundaries.mat','SyriaLat','SyriaLon');
    plot3m(SyriaLat,SyriaLon,maxval2,'r');
    load('SaudiBoundaries.mat','SaudiLat','SaudiLon');
    plot3m(SaudiLat,SaudiLon,maxval2,'r');
    load('LebanonBoundaries.mat','LebanonLat','LebanonLon');
    plot3m(LebanonLat,LebanonLon,maxval2,'r');
    load('OmanBoundaries.mat','OmanLat','OmanLon');
    plot3m(OmanLat,OmanLon,maxval2,'r');
    load('YemenBoundaries.mat','YemenLat','YemenLon');
    plot3m(YemenLat,YemenLon,maxval2,'r');
    load('JordanBoundaries.mat','JordanLat','JordanLon');
    plot3m(JordanLat,JordanLon,maxval2,'r');
    load('AfricaHiResBoundaries','AfricaLat','AfricaLon');
    plot3m(AfricaLat,AfricaLon,maxval2,'r');
    load('AsiaHiResBoundaries.mat','AsiaLat','AsiaLon');
    plot3m(AsiaLat,AsiaLon,maxval2,'r');
    load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');
    plot3m(EuropeLat,EuropeLon,maxval2,'r');
    load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
    plot3m(AustraliaLat,AustraliaLon,maxval2,'r');
%% Add Cities to the plot is desired
iCityPlot=1;
if((iCityPlot>0))
    load("Merra2CityList.mat");
    maxCities=height(Merra2WorldCities);
    Merra2Cities= table2cell(Merra2WorldCities);
    ab=1;
    for k=1:maxCities
        nowName=char(Merra2Cities{k,2});
        namelen=length(nowName);
        if(namelen>5)
            nowName=nowName(1:5);
        end
        nowLat=Merra2Cities{k,3};
        nowLon=Merra2Cities{k,4};
        nowRank=Merra2Cities{k,9};
        if(nowRank<2)
            plotm(nowLat,nowLon,11,'k+');
            textm(nowLat,nowLon+3,11,nowName,'Color','black','FontSize',8);
        end
    end
else
    for k=1:maxCities
        nowName=char(Merra2Cities{k,2});
        nowLat=Merra2Cities{k,3};
        nowLon=Merra2Cities{k,4};
        nowRank=Merra2Cities{k,9};
        if(nowRank<2)
            plot3m(nowLat,nowLon,11,'k+');
            textm(nowLat,nowLon+3,11,nowName,'Color','blue','FontSize',8);
        end
    end
end
% Now write the geo tiff file
    eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
    JpegFileName=['MercatorBaseMap2' '.jpg'];
    GeoTiffFileName=['MercatorBaseMap2' '.tif'];
    baseframe=getframe(gca);
    baseframe.colormap='jet';
    imgdata=baseframe.cdata;
    figstr2=JpegFileName;
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr2);
    eval(cmdString);
    dispstr=strcat('Saved Image To File-',figstr2,'-at location-',geotiffpath);
    disp(dispstr)
    RGB=imread(JpegFileName);
    latlim = [southEdge northEdge];
    lonlim = [westEdge eastEdge];
%    [RSize1,RSize2,depth]=size(RGB);% Old version
    [RSize1,RSize2,depth]=size(imgdata);% new version
    rasterSize = [RSize1 RSize2];
    R1 = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
        'RowsStartFrom','west');
%   geotiffwrite(GeoTiffFileName, RGB, R1);% old version
   geotiffwrite(GeoTiffFileName, imgdata, R1);
   close('all')
% Recreate the image using the basemap
    eval(['cd ' geotiffpath(1:length(geotiffpath)-1)]);
    %JpegFileName=['ConusHotSpotBasemap' '.jpg'];
    %GeoTiffFileName=['ConusHotSpotBasemap' '.tif'];
    RGB=imread(JpegFileName);
    latlim = [southEdge northEdge];
    lonlim = [westEdge eastEdge];
    [RSize1,RSize2,depth]=size(RGB);
    rasterSize = [RSize1 RSize2];
    R = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north',...
        'RowsStartFrom','west');
    set(gcf,'MenuBar','none');
    set(gcf,'Position',[hor1 vert1 widd lend])
    geoshow(imgdata,R1,'DisplayType','image');
    titlestr='TestPlot'
    ht=title(titlestr);
    ab=1;
%% Add Cities to the plot is desired
iCityPlot=1;

end % Loop over cases
end