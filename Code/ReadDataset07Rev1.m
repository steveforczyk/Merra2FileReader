function ReadDataset07Rev1(nowFile,nowpath)
% Modified: This function will read in the the Merra-2 data set 03
% This dataset is of the item M2IUNXASM_5.12.4
% This Rev 1 version was created to shift the order in which image
% statistics are calculated and to remove NaN values from statistical
% calculations
% Written By: Stephen Forczyk
% Created: Mar 13.2024
% Revised: 



% Classification: Unclassified

global BandDataS MetaDataS;
global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevelUsed PressureLabels42 PressureLabels72 framecounter;
global TimeSlices iTimeSlice;
global LatSpacing LonSpacing RasterAreas RadiusCalc;
global RasterLats RasterLons RasterAreaGrid;
global sumMaskArea1 sumMaskArea2 sumMaskArea3 sumMaskArea4 sumMaskArea5;
global sumMaskArea6 sumMaskArea7 sumMaskArea8 sumMaskArea9 sumMaskArea10;
global TSValues1 TSValues2 TSValues3 TSValues4 TSValues5;
global TSValues6 TSValues7 TSValues8 TSValues9 TSValues10;
global QVSValues1 QVSValues2 QVSValues3 QVSValues4 QVSValues5;
global QVSValues6 QVSValues7 QVSValues8 QVSValues9 QVSValues10;
global O3Values1 O3Values2 O3Values3 O3Values4 O3Values5;
global O3Values6 O3Values7 O3Values8 O3Values9 O3Values10;

global Merra2FileName Merra2Dat Merra2ShortFileName numSelectedFiles;

global idebug;
global iSubtract iSubval;
global LatitudesS LongitudesS LevS;
global O3S PSS QVS HS SLPS TS ;
global timeS US VS;
global HS01 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S01 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;
global PSS01 PSS25 PSS50 PSS75 PSS90 PSS100 PSSLow PSSHigh PSSNaN;
global QVS01 QVS25 QVS50 QVS75 QVS90 QVS100 QVSLow QVSHigh QVSNaN;
global SLPS01 SLPS25 SLPS50 SLPS75 SLPS90 SLPS100 SLPSLow SLPSHigh SLPSNaN;
global TS01 TS25 TS50 TS75 TS90 TS100 TSLow TSHigh TSNaN;
global US01 US25 US50 US75 US90 US100 USLow USHigh USNaN;
global VS01 VS25 VS50 VS75 VS90 VS100 VSLow VSHigh VSNaN;
global HSValues O3SValues PSSValues QVSValues SLPSValues TSValues USValues VSValues;
global TSTable TSTT HSTable HSTT O3STable O3STT SLPSTable SLPSTT;
global QVSTable QVSTT PSSTable PSSTT USTable USTT VSTable VSTT;
global WindStress01 WindStress25 WindStress50 WindStress75 WindStress75 WindStress90 WindStress100;
global numtimeslice framecounter;
global YearMonthDayStr1 YearMonthDayStr2;
global ChoiceList;
global PascalsToMilliBars PascalsToPsi;
global PSTable PSTT;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global Merra2WorkingMask6 Merra2WorkingMask7;
global Merra2WorkingMask8 Merra2WorkingMask9 Merra2WorkingMask10;
global TSStats TSStatsTable TSSTT TSStats2Table TSS2TT;
global QVStats QVStatsTable QVStatTT QVStats2Table QVStat2TT;
global O3Stats O3StatsTable O3StatTT O3Stats2Table O3Stat2TT;
global SLPTable SLPTT;


global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;
global yd md dd;
global iCityPlot;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

% additional paths needed for mapping
global matpath1 mappath oceanmappath;
global savepath jpegpath pdfpath logpath moviepath tablepath;
global YearMonthStr MonthStr YearStr MonthYearStr;
global fid isavefiles;
global GridFileName;

global ROIName1 ROIName2 ROIName3 ROIName4 ROIName5;
global ROIName6 ROIName7 ROIName8 ROIName9 ROIName10;

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
% Contents of file base on ncdisp
% lat   1D
% lon   1D
% lev   1D
% time  1D
% SLP   3D
% PS    3D
% H     4D
% T     4D
% U     4D
% V     4D
% QV    4D
% O3    4D

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
    %        eval([varname '=( double(double(double(netcdf.getVar(ncid,i))-0)));']);
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

%         if(a40==1)
%             eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
%             O3S.values=O3;
%         end
        if(a50==1)
%            QVS.values=ncread(nowFile,'QV');
%             eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
%             QVS.values=QV;
        end

        if(a60==1)
 %           SLPS.values=ncread(nowFile,'SLP');
%             eval([varname '=(double(double(double(netcdf.getVar(ncid,i))-0)));']);
%             SLPS.values=SLP;
        end

        if(a70==1)
            TS.values=ncread(nowFile,'T');
%             eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
%             TS.values=T;
            ab=1;
        end

        if(a80==1)
            eval([varname '=(double(netcdf.getVar(ncid,i))-0);']);
            LevS.values=lev;
        end

        if(a100==1)
          eval([varname '=(double(netcdf.getVar(ncid,i))-0);']);
          timeS.values=time;
        end

        if(a110==1)
%            HS.values=ncread(nowFile,'H');
%            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
%            HS.values=H;
        end

        if(a120==1)
            US.values=ncread(nowFile,'U');
%             eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
%             US.values=U;
        end

        if(a130==1)
            VS.values=ncread(nowFile,'V');
%             eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
%             VS.values=V;
        end



    end
end

if(idebug==1)
    disp('^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~')
    disp('________________________________________________________')
    disp(' '),disp(' ')
end
netcdf.close(ncid);
framestr=strcat('*****Finished ReadingDataset07 data from frame-',num2str(framecounter),'*****');
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
    varstr1='LatitudesS LongitudesS TS ';
    varstr2=' timeS  US VS LevS';
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
if(framecounter==1)
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
    westEdge=-180;
    eastEdge=180;
    southEdge=-90;
    northEdge=90;
    Merra2DataRasterLon=zeros(numlon,numlat);
    Merra2DataRasterLat=zeros(numlon,numlat);
    deltaLon=0.625;
    deltaLat=0.500;
    for i=1:numlon
        nowlon=westEdge+(i-1)*deltaLon;
        for j=1:numlat
            nowlat=southEdge+(j-1)*deltaLat;
            Merra2DataRasterLon(i,j)=nowlon;
            Merra2DataRasterLat(i,j)=nowlat;
        end
    end
    RasterLats=Merra2DataRasterLat;
    RasterLons=Merra2DataRasterLon;
%% Now calculate the area of each Raster point. This on varies by latitude
% Get the area of each cell based on the latitude
    nlats=length(RasterLats);
    nlons=length(RasterLons);
    RadiusCalc=zeros(nlats,1);
    LatSpacing=0.5;
    LonSpacing=0.625;
    lon1=10;
    lon2=lon1+LonSpacing;
    deg2rad=pi/180;
    areakmlast=0;
    for k=1:nlats % Check this out-this may be wrong SMF Feb 11,2024
        lat1=RasterLats(k,1);
        lat2=RasterLats(k,1)+LatSpacing;
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
        RadiusCalc(k,1)=radius;
    end
    [nr,~]=size(RasterLats);
    [nc,~]=size(RasterLons);
%     RasterAreaGrid=zeros(nc,nr);
% % Now make an area grid that will have the same values of Area for each
% % latitude point regardless 
%         for ii=1:nr
%             nowArea=RasterAreas(ii,1);
%             for jj=1:nc
%                 RasterAreaGrid(jj,ii)=nowArea;
%             end
%         end
% Load Raster Grid Areas
eval(['cd ' oceanmappath(1:length(oceanmappath)-1)]);
load(GridFileName,'RasterAreaGrid','RasterLats','RasterLons');
ab=1;
end


