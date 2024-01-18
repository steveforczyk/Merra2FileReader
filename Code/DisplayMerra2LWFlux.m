function  DisplayMerra2LWFlux(ikind,titlestr)
% Display the LWIR Flux
% Written By: Stephen Forczyk
% Created: Aug 10,2022
% Revised: 
% TAUHGHS,TAULOWS,TAUMIDS,TAUTOTS based on value of itype
% Classification: Unclassified

global LonS LatS TimeS ;
global YearMonthDayStr1 YearMonthDayStr2;
global AlbedoS ALBNIRDFS ALBNIRDRS ALBVISDFS ALBVISDRS;
global CLDHGHS CLDLOWS CLDMIDS CLDTOTS;
global EMISS LWGABS LWGABCLRS LWGABCLRCLNS LWTUPS;
global LWGEMS LWGNTS LWGNTCLRS LWGNTCLRCLNS LWTUPCLRS LWTUPCLRCLNS;
global SWGDNS SWGDNCLRS SWGNTS SWGNTCLNS SWGNTCLRS SWGNTCLRCLNS;
global SWTDNS SWTNTS SWTNTCLNS SWTNTCLRS SWTNTCLRCLNS ;
global TAUHGHS TAULOWS TAUMIDS TAUTOTS;
global ChoiceList iSubMean iSubMean1;
global WorldCityFileName World200TopCities;
global iCityPlot maxCities;

global RptGenPresent iCreatePDFReport pdffilename rpt chapter;
global JpegCounter JpegFileList;
global RasterLats RasterLons;
global Merra2FileName;

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

if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*
end
iSubMean1=1;
% Get the year and month of the data from the file name
Yearstr=YearMonthDayStr1(1:4);
Monthstr=YearMonthDayStr1(5:6);
% Create A Raster of Plot Points
LatVals=(LatS.values);
LonVals=LonS.values;
numlats=length(LatVals);
numlons=length(LonVals);
RasterLats=zeros(numlons,numlats);
RasterLons=zeros(numlons,numlats);
minLat=min(LatVals);
maxLat=max(LatVals);
minLon=min(LonVals);
maxLon=max(LonVals);
%% Create Georeference object Rpix
latlim=[-90 90];
lonlim=[-180 180];
rasterSize=[numlats numlons];
Rpix = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','south');
for i=1:numlons
    for j=1:numlats
        RasterLons(i,j)=LonVals(j,1);
    end
end
for i=1:numlons
    for j=1:numlats
        RasterLats(i,j)=LatVals(j,1);
    end
end
fprintf(fid,'%s\n','------- Plot The LWIR Flux ------');
% Select the variable to be used for the plot based on itype
if(ikind==1)
    LWFlux=LWGABS.values;
    desc='Surf Abs LWIR Rad';
    units='W/m^2';
elseif(ikind==2)
    LWFlux=LWGABCLRS.values;
    desc='Surf Abs LWIR Clear Skies';
    units='LWIR W/m^2';
elseif(ikind==3)
    LWFlux=LWGABCLRCLNS.values;
    desc='Surf Abs LWIR Clear Skies No Aerosol';
    units='LWIR W/m^2';
elseif(ikind==4)
    LWFlux=LWGEMS.values;
    desc='LWIR Flux From Surf';
    units='LWIR W/m^2';
elseif(ikind==5)
    LWFlux=LWGNTS.values;
    LWFlux=-LWFlux;
    desc='LWIR Surf DownFlux';
    units='LWIR W/m^2';
elseif(ikind==6)
    LWFlux=LWGNTCLRS.values;
    LWFlux=-LWFlux;
    desc='LWIR Surf DownFlux Clear';
    units='LWIR W/m^2';
elseif(ikind==7)
    LWFlux=LWGNTCLRCLNS.values;
    LWFlux=-LWFlux;
    desc='LWIR Surf DownFlux Clear No Aero';
    units='LWIR W/m^2';
elseif(ikind==8)
    LWFlux=LWTUPS.values;
    desc='LWIR Flux At TOA';
    units='LWIR W/m^2';
elseif(ikind==9)
    LWFlux=LWTUPCLRS.values;
    desc='LWIR Flux At TOA ClearSky';
    units='LWIR W/m^2';
elseif(ikind==10)
    LWFlux=LWTUPCLRCLNS.values;
    desc='LWIR Flux At TOA ClearSky/NoAero';
    units='LWIR W/m^2';
elseif(ikind==11)
    LWFlux=SWGDNS.values;
    desc='SWIR Surface Incoming Flux';
    units='SWIR W/m^2';
elseif(ikind==12)
    LWFlux=SWGDNCLRS.values;
    desc='SWIR Surface Incoming Flux Clear Sky';
    units='SWIR W/m^2';
elseif(ikind==13)
    LWFlux=SWGNTS.values;
    desc='Surface Net Down SWIR Flux';
    units='SWIR W/m^2';
elseif(ikind==14)
    LWFlux=SWGNTCLNS.values;
    desc='Surface Net Down SWIR Flux No Aero';
    units='SWIR W/m^2';
elseif(ikind==15)
    LWFlux=SWGNTCLRCLNS.values;
    desc='Surface Net Down SWIR Flux No Aero Clr Sky';
    units='SWIR W/m^2';
elseif(ikind==16)
    LWFlux=SWTDNS.values;
    desc='SWIR TOA Flux';
    units='SWIR W/m^2';
elseif(ikind==17)
    LWFlux=SWTNTS.values;
    desc='SWIR TOA Net Down Flux';
    units='SWIR W/m^2';
elseif(ikind==18)
    LWFlux=SWTNTCLNS.values;
    desc='SWIR TOA Net Down No Aero Flux';
    units='SWIR W/m^2';
elseif(ikind==19)
    LWFlux=SWTNTCLRS.values;
    desc='SWIR TOA Net Down Clr Sky Flux';
    units='SWIR W/m^2';
elseif(ikind==20)
    LWFlux=SWTNTCLRCLNS.values;
    desc='SWIR TOA Net Down Clr-Sky No-Aero Flux';
    units='SWIR W/m^2';
end
%% Plot the Cloud Optical Thickness  remove bad values
[nrows,ncols]=size(LWFlux);
numpts=nrows*ncols;
LWFluxAdj=LWFlux;
startmean=mean(mean(LWFluxAdj));
% Define a new array where all values less than 0 are set to 0 the
% others are untouched
[ibad,jbad]=find(LWFlux<=0);
numbad=length(ibad);
ilow=0;
if(numbad>0)
    for jj=1:numbad
        indx=ibad(jj,1);
        indy=jbad(jj,1);
        nowval=LWFlux(indx,indy);
        if(nowval<0)
            LWFluxAdj(indx,indy)=0;
            ilow=ilow+1;
        end
    end
end
if(numbad>0)
    fracbad=numbad/numpts;
else
    fracbad=0;
end
startmean=mean(mean(LWFluxAdj));
LWFluxwMean=LWFluxAdj;

isub=0;
if(iSubMean*iSubMean1>0)
    LWFluxAdj=LWFluxAdj-startmean;
    isub=1;
else
    
end
if(isub==1)
    unitstr=strcat(desc,units,'-with mean value-',num2str(startmean,6),'-subtracted');
else
    unitstr=strcat(desc,units,'-with mean value left in data');
end
LWFlux1D=reshape(LWFluxAdj,nrows*ncols,1);
LWFlux1DS=sort(LWFlux1D);
LWFlux1DwMean=reshape(LWFluxwMean,nrows*ncols,1);
LWFlux1DSwMean=sort(LWFlux1DwMean);
num01=floor(.01*numpts);
num25=floor(.25*numpts);
num50=floor(.50*numpts);
num75=floor(.75*numpts);
num99=floor(.99*numpts);
val01=LWFlux1DS(num01,1);
val25=LWFlux1DS(num25,1);
val50=LWFlux1DS(num50,1);
val75=LWFlux1DS(num75,1);
val99=LWFlux1DS(num99,1);
val01wMean=LWFlux1DSwMean(num01,1);
val25wMean=LWFlux1DSwMean(num25,1);
val50wMean=LWFlux1DSwMean(num50,1);
val75wMean=LWFlux1DSwMean(num75,1);
val99wMean=LWFlux1DSwMean(num99,1);
fprintf(fid,'%s\n',' Basic Stats follow for Flux Data with Mean Data');
ptc1str=strcat('01 % Flux w/m2 =',num2str(val01wMean,6));
fprintf(fid,'%s\n',ptc1str);
ptc25str=strcat('25 % Flux w/m2 =',num2str(val25wMean,6));
fprintf(fid,'%s\n',ptc25str);
ptc50str=strcat('50 % Flux w/m2 =',num2str(val50wMean,6));
fprintf(fid,'%s\n',ptc50str);
ptc75str=strcat('75 % Flux w/m2 =',num2str(val75wMean,6));
fprintf(fid,'%s\n',ptc75str);
ptc99str=strcat('99 %Flux w/m2 =',num2str(val99wMean,6));
fprintf(fid,'%s\n',ptc99str);
statsstr=strcat('Fraction of Bad Data Point=',num2str(fracbad,6),'-Array Mean=',num2str(startmean,6));
fprintf(fid,'%s\n',statsstr);
fprintf(fid,'%s\n',' End Stats follow for Flux Data');

if(isub==1)
    minval=val01;
    maxval=val99;
    maxval2=maxval+2;
    incsize=(maxval-minval)/100;
else
    minval=.8*startmean;
    maxval=val99;
    if(maxval<0)
        maxval=abs(maxval);
    end
    maxval2=maxval+2;
    incsize=(maxval-minval)/100;
    ab=1;
end
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
%% Plot the cloud area fraction on the map
geoshow(LWFluxAdj',Rpix,'DisplayType','surface');
%zlimits=[minval maxval];
%demcmap(zlimits);
demcmap('inc',[maxval minval],incsize);
hc=colorbar;
unitstr=strcat(desc,'-',units);
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
load('AfricaHiResBoundaries','AfricaLat','AfricaLon');
plot3m(AfricaLat,AfricaLon,maxval2,'r');
load('AsiaHiResBoundaries.mat','AsiaLat','AsiaLon');
plot3m(AsiaLat,AsiaLon,maxval2,'r');
load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');
plot3m(EuropeLat,EuropeLon,maxval2,'r');
load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
plot3m(AustraliaLat,AustraliaLon,maxval2,'r');
%% Add Cities to the plot is desired
if((iCityPlot>0) && (iSubMean*iSubMean1>0))
    for k=1:maxCities
        nowLat=World200TopCities{1+k,2};
        nowLon=World200TopCities{1+k,3};
        nowName=char(World200TopCities{1+k,1});
        plot3m(nowLat,nowLon,maxval2,'w+');
        textm(nowLat,nowLon+3,maxval2,nowName,'Color','white','FontSize',8);
    end
else
    for k=1:maxCities
        nowLat=World200TopCities{1+k,2};
        nowLon=World200TopCities{1+k,3};
        nowName=char(World200TopCities{1+k,1});
        plot3m(nowLat,nowLon,maxval2,'b+');
        textm(nowLat,nowLon+3,maxval2,nowName,'Color','blue','FontSize',8);
    end
end
ht=title(titlestr);
hold off
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.18;
txtstr1=strcat('Year',Yearstr,'-Month-',Monthstr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.10;
ty2=.14;
txtstr2=strcat('1 ptile =',num2str(val01,6),'//-50 ptile =',num2str(val50,6),...
    '//-99 ptile=',num2str(val99,6),'-',desc,'-',units);
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
tx3=.10;
ty3=.10;
if(isub==1)
    txtstr3=strcat('Flux Data plotted with a mean value of-',num2str(startmean),'-W/m^2 subtracted');
else
    txtstr3='Flux Data plotted with a original data';
end
txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',10,'Color',[1 0 0]);
set(newaxesh,'Visible','Off');
% Save this chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
if((iCreatePDFReport==1) && (RptGenPresent==1))
    [ibreak]=strfind(GOESFileName,'_e');
    is=1;
    ie=ibreak(1)-1;
    GOESShortFileName=GOESFileName(is:ie);
    headingstr1=strcat('ABI Cloud Temps For File-',GOESShortFileName);
    chapter = Chapter("Title",headingstr1);
    add(chapter,Section('Cloud Top Temps'));
    imdata = imread(figstr);
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat('Cloud Top Temps For File-',GOESShortFileName);
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
    parastr5='The Data for this chart was from file-';
    parastr6=strcat(parastr5,GOESFileName);
    p2 = Paragraph(parastr6);
    p2.Style = {OuterMargin("0pt", "0pt","0pt","10pt")};
    add(chapter,p2);
    parastr7=strcat('The Cloud Top dataset has-',num2str(nrows),'-rows and-',num2str(ncols),'-columns of data.');
    parastr8=strcat('The mapping grid used was from file-',GridMatFileName,'.');
    parastr9='Typically,the data available for download is for the Full Disk-not Conus only.';
    parastr10=strcat(parastr7,parastr8,parastr9);
    p3 = Paragraph(parastr10);
    p3.Style = {OuterMargin("0pt", "0pt","0pt","10pt")};
    add(chapter,p3);
    parastr1='High level clouds are cooler than low altitude clouds so stormy areas have cooler cloudtops.';
    parastr2='Clear areas do not return a temperature so these appear shown at blue which is below 200K.';
    parastr3=strcat('In order to improve legibility the areas with temperatures below 200 K have their plot values adjusted to -2 Deg-K.',...
        'This does not affect the calculated statistics but is a display adjustment only.');
    parastr4=strcat(' The reader will note that the image appears to have two circles one inside the other.',...
        'This occurs because the outer circle covers the earth hemisphere while the inner circle shows the regions',...
        ' where the ABI sensor can return valid data.');
    parastr=strcat(parastr1,parastr2,parastr3,parastr4);
    p1 = Paragraph(parastr);
    p1.Style = {OuterMargin("0pt", "0pt","0pt","10pt")};
    add(chapter,p1);
% Work on the Data Quality factors
    dqfflag1=100*DQF2S.percent_good_quality_qf;
    dqfflagstr1=num2str(dqfflag1,6);
    dqfflag2=100*DQF2S.percent_invalid_due_to_not_geolocated_qf;
    dqfflagstr2=num2str(dqfflag2,6);
    dqfflag3=100*DQF2S.percent_invalid_due_to_LZA_threshold_exceeded_qf;
    dqfflagstr3=num2str(dqfflag3,6);
    dqfflag4=100*DQF2S.percent_invalid_due_to_bad_or_missing_brightness_temp_data_qf;
    dqfflagstr4=num2str(dqfflag4,6);
    dqfflag5=100*DQF2S.percent_invalid_due_to_clear_or_probably_clear_sky_qf;
    dqfflagstr5=num2str(dqfflag5,6);
    dqfflag6=100*DQF2S.percent_invalid_due_to_unknown_cloud_type_qf;
    dqfflagstr6=num2str(dqfflag6,6);
    dqfflag7=100*DQF2S.percent_invalid_due_to_nonconvergent_retrieval_qf;
    dqfflagstr7=num2str(dqfflag7,6);
    DQFCauses=zeros(6,1);
    DQFCauses(1,1)=dqfflag2;
    DQFCauses(2,1)=dqfflag3;
    DQFCauses(3,1)=dqfflag4;
    DQFCauses(4,1)=dqfflag5;
    DQFCauses(5,1)=dqfflag6;
    DQFCauses(6,1)=dqfflag7;
    sumcauses=sum(DQFCauses);
    DQFLabels=cell(1,6);
    DQFLabels{1,1}='Invalid not geolocated';
    DQFLabels{1,2}='Invalid to LZA Threshold Exceeded';
    DQFLabels{1,3}='Invalid bad bright temp';
    DQFLabels{1,4}='Invalid due to clear/prob clear sky';
    DQFLabels{1,5}='Invalid due to unknown cloud type';
    DQFLabels{1,6}='Invalid due bad retrieval';
    if(sumcauses>0)
        DQFNormed=DQFCauses*100/sumcauses;
    else
        DQFNormed=DQFCauses;
    end
% Now build a DQF Table of key values
        DQFHdr = {'Item' '% Of Pixels'};
        DQFTable=cell(7,2);
        DQFTable{1,1}='Pct Good Quality Pixel';
        DQFTable{1,2}=dqfflagstr1;
        DQFTable{2,1}='Invalid Geo Location or LZA problem';
        DQFTable{2,2}=dqfflagstr2;
        DQFTable{3,1}='Invalid LZA threshold exceeded';
        DQFTable{3,2}=dqfflagstr3;
        DQFTable{4,1}='Invalid due to bad bright temp';
        DQFTable{4,2}=dqfflagstr4;
        DQFTable{5,1}='Invalid due to clear/prob clear sky';
        DQFTable{5,2}=dqfflagstr5;
        DQFTable{6,1}='Invalid due to unknown cloud type';
        DQFTable{6,2}=dqfflagstr6;
        DQFTable{7,1}='Invalid due bad retrieval';
        DQFTable{7,2}=dqfflagstr7;
% Find which factor causes the most invalid/degraded pixels
        [DQFCausesSort,Index]=sort(DQFCauses,'descend');
        Index3=Index+1;
        biggest_reason_str=DQFTable{Index3(1,1),1};
        is=1;
        ie=length(biggest_reason_str);
        prime_cause_str=biggest_reason_str(is:ie);
        biggest_reason_value=DQFTable{Index3(1,1),2};
        dqfstr1=strcat('The biggest reason for rejected pixels is-',prime_cause_str,'-which results in-',biggest_reason_value,....
            '%-of all reporting pixels reporting invalid values.');
        fprintf(fid,'%s\n',dqfstr1);
        br = PageBreak();
        add(chapter,br);
        T4=[DQFHdr;DQFTable];
        tbl4=Table(T4);
        tbl4.Style = [tbl4.Style {Border('solid','black','3px')}];
        tbl4.HAlign='center';
        tbl4.TableEntriesHAlign = 'center';
        tbl4.ColSep = 'single';
        tbl4.RowSep = 'single';
        r = row(tbl4,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt4 = BaseTable(tbl4);
        tabletitle = Text('DQF Table For Cloud Top Temps');
        tabletitle.Bold = false;
        bt4.Title = tabletitle;
        bt4.TableWidth="7in";
        add(chapter,bt4);
        % Add text for this table
        parastr11=strcat('The DQF table above is intended to inform the user regarding the factors that play into the quality of the data.',...
            'The Cloud Temp metric actually has 6 different data quality factors.');
        parastr12=strcat('In the first row of the table is the per centage of all pixels that returned good data-',dqfflagstr1,'%.');
        parastr13=strcat('Inspection of the data in rows 2 through 7 reveals that the biggest cause for invalid pixels is-',prime_cause_str,'-which caused-',...
              biggest_reason_value,'-% of pixels to return invalid values.','On the next page is a pie chart showing those DQF factors relating to invalid pixels.');
        parastr14='Note that the values in the pie chart are different from those in the preceeding table-this is because the pie chart is looking only at invalid pixels.';
        parastr19=strcat(parastr11,parastr12,parastr13,parastr14);
        p2 = Paragraph(parastr19);
        p2.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
        add(chapter,p2);   
end
pause(chart_time);
fprintf(fid,'%s\n','------- Finished Plotting Flux ------');
close('all');
end

