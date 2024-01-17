function ReadDataset04()
% Modified: This function will read in the the Merra-2 data set called 04
% which is cloud opacity
% Written By: Stephen Forczyk
% Created: Aug 4,2022
% Revised: Aug 5,2022 added more decoded variables
% Revised: Aug 8,2022 added more decoded variables
% Revised: Aug 9,2022 added more decoded variables and plots for decoded
% variables
% Revised: Aug 10,2022 added plots for decoded variables
% Revised: Aug 14,2022 continued to add plots for decoded variables
% Classification: Unclassified

global BandDataS MetaDataS;

global Merra2FileName Merra2ShortFileName Merra2Dat;

global idebug;
global LonS LatS TimeS ;
global YearMonthDayStr1 YearMonthDayStr2;
global AlbedoS ALBNIRDFS ALBNIRDRS ALBVISDFS ALBVISDRS;
global CLDHGHS CLDLOWS CLDMIDS CLDTOTS;
global VarCLDHGHS VarCLDLOWS VarCLDMIDS VarCLDTOTS;
global EMISS LWGABS LWGABCLRS LWGABCLRCLNS LWTUPS;
global VarEMISS;
global LWGEMS LWGNTS LWGNTCLRS LWGNTCLRCLNS LWTUPCLRS LWTUPCLRCLNS;
global SWGDNS SWGDNCLRS SWGNTS SWGNTCLNS SWGNTCLRS SWGNTCLRCLNS;
global SWTDNS SWTNTS SWTNTCLNS SWTNTCLRS SWTNTCLRCLNS;
global TAUHGHS TAULOWS TAUMIDS TAUTOTS TSS;
global VarALBEDOS VarALBNIRDFS VarALBNIRDRS VarALBVISDFS;
global VarALBVISDRS;
global ChoiceList;
% additional paths needed for mapping
global matpath1 mappath GOES16path;
global jpegpath savepath;

global fid isavefiles;

ChoiceList=cell(1,1);
ChoiceList{1,1}='ALBEDO-surface-albedo';
ChoiceList{2,1}='ALBNIRDFS-surface-albedo-nir-diffuse';
ChoiceList{3,1}='ALBNIRDRS-surface-albedo-nir-beam';
ChoiceList{4,1}='ALBVISDFS-surface-vis-diffuse';
ChoiceList{5,1}='ALBVISDRS-surface-vis-beam';
ChoiceList{6,1}='CLDHGHS-cloudarea-fraction-highclouds';
ChoiceList{7,1}='CLDLOWS-cloudarea-fraction-lowclouds';
ChoiceList{8,1}='CLDMIDS-cloudarea-fraction-midclouds';
ChoiceList{9,1}='CLDTOTS-cloudarea-fraction-totclouds';
ChoiceList{10,1}='EMISS-surface emissivity';
ChoiceList{11,1}='LWGAB-surface absorbed LWIR Rad';
ChoiceList{12,1}='LWGABCLR-surface absorbed LWIR Rad-ClearSky';
ChoiceList{13,1}='LWGABCLRCLN-surface absorbed LWIR Rad-ClearSky/NoAerosol';
ChoiceList{14,1}='LWGEM-longwave_flux_emitted_from_surface';
ChoiceList{15,1}='LWGNT-surface_net_downward_longwave_flux';
ChoiceList{16,1}='LWGNTCLR-surface_net_downward_longwave_flux-clear';
ChoiceList{17,1}='LWGNTCLRCLN-surface_net_downward_longwave_flux-clear-noaero';
ChoiceList{18,1}='LWTUP-LWIR Flux At TOA';
ChoiceList{19,1}='LWTUPCLR-LWIR Flux At TOA Clear Sky';
ChoiceList{20,1}='LWTUPCLR-LWIR Flux At TOA Clear Sky/No Aero';
ChoiceList{21,1}='SWGDN-Surface SWIR Incoming Flux';
ChoiceList{22,1}='SWGDNCLR-Surface SWIR Incoming Flux Clear Sky';
ChoiceList{23,1}='SWGNT-surface net downward shortwave flux';
ChoiceList{24,1}='SWGNTCLN-surface net downward shortwave flux no/aerosol';
ChoiceList{25,1}='SWGNTCLN-surface net downward shortwave flux no/aerosol Clr Sky';
ChoiceList{26,1}='SWTDNS-TOA-incoming-SWIR-flux';
ChoiceList{27,1}='SWTNTS-TOA-Net-Downward-flux';
ChoiceList{28,1}='SWTNTCLN-TOA-Net-Downward-NoAero-flux';
ChoiceList{29,1}='SWTNTCLR-TOA-Net-Downward-ClearSky-flux';
ChoiceList{30,1}='SWTNTCLRCLN-TOA-Net-Downward-Flux-ClrSkyNoAero';
ChoiceList{31,1}='TAUHGH-cloud-optical-thickness-highclouds';
ChoiceList{32,1}='TAUHGH-cloud-optical-thickness-lowclouds';
ChoiceList{33,1}='TAUHGH-cloud-optical-thickness-midclouds';
ChoiceList{34,1}='TAUHGH-cloud-optical-thickness-midclouds';
ChoiceList{35,1}='Surface-Temp-TSkin';
ChoiceList{36,1}='VarAlbedo-variance in albedo';
ChoiceList{37,1}='VarALBNIRDF-variance surface-albedo-nir-diffuse';
ChoiceList{38,1}='VarALBNIRDR-variance surface-albedo-nir-beam';
ChoiceList{39,1}='VarALBVISDF-variance surface-albedo-vis-diffuse';
ChoiceList{40,1}='VarALBVISDR-variance surface-albedo-vis-beam';
ChoiceList{41,1}='VarCLDHGH-variance in cloud fraction-high clouds';
ChoiceList{42,1}='VarCLDLOW-variance in cloud fraction-low clouds';
ChoiceList{43,1}='VarCLDMID-variance in cloud fraction-mid clouds';
ChoiceList{44,1}='VarCLDTOT-variance in cloud fraction-total clouds';
ChoiceList{45,1}='VarEMIS-variance in surface emissivity';
fprintf(fid,'\n');
fprintf(fid,'%s\n','**************Start reading dataset 04 data***************');

[nc_filenamesuf,path]=uigetfile('*nc4','Select One Data File');% SMF Modification
GOESFileName=nc_filenamesuf;
Merra2FileName=RemoveUnderScores(GOESFileName);
nc_filename=strcat(path,nc_filenamesuf);
ncid=netcdf.open(nc_filename,'nowrite');
openfilestr=strcat('Opening file-',Merra2FileName,'-for reading');
fprintf(fid,'%s\n',openfilestr);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);


LonS=struct('values',[],'long_name',[],'units',[],'vmax',[],'vmin',[],'valid_range',[]);
LatS=LonS;
TimeS=struct('values',[],'long_name',[],'units',[],'time_increment',[],...
    'begin_date',[],'begin_time',[],'vmax',[],'vmin',[],'valid_range',[]);
AlbedoS=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'vmax',[],'vmin',[],'valid_range',[]);
ALBNIRDFS=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'vmax',[],...
    'vmin',[],'valid_range',[]);
ALBNIRDRS=ALBNIRDFS;
ALBVISDFS=ALBNIRDFS;
ALBVISDRS=ALBNIRDFS;
CLDHGHS=ALBNIRDFS;
CLDLOWS=CLDHGHS;
CLDMIDS=CLDHGHS;
CLDTOTS=CLDHGHS;
EMISS=CLDHGHS;
LWGABS=CLDHGHS;
LWGABCLRS=CLDHGHS;
LWGABCLRCLNS=CLDHGHS;
LWTUPS=CLDHGHS;
LWGNTCLRS=CLDHGHS;
LWGNTS=CLDHGHS;
LWGNTCLRCLNS=CLDHGHS;
LWTUPCLRS=CLDHGHS;
LWTUPCLRCLNS=CLDHGHS;
SWGDNS=CLDHGHS;
SWGDNCLRS=CLDHGHS;
SWGNTS=CLDHGHS;
SWGNTCLNS=CLDHGHS;
SWGNTCLRS=CLDHGHS;
SWGNTCLRCLNS=CLDHGHS;
SWTDNS=CLDHGHS;
SWTNTS=CLDHGHS;
SWTNTCLNS=CLDHGHS;
SWTNTCLRS=CLDHGHS;
SWTNTCLRCLNS=CLDHGHS;
TAUHGHS=CLDHGHS;
TAULOWS=CLDHGHS;
TAUMIDS=CLDHGHS;
TAUTOTS=CLDHGHS;
TSS=CLDHGHS;
VarALBEDOS=CLDHGHS;
VarALBNIRDFS=CLDHGHS;
VarALBNIRDRS=CLDHGHS;
VarALBVISDRS=CLDHGHS;
VarCLDHGHS=CLDHGHS;
VarCLDLOWS=CLDHGHS;
VarCLDMIDS=CLDHGHS;
VarCLDTOTS=CLDHGHS;
VarEMISS=CLDHGHS;
% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
numvarstr=strcat('The number of variables read from the Cloud Top Data file=',num2str(numvars));
fprintf(fid,'%s\n',numvarstr);
    
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
       a10=strcmp(varname,'lon');
       a20=strcmp(varname,'lat');
       a30=strcmp(varname,'time');
       a40=strcmp(varname,'ALBEDO');
       a50=strcmp(varname,'ALBNIRDF');
       a60=strcmp(varname,'ALBNIRDR');
       a70=strcmp(varname,'ALBVISDF');
       a80=strcmp(varname,'ALBVISDR');
       a90=strcmp(varname,'CLDHGH');
       a100=strcmp(varname,'CLDLOW');
       a110=strcmp(varname,'CLDMID');
       a120=strcmp(varname,'CLDTOT');
       a130=strcmp(varname,'EMIS');
       a140=strcmp(varname,'LWGAB');
       a150=strcmp(varname,'LWGABCLR');
       a160=strcmp(varname,'LWGABCLRCLN');
       a170=strcmp(varname,'LWGEM');
       a180=strcmp(varname,'LWGNT');
       a190=strcmp(varname,'LWGNTCLR');
       a200=strcmp(varname,'LWGNTCLRCLN');
       a210=strcmp(varname,'LWTUP');
       a220=strcmp(varname,'SWGDN');
       a230=strcmp(varname,'SWGDNCLR');
       a240=strcmp(varname,'SWGNTCLN');
       a250=strcmp(varname,'SWGNTCLR');
       a260=strcmp(varname,'SWGNTCLRCLN');
       a270=strcmp(varname,'SWTDN');
       a280=strcmp(varname,'SWTNT');
       a290=strcmp(varname,'SWTNTCLN');
       a300=strcmp(varname,'SWTNTCLR');
       a310=strcmp(varname,'SWTNTCLRCLN');
       a340=strcmp(varname,'TAUHGH');
       a350=strcmp(varname,'TAULOW');
       a360=strcmp(varname,'TAUMID');
       a370=strcmp(varname,'TAUTOT');
       a380=strcmp(varname,'TS');
       a390=strcmp(varname,'LWTUPCLR');
       a400=strcmp(varname,'LWTUPCLRCLN');
       a410=strcmp(varname,'SWGNT');
       a420=strcmp(varname,'Var_ALBEDO');
       a430=strcmp(varname,'Var_ALBNIRDF');
       a440=strcmp(varname,'Var_ALBNIRDR');
       a450=strcmp(varname,'Var_ALBVISDF');
       a460=strcmp(varname,'Var_ALBVISDR');
       a470=strcmp(varname,'Var_CLDHGH');
       a480=strcmp(varname,'Var_CLDLOW');
       a490=strcmp(varname,'Var_CLDMID');
       a500=strcmp(varname,'Var_CLDTOT');
       a510=strcmp(varname,'Var_EMIS');
       if (a10==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
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
        elseif (a20==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
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
        elseif (a30==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
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
       elseif (a40==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                AlbedoS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                AlbedoS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                AlbedoS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                AlbedoS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                AlbedoS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                AlbedoS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                AlbedoS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                AlbedoS.valid_range=attname2;
            end
        elseif (a50==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                ALBNIRDFS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                ALBNIRDFS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                ALBNIRDFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                ALBNIRDFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                ALBNIRDFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                ALBNIRDFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                ALBNIRDFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                ALBNIRDFS.valid_range=attname2;
            end
        elseif (a60==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                ALBNIRDRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                ALBNIRDRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                ALBNIRDRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                ALBNIRDRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                ALBNIRDRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                ALBNIRDRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                ALBNIRDRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                ALBNIRDRS.valid_range=attname2;
            end
        elseif (a70==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                ALBVISDFS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                ALBVISDFS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                ALBVISDFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                ALBVISDFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                ALBVISDFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                ALBVISDFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                ALBVISDFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                ALBVISDFS.valid_range=attname2;
            end
        elseif (a80==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                ALBVISDRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                ALBVISDRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                ALBVISDRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                ALBVISDRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                ALBVISDRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                ALBVISDRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                ALBVISDRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                ALBVISDRS.valid_range=attname2;
            end
        elseif (a90==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                CLDHGHS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                CLDHGHS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                CLDHGHS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                CLDHGHS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                CLDHGHS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                CLDHGHS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                CLDHGHS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                CLDHGHS.valid_range=attname2;
            end
        elseif (a100==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                CLDLOWS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                CLDLOWS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                CLDLOWS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                CLDLOWS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                CLDLOWS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                CLDLOWS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                CLDLOWS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                CLDLOWS.valid_range=attname2;
            end
        elseif (a110==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                CLDMIDS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                CLDMIDS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                CLDMIDS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                CLDMIDS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                CLDMIDS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                CLDMIDS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                CLDMIDS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                CLDMIDS.valid_range=attname2;
            end
        elseif (a120==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                CLDTOTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                CLDTOTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                CLDTOTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                CLDTOTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                CLDTOTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                CLDTOTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                CLDTOTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                CLDTOTS.valid_range=attname2;
            end
        elseif (a130==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                EMISS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                EMISS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                EMISS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                EMISS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                EMISS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                EMISS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                EMISS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                EMISS.valid_range=attname2;
            end
        elseif (a140==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGABS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGABS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGABS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGABS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGABS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGABS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGABS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGABS.valid_range=attname2;
            end
        elseif (a150==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGABCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGABCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGABCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGABCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGABCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGABCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGABCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGABCLRS.valid_range=attname2;
            end
        elseif (a160==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGABCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGABCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGABCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGABCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGABCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGABCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGABCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGABCLRCLNS.valid_range=attname2;
            end
        elseif (a170==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGEMS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGEMS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGEMS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGEMS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGEMS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGEMS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGEMS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGEMS.valid_range=attname2;
            end
        elseif (a180==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGNTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGNTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGNTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGNTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGNTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGNTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGNTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGNTS.valid_range=attname2;
            end
        elseif (a190==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGNTCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGNTCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGNTCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGNTCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGNTCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGNTCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGNTCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGNTCLRS.valid_range=attname2;
            end
        elseif (a200==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWGNTCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWGNTCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWGNTCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWGNTCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWGNTCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWGNTCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWGNTCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWGNTCLRCLNS.valid_range=attname2;
            end
        elseif (a210==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWTUPS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWTUPS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWTUPS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWTUPS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWTUPS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWTUPS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWTUPS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWTUPS.valid_range=attname2;
            end
        elseif (a220==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGDNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGDNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGDNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGDNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGDNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGDNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGDNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGDNS.valid_range=attname2;
            end
        elseif (a230==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGDNCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGDNCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGDNCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGDNCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGDNCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGDNCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGDNCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGDNCLRS.valid_range=attname2;
            end
        elseif (a240==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGNTCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGNTCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGNTCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGNTCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGNTCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGNTCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGNTCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGNTCLNS.valid_range=attname2;
            end
        elseif (a250==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGNTCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGNTCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGNTCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGNTCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGNTCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGNTCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGNTCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGNTCLRS.valid_range=attname2;
            end
        elseif (a260==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGNTCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGNTCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGNTCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGNTCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGNTCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGNTCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGNTCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGNTCLRCLNS.valid_range=attname2;
            end
        elseif (a270==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWTDNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWTDNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWTDNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWTDNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWTDNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWTDNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWTDNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWTDNS.valid_range=attname2;
            end
        elseif (a280==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWTNTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWTNTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWTNTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWTNTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWTNTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWTNTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWTNTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWTNTS.valid_range=attname2;
            end
        elseif (a290==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWTNTCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWTNTCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWTNTCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWTNTCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWTNTCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWTNTCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWTNTCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWTNTCLNS.valid_range=attname2;
            end
        elseif (a300==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWTNTCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWTNTCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWTNTCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWTNTCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWTNTCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWTNTCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWTNTCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWTNTCLRS.valid_range=attname2;
            end
        elseif (a310==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWTNTCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWTNTCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWTNTCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWTNTCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWTNTCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWTNTCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWTNTCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWTNTCLRCLNS.valid_range=attname2;
            end 
        elseif (a340==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAUHGHS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                TAUHGHS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAUHGHS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAUHGHS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAUHGHS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAUHGHS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAUHGHS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAUHGHS.valid_range=attname2;
            end 
        elseif (a350==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAULOWS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                TAULOWS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAULOWS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAULOWS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAULOWS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAULOWS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAULOWS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAULOWS.valid_range=attname2;
            end
        elseif (a360==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAUMIDS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                TAUMIDS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAUMIDS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAUMIDS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAUMIDS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAUMIDS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAUMIDS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAUMIDS.valid_range=attname2;
            end 
        elseif (a370==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TAUTOTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                TAUTOTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TAUTOTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TAUTOTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TAUTOTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TAUTOTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TAUTOTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TAUTOTS.valid_range=attname2;
            end 
        elseif (a380==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TSS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                TSS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TSS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TSS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TSS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TSS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TSS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TSS.valid_range=attname2;
            end 
        elseif (a390==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWTUPCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWTUPCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWTUPCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWTUPCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWTUPCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWTUPCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWTUPCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWTUPCLRS.valid_range=attname2;
            end
        elseif (a400==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LWTUPCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LWTUPCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                LWTUPCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                LWTUPCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                LWTUPCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LWTUPCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LWTUPCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LWTUPCLRCLNS.valid_range=attname2;
            end
        elseif (a410==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SWGNTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SWGNTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SWGNTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SWGNTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SWGNTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SWGNTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SWGNTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SWGNTS.valid_range=attname2;
            end
        elseif (a420==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarALBEDOS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarALBEDOS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarALBEDOS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarALBEDOS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarALBEDOS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarALBEDOS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarALBEDOS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarALBEDOS.valid_range=attname2;
            end
        elseif (a430==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarALBNIRDFS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarALBNIRDFS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarALBNIRDFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarALBNIRDFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarALBNIRDFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarALBNIRDFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarALBNIRDFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarALBNIRDFS.valid_range=attname2;
            end
        elseif (a440==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarALBNIRDRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarALBNIRDRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarALBNIRDRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarALBNIRDRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarALBNIRDRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarALBNIRDRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarALBNIRDRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarALBNIRDRS.valid_range=attname2;
            end
        elseif (a450==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarALBVISDFS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarALBVISDFS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarALBVISDFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarALBVISDFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarALBVISDFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarALBVISDFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarALBVISDFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarALBVISDFS.valid_range=attname2;
            end
        elseif (a460==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarALBVISDRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarALBVISDRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarALBVISDRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarALBVISDRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarALBVISDRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarALBVISDRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarALBVISDRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarALBVISDRS.valid_range=attname2;
            end
        elseif (a470==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarCLDHGHS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarCLDHGHS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarCLDHGHS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarCLDHGHS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarCLDHGHS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarCLDHGHS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarCLDHGHS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarCLDHGHS.valid_range=attname2;
            end
        elseif (a480==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarCLDLOWS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarCLDLOWS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarCLDLOWS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarCLDLOWS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarCLDLOWS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarCLDLOWS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarCLDLOWS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarCLDLOWS.valid_range=attname2;
            end
         elseif (a490==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarCLDMIDS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarCLDMIDS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarCLDMIDS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarCLDMIDS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarCLDMIDS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarCLDMIDS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarCLDMIDS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarCLDMIDS.valid_range=attname2;
            end 
         elseif (a500==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarCLDTOTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarCLDTOTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarCLDTOTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarCLDTOTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarCLDTOTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarCLDTOTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarCLDTOTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarCLDTOTS.valid_range=attname2;
            end 
            
         elseif (a510==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                VarEMISS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VarEMISS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VarEMISS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VarEMISS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VarEMISS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VarEMISS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VarEMISS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VarEMISS.valid_range=attname2;
            end       
        end
    end
    if(idebug==1)
        disp(' ')
    end
    
    if flag
        if(varname=='AIRX3STD_006_RelHumid_AS')
            eval([varname '=( double(double(netcdf.getVar(ncid,i))-0));'])
            FillValue=AIRX3STD_006_RelHumid_AS.FillValue;
            CT=AIRX3STD_006_RelHumid_AS;
            [CT,numnanvals] = ReplaceFillValues(CT,FillValue);
               [nrows,ncols]=size(CT);
               level=(2^15)-1;
               for ik=1:nrows
                   for jk=1:ncols
                      value=CT(ik,jk);
                      if(value<0)
                           diff=level-abs(value);
                           corval=level+diff;
                           CT(ik,jk)=corval;
                      end
                   end
               end
               CTT=CT;
               scale2=double(scale);
               offset2=double(offset);
               CTT2=CTT'*scale2+offset2;
               AIRX3STD_006_RelHumid_AS.values=CTT2;
               clear CT
               ab=1;
        end

    else
        eval([varname '= double(netcdf.getVar(ncid,i));'])   
        if(a10==1)
            LonS.values=lon;
        end
        if(a20==1)
            LatS.values=lat;
        end
        if(a30==1)
            TimeS.values=time;
        end
        if(a40==1)
            AlbedoS.values=ALBEDO;
        end
        if(a50==1)
            ALBNIRDFS.values=ALBNIRDF;
        end
        if(a60==1)
            ALBNIRDRS.values=ALBNIRDR;
        end
        if(a70==1)
            ALBVISDFS.values=ALBVISDF;
        end
        if(a80==1)
            ALBVISDRS.values=ALBVISDR;
        end
        if(a90==1)
            CLDHGHS.values=CLDHGH;
        end
        if(a100==1)
            CLDLOWS.values=CLDLOW;
        end
        if(a110==1)
            CLDMIDS.values=CLDMID;
        end
        if(a120==1)
            CLDTOTS.values=CLDTOT;
        end
        if(a130==1)
            EMISS.values=EMIS;
        end
        if(a140==1)
            LWGABS.values=LWGAB;
        end
        if(a150==1)
            LWGABCLRS.values=LWGABCLR;
        end
        if(a160==1)
            LWGABCLRCLNS.values=LWGABCLRCLN;
        end
        if(a170==1)
            LWGEMS.values=LWGEM;
        end
        if(a180==1)
            LWGNTS.values=LWGNT;
        end
        if(a190==1)
            LWGNTCLRS.values=LWGNTCLR;
        end
        if(a200==1)
            LWGNTCLRCLNS.values=LWGNTCLRCLN;
        end
        if(a210==1)
            LWTUPS.values=LWTUP;
        end
        if(a220==1)
            SWGDNS.values=SWGDN;
        end
        if(a230==1)
            SWGDNCLRS.values=SWGDNCLR;
        end
        if(a240==1)
            SWGNTCLNS.values=SWGNTCLN;
        end
        if(a250==1)
            SWGNTCLRS.values=SWGNTCLR;
        end
        if(a260==1)
            SWGNTCLRCLNS.values=SWGNTCLRCLN;
        end
        if(a270==1)
            SWTDNS.values=SWTDN;
        end
        if(a280==1)
            SWTNTS.values=SWTNT;
        end
        if(a290==1)
            SWTNTCLNS.values=SWTNTCLN;
        end
        if(a300==1)
            SWTNTCLRS.values=SWTNTCLR;
        end
        if(a310==1)
            SWTNTCLRCLNS.values=SWTNTCLRCLN;
        end
        if(a340==1)
            TAUHGHS.values=TAUHGH;
        end
        if(a350==1)
            TAULOWS.values=TAULOW;
        end
        if(a360==1)
            TAUMIDS.values=TAUMID;
        end
        if(a370==1)
            TAUTOTS.values=TAUTOT;
        end
        if(a380==1)
            TSS.values=TS;
        end
        if(a390==1)
            LWTUPCLRS.values=LWTUPCLR;
        end
        if(a400==1)
            LWTUPCLRCLNS.values=LWTUPCLRCLN;
        end
        if(a410==1)
            SWGNTS.values=SWGNT;
        end
        if(a420==1)
            VarALBEDOS.values=Var_ALBEDO;
        end
        if(a430==1)
            VarALBNIRDFS.values=Var_ALBNIRDF;
        end
        if(a440==1)
            VarALBNIRDRS.values=Var_ALBNIRDR;
        end
        if(a450==1)
            VarALBVISDFS.values=Var_ALBVISDF;
        end
        if(a460==1)
            VarALBVISDRS.values=Var_ALBVISDR;
        end
        if(a470==1)
            VarCLDHGHS.values=Var_CLDHGH;
        end
        if(a480==1)
            VarCLDLOWS.values=Var_CLDLOW;
        end
        if(a490==1)
            VarCLDMIDS.values=Var_CLDMID;
        end
        if(a500==1)
            VarCLDTOTS.values=Var_CLDTOT;
        end
        if(a510==1)
            VarEMISS.values=Var_EMIS;
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
    savestr=strcat('Saved Decode Data to File=',MatFileName);
    fprintf(fid,'%s\n',savestr);
    disp(savestr)
else
    dispstr=strcat('Did Not save Decided Data to File-',MatFileName);
    disp(dispstr);
    fprintf(fid,'%s\n',dispstr);
end
% Make a variable selection from the list
[indx2,~] = listdlg('PromptString',{'Select type of data to plot'},...
'SelectionMode','single','ListString',ChoiceList,'ListSize',[480,700]);
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
% Display the selected variable on the correct plot
if(indx2==1) %Ok
    titlestr=strcat('SurfaceAlbedo-',Merra2ShortFileName);
    ikind=1;
    DisplayMerra2Albedo(ikind,titlestr)   
end
if(indx2==2) %Ok
    titlestr=strcat('SurfaceAlbedo-Diffuse-NIR-',Merra2ShortFileName);
    ikind=2;
    DisplayMerra2Albedo(ikind,titlestr)      
end
if(indx2==3)%Ok
    titlestr=strcat('SurfaceAlbedo-Beam-NIR-',Merra2ShortFileName);
    ikind=3;
    DisplayMerra2Albedo(ikind,titlestr)      
end
if(indx2==4)%Ok
    titlestr=strcat('SurfaceAlbedo-Diffuse-VIS-',Merra2ShortFileName);
    ikind=4;
    DisplayMerra2Albedo(ikind,titlestr)      
end
if(indx2==5)%Ok
    titlestr=strcat('SurfaceAlbedo-Beam-VIS-',Merra2ShortFileName);
    ikind=5;
    DisplayMerra2Albedo(ikind,titlestr)      
end
if(indx2==6)%Ok
    titlestr=strcat('CloudAreaFrac-HighClouds-',Merra2ShortFileName);
    ikind=1;
    DisplayMerra2CLDHGHS(ikind,titlestr)
end
if(indx2==7)%Ok
    titlestr=strcat('CloudAreaFrac-LowClouds-',Merra2ShortFileName);
    ikind=2;
    DisplayMerra2CLDHGHS(ikind,titlestr)
end
if(indx2==8)%Ok
    titlestr=strcat('CloudAreaFrac-MidClouds-',Merra2ShortFileName);
    ikind=3;
    DisplayMerra2CLDHGHS(ikind,titlestr)
end
if(indx2==9)%Ok
    titlestr=strcat('CloudAreaFrac-TotClouds-',Merra2ShortFileName);
    ikind=4;
    DisplayMerra2CLDHGHS(ikind,titlestr)
end
if(indx2==10)%Ok
    titlestr=strcat('SurfaceEmissivity-',Merra2ShortFileName);
    DisplayMerra2EMISS(titlestr)
end
if(indx2==11)%Ok
    titlestr=strcat('SurfaceAbsorbedLWIRRad-',Merra2ShortFileName);
    ikind=1;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==12)%Ok
    titlestr=strcat('SurfaceAbsorbedLWIRRadClearSky-',Merra2ShortFileName);
    ikind=2;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==13)%Ok
    titlestr=strcat('SurfaceAbsorbedLWIRRadClearSkyNoAero-',Merra2ShortFileName);
    ikind=3;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==14)%Ok
    titlestr=strcat('LWIR-Flux-From-Surface-',Merra2ShortFileName);
    ikind=4;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==15)%Ok
    titlestr=strcat('LWIR-Surface-Net-Downflux-',Merra2ShortFileName);
    ikind=5;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==16)% Ok
    titlestr=strcat('LWIR-Surface-Net-Downflux-Clear',Merra2ShortFileName);
    ikind=6;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==17)% Ok
    titlestr=strcat('LWIR-Surface-Net-Downflux-Clear-NoAero',Merra2ShortFileName);
    ikind=7;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==18)% Ok
    titlestr=strcat('LWIR-Flux-At-TOA',Merra2ShortFileName);
    ikind=8;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==19)%Ok
    titlestr=strcat('LWIR-Flux-At-TOA-ClearSky',Merra2ShortFileName);
    ikind=9;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==20)%Ok
    titlestr=strcat('LWIR-Flux-At-TOA-ClearSky-NoAero',Merra2ShortFileName);
    ikind=10;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==21)%Ok
    titlestr=strcat('Surface-Shortwave-IncomingFlux',Merra2ShortFileName);
    ikind=11;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==22)%Ok
    titlestr=strcat('Surface-Shortwave-IncomingFlux-ClearSky',Merra2ShortFileName);
    ikind=12;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==23)%Ok
    titlestr=strcat('Surface-DownwardShortwave-Flux',Merra2ShortFileName);
    ikind=13;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==24)%Ok
    titlestr=strcat('Surface-DownwardShortwave-Flux-NoAero',Merra2ShortFileName);
    ikind=14;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==25)%Ok
    titlestr=strcat('Surface-DownwardShortwave-Flux-NoAeroClearSky',Merra2ShortFileName);
    ikind=15;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==26)%Ok
    titlestr=strcat('SWIR-Flux-TOA',Merra2ShortFileName);
    ikind=16;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==27)%Ok
    titlestr=strcat('SWIR-NetDownwards-Flux-TOA',Merra2ShortFileName);
    ikind=17;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==28)%Ok
    titlestr=strcat('SWIR-NetDownNoAero-Flux-TOA',Merra2ShortFileName);
    ikind=18;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==29)%Ok
    titlestr=strcat('SWIR-NetDownClearSky-Flux-TOA',Merra2ShortFileName);
    ikind=19;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==30)%Ok
    titlestr=strcat('SWIR-NetDownClearSkyNoAero-Flux-TOA',Merra2ShortFileName);
    ikind=20;
    DisplayMerra2LWFlux(ikind,titlestr)
end
if(indx2==31)%Ok
    ikind=1;
    titlestr=strcat('CloudOpticalThickness-HighClouds-',Merra2ShortFileName);
    DisplayMerra2TAUHGH(ikind,titlestr)
end
if(indx2==32)%Ok
    ikind=2;
    titlestr=strcat('CloudOpticalThickness-LowClouds-',Merra2FileName);
    DisplayMerra2TAUHGH(ikind,titlestr)
end
if(indx2==33)%Ok
    ikind=3;
    titlestr=strcat('CloudOpticalThickness-MidClouds-',Merra2FileName);
    DisplayMerra2TAUHGH(ikind,titlestr)
end
if(indx2==34)%Ok
    ikind=4;
    titlestr=strcat('CloudOpticalThickness-TotClouds-',Merra2FileName);
    DisplayMerra2TAUHGH(ikind,titlestr)
end
if(indx2==35)%Ok
    titlestr=strcat('Surface-Skin-Temp-',Merra2FileName);
    DisplayMerra2TSS(titlestr)
end
if(indx2==36)
    ikind=1;
    titlestr=strcat('VarAlbedo-',Merra2FileName);
    DisplayMerra2Var_ALBEDO(ikind,titlestr)
end
if(indx2==37)
    ikind=2;
    titlestr=strcat('VarALBNIRDF-',Merra2FileName);
    DisplayMerra2Var_ALBEDO(ikind,titlestr)
end
if(indx2==38)
    ikind=3;
    titlestr=strcat('VarALBNIRDR-',Merra2FileName);
    DisplayMerra2Var_ALBEDO(ikind,titlestr)
end
if(indx2==39)
    ikind=4;
    titlestr=strcat('VarALBVISDF-',Merra2FileName);
    DisplayMerra2Var_ALBEDO(ikind,titlestr)
end
if(indx2==40)
    ikind=5;
    titlestr=strcat('VarALBVISDR-',Merra2FileName);
    DisplayMerra2Var_ALBEDO(ikind,titlestr)
end
if(indx2==41)
    ikind=1;
    titlestr=strcat('VarCLDHGH-',Merra2FileName);
    DisplayMerra2Var_CLDHGH(ikind,titlestr)
end
if(indx2==42)
    ikind=2;
    titlestr=strcat('VarCLDLOW-',Merra2FileName);
    DisplayMerra2Var_CLDHGH(ikind,titlestr)
end
if(indx2==43)
    ikind=3;
    titlestr=strcat('VarCLDMID-',Merra2FileName);
    DisplayMerra2Var_CLDHGH(ikind,titlestr)
end
if(indx2==44)
    ikind=4;
    titlestr=strcat('VarCLDTOT-',Merra2FileName);
    DisplayMerra2Var_CLDHGH(ikind,titlestr)
end
if(indx2==45)
    titlestr=strcat('VarEMIS-',Merra2FileName);
    DisplayMerra2EMISS_Var(titlestr)
end

end

