function  DisplayMerra2TAUCloud(ikind,titlestr)
% Display the cloud optical thickness for high clouds
% Written By: Stephen Forczyk
% Created: Oct 24,2022
% Revised: Oct 25,2022 added RasterArea variable to get density plot
% Classification: Unclassified

global LonS LatS TimeS ;
global YearMonthDayStr1 YearMonthStr Year Month
global TAUHGHS TAULOWS TAUMIDS TAUTOTS minTauValue;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons;
global ChoiceList iSubMean iSubMean1;

global RptGenPresent iCreatePDFReport pdffilename rpt chapter;
global JpegCounter JpegFileList;
global RasterLats RasterLons;
global Merra2FileName Merra2ShortFileName;
global WorldCityFileName World200TopCities;
global iCityPlot maxCities;

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



iSubMean1=0;

TAUVAL=TAUHGHS.values;
LonVals=LonS.values;
LatVals=LatS.values;
[numlons,numlats]=size(TAUVAL);
%% Create Georeference object Rpix
latlim=[-90 90];
lonlim=[-180 180];
rasterSize=[numlats numlons];
Rpix = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','south');

fprintf(fid,'%s\n','------- Plot The Cloud Optical Thickness For Clouds ------');
minTauStr=strcat('Values with TAU less than-',num2str(minTauValue),'-are set to NaN for plot purposes');
fprintf(fid,'%s\n',minTauStr);
% Select the variable to be used for the plot based on itype
if(ikind==1)
    TAUVAL=TAUHGHS.values;
    desc='TAU High Clouds';
    units='Optical Thickness-Dimensionless';
elseif(ikind==2)
    TAUVAL=TAULOWS.values;
    desc='TAU Low Clouds';
    units='Optical Thickness-Dimensionless';
elseif(ikind==3)
    TAUVAL=TAUMIDS.values;
    desc='TAU Mid Clouds';
    units='Optical Thickness-Dimensionless';
elseif(ikind==4)
    TAUVAL=TAUTOTS.values;
    desc='TAU Tot Clouds';
    units='Optical Thickness-Dimensionless';  
end


%% Plot the Cloud Optical Thickness  remove bad values
[nrows,ncols]=size(TAUVAL);
numpts=nrows*ncols;
TAUVALAdj=TAUVAL;
% Find out how many array elements have NaN values
numNaN=0;
for i=1:nrows
    for j=1:ncols
        TF1=isnan(TAUVAL(i,j));
        if(TF1==1)
            numNaN=numNaN+1;
        end
    end
end
% Define a new array where all values less than 0 are set to 0 the
% others are untouched
[ibad,jbad]=find(TAUVAL<minTauValue);
numbad=length(ibad);
ilow=0;
tauarea=0;
if(numbad>0)
    for jj=1:numbad
        indx=ibad(jj,1);
        indy=jbad(jj,1);
        nowval=TAUVAL(indx,indy);
        if(nowval<minTauValue)
            TAUVALAdj(indx,indy)=NaN;
            ilow=ilow+1;
        end
    end
end
ihigh=numpts-ilow;
fracgood=ihigh/numpts;
startmean=mean(mean(TAUVALAdj));
isub=0;
TauValAdjwMean=TAUVALAdj;
if(iSubMean*iSubMean1>0)
    TAUVALAdj=TAUVALAdj-startmean;
    isub=1;
else

end
% Calculate some stats
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

fprintf(fid,'%s\n',' Basic Stats follow for Cloud Optical Thickness Data with Mean');
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

minval=val01;
minval=minTauValue;
maxval=20;
maxval2=maxval+10;

%incsize=(maxval-minval)/64;

%% Fetch the map limits
westEdge=min(LonVals);
eastEdge=max(LonVals);
southEdge=min(LatVals);
northEdge=max(LatVals);
maplimitstr1='****Map Limits Follow*****';
fprintf(fid,'%s\n',maplimitstr1);
maplimitstr2=strcat('WestEdge=',num2str(westEdge,7),'-EastEdge=',num2str(eastEdge));
fprintf(fid,'%s\n',maplimitstr2);
maplimitstr3=strcat('SouthEdge=',num2str(southEdge,7),'-NorthEdge=',num2str(northEdge));
fprintf(fid,'%s\n',maplimitstr3);
maplimitstr4='****Map Limits End*****';
fprintf(fid,'%s\n',maplimitstr4);
%% Set up the map axis
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
set(gca,'FontWeight','bold');
colormap jet
%% Plot the cloud area fraction on the map
geoshow(TAUVALAdj',Rpix,'DisplayType','surface');
%demcmap('inc',[maxval minval],incsize);
c1=colormap('jet');
cmapland(1:181,:)=c1(1:181,:);
demcmap(TAUVALAdj',181,[],cmapland);
hc=colorbar;
ylabel(hc,units,'FontWeight','bold');
tightmap
hold on
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
txtstr1=strcat('Time Period-',YearMonthStr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.10;
ty2=.14;
txtstr2=strcat('1 ptile Cloud Optical Thickness =',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
    '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over minimum=',num2str(fracgood,6));
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);

set(newaxesh,'Visible','Off');
% Save this chart
figstr=strcat(titlestr,'.jpg');
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

