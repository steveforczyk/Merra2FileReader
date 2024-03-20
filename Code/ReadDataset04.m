function ReadDataset04(nowFile,nowpath)
% Modified: This function will read in the the Merra-2 data set called 04
% which is hourly average data
% Written By: Stephen Forczyk
% Created: Aug 4,2022
% Revised: Jan 24-27,2024 started recoding this routine
% Revised: Feb 5,2024 added SWGNTWTRS to decode list-previously omitted
% Revised: Feb 6,2024 started adding data table for whole world
% Revised: Feb 7,2024 added Tables for ikind 2 and 3 data an routine called
% PlotDataset04Table.m to plot the results
% Revised: Feb 8,2024 added additions tables for ikind 5 and 6
% to handle dataset M2T1NXOCN which was different than initially planned
% Revised: Feb 9-10,2024 added more table for ikind 7,11 and 12
% Revised: Feb 11,2024 added calculation of ratster areas to routine
% Revised: Feb 12-13,2014 added tables for ikind 19-23
% Revised: Feb 20,2024 added routine to plot subsolar point
% Revised: Feb 21 thru Mar 2024 set up masks for use in gatherting
% Revised: Mar 1-4 2024 added more countries to list of regional
% temperature calculations
% Temperature Stats
% Classification: Unclassified

global BandDataS MetaDataS;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global YearMonthDayStr1 YearMonthStr datestubstr;

global idebug iScale iReset;
global LonS LatS TimeS iTimeSlice framecounter;
global EFLUXICES EFLUXWTRS FRSEAICES HFLUXICES HFLUXWTRS;
global LWGNTICES LWGNTWTRS SWGNTICES SWGNTWTRS;
global PRECSNOOCNS QV10MS RAINOCNS  integrateRate;
global T10MS TAUXICES TAUXWTRS TAUYICES TAUYWTRS;
global TSKINICES TSKINWTRS U10MS V10MS;
global EFLUXICETable EFLUXICETT SILF01 SILF25 SILF50 SILF75 SILF90 SILF100 SILFNaN;
global EFLUXWTRTable EFLUXWTRTT OWLF01 OWLF25 OWLF50 OWLF75 OWLF90 OWLF100 OWLFNaN;
global SEAICETable SEAICETT SEAF01 SEAF25 SEAF50 SEAF75 SEAF90  SEAF100 SEAFNaN;
global HFLUXICETable HFLUXICETT HFICEF01 HFICEF25 HFICEF50 HFICEF75 HFICEF90 HFICEF100 HFICEFNaN;
global HFLUXWTRTable HFLUXWTRTT HFWTRF01 HFWTRF25 HFWTRF50 HFWTRF75 HFWTRF90 HFWTRF100 HFWTRFNaN;
global LWGNICESTable LWGNICESTT LWGNICE01 LWGNICE25 LWGNICE50 LWGNICE75 LWGNICE90 LWGNICE100 LWGNICENaN;
global LWGNWTRSTable LWGNWTRSTT LWGNWTR01 LWGNWTR25 LWGNWTR50 LWGNWTR75 LWGNWTR90 LWGNWTR100 LWGNWTRNaN;
global TSKINICETable TSKINICETT TSKINICE01 TSKINICE25 TSKINICE50 TSKINICE75 TSKINICE90 TSKINICE100 TSKINICENaN;
global TSKINWTRTable TSKINWTRTT TSKINWTR01 TSKINWTR25 TSKINWTR50 TSKINWTR75 TSKINWTR90 TSKINWTR100 TSKINWTRNaN;
global SWGNTICETable SWGNTICETT SWGNTICE01 SWGNTICE25 SWGNTICE50 SWGNTICE75 SWGNTICE90 SWGNTICE100 SWGNTICENaN;
global SWGNTWTRTable SWGNTWTRTT SWGNTWTR01 SWGNTWTR25 SWGNTWTR50 SWGNTWTR75 SWGNTWTR90 SWGNTWTR100 SWGNTWTRNaN;
global T10MTable T10MTT T10M01 T10M25 T10M50 T10M75 T10M90 T10M100 T10MNaN;
global TAUXICETable TAUXICETT TAUXICE01 TAUXICE25 TAUXICE50 TAUXICE75 TAUXICE90 TAUXICE100 TAUXICENaN;
global TAUXWTRTable TAUXWTRTT TAUXWTR01 TAUXWTR25 TAUXWTR50 TAUXWTR75 TAUXWTR90 TAUXWTR100 TAUXWTRNaN;
global TAUYICETable TAUYICETT TAUYICE01 TAUYICE25 TAUYICE50 TAUYICE75 TAUYICE90 TAUYICE100 TAUYICENaN;
global TAUYWTRTable TAUYWTRTT TAUYWTR01 TAUYWTR25 TAUYWTR50 TAUYWTR75 TAUYWTR90 TAUYWTR100 TAUYWTRNaN;
global RFRateTable RFRateTT RFRate01 RFRate25 RFRate50 RFRate75 RFRate90 RFRate100 RFRateNaN;
global SFRateTable SFRateTT SFRate01 SFRate25 SFRate50 SFRate75 SFRate90 SFRate100 SFRateNaN;
global RasterLats RasterLons Rpix RasterAreas RadiusCalc RasterPtLats RasterLatAreas;
global RFTotalTable RFTotalTT RFTot01 RFTot25 RFTot50 RFTot75 RFTot90 RFTot100 RFTotNaN;
global SFTotalTable SFTotalTT SFTot01 SFTot25 SFTot50 SFTot75 SFTot90 SFTot100 SFTotNaN;
global U10MTable U10MTT U10M01 U10M25 U10M50 U10M75 U10M90 U10M100 U10MNaN;
global V10MTable V10MTT V10M01 V10M25 V10M50 V10M75 V10M90 V10M100 V10MNaN;
global QV10MTable QV10MTT QV10M01 QV10M25 QV10M50 QV10M75 QV10M90 QV10M100 QV10MNaN;
global SeaIceAreaTable SeaIceAreaTT SeaIceAreaKmWorld SeaIceAreaKmNP SeaIceAreaKmSP;
global MaskList Dataset4Masks SelectedMaskIndices AfricaTemps AlgeriaTemps;
global ChadTemps LibyaTemps EgyptTemps AngolaTemps NigeriaTemps;
global KenyaTemps MozambiqueTemps EthiopiaTemps MadagascarTemps SouthAfricaTemps;
global CDRTemps CARTemps NamibiaTemps SomaliaTemps SudanTemps SaudiTemps;
global IranTemps IraqTemps JordanTemps SyriaTemps TurkeyTemps PakistanTemps;
global AfganistanTemps IndiaTemps;
global AfricaTempsTable AfricaTempsTT AlgeriaTempsTable AlgeriaTempsTT;
global ChadTempsTable ChadTempsTT EgyptTempsTable EgyptTempsTT;
global LibyaTempsTable LibyaTempsTT AngolaTempsTable AngolaTempsTT;
global NigeriaTempsTable NigeriaTempsTT KenyaTempsTable KenyaTempsTT;
global MozambiqueTempsTable MozambiqueTempsTT EthiopiaTempsTable EthiopiaTempsTT;
global MadagascarTempsTable MadagascarTempsTT SouthAfricaTempsTable SouthAfricaTempsTT;
global CDRTempsTable CDRTempsTT CARTempsTable CARTempsTT NamibiaTempsTable NamibiaTempsTT;
global SomaliaTempsTable SomaliaTempsTT SudanTempsTable SudanTempsTT SaudiTempsTable SaudiTempsTT;
global IranTempsTable IranTempsTT IraqTempsTable IraqTempsTT JordanTempsTable JordanTempsTT;
global SyriaTempsTable SyriaTempsTT TurkeyTempsTable TurkeyTempsTT PakistanTempsTable PakistanTempsTT;
global AfganistanTempsTable AfganistanTempsTT IndiaTempsTable IndiaTempsTT;
global numSelectedMasks
global SeaIceConc TAirTempC Tau U10 V10 ;
global framecounter numSelectedFiles;
global westEdge eastEdge northEdge southEdge;
global yd md dd StartDateStr;
global YearValue MonthValue DayValue HourValue MinValue SecValue frameDate;
global SubSolarLat SubSolarLon;
global iSkipDisplayFrames;
global iCityPlot maxCities Merra2Cities Merra2WorldCities;

% additional paths needed for mapping
global matpath1 mappath GOES16path;
global jpegpath savepath tablepath;
global maskpath watermaskpath;

global fid isavefiles;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global brightblue;
brightblue=[.0039 .3961 .9882];
fprintf(fid,'\n');
fprintf(fid,'%s\n','******************Start reading dataset 04 data*******************');
nc_filenamesuf=nowFile;
Merra2FileName=RemoveUnderScores(nowFile);
nc_filename=strcat(nowpath,nc_filenamesuf);
ncid=netcdf.open(nc_filename,'nowrite');
openfilestr=strcat('Opening file-',Merra2FileName,'-for reading');
fprintf(fid,'%s\n',openfilestr);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
[iper]=strfind(Merra2ShortFileName,'.');
numper=length(iper);
strlen=length(Merra2ShortFileName);
is=iper(2)+1;
ie=strlen;
currYearMonth=Merra2ShortFileName(is:ie);
YearMonthStr=currYearMonth;
YearStr=YearMonthStr(1:4);
YearValue=str2num(YearStr);
MonthStr1=YearMonthStr(5:6);
MonthValue=str2num(MonthStr1);
monthnum=str2double(MonthStr1);
[MonthName] = ConvertMonthNumToStr(monthnum);
MonthStr=MonthName;
MonthYearStr=strcat(MonthStr,'-',YearStr);
Daystr=YearMonthStr(7:8);
if(framecounter==1)
    StartDateStr=strcat(MonthYearStr,Daystr);
end
DayValue=str2num(Daystr);
datestubstr=YearMonthStr(1:8);
frameDate=datetime(YearValue,MonthValue,DayValue,HourValue,MinValue,SecValue);
ab=1;
LonS=struct('values',[],'long_name',[],'units',[],'vmax',[],'vmin',[],'valid_range',[]);
LatS=LonS;
TimeS=struct('values',[],'long_name',[],'units',[],'time_increment',[],...
    'begin_date',[],'begin_time',[],'vmax',[],'vmin',[],'valid_range',[]);

EFLUXICES=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'scale_factor',[],'add_offset',[],...
    'standard_name',[],'vmax',[],'vmin',[],'valid_range',[]);

EFLUXWTRS=EFLUXICES;
FRSEAICES=EFLUXICES;
HFLUXICES=EFLUXICES;
HFLUXWTRS=EFLUXICES;
LWGNTICES=EFLUXICES;
LWGNTWTRS=EFLUXICES;
PRECSNOOCNS=EFLUXICES;
QV10MS=EFLUXICES;
RAINOCNS=EFLUXICES;
SWGNTICES=EFLUXICES;
T10MS=EFLUXICES;
TAUXICES=EFLUXICES;
TAUXWTRS=EFLUXICES;
TAUYICES=EFLUXICES;
TAUYWTRS=EFLUXICES;
TSKINICES=EFLUXICES;
TSKINWTRS=EFLUXICES;
U10MS=EFLUXICES;
V10MS=EFLUXICES;

% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
if(framecounter==1)
    numvarstr=strcat('The number of variables read from the Cloud Top Data file=',num2str(numvars));
    fprintf(fid,'%s\n',numvarstr);
end
    
if(idebug==1)
    disp(' '),disp(' '),disp(' ')
    disp('________________________________________________________')
    disp('^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~')
    disp(['VARIABLES CONTAINED IN THE netCDF FILE: ' nc_filename ])
    dispstr=strcat('VARIABLES CONTAINED IN THE netCDF FILE:',GOESFileName);
    disp(' ')
    fprintf(fid,'%s\n','________________________________________________________');
    fprintf(fid,'%s\n','^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~');
    fprintf(fid,'%s\n',dispstr);
    variablestr=strcat('Number of variables in file=',num2str(numvars));
    disp(variablestr);
    fprintf(fid,'%s\n',variablestr);
    fprintf(fid,'\n');
end
iPrintAll=0;
if(iPrintAll==1)
    for jj=0:numvars-1
        [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,jj);
        dispstr=strcat(num2str(jj),'-','varname=',num2str(varname),'-numatts=',num2str(numatts));
        disp(dispstr)
        for kk=0:numatts-1
            attname1 = netcdf.inqAttName(ncid,jj,kk);
            attname2 = netcdf.getAtt(ncid,jj,attname1);
            dispstr=strcat(attname1,'-',attname2);
            disp(dispstr)
        end
    end
end
for i = 0:numvars-1
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,i);
    if(idebug==1)
        disp(['--------------------< ' varname ' >---------------------'])
        dispstr=strcat('--------------',varname,'--------------');
        fprintf(fid,'\n');
        fprintf(fid,'%s\n',dispstr);
    end
    flag = 0;
    for j = 0:numatts - 1
       a10=strcmp(varname,'EFLUXICE');
       a20=strcmp(varname,'EFLUXWTR');
       a30=strcmp(varname,'FRSEAICE');
       a40=strcmp(varname,'HFLUXICE');
       a50=strcmp(varname,'HFLUXWTR');
       a60=strcmp(varname,'LWGNTICE');
       a70=strcmp(varname,'LWGNTWTR');
       a80=strcmp(varname,'PRECSNOOCN');
       a90=strcmp(varname,'QV10M');
       a100=strcmp(varname,'RAINOCN');
       a110=strcmp(varname,'SWGNTICE');
       a120=strcmp(varname,'lat');
       a130=strcmp(varname,'lon');
       a140=strcmp(varname,'T10M');
       a150=strcmp(varname,'TAUXICE');
       a160=strcmp(varname,'TAUXWTR');
       a170=strcmp(varname,'TAUYICE');
       a180=strcmp(varname,'TAUYWTR');
       a190=strcmp(varname,'time');
       a200=strcmp(varname,'TSKINICE');
       a210=strcmp(varname,'TSKINWTR');
       a220=strcmp(varname,'U10M');
       a230=strcmp(varname,'V10M');
       a240=strcmp(varname,'SWGNTWTR');
       if (a10==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                EFLUXICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                EFLUXICES.scale_factor=attname2;
                flag = 0;% Not needed becasue the scale factor is 1
            end 

            a1=strcmp(attname1,'long_name');
            if(a1==1)
                EFLUXICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                EFLUXICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                EFLUXICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                EFLUXICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                EFLUXICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                EFLUXICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                EFLUXICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                EFLUXICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                EFLUXICES.fmissing_value=attname2;
            end

        elseif (a20==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                EFLUXWTRS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                EFLUXWTRS.scale_factor=attname2;
                flag = 0;
            end 

            a1=strcmp(attname1,'long_name');
            if(a1==1)
                EFLUXWTRS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                EFLUXWTRS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                EFLUXWTRS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                EFLUXWTRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                EFLUXWTRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                EFLUXWTRS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                EFLUXWTRS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                EFLUXWTRS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                EFLUXWTRS.fmissing_value=attname2;
            end

         elseif (a30==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                FRSEAICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                FRSEAICES.scale_factor=attname2;
                flag = 0;
            end 

            a1=strcmp(attname1,'long_name');
            if(a1==1)
                FRSEAICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                FRSEAICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                FRSEAICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                FRSEAICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                FRSEAICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                FRSEAICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                FRSEAICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                FRSEAICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                FRSEAICES.fmissing_value=attname2;
            end

         elseif (a40==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                HFLUXICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                HFLUXICES.scale_factor=attname2;
                flag = 0;
            end 

            a1=strcmp(attname1,'long_name');
            if(a1==1)
                HFLUXICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                HFLUXICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                HFLUXICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                HFLUXICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                HFLUXICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                HFLUXICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                HFLUXICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                HFLUXICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                HFLUXICES.fmissing_value=attname2;
            end

         elseif (a50==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                HFLUXWTRS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                HFLUXWTRS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                HFLUXWTRS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                HFLUXWTRS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                HFLUXWTRS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                HFLUXWTRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                HFLUXWTRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                HFLUXWTRS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                HFLUXWTRS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                HFLUXWTRS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                HFLUXWTRS.fmissing_value=attname2;
            end

         elseif (a60==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                LWGNTICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                LWGNTICES.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGNTICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                LWGNTICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGNTICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGNTICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGNTICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGNTICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGNTICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGNTICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGNTICES.fmissing_value=attname2;
            end

         elseif (a70==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                LWGNTWTRS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                LWGNTWTRS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGNTWTRS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                LWGNTWTRS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGNTWTRS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGNTWTRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGNTWTRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGNTWTRS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGNTWTRS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGNTWTRS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGNTWTRS.fmissing_value=attname2;
            end

        elseif (a80==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                PRECSNOOCNS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                PRECSNOOCNS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                PRECSNOOCNS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                PRECSNOOCNS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                PRECSNOOCNS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                PRECSNOOCNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                PRECSNOOCNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                PRECSNOOCNS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                PRECSNOOCNS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                PRECSNOOCNS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                PRECSNOOCNS.fmissing_value=attname2;
            end

          elseif (a90==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                QV10MS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                QV10MS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                QV10MS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                QV10MS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                QV10MS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                QV10MS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                QV10MS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                QV10MS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                QV10MS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                QV10MS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                QV10MS.fmissing_value=attname2;
            end

          elseif (a100==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                RAINOCNS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                RAINOCNS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                RAINOCNS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                RAINOCNS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                RAINOCNS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                RAINOCNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                RAINOCNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                RAINOCNS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                RAINOCNS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                RAINOCNS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                RAINOCNS.fmissing_value=attname2;
            end

         elseif (a110==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                SWGNTICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                SWGNTICES.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGNTICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SWGNTICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGNTICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGNTICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGNTICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGNTICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGNTICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGNTICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGNTICES.fmissing_value=attname2;
            end

       elseif (a120==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LatS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LatS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LatS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LatS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LatS.valid_range=attname2;
            end

        elseif (a130==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LonS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LonS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LonS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LonS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LonS.valid_range=attname2;
            end

         elseif (a140==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                T10MS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                T10MS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                T10MS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                T10MS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                T10MS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                T10MS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                T10MS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                T10MS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                T10MS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                T10MS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                T10MS.fmissing_value=attname2;
            end

        elseif (a150==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                TAUXICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TAUXICES.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAUXICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                TAUXICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                TAUXICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAUXICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAUXICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAUXICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAUXICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAUXICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAUXICES.fmissing_value=attname2;
            end

          elseif (a160==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                TAUXWTRS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TAUXWTRS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAUXWTRS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                TAUXWTRS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                TAUXWTRS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAUXWTRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAUXWTRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAUXWTRS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAUXWTRS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAUXWTRS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAUXWTRS.fmissing_value=attname2;
            end

         elseif (a170==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                TAUYICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TAUYICES.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAUYICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                TAUYICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                TAUYICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAUYICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAUYICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAUYICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAUYICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAUYICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAUYICES.fmissing_value=attname2;
            end

          elseif (a180==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                TAUYWTRS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TAUYWTRS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAUYWTRS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                TAUYWTRS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                TAUYWTRS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAUYWTRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAUYWTRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAUYWTRS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAUYWTRS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAUYWTRS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAUYWTRS.fmissing_value=attname2;
            end

         elseif (a190==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            flag=0;

            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TimeS.long_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                TimeS.units=attname2;
            end
            a1=strcmp(attname1,'time_increment');
            if(a1==1)
                TimeS.time_increment=attname2;
            end
            a1=strcmp(attname1,'begin_date');
            if(a1==1)
                TimeS.begin_date=attname2;
            end
            a1=strcmp(attname1,'begin_time');
            if(a1==1)
                TimeS.begin_time=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TimeS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TimeS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TimeS.valid_range=attname2;
            end

         elseif (a200==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                TSKINICES.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TSKINICES.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TSKINICES.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                TSKINICES.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                TSKINICES.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TSKINICES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TSKINICES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TSKINICES.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TSKINICES.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TSKINICES.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TSKINICES.fmissing_value=attname2;
            end

          elseif (a210==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                TSKINWTRS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TSKINWTRS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TSKINWTRS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                TSKINWTRS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                TSKINWTRS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TSKINWTRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TSKINWTRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TSKINWTRS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TSKINWTRS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TSKINWTRS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TSKINWTRS.fmissing_value=attname2;
            end

        elseif (a220==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                U10MS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                U10MS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                U10MS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                U10MS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                U10MS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                U10MS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                U10MS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                U10MS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                U10MS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                U10MS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                U10MS.fmissing_value=attname2;
            end

          elseif (a230==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                V10MS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                V10MS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                V10MS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                V10MS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                V10MS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                V10MS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                V10MS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                V10MS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                V10MS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                V10MS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                V10MS.fmissing_value=attname2;
            end

         elseif (a240==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
                SWGNTWTRS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                SWGNTWTRS.scale_factor=attname2;
                flag = 0;
            end 
            
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGNTWTRS.long_name=attname2;
            end

            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SWGNTWTRS.standard_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGNTWTRS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGNTWTRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGNTWTRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGNTWTRS.valid_range=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGNTWTRS.FillValue=attname2;
            end

            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGNTWTRS.missing_value=attname2;
            end

            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGNTWTRS.fmissing_value=attname2;
            end


       end % End of loop over variables
    end
    if(idebug==1)
        disp(' ')
    end
    
    if flag
        if(varname=='EFLUXICE')
            eval([varname '=( double(double(netcdf.getVar(ncid,i))-0));'])
            CT=EFLUXICE;
           scale2=double(scale);
           offset2=double(offset);
           CTT2=CT*scale2+offset2;
           EFLUXICES.values=CTT2;
           clear CT
        end

    else
        eval([varname '= double(netcdf.getVar(ncid,i));'])   
        if(a10==1)
            EFLUXICES.values=EFLUXICE;
        end

        if(a20==1)
            EFLUXWTRS.values=EFLUXWTR;
        end

        if(a30==1)
            FRSEAICES.values=FRSEAICE;
        end

        if(a40==1)
            HFLUXICES.values=HFLUXICE;
        end

        if(a50==1)
            HFLUXWTRS.values=HFLUXWTR;

        end
        if(a60==1)
             LWGNTICES.values=LWGNTICE;
        end

        if(a70==1)
            LWGNTWTRS.values=LWGNTWTR;
        end
        if(a80==1)
            PRECSNOOCNS.values=PRECSNOOCN;
        end
        if(a90==1)
            QV10MS.values=QV10M;
        end
         if(a100==1)
             RAINOCNS.values=RAINOCN;
         end

        if(a110==1)
            SWGNTICES.values=SWGNTICE;
        end
        if(a120==1)
            LatS.values=lat;
        end
        if(a130==1)
            LonS.values=lon;
        end
        if(a140==1)
            T10MS.values=T10M;
            ab=1;
        end
        if(a150==1)
            TAUXICES.values=TAUXICE;
        end
        if(a160==1)
            TAUXWTRS.values=TAUXWTR;
        end
        if(a170==1)
            TAUYICES.values=TAUYICE;
        end
        if(a180==1)
            TAUYWTRS.values=TAUYWTR;
        end
        if(a190==1)
            TimeS.values=time;
        end
        if(a200==1)
            TSKINICES.values=TSKINICE;
        end
        if(a210==1)
            TSKINWTRS.values=TSKINWTR;
        end
        if(a220==1)
            U10MS.values=U10M;
        end
        if(a230==1)
            V10MS.values=V10M;
        end
        if(a240==1)
            SWGNTWTRS.values=SWGNTWTR;
        end

    end
end

if(idebug==1)
    disp('^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~')
    disp('________________________________________________________')
    disp(' '),disp(' ')
end
netcdf.close(ncid);
fprintf(fid,'%s\n','Finished reading netCDF data file');
%Now write a Matlab file containing the decoded data
%use the original file name with a .mat extension
ab=1;
MatFileName=strcat(Merra2ShortFileName,'.mat');
if(isavefiles==1)
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='LonS LatS TimeS Merra2FileName Merra2ShortFileName';
    varstr2=' AlbedoS ALBNIRDFS ALBNIRDRS ALBVISDFS ALBVISDRS';
    varstr3=' CLDHGHS CLDLOWS CLDMIDS CLDTOTS';
    varstr4=' VarCLDHGHS VarCLDLOWS VarCLDMIDS VarCLDTOTS VarEMISS';
    varstr5=' EMISS LWGABS LWGABCLRS LWGABCLRCLNS LWTUPS';
    varstr6=' LWGEMS LWGNTS LWGNTCLRS LWGNTCLRCLNS LWTUPCLRS LWTUPCLRCLNS';
    varstr7=' SWGDNS SWGDNCLRS SWGNTS SWGNTCLNS SWGNTCLRS SWGNTCLRCLNS';
    varstr8=' SWTDNS SWTNTS SWTNTCLNS SWTNTCLRS SWTNTCLRCLNS';
    varstr9=' TAUHGHS TAULOWS TAUMIDS TAUTOTS TSS';
    varstr10=' VarALBEDOS VarALBNIRDFS VarALBNIRDRS VarALBVISDFS VarALBVISDRS';
    varstr=strcat(varstr1,varstr2,varstr3,varstr4,varstr5);
    varstr=strcat(varstr,varstr6,varstr7,varstr8,varstr9,varstr10);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr);
    savestr=strcat('Saved Decoded Data to File=',MatFileName);
    fprintf(fid,'%s\n',savestr);
    disp(savestr)
elseif((isavefiles~=1) && (framecounter<2))
    dispstr=strcat('Did Not save Decoded Data to File-',MatFileName);
    disp(dispstr);
    fprintf(fid,'%s\n',dispstr);
end
%% Make the Raster Grid that will be used for Geo2D plots
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
westEdge=min(LonVals);
eastEdge=max(LonVals);
southEdge=min(LatVals);
northEdge=max(LatVals);

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
%% Now calculate the subsolar point
maxSolarElv=-180;
maxi=1;
maxj=1;
GLats=-25:.5:25;
GLats=GLats';
GLons=-180:.625:179.4;
GLons=GLons';
numlatsex=length(GLats);
for i=1:numlatsex
    for j=1:576
        nowLat=GLats(i,1);
        nowLon=GLons(j,1);
        [~,solarEl] = sun_angle(frameDate,nowLat,nowLon,0);
        if(solarEl>maxSolarElv)
            maxi=i;
            maxj=j;
            SubSolarLat=nowLat;
            SubSolarLon=nowLon;
            maxSolarElv=solarEl;
            ab=1;
        end
    end
end
fprintf(fid,'\n');
fprintf(fid,'%s\n','------- Sub Solar Point------');
subsolarstr=strcat('SubSolarLat-',num2str(SubSolarLat,4),'-SubSolarLon-',num2str(SubSolarLon,4));
fprintf(fid,'%s\n',subsolarstr);
fprintf(fid,'%s\n','------- End Sub Solar Point Calculation------');
fprintf(fid,'\n');
%% Now calculate the area of each Raster point. This on varies by latitude
% Get the area of each cell based on the latitude-this is hardwired for the
% Merra 2 grid which is 576 x 361 (nlons,nlats)
nlats=361;
nlons=576;
RadiusCalc=zeros(nlats,1);
LatSpacing=0.5;
LonSpacing=0.625;
RasterPtLats=-90:LatSpacing:90;
RasterPtLats=RasterPtLats';
lon1=10;
lon2=lon1+LonSpacing;
deg2rad=pi/180;
areakmlast=0;
RasterLatAreas=16*ones(nlats,1);
for k=1:nlats-1
    lat1=RasterPtLats(k,1);
    lat2=RasterPtLats(k,1)+LatSpacing;
    [arclen1,~]=distance(lat1,lon1,lat2,lon1);
    radius = geocradius(lat1);
    distlat=radius*arclen1*deg2rad;
    [arclen2,~]=distance(lat1,lon1,lat1,lon2);
    distlon=radius*arclen2*deg2rad;
    areakm=distlat*distlon/1E6;
    if(areakm<1)
        areaused=16;
    else
        areaused=areakm;
    end
    RasterAreas(k,1)=areaused;
    RasterLatAreas(k,1)=areaused;
    RadiusCalc(k,1)=radius;
end


if(framecounter==1)
    yd=str2double(YearMonthStr(1:4));
    md=str2double(YearMonthStr(5:6));
    dd=str2double(YearMonthStr(7:8));
end

%% Initialize statistics holding arrays
if(framecounter==1)
% Initialize Statistic Hold Arrays for HS the geopotential height
    SILF01=zeros(numSelectedFiles,1);
    SILF25=zeros(numSelectedFiles,1);
    SILF50=zeros(numSelectedFiles,1);
    SILF75=zeros(numSelectedFiles,1);
    SILF90=zeros(numSelectedFiles,1);
    SILF100=zeros(numSelectedFiles,1);
    SILFNaN=zeros(numSelectedFiles,1);
    OWLF01=zeros(numSelectedFiles,1);
    OWLF25=zeros(numSelectedFiles,1);
    OWLF50=zeros(numSelectedFiles,1);
    OWLF75=zeros(numSelectedFiles,1);
    OWLF90=zeros(numSelectedFiles,1);
    OWLF100=zeros(numSelectedFiles,1);
    OWLFNaN=zeros(numSelectedFiles,1);
    SEAF01=zeros(numSelectedFiles,1);
    SEAF25=zeros(numSelectedFiles,1);
    SEAF50=zeros(numSelectedFiles,1);
    SEAF75=zeros(numSelectedFiles,1);
    SEAF90=zeros(numSelectedFiles,1);
    SEAF50=zeros(numSelectedFiles,1);
    SEAF100=zeros(numSelectedFiles,1);
    SEAFNaN=zeros(numSelectedFiles,1);
    HFICEF01=zeros(numSelectedFiles,1);
    HFICEF25=zeros(numSelectedFiles,1);
    HFICEF50=zeros(numSelectedFiles,1);
    HFICEF75=zeros(numSelectedFiles,1);
    HFICEF90=zeros(numSelectedFiles,1);
    HFICEF100=zeros(numSelectedFiles,1);
    HFICEFNaN=zeros(numSelectedFiles,1);
    HFWTRF01=zeros(numSelectedFiles,1);
    HFWTRF25=zeros(numSelectedFiles,1);
    HFWTRF50=zeros(numSelectedFiles,1);
    HFWTRF75=zeros(numSelectedFiles,1);
    HFWTRF90=zeros(numSelectedFiles,1);
    HFWTRF100=zeros(numSelectedFiles,1);
    LWGNICE01=zeros(numSelectedFiles,1);
    LWGNICE25=zeros(numSelectedFiles,1);
    LWGNICE50=zeros(numSelectedFiles,1);
    LWGNICE75=zeros(numSelectedFiles,1);
    LWGNICE90=zeros(numSelectedFiles,1);
    LWGNICE100=zeros(numSelectedFiles,1);
    LWGNICENaN=zeros(numSelectedFiles,1);
    LWGNWTR01=zeros(numSelectedFiles,1);
    LWGNWTR25=zeros(numSelectedFiles,1);
    LWGNWTR50=zeros(numSelectedFiles,1);
    LWGNWTR75=zeros(numSelectedFiles,1);
    LWGNWTR90=zeros(numSelectedFiles,1);
    LWGNWTR100=zeros(numSelectedFiles,1);
    LWGNWTRNaN=zeros(numSelectedFiles,1);
    TSKINICE01=zeros(numSelectedFiles,1);
    TSKINICE25=zeros(numSelectedFiles,1);
    TSKINICE50=zeros(numSelectedFiles,1);
    TSKINICE75=zeros(numSelectedFiles,1);
    TSKINICE90=zeros(numSelectedFiles,1);
    TSKINICE100=zeros(numSelectedFiles,1);
    TSKINICENaN=zeros(numSelectedFiles,1);
    TSKINWTR01=zeros(numSelectedFiles,1);
    TSKINWTR25=zeros(numSelectedFiles,1);
    TSKINWTR50=zeros(numSelectedFiles,1);
    TSKINWTR75=zeros(numSelectedFiles,1);
    TSKINWTR90=zeros(numSelectedFiles,1);
    TSKINWTR100=zeros(numSelectedFiles,1);
    TSKINWTRNaN=zeros(numSelectedFiles,1);
    SWGNTICE01=zeros(numSelectedFiles,1);
    SWGNTICE25=zeros(numSelectedFiles,1);
    SWGNTICE50=zeros(numSelectedFiles,1);
    SWGNTICE75=zeros(numSelectedFiles,1);
    SWGNTICE90=zeros(numSelectedFiles,1);
    SWGNTICE100=zeros(numSelectedFiles,1);
    SWGNTICENaN=zeros(numSelectedFiles,1);
    SWGNTWTR01=zeros(numSelectedFiles,1);
    SWGNTWTR25=zeros(numSelectedFiles,1);
    SWGNTWTR50=zeros(numSelectedFiles,1);
    SWGNTWTR75=zeros(numSelectedFiles,1);
    SWGNTWTR90=zeros(numSelectedFiles,1);
    SWGNTWTR100=zeros(numSelectedFiles,1);
    SWGNTWTRNaN=zeros(numSelectedFiles,1);
    TAUXICE01=zeros(numSelectedFiles,1);
    TAUXICE25=zeros(numSelectedFiles,1);
    TAUXICE50=zeros(numSelectedFiles,1);
    TAUXICE75=zeros(numSelectedFiles,1);
    TAUXICE90=zeros(numSelectedFiles,1);
    TAUXICE100=zeros(numSelectedFiles,1);
    TAUXICENaN=zeros(numSelectedFiles,1);
    TAUXWTR01=zeros(numSelectedFiles,1);
    TAUXWTR25=zeros(numSelectedFiles,1);
    TAUXWTR50=zeros(numSelectedFiles,1);
    TAUXWTR75=zeros(numSelectedFiles,1);
    TAUXWTR90=zeros(numSelectedFiles,1);
    TAUXWTR100=zeros(numSelectedFiles,1);
    TAUXWTRNaN=zeros(numSelectedFiles,1);
    TAUYICE01=zeros(numSelectedFiles,1);
    TAUYICE25=zeros(numSelectedFiles,1);
    TAUYICE50=zeros(numSelectedFiles,1);
    TAUYICE75=zeros(numSelectedFiles,1);
    TAUYICE90=zeros(numSelectedFiles,1);
    TAUYICE100=zeros(numSelectedFiles,1);
    TAUYICENaN=zeros(numSelectedFiles,1);
    TAUYWTR01=zeros(numSelectedFiles,1);
    TAUYWTR25=zeros(numSelectedFiles,1);
    TAUYWTR50=zeros(numSelectedFiles,1);
    TAUYWTR75=zeros(numSelectedFiles,1);
    TAUYWTR90=zeros(numSelectedFiles,1);
    TAUYWTR100=zeros(numSelectedFiles,1);
    TAUYWTRNaN=zeros(numSelectedFiles,1);
    T10M01=zeros(numSelectedFiles,1);
    T10M25=zeros(numSelectedFiles,1);
    T10M50=zeros(numSelectedFiles,1);
    T10M75=zeros(numSelectedFiles,1);
    T10M90=zeros(numSelectedFiles,1);
    T10M100=zeros(numSelectedFiles,1);
    T10MNaN=zeros(numSelectedFiles,1);
    QV10M01=zeros(numSelectedFiles,1);
    QV10M25=zeros(numSelectedFiles,1);
    QV10M50=zeros(numSelectedFiles,1);
    QV10M75=zeros(numSelectedFiles,1);
    QV10M90=zeros(numSelectedFiles,1);
    QV10M100=zeros(numSelectedFiles,1);
    QV10MNaN=zeros(numSelectedFiles,1);
    U10M01=zeros(numSelectedFiles,1);
    U10M25=zeros(numSelectedFiles,1);
    U10M50=zeros(numSelectedFiles,1);
    U10M75=zeros(numSelectedFiles,1);
    U10M90=zeros(numSelectedFiles,1);
    U10M100=zeros(numSelectedFiles,1);
    U10MNaN=zeros(numSelectedFiles,1);
    V10M01=zeros(numSelectedFiles,1);
    V10M25=zeros(numSelectedFiles,1);
    V10M50=zeros(numSelectedFiles,1);
    V10M75=zeros(numSelectedFiles,1);
    V10M90=zeros(numSelectedFiles,1);
    V10M100=zeros(numSelectedFiles,1);
    V10MNaN=zeros(numSelectedFiles,1);
    TAUYWTR75=zeros(numSelectedFiles,1);
    TAUYWTR90=zeros(numSelectedFiles,1);
    TAUYWTR100=zeros(numSelectedFiles,1);
    TAUYWTRNaN=zeros(numSelectedFiles,1);
    SeaIceAreaKmWorld=zeros(numSelectedFiles,1);
    SeaIceAreaKmNP=zeros(numSelectedFiles,1);
    SeaIceAreaKmSP=zeros(numSelectedFiles,1);
    RFRate01=zeros(numSelectedFiles,1);
    RFRate25=zeros(numSelectedFiles,1);
    RFRate50=zeros(numSelectedFiles,1);
    RFRate75=zeros(numSelectedFiles,1);
    RFRate90=zeros(numSelectedFiles,1);
    RFRate100=zeros(numSelectedFiles,1);
    RFRateNaN=zeros(numSelectedFiles,1);
    SFRate01=zeros(numSelectedFiles,1);
    SFRate25=zeros(numSelectedFiles,1);
    SFRate50=zeros(numSelectedFiles,1);
    SFRate75=zeros(numSelectedFiles,1);
    SFRate90=zeros(numSelectedFiles,1);
    SFRate100=zeros(numSelectedFiles,1);
    SFRateNaN=zeros(numSelectedFiles,1);
    RFTot01=zeros(numSelectedFiles,1);
    RFTot25=zeros(numSelectedFiles,1);
    RFTot50=zeros(numSelectedFiles,1);
    RFTot75=zeros(numSelectedFiles,1);
    RFTot90=zeros(numSelectedFiles,1);
    RFTot100=zeros(numSelectedFiles,1);
    RFTotNaN=zeros(numSelectedFiles,1);
    SFTot01=zeros(numSelectedFiles,1);
    SFTot25=zeros(numSelectedFiles,1);
    SFTot50=zeros(numSelectedFiles,1);
    SFTot75=zeros(numSelectedFiles,1);
    SFTot90=zeros(numSelectedFiles,1);
    SFTot100=zeros(numSelectedFiles,1);
    SFTotNaN=zeros(numSelectedFiles,1);
    AfricaTemps=zeros(numSelectedFiles,5);
    AlgeriaTemps=zeros(numSelectedFiles,5);
    ChadTemps=zeros(numSelectedFiles,5);
    LibyaTemps=zeros(numSelectedFiles,5);
    EgyptTemps=zeros(numSelectedFiles,5);
    AngolaTemps=zeros(numSelectedFiles,5);
    NigeriaTemps=zeros(numSelectedFiles,5);
    KenyaTemps=zeros(numSelectedFiles,5);
    MozambiqueTemps=zeros(numSelectedFiles,5);
    EthiopiaTemps=zeros(numSelectedFiles,5);
    MadagascarTemps=zeros(numSelectedFiles,5);
    SouthAfricaTemps=zeros(numSelectedFiles,5);
    CDRTemps=zeros(numSelectedFiles,5);
    CARTemps=zeros(numSelectedFiles,5);
    NamibiaTemps=zeros(numSelectedFiles,5);
    SomaliaTemps=zeros(numSelectedFiles,5);
    SudanTemps=zeros(numSelectedFiles,5);
    SaudiTemps=zeros(numSelectedFiles,5);
    IranTemps=zeros(numSelectedFiles,5);
    IraqTemps=zeros(numSelectedFiles,5);
    JordanTemps=zeros(numSelectedFiles,5);
    SyriaTemps=zeros(numSelectedFiles,5);
    TurkeyTemps=zeros(numSelectedFiles,5);
    PakistanTemps=zeros(numSelectedFiles,5);
    iReset=0;
end
%% Make Plots of the Geo2D variables that were decoded
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=iper(2)+1;
ie=iper(3)-1;
YearMonthDayStr1=Merra2FileName(is:ie);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
iper=iper';
ie=iper(numper,1)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
iScale=1; % This sets a scale factor which should in most cases be 1
% Display the Sea Ice Latent Energy Flux
lowcutoff=-200;
highcutoff=200;
ikind=1;
titlestr=strcat('WorldSeaIce-LatentEnergyFlux-',datestubstr);
iProj=2;
icase=2;
GeoTiffFileName='MercatorBaseMap.tif';
%[outputArg1,outputArg2] = CreateMerra2BaseMap(iProj,icase,GeoTiffFileName);
[Stats,EFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(EFLUXICES,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    %DisplayMerra2LatentEnergyFluxRev1(Stats,EFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
    DisplayMerra2LatentEnergyFluxRev1(Stats,EFluxAdj,fracNaN,ikind,iProj,titlestr)
%     titlestr=strcat('Africa-LatentEnergyFlux-',datestubstr);
%     iProj=4;
%     DisplayMerra2LatentEnergyFluxRev1(Stats,EFluxAdj,fracNaN,ikind,iProj,titlestr)
end
%DisplayMerra2LatentEnergyFluxRev3(Stats,EFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)%
%this does not work-says current map limits are not geographic
SILF01(framecounter,1)=Stats(1,3);
SILF25(framecounter,1)=Stats(6,3);
SILF50(framecounter,1)=Stats(9,3);
SILF75(framecounter,1)=Stats(12,3);
SILF90(framecounter,1)=Stats(14,3);
SILF100(framecounter,1)=Stats(18,3);
SILFNaN(framecounter,1)=fracNaN;
ab=1;
% Display the Open Water Latent Energy Flux
lowcutoff=-100;
highcutoff=800;
ikind=2;
iProj=2;
titlestr=strcat('WorldOpenWater-LatentEnergyFlux-',datestubstr);
[Stats,EFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(EFLUXWTRS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
%    DisplayMerra2LatentEnergyFluxRev1(Stats,EFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
    DisplayMerra2LatentEnergyFluxRev1(Stats,EFluxAdj,fracNaN,ikind,iProj,titlestr)
end
OWLF01(framecounter,1)=Stats(1,3);
OWLF25(framecounter,1)=Stats(6,3);
OWLF50(framecounter,1)=Stats(9,3);
OWLF75(framecounter,1)=Stats(12,3);
OWLF90(framecounter,1)=Stats(14,3);
OWLF100(framecounter,1)=Stats(18,3);
OWLFNaN(framecounter,1)=fracNaN;
% Display The Sea Ice Fraction
titlestr=strcat('SeaIce-Fraction-',datestubstr);
ikind=3;
iProj=2;
lowcutoff=0.00;
highcutoff=1.2;
[Stats,SeaIceAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(FRSEAICES,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2SeaIceFractionRev1(Stats,SeaIceAdj,fraclow,frachigh,fracNaN,ikind,iProj,titlestr)
end
SEAF01(framecounter,1)=Stats(1,3);
SEAF25(framecounter,1)=Stats(6,3);
SEAF50(framecounter,1)=Stats(9,3);
SEAF75(framecounter,1)=Stats(12,3);
SEAF90(framecounter,1)=Stats(14,3);
SEAF100(framecounter,1)=Stats(18,3);
SEAFNaN(framecounter,1)=fracNaN;

% Calculate Sea Ice area this will be ikind=4
SeaIce=SeaIceAdj;
[IceAreaWorld,IceAreaNP,IceAreaSP] = CalculateIceCoverKm(SeaIce);
SeaIceAreaKmWorld(framecounter,1)=IceAreaWorld;
SeaIceAreaKmNP(framecounter,1)= IceAreaNP;
SeaIceAreaKmSP(framecounter,1)=IceAreaSP;
% create a polar plot-for the North Pole
titlestr=strcat('SeaIceNP-Fraction-',datestubstr);
SeaIceConc=SeaIceAdj;
iProj=7;
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2SeaIceFractionPolarRev1(iProj,IceAreaWorld,IceAreaNP,IceAreaSP,titlestr)
end
% create a polar plot-for the South Pole
titlestr=strcat('SeaIceSP-Fraction-',datestubstr);
SeaIceConc=SeaIceAdj;
iProj=8;
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2SeaIceFractionPolarRev1(iProj,IceAreaWorld,IceAreaNP,IceAreaSP,titlestr)
end
% Display Upward Heat Flux
titlestr=strcat('SeaIce-UpwardHeatFlux-',datestubstr);
ikind=5;
lowcutoff=-500;
highcutoff=500;
[Stats,HFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(HFLUXICES,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) && (framecounter==1))
    DisplayMerra2UpwardHeatFluxRev1(Stats,HFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
HFICEF01(framecounter,1)=Stats(1,3);
HFICEF25(framecounter,1)=Stats(6,3);
HFICEF50(framecounter,1)=Stats(9,3);
HFICEF75(framecounter,1)=Stats(12,3);
HFICEF90(framecounter,1)=Stats(14,3);
HFICEF100(framecounter,1)=Stats(18,3);
HFICEFNaN(framecounter,1)=fracNaN;
% Display Open Water Upward Heat Flux
ikind=6;
titlestr=strcat('OpenWater-UpwardHeatFlux-',datestubstr);
lowcutoff=-500;
highcutoff=1000;
[Stats,HFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(HFLUXWTRS,lowcutoff,highcutoff);
if((mod(framecounter-1,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2UpwardHeatFluxRev1(Stats,HFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
HFWTRF01(framecounter,1)=Stats(1,3);
HFWTRF25(framecounter,1)=Stats(6,3);
HFWTRF50(framecounter,1)=Stats(9,3);
HFWTRF75(framecounter,1)=Stats(12,3);
HFWTRF90(framecounter,1)=Stats(14,3);
HFWTRF100(framecounter,1)=Stats(18,3);
HFWTRFNaN(framecounter,1)=fracNaN;
% Display the Sea Ice Net Downward Long Wave Flux
titlestr=strcat('SeaIce-NetDownLW-Flux-',datestubstr);
lowcutoff=-500;
highcutoff=500;
ikind=7;
[Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(LWGNTICES,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2NetDownLWFluxRev1(Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
LWGNICE01(framecounter,1)=Stats(1,3);
LWGNICE25(framecounter,1)=Stats(6,3);
LWGNICE50(framecounter,1)=Stats(9,3);
LWGNICE75(framecounter,1)=Stats(12,3);
LWGNICE90(framecounter,1)=Stats(14,3);
LWGNICE100(framecounter,1)=Stats(18,3);
LWGNICENaN(framecounter,1)=fracNaN;
% Display The Open Water Net Downward Flux
titlestr=strcat('OpenWater-NetDownLW-Flux-',datestubstr);
ikind=8;
lowcutoff=-500;
highcutoff=500;
[Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(LWGNTWTRS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2NetDownLWFluxRev1(Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
LWGNWTR01(framecounter,1)=Stats(1,3);
LWGNWTR25(framecounter,1)=Stats(6,3);
LWGNWTR50(framecounter,1)=Stats(9,3);
LWGNWTR75(framecounter,1)=Stats(12,3);
LWGNWTR90(framecounter,1)=Stats(14,3);
LWGNWTR100(framecounter,1)=Stats(18,3);
LWGNWTRNaN(framecounter,1)=fracNaN;


% Display The 10 Meter Air Temp
titlestr=strcat('World-AirTemp-10m-',datestubstr);
ikind=9;
lowcutoff=200;
highcutoff=400;
iProj=2;
[Stats,AirTempAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(T10MS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2AirTemp(Stats,AirTempAdj,fraclow,frachigh,fracNaN,ikind,iProj,titlestr)
    iProj=4;
    titlestr=strcat('Africa-AirTemp-10m-',datestubstr);
    DisplayMerra2AirTemp(Stats,AirTempAdj,fraclow,frachigh,fracNaN,ikind,iProj,titlestr)
    iProj=5;
    titlestr=strcat('Australia-AirTemp-10m-',datestubstr);
    DisplayMerra2AirTemp(Stats,AirTempAdj,fraclow,frachigh,fracNaN,ikind,iProj,titlestr)
    iProj=6;
    titlestr=strcat('Europe-AirTemp-10m-',datestubstr);
    DisplayMerra2AirTemp(Stats,AirTempAdj,fraclow,frachigh,fracNaN,ikind,iProj,titlestr)
end
iProj=2;
T10M01(framecounter,1)=Stats(1,3)-273.15;% Change the final stats into Deg C
T10M25(framecounter,1)=Stats(6,3)-273.15;
T10M50(framecounter,1)=Stats(9,3)-273.15;
T10M75(framecounter,1)=Stats(12,3)-273.15;
T10M90(framecounter,1)=Stats(14,3)-273.15;
T10M100(framecounter,1)=Stats(18,3)-273.15;
T10MNaN(framecounter,1)=fracNaN;
TAirTempC=AirTempAdj-273.15;
iMaskSclt=1;
for jj=1:numSelectedMasks
    iMaskSclt=SelectedMaskIndices(jj,1);
    Merra2UserMask=Dataset4Masks(iMaskSclt).Mask;
    CalculateMaskedAreaAirTempStats(AirTempAdj,Merra2UserMask,iMaskSclt);
end

%% Display Ocean Precip Data
% Note that this can be displayed as rate or as an integrated value ov a 24
% hour period
iScale=3600;
if(integrateRate==0)
    titlestr=strcat('OceanRainFallRate-',datestubstr);
    lowcutoff=-.1;
    highcutoff=20;
elseif(integrateRate==1)
    titlestr=strcat('OceanRainFallTotal-',datestubstr);
    lowcutoff=-.1;
    highcutoff=20;
end
% Display the Rain Fall Rate
ikind=20;
iScale=3600;
titlestr=strcat('Ocean-RainFallRate-',datestubstr);
[Stats,PrecipAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(RAINOCNS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2OceanPrecip(Stats,PrecipAdj,fraclow,frachigh,fracNaN,ikind,titlestr);
end
RFRate01(framecounter,1)=Stats(1,3);
RFRate25(framecounter,1)=Stats(6,3);
RFRate50(framecounter,1)=Stats(9,3);
RFRate75(framecounter,1)=Stats(12,3);
RFRate90(framecounter,1)=Stats(14,3);
RFRate100(framecounter,1)=Stats(18,3);
RFRateNaN(framecounter,1)=fracNaN;
% Display the Snow Fall Rate
ikind=21;
iScale=3600;
titlestr=strcat('Ocean-SnowFallRate-',datestubstr);
[Stats,PrecipAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(PRECSNOOCNS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2OceanPrecip(Stats,PrecipAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
SFRate01(framecounter,1)=Stats(1,3);
SFRate25(framecounter,1)=Stats(6,3);
SFRate50(framecounter,1)=Stats(9,3);
SFRate75(framecounter,1)=Stats(12,3);
SFRate90(framecounter,1)=Stats(14,3);
SFRate100(framecounter,1)=Stats(18,3);
SFRateNaN(framecounter,1)=fracNaN;
ab=2;
% Display The Rain Fall Total
ikind=22;
iScale=3600;
titlestr=strcat('Ocean-RainFallTotal-',datestubstr);
[Stats,PrecipSumAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev6(RAINOCNS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2OceanPrecip(Stats,PrecipSumAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
RFTot01(framecounter,1)=Stats(1,3);
RFTot25(framecounter,1)=Stats(6,3);
RFTot50(framecounter,1)=Stats(9,3);
RFTot75(framecounter,1)=Stats(12,3);
RFTot90(framecounter,1)=Stats(14,3);
RFTot100(framecounter,1)=Stats(18,3);
RFTotNaN(framecounter,1)=fracNaN;
ab=2;
% Display The Snow Fall Total
ikind=23;
iScale=3600;
titlestr=strcat('Ocean-SnowFallTotal-',datestubstr);
lowcutoff=-.1;
highcutoff=20;
[Stats,PrecipSumAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev6(PRECSNOOCNS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2OceanPrecip(Stats,PrecipSumAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
SFTot01(framecounter,1)=Stats(1,3);
SFTot25(framecounter,1)=Stats(6,3);
SFTot50(framecounter,1)=Stats(9,3);
SFTot75(framecounter,1)=Stats(12,3);
SFTot90(framecounter,1)=Stats(14,3);
SFTot100(framecounter,1)=Stats(18,3);
SFTotNaN(framecounter,1)=fracNaN;
ab=2;
% Display the Sea Ice Skin Temperature
titlestr=strcat('SeaIce-Skin-Temp-',datestubstr);
lowcutoff=150;
highcutoff=320;
ikind=11;
iScale=1;
[Stats,TSKINICEAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TSKINICES,lowcutoff,highcutoff);
% Reset the stats temps from Deg K to Deg C
for nk=1:18
    Stats(nk,3)=Stats(nk,3)-273.15;
end
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2SeaIceSkinTempRev1(Stats,TSKINICEAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
TSKINICE01(framecounter,1)=Stats(1,3);
TSKINICE25(framecounter,1)=Stats(6,3);
TSKINICE50(framecounter,1)=Stats(9,3);
TSKINICE75(framecounter,1)=Stats(12,3);
TSKINICE90(framecounter,1)=Stats(14,3);
TSKINICE100(framecounter,1)=Stats(18,3);
TSKINICENaN(framecounter,1)=fracNaN;
titlestr=strcat('SeaIce-SkinTemp-',datestubstr);
ab=3;
% Display the Open Water Skin Temperature
titlestr=strcat('Open-Water-Skin-Temp-',datestubstr);
lowcutoff=150;
highcutoff=320;
ikind=12;
iScale=1;
[Stats,TSKINWTRAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TSKINWTRS,lowcutoff,highcutoff);
% Reset the stats temps from Deg K to Deg C
for nk=1:18
    Stats(nk,3)=Stats(nk,3)-273.15;
end
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2SeaIceSkinTempRev1(Stats,TSKINWTRAdj,fraclow,frachigh,fracNaN,ikind,titlestr);
end
TSKINWTR01(framecounter,1)=Stats(1,3);
TSKINWTR25(framecounter,1)=Stats(6,3);
TSKINWTR50(framecounter,1)=Stats(9,3);
TSKINWTR75(framecounter,1)=Stats(12,3);
TSKINWTR90(framecounter,1)=Stats(14,3);
TSKINWTR100(framecounter,1)=Stats(18,3);
TSKINWTRNaN(framecounter,1)=fracNaN;
titlestr=strcat('SeaIce-SkinTemp-',datestubstr);
ab=3;
% Display the Sea Ice Net Downward Short Wave Flux
titlestr=strcat('SeaIce-NetDownSW-Flux-',datestubstr);
lowcutoff=-500;
highcutoff=700;
ikind=13;
[Stats,SWGNFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(SWGNTICES,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2NetDownLWFluxRev2(Stats,SWGNFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr);
end
SWGNTICE01(framecounter,1)=Stats(1,3);
SWGNTICE25(framecounter,1)=Stats(6,3);
SWGNTICE50(framecounter,1)=Stats(9,3);
SWGNTICE75(framecounter,1)=Stats(12,3);
SWGNTICE90(framecounter,1)=Stats(14,3);
SWGNTICE100(framecounter,1)=Stats(18,3);
SWGNTICENaN(framecounter,1)=fracNaN;
ab=1;
% Display the Open Water Net Downward Short Wave Flux
titlestr=strcat('SeaIce-NetDownSW-Flux-',datestubstr);
lowcutoff=-500;
highcutoff=700;
ikind=14;
[Stats,SWGNFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(SWGNTWTRS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2NetDownLWFluxRev2(Stats,SWGNFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
SWGNTWTR01(framecounter,1)=Stats(1,3);
SWGNTWTR25(framecounter,1)=Stats(6,3);
SWGNTWTR50(framecounter,1)=Stats(9,3);
SWGNTWTR75(framecounter,1)=Stats(12,3);
SWGNTWTR90(framecounter,1)=Stats(14,3);
SWGNTWTR100(framecounter,1)=Stats(18,3);
SWGNTWTRNaN(framecounter,1)=fracNaN;
ab=1;
% Display the Eastward Windstress over ice
titlestr=strcat('SeaIce-East-Windstress',datestubstr);
lowcutoff=-10;
highcutoff=10;
ikind=15;
[Stats,TauAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TAUXICES,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2WindStress(Stats,TauAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
TAUXICE01(framecounter,1)=Stats(1,3);
TAUXICE25(framecounter,1)=Stats(6,3);
TAUXICE50(framecounter,1)=Stats(9,3);
TAUXICE75(framecounter,1)=Stats(12,3);
TAUXICE90(framecounter,1)=Stats(14,3);
TAUXICE100(framecounter,1)=Stats(18,3);
TAUXICENaN(framecounter,1)=fracNaN;
% Display the Eastward Windstress over Open Water
titlestr=strcat('OpenWater-East-Windstress',datestubstr);
lowcutoff=-10;
highcutoff=10;
ikind=16;
[Stats,TauAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TAUXWTRS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2WindStress(Stats,TauAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
TAUXWTR01(framecounter,1)=Stats(1,3);
TAUXWTR25(framecounter,1)=Stats(6,3);
TAUXWTR50(framecounter,1)=Stats(9,3);
TAUXWTR75(framecounter,1)=Stats(12,3);
TAUXWTR90(framecounter,1)=Stats(14,3);
TAUXWTR100(framecounter,1)=Stats(18,3);
TAUXWTRNaN(framecounter,1)=fracNaN;
% Display the North Windstress over Sea Ice
titlestr=strcat('SeaIce-North-Windstress',datestubstr);
lowcutoff=-10;
highcutoff=10;
ikind=17;
[Stats,TauAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TAUYICES,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2WindStress(Stats,TauAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
TAUYICE01(framecounter,1)=Stats(1,3);
TAUYICE25(framecounter,1)=Stats(6,3);
TAUYICE50(framecounter,1)=Stats(9,3);
TAUYICE75(framecounter,1)=Stats(12,3);
TAUYICE90(framecounter,1)=Stats(14,3);
TAUYICE100(framecounter,1)=Stats(18,3);
TAUYICENaN(framecounter,1)=fracNaN;
ab=5;
% Display the North Windstress over Open Water
titlestr=strcat('OpenWater-North-Windstress',datestubstr);
lowcutoff=-10;
highcutoff=10;
ikind=18;
[Stats,TauAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TAUYWTRS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
    DisplayMerra2WindStress(Stats,TauAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
end
TAUYWTR01(framecounter,1)=Stats(1,3);
TAUYWTR25(framecounter,1)=Stats(6,3);
TAUYWTR50(framecounter,1)=Stats(9,3);
TAUYWTR75(framecounter,1)=Stats(12,3);
TAUYWTR90(framecounter,1)=Stats(14,3);
TAUYWTR100(framecounter,1)=Stats(18,3);
TAUYWTRNaN(framecounter,1)=fracNaN;
% Display The 10 Meter Eastward Wind
titlestr=strcat('World-EastWind-10m-',datestubstr);
ikind=25;
lowcutoff=-100;
highcutoff=100;
[Stats,WindAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(U10MS,lowcutoff,highcutoff);
iProj=2;
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
%    DisplayMerra2WindComponents(Stats,WindAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
    DisplayMerra2WindComponents(Stats,WindAdj,fracNaN,ikind,iProj,titlestr)
end
U10M01(framecounter,1)=Stats(1,3);
U10M25(framecounter,1)=Stats(6,3);
U10M50(framecounter,1)=Stats(9,3);
U10M75(framecounter,1)=Stats(12,3);
U10M90(framecounter,1)=Stats(14,3);
U10M100(framecounter,1)=Stats(18,3);
U10MNaN(framecounter,1)=fracNaN;
U10=WindAdj;
% Display The 10 Meter Northward Wind
titlestr=strcat('World-NorthWind-10m-',datestubstr);
ikind=26;
lowcutoff=-100;
highcutoff=100;
iProj=2;
[Stats,WindAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(V10MS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
%    DisplayMerra2WindComponents(Stats,WindAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
    DisplayMerra2WindComponents(Stats,WindAdj,fracNaN,ikind,iProj,titlestr)
end
V10M01(framecounter,1)=Stats(1,3);
V10M25(framecounter,1)=Stats(6,3);
V10M50(framecounter,1)=Stats(9,3);
V10M75(framecounter,1)=Stats(12,3);
V10M90(framecounter,1)=Stats(14,3);
V10M100(framecounter,1)=Stats(18,3);
V10MNaN(framecounter,1)=fracNaN;
V10=WindAdj;
% Plot the wind components at 10 m along with the air temp
Tau = windstress(hypot(U10,V10));
ikind=30;
titlestr=strcat('WindComponentsQuiver-',datestubstr);
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotWindQuiver(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)

% Display The 10 Meter Specific Humidity
titlestr=strcat('WorldSpecificHumidity-10m-',datestubstr);
ikind=27;
lowcutoff=-1;
highcutoff=1E-2;
iProj=2;
[Stats,QVAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(QV10MS,lowcutoff,highcutoff);
if((mod(framecounter,iSkipDisplayFrames)==0) || (framecounter==1))
%    DisplayMerra2WindComponents(Stats,QVAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
    DisplayMerra2WindComponents(Stats,QVAdj,fracNaN,ikind,iProj,titlestr)
    titlestr=strcat('AfricaSpecificHumidity-10m-',datestubstr);
    iProj=4;
    DisplayMerra2WindComponents(Stats,QVAdj,fracNaN,ikind,iProj,titlestr)
    iProj=5;
    titlestr=strcat('AustraliaSpecificHumidity-10m-',datestubstr);
    DisplayMerra2WindComponents(Stats,QVAdj,fracNaN,ikind,iProj,titlestr)
end
QV10M01(framecounter,1)=Stats(1,3);
QV10M25(framecounter,1)=Stats(6,3);
QV10M50(framecounter,1)=Stats(9,3);
QV10M75(framecounter,1)=Stats(12,3);
QV10M90(framecounter,1)=Stats(14,3);
QV10M100(framecounter,1)=Stats(18,3);
QV10MNaN(framecounter,1)=fracNaN;


%% Start compilation of data over all frames
if(framecounter==numSelectedFiles)
    if(iTimeSlice==1)
        TimeStr='-00-Hrs-GMT';
    elseif(iTimeSlice==2)
        TimeStr='-01-Hrs-GMT';
    elseif(iTimeSlice==3)
        TimeStr='-02-Hrs-GMT';
    elseif(iTimeSlice==4)
        TimeStr='-03-Hrs-GMT';
    elseif(iTimeSlice==5)
        TimeStr='-04-Hrs-GMT';
    elseif(iTimeSlice==6)
        TimeStr='-05-Hrs-GMT';
    elseif(iTimeSlice==7)
        TimeStr='-06-Hrs-GMT';
    elseif(iTimeSlice==8)
        TimeStr='-07-Hrs-GMT';
    elseif(iTimeSlice==9)
        TimeStr='-08-Hrs-GMT';
    elseif(iTimeSlice==10)
        TimeStr='-09-Hrs-GMT';
    elseif(iTimeSlice==11)
        TimeStr='-10-Hrs-GMT';
    elseif(iTimeSlice==12)
        TimeStr='-11-Hrs-GMT';   
    elseif(iTimeSlice==13)
        TimeStr='-12-Hrs-GMT';
    elseif(iTimeSlice==14)
        TimeStr='-13-Hrs-GMT';
    elseif(iTimeSlice==15)
        TimeStr='-14-Hrs-GMT';
    elseif(iTimeSlice==16)
        TimeStr='-15-Hrs-GMT';
    elseif(iTimeSlice==17)
        TimeStr='-16-Hrs-GMT';
    elseif(iTimeSlice==18)
        TimeStr='-17-Hrs-GMT'; 
    elseif(iTimeSlice==19)
        TimeStr='-18-Hrs-GMT';
    elseif(iTimeSlice==20)
        TimeStr='-19-Hrs-GMT';
    elseif(iTimeSlice==21)
        TimeStr='-20-Hrs-GMT';
    elseif(iTimeSlice==22)
        TimeStr='-21-Hrs-GMT';
    elseif(iTimeSlice==23)
        TimeStr='-22-Hrs-GMT';
    elseif(iTimeSlice==24)
        TimeStr='-23-Hrs-GMT';      
    end
  stime=datetime(yd,md,dd);
  timestep=days(1);
end
%% Build All Data Tables
if(framecounter==numSelectedFiles)
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','----------- Starting Detailing Table Creation-----------');
%% Create the Sea Ice Latent Energy Flux ikind=1
    EFLUXICETable=table(SILF01(:,1),SILF25(:,1),SILF50(:,1),SILF75(:,1),...
        SILF90(:,1),SILF100(:,1),...
        'VariableNames',{'SILF01','SILF25','SILF50',...
         'SILF75','SILF90','SILF100'});
    EFLUXICETT = table2timetable(EFLUXICETable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='EFLUXICETable EFLUXICETT';
    MatFileName=strcat('EFLUXICETable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    silstr=strcat('Created EFLUXICETT-','Contains Sea Ice Latent Energy Flux Data-',num2str(1));
    fprintf(fid,'%s\n',silstr);

%% Create the Open Water Latent Energy Flux ikind=2
    EFLUXWTRTable=table(OWLF01(:,1),OWLF25(:,1),OWLF50(:,1),OWLF75(:,1),...
        OWLF90(:,1),OWLF100(:,1),...
        'VariableNames',{'OWLF01','OWLF25','OWLF50',...
         'OWLF75','OWLF90','OWLF100'});
    EFLUXWTRTT = table2timetable(EFLUXWTRTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='EFLUXWTRTable EFLUXWTRTT';
    MatFileName=strcat('EFLUXWTRTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    owlstr=strcat('Created EFLUXWTRTT-','Contains Open Water Latent Energy Flux Data-',num2str(2));
    fprintf(fid,'%s\n',owlstr);
%% Create a Table to Store The Sea Ice Fraction ikind=3
    SEAICETable=table(SEAF01(:,1),SEAF25(:,1),SEAF50(:,1),SEAF75(:,1),...
        SEAF90(:,1),SEAF100(:,1),...
        'VariableNames',{'SEAF01','SEAF25','SEAF50',...
         'SEAF75','SEAF90','SEAF100'});
    SEAICETT = table2timetable(SEAICETable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='SEAICETable SEAICETT';
    MatFileName=strcat('SEAICETable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    seastr=strcat('Created SEAICETT-','Contains Sea Ice Fraction-',num2str(3));
    fprintf(fid,'%s\n',seastr);
%% Create a Table Holding the Sea Ice Data ikind=4
    SeaIceAreaTable=table(SeaIceAreaKmWorld(:,1),SeaIceAreaKmNP(:,1),SeaIceAreaKmSP(:,1),...
       'VariableNames',{'SeaIceAreaKmWorld','SeaIceAreaKmNP','SeaIceAreaKmSP'});
    SeaIceAreaTT = table2timetable(SeaIceAreaTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='SeaIceAreaTable SeaIceAreaTT';
    MatFileName=strcat('SeaIceAreaTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    seaiceareastr=strcat('SeaIceAreaTT-','Contains Sea Ice Area in Sq KM-',num2str(25));
    fprintf(fid,'%s\n',seaiceareastr);
 %% Create a Table to Store The Sea Ice Upwards Flux ikind=5
    HFLUXICETable=table(HFICEF01(:,1),HFICEF25(:,1),HFICEF50(:,1),HFICEF75(:,1),...
        HFICEF90(:,1),HFICEF100(:,1),...
        'VariableNames',{'HFICEF01','HFICEF25','HFICEF50',...
         'HFICEF75','HFICEF90','HFICEF100'});
    HFLUXICETT = table2timetable(HFLUXICETable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='HFLUXICETable HFLUXICETT';
    MatFileName=strcat('HFLUXICETable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    seastr=strcat('Created HFLUXICETT-','Contains Sea Ice Upwards Heat Flux-',num2str(5));
    fprintf(fid,'%s\n',seastr);
 %% Create a Table to Store The Open Upwards Flux ikind=6
    HFLUXWTRTable=table(HFWTRF01(:,1),HFWTRF25(:,1),HFWTRF50(:,1),HFWTRF75(:,1),...
        HFWTRF90(:,1),HFWTRF100(:,1),...
        'VariableNames',{'HFWTRF01','HFWTRF25','HFWTRF50',...
         'HFWTRF75','HFWTRF90','HFWTRF100'});
    HFLUXWTRTT = table2timetable(HFLUXWTRTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='HFLUXWTRTable HFLUXWTRTT';
    MatFileName=strcat('HFLUXWTRTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    opwstr=strcat('Created HFLUXWTRTT-','Contains Open Water Upwards Heat Flux-',num2str(5));
    fprintf(fid,'%s\n',opwstr);
 %% Create a Table to Store The Sea Ice Downwards Flux ikind=7
    LWGNICESTable=table(LWGNICE01(:,1),LWGNICE25(:,1),LWGNICE50(:,1),LWGNICE75(:,1),...
        LWGNICE90(:,1),LWGNICE100(:,1),...
        'VariableNames',{'LWGNICE01','LWGNICE25','LWGNICE50',...
         'LWGNICE75','LWGNICE90','LWGNICE100'});
    LWGNICESTT = table2timetable(LWGNICESTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='LWGNICESTable LWGNICESTT';
    MatFileName=strcat('LWGNICESTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    licesstr=strcat('Created LWGNICESTableTT-','Contains Sea Ice Downward Flux-',num2str(7));
    fprintf(fid,'%s\n',licesstr);
 %% Create a Table to Store The Open Water Downwards Flux ikind=8
    LWGNWTRSTable=table(LWGNWTR01(:,1),LWGNWTR25(:,1),LWGNWTR50(:,1),LWGNWTR75(:,1),...
        LWGNWTR90(:,1),LWGNWTR100(:,1),...
        'VariableNames',{'LWGNWTR01','LWGNWTR25','LWGNWTR50',...
         'LWGNWTR75','LWGNWTR90','LWGNWTR100'});
    LWGNWTRSTT = table2timetable(LWGNWTRSTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='LWGNWTRSTable LWGNWTRSTT';
    MatFileName=strcat('LWGNWTRSTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    lwtrsstr=strcat('Created LWGNWTRSTT-','Contains Open Waters Downward Flux-',num2str(8));
    fprintf(fid,'%s\n',lwtrsstr);
 %% Create a Table to Store The 10 Meter Air Temp ikind=9
    T10MTable=table(T10M01(:,1),T10M25(:,1),T10M50(:,1),T10M75(:,1),...
        T10M90(:,1),T10M100(:,1),...
        'VariableNames',{'T10M01','T10M25','T10M50',...
         'T10M75','T10M90','T10M100'});
    T10MTT = table2timetable(T10MTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='T10MTable T10MTT';
    MatFileName=strcat('T10MTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    air10str=strcat('Created T10MTT-','Contains Air Temp At 10M-',num2str(9));
    fprintf(fid,'%s\n',air10str);
%% Create a Table to Store The Skin Temp Of Sea Ice  ikind 11
    TSKINICETable=table(TSKINICE01(:,1),TSKINICE25(:,1),TSKINICE50(:,1),TSKINICE75(:,1),...
        TSKINICE90(:,1),TSKINICE100(:,1),...
        'VariableNames',{'TSKINICE01','TSKINICE25','TSKINICE50',...
         'TSKINICE75','TSKINICE90','TSKINICE100'});
    TSKINICETT = table2timetable(TSKINICETable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TSKINICETable TSKINICETT';
    MatFileName=strcat('TSKINICETable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    skin1str=strcat('Created TSKINICETT-','Contains Sea Ice Skin Temps-',num2str(11));
    fprintf(fid,'%s\n',skin1str);
 %% Create a Table to Store The Skin Temp Of Sea Ice  ikind 12
    TSKINWTRTable=table(TSKINWTR01(:,1),TSKINWTR25(:,1),TSKINWTR50(:,1),TSKINWTR75(:,1),...
        TSKINWTR90(:,1),TSKINWTR100(:,1),...
        'VariableNames',{'TSKINWTR01','TSKINWTR25','TSKINWTR50',...
         'TSKINWTR75','TSKINWTR90','TSKINWTR100'});
    TSKINWTRTT = table2timetable(TSKINWTRTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TSKINWTRTable TSKINWTRTT';
    MatFileName=strcat('TSKINWTRTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    skin2str=strcat('Created TSKINWTRTT-','Contains Open Water Skin Temps-',num2str(12));
    fprintf(fid,'%s\n',skin2str);
 %% Create a Table to Store Sea Ice Net Downward SW Flux  ikind 13
    SWGNTICETable=table(SWGNTICE01(:,1),SWGNTICE25(:,1),SWGNTICE50(:,1),SWGNTICE75(:,1),...
        SWGNTICE90(:,1),SWGNTICE100(:,1),...
        'VariableNames',{'SWGNTICE01','SWGNTICE25','SWGNTICE50',...
         'SWGNTICE75','SWGNTICE90','SWGNTICE100'});
    SWGNTICETT = table2timetable(SWGNTICETable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='SWGNTICETable SWGNTICETT';
    MatFileName=strcat('SWGNTICETable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dflux1str=strcat('SWGNTICETT-','Contains Sea Ice SW Downards Flux-',num2str(13));
    fprintf(fid,'%s\n',dflux1str);
 %% Create a Table to Store Open Water Net Downward SW Flux  ikind 14
    SWGNTWTRTable=table(SWGNTWTR01(:,1),SWGNTWTR25(:,1),SWGNTWTR50(:,1),SWGNTWTR75(:,1),...
        SWGNTWTR90(:,1),SWGNTWTR100(:,1),...
        'VariableNames',{'SWGNTWTR01','SWGNTWTR25','SWGNTWTR50',...
         'SWGNTWTR75','SWGNTWTR90','SWGNTWTR100'});
    SWGNTWTRTT = table2timetable(SWGNTWTRTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='SWGNTWTRTable SWGNTWTRTT';
    MatFileName=strcat('SWGNTWTRTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    dflux2str=strcat('SWGNTWTRTT-','Contains Open SW Downards Flux-',num2str(14));
    fprintf(fid,'%s\n',dflux2str);
 %% Create a Table to Store Sea Ice East Windstress  ikind 15
    TAUXICETable=table(TAUXICE01(:,1),TAUXICE25(:,1),TAUXICE50(:,1),TAUXICE75(:,1),...
        TAUXICE90(:,1),TAUXICE100(:,1),...
        'VariableNames',{'TAUXICE01','TAUXICE25','TAUXICE50',...
         'TAUXICE75','TAUXICE90','TAUXICE100'});
    TAUXICETT = table2timetable(TAUXICETable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TAUXICETable TAUXICETT';
    MatFileName=strcat('TAUXICETable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    ewind1str=strcat('TAUXICETT-','Contains Sea Ice East Wind Stress-',num2str(15));
    fprintf(fid,'%s\n',ewind1str);
  %% Create a Table to Store Open Water East Windstress  ikind 16
    TAUXWTRTable=table(TAUXWTR01(:,1),TAUXWTR25(:,1),TAUXWTR50(:,1),TAUXWTR75(:,1),...
        TAUXWTR90(:,1),TAUXWTR100(:,1),...
        'VariableNames',{'TAUXWTR01','TAUXWTR25','TAUXWTR50',...
         'TAUXWTR75','TAUXWTR90','TAUXWTR100'});
    TAUXWTRTT = table2timetable(TAUXWTRTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TAUXWTRTable TAUXWTRTT';
    MatFileName=strcat('TAUXWTRTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    ewind2str=strcat('TAUXWTRTT-','Contains Open Water East Wind Stress-',num2str(16));
    fprintf(fid,'%s\n',ewind2str);
  %% Create a Table to Store Sea Ice North Windstress  ikind 17
    TAUYICETable=table(TAUYICE01(:,1),TAUYICE25(:,1),TAUYICE50(:,1),TAUYICE75(:,1),...
        TAUYICE90(:,1),TAUYICE100(:,1),...
        'VariableNames',{'TAUYICE01','TAUYICE25','TAUYICE50',...
         'TAUYICE75','TAUYICE90','TAUYICE100'});
    TAUYICETT = table2timetable(TAUYICETable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TAUYICETable TAUYICETT';
    MatFileName=strcat('TAUYICETable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    nwind1str=strcat('TAUYICETT-','Contains Sea Ice North Wind Stress-',num2str(17));
    fprintf(fid,'%s\n',nwind1str);
  %% Create a Table to Store Open Water North Windstress  ikind 18
    TAUYWTRTable=table(TAUYWTR01(:,1),TAUYWTR25(:,1),TAUYWTR50(:,1),TAUYWTR75(:,1),...
        TAUYWTR90(:,1),TAUYWTR100(:,1),...
        'VariableNames',{'TAUYWTR01','TAUYWTR25','TAUYWTR50',...
         'TAUYWTR75','TAUYWTR90','TAUYWTR100'});
    TAUYWTRTT = table2timetable(TAUYWTRTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TAUYWTRTable TAUYWTRTT';
    MatFileName=strcat('TAUYWTRTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    nwind2str=strcat('TAUYWTRTT-','Contains Open Water North Wind Stress-',num2str(18));
    fprintf(fid,'%s\n',nwind2str);
 %% Create a Table to store the Ocean Rainfall Rate  ikind 20
    RFRateTable=table(RFRate01(:,1),RFRate25(:,1),RFRate50(:,1),RFRate75(:,1),...
        RFRate90(:,1),RFRate100(:,1),...
        'VariableNames',{'RFRate01','RFRate25','RFRate50',...
         'RFRate75','RFRate90','RFRate100'});
    RFRateTT = table2timetable(RFRateTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='RFRateTable RFRateTT';
    MatFileName=strcat('RFRateTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    rfrstr=strcat('RFRateTT-','Contains Ocean Rain Fall Rate-',num2str(20));
    fprintf(fid,'%s\n',rfrstr);
 %% Create a Table to store the Ocean Snowfall Rate  ikind 21
    SFRateTable=table(SFRate01(:,1),SFRate25(:,1),SFRate50(:,1),SFRate75(:,1),...
        SFRate90(:,1),SFRate100(:,1),...
        'VariableNames',{'SFRate01','SFRate25','SFRate50',...
         'SFRate75','SFRate90','SFRate100'});
    SFRateTT = table2timetable(SFRateTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='SFRateTable SFRateTT';
    MatFileName=strcat('SFRateTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    snfrstr=strcat('SFRateTT-','Contains Ocean Snow Fall Rate-',num2str(21));
    fprintf(fid,'%s\n',snfrstr);
 %% Create a Table to store the Ocean Rainfall Total  ikind 22
    RFTotalTable=table(RFTot01(:,1),RFTot25(:,1),RFTot50(:,1),RFTot75(:,1),...
        RFTot90(:,1),RFTot100(:,1),...
        'VariableNames',{'RFTot01','RFTot25','RFTot50',...
         'RFTot75','RFTot90','RFTot100'});
    RFTotalTT = table2timetable(RFTotalTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='RFTotalTable RFTotalTT';
    MatFileName=strcat('RFTotalTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    rftstr=strcat('RFTotalTT-','Contains Ocean Rain Fall Total-',num2str(22));
    fprintf(fid,'%s\n',rftstr);
 %% Create a Table to store the Ocean Snowfall Total  ikind 23
    SFTotalTable=table(SFTot01(:,1),SFTot25(:,1),SFTot50(:,1),SFTot75(:,1),...
        SFTot90(:,1),SFTot100(:,1),...
        'VariableNames',{'SFTot01','SFTot25','SFTot50',...
         'SFTot75','SFTot90','SFTot100'});
    SFTotalTT = table2timetable(SFTotalTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='SFTotalTable SFTotalTT';
    MatFileName=strcat('SFTotalTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    sftstr=strcat('SFTotalTT-','Contains Ocean Snow Fall Total-',num2str(23));
    fprintf(fid,'%s\n',sftstr);
 %% Create a Table to Store The 10 Meter East Wind Velocity ikind=25
    U10MTable=table(U10M01(:,1),U10M25(:,1),U10M50(:,1),U10M75(:,1),...
        U10M90(:,1),U10M100(:,1),...
        'VariableNames',{'U10M01','U10M25','U10M50',...
         'U10M75','U10M90','U10M100'});
    U10MTT = table2timetable(U10MTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='U10MTable U10MTT';
    MatFileName=strcat('U10MTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    winde10str=strcat('Created U10MTT-','Contains East Wind At 10M-',num2str(25));
    fprintf(fid,'%s\n',winde10str);
  %% Create a Table to Store The 10 Meter North Wind Velocity ikind=26
    V10MTable=table(V10M01(:,1),V10M25(:,1),V10M50(:,1),V10M75(:,1),...
        V10M90(:,1),V10M100(:,1),...
        'VariableNames',{'V10M01','V10M25','V10M50',...
         'V10M75','V10M90','V10M100'});
    V10MTT = table2timetable(V10MTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='V10MTable V10MTT';
    MatFileName=strcat('V10MTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    windn10str=strcat('Created V10MTT-','Contains North Wind At 10M-',num2str(26));
    fprintf(fid,'%s\n',windn10str);
 %% Create a Table to Store The 10 Meter Specific Humidity ikind=27
    QV10MTable=table(QV10M01(:,1),QV10M25(:,1),QV10M50(:,1),QV10M75(:,1),...
        QV10M90(:,1),QV10M100(:,1),...
        'VariableNames',{'QV10M01','QV10M25','QV10M50',...
         'QV10M75','QV10M90','QV10M100'});
    QV10MTT = table2timetable(QV10MTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='QV10MTable QV10MTT';
    MatFileName=strcat('V10MTable',YearMonthStr,TimeStr,'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    qv10str=strcat('Created QV10MTT-','Contains Specific Humidity At 10M-',num2str(27));
    fprintf(fid,'%s\n',qv10str);

%% Create a Table to Store the Africa Continent Only Air Temp Values
AfricaTempsTable=table(AfricaTemps(:,2),AfricaTemps(:,3),AfricaTemps(:,4),AfricaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
AfricaTempsTT=table2timetable(AfricaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='AfricaTempsTable AfricaTempsTT';
MatFileName=strcat('AfricaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
africatempsstr=strcat('Created AfricaTempsTT-','Contains Temp Dec C at 10 m-',num2str(28));
fprintf(fid,'%s\n',africatempsstr);

%% Create a Table to Store the Algeria Only Air Temp Values
AlgeriaTempsTable=table(AlgeriaTemps(:,2),AlgeriaTemps(:,3),AlgeriaTemps(:,4),AlgeriaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
AlgeriaTempsTT=table2timetable(AlgeriaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='AlgeriaTempsTable AlgeriaTempsTT';
MatFileName=strcat('AlgeriaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
algeriatempsstr=strcat('Created AlgeriaTempsTT-','Contains Temp Dec C at 10 m-',num2str(30));

%% Create a Table to Store the Chad Only Air Temp Values
ChadTempsTable=table(ChadTemps(:,2),ChadTemps(:,3),ChadTemps(:,4),ChadTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
ChadTempsTT=table2timetable(ChadTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='ChadTempsTable ChadTempsTT';
MatFileName=strcat('ChadTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
chadtempsstr=strcat('Created ChadTempsTT-','Contains Temp Dec C at 10 m-',num2str(31));

%% Create a Table to Store the Egypt Only Air Temp Values
EgyptTempsTable=table(EgyptTemps(:,2),EgyptTemps(:,3),EgyptTemps(:,4),EgyptTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
EgyptTempsTT=table2timetable(EgyptTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='EgyptTempsTable EgyptTempsTT';
MatFileName=strcat('EgyptTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
egypttempsstr=strcat('Created EgyptTempsTT-','Contains Temp Dec C at 10 m-',num2str(32));
fprintf(fid,'%s\n',egypttempsstr);

%% Create a Table to Store the Libya Only Air Temp Values
LibyaTempsTable=table(LibyaTemps(:,2),LibyaTemps(:,3),LibyaTemps(:,4),LibyaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
LibyaTempsTT=table2timetable(LibyaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='LibyaTempsTable LibyaTempsTT';
MatFileName=strcat('LibyaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
libyatempsstr=strcat('Created LibyaTempsTT-','Contains Temp Dec C at 10 m-',num2str(33));
fprintf(fid,'%s\n',libyatempsstr);
fprintf(fid,'\n');
fprintf(fid,'%s\n','----------- End Detailing Table Creation-----------');
fprintf(fid,'\n');

%% Create a Table to Store the Angola Only Air Temp Values
AngolaTempsTable=table(AngolaTemps(:,2),AngolaTemps(:,3),AngolaTemps(:,4),AngolaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
AngolaTempsTT=table2timetable(AngolaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='AngolaTempsTable AngolaTempsTT';
MatFileName=strcat('AngolaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
angolatempsstr=strcat('Created AngolaTempsTT-','Contains Temp Dec C at 10 m-',num2str(34));
fprintf(fid,'%s\n',angolatempsstr);

%% Create a Table to Store the Nigeria Only Air Temp Values
NigeriaTempsTable=table(NigeriaTemps(:,2),NigeriaTemps(:,3),NigeriaTemps(:,4),NigeriaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
NigeriaTempsTT=table2timetable(NigeriaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='NigeriaTempsTable NigeriaTempsTT';
MatFileName=strcat('NigeriaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
nigeriatempsstr=strcat('Created NigeriaTempsTT-','Contains Temp Dec C at 10 m-',num2str(35));
fprintf(fid,'%s\n',nigeriatempsstr);

%% Create a Table to Store the Kenya Only Air Temp Values
KenyaTempsTable=table(KenyaTemps(:,2),KenyaTemps(:,3),KenyaTemps(:,4),KenyaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
KenyaTempsTT=table2timetable(KenyaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='KenyaTempsTable KenyaTempsTT';
MatFileName=strcat('KenyaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
kenyatempsstr=strcat('Created KenyaTempsTT-','Contains Temp Dec C at 10 m-',num2str(36));
fprintf(fid,'%s\n',kenyatempsstr);

%% Create a Table to Store the Mozambique Only Air Temp Values
MozambiqueTempsTable=table(MozambiqueTemps(:,2),MozambiqueTemps(:,3),MozambiqueTemps(:,4),MozambiqueTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
MozambiqueTempsTT=table2timetable(MozambiqueTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='MozambiqueTempsTable MozambiqueTempsTT';
MatFileName=strcat('MozambiqueTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
mozambiquetempsstr=strcat('Created MozambiqueTempsTT-','Contains Temp Dec C at 10 m-',num2str(37));
fprintf(fid,'%s\n',mozambiquetempsstr);

%% Create a Table to Store the Ethiopia Only Air Temp Values
EthiopiaTempsTable=table(EthiopiaTemps(:,2),EthiopiaTemps(:,3),EthiopiaTemps(:,4),EthiopiaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
EthiopiaTempsTT=table2timetable(EthiopiaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='EthiopiaTempsTable EthiopiaTempsTT';
MatFileName=strcat('EthiopiaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
ethiopiatempsstr=strcat('Created EthiopiaTempsTT-','Contains Temp Dec C at 10 m-',num2str(38));
fprintf(fid,'%s\n',ethiopiatempsstr);

%% Create a Table to Store the Madagascar Only Air Temp Values
MadagascarTempsTable=table(MadagascarTemps(:,2),MadagascarTemps(:,3),MadagascarTemps(:,4),MadagascarTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
MadagascarTempsTT=table2timetable(MadagascarTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='MadagascarTempsTable MadagascarTempsTT';
MatFileName=strcat('MadagascarTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
madagascartempsstr=strcat('Created MadagascarTempsTT-','Contains Temp Dec C at 10 m-',num2str(39));
fprintf(fid,'%s\n',madagascartempsstr);

%% Create a Table to Store the SouthAfrica Only Air Temp Values
SouthAfricaTempsTable=table(SouthAfricaTemps(:,2),SouthAfricaTemps(:,3),SouthAfricaTemps(:,4),SouthAfricaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
SouthAfricaTempsTT=table2timetable(SouthAfricaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='SouthAfricaTempsTable SouthAfricaTempsTT';
MatFileName=strcat('SouthAfricaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
southafricatempsstr=strcat('Created SouthAfricaTempsTT-','Contains Temp Dec C at 10 m-',num2str(40));
fprintf(fid,'%s\n',southafricatempsstr);


%% Create a Table to Store the Congo Dem Republic Only Air Temp Values
CDRTempsTable=table(CDRTemps(:,2),CDRTemps(:,3),CDRTemps(:,4),CDRTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
CDRTempsTT=table2timetable(CDRTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='CDRTempsTable CDRTempsTT';
MatFileName=strcat('CDRTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
cdrtempsstr=strcat('Created CDRTempsTT-','Contains Temp Dec C at 10 m-',num2str(41));
fprintf(fid,'%s\n',cdrtempsstr);

%% Create a Table to Store the CAR Only Air Temp Values
CARTempsTable=table(CARTemps(:,2),CARTemps(:,3),CARTemps(:,4),CARTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
CARTempsTT=table2timetable(CARTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='CARTempsTable CARTempsTT';
MatFileName=strcat('CARTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
cartempsstr=strcat('Created CARTempsTT-','Contains Temp Dec C at 10 m-',num2str(42));
fprintf(fid,'%s\n',cartempsstr);

%% Create a Table to Store the Namibia Only Air Temp Values
NamibiaTempsTable=table(NamibiaTemps(:,2),NamibiaTemps(:,3),NamibiaTemps(:,4),NamibiaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
NamibiaTempsTT=table2timetable(NamibiaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='NamibiaTempsTable NamibiaTempsTT';
MatFileName=strcat('NamibiaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
namtempsstr=strcat('Created NamibiaTempsTT-','Contains Temp Dec C at 10 m-',num2str(43));
fprintf(fid,'%s\n',namtempsstr);

%% Create a Table to Store the Somalia Only Air Temp Values
SomaliaTempsTable=table(SomaliaTemps(:,2),SomaliaTemps(:,3),SomaliaTemps(:,4),SomaliaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
SomaliaTempsTT=table2timetable(SomaliaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='SomaliaTempsTable SomaliaTempsTT';
MatFileName=strcat('SomaliaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
somtempsstr=strcat('Created SomaliaTempsTT-','Contains Temp Dec C at 10 m-',num2str(44));
fprintf(fid,'%s\n',somtempsstr);

%% Create a Table to Store the Sudan Only Air Temp Values
SudanTempsTable=table(SudanTemps(:,2),SudanTemps(:,3),SudanTemps(:,4),SudanTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
SudanTempsTT=table2timetable(SudanTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='SudanTempsTable SudanTempsTT';
MatFileName=strcat('SudanTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
sudantempsstr=strcat('Created SudanTempsTT-','Contains Temp Dec C at 10 m-',num2str(45));
fprintf(fid,'%s\n',sudantempsstr);

%% Create a Table to Store the Saudi Only Air Temp Values
SaudiTempsTable=table(SaudiTemps(:,2),SaudiTemps(:,3),SaudiTemps(:,4),SaudiTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
SaudiTempsTT=table2timetable(SaudiTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='SaudiTempsTable SaudiTempsTT';
MatFileName=strcat('SaudiTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
sauditempsstr=strcat('Created SaudiTempsTT-','Contains Temp Dec C at 10 m-',num2str(46));
fprintf(fid,'%s\n',sauditempsstr);

%% Create a Table to Store the Iran Only Air Temp Values
IranTempsTable=table(IranTemps(:,2),IranTemps(:,3),IranTemps(:,4),IranTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
IranTempsTT=table2timetable(IranTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='IranTempsTable IranTempsTT';
MatFileName=strcat('IranTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
irantempsstr=strcat('Created IranTempsTT-','Contains Temp Dec C at 10 m-',num2str(47));
fprintf(fid,'%s\n',irantempsstr);

%% Create a Table to Store the  Iraq Only Air Temp Values
IraqTempsTable=table(IraqTemps(:,2),IraqTemps(:,3),IraqTemps(:,4),IraqTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
IraqTempsTT=table2timetable(IraqTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='IraqTempsTable IraqTempsTT';
MatFileName=strcat('IraqTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
iraqtempsstr=strcat('Created IraqTempsTT-','Contains Temp Dec C at 10 m-',num2str(48));
fprintf(fid,'%s\n',iraqtempsstr);


%% Create a Table to Store the Jordan Only Air Temp Values
JordanTempsTable=table(JordanTemps(:,2),JordanTemps(:,3),JordanTemps(:,4),JordanTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
JordanTempsTT=table2timetable(JordanTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='JordanTempsTable JordanTempsTT';
MatFileName=strcat('JordanTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
jordantempsstr=strcat('Created JordanTempsTT-','Contains Temp Dec C at 10 m-',num2str(49));
fprintf(fid,'%s\n',jordantempsstr);

%% Create a Table to Store the Syria Only Air Temp Values
SyriaTempsTable=table(SyriaTemps(:,2),SyriaTemps(:,3),SyriaTemps(:,4),SyriaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
SyriaTempsTT=table2timetable(SyriaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='SyriaTempsTable SyriaTempsTT';
MatFileName=strcat('SyriaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
syriatempsstr=strcat('Created SyriaTempsTT-','Contains Temp Dec C at 10 m-',num2str(50));
fprintf(fid,'%s\n',syriatempsstr);

%% Create a Table to Store the Turkey Only Air Temp Values
TurkeyTempsTable=table(TurkeyTemps(:,2),TurkeyTemps(:,3),TurkeyTemps(:,4),TurkeyTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
TurkeyTempsTT=table2timetable(TurkeyTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='TurkeyTempsTable TurkeyTempsTT';
MatFileName=strcat('TurkeyTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
turkeytempsstr=strcat('Created TurkeyTempsTT-','Contains Temp Dec C at 10 m-',num2str(51));
fprintf(fid,'%s\n',turkeytempsstr);

%% Create a Table to Store the Pakistan Only Air Temp Values
PakistanTempsTable=table(PakistanTemps(:,2),PakistanTemps(:,3),PakistanTemps(:,4),PakistanTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
PakistanTempsTT=table2timetable(PakistanTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='PakistanTempsTable PakistanTempsTT';
MatFileName=strcat('PakistanTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
paktempsstr=strcat('Created PakistanTempsTT-','Contains Temp Dec C at 10 m-',num2str(52));
fprintf(fid,'%s\n',paktempsstr);

%% Create a Table to Store the Afganistan Only Air Temp Values
AfganistanTempsTable=table(AfganistanTemps(:,2),AfganistanTemps(:,3),AfganistanTemps(:,4),AfganistanTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
AfganistanTempsTT=table2timetable(AfganistanTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='AfganistanTempsTable AfganistanTempsTT';
MatFileName=strcat('AfganistanTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
afgantempsstr=strcat('Created AfganistanTempsTT-','Contains Temp Dec C at 10 m-',num2str(33));
fprintf(fid,'%s\n',afgantempsstr);
%% Create a Table to Store the India Only Air Temp Values
IndiaTempsTable=table(IndiaTemps(:,2),IndiaTemps(:,3),IndiaTemps(:,4),IndiaTemps(:,5),...
        'VariableNames',{'Ptile25','Ptile50','Ptile75','Ptile99'});
IndiaTempsTT=table2timetable(IndiaTempsTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='IndiaTempsTable IndiaTempsTT';
MatFileName=strcat('IndiaTempsTable',YearMonthStr,TimeStr,'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
indiatempsstr=strcat('Created IndiaTempsTT-','Contains Temp Dec C at 10 m-',num2str(33));
fprintf(fid,'%s\n',indiatempsstr);
fprintf(fid,'\n');
fprintf(fid,'%s\n','----------- End Detailing Table Creation-----------');
fprintf(fid,'\n');

%% Plot the Sea Ice Latent Flux
titlestr=strcat('Hourly-Sea-Ice-LatentFlux-',num2str(yd));
ikind=1;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Sea Ice Latent Flux
titlestr=strcat('Hourly-OpenWaterLatentFlux-',num2str(yd));
ikind=2;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice Fraction
titlestr=strcat('Hourly-SeaIceFraction-',num2str(yd));
ikind=3;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice Area in Sq Km
titlestr=strcat('Hourly-SeaIceFraction-',num2str(yd));
ikind=4;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice Upward Heat Flux
titlestr=strcat('Hourly-SeaIce-UpHeat',num2str(yd));
ikind=5;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Open Water Upward Heat Flux
titlestr=strcat('Hourly-OpenWater-UpHeat',num2str(yd));
ikind=6;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice Downwards Flux
titlestr=strcat('Hourly-SeaIce-DownHeat',num2str(yd));
ikind=7;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Open Waters Downwards Flux
titlestr=strcat('Hourly-OpenWaters-DownHeat',num2str(yd));
ikind=8;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 M
titlestr=strcat('Hourly-AirTemp-10M',num2str(yd));
ikind=9;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice Skin Temps
titlestr=strcat('Hourly-SeaIce-SkinTemp',num2str(yd));
ikind=11;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Open Water Skin Temps
titlestr=strcat('Hourly-OpenWater-SkinTemp',num2str(yd));
ikind=12;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice SW Downward Flux Skin 
titlestr=strcat('Hourly-SeaIce-SWDownFlux',num2str(yd));
ikind=13;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Open Water SW Downward Flux Skin 
titlestr=strcat('Hourly-OpenWater-SWDownFlux',num2str(yd));
ikind=14;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice Eastwind Stress
titlestr=strcat('Hourly-Sea-Ice-EastWindStress',num2str(yd));
ikind=15;
iAddToReport=0;
iNewChapter=0;
iCloseChapter=0;
PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the OPen Water Eastwind Stress
   titlestr=strcat('Hourly-OpenWater-EastWindStress',num2str(yd));
   ikind=16;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Sea Ice Eastwind Stress
   titlestr=strcat('Hourly-Sea-Ice-NorthWindStress',num2str(yd));
   ikind=17;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Open Water Eastwind Stress
   titlestr=strcat('Hourly-OpenWater-NorthWindStress',num2str(yd));
   ikind=18;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Ocean Rainfall Rate
   titlestr=strcat('Hourly-Ocean-RainfallRate',num2str(yd));
   ikind=20;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Snow Rainfall Rate
   titlestr=strcat('Hourly-Ocean-SnowfallRate',num2str(yd));
   ikind=21;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Rain Total for 24 hours
   titlestr=strcat('Hourly-Ocean-Rain24Total',num2str(yd));
   ikind=22;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  %% Plot the Snow Total for 24 hours
   titlestr=strcat('Hourly-Ocean-Snow24Total',num2str(yd));
   ikind=23;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  %% Plot the East Wind Magnitude at 10 meters
   titlestr=strcat('Hourly-EastWind-10m',num2str(yd));
   ikind=25;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  %% Plot the North Wind Magnitude at 10 meters
   titlestr=strcat('Hourly-NorthWind-10m',num2str(yd));
   ikind=26;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Specific Humidity at 10 meters
   titlestr=strcat('Hourly-QV-10m',num2str(yd));
   ikind=27;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('AfricaAirTemp-10m',num2str(yd));
   ikind=40;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('AlgeriaAirTemp-10m',num2str(yd));
   ikind=41;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('ChadAirTemp-10m',num2str(yd));
   ikind=42;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('EgyptAirTemp-10m',num2str(yd));
   ikind=43;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('LibyaAirTemp-10m',num2str(yd));
   ikind=44;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('AngolaAirTemp-10m',num2str(yd));
   ikind=45;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('NigeriaAirTemp-10m',num2str(yd));
   ikind=46;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('KenyaAirTemp-10m',num2str(yd));
   ikind=47;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('MozambiqueAirTemp-10m',num2str(yd));
   ikind=48;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('EthiopiaAirTemp-10m',num2str(yd));
   ikind=49;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('MadagascarAirTemp-10m',num2str(yd));
   ikind=50;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('SouthAgricaAirTemp-10m',num2str(yd));
   ikind=51;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('CDRAirTemp-10m',num2str(yd));
   ikind=52;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('CARAirTemp-10m',num2str(yd));
   ikind=53;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('NamibiaAirTemp-10m',num2str(yd));
   ikind=54;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('SomaliaAirTemp-10m',num2str(yd));
   ikind=55;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('SudanAirTemp-10m',num2str(yd));
   ikind=56;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('SaudiAirTemp-10m',num2str(yd));
   ikind=57;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('IranAirTemp-10m',num2str(yd));
   ikind=58;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('IraqAirTemp-10m',num2str(yd));
   ikind=59;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('JordanAirTemp-10m',num2str(yd));
   ikind=60;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('SyriaAirTemp-10m',num2str(yd));
   ikind=61;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('TurkeyAirTemp-10m',num2str(yd));
   ikind=62;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('PakistanAirTemp-10m',num2str(yd));
   ikind=63;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('AfganistanAirTemp-10m',num2str(yd));
   ikind=64;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Air Temp at 10 meters for a specific Region
   titlestr=strcat('IndiaAirTemp-10m',num2str(yd));
   ikind=65;
   iAddToReport=0;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset04RegionalTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
end

end

