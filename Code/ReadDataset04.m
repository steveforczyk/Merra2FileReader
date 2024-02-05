function ReadDataset04(nowFile,nowpath)
% Modified: This function will read in the the Merra-2 data set called 04
% which is cloud opacity
% Written By: Stephen Forczyk
% Created: Aug 4,2022
% Revised: Jan 24-27,2024 started recoding this routine
% to handle dataset M2T1NXOCN which was different than initially planned

% Classification: Unclassified

global BandDataS MetaDataS;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global YearMonthDayStr1;

global idebug iScale;
global LonS LatS TimeS ;
global EFLUXICES EFLUXWTRS FRSEAICES HFLUXICES HFLUXWTRS;
global LWGNTICES LWGNTWTRS;
global PRECSNOOCNS QV10MS RAINOCNS SWGNTICES integrateRate;
global T10MS TAUXICES TAUXWTRS TAUYICES TAUYWTRS;
global TSKINICES TSKINWTRS U10MS V10MS;
global RasterLats RasterLons Rpix;
global westEdge eastEdge northEdge southEdge;

% additional paths needed for mapping
global matpath1 mappath GOES16path;
global jpegpath savepath;

global fid isavefiles;


fprintf(fid,'\n');
fprintf(fid,'%s\n','**************Start reading dataset 04 data***************');
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
titlestr=strcat('SeaIce-LatentEnergyFlux-',Merra2ShortFileName);
[Stats,EFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(EFLUXICES,lowcutoff,highcutoff);
DisplayMerra2LatentEnergyFluxRev1(Stats,EFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
% Display the Open Water Latent Energy Flux
lowcutoff=-100;
highcutoff=800;
ikind=2;
titlestr=strcat('OpenWater-LatentEnergyFlux-',Merra2ShortFileName);
[Stats,EFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(EFLUXWTRS,lowcutoff,highcutoff);
DisplayMerra2LatentEnergyFluxRev1(Stats,EFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
% Display The Sea Ice Fraction
titlestr=strcat('SeaIce-Fraction-',Merra2ShortFileName);
ikind=3;
lowcutoff=0.00;
highcutoff=1.2;
[Stats,SeaIceAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(FRSEAICES,lowcutoff,highcutoff);
DisplayMerra2SeaIceFractionRev1(Stats,SeaIceAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
% Display Upward Heat Flux
titlestr=strcat('SeaIce-UpwardHeatFlux-',Merra2ShortFileName);
ikind=5;
lowcutoff=-500;
highcutoff=500;
[Stats,HFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(HFLUXICES,lowcutoff,highcutoff);
DisplayMerra2UpwardHeatFluxRev1(Stats,HFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
% Display Open Water Upward Heat Flux
ikind=6;
titlestr=strcat('OpenWater-UpwardHeatFlux-',Merra2ShortFileName);
lowcutoff=-500;
highcutoff=1000;
[Stats,HFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(HFLUXWTRS,lowcutoff,highcutoff);
DisplayMerra2UpwardHeatFluxRev1(Stats,HFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
% Display the Net Downward Long Wave Flux
titlestr=strcat('SeaIce-NetDownLW-Flux-',Merra2ShortFileName);
lowcutoff=-500;
highcutoff=500;
ikind=7;
[Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(HFLUXWTRS,lowcutoff,highcutoff);
DisplayMerra2NetDownLWFluxRev1(Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
titlestr=strcat('OpenWater-NetDownLW-Flux-',Merra2ShortFileName);
ikind=8;
lowcutoff=-500;
highcutoff=500;
[Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(HFLUXWTRS,lowcutoff,highcutoff);
DisplayMerra2NetDownLWFluxRev1(Stats,LWGNFluxAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
ab=2;
%% Display Ocean Precip Data
% Note that this can be displayed as rate or as an integrated value ov a 24
% hour period
iScale=3600;
if(integrateRate==0)
    titlestr=strcat('OceanRainFallRate-',Merra2ShortFileName);
    lowcutoff=-.1;
    highcutoff=20;
elseif(integrateRate==1)
    titlestr=strcat('OceanRainFallTotal-',Merra2ShortFileName);
    lowcutoff=-.1;
    highcutoff=20;
end
% Display the Rain Fall Rate
ikind=7;
iScale=3600;
titlestr=strcat('Ocean-RainFallRate-',Merra2ShortFileName);
[Stats,PrecipAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(RAINOCNS,lowcutoff,highcutoff);
DisplayMerra2OceanPrecip(Stats,PrecipAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
ab=1;
% Display the Snow Fall Rate
ikind=8;
iScale=3600;
titlestr=strcat('Ocean-SnowFallRate-',Merra2ShortFileName);
[Stats,PrecipAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(PRECSNOOCNS,lowcutoff,highcutoff);
DisplayMerra2OceanPrecip(Stats,PrecipAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
ab=2;
% Display The Rain Fall Total
ikind=9;
iScale=3600;
titlestr=strcat('Ocean-RainFallTotal-',Merra2ShortFileName);
[Stats,PrecipSumAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev6(RAINOCNS,lowcutoff,highcutoff);
DisplayMerra2OceanPrecip(Stats,PrecipSumAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
ab=2;
% Display The Snow Fall Total
ikind=10;
iScale=3600;
titlestr=strcat('Ocean-SnowFallTotal-',Merra2ShortFileName);
lowcutoff=-.1;
highcutoff=20;
[Stats,PrecipSumAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev6(PRECSNOOCNS,lowcutoff,highcutoff);
DisplayMerra2OceanPrecip(Stats,PrecipSumAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
ab=2;
% Display the Sea Ice Skin Temperature
titlestr=strcat('SeaIce-Skin-Temp-',Merra2ShortFileName);
lowcutoff=150;
highcutoff=320;
ikind=11;
iScale=1;
[Stats,TSKINICEAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TSKINICES,lowcutoff,highcutoff);
DisplayMerra2SeaIceSkinTempRev1(Stats,TSKINICEAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
titlestr=strcat('SeaIce-SkinTemp-',Merra2ShortFileName);
ab=3;
% Display the Open Water Skin Temperature
titlestr=strcat('Open-Water-Skin-Temp-',Merra2ShortFileName);
lowcutoff=150;
highcutoff=320;
ikind=12;
iScale=1;
[Stats,TSKINWTRAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev5(TSKINWTRS,lowcutoff,highcutoff);
DisplayMerra2SeaIceSkinTempRev1(Stats,TSKINWTRAdj,fraclow,frachigh,fracNaN,ikind,titlestr)
ab=3;

end

