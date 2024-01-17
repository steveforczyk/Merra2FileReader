function ReadDailyCOTData(MerraFileName)
% Modified: This function will read in the the Merra-2 data set for Cloud
% Optical Thickness. This daily dataset has very significant differences
% from the monthly product. There are 8 timeslices and 72 vertical slices
% in the data and there is a distinction of ice clouds and liquid clouds
% Written By: Stephen Forczyk
% Created: Mar 06,2023
% Revised: Mar 17,2023 continued decoding variables
% Revised: Mar 19,2023 starting building save file (3-Hr data)
% Revised: Mar 20,2023 made changes to allow plots of 4 D quantities
% Revised: Mar 21,2023 made changes to store key variable to file
% Classification: Unclassified

global BandDataS MetaDataS;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons PressureLevelUsed;
global PressureLevel42 PressureLevel72;
global TauCliSel TauClwSel SurfacePressure SP;
global CloudSel CfcuSel;
global Merra2FileName Merra2ShortFileName ;
global TauCliSel1Day TauClwSel1Day CloudSel1Day CfcuSel1Day;

global idebug;
global LonS LatS LevS;
global timeS CfcuS CloudS DelpS DtrainS InCloudQIS InCloudQLS;
global PsS QiS QlS RhS TauCliS TauClwS;
global YearMonthStr YearStr MonthStr DayStr YearMonthDayStr;
global TAUHGHS;

% additional paths needed for mapping
global matpath1 mappath GOES16path;
global jpegpath savepath averaged1Daypath;
global fid isavefiles;


fprintf(fid,'\n');
fprintf(fid,'%s\n','**************Start reading dataset 09 COT data***************');

[nc_filenamesuf,path]=uigetfile('*nc4','Select One Data File');
Merra2FileName=nc_filenamesuf;
Merra2FileName=RemoveUnderScores(Merra2FileName);
nc_filename=strcat(path,nc_filenamesuf);
ncid=netcdf.open(nc_filename,'nowrite');
openfilestr=strcat('Opening file-',Merra2FileName,'-for reading');
fprintf(fid,'%s\n',openfilestr);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
is=iper(2)+1;
ie=is+3;
YearStr=Merra2FileName(is:ie);
is=ie+1;
ie=is+1;
MonthStr=Merra2FileName(is:ie);
is=ie+1;
ie=is+1;
DayStr=Merra2FileName(is:ie);
YearMonthDayStr=strcat(YearStr,MonthStr,DayStr);

LonS=struct('values',[],'long_name',[],'units',[],'vmax',[],'vmin',[]);
LatS=LonS;
LevS=struct('values',[],'long_name',[],'standard_name',[],...
    'units',[],'coordinates',[],'positive',[],'vmin',[],'vmax',[],'valid_range',[]);
timeS=struct('values',[],'long_name',[],'units',[],'time_increment',[],...
    'begin_date',[],'begin_time',[],'vmax',[],'vmin',[],'valid_range',[]);
CfcuS=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
      'missing_value',[],'fmissing_value',[],'scale_factor',[],'add_offset',[],...
      'vmax',[],'vmin',[],'valid_range',[]);
CloudS=CfcuS;
DelpS=CfcuS;
DtrainS=CfcuS;
InCloudQIS=CfcuS;
PsS=CfcuS;
QiS=CfcuS;
QlS=CfcuS;
RhS=CfcuS;
TauCliS=CfcuS;
TauClwS=CfcuS;
TAUHGHS=struct('values',[],'Fill_Value',[],'fmissing_value',[],'missing_value',[],...
    'origname',[],'vmax',[],'vmin',[],'standard_name',[],'quantity_type',[],...
    'product_short_name',[],'product_version',[],'long_name',[],...
    'units',[],'cell_methods',[],'latitude_resolution',[],....
    'longitude_resolution',[],'coordinates',[]);
% TimeS=struct('values',[],'long_name',[],'units',[],'time_increment',[],...
%     'begin_date',[],'begin_time',[],'vmax',[],'vmin',[],'valid_range',[]);


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
AllVariables=cell(numvars,1);
for i=0:numvars-1
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,i);
    AllVariables{i+1,1}=varname;
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
       a30=strcmp(varname,'lev');
       a40=strcmp(varname,'time');
       a50=strcmp(varname,'CFCU');
       a60=strcmp(varname,'CLOUD');
       a70=strcmp(varname,'DELP');
       a80=strcmp(varname,'DTRAIN');
       a90=strcmp(varname,'INCLOUDQI');
       a100=strcmp(varname,'INCLOUDQL');
       a110=strcmp(varname,'PS');
       a120=strcmp(varname,'QI');
       a130=strcmp(varname,'QL');
       a140=strcmp(varname,'RH');
       a150=strcmp(varname,'TAUCLI');
       a160=strcmp(varname,'TAUCLW');




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
                 LevS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                 LevS.standard_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 LevS.units=attname2;
            end
            a1=strcmp(attname1,'coordinate');
            if(a1==1)
                 LevS.coordinates=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 LevS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 LevS.vmin=attname2;
            end
            a1=strcmp(attname1,'positive');
            if(a1==1)
                 LevS.positive=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 LevS.valid_range=attname2;
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
                 timeS.long_name=attname2;
            end
            a1=strcmp(attname1,'time_increment');
            if(a1==1)
                 timeS.time_increment=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 timeS.units=attname2;
            end
            a1=strcmp(attname1,'begin_date');
            if(a1==1)
                 timeS.begin_date=attname2;
            end
            a1=strcmp(attname1,'begin_time');
            if(a1==1)
                 timeS.begin_time=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 timeS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 timeS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 timeS.valid_range=attname2;
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
                CfcuS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                CfcuS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 CfcuS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 CfcuS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 CfcuS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 CfcuS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 CfcuS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 CfcuS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 CfcuS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 CfcuS.valid_range=attname2;
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
                CloudS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                CloudS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 CloudS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 CloudS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 CloudS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 CloudS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 CloudS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 CloudS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 CloudS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 CloudS.valid_range=attname2;
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
                DelpS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                DelpS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 DelpS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 DelpS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 DelpS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 DelpS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 DelpS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 DelpS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 DelpS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 DelpS.valid_range=attname2;
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
                DtrainS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                DtrainS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 DtrainS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 DtrainS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 DtrainS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 DtrainS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 DtrainS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 DtrainS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 DtrainS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 DtrainS.valid_range=attname2;
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
                InCloudQIS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                InCloudQIS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 InCloudQIS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 InCloudQIS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 InCloudQIS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 InCloudQIS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 InCloudQIS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 InCloudQIS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 InCloudQIS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 InCloudQIS.valid_range=attname2;
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
                InCloudQLS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                InCloudQLS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 InCloudQLS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 InCloudQIS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 InCloudQLS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 InCloudQLS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 InCloudQLS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 InCloudQLS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 InCloudQLS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 InCloudQLS.valid_range=attname2;
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
                PsS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                PsS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 PsS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 PsS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 PsS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 PsS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 PsS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 PsS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 PsS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 PsS.valid_range=attname2;
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
                QiS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                QiS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 QiS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 QiS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 QiS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 QiS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 QiS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 QiS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 QiS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 QiS.valid_range=attname2;
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
                QlS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                QlS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 QlS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 QlS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 QlS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 QlS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 QlS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 QlS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 QlS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 QlS.valid_range=attname2;
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
                RhS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                RhS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 RhS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 RhS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 RhS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 RhS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 RhS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 RhS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 RhS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 RhS.valid_range=attname2;
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
                TauCliS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TauCliS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 TauCliS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 TauCliS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 TauCliS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 TauCliS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 TauCliS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 TauCliS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 TauCliS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 TauCliS.valid_range=attname2;
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
                TauClwS.add_offset=attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                TauClwS.scale_factor=attname2;
                flag=1;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 TauClwS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 TauClwS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 TauClwS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 TauClwS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 TauClwS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 TauClwS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 TauClwS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 TauClwS.valid_range=attname2;
            end

        end
    end
    if(idebug==1)
        disp(' ')
    end
    
    if flag

        if(a50==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            CfcuS.values=CFCU;
        end

        if(a60==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            CloudS.values=CLOUD;
        end

        if(a70==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            DelpS.values=DELP;
        end

        if(a80==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            DtrainS.values=DTRAIN;
        end

        if(a90==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            InCloudQIS.values=INCLOUDQI;
        end

        if(a100==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            InCloudQLS.values=INCLOUDQL;
        end

        if(a110==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            PsS.values=PS;
        end

        if(a120==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            QiS.values=QI;
        end

        if(a130==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            QlS.values=QL;
        end

       if(a140==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            RhS.values=RH;
       end

       if(a150==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            TauCliS.values=TAUCLI;
       end

       if(a160==1)
            eval([varname '= double(double(netcdf.getVar(ncid,i))*scale + offset);'])
            TauClwS.values=TAUCLW;
       end


    else
         
        if(a10==1)
            eval([varname '= double(netcdf.getVar(ncid,i));'])  
            LonS.values=lon;
        end

        if(a20==1)
            eval([varname '= double(netcdf.getVar(ncid,i));'])  
            LatS.values=lat;
        end

        if(a30==1)
            eval([varname '= double(netcdf.getVar(ncid,i));'])  
            LevS.values=lev;
        end

        if(a40==1)
            eval([varname '= double(netcdf.getVar(ncid,i));'])  
            timeS.values=time;
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
% Now build the RasterLats and RasterLons variables
nlats=length(LatS.values);
nlons=length(LonS.values);
rlats=LatS.values;
rlons=LonS.values;
RasterLats=zeros(nlats,nlons);
RasterLons=zeros(nlats,nlons);
for i=1:nlats
    for j=1:1:nlons
        RasterLats(i,j)=rlats(i,1);
        RasterLons(i,j)=rlons(j,1);
    end
end

%Now write a Matlab file containing the decoded data
%use the original file name with a .mat extension
%% Now pull out the data for the desired pressure levels and write just those levels to the file to save space
[plevelsp1,~]=size(PressureLevelUsed);
plevels=plevelsp1-1;
TauCli=TauCliS.values;
TauClw=TauClwS.values;
CloudFrac=CloudS.values;
CfcuSFrac=CfcuS.values;
[nlon,nlat,~,ntimes]=size(TauCli);
TauCliSel=zeros(nlon,nlat,plevels,ntimes);
TauClwSel=zeros(nlon,nlat,plevels,ntimes);
CloudSel=zeros(nlon,nlat,plevels,ntimes);
CfcuSel=zeros(nlon,nlat,plevels,ntimes);
TauCliSel1Day=zeros(nlon,nlat,plevels);
TauGrab=zeros(nlon,nlat);
TauHold=zeros(nlon,nlat);
TauGrab1=zeros(nlon,nlat);
TauHold1=zeros(nlon,nlat);
TauGrab2=zeros(nlon,nlat);
TauHold2=zeros(nlon,nlat);
TauGrab3=zeros(nlon,nlat);
TauHold3=zeros(nlon,nlat);
% First pick out just those pressure levels needed so
% we can reduce memory and file size levels for TauCliSel
for np=1:plevels
    ind=PressureLevelUsed{1+np,1};
    for nt=1:ntimes
        for n2=1:nlat
            for n1=1:nlon
                TauCliSel(n1,n2,np,nt)=TauCli(n1,n2,ind,nt);
                TauClwSel(n1,n2,np,nt)=TauClw(n1,n2,ind,nt);
                CloudSel(n1,n2,np,nt)=CloudFrac(n1,n2,ind,nt);
                CfcuSel(n1,n2,np,nt)=CfcuSFrac(n1,n2,ind,nt);
            end
        end
    end
end
% Now create the 1 day average variables
for np=1:plevels
    for nt=1:ntimes
        TauGrab(:,:)=TauCliSel(:,:,np,nt);
        TauGrab1(:,:)=TauClwSel(:,:,np,nt);
        TauGrab2(:,:)=CloudSel(:,:,np,nt);
        TauGrab3(:,:)=CfcuSel(:,:,np,nt);
        for n2=1:nlat
            for n1=1:nlon                
                TauHold(n1,n2)=TauHold(n1,n2)+TauGrab(n1,n2);
                TauHold1(n1,n2)=TauHold1(n1,n2)+TauGrab1(n1,n2);
                TauHold2(n1,n2)=TauHold2(n1,n2)+TauGrab2(n1,n2);
                TauHold3(n1,n2)=TauHold3(n1,n2)+TauGrab3(n1,n2);
            end
        end
        maxval=max(max(TauHold));
        dispstr=strcat('At Time=',num2str(nt),'-The max value is-',num2str(maxval));
        disp(dispstr)
        ab=1;
    end
        TauHold=TauHold/8;
        TauHold1=TauHold1/8;
        TauHold2=TauHold2/8;
        TauHold3=TauHold3/8;
        adjmaxval=max(max(TauHold));
        dispstr=strcat('The adjusted max value is-',num2str(adjmaxval));
        disp(dispstr)
        ab=2;
        for n2=1:nlat
            for n1=1:nlon
                TauCliSel1Day(n1,n2,np)=TauHold(n1,n2);
                TauClwSel1Day(n1,n2,np)=TauHold1(n1,n2);
                CloudSel1Day(n1,n2,np)=TauHold2(n1,n2);
                CfcuSel1Day(n1,n2,np)=TauHold3(n1,n2);
            end
        end
end
ab=2;
% Pull out the surface pressures
SP= PsS.values;
[k1,k2,~]=size(SP);
SurfacePressure=zeros(k1,k2);
for ii=1:k1
    for jj=1:k2
        SurfacePressure(ii,jj)=SP(ii,jj,1);
    end
end

%% This section will save the data from the 3 hr time segments
if(isavefiles>0)
    MatFileName=strcat('COT-3Hr-',Merra2ShortFileName,'.mat');
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='Merra2FileName Merra2ShortFileName RasterLats RasterLons';
    varstr2=' TauCliSel TauClwSel PressureLevelUsed timeS SurfacePressure';
    varstr3=' CloudSel CfcuSel ';
    varstr4=' CloudSel1Day CfcuSel1Day TauCliSel1Day TauClwSel1Day';
    varstr=strcat(varstr1,varstr2,varstr3);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr);
    savestr=strcat('Saved Decode Data to File=',MatFileName);
    fprintf(fid,'%s\n',savestr);
    disp(savestr)
else
    dispstr=strcat('Did Not save Decoded Data to File-',MatFileName);
    disp(dispstr);
    fprintf(fid,'%s\n',dispstr);
end

%% This section will save the data that was aggregated into 1 Day but averaging 8 three hour segements
if(isavefiles>1)
    MatFileName2=strcat('COT-1DayAvg-',Merra2ShortFileName,'.mat');
    eval(['cd ' averaged1Daypath(1:length(averaged1Daypath)-1)]);
    actionstr='save';
    varstr1='Merra2FileName Merra2ShortFileName RasterLats RasterLons';
    varstr2=' PressureLevelUsed timeS SurfacePressure';
    varstr3=' TauCliSel1Day TauClwSel1Day';
    varstr4=' CloudSel1Day CfcuSel1Day';
    varstr=strcat(varstr1,varstr2,varstr3,varstr4);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName2,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName2);
    disp(dispstr);
    savestr=strcat('Saved Decode Data to File=',MatFileName2);
    fprintf(fid,'%s\n',savestr);
    disp(savestr)
else
    dispstr=strcat('Did Not save Decoded Data to File-',MatFileName2);
    disp(dispstr);
    fprintf(fid,'%s\n',dispstr);
end 
Merra2ShortFileName=Merra2FileName(is:ie);
%% Plot selected variables for the 3 hour time segments
% Display the Cloud Optical Thickness for Ice Clouds
ikind=1;
itime=1;
ipress=3;
itype=3;
varname='TAUCLI';
DisplayMerra2TAUInCloud(ikind,itime,ipress,itype,varname)
% Display the Cloud Optical Thickness for Water Clouds
ikind=3;
itime=1;
ipress=3;
itype=3;
varname='TAUCLW';
DisplayMerra2TAUInCloud(ikind,itime,ipress,itype,varname)
% Display the Cloud Optical Thickness as a density
% titlestr=strcat('CloudOpticalDensity-400hPA-',Merra2ShortFileName);
% DisplayMerra2TAUCloudDensity(ikind,titlestr)
%% PLot selected variables that were average into 1 Day tme segments
ikind=1;
ipress=3;
itype=3;
varname='TauCliSel1Day';
DisplayMerra2TAUInCloud1DayAvg(ikind,ipress,itype,varname)
end

