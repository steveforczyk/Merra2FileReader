function ReadDataset03Rev1(nowFile,nowpath)
% Modified: This function will read in the the Merra-2 data set 03
% This dataset is of the item M2IUNXASM_5.12.4
% This Rev 1 version was created to shift the order in which image
% statistics are calculated and to remove NaN values from statistical
% calculations
% Written By: Stephen Forczyk
% Created: Nov 6,2023
% Revised: 

% Classification: Unclassified

global BandDataS MetaDataS;
global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevelUsed PressureLabels42 PressureLabels72 framecounter;
global TimeSlices iTimeSlice;

global Merra2FileName Merra2Dat Merra2ShortFileName numSelectedFiles;

global idebug;
global LatitudesS LongitudesS LevS;
global O3S PSS QVS HS QV2MS SLPS TS T2MS;
global timeS US VS;
global HS01 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S01 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;
global PSS01 PSS25 PSS50 PSS75 PSS90 PSS100 PSSLow PSSHigh PSSNaN;
global HSValues O3SValues PSSValues;
global TROPPBS TROPPTS TROPPVS TROPQS TROPTS;
global U10MS U2MS U50MS V10MS V2MS V50MS;
global numtimeslice framecounter;
global YearMonthDayStr1 YearMonthDayStr2;
global ChoiceList;
global PascalsToMilliBars PascalsToPsi;
global PSTable PSTT;

global SLPTable SLPTT;


global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;
global yd md dd;
global iCityPlot;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

% additional paths needed for mapping
global matpath1 mappath ;
global savepath jpegpath pdfpath logpath moviepath tablepath;
global YearMonthStr MonthStr YearStr MonthYearStr;
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
[iper]=strfind(Merra2ShortFileName,'.');
numper=length(iper);
strlen=length(Merra2ShortFileName);
is=iper(2)+1;
ie=strlen;
currYearMonth=Merra2ShortFileName(is:ie);
YearMonthStr=currYearMonth;
YearStr=YearMonthStr(1:4);
MonthStr1=YearMonthStr(5:6);
monthnum=str2double(MonthStr1);
[MonthName] = ConvertMonthNumToStr(monthnum);
MonthStr=MonthName;
MonthYearStr=strcat(MonthStr,'-',YearStr);
ab=3;
LatitudesS=struct('values',[],'long_name',[],'units',[],...
    'vmax',[],'vmin',[],'valid_range',[]);
LongitudesS=LatitudesS;
LevS=LatitudesS;
PSS=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'vmax',[],'vmin',[],...
    'valid_range',[]);
O3S=PSS;
QVS=PSS;
SLPS=PSS;
HS=PSS;
US=PSS;
VS=PSS;


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
       a20=strcmp(varname,'lat');
       a30=strcmp(varname,'lon');
       a40=strcmp(varname,'O3');
       a50=strcmp(varname,'QV');
       a60=strcmp(varname,'SLP');
       a70=strcmp(varname,'T');
       a80=strcmp(varname,'lev');
       a100=strcmp(varname,'time');
       a110=strcmp(varname,'H');
       a120=strcmp(varname,'U');
       a130=strcmp(varname,'V');

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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LatitudesS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LatitudesS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LatitudesS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LatitudesS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LatitudesS.valid_range=attname2;
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LongitudesS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LongitudesS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LongitudesS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LongitudesS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LongitudesS.valid_range=attname2;
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                TS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                TS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                TS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                TS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                TS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                TS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                TS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                TS.valid_range=attname2;
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LevS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LevS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LevS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LevS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LevS.valid_range=attname2;
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                timeS.long_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                timeS.units=attname2;
            end
            a1=strcmp(attname1,'time_increment');
            if(a1==1)
                timeS.time_increment=attname2;
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
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                HS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                HS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                HS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                HS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                HS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                HS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                HS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                HS.valid_range=attname2;
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
                US.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                US.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                US.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                US.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                US.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                US.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                US.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                US.valid_range=attname2;
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
                VS.long_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                VS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                VS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                VS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                VS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                VS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                VS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                VS.valid_range=attname2;
            end


       end
    end
    if(idebug==1)
        disp(' ')
    end
    iflag=0;
    if iflag
            eval([varname '=( double(double(double(netcdf.getVar(ncid,i))-0)));']);
            ab=1;

    else
        if(a10==1)
            eval([varname '=( double(double(double(netcdf.getVar(ncid,i))-0)));'])
            PSS.values=PS;
        end
        if(a20==1)
            eval([varname '=(double(netcdf.getVar(ncid,i))-0);'])
            LatitudesS.values=lat;
        end

        if(a30==1)
            eval([varname '=(double(netcdf.getVar(ncid,i))-0);'])
            LongitudesS.values=lon;
        end

        if(a40==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            O3S.values=O3;
        end
        if(a50==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            QVS.values=QV;
        end

        if(a60==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            SLPS.values=SLP;
        end

        if(a70==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            TS.values=T;
        end

        if(a80==1)
            eval([varname '=(double(netcdf.getVar(ncid,i))-0);']);
            LevS.values=lev;
        end

        if(a100==1)
          eval([varname '=(double(netcdf.getVar(ncid,i))-0);']);
          timeS.values=time;
          ab=1;
        end

        if(a110==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            HS.values=H;
        end

        if(a120==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            US.values=U;
        end

        if(a130==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            VS.values=U;
        end



    end
end

if(idebug==1)
    disp('^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~')
    disp('________________________________________________________')
    disp(' '),disp(' ')
end
netcdf.close(ncid);
framestr=strcat('*****Finished ReadingDataset03 data from frame-',num2str(framecounter),'*****');
fprintf(fid,'%s\n',framestr);
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
    varstr1='LatitudesS LongitudesS PSS ';
    varstr2=' timeS O3S QVS SLPS HS US VS LevS';
    varstr=strcat(varstr1,varstr2);
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
%% Initialize statistics holding arrays
if(framecounter==1)
% Initialize Statistic Hold Arrays for HS the geopotential height
    HS01=zeros(numSelectedFiles,1);
    HS25=zeros(numSelectedFiles,1);
    HS50=zeros(numSelectedFiles,1);
    HS75=zeros(numSelectedFiles,1);
    HS90=zeros(numSelectedFiles,1);
    HS100=zeros(numSelectedFiles,1);
    HSLow=zeros(numSelectedFiles,1);
    HSHigh=zeros(numSelectedFiles,1);
    HSNaN=zeros(numSelectedFiles,1);
    O3S01=zeros(numSelectedFiles,1);
    O3S25=zeros(numSelectedFiles,1);
    O3S50=zeros(numSelectedFiles,1);
    O3S75=zeros(numSelectedFiles,1);
    O3S90=zeros(numSelectedFiles,1);
    O3S100=zeros(numSelectedFiles,1);    
    O3SLow=zeros(numSelectedFiles,1);
    O3SHigh=zeros(numSelectedFiles,1);
    O3SNaN=zeros(numSelectedFiles,1);
    PSS01=zeros(numSelectedFiles,1);
    PSS25=zeros(numSelectedFiles,1);
    PSS50=zeros(numSelectedFiles,1);
    PSS75=zeros(numSelectedFiles,1);
    PSS90=zeros(numSelectedFiles,1);
    PSS100=zeros(numSelectedFiles,1);
    PSSLow=zeros(numSelectedFiles,1);
    PSSHigh=zeros(numSelectedFiles,1);
    PSSNaN=zeros(numSelectedFiles,1);
end
%% Capture Selected Statistics to Holding Arrays
if(framecounter<=numSelectedFiles)
% Start with the The Geopotential Height in m
    HSValues=HS.values(:,:,iPress42,iTimeSlice);
    fillvalue=HS.FillValue;
    HSValues(HSValues==fillvalue)=NaN;
    lowcutoff=0;
    highcutoff=50000;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(HSValues,lowcutoff,highcutoff);
    HS01(framecounter,1)=val01;
    HS25(framecounter,1)=val25;
    HS50(framecounter,1)=val50;
    HS75(framecounter,1)=val75;
    HS90(framecounter,1)=val90;
    HS100(framecounter,1)=val100;
    HSLow(framecounter,1)=fraclow;
    HSHigh(framecounter,1)=frachigh;
    HSNaN(framecounter,1)=fracNaN;
% Continue with the mixing ratio
    O3SValues=O3S.values(:,:,iPress42,iTimeSlice);
    fillvalue=O3S.FillValue;
    O3SValues(O3SValues==fillvalue)=NaN;
    lowcutoff=1E-9;
    highcutoff=1E-5;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(O3SValues,lowcutoff,highcutoff);
    O3S01(framecounter,1)=val01;
    O3S25(framecounter,1)=val25;
    O3S50(framecounter,1)=val50;
    O3S75(framecounter,1)=val75;
    O3S90(framecounter,1)=val90;
    O3S100(framecounter,1)=val100;
    O3SLow(framecounter,1)=fraclow;
    O3SHigh(framecounter,1)=frachigh;
    O3SNaN(framecounter,1)=fracNaN;
 % Continue with the SurfacePressure in kPa
    PSSValues=PSS.values(:,:,iTimeSlice)/1000;
    fillvalue=PSS.FillValue;
    PSSValues(PSSValues==fillvalue)=NaN;
    lowcutoff=1;
    highcutoff=120;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(PSSValues,lowcutoff,highcutoff);
    PSS01(framecounter,1)=val01;
    PSS25(framecounter,1)=val25;
    PSS50(framecounter,1)=val50;
    PSS75(framecounter,1)=val75;
    PSS90(framecounter,1)=val90;
    PSS100(framecounter,1)=val100;
    PSSLow(framecounter,1)=fraclow;
    PSSHigh(framecounter,1)=frachigh;
    PSSNaN(framecounter,1)=fracNaN; 
    ab=2;
end
%% Display the selected data  on a map of the earth
% This dataset has 4 timeslices-only data from a single pre selected
% time slice will be plotted.
% Geopotential Height
ikind=1;
itype=3;
iCityPlot=0;
varname='HS';
iAddToReport=1;
iNewChapter=1;
iCloseChapter=0;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Ozone Mixing Ratio
ikind=2;
itype=3;
iCityPlot=0;
varname='O3S';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
ab=1;
% Continue with the Surface Pressure
ikind=3;
itype=3;
iCityPlot=0;
varname='PSS';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=1;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Now plot the Specific Humidity at 2 m
% ikind=6;
% itype=3;
% iCityPlot=0;
% varname='QV2M';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Now plot the Sea Level Pressure
% ikind=7;
% itype=3;
% iCityPlot=0;
% varname='SLP';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Now plot the Temperature at 10 M
% ikind=8;
% itype=3;
% iCityPlot=0;
% varname='T10M';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Now plot the Temperature at 2 M
% ikind=9;
% itype=3;
% iCityPlot=0;
% varname='T2M';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Total Column Ozone Concentration
% ikind=11;
% itype=3;
% iCityPlot=0;
% varname='TO3';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Total Column Odd Oxygen Concentration
% ikind=12;
% itype=3;
% iCityPlot=0;
% varname='TOX';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Total Column Precipitable Ice Water
% ikind=13;
% itype=3;
% iCityPlot=0;
% varname='TQI';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% % Total Column Precipitable Liquid Water
% ikind=14;
% itype=3;
% iCityPlot=0;
% varname='TQL';
% iAddToReport=1;
% iNewChapter=0;
% iCloseChapter=0;
% DisplayMerra2Dataset01(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
%if(framecounter==1)
% Initialize Statistic Hold Arrays for HS the geopotential height
%     HS10=zeros(numSelectedFiles,1);
%     HS25=zeros(numSelectedFiles,1);
%     HS50=zeros(numSelectedFiles,1);
%     HS75=zeros(numSelectedFiles,1);
%     HS90=zeros(numSelectedFiles,1);
%     HS100=zeros(numSelectedFiles,1);
%     HSLow=zeros(numSelectedFiles,1);
%     HSHigh=zeros(numSelectedFiles,1);
%     HSNaN=zeros(numSelectedFiles,1);
%     O3S10=zeros(numSelectedFiles,1);
%     O3S25=zeros(numSelectedFiles,1);
%     O3S50=zeros(numSelectedFiles,1);
%     O3S75=zeros(numSelectedFiles,1);
%     O3S90=zeros(numSelectedFiles,1);
%     O3S100=zeros(numSelectedFiles,1);
%     O3SLow=zeros(numSelectedFiles,1);
%     O3SHigh=zeros(numSelectedFiles,1);
%     O3SNaN=zeros(numSelectedFiles,1);
%     PSS10=zeros(numSelectedFiles,1);
%     PSS25=zeros(numSelectedFiles,1);
%     PSS50=zeros(numSelectedFiles,1);
%     PSS75=zeros(numSelectedFiles,1);
%     PSS90=zeros(numSelectedFiles,1);
%     PSS100=zeros(numSelectedFiles,1);
%     PSSLow=zeros(numSelectedFiles,1);
%     PSSHigh=zeros(numSelectedFiles,1);
%     PSSNaN=zeros(numSelectedFiles,1);
%end
%% Capture Selected Statistics to Holding Arrays
% if(framecounter<=numSelectedFiles)
% % Start with the The Geopotential Height in m
%     HSValues=HS.values(:,:,iPress42,iTimeSlice);
%     fillvalue=HS.FillValue;
%     HSValues(HSValues==fillvalue)=NaN;
%     lowcutoff=0;
%     highcutoff=50000;
%     [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(HSValues,lowcutoff,highcutoff);
%     HS10(framecounter,1)=val10;
%     HS25(framecounter,1)=val25;
%     HS50(framecounter,1)=val50;
%     HS75(framecounter,1)=val75;
%     HS90(framecounter,1)=val90;
%     HS100(framecounter,1)=val100;
%     HSLow(framecounter,1)=fraclow;
%     HSHigh(framecounter,1)=frachigh;
%     HSNaN(framecounter,1)=fracNaN;
% % Continue with the mixing ratio
%     O3SValues=O3S.values(:,:,iPress42,iTimeSlice);
%     fillvalue=O3S.FillValue;
%     O3SValues(O3SValues==fillvalue)=NaN;
%     lowcutoff=1E-9;
%     highcutoff=1E-5;
%     [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(O3SValues,lowcutoff,highcutoff);
%     O3S10(framecounter,1)=val10;
%     O3S25(framecounter,1)=val25;
%     O3S50(framecounter,1)=val50;
%     O3S75(framecounter,1)=val75;
%     O3S90(framecounter,1)=val90;
%     O3S100(framecounter,1)=val100;
%     O3SLow(framecounter,1)=fraclow;
%     O3SHigh(framecounter,1)=frachigh;
%     O3SNaN(framecounter,1)=fracNaN;
%  % Continue with the SurfacePressure in kPa
%     
%  ab=1;
%     PSSValues=PSS.values(:,:,iTimeSlice)/1000;
%     fillvalue=PSS.FillValue;
%     lowcutoff=1;
%     highcutoff=120;
%     [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(PSSValues,lowcutoff,highcutoff);
%     PSS10(framecounter,1)=val10;
%     PSS25(framecounter,1)=val25;
%     PSS50(framecounter,1)=val50;
%     PSS75(framecounter,1)=val75;
%     PSS90(framecounter,1)=val90;
%     PSS100(framecounter,1)=val100;
%     PSSLow(framecounter,1)=fraclow;
%     PSSHigh(framecounter,1)=frachigh;
%     PSSNaN(framecounter,1)=fracNaN; 
%     ab=2;
% end
if(framecounter==1)
    yd=str2double(YearMonthStr(1:4));
    md=str2double(YearMonthStr(5:6));
    dd=15;
end
%% Create a series of timetables
if(framecounter>numSelectedFiles)
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

