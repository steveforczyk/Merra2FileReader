function  DisplayMerra2NetDownLWFluxRev2(Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
% Display the downward net  LW flux for dataset 04
% This Rev1 version of the coe was written to split out the cleaning and
% calculation of the statistics of the data from the plotting of same
% This is changed from the Rev1 version to add in
% Written By: Stephen Forczyk
% Created: Feb 04,2024
% Revised: Feb 6,2024 changed limits on Open Water Down Flux
% Revised: Changed Code so stats are only printed to the log file
% on the first frame of data
% Classification: Unclassified

global LonS LatS TimeS iTimeSlice TimeSlices;
global YearMonthDayStr1 YearMonthDayStr2 framecounter;
global LWGNTICES LWGNTWTRS SWGNTICES SWGNTWTRS;
global WorldCityFileName World200TopCities Merra2Cities Merra2WorldCities;
global iCityPlot maxCities;
global iLogo LogoFileName1 LogoFileName2;

global RptGenPresent iCreatePDFReport pdffilename rpt chapter;
global JpegCounter JpegFileList;
global RasterLats RasterLons Rpix;
global Merra2FileName Merra2ShortFileName;
global SubSolarLat SubSolarLon iFastSave;

global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath tiffpath2;
global jpegpath ;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
% additional paths needed for mapping
global gridpath govjpegpath;
global matpath1 mappath;
global canadapath stateshapepath topopath;
global trajpath militarypath;
global figpath screencapturepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;

global westEdge eastEdge northEdge southEdge;
persistent AfricaLat AfricaLon  ArgentinaLat ArgentinaLon AsiaLat AsiaLon;
persistent AustraliaLat AustraliaLon BelizeLat BelizeLon BoliviaLat BoliviaLon;
persistent BrazilLat BrazilLon CanadaLat CanadaLon ChileLat ChileLon;
persistent ColumbiaLat ColumbiaLon CostaRicaLat CostaRicaLon CubaLat CubaLon;
persistent DRLat DRLon EcuadorLat EcuadorLon ElSalvadorLat ElSalvadorLon;
persistent EuropeLat EuropeLon FrenchGuianaLat FrenchGuianaLon;
persistent GautemalaLat GautemalaLon GuyanaLat GuyanaLon HaitiLat HaitiLon;
persistent HondurasLat HondurasLon IranLat IranLon IraqLat IraqLon JamaicaLat JamaicaLon;
persistent JordanLat JordanLon LebanonLat LebanonLon MexicoLat MexicoLon;
persistent NicaraguaLat NicaraguaLon OmanLat OmanLon PanamaLat PanamaLon;
persistent PeruLat PeruLon SaudiLat SaudiLon SurinameLat SurinameLon;
persistent SyriaLat SyriaLon TurkeyLat TurkeyLon USALat USALon UruguayLat  UruguayLon;
persistent VenezuelaLat VenezuelaLon YemenLat YemenLon;
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*
end
Yearstr=YearMonthDayStr1(1:4);
Monthstr=YearMonthDayStr1(5:6);
Daystr=YearMonthDayStr1(7:8);
Hourstr=char(TimeSlices{iTimeSlice,1});


if(ikind==7)
    if(framecounter==1)
        fprintf(fid,'%s\n','------- Start Plotting Sea Ice Net Down Flux  ------');
    end
    vmax=LWGNTICES.vmax;
    vmin=LWGNTICES.vmin;
    minval=-50;
    maxval=500;
    FillVal=LWGNTICES.FillValue;
    desc='Sea Ice Net Downward Flux';
    unitstr='W/m2';
elseif(ikind==8)
    if(framecounter==1)
        fprintf(fid,'%s\n','------- Start Plotting Open Water Net Down Flux  ------');
    end
    vmax=LWGNTWTRS.vmax;
    vmin=LWGNTWTRS.vmin;
    minval=-50;
    maxval=500;
    FillVal=LWGNTWTRS.FillValue;
    desc='Open Water Net Downward Flux';
    unitstr='W/m2';
end

headerstr=strcat('Basic Stats wMeans follow for-',desc,'-Data-ikind-',num2str(ikind));
ptc1str=strcat('01 % LWGNFlux Value=',num2str(Stats(1,3),6));
ptc25str=strcat('25 % LWGNFlux Value=',num2str(Stats(6,3),6));
ptc50str=strcat('50 % LWGNFlux Value=',num2str(Stats(9,3),6));
ptc75str=strcat('75 % LWGNFlux Value=',num2str(Stats(12,3),6));
ptc99str=strcat('99 % LWGNFlux Vallue=',num2str(Stats(17,3),6));
numfracstr=strcat('fracNaN=',num2str(fracNaN,6));
if(framecounter==1)
    fprintf(fid,'%s\n',headerstr);
    fprintf(fid,'%s\n',ptc1str);
    fprintf(fid,'%s\n',ptc25str);
    fprintf(fid,'%s\n',ptc50str);
    fprintf(fid,'%s\n',ptc75str);
    fprintf(fid,'%s\n',ptc99str);
    fprintf(fid,'%s\n',numfracstr);
    fprintf(fid,'%s\n',' End Stats for LGWNFlux Data');
end
zlimits=[minval maxval];
incsize=(maxval-minval)/128;
%% Fetch the map limits
maplimitstr1='****Map Limits Follow*****';
maplimitstr2=strcat('WestEdge=',num2str(westEdge,7),'-EastEdge=',num2str(eastEdge));
maplimitstr3=strcat('SouthEdge=',num2str(southEdge,7),'-NorthEdge=',num2str(northEdge));
maplimitstr4='****Map Limits End*****';
%fprintf(fid,'%s\n',maplimitstr1);
%fprintf(fid,'%s\n',maplimitstr2);
%fprintf(fid,'%s\n',maplimitstr3);
%fprintf(fid,'%s\n',maplimitstr4);
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
%% Plot the surface HFlux on the map
geoshow(LWGNFluxAdj',Rpix,'DisplayType','surface');
demcmap('inc',[maxval minval],incsize);
hc=colorbar;
ylabel(hc,unitstr,'FontWeight','bold');
tightmap
hold on
maxval2=maxval+5;
% load the country borders from a single larger file and plot them
a1=isempty(MexicoLat);
if(a1==1)
% load the country borders and plot them-pull them all from the same file
% if they are not currently in memory
    eval(['cd ' mappath(1:length(mappath)-1)]);
    load('WorldMercatorBoundaries.mat');
end
plot3m(USALat,USALon,maxval2,'r');
plot3m(CanadaLat,CanadaLon,maxval2,'r');
plot3m(MexicoLat,MexicoLon,maxval2,'r');
plot3m(CubaLat,CubaLon,maxval2,'r');
plot3m(DRLat,DRLon,maxval2,'r');
plot3m(HaitiLat,HaitiLon,maxval2,'r');
plot3m(BelizeLat,BelizeLon,maxval2,'r');
plot3m(GautemalaLat,GautemalaLon,maxval2,'r')
plot3m(JamaicaLat,JamaicaLon,maxval2,'r');
plot3m(NicaraguaLat,NicaraguaLon,maxval2,'r')
plot3m(HondurasLat,HondurasLon,maxval2,'r')
plot3m(ElSalvadorLat,ElSalvadorLon,maxval2,'r');
plot3m(PanamaLat,PanamaLon,maxval2,'r');
plot3m(ColumbiaLat,ColumbiaLon,maxval2,'r');
plot3m(VenezuelaLat,VenezuelaLon,maxval2,'r')
plot3m(PeruLat,PeruLon,maxval2,'r');
plot3m(EcuadorLat,EcuadorLon,maxval2,'r');
plot3m(BrazilLat,BrazilLon,maxval2,'r');
plot3m(BoliviaLat,BoliviaLon,maxval2,'r')
plot3m(ChileLat,ChileLon,maxval2,'r');
plot3m(ArgentinaLat,ArgentinaLon,maxval2,'r');
plot3m(UruguayLat,UruguayLon,maxval2,'r');
plot3m(CostaRicaLat,CostaRicaLon,maxval2,'r');
plot3m(FrenchGuianaLat,FrenchGuianaLon,maxval2,'r');
plot3m(GuyanaLat,GuyanaLon,maxval2,'r');
plot3m(SurinameLat,SurinameLon,maxval2,'r');
plot3m(IranLat,IranLon,maxval2,'r');
plot3m(IraqLat,IraqLon,maxval2,'r');
plot3m(TurkeyLat,TurkeyLon,maxval2,'r');
plot3m(SyriaLat,SyriaLon,maxval2,'r');
plot3m(SaudiLat,SaudiLon,maxval2,'r');
plot3m(LebanonLat,LebanonLon,maxval2,'r');
plot3m(OmanLat,OmanLon,maxval2,'r');
plot3m(YemenLat,YemenLon,maxval2,'r');
plot3m(JordanLat,JordanLon,maxval2,'r');
plot3m(AfricaLat,AfricaLon,maxval2,'r');
plot3m(AsiaLat,AsiaLon,maxval2,'r');
plot3m(EuropeLat,EuropeLon,maxval2,'r');
plot3m(AustraliaLat,AustraliaLon,maxval2,'r');


%% Add Cities to the plot is desired
if((iCityPlot>0))
%    load("Merra2CityList.mat");
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
            plot3m(nowLat,nowLon,11,'k+');
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
ty1=.18;
txtstr1=strcat('Year',Yearstr,'-Month-',Monthstr,'-Day-',Daystr,'-Hour-',Hourstr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.10;
ty2=.14;
txtstr2=strcat('1 ptile =',num2str(Stats(1,3),6),'//-50 ptile =',num2str(Stats(9,3),6),...
    '//-99 ptile=',num2str(Stats(17,3),6),'//-',desc);
txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
tx3=.10;
ty3=.10;
txtstr3=strcat('SubSolarLat=',num2str(SubSolarLat,6),'-SubSolarLon=',num2str(SubSolarLon,6));
txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',12);
set(newaxesh,'Visible','Off');
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
if((iCreatePDFReport==1) && (RptGenPresent==1))
    [ibreak]=strfind(GOESFileName,'_e');
    is=1;
    ie=ibreak(1)-1;
    GOESShortFileName=GOESFileName(is:ie);
    headingstr1=strcat('ABI Cloud Temps For File-',GOESShortFileName);
    chapter = Chapter("Title",headingstr1);
    add(chapter,Section('Cloud Top Temps'));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
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
if(framecounter==1)
    fprintf(fid,'%s\n','------- Finished Plotting Net Downwards  Flux------');
end
close('all');
end

