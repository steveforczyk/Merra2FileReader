function ReadDataset03(nowFile,nowpath)
% Modified: This function will read in the the Merra-2 data set 03
% This dataset is of the item M2IUNXASM_5.12.4
% Written By: Stephen Forczyk
% Created: Oct 30,2023

% Classification: Unclassified

global BandDataS MetaDataS;

global Merra2FileName Merra2Dat Merra2ShortFileName numSelectedFiles;

global idebug;
global LatitudesS LongitudesS ;
global O3S PSS QVS QV10MS QV2MS SLPS T10MS T2MS;
global timeS TO3S TOXS TQIS TQLS TQVS TSS;
global TROPPBS TROPPTS TROPPVS TROPQS TROPTS;
global U10MS U2MS U50MS V10MS V2MS V50MS;
global numtimeslice framecounter;
global YearMonthDayStr1 YearMonthDayStr2;
global ChoiceList;
global PascalsToMilliBars PascalsToPsi;
global PSTable PSTT;
global PS10 PS25 PS50 PS75 PS90 PS100 PSLow PSHigh PSNaN PSValues
global QV10MTable QV10MTT;
global QV10M10 QV10M25 QV10M50 QV10M75 QV10M90 QV10M100 QV10MLow QV10MHigh QV10MNaN QV10MValues;
global QV2MTable QV2MTT;
global QV2M10 QV2M25 QV2M50 QV2M75 QV2M90 QV2M100 QV2MLow QV2MHigh QV2MNaN QV2MValues;
global SLPTable SLPTT;
global SLP10 SLP25 SLP50 SLP75 SLP90 SLP100 SLPLow SLPHigh SLPNaN SLPValues;
global T10MTable T10MTT;
global T10M10 T10M25 T10M50 T10M75 T10M90 T10M100 T10MLow T10MHigh T10MNaN T10MValues;
global T2MTable T2MTT;
global T2M10 T2M25 T2M50 T2M75 T2M90 T2M100 T2MLow T2MHigh T2MNaN T2MValues;
global TO3Table TO3TT;
global TO310 TO325 TO350 TO375 TO390 TO3100 TO3Low TO3High TO3NaN TO3Values;
global TOXTable TOXTT;
global TOX10 TOX25 TOX50 TOX75 TOX90 TOX100 TOXLow TOXHigh TOXNaN TOXValues;
global TQITable TQITT;
global TQI10 TQI25 TQI50 TQI75 TQI90 TQI100 TQILow TQIHigh TQINaN TQIValues;
global TQLTable TQLTT;
global TQL10 TQL25 TQL50 TQL75 TQL90 TQL100 TQLLow TQLHigh TQLNaN TQLValues;
global TQVTable TQVTT;
global TQV10 TQV25 TQV50 TQV75 TQV90 TQV100 TQVLow TQVHigh TQVNaN TQVValues;
global TROPPBTable TROPPBTT;
global TROPPB10 TROPPB25 TROPPB50 TROPPB75 TROPPB90 TROPPB100 TROPPBLow TROPPBHigh TROPPBNaN TROPPBValues;
global TROPPTTable TROPPTTT;
global TROPPT10 TROPPT25 TROPPT50 TROPPT75 TROPPT90 TROPPT100 TROPPTLow TROPPTHigh TROPPTNaN TROPPTValues;
global TROPPVTable TROPPVTT;
global TROPPV10 TROPPV25 TROPPV50 TROPPV75 TROPPV90 TROPPV100 TROPPVLow TROPPVHigh TROPPVNaN TROPPVValues;
global TROPQTable TROPQTT;
global TROPQ10 TROPQ25 TROPQ50 TROPQ75 TROPQ90 TROPQ100 TROPQLow TROPQHigh TROPQNaN TROPQValues;
global TROPTTable TROPTTT;
global TROPT10 TROPT25 TROPT50 TROPT75 TROPT90 TROPT100 TROPTLow TROPTHigh TROPTNaN TROPTValues;
global TSTable TSTT;
global TS10 TS25 TS50 TS75 TS90 TS100 TSLow TSHigh TSNaN TSValues;
global U10MTable U10MTT;
global U10M10 U10M25 U10M50 U10M75 U10M90 U10M100 U10MLow U10MHigh U10MNaN U10MValues;
global U2MTable U2MTT;
global U2M10 U2M25 U2M50 U2M75 U2M90 U2M100 U2MLow U2MHigh U2MNaN U2MValues;
global U50MTable U50MTT;
global U50M10 U50M25 U50M50 U50M75 U50M90 U50M100 U50MLow U50MHigh U50MNaN U50MValues;
global V10MTable V10MTT;
global V10M10 V10M25 V10M50 V10M75 V10M90 V10M100 V10MLow V10MHigh V10MNaN V10MValues;
global V2MTable V2MTT;
global V2M10 V2M25 V2M50 V2M75 V2M90 V2M100 V2MLow V2MHigh V2MNaN V2MValues;
global V50MTable V50MTT;
global V50M10 V50M25 V50M50 V50M75 V50M90 V50M100 V50MLow V50MHigh V50MNaN V50MValues;
global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;
global yd md dd;
global iCityPlot;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

% additional paths needed for mapping
global matpath1 mappath ;
global savepath jpegpath pdfpath logpath moviepath tablepath;
global YearMonthStr;
global fid isavefiles;

fprintf(fid,'\n');
fprintf(fid,'%s\n','**************Start reading dataset 03***************');
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
LatitudesS=struct('values',[],'long_name',[],'units',[],...
    'vmax',[],'vmin',[],'valid_range',[]);
LongitudesS=LatitudesS;
PSS=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'vmax',[],'vmin',[],...
    'valid_range',[]);
O3S=PSS;
QVS=PSS;
SLPS=PSS;


timeS=struct('values',[],'long_name',[],'units',[],'time_increment',[],...
    'begin_date',[],'begin_time',[],'vmax',[],'vmin',[],'valid_range',[]);
% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
numvarstr=strcat('The number of variables read from the Datset1 file=',num2str(numvars));
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
       a10=strcmp(varname,'PS');
%        a20=strcmp(varname,'lat');
%        a30=strcmp(varname,'lon');
         a40=strcmp(varname,'O3');
         a50=strcmp(varname,'QV');
         a60=strcmp(varname,'SLP');
%        a70=strcmp(varname,'SLP');
%        a80=strcmp(varname,'T10M');
%        a90=strcmp(varname,'T2M');
%        a100=strcmp(varname,'time');
%        a110=strcmp(varname,'TO3');
%        a120=strcmp(varname,'TOX');
%        a130=strcmp(varname,'TQI');
%        a140=strcmp(varname,'TQL');
%        a150=strcmp(varname,'TQV');
%        a160=strcmp(varname,'TROPPB');
%        a170=strcmp(varname,'TROPPT');
%        a180=strcmp(varname,'TROPPV');
%        a190=strcmp(varname,'TROPQ');
%        a200=strcmp(varname,'TROPT');
%        a210=strcmp(varname,'TS');
%        a220=strcmp(varname,'U10M');
%        a230=strcmp(varname,'U2M');
%        a240=strcmp(varname,'U50M');
%        a250=strcmp(varname,'V10M');
%        a260=strcmp(varname,'V2M');
%        a270=strcmp(varname,'V50M');
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                PSS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                PSS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                PSS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                PSS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                PSS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                PSS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                PSS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                PSS.valid_range=attname2;
            end

%         elseif (a20==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 LatitudesS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 LatitudesS.units=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 LatitudesS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 LatitudesS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 LatitudesS.valid_range=attname2;
%             end

%         elseif (a30==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 LongitudesS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 LongitudesS.units=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 LongitudesS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 LongitudesS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 LongitudesS.valid_range=attname2;
%             end
% 
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                O3S.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                O3S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                O3S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                O3S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                O3S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                O3S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                O3S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                O3S.valid_range=attname2;
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                QVS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                QVS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                QVS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                QVS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                QVS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                QVS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                QVS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                QVS.valid_range=attname2;
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SLPS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SLPS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SLPS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SLPS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SLPS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SLPS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SLPS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SLPS.valid_range=attname2;
            end

% 
%           elseif (a70==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 SLPS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 SLPS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 SLPS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 SLPS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 SLPS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 SLPS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 SLPS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 SLPS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 SLP10=zeros(numSelectedFiles,1);
%                 SLP25=zeros(numSelectedFiles,1);
%                 SLP50=zeros(numSelectedFiles,1);
%                 SLP75=zeros(numSelectedFiles,1);
%                 SLP90=zeros(numSelectedFiles,1);
%                 SLP100=zeros(numSelectedFiles,1);
%                 SLPLow=zeros(numSelectedFiles,1);
%                 SLPHigh=zeros(numSelectedFiles,1);
%                 SLPNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a80==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 T10MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 T10MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 T10MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 T10MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 T10MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 T10MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 T10MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 T10MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 T10M10=zeros(numSelectedFiles,1);
%                 T10M25=zeros(numSelectedFiles,1);
%                 T10M50=zeros(numSelectedFiles,1);
%                 T10M75=zeros(numSelectedFiles,1);
%                 T10M90=zeros(numSelectedFiles,1);
%                 T10M100=zeros(numSelectedFiles,1);
%                 T10MLow=zeros(numSelectedFiles,1);
%                 T10MHigh=zeros(numSelectedFiles,1);
%                 T10MNaN=zeros(numSelectedFiles,1);
%             end
% 
%          elseif (a90==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 T2MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 T2MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 T2MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 T2MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 T2MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 T2MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 T2MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 T2MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 T2M10=zeros(numSelectedFiles,1);
%                 T2M25=zeros(numSelectedFiles,1);
%                 T2M50=zeros(numSelectedFiles,1);
%                 T2M75=zeros(numSelectedFiles,1);
%                 T2M90=zeros(numSelectedFiles,1);
%                 T2M100=zeros(numSelectedFiles,1);
%                 T2MLow=zeros(numSelectedFiles,1);
%                 T2MHigh=zeros(numSelectedFiles,1);
%                 T2MNaN=zeros(numSelectedFiles,1);
%             end
% 
% 
%          elseif (a100==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 timeS.long_name=attname2;
%             end
% 
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 timeS.units=attname2;
%             end
%             a1=strcmp(attname1,'time_increment');
%             if(a1==1)
%                 timeS.time_increment=attname2;
%             end
%             a1=strcmp(attname1,'begin_date');
%             if(a1==1)
%                 timeS.begin_date=attname2;
%             end
%             a1=strcmp(attname1,'begin_time');
%             if(a1==1)
%                 timeS.begin_time=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 timeS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 timeS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 timeS.valid_range=attname2;
%             end
% 
%           elseif (a110==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TO3S.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TO3S.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TO3S.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TO3S.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TO3S.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TO3S.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TO3S.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TO3S.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TO310=zeros(numSelectedFiles,1);
%                 TO325=zeros(numSelectedFiles,1);
%                 TO350=zeros(numSelectedFiles,1);
%                 TO375=zeros(numSelectedFiles,1);
%                 TO390=zeros(numSelectedFiles,1);
%                 TO3100=zeros(numSelectedFiles,1);
%                 TO3Low=zeros(numSelectedFiles,1);
%                 TO3High=zeros(numSelectedFiles,1);
%                 TO3NaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a120==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TOXS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TOXS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TOXS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TOXS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TOXS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TOXS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TOXS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TOXS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TOX10=zeros(numSelectedFiles,1);
%                 TOX25=zeros(numSelectedFiles,1);
%                 TOX50=zeros(numSelectedFiles,1);
%                 TOX75=zeros(numSelectedFiles,1);
%                 TOX90=zeros(numSelectedFiles,1);
%                 TOX100=zeros(numSelectedFiles,1);
%                 TOXLow=zeros(numSelectedFiles,1);
%                 TOXHigh=zeros(numSelectedFiles,1);
%                 TOXNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a130==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TQIS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TQIS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TQIS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TQIS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TQIS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TQIS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TQIS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TQIS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TQI10=zeros(numSelectedFiles,1);
%                 TQI25=zeros(numSelectedFiles,1);
%                 TQI50=zeros(numSelectedFiles,1);
%                 TQI75=zeros(numSelectedFiles,1);
%                 TQI90=zeros(numSelectedFiles,1);
%                 TQI100=zeros(numSelectedFiles,1);
%                 TQILow=zeros(numSelectedFiles,1);
%                 TQIHigh=zeros(numSelectedFiles,1);
%                 TQINaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a140==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TQLS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TQLS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TQLS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TQLS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TQLS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TQLS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TQLS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TQLS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TQL10=zeros(numSelectedFiles,1);
%                 TQL25=zeros(numSelectedFiles,1);
%                 TQL50=zeros(numSelectedFiles,1);
%                 TQL75=zeros(numSelectedFiles,1);
%                 TQL90=zeros(numSelectedFiles,1);
%                 TQL100=zeros(numSelectedFiles,1);
%                 TQLLow=zeros(numSelectedFiles,1);
%                 TQLHigh=zeros(numSelectedFiles,1);
%                 TQLNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a150==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TQVS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TQVS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TQVS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TQVS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TQVS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TQVS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TQVS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TQVS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TQV10=zeros(numSelectedFiles,1);
%                 TQV25=zeros(numSelectedFiles,1);
%                 TQV50=zeros(numSelectedFiles,1);
%                 TQV75=zeros(numSelectedFiles,1);
%                 TQV90=zeros(numSelectedFiles,1);
%                 TQV100=zeros(numSelectedFiles,1);
%                 TQVLow=zeros(numSelectedFiles,1);
%                 TQVHigh=zeros(numSelectedFiles,1);
%                 TQVNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a160==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TROPPBS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TROPPBS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TROPPBS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TROPPBS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TROPPBS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TROPPBS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TROPPBS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TROPPBS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TROPPB10=zeros(numSelectedFiles,1);
%                 TROPPB25=zeros(numSelectedFiles,1);
%                 TROPPB50=zeros(numSelectedFiles,1);
%                 TROPPB75=zeros(numSelectedFiles,1);
%                 TROPPB90=zeros(numSelectedFiles,1);
%                 TROPPB100=zeros(numSelectedFiles,1);
%                 TROPPBLow=zeros(numSelectedFiles,1);
%                 TROPPBHigh=zeros(numSelectedFiles,1);
%                 TROPPBNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a170==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TROPPTS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TROPPTS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TROPPTS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TROPPTS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TROPPTS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TROPPTS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TROPPTS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TROPPTS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TROPPT10=zeros(numSelectedFiles,1);
%                 TROPPT25=zeros(numSelectedFiles,1);
%                 TROPPT50=zeros(numSelectedFiles,1);
%                 TROPPT75=zeros(numSelectedFiles,1);
%                 TROPPT90=zeros(numSelectedFiles,1);
%                 TROPPT100=zeros(numSelectedFiles,1);
%                 TROPPTLow=zeros(numSelectedFiles,1);
%                 TROPPTHigh=zeros(numSelectedFiles,1);
%                 TROPPTNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a180==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TROPPVS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TROPPVS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TROPPVS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TROPPVS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TROPPVS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TROPPVS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TROPPVS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TROPPVS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TROPPV10=zeros(numSelectedFiles,1);
%                 TROPPV25=zeros(numSelectedFiles,1);
%                 TROPPV50=zeros(numSelectedFiles,1);
%                 TROPPV75=zeros(numSelectedFiles,1);
%                 TROPPV90=zeros(numSelectedFiles,1);
%                 TROPPV100=zeros(numSelectedFiles,1);
%                 TROPPVLow=zeros(numSelectedFiles,1);
%                 TROPPVHigh=zeros(numSelectedFiles,1);
%                 TROPPVNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a190==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TROPQS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TROPQS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TROPQS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TROPQS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TROPQS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TROPQS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TROPQS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TROPQS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TROPQ10=zeros(numSelectedFiles,1);
%                 TROPQ25=zeros(numSelectedFiles,1);
%                 TROPQ50=zeros(numSelectedFiles,1);
%                 TROPQ75=zeros(numSelectedFiles,1);
%                 TROPQ90=zeros(numSelectedFiles,1);
%                 TROPQ100=zeros(numSelectedFiles,1);
%                 TROPQLow=zeros(numSelectedFiles,1);
%                 TROPQHigh=zeros(numSelectedFiles,1);
%                 TROPQNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a200==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TROPTS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TROPTS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TROPTS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TROPTS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TROPTS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TROPTS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TROPTS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TROPTS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TROPT10=zeros(numSelectedFiles,1);
%                 TROPT25=zeros(numSelectedFiles,1);
%                 TROPT50=zeros(numSelectedFiles,1);
%                 TROPT75=zeros(numSelectedFiles,1);
%                 TROPT90=zeros(numSelectedFiles,1);
%                 TROPT100=zeros(numSelectedFiles,1);
%                 TROPTLow=zeros(numSelectedFiles,1);
%                 TROPTHigh=zeros(numSelectedFiles,1);
%                 TROPTNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a210==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 TSS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 TSS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 TSS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 TSS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 TSS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 TSS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 TSS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 TSS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 TS10=zeros(numSelectedFiles,1);
%                 TS25=zeros(numSelectedFiles,1);
%                 TS50=zeros(numSelectedFiles,1);
%                 TS75=zeros(numSelectedFiles,1);
%                 TS90=zeros(numSelectedFiles,1);
%                 TS100=zeros(numSelectedFiles,1);
%                 TSLow=zeros(numSelectedFiles,1);
%                 TSHigh=zeros(numSelectedFiles,1);
%                 TSNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a220==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 U10MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 U10MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 U10MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 U10MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 U10MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 U10MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 U10MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 U10MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 U10M10=zeros(numSelectedFiles,1);
%                 U10M25=zeros(numSelectedFiles,1);
%                 U10M50=zeros(numSelectedFiles,1);
%                 U10M75=zeros(numSelectedFiles,1);
%                 U10M90=zeros(numSelectedFiles,1);
%                 U10M100=zeros(numSelectedFiles,1);
%                 U10MLow=zeros(numSelectedFiles,1);
%                 U10MHigh=zeros(numSelectedFiles,1);
%                 U10MNaN=zeros(numSelectedFiles,1);
%             end
% 
%          elseif (a230==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 U2MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 U2MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 U2MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 U2MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 U2MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 U2MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 U2MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 U2MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 U2M10=zeros(numSelectedFiles,1);
%                 U2M25=zeros(numSelectedFiles,1);
%                 U2M50=zeros(numSelectedFiles,1);
%                 U2M75=zeros(numSelectedFiles,1);
%                 U2M90=zeros(numSelectedFiles,1);
%                 U2M100=zeros(numSelectedFiles,1);
%                 U2MLow=zeros(numSelectedFiles,1);
%                 U2MHigh=zeros(numSelectedFiles,1);
%                 U2MNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a240==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 U50MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 U50MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 U50MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 U50MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 U50MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 U50MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 U50MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 U50MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 U50M10=zeros(numSelectedFiles,1);
%                 U50M25=zeros(numSelectedFiles,1);
%                 U50M50=zeros(numSelectedFiles,1);
%                 U50M75=zeros(numSelectedFiles,1);
%                 U50M90=zeros(numSelectedFiles,1);
%                 U50M100=zeros(numSelectedFiles,1);
%                 U50MLow=zeros(numSelectedFiles,1);
%                 U50MHigh=zeros(numSelectedFiles,1);
%                 U50MNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a250==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 V10MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 V10MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 V10MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 V10MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 V10MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 V10MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 V10MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 V10MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 V10M10=zeros(numSelectedFiles,1);
%                 V10M25=zeros(numSelectedFiles,1);
%                 V10M50=zeros(numSelectedFiles,1);
%                 V10M75=zeros(numSelectedFiles,1);
%                 V10M90=zeros(numSelectedFiles,1);
%                 V10M100=zeros(numSelectedFiles,1);
%                 V10MLow=zeros(numSelectedFiles,1);
%                 V10MHigh=zeros(numSelectedFiles,1);
%                 V10MNaN=zeros(numSelectedFiles,1);
%             end
% 
%          elseif (a260==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 V2MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 V2MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 V2MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 V2MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 V2MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 V2MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 V2MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 V2MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 V2M10=zeros(numSelectedFiles,1);
%                 V2M25=zeros(numSelectedFiles,1);
%                 V2M50=zeros(numSelectedFiles,1);
%                 V2M75=zeros(numSelectedFiles,1);
%                 V2M90=zeros(numSelectedFiles,1);
%                 V2M100=zeros(numSelectedFiles,1);
%                 V2MLow=zeros(numSelectedFiles,1);
%                 V2MHigh=zeros(numSelectedFiles,1);
%                 V2MNaN=zeros(numSelectedFiles,1);
%             end
% 
%           elseif (a270==1)
%             attname1 = netcdf.inqAttName(ncid,i,j);
%             attname2 = netcdf.getAtt(ncid,i,attname1);
%             if(idebug==1)
%                 disp([attname1 ':  ' num2str(attname2)])
%                 dispstr=strcat(attname1,': ',num2str(attname2));
%                 fprintf(fid,'%s\n',dispstr);
%             end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
%             a1=strcmp(attname1,'long_name');
%             if(a1==1)
%                 V50MS.long_name=attname2;
%             end
%             a1=strcmp(attname1,'_FillValue');
%             if(a1==1)
%                 V50MS.FillValue=attname2;
%             end
%             a1=strcmp(attname1,'units');
%             if(a1==1)
%                 V50MS.units=attname2;
%             end
%             a1=strcmp(attname1,'missing_value');
%             if(a1==1)
%                 V50MS.missing_value=attname2;
%             end
%             a1=strcmp(attname1,'fmissing_value');
%             if(a1==1)
%                 V50MS.fmissing_value=attname2;
%             end
%             a1=strcmp(attname1,'vmax');
%             if(a1==1)
%                 V50MS.vmax=attname2;
%             end
%             a1=strcmp(attname1,'vmin');
%             if(a1==1)
%                 V50MS.vmin=attname2;
%             end
%             a1=strcmp(attname1,'valid_range');
%             if(a1==1)
%                 V50MS.valid_range=attname2;
%             end
%             if(framecounter==1)
%                 V50M10=zeros(numSelectedFiles,1);
%                 V50M25=zeros(numSelectedFiles,1);
%                 V50M50=zeros(numSelectedFiles,1);
%                 V50M75=zeros(numSelectedFiles,1);
%                 V50M90=zeros(numSelectedFiles,1);
%                 V50M100=zeros(numSelectedFiles,1);
%                 V50MLow=zeros(numSelectedFiles,1);
%                 V50MHigh=zeros(numSelectedFiles,1);
%                 V50MNaN=zeros(numSelectedFiles,1);
%             end



       end
    end
    if(idebug==1)
        disp(' ')
    end
    iflag=0;
    if iflag
            eval([varname '=( double(double(double(netcdf.getVar(ncid,i))-0)));'])
            ab=1;

    else
%        eval([varname '=( double(double(double(netcdf.getVar(ncid,i))-0)));'])
        if(a10==1)
            eval([varname '=( double(double(double(netcdf.getVar(ncid,i))-0)));'])
            PSS.values=PS;
            ab=1;
        end
%         if(a20==1)
%             LatitudesS.values=lat;
%         end
% 
%         if(a30==1)
%             LongitudesS.values=lon;
%         end
% 
        if(a40==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));'])
            O3S.values=O3;
        end
        if(a50==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));'])
            QVS.values=QV;
        end

        if(a60==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));'])
            SLPS.values=SLP;
            ab=1;
        end
% 
%         if(a70==1)
% 
%             SLPS.values=SLP;
%         end
% 
%         if(a80==1)
%             T10MS.values=T10M;
%         end
% 
%         if(a90==1)
%             T2MS.values=T2M;
%         end
% 
%         if(a100==1)
%           timeS.values=time;
%         end
% 
%         if(a110==1)
%           TO3S.values=TO3;
%         end
% 
%         if(a120==1)
%           TOXS.values=TO3;
%         end
% 
%         if(a130==1)
%           TQIS.values=TQI;
%         end
% 
%         if(a140==1)
%           TQLS.values=TQL;
%         end
% 
%         if(a150==1)
%           TQVS.values=TQV;
%         end
% 
%         if(a160==1)
%           TROPPBS.values=TROPPB;
%         end
% 
%         if(a170==1)
%           TROPPTS.values=TROPPT;
%         end
% 
%         if(a180==1)
%           TROPPVS.values=TROPPV;
%         end
% 
%         if(a190==1)
%           TROPQS.values=TROPQ;
%         end
% 
%        if(a200==1)
%           TROPTS.values=TROPT;
%        end
% 
%        if(a210==1)
%           TSS.values=TS;
%        end
% 
%        if(a220==1)
%           U10MS.values=U10M;
%        end
% 
%        if(a230==1)
%           U2MS.values=U2M;
%        end
% 
%        if(a240==1)
%           U50MS.values=U50M;
%        end
% 
%        if(a250==1)
%           V10MS.values=V10M;
%        end
% 
%        if(a260==1)
%           V2MS.values=V2M;
%        end
% 
%        if(a270==1)
%           V50MS.values=V50M;
%        end

    end
end

if(idebug==1)
    disp('^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~')
    disp('________________________________________________________')
    disp(' '),disp(' ')
end
netcdf.close(ncid);
fprintf(fid,'%s\n','Finished reading Dataset01 data');
%Now write a Matlab file containing the decoded data
%use the original file name with a .mat extension and eliminate periods
% replaced with a dash
[iper]=strfind(Merra2FileName,'.');
is=1;
ie=iper(3)-1;
Merra2FileStub=Merra2FileName(is:ie);
is=iper(1);
Merra2FileStub(is:is)='-';
is=iper(2);
Merra2FileStub(is:is)='-';
MatFileName=strcat(Merra2FileStub,'-Decoded','.mat');
if(isavefiles==1)
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='LatitudesS LongitudesS DISPHS PSS QV10MS QV2MS SLPS T10MS T2MS';
    varstr2=' timeS TO3S TOXS TQIS TQLS TQVS TSS';
    varstr3=' TROPPBS TROPPTS TROPPVS TROPQS TROPTS';
    varstr4=' U10MS U2MS U50MS V10MS V2MS V50MS';
    varstr=strcat(varstr1,varstr2,varstr3,varstr4);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr);
else
%     dispstr=strcat('Did Not Save Matlab File-',MatFileName);
%     disp(dispstr);
end
%% Create Georeference object Rpix
latlim=[-90 90];
lonlim=[-180 180];
numlon=length(lon);
numlat=length(lat);
rasterSize=[numlat numlon];
Rpix = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','south','RowsStartFrom','west');
westEdge=-180;
eastEdge=180;
southEdge=-90;
northEdge=90;
%% Display the selected data  on a map of the earth
% This dataset has 24 timeslices-only data from a single pre selected
% time slice will be plotted.
% Start with the surface pressure data
ikind=4;
itype=3;
iCityPlot=0;
varname='PS';
iAddToReport=1;
iNewChapter=1;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Continue with the Specific Humidity at 10 m
ikind=5;
itype=3;
iCityPlot=0;
varname='QV10M';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the Specific Humidity at 2 m
ikind=6;
itype=3;
iCityPlot=0;
varname='QV2M';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the Sea Level Pressure
ikind=7;
itype=3;
iCityPlot=0;
varname='SLP';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the Temperature at 10 M
ikind=8;
itype=3;
iCityPlot=0;
varname='T10M';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the Temperature at 2 M
ikind=9;
itype=3;
iCityPlot=0;
varname='T2M';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Total Column Ozone Concentration
ikind=11;
itype=3;
iCityPlot=0;
varname='TO3';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Total Column Odd Oxygen Concentration
ikind=12;
itype=3;
iCityPlot=0;
varname='TOX';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Total Column Precipitable Ice Water
ikind=13;
itype=3;
iCityPlot=0;
varname='TQI';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Total Column Precipitable Liquid Water
ikind=14;
itype=3;
iCityPlot=0;
varname='TQL';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Total Column Precipitable Water Vapor
ikind=15;
itype=3;
iCityPlot=0;
varname='TQV';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)% Total Column Precipitable Water Vapor
ikind=16;
itype=3;
iCityPlot=0;
varname='TROPPB';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
ikind=17;
itype=3;
iCityPlot=0;
varname='TROPPT';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
ikind=18;
itype=3;
iCityPlot=0;
varname='TROPPV';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
ikind=19;
itype=3;
iCityPlot=0;
varname='TROPQ';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
ikind=20;
itype=3;
iCityPlot=0;
varname='TROPT';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
ikind=21;
itype=3;
iCityPlot=0;
varname='TS';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
%% Produce a quiver plot of the wind velocity at 10 m
ikind=22;
itype=4;
iCityPlot=0;
varname='U10M';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01QP(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
%% Produce a quiver plot of the wind velocity at 2 m
ikind=23;
itype=4;
iCityPlot=0;
varname='U2M';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset01QP(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
%% Produce a quiver plot of the wind velocity at 50 m
ikind=24;
itype=4;
iCityPlot=0;
varname='U50M';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=1;
DisplayMerra2Dataset01QP(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
%% Capture Selected Statistics to Holding Arrays
if(framecounter<=numSelectedFiles)
% Start with the Surface Pressure  ikind=4
    data=PSS.values(:,:,numtimeslice);
    fillvalue=PSS.FillValue;
    data(data==fillvalue)=NaN;
    PSValues=data*PascalsToPsi;
    lowcutoff=0;
    highcutoff=20;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(PSValues,lowcutoff,highcutoff);
    PS10(framecounter,1)=val10;
    PS25(framecounter,1)=val25;
    PS50(framecounter,1)=val50;
    PS75(framecounter,1)=val75;
    PS90(framecounter,1)=val90;
    PS100(framecounter,1)=val100;
    PSLow(framecounter,1)=fraclow;
    PSHigh(framecounter,1)=frachigh;
    PSNaN(framecounter,1)=fracNaN;
% Next contnue with the Specific Humidity at 10M
    data=QV10MS.values(:,:,numtimeslice);
    fillvalue=QV10MS.FillValue;
    data(data==fillvalue)=NaN;
    QV10MValues=data;
    lowcutoff=0;
    highcutoff=1;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(QV10MValues,lowcutoff,highcutoff);
    QV10M10(framecounter,1)=val10;
    QV10M25(framecounter,1)=val25;
    QV10M50(framecounter,1)=val50;
    QV10M75(framecounter,1)=val75;
    QV10M90(framecounter,1)=val90;
    QV10M100(framecounter,1)=val100;
    QV10MLow(framecounter,1)=fraclow;
    QV10MHigh(framecounter,1)=frachigh;
    QV10MNaN(framecounter,1)=fracNaN;
% Next contnue with the Specific Humidity at 2M
    data=QV2MS.values(:,:,numtimeslice);
    fillvalue=QV2MS.FillValue;
    data(data==fillvalue)=NaN;
    QV2MValues=data;
    lowcutoff=0;
    highcutoff=1;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(QV2MValues,lowcutoff,highcutoff);
    QV2M10(framecounter,1)=val10;
    QV2M25(framecounter,1)=val25;
    QV2M50(framecounter,1)=val50;
    QV2M75(framecounter,1)=val75;
    QV2M90(framecounter,1)=val90;
    QV2M100(framecounter,1)=val100;
    QV2MLow(framecounter,1)=fraclow;
    QV2MHigh(framecounter,1)=frachigh;
    QV2MNaN(framecounter,1)=fracNaN;
 % Next continue with the Sea Level Pressure
    data=SLPS.values(:,:,numtimeslice);
    fillvalue=SLPS.FillValue;
    data(data==fillvalue)=NaN;
    SLPValues=data*PascalsToPsi;
    lowcutoff=0;
    highcutoff=20;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(SLPValues,lowcutoff,highcutoff);
    SLP10(framecounter,1)=val10;
    SLP25(framecounter,1)=val25;
    SLP50(framecounter,1)=val50;
    SLP75(framecounter,1)=val75;
    SLP90(framecounter,1)=val90;
    SLP100(framecounter,1)=val100;
    SLPLow(framecounter,1)=fraclow;
    SLPHigh(framecounter,1)=frachigh;
    SLPNaN(framecounter,1)=fracNaN;
  % Next contnue with the Air Temp at 10M
    data=T10MS.values(:,:,numtimeslice);
    fillvalue=T10MS.FillValue;
    data(data==fillvalue)=NaN;
    T10MValues=data;
    lowcutoff=200;
    highcutoff=500;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(T10MValues,lowcutoff,highcutoff);
    T10M10(framecounter,1)=val10;
    T10M25(framecounter,1)=val25;
    T10M50(framecounter,1)=val50;
    T10M75(framecounter,1)=val75;
    T10M90(framecounter,1)=val90;
    T10M100(framecounter,1)=val100;
    T10MLow(framecounter,1)=fraclow;
    T10MHigh(framecounter,1)=frachigh;
    T10MNaN(framecounter,1)=fracNaN;
  % Next contnue with the Air Temp at 2M
    data=T2MS.values(:,:,numtimeslice);
    fillvalue=T2MS.FillValue;
    data(data==fillvalue)=NaN;
    T2MValues=data;
    lowcutoff=200;
    highcutoff=500;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(T2MValues,lowcutoff,highcutoff);
    T2M10(framecounter,1)=val10;
    T2M25(framecounter,1)=val25;
    T2M50(framecounter,1)=val50;
    T2M75(framecounter,1)=val75;
    T2M90(framecounter,1)=val90;
    T2M100(framecounter,1)=val100;
    T2MLow(framecounter,1)=fraclow;
    T2MHigh(framecounter,1)=frachigh;
    T2MNaN(framecounter,1)=fracNaN;
 % Total Column Ozone
    data=TO3S.values(:,:,numtimeslice);
    fillvalue=TO3S.FillValue;
    data(data==fillvalue)=NaN;
    TO3Values=data;
    lowcutoff=0;
    highcutoff=1000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TO3Values,lowcutoff,highcutoff);
    TO310(framecounter,1)=val10;
    TO325(framecounter,1)=val25;
    TO350(framecounter,1)=val50;
    TO375(framecounter,1)=val75;
    TO390(framecounter,1)=val90;
    TO3100(framecounter,1)=val100;
    TO3Low(framecounter,1)=fraclow;
    TO3High(framecounter,1)=frachigh;
    TO3NaN(framecounter,1)=fracNaN;
  % Total Column Odd Oxygen
    data=TOXS.values(:,:,numtimeslice);
    fillvalue=TOXS.FillValue;
    data(data==fillvalue)=NaN;
    TOXValues=data;
    lowcutoff=0;
    highcutoff=1000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TOXValues,lowcutoff,highcutoff);
    TOX10(framecounter,1)=val10;
    TOX25(framecounter,1)=val25;
    TOX50(framecounter,1)=val50;
    TOX75(framecounter,1)=val75;
    TOX90(framecounter,1)=val90;
    TOX100(framecounter,1)=val100;
    TOXLow(framecounter,1)=fraclow;
    TOXHigh(framecounter,1)=frachigh;
    TOXNaN(framecounter,1)=fracNaN;
   % Total Precipatable Ice Water
    data=TQIS.values(:,:,numtimeslice);
    fillvalue=TQIS.FillValue;
    data(data==fillvalue)=NaN;
    TQIValues=data;
    lowcutoff=0;
    highcutoff=1;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TQIValues,lowcutoff,highcutoff);
    TQI10(framecounter,1)=val10;
    TQI25(framecounter,1)=val25;
    TQI50(framecounter,1)=val50;
    TQI75(framecounter,1)=val75;
    TQI90(framecounter,1)=val90;
    TQI100(framecounter,1)=val100;
    TQILow(framecounter,1)=fraclow;
    TQIHigh(framecounter,1)=frachigh;
    TQINaN(framecounter,1)=fracNaN;
  % Total Precipatable Liquid Water
    data=TQLS.values(:,:,numtimeslice);
    fillvalue=TQLS.FillValue;
    data(data==fillvalue)=NaN;
    TQLValues=data;
    lowcutoff=0;
    highcutoff=1;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TQLValues,lowcutoff,highcutoff);
    TQL10(framecounter,1)=val10;
    TQL25(framecounter,1)=val25;
    TQL50(framecounter,1)=val50;
    TQL75(framecounter,1)=val75;
    TQL90(framecounter,1)=val90;
    TQL100(framecounter,1)=val100;
    TQLLow(framecounter,1)=fraclow;
    TQLHigh(framecounter,1)=frachigh;
    TQLNaN(framecounter,1)=fracNaN;
   % Total Precipatable Water Vapor
    data=TQVS.values(:,:,numtimeslice);
    fillvalue=TQVS.FillValue;
    data(data==fillvalue)=NaN;
    TQVValues=data;
    lowcutoff=0;
    highcutoff=20;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TQVValues,lowcutoff,highcutoff);
    TQV10(framecounter,1)=val10;
    TQV25(framecounter,1)=val25;
    TQV50(framecounter,1)=val50;
    TQV75(framecounter,1)=val75;
    TQV90(framecounter,1)=val90;
    TQV100(framecounter,1)=val100;
    TQVLow(framecounter,1)=fraclow;
    TQVHigh(framecounter,1)=frachigh;
    TQVNaN(framecounter,1)=fracNaN;
  % Tropopause pressure due to blended estimate
    data=TROPPBS.values(:,:,numtimeslice);
    fillvalue=TROPPBS.FillValue;
    data(data==fillvalue)=NaN;
    data=data*PascalsToPsi;
    TROPPBValues=data;
    lowcutoff=0;
    highcutoff=200;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TROPPBValues,lowcutoff,highcutoff);
    TROPPB10(framecounter,1)=val10;
    TROPPB25(framecounter,1)=val25;
    TROPPB50(framecounter,1)=val50;
    TROPPB75(framecounter,1)=val75;
    TROPPB90(framecounter,1)=val90;
    TROPPB100(framecounter,1)=val100;
    TROPPBLow(framecounter,1)=fraclow;
    TROPPBHigh(framecounter,1)=frachigh;
    TROPPBNaN(framecounter,1)=fracNaN;
  % Tropopause pressure based on thermal estimate
    data=TROPPTS.values(:,:,numtimeslice);
    fillvalue=TROPPTS.FillValue;
    data(data==fillvalue)=NaN;
    data=data*PascalsToPsi;
    TROPPTValues=data;
    lowcutoff=0;
    highcutoff=200;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TROPPTValues,lowcutoff,highcutoff);
    TROPPT10(framecounter,1)=val10;
    TROPPT25(framecounter,1)=val25;
    TROPPT50(framecounter,1)=val50;
    TROPPT75(framecounter,1)=val75;
    TROPPT90(framecounter,1)=val90;
    TROPPT100(framecounter,1)=val100;
    TROPPTLow(framecounter,1)=fraclow;
    TROPPTHigh(framecounter,1)=frachigh;
    TROPPTNaN(framecounter,1)=fracNaN;
  % Tropopause pressure based on EPV Estimate
    data=TROPPVS.values(:,:,numtimeslice);
    fillvalue=TROPPVS.FillValue;
    data(data==fillvalue)=NaN;
    data=data*PascalsToPsi;
    TROPPVValues=data;
    lowcutoff=0;
    highcutoff=200;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TROPPVValues,lowcutoff,highcutoff);
    TROPPV10(framecounter,1)=val10;
    TROPPV25(framecounter,1)=val25;
    TROPPV50(framecounter,1)=val50;
    TROPPV75(framecounter,1)=val75;
    TROPPV90(framecounter,1)=val90;
    TROPPV100(framecounter,1)=val100;
    TROPPVLow(framecounter,1)=fraclow;
    TROPPVHigh(framecounter,1)=frachigh;
    TROPPVNaN(framecounter,1)=fracNaN;
  % Tropopause Specific Humidity Based On Blended TROPP estimate
    data=TROPQS.values(:,:,numtimeslice);
    fillvalue=TROPQS.FillValue;
    data(data==fillvalue)=NaN;
    TROPQValues=data;
    lowcutoff=0;
    highcutoff=1;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TROPQValues,lowcutoff,highcutoff);
    TROPQ10(framecounter,1)=val10;
    TROPQ25(framecounter,1)=val25;
    TROPQ50(framecounter,1)=val50;
    TROPQ75(framecounter,1)=val75;
    TROPQ90(framecounter,1)=val90;
    TROPQ100(framecounter,1)=val100;
    TROPQLow(framecounter,1)=fraclow;
    TROPQHigh(framecounter,1)=frachigh;
    TROPQNaN(framecounter,1)=fracNaN;
  % Tropopause Temperature Based On Blended TROPP estimate
    data=TROPTS.values(:,:,numtimeslice);
    fillvalue=TROPTS.FillValue;
    data(data==fillvalue)=NaN;
    TROPTValues=data;
    lowcutoff=0;
    highcutoff=500;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TROPTValues,lowcutoff,highcutoff);
    TROPT10(framecounter,1)=val10;
    TROPT25(framecounter,1)=val25;
    TROPT50(framecounter,1)=val50;
    TROPT75(framecounter,1)=val75;
    TROPT90(framecounter,1)=val90;
    TROPT100(framecounter,1)=val100;
    TROPTLow(framecounter,1)=fraclow;
    TROPTHigh(framecounter,1)=frachigh;
    TROPTNaN(framecounter,1)=fracNaN;
 %  Surface Skin Temperature
    data=TSS.values(:,:,numtimeslice);
    fillvalue=TSS.FillValue;
    data(data==fillvalue)=NaN;
    TSValues=data;
    lowcutoff=0;
    highcutoff=500;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(TSValues,lowcutoff,highcutoff);
    TS10(framecounter,1)=val10;
    TS25(framecounter,1)=val25;
    TS50(framecounter,1)=val50;
    TS75(framecounter,1)=val75;
    TS90(framecounter,1)=val90;
    TS100(framecounter,1)=val100;
    TSLow(framecounter,1)=fraclow;
    TSHigh(framecounter,1)=frachigh;
    TSNaN(framecounter,1)=fracNaN;
 %  East wind at 10 M
    data=U10MS.values(:,:,numtimeslice);
    fillvalue=U10MS.FillValue;
    data(data==fillvalue)=NaN;
    U10MValues=data;
    lowcutoff=0;
    highcutoff=100;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(U10MValues,lowcutoff,highcutoff);
    U10M10(framecounter,1)=val10;
    U10M25(framecounter,1)=val25;
    U10M50(framecounter,1)=val50;
    U10M75(framecounter,1)=val75;
    U10M90(framecounter,1)=val90;
    U10M100(framecounter,1)=val100;
    U10MLow(framecounter,1)=fraclow;
    U10MHigh(framecounter,1)=frachigh;
    U10MNaN(framecounter,1)=fracNaN;
 %  East wind at 2 M
    data=U2MS.values(:,:,numtimeslice);
    fillvalue=U2MS.FillValue;
    data(data==fillvalue)=NaN;
    U2MValues=data;
    lowcutoff=0;
    highcutoff=100;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(U2MValues,lowcutoff,highcutoff);
    U2M10(framecounter,1)=val10;
    U2M25(framecounter,1)=val25;
    U2M50(framecounter,1)=val50;
    U2M75(framecounter,1)=val75;
    U2M90(framecounter,1)=val90;
    U2M100(framecounter,1)=val100;
    U2MLow(framecounter,1)=fraclow;
    U2MHigh(framecounter,1)=frachigh;
    U2MNaN(framecounter,1)=fracNaN;
  % East wind at 50 M
    data=U50MS.values(:,:,numtimeslice);
    fillvalue=U50MS.FillValue;
    data(data==fillvalue)=NaN;
    U50MValues=data;
    lowcutoff=0;
    highcutoff=100;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(U50MValues,lowcutoff,highcutoff);
    U50M10(framecounter,1)=val10;
    U50M25(framecounter,1)=val25;
    U50M50(framecounter,1)=val50;
    U50M75(framecounter,1)=val75;
    U50M90(framecounter,1)=val90;
    U50M100(framecounter,1)=val100;
    U50MLow(framecounter,1)=fraclow;
    U50MHigh(framecounter,1)=frachigh;
    U50MNaN(framecounter,1)=fracNaN;
 %  North wind at 10 M
    data=V10MS.values(:,:,numtimeslice);
    fillvalue=V10MS.FillValue;
    data(data==fillvalue)=NaN;
    V10MValues=data;
    lowcutoff=0;
    highcutoff=100;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(V10MValues,lowcutoff,highcutoff);
    V10M10(framecounter,1)=val10;
    V10M25(framecounter,1)=val25;
    V10M50(framecounter,1)=val50;
    V10M75(framecounter,1)=val75;
    V10M90(framecounter,1)=val90;
    V10M100(framecounter,1)=val100;
    V10MLow(framecounter,1)=fraclow;
    V10MHigh(framecounter,1)=frachigh;
    V10MNaN(framecounter,1)=fracNaN;
 %  North wind at 2 M
    data=V2MS.values(:,:,numtimeslice);
    fillvalue=V2MS.FillValue;
    data(data==fillvalue)=NaN;
    V2MValues=data;
    lowcutoff=0;
    highcutoff=100;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(V2MValues,lowcutoff,highcutoff);
    V2M10(framecounter,1)=val10;
    V2M25(framecounter,1)=val25;
    V2M50(framecounter,1)=val50;
    V2M75(framecounter,1)=val75;
    V2M90(framecounter,1)=val90;
    V2M100(framecounter,1)=val100;
    V2MLow(framecounter,1)=fraclow;
    V2MHigh(framecounter,1)=frachigh;
    V2MNaN(framecounter,1)=fracNaN;
  % North wind at 50 M
    data=V50MS.values(:,:,numtimeslice);
    fillvalue=V50MS.FillValue;
    data(data==fillvalue)=NaN;
    V50MValues=data;
    lowcutoff=0;
    highcutoff=100;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(V50MValues,lowcutoff,highcutoff);
    V50M10(framecounter,1)=val10;
    V50M25(framecounter,1)=val25;
    V50M50(framecounter,1)=val50;
    V50M75(framecounter,1)=val75;
    V50M90(framecounter,1)=val90;
    V50M100(framecounter,1)=val100;
    V50MLow(framecounter,1)=fraclow;
    V50MHigh(framecounter,1)=frachigh;
    V50MNaN(framecounter,1)=fracNaN;

end
if(framecounter==1)
    yd=str2double(YearMonthStr(1:4));
    md=str2double(YearMonthStr(5:6));
    dd=15;
end
%% Create a series of timetables
if(framecounter==numSelectedFiles)
  stime=datetime(yd,md,dd);
  timestep=calmonths(1);
  fprintf(fid,'%s\n','----Start Creating Tables----');
% Create the Surface Pressure Table ikind=4
  PSTable=table(PS10(:,1),PS25(:,1),PS50(:,1),PS75(:,1),...
      PS90(:,1),PS100(:,1),...
            'VariableNames',{'PS10','PS25','PS50',...
            'PS75','PS90','PS100'});
  PSTT = table2timetable(PSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='PSTable PSTT';
  MatFileName=strcat('PSTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  psstr=strcat('Created PSTT-','Contains Surface Pressure Data-',num2str(4));
  fprintf(fid,'%s\n',psstr);
% Create the Specific Humidity at 10 M ikind=5
  QV10MTable=table(QV10M10(:,1),QV10M25(:,1),QV10M50(:,1),QV10M75(:,1),...
      QV10M90(:,1),QV10M100(:,1),...
            'VariableNames',{'QV10M10','QV10M25','QV10M50',...
            'QV10M75','QV10M90','QV10M100'});
  QV10MTT = table2timetable(QV10MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='QV10MTable QV10MTT';
  MatFileName=strcat('QV10MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  qv10str=strcat('Created QV10MTT-','Contains Speific Humidity at 10 M-',num2str(5));
  fprintf(fid,'%s\n',qv10str);
 % Create the Specific Humidity at 2 M ikind=6
  QV2MTable=table(QV2M10(:,1),QV2M25(:,1),QV2M50(:,1),QV2M75(:,1),...
      QV2M90(:,1),QV2M100(:,1),...
            'VariableNames',{'QV2M10','QV2M25','QV2M50',...
            'QV2M75','QV2M90','QV2M100'});
  QV2MTT = table2timetable(QV2MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='QV2MTable QV2MTT';
  MatFileName=strcat('QV2MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  qv2str=strcat('Created QV2MTT-','Contains Specific Humidity at 2 M-',num2str(6));
  fprintf(fid,'%s\n',qv2str);
 % Create the Sea Level Pressure ikind=7
  SLPTable=table(SLP10(:,1),SLP25(:,1),SLP50(:,1),SLP75(:,1),...
      SLP90(:,1),SLP100(:,1),...
            'VariableNames',{'SLP10','SLP25','SLP50',...
            'SLP75','SLP90','SLP100'});
  SLPTT = table2timetable(SLPTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SLPTable SLPTT';
  MatFileName=strcat('SLPTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  slpstr=strcat('Created SLPTT-','Contains Sea Level Pressure-',num2str(7));
  fprintf(fid,'%s\n',slpstr);
 % Create the Air Temp At 10 M Table ikind=8
  T10MTable=table(T10M10(:,1),T10M25(:,1),T10M50(:,1),T10M75(:,1),...
      T10M90(:,1),T10M100(:,1),...
            'VariableNames',{'T10M10','T10M25','T10M50',...
            'T10M75','T10M90','T10M100'});
  T10MTT = table2timetable(T10MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='T10MTable T10MTT';
  MatFileName=strcat('T10MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  t10str=strcat('Created T10MTT-','Contains Air Temp at 10 M-',num2str(8));
  fprintf(fid,'%s\n',t10str);
 % Create the Air Temp At 2 M Table ikind=9
  T2MTable=table(T2M10(:,1),T2M25(:,1),T2M50(:,1),T2M75(:,1),...
      T2M90(:,1),T2M100(:,1),...
            'VariableNames',{'T2M10','T2M25','T2M50',...
            'T2M75','T2M90','T2M100'});
  T2MTT = table2timetable(T2MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='T2MTable T2MTT';
  MatFileName=strcat('T2MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  t2str=strcat('Created T2MTT-','Contains Air Temp at 2 M-',num2str(9));
  fprintf(fid,'%s\n',t2str);
 % Create the Total Column Ozone ikind=11
  TO3Table=table(TO310(:,1),TO325(:,1),TO350(:,1),TO375(:,1),...
      TO390(:,1),TO3100(:,1),...
            'VariableNames',{'TO310','TO325','TO350',...
            'TO375','TO390','TO3100'});
  TO3TT = table2timetable(TO3Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TO3Table TO3TT';
  MatFileName=strcat('TO3Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tO3str=strcat('Created TO3TT-','Contains Total Column Ozone-',num2str(11));
  fprintf(fid,'%s\n',tO3str);
% Create the Total Column Odd Oxygen ikind=12
  TOXTable=table(TOX10(:,1),TOX25(:,1),TOX50(:,1),TOX75(:,1),...
      TOX90(:,1),TOX100(:,1),...
            'VariableNames',{'TOX10','TOX25','TOX50',...
            'TOX75','TOX90','TOX100'});
  TOXTT = table2timetable(TOXTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TOXTable TOXTT';
  MatFileName=strcat('TOXTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  toxstr=strcat('Created TOXTT-','Contains Total Column Odd Oxygen-',num2str(12));
  fprintf(fid,'%s\n',toxstr);
 % Create the Total Precipatable Ice Water ikind=13
  TQITable=table(TQI10(:,1),TQI25(:,1),TQI50(:,1),TQI75(:,1),...
      TQI90(:,1),TQI100(:,1),...
            'VariableNames',{'TQI10','TQI25','TQI50',...
            'TQI75','TQI90','TQI100'});
  TQITT = table2timetable(TQITable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TQITable TQITT';
  MatFileName=strcat('TQITable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tqistr=strcat('Created TQITT-','Contains Total Precipitable Ice Water-',num2str(13));
  fprintf(fid,'%s\n',tqistr);
 % Create the Total Precipatable Liquid Water ikind=14
  TQLTable=table(TQL10(:,1),TQL25(:,1),TQL50(:,1),TQL75(:,1),...
      TQL90(:,1),TQL100(:,1),...
            'VariableNames',{'TQL10','TQL25','TQL50',...
            'TQL75','TQL90','TQL100'});
  TQLTT = table2timetable(TQLTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TQLTable TQLTT';
  MatFileName=strcat('TQITable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tqlstr=strcat('Created TQLTT-','Contains Total Precipitable Liquid Water-',num2str(14));
  fprintf(fid,'%s\n',tqlstr);
 % Create the Total Precipatable Water Vapor ikind=15
  TQVTable=table(TQV10(:,1),TQV25(:,1),TQV50(:,1),TQV75(:,1),...
      TQV90(:,1),TQV100(:,1),...
            'VariableNames',{'TQV10','TQV25','TQV50',...
            'TQV75','TQV90','TQV100'});
  TQVTT = table2timetable(TQVTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TQVTable TQVTT';
  MatFileName=strcat('TQVTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tqvstr=strcat('Created TQVTT-','Contains Total Precipitable Water Vapor-',num2str(15));
  fprintf(fid,'%s\n',tqvstr);
% Create the Troposphere pressure estimate based on blended estimate ikind=16
  TROPPBTable=table(TROPPB10(:,1),TROPPB25(:,1),TROPPB50(:,1),TROPPB75(:,1),...
      TROPPB90(:,1),TROPPB100(:,1),...
            'VariableNames',{'TROPPB10','TROPPB25','TROPPB50',...
            'TROPPB75','TROPPB90','TROPPB100'});
  TROPPBTT = table2timetable(TROPPBTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TROPPBTable TROPPBTT';
  MatFileName=strcat('TROPPBTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tropbbstr=strcat('Created TROPPBTT-','Contains blended tropossphere pressure in psi-',num2str(16));
  fprintf(fid,'%s\n',tropbbstr);
% Create the Troposphere pressure estimate based on thermal estimate
% ikind=17
  TROPPTTable=table(TROPPT10(:,1),TROPPT25(:,1),TROPPT50(:,1),TROPPT75(:,1),...
      TROPPT90(:,1),TROPPT100(:,1),...
            'VariableNames',{'TROPPT10','TROPPT25','TROPPT50',...
            'TROPPT75','TROPPT90','TROPPT100'});
  TROPPTTT = table2timetable(TROPPTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TROPPTTable TROPPTTT';
  MatFileName=strcat('TROPPTTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tropbtstr=strcat('Created TROPPTTT-','Contains troposphere pressure based on thermal estimate in psi-',num2str(17));
  fprintf(fid,'%s\n',tropbtstr);
% Create the Troposphere pressure estimate based on EPV estimate
% ikind=18
  TROPPVTable=table(TROPPV10(:,1),TROPPV25(:,1),TROPPV50(:,1),TROPPV75(:,1),...
      TROPPV90(:,1),TROPPV100(:,1),...
            'VariableNames',{'TROPPV10','TROPPV25','TROPPV50',...
            'TROPPV75','TROPPV90','TROPPV100'});
  TROPPVTT = table2timetable(TROPPVTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TROPPVTable TROPPVTT';
  MatFileName=strcat('TROPPVTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  troppvstr=strcat('Created TROPPVTT-','Contains troposphere pressure based on EPV estimate',num2str(18));
  fprintf(fid,'%s\n',troppvstr);
% Create the Troposphere Specific Humidity estimate based on blended
% estimate  ikind=19
  TROPQTable=table(TROPQ10(:,1),TROPQ25(:,1),TROPQ50(:,1),TROPQ75(:,1),...
      TROPQ90(:,1),TROPQ100(:,1),...
            'VariableNames',{'TROPQ10','TROPQ25','TROPQ50',...
            'TROPQ75','TROPQ90','TROPQ100'});
  TROPQTT = table2timetable(TROPQTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TROPQTable TROPQTT';
  MatFileName=strcat('TROPQTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tropqstr=strcat('Created TROPQTT-','Contains troposphere specific humidity based on blended estimate',num2str(19));
  fprintf(fid,'%s\n',tropqstr);
% Create the Troposphere Temperature estimate based on blended
% estimate  ikind=20
  TROPTTable=table(TROPT10(:,1),TROPT25(:,1),TROPT50(:,1),TROPT75(:,1),...
      TROPT90(:,1),TROPT100(:,1),...
            'VariableNames',{'TROPT10','TROPT25','TROPT50',...
            'TROPT75','TROPT90','TROPT100'});
  TROPTTT = table2timetable(TROPTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TROPTTable TROPTTT';
  MatFileName=strcat('TROPTTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  troptstr=strcat('Created TROPTTT-','Contains troposphere temperature based on blended estimate',num2str(20));
  fprintf(fid,'%s\n',troptstr);
% Surface Skin Temperature Table
% ikind=21
  TSTable=table(TS10(:,1),TS25(:,1),TS50(:,1),TS75(:,1),...
      TS90(:,1),TS100(:,1),...
            'VariableNames',{'TS10','TS25','TS50',...
            'TS75','TS90','TS100'});
  TSTT = table2timetable(TSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TSTable TSTT';
  MatFileName=strcat('TSTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tsstr=strcat('Created TSTT-','Contains earth surface skin temp',num2str(21));
  fprintf(fid,'%s\n',tsstr);
% East Wind at 10 m
% ikind=22
  U10MTable=table(U10M10(:,1),U10M25(:,1),U10M50(:,1),U10M75(:,1),...
      U10M90(:,1),U10M100(:,1),...
            'VariableNames',{'U10M10','U10M25','U10M50',...
            'U10M75','U10M90','U10M100'});
  U10MTT = table2timetable(U10MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='U10MTable U10MTT';
  MatFileName=strcat('U10MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  u10mstr=strcat('Created U10MTT-','Contains east wind at 10 m ',num2str(22));
  fprintf(fid,'%s\n',u10mstr);
% East Wind at 2 m
% ikind=23
  U2MTable=table(U2M10(:,1),U2M25(:,1),U2M50(:,1),U2M75(:,1),...
      U2M90(:,1),U2M100(:,1),...
            'VariableNames',{'U2M10','U2M25','U2M50',...
            'U2M75','U2M90','U2M100'});
  U2MTT = table2timetable(U2MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='U2MTable U2MTT';
  MatFileName=strcat('U2MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  u2mstr=strcat('Created U2MTT-','Contains east wind at 2 m ',num2str(23));
  fprintf(fid,'%s\n',u2mstr);
% East Wind at 50 m
% ikind=24
  U50MTable=table(U50M10(:,1),U50M25(:,1),U50M50(:,1),U50M75(:,1),...
      U50M90(:,1),U50M100(:,1),...
            'VariableNames',{'U50M10','U50M25','U50M50',...
            'U50M75','U50M90','U50M100'});
  U50MTT = table2timetable(U50MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='U50MTable U50MTT';
  MatFileName=strcat('U50MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  u50mstr=strcat('Created U50MTT-','Contains east wind at 50 m ',num2str(24));
  fprintf(fid,'%s\n',u50mstr);
% North Wind at 10 m
% ikind=25
  V10MTable=table(V10M10(:,1),V10M25(:,1),V10M50(:,1),V10M75(:,1),...
      V10M90(:,1),V10M100(:,1),...
            'VariableNames',{'V10M10','V10M25','V10M50',...
            'V10M75','V10M90','V10M100'});
  V10MTT = table2timetable(V10MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='V10MTable V10MTT';
  MatFileName=strcat('V10MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  v10mstr=strcat('Created V10MTT-','Contains north wind at 10 m ',num2str(25));
  fprintf(fid,'%s\n',v10mstr);
% North Wind at 2 m
% ikind=26
  V2MTable=table(V2M10(:,1),V2M25(:,1),V2M50(:,1),V2M75(:,1),...
      V2M90(:,1),V2M100(:,1),...
            'VariableNames',{'V2M10','V2M25','V2M50',...
            'V2M75','V2M90','V2M100'});
  V2MTT = table2timetable(V2MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='V2MTable V2MTT';
  MatFileName=strcat('V2MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  v2mstr=strcat('Created V2MTT-','Contains north wind at 2 m ',num2str(26));
  fprintf(fid,'%s\n',v2mstr);
% North Wind at 50 m
% ikind=27
  V50MTable=table(V50M10(:,1),V50M25(:,1),V50M50(:,1),V50M75(:,1),...
      V50M90(:,1),V50M100(:,1),...
            'VariableNames',{'V50M10','V50M25','V50M50',...
            'V50M75','V50M90','V50M100'});
  V50MTT = table2timetable(V50MTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='V50MTable V50MTT';
  MatFileName=strcat('V50MTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  v50mstr=strcat('Created V50MTT-','Contains north wind at 50 m ',num2str(24));
  fprintf(fid,'%s\n',v50mstr);
%% Plot the Surface Pressure Table Results
   titlestr=strcat('Instantaneous-SurfacePressure-',num2str(yd));
   ikind=4;
   iAddToReport=1;
   iNewChapter=1;
   iCloseChapter=0;
   PlotPSTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% Continue with the Specific Humidity at 10 M
   titlestr=strcat('Instantaneous-SpecificHumidity10M-',num2str(yd));
   ikind=5;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotQV10MTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
   % Continue with the Specific Humidity at 2 M
   titlestr=strcat('Instantaneous-SpecificHumidity2M-',num2str(yd));
   ikind=6;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotQV10MTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Total Precipitable Ice Water
   titlestr=strcat('Instantaneous-TotalPrecipIceWater-',num2str(yd));
   ikind=13;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTQITable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Total Precipitable Liquid Water
   titlestr=strcat('Instantaneous-TotalPrecipLiquidWater-',num2str(yd));
   ikind=14;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTQITable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Total Precipitable Water Vapor
   titlestr=strcat('Instantaneous-TotalPrecipWaterVapor-',num2str(yd));
   ikind=15;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTQITable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Tropospheric pressure estimate based on a blended
 % technique
   titlestr=strcat('Instantaneous-TropPressureBlended-',num2str(yd));
   ikind=16;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTROPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Tropospheric pressure estimate based on a thermal
 % estimate
   titlestr=strcat('Instantaneous-TropPressureThermal-',num2str(yd));
   ikind=17;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTROPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Tropospheric pressure estimate based on a thermal
 % estimate
   titlestr=strcat('Instantaneous-TropSpecific-Humidity-',num2str(yd));
   ikind=18;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTROPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Tropospheric specific humidity based on a blended
 % estimate
   titlestr=strcat('Instantaneous-TropSpecific-Humidity-',num2str(yd));
   ikind=19;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTROPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the Tropospheric specific humidity based on a blended
 % estimate
   titlestr=strcat('Instantaneous-TropSpecific-Temp-',num2str(yd));
   ikind=20;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTROPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the earth surface skin temp
   titlestr=strcat('Instantaneous-EarthSurface-Temp-',num2str(yd));
   ikind=21;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotTROPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the east wind velocity component at 10 m
   titlestr=strcat('Instantaneous-EastWind-10m-',num2str(yd));
   ikind=22;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotUVTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the east wind velocity component at 2 m
   titlestr=strcat('Instantaneous-EastWind-2m-',num2str(yd));
   ikind=23;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotUVTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the east wind velocity component at 50 m
   titlestr=strcat('Instantaneous-EastWind-50m-',num2str(yd));
   ikind=24;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotUVTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the north wind velocity component at 10 m
   titlestr=strcat('Instantaneous-NorthWind-10m-',num2str(yd));
   ikind=25;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotUVTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the north wind velocity component at 2 m
   titlestr=strcat('Instantaneous-NorthWind-2m-',num2str(yd));
   ikind=26;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0; 
   PlotUVTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 % Continue with the north wind velocity component at 50 m
   titlestr=strcat('Instantaneous-NorthWind-50m-',num2str(yd));
   ikind=27;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=1; 
   PlotUVTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
end

