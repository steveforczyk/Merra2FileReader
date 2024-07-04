function  DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Display the cloud optical thickness for high clouds
% Written By: Stephen Forczyk
% Created: Apr 07,2023
% Revised: Apr 08,2023 made changes to archticture of function to allow
% plots for any 2D Plottable Georeferenced Array 
% Revised: Apr 12,2023 added logo to charts
% Revised: Apr 14,2023 - April 23,2023 added more chart types
% Revised: May  8,2023 - Added Chart ikind 28
% Revised: May 10,2023 - added Chart ikind=31 and 32
% Revised: May 11,2023 added chart ikind=35 and 36
% Revised: May 12,2023 added chart ikind=37
% Revised: Mar 26,2024 added Fast Save Option as screengrab
% Classification: Unclassified
global BandDataS MetaDataS framecounter;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global numlat numlon Rpix latlim lonlim rasterSize;
global StatCompTimes;
global LonS LatS TimeS AlbedoS AlbnirdfS AlbnirdrS AlbvisdfS;
global AlbvisdrS  CLDHGHS CLDLOWS CLDMIDS CLDTOTS;
global EmissS LWGABS LWGABCLRS LWGABCLRCLNS;
global LWGEMS LWGNTS LWGNTCLRS LWGNTCLRCLNS LWTUPS LWTUPCLRS;
global LWTUPCLRCLNS SWGDNS SWGDNCLRS SWGNTS SWGNTCLNS;
global SWGNTCLRS SWGNTCLRCLNS SWTDNS SWTNTS;
global SWTNTCLNS SWTNTCLRS SWTNTCLRCLNS TAUHGHS TAULOWS TAUMIDS TAUTOTS TSS;
global westEdge eastEdge southEdge northEdge FillValue;
global vTemp TempMovieName iMovie;
global vTemp17 TempMovieName17;
global vTemp34 TempmovieName34;
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global idebug iCityPlot World200TopCities maxCities framecounter;
global YearMonthStr YearStr MonthStr DayStr YearMonthDayStr FullTimeStr;

% additional paths needed for mapping
global matpath1 mappath ;
global jpegpath savepath tiffpath;
global fid isavefiles iFastSave;



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

persistent xlogo numcalled;
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
persistent AfricanCities numAfricanCities AfricanCitiesList;
persistent AustralianCities numAustralianCities AustralianCitiesList;
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
end

monthnum=str2double(MonthStr);
[MonthName] = ConvertMonthNumToStr(monthnum);

if(ikind==1)
    PlotArray=AlbedoS.values;
    nanreplacement=0;
    FillValue=AlbedoS.FillValue;
    labelstr='Albedo-dimensionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;
elseif(ikind==2)
    PlotArray=AlbnirdfS.values;
    FillValue=AlbnirdfS.FillValue;
    labelstr='ALBNIRDF-dimensionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

elseif(ikind==3)
    PlotArray=AlbnirdrS.values;
    labelstr='ALBNIRDR-dimensionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

elseif(ikind==4)
    PlotArray=AlbvisdfS.values;
    labelstr='ALBVISDF-dimensionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

elseif(ikind==5)
    PlotArray=AlbvisdrS.values;
    labelstr='ALBVISDR-dimensionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

elseif(ikind==6)
    PlotArray=CLDHGHS.values; 
    labelstr='HighCloudFrac-diemnsionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==7)
    PlotArray=CLDLOWS.values; 
    labelstr='LowCloudFrac-diemnsionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==8)
    PlotArray=CLDMIDS.values; 
    labelstr='MidCloudFrac-diemnsionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

elseif(ikind==9)
    PlotArray=CLDTOTS.values; 
    labelstr='TotalCloudFrac-diemnsionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==10)
    PlotArray=EmissS.values; 
    labelstr='Surface Emissivity-diemnsionless';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==13)
    PlotArray=LWGABS.values; 
    labelstr='Long Wave Surface Absorbed Radiation-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

   elseif(ikind==14)
    PlotArray=LWGABCLRS.values; 
    labelstr='Long Wave Surface Absorbed Rad Clear Sky-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==15)
    PlotArray=LWGABCLRCLNS.values; 
    labelstr='Long Wave Surface Absorbed Rad Clear Sky-No Aerosol-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

   elseif(ikind==16)
        PlotArray=LWGEMS.values; 
        labelstr='Long Wave Flux From Surface-w/m^2';
        [nrows,ncols]=size(PlotArray);
        numtot=nrows*ncols;
        [ihigh,jhigh]=find(PlotArray>1000);
        a1=isempty(ihigh);
        if(a1==1)
            maxval=1000;
            frachigh=0;
        elseif(a1==0)
            numhigh=length(ihigh);
            frachigh=numhigh/(numtot);
            for nk=1:numhigh
                inow=ihigh(nk);
                jnow=jhigh(nk);
                PlotArray(inow,jnow)=NaN;
            end
        end
        FullTimeStr=YearMonthStr;

    elseif(ikind==17)
        PlotArray=LWGNTS.values; 
        labelstr='Surface Net Downward Flux-w/m^2';
        [nrows,ncols]=size(PlotArray);
        numtot=nrows*ncols;
        [ihigh,jhigh]=find(PlotArray>1000);
        a1=isempty(ihigh);
        if(a1==1)
            maxval=1000;
            frachigh=0;
        elseif(a1==0)
            numhigh=length(ihigh);
            frachigh=numhigh/(numtot);
            for nk=1:numhigh
                inow=ihigh(nk);
                jnow=jhigh(nk);
                PlotArray(inow,jnow)=NaN;
            end
        end
        FullTimeStr=YearMonthStr;

    elseif(ikind==18)
        PlotArray=LWGNTCLRS.values; 
        labelstr='Surfavce Net Downward Flux Clear Sky-w/m^2';
        [nrows,ncols]=size(PlotArray);
        numtot=nrows*ncols;
        [ihigh,jhigh]=find(PlotArray>1000);
        a1=isempty(ihigh);
        if(a1==1)
            maxval=1000;
            frachigh=0;
        elseif(a1==0)
            numhigh=length(ihigh);
            frachigh=numhigh/(numtot);
            for nk=1:numhigh
                inow=ihigh(nk);
                jnow=jhigh(nk);
                PlotArray(inow,jnow)=NaN;
            end
        end
        FullTimeStr=YearMonthStr;

    elseif(ikind==19)
        PlotArray=LWGNTCLRCLNS.values; 
        labelstr='Surfavce Net Downward Flux Clear Sky/No Aero-w/m^2';
        [nrows,ncols]=size(PlotArray);
        numtot=nrows*ncols;
        [ihigh,jhigh]=find(PlotArray>1000);
        a1=isempty(ihigh);
        if(a1==1)
            maxval=1000;
            frachigh=0;
        elseif(a1==0)
            numhigh=length(ihigh);
            frachigh=numhigh/(numtot);
            for nk=1:numhigh
                inow=ihigh(nk);
                jnow=jhigh(nk);
                PlotArray(inow,jnow)=NaN;
            end
        end
        FullTimeStr=YearMonthStr;

  elseif(ikind==20)
    PlotArray=LWTUPS.values; 
    labelstr='Upwelling Long Wave Flux-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==21)
    PlotArray=LWTUPCLRS.values; 
    labelstr='Upwelling Long Wave Flux Clear Sky-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==22)
    PlotArray=LWTUPCLRCLNS.values; 
    labelstr='Upwelling Long Wave Flux Clear Sky/No Aero-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==23)
    PlotArray=SWGDNS.values; 
    labelstr='Incoming ShortWave Surface Flux-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=1000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==24)
    PlotArray=SWGDNCLRS.values; 
    labelstr='Incoming ShortWave Surface Flux Cleak Sky-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==25)
    PlotArray=SWGNTS.values; 
    labelstr='ShortWave Surface Downward Flux-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==26)
    PlotArray=SWGNTCLNS.values; 
    labelstr='ShortWave Surface Downward Flux No Aerosol -w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

   elseif(ikind==27)
    PlotArray=SWGNTCLRS.values; 
    labelstr='ShortWave Surface Downward Flux Clear Sky -w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;  

   elseif(ikind==28)
    PlotArray=SWGNTCLRCLNS.values; 
    labelstr='ShortWave Surface Downward Flux Clear Sky/No Aero -w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>1000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;
   
  elseif(ikind==29)
    PlotArray=SWTDNS.values; 
    labelstr='Toa Incoming SW Flux-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>2000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==30)
    PlotArray=SWTNTS.values; 
    labelstr='Toa Net Downward SW Flux-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>2000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==31)
    PlotArray=SWTNTCLNS.values; 
    labelstr='Toa Net Downward SW Flux No-Aero-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>2000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==32)
    PlotArray=SWTNTCLRS.values; 
    labelstr='Toa Net Downward SW Flux Clear Sky-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>2000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==33)
    PlotArray=SWTNTCLRCLNS.values; 
    labelstr='Toa Net Downward SW Flux NoAero Clear Sky-w/m^2';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>2000);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=2000;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==34)
    PlotArray=TAUHGHS.values; 
    labelstr='High Cloud Optical Thickness';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>50);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=50;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==35)
    PlotArray=TAULOWS.values; 
    labelstr='Low Cloud Optical Thickness';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>50);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=50;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==36)
    PlotArray=TAUMIDS.values; 
    labelstr='Mid Cloud Optical Thickness';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>50);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=50;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==37)
    PlotArray=TAUTOTS.values; 
    labelstr='Tot Cloud Optical Thickness';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>50);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=50;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;

  elseif(ikind==39)
    PlotArray=TSS.values; 
    labelstr='Skin Temp-Deg-K';
    [nrows,ncols]=size(PlotArray);
    numtot=nrows*ncols;
    [ihigh,jhigh]=find(PlotArray>500);
    a1=isempty(ihigh);
    if(a1==1)
        maxval=500;
        frachigh=0;
    elseif(a1==0)
        numhigh=length(ihigh);
        frachigh=numhigh/(numtot);
        for nk=1:numhigh
            inow=ihigh(nk);
            jnow=jhigh(nk);
            PlotArray(inow,jnow)=NaN;
        end
    end
    FullTimeStr=YearMonthStr;
end
[nrows,ncols]=size(PlotArray);

%% Set Up titles and units

% Select the variable to be used for the plot based on itype
if(ikind==1)
    desc='Albedo';
    units='dimensionless';
    titlestr=strcat('Albedo For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==2)
    desc='ALBNIRDF';
    units='dimensioness';
    titlestr=strcat('Surface Albedo NearIR Diffuse For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==3)
    desc='ALBNIRDR';
    units='dimensionless';
    titlestr=strcat('Surface Albedo Near IR Beam For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==4)
    desc='ALBVISDF';
    units='Dimensionless';  
    titlestr=strcat('Surface Albedo Visible Difuse For-', Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==5)
    desc='ALBVISDR';
    units='Dimensionless';  
    titlestr=strcat('Surface Albedo Visible Beam For-', Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==6)
    desc='High Cloud Frac';
    units='Dimensionless';  
    titlestr=strcat('High Cloud Frac For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==7)
    desc='Low Cloud Frac';
    units='Dimensionless';  
    titlestr=strcat('Low Cloud Frac For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==8)
    desc='Mid Cloud Frac';
    units='Dimensionless';  
    titlestr=strcat('Mid Cloud Frac For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==9)
    desc='Total Cloud Frac';
    units='Dimensionless';  
    titlestr=strcat('Total Cloud Frac For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==10)
    desc='Surface Emissivity';
    units='Dimensionless';  
    titlestr=strcat('Surface Emissivity For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==13)
    desc='Long Wave Surface Absorption ';
    units='W/m^2';  
    titlestr=strcat('Long Wave Surface Absorption For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==14)
    desc='Long Wave Surface Absorption-Clear Sky ';
    units='W/m^2';  
    titlestr=strcat('Long Wave Surface Absorption Clear Sky For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==15)
    desc='Long Wave Surface Absorption-Clear Sky-No Aerosol ';
    units='W/m^2';  
    titlestr=strcat('Long Wave Surface Absorption Clear Sky No Aerosol For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==16)
    desc=' Long Wave Surface Emission Flux ';
    units='W/m^2';  
    titlestr=strcat('Long Wave Surface Emission Flux For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==17)
    desc=' Long Wave Surface Net Downward Flux ';
    units='W/m^2';  
    titlestr=strcat('Long Wave Net Surface Downward Flux-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==18)
    desc=' Long Wave Surface Net Downward Flux Clear Sky ';
    units='W/m^2';  
    titlestr=strcat('Long Wave Net Surface Downward Clear Sky Flux-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==19)
    desc=' Long Wave Surface Net Downward Flux Clear Sky No Aero ';
    units='W/m^2';  
    titlestr=strcat('Long Wave Net Surface Downward Clear Sky/No Aero Flux-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==20)
    desc='Upwelling Long Wave Flux ';
    units='W/m^2';  
    titlestr=strcat('Upwelling Long Wave Flux At TOA For-',Merra2FileName);
    descstr=strcat('Basic stats monthly follow for-',titlestr);
elseif(ikind==21)
    desc='Upwelling Long Wave Flux Clear Sky';
    units='W/m^2';  
    titlestr=strcat('Upwelling Long Wave Clear Sky Flux At TOA For-',Merra2FileName);
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
if((ikind==1) ||(ikind==6) || (ikind==9) || (ikind==10))
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    [ibad]=isnan(PlotArray1DS);
    numgood=numpts;
    a1=isempty(ibad);
    if((a1==0) && (ikind==1))
        numbad=sum(ibad);
        numgood=numpts-(numbad+1);
    else
        numgood=numpts;
    end
    num01=floor(.01*numgood);
    num25=floor(.25*numgood);
    num50=floor(.50*numgood);
    num75=floor(.75*numgood);
    num99=floor(.99*numgood);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    ptc1str= strcat('01 % Ptile-',desc,'-',num2str(val01,6));
    ptc25str=strcat('25 % Ptile-',desc,'-',num2str(val25,6));
    ptc50str=strcat('50 % Ptile-',desc,'-',num2str(val50,6));
    ptc75str=strcat('75 % Ptile-',desc,'-',num2str(val75,6));
    ptc99str=strcat('99 % Ptile -',desc,'-',num2str(val99,6));
    endstr=strcat('End stats for-',desc);
    if(framecounter<=10)
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',endstr);
    end
    maxval2=1;
    if(ikind==10)
        maxval=1;
        minval=.95;
        incsize=(maxval-minval)/64;
    end
elseif(ikind==2)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    [ibad]=isnan(PlotArray1DS);
    numgood=numpts;
    a1=isempty(ibad);
    if((a1==0) && (ikind==2))
        numbad=sum(ibad);
        numgood=numpts-(numbad+1);
    else
        numgood=numpts;
    end
    num01=floor(.01*numgood);
    num25=floor(.25*numgood);
    num50=floor(.50*numgood);
    num75=floor(.75*numgood);
    num99=floor(.99*numgood);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    ptc1str= strcat('01 % Ptile ALBNIRDF=',num2str(val01,6));
    ptc25str=strcat('25 % Ptile ALBNIRDF=',num2str(val25,6));
    ptc50str=strcat('50 % Ptile ALBNIRDF=',num2str(val50,6));
    ptc75str=strcat('75 % Ptile ALBNIRDF=',num2str(val75,6));
    ptc99str=strcat('99 % Ptile ALBNIRDF=',num2str(val99,6));
   if(framecounter<=10)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for ALBNIRDF');
    end
    frachigh=1;
    maxval=1;
    maxval2=maxval+10; 
elseif(ikind==3)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    [ibad]=isnan(PlotArray1DS);
    numgood=numpts;
    a1=isempty(ibad);
    if((a1==0) && (ikind==3))
        numbad=sum(ibad);
        numgood=numpts-(numbad+1);
    else
        numgood=numpts;
    end
    num01=floor(.01*numgood);
    num25=floor(.25*numgood);
    num50=floor(.50*numgood);
    num75=floor(.75*numgood);
    num99=floor(.99*numgood);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    ptc1str= strcat('01 % Ptile ALBNIRDR=',num2str(val01,6));
    ptc25str=strcat('25 % Ptile ALBNIRDR=',num2str(val25,6));
    ptc50str=strcat('50 % Ptile ALBNIRDR=',num2str(val50,6));
    ptc75str=strcat('75 % Ptile ALBNIRDR=',num2str(val75,6));
    ptc99str=strcat('99 % Ptile ALBNIRDR=',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for ALBNIRDR');
    end
    frachigh=1;
    maxval=1;
    maxval2=maxval+10; 

elseif(ikind==4)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    [ibad]=isnan(PlotArray1DS);
    numgood=numpts;
    a1=isempty(ibad);
    if((a1==0) && (ikind==4))
        numbad=sum(ibad);
        numgood=numpts-(numbad+1);
    else
        numgood=numpts;
    end
    num01=floor(.01*numgood);
    num25=floor(.25*numgood);
    num50=floor(.50*numgood);
    num75=floor(.75*numgood);
    num99=floor(.99*numgood);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    ptc1str= strcat('01 % Ptile ALVISDF=',num2str(val01,6));
    ptc25str=strcat('25 % Ptile ALBVISDF=',num2str(val25,6));
    ptc50str=strcat('50 % Ptile ALBVISDF=',num2str(val50,6));
    ptc75str=strcat('75 % Ptile ALBVISDF=',num2str(val75,6));
    ptc99str=strcat('99 % Ptile ALBVISDF=',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for ALBVISDF');
    end
    frachigh=1;
    maxval=1;
    maxval2=maxval+10; 
 elseif(ikind==5)
    PlotArray1D=reshape(PlotArray,nrows*ncols,1);
    PlotArray1DS=sort(PlotArray1D);
    [ibad]=isnan(PlotArray1DS);
    numgood=numpts;
    a1=isempty(ibad);
    if((a1==0) && (ikind==5))
        numbad=sum(ibad);
        numgood=numpts-(numbad+1);
    else
        numgood=numpts;
    end
    num01=floor(.01*numgood);
    num25=floor(.25*numgood);
    num50=floor(.50*numgood);
    num75=floor(.75*numgood);
    num99=floor(.99*numgood);
    val01=PlotArray1DS(num01,1);
    val25=PlotArray1DS(num25,1);
    val50=PlotArray1DS(num50,1);
    val75=PlotArray1DS(num75,1);
    val99=PlotArray1DS(num99,1);
    ptc1str= strcat('01 % Ptile ALVISDR=',num2str(val01,6));
    ptc25str=strcat('25 % Ptile ALBVISDR=',num2str(val25,6));
    ptc50str=strcat('50 % Ptile ALBVISDR=',num2str(val50,6));
    ptc75str=strcat('75 % Ptile ALBVISDR=',num2str(val75,6));
    ptc99str=strcat('99 % Ptile ALBVISDR=',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for ALBVISDR');
    end
    frachigh=1;
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
    ptc1str= strcat('01 % Ptile CLDHGH=',num2str(val01,6));
    ptc25str=strcat('25 % Ptile CLDHGH=',num2str(val25,6));
    ptc50str=strcat('50 % Ptile CLDHGH=',num2str(val50,6));
    ptc75str=strcat('75 % Ptile CLDHGH=',num2str(val75,6));
    ptc99str=strcat('99 % Ptile CLDHGH=',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for CLDHGH');
    end
    frachigh=1;
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
    ptc1str= strcat('01 % Ptile CLDLOW=',num2str(val01,6));
    ptc25str=strcat('25 % Ptile CLHLOW=',num2str(val25,6));
    ptc50str=strcat('50 % Ptile CLDLOW=',num2str(val50,6));
    ptc75str=strcat('75 % Ptile CLDLOW=',num2str(val75,6));
    ptc99str=strcat('99 % Ptile CLDLOW=',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for CLDLOW');
    end
    frachigh=1;
    maxval=1;
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
    ptc1str= strcat('01 % Ptile CLDMID=',num2str(val01,6));
    ptc25str=strcat('25 % Ptile CLHMID=',num2str(val25,6));
    ptc50str=strcat('50 % Ptile CLDMID=',num2str(val50,6));
    ptc75str=strcat('75 % Ptile CLDMID=',num2str(val75,6));
    ptc99str=strcat('99 % Ptile CLDMID=',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Month Data Average ');
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for CLDMID');
    end
    frachigh=1;
    maxval=1;
    maxval2=maxval+10; 
elseif((ikind==13) || (ikind==16) || (ikind==20) || (ikind==23) || (ikind==25)|| (ikind==29))
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
    ptc1str= strcat('01 % Ptile-',desc,'-',num2str(val01,6));
    ptc25str=strcat('25 % Ptile-',desc,'-',num2str(val25,6));
    ptc50str=strcat('50 % Ptile-',desc,'-',num2str(val50,6));
    ptc75str=strcat('75 % Ptile-',desc,'-',num2str(val75,6));
    ptc99str=strcat('99 % Ptile -',desc,'-',num2str(val99,6));
    endstr=strcat('End stats for-',desc);
    if(framecounter<=10)
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',endstr);
    end
    frachigh=1;
    maxval=1000;
    maxval2=maxval+20; 
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
    ptc1str= strcat('01 % Ptile-',desc,num2str(val01,6));
    ptc25str=strcat('25 % Ptile-',desc,num2str(val25,6));
    ptc50str=strcat('50 % Ptile-',desc,num2str(val50,6));
    ptc75str=strcat('75 % Ptile-',desc,num2str(val75,6));
    ptc99str=strcat('99 % Ptile -',desc,num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    frachigh=1;
    maxval=1000;
    maxval2=maxval+20; 
  elseif((ikind==15) || (ikind==17) || (ikind==18) || (ikind==19))
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
    if(framecounter<=10)
        ptc1str= strcat('01 % Ptile-',desc,num2str(val01,6));
        ptc25str=strcat('25 % Ptile-',desc,num2str(val25,6));
        ptc50str=strcat('50 % Ptile-',desc,num2str(val50,6));
        ptc75str=strcat('75 % Ptile-',desc,num2str(val75,6));
        ptc99str=strcat('99 % Ptile -',desc,num2str(val99,6));
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    
    frachigh=1;
    maxval=1000;
    maxval2=maxval+20; 
  elseif((ikind==20) || (ikind==21) || (ikind==22) || (ikind==24) || (ikind==25) || (ikind==26) || (ikind==27))
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
    ptc1str= strcat('01 % Ptile-',desc,'-',num2str(val01,6));
    ptc25str=strcat('25 % Ptile-',desc,'-',num2str(val25,6));
    ptc50str=strcat('50 % Ptile-',desc,'-',num2str(val50,6));
    ptc75str=strcat('75 % Ptile-',desc,'-',num2str(val75,6));
    ptc99str=strcat('99 % Ptile-',desc,'-',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    frachigh=1;
    maxval=1000;
    maxval2=maxval+20; 
elseif((ikind==28) || (ikind==30) || (ikind==31) || (ikind==32) || (ikind==33))
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
    ptc1str= strcat('01 % Ptile-',desc,'-',num2str(val01,6));
    ptc25str=strcat('25 % Ptile-',desc,'-',num2str(val25,6));
    ptc50str=strcat('50 % Ptile-',desc,'-',num2str(val50,6));
    ptc75str=strcat('75 % Ptile-',desc,'-',num2str(val75,6));
    ptc99str=strcat('99 % Ptile-',desc,'-',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);    
    end 
    frachigh=1;
    maxval=2000;
    maxval2=maxval+20; 
elseif((ikind==34) || (ikind==35) || (ikind==36) || (ikind==37))
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
    ptc1str= strcat('01 % Ptile-',desc,'-',num2str(val01,6));
    ptc25str=strcat('25 % Ptile-',desc,'-',num2str(val25,6));
    ptc50str=strcat('50 % Ptile-',desc,'-',num2str(val50,6));
    ptc75str=strcat('75 % Ptile-',desc,'-',num2str(val75,6));
    ptc99str=strcat('99 % Ptile-',desc,'-',num2str(val99,6));
    if(framecounter<=10)
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    frachigh=1;
    maxval=50;
    maxval2=maxval+20; 

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
    ptc1str= strcat('01 % Ptile-',desc,'-',num2str(val01,6));
    ptc25str=strcat('25 % Ptile-',desc,'-',num2str(val25,6));
    ptc50str=strcat('50 % Ptile-',desc,'-',num2str(val50,6));
    ptc75str=strcat('75 % Ptile-',desc,'-',num2str(val75,6));
    ptc99str=strcat('99 % Ptile -',desc,'-',num2str(val99,6));
    endstr=strcat('End stats for-',desc);
    if(framecounter<=10)
        fprintf(fid,'%s\n',descstr);
        fprintf(fid,'%s\n',ptc1str);
        fprintf(fid,'%s\n',ptc25str);
        fprintf(fid,'%s\n',ptc50str);
        fprintf(fid,'%s\n',ptc75str);
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',endstr);
    end
    frachigh=1;
    maxval=500;
    maxval2=maxval+20; 

end

%% Fetch the map limits

if((framecounter==1) && (ikind==1))
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
%% Plot the Selected parameter on the map on the map
if((ikind==1) || (ikind==2) || (ikind==3) || (ikind==4) || (ikind==5) ||(ikind==6) || (ikind==9) || (ikind==10))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    if(ikind==10)
        demcmap('inc',[maxval minval],incsize);
    end
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif((ikind==7) || (ikind==8) || (ikind==14) || (ikind==15) || (ikind==17))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on

elseif((ikind==13) || (ikind==16) || (ikind==20) || (ikind==23) || (ikind==25) || (ikind==29))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif((ikind==18) || (ikind==19) || (ikind==20) || (ikind==21) || (ikind==22) || (ikind==24))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif((ikind==25) || (ikind==26) || (ikind==27) || (ikind==28) || (ikind==30) || (ikind==31) || (ikind==32))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif( (ikind==33) ||(ikind==34) || (ikind==35) || (ikind==36) || (ikind==37) || (ikind==39))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on

end
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
if((iLogo==1) && (framecounter==1))
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
   [xlogo, ~]=imread(LogoFileName1);
   numcalled=1;
end
if(iLogo==1)
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.08, .1,.04,]);
    imshow(xlogo);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.07;
ty1=.18;
txtstr1=strcat('Time Period-',FullTimeStr,'-ikind=',num2str(ikind));
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.07;
ty2=.14;
if((ikind==1) || (ikind==6) || (ikind==9) || (ikind==10) || (ikind==13) || (ikind==16) || (ikind==20))
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
    tx3=.07;
    ty3=.10;

elseif((ikind==2) || (ikind==3) || (ikind==23) || (ikind==25) || (ikind==29) || (ikind==34))
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);

elseif((ikind==4) || (ikind==5) || (ikind==7) || (ikind==8) || (ikind==14) || (ikind==15) || (ikind==17) ||(ikind==18))
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
else
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);

end
set(newaxesh,'Visible','Off');

% Grab a movie frame
if((ikind==1) && (iMovie>0))
    frame=getframe(gcf);
    writeVideo(vTemp,frame);
%    disp('Grabbed 1 frame of movie data for ikind =1')
% elseif((ikind==17) && (iMovie>0))
%     frame=getframe(gcf);
%     writeVideo(vTemp17,frame);
%     disp('Grabbed 1 frame of movie data for ikind =17')
% elseif((ikind==34) && (iMovie>0))
%     frame=getframe(gcf);
%     writeVideo(vTemp34,frame);
%     disp('Grabbed 1 frame of movie data for ikind =34')
else

end

% Save this chart
if((ikind==1) || (ikind==6) || (ikind==9) || (ikind==10) || (ikind==13) || (ikind==14) || (ikind==15))
    figstr=strcat(varname,'-',FullTimeStr,'.jpg');
elseif((ikind==2) || (ikind==3) || (ikind==4) || (ikind==5) || (ikind==7) || (ikind==8) || (ikind==17))
    figstr=strcat(varname,'-',FullTimeStr,'.jpg');
elseif(ikind==90)
    figstr=strcat(varname,'-Atm-Level-',num2str(ipressind),'-','TimeSlice-',num2str(itime),'-',YearMonthDayStr,'.jpg');
elseif((ikind==16) ||(ikind==20) ||(ikind==23) || (ikind==25) || (ikind==29) || (ikind==34))
    figstr=strcat(varname,'-',FullTimeStr,'.jpg');
else
    figstr=strcat(varname,'-',FullTimeStr,'.jpg');
end
if(iFastSave==0)
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr);
    eval(cmdString);
    close('all');
else
% Try a screencapture
    figstrlen=length(figstr);
    is=1;
    ie=figstrlen-4;
    tiffstub=figstr(is:ie);
    figstr2=strcat(tiffstub,'.tif');
    eval(['cd ' tiffpath(1:length(tiffpath)-1)]);
    screencapture('handle',gcf,'target',figstr2);
end
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
    parastr2=strcat(' This metric is a monthly average for-',varname,'.');
    if(ikind==1)
        parastr3='The valid data range for this dataset is from 0 to 1 and is dimensionless .';
    elseif((ikind==14) || (ikind==15) || (ikind==18) || (ikind==20) || (ikind==21) || (ikind==22) || (ikind==28))
        parastr3='The likely data range is likely 0-2000 w/m^2';
    elseif((ikind==30) || (ikind==31) || (ikind==32) || (ikind==33))
        parastr3='The likely data range is likely 0-2000 w/m^2';
    elseif((ikind==34) || (ikind==35) || (ikind==36) || (ikind==37))
        parastr3='The likely range of the optical thickness is 0-50 and is dimensionless';
    elseif(ikind==39)
        parastr3='The likely range of the optical thickness is 0-500 and is in Deg-K';
    else
        parastr3='unspecified';
    end
%     parastr4='Note that in the plot above a small constant was added to the AOD to insure all values>0 for plot purposes.';
%     parastr5='AOD is a dimensionless parameter that describes the extinction properties of light in the visible band.';
%     parastr6='A very clear atmosphere will have a value of .01,typical values are in the range of .10 and a very hazy atmosphere would be above 0.4.';
%     parastr7=strcat('For the image above the AOD value range was=',num2str(AODmin,6),'-to-',num2str(AODmax,6),'.','The list below shows key requirements for this product.');
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

