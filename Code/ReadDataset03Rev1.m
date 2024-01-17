function ReadDataset03Rev1(nowFile,nowpath)
% Modified: This function will read in the the Merra-2 data set 03
% This dataset is of the item M2IUNXASM_5.12.4
% This Rev 1 version was created to shift the order in which image
% statistics are calculated and to remove NaN values from statistical
% calculations
% Written By: Stephen Forczyk
% Created: Nov 6,2023
% Revised: Rest of Nov 2023 adding code for all dataset items
% Revised: Dec 7,2023 added TSStatsTable to store data on air temp data
% at median value over a number of defined geographic areas
% Revised: Dec 11,2023 added QVStatsTable to do the same for specific
% humidity
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
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            HS.values=H;
        end

        if(a120==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            US.values=U;
        end

        if(a130==1)
            eval([varname '=( double(double(double(double(netcdf.getVar(ncid,i))-0))));']);
            VS.values=V;
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
    for k=1:nlats
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
    QVS01=zeros(numSelectedFiles,1);
    QVS25=zeros(numSelectedFiles,1);
    QVS50=zeros(numSelectedFiles,1);
    QVS75=zeros(numSelectedFiles,1);
    QVS90=zeros(numSelectedFiles,1);
    QVS100=zeros(numSelectedFiles,1);
    QVSLow=zeros(numSelectedFiles,1);
    QVSHigh=zeros(numSelectedFiles,1);
    QVSNaN=zeros(numSelectedFiles,1);
    SLPS01=zeros(numSelectedFiles,1);
    SLPS25=zeros(numSelectedFiles,1);
    SLPS50=zeros(numSelectedFiles,1);
    SLPS75=zeros(numSelectedFiles,1);
    SLPS90=zeros(numSelectedFiles,1);
    SLPS100=zeros(numSelectedFiles,1);
    SLPSLow=zeros(numSelectedFiles,1);
    SLPSHigh=zeros(numSelectedFiles,1);
    SLPSNaN=zeros(numSelectedFiles,1);
    TS01=zeros(numSelectedFiles,1);
    TS25=zeros(numSelectedFiles,1);
    TS50=zeros(numSelectedFiles,1);
    TS75=zeros(numSelectedFiles,1);
    TS90=zeros(numSelectedFiles,1);
    TS100=zeros(numSelectedFiles,1);
    TSLow=zeros(numSelectedFiles,1);
    TSHigh=zeros(numSelectedFiles,1);
    TSNaN=zeros(numSelectedFiles,1);
    US01=zeros(numSelectedFiles,1);
    US25=zeros(numSelectedFiles,1);
    US50=zeros(numSelectedFiles,1);
    US75=zeros(numSelectedFiles,1);
    US90=zeros(numSelectedFiles,1);
    US100=zeros(numSelectedFiles,1);
    USLow=zeros(numSelectedFiles,1);
    USHigh=zeros(numSelectedFiles,1);
    USNaN=zeros(numSelectedFiles,1);
    VS01=zeros(numSelectedFiles,1);
    VS25=zeros(numSelectedFiles,1);
    VS50=zeros(numSelectedFiles,1);
    VS75=zeros(numSelectedFiles,1);
    VS90=zeros(numSelectedFiles,1);
    VS100=zeros(numSelectedFiles,1);
    VSLow=zeros(numSelectedFiles,1);
    VSHigh=zeros(numSelectedFiles,1);
    VSNaN=zeros(numSelectedFiles,1);
    TSStats=zeros(numSelectedFiles,10);
    QVStats=zeros(numSelectedFiles,10);
    O3Stats=zeros(numSelectedFiles,10);
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
    O3Values1= O3SValues;
    O3Values2= O3SValues;
    O3Values3= O3SValues;
    O3Values4= O3SValues;
    O3Values5= O3SValues;
    O3Values6= O3SValues;
    O3Values7= O3SValues;
    O3Values8= O3SValues;
    O3Values9= O3SValues;
    O3Values10= O3SValues;
    lowcutoff=1E-10;
    highcutoff=1E-4;
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
    iSubtract=0;
    iSubval=0;
 % Compute the Stats for Mask 1-Germany
    sumMaskArea1=sum(sum(RasterAreaGrid.*Merra2WorkingMask1));
    O3Values1=O3Values1.*Merra2WorkingMask1;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values1,sumMaskArea1,lowcutoff,highcutoff);
    O3Stats(framecounter,1)=val50W;
 % Compute the Stats for Mask 2-Finland
    sumMaskArea2=sum(sum(RasterAreaGrid.*Merra2WorkingMask2));
    O3Values2=O3Values2.*Merra2WorkingMask2;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values2,sumMaskArea2,lowcutoff,highcutoff);
    O3Stats(framecounter,2)=val50W;
 % Compute the Stats for Mask 3-UK
    sumMaskArea3=sum(sum(RasterAreaGrid.*Merra2WorkingMask3));
    O3Values3=O3Values3.*Merra2WorkingMask3;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values3,sumMaskArea3,lowcutoff,highcutoff);
    O3Stats(framecounter,3)=val50W;
 % Compute the Stats for Mask 4-Sudan
    sumMaskArea4=sum(sum(RasterAreaGrid.*Merra2WorkingMask4));
    O3Values4=O3Values4.*Merra2WorkingMask4;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values4,sumMaskArea4,lowcutoff,highcutoff);
    O3Stats(framecounter,4)=val50W;
 % Compute the Stats for Mask 5-SouthArica
    sumMaskArea5=sum(sum(RasterAreaGrid.*Merra2WorkingMask5));
    O3Values5=O3Values5.*Merra2WorkingMask5;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values5,sumMaskArea5,lowcutoff,highcutoff);
    O3Stats(framecounter,5)=val50W;
 % Compute the Stats for Mask 6-India
    sumMaskArea6=sum(sum(RasterAreaGrid.*Merra2WorkingMask6));
    O3Values6=O3Values6.*Merra2WorkingMask6;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values6,sumMaskArea6,lowcutoff,highcutoff);
    O3Stats(framecounter,6)=val50W;
 % Compute the Stats for Mask 7-Australia
    sumMaskArea7=sum(sum(RasterAreaGrid.*Merra2WorkingMask7));
    O3Values7=O3Values7.*Merra2WorkingMask7;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values7,sumMaskArea7,lowcutoff,highcutoff);
    O3Stats(framecounter,7)=val50W;
 % Compute the Stats for Mask 8-California
    sumMaskArea8=sum(sum(RasterAreaGrid.*Merra2WorkingMask8));
    O3Values8=O3Values8.*Merra2WorkingMask8;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values8,sumMaskArea8,lowcutoff,highcutoff);
    O3Stats(framecounter,8)=val50W;
 % Compute the Stats for Mask 9-Texas
    sumMaskArea9=sum(sum(RasterAreaGrid.*Merra2WorkingMask9));
    O3Values9=O3Values9.*Merra2WorkingMask9;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values9,sumMaskArea9,lowcutoff,highcutoff);
    O3Stats(framecounter,9)=val50W;
 % Compute the Stats for Mask 10-Peru
    sumMaskArea10=sum(sum(RasterAreaGrid.*Merra2WorkingMask10));
    O3Values10=O3Values10.*Merra2WorkingMask10;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(O3Values10,sumMaskArea10,lowcutoff,highcutoff);
    O3Stats(framecounter,10)=val50W;
    ab=1;
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
 % Continue with the Specific Humidity (kg/kg)
    QVSValues=QVS.values(:,:,iPress42,iTimeSlice);
    fillvalue=QVS.FillValue;
    QVSValues(QVSValues==fillvalue)=NaN;
    QVSValues1= QVSValues;
    QVSValues2= QVSValues;
    QVSValues3= QVSValues;
    QVSValues4= QVSValues;
    QVSValues5= QVSValues;
    QVSValues6= QVSValues;
    QVSValues7= QVSValues;
    QVSValues8= QVSValues;
    QVSValues9= QVSValues;
    QVSValues10= QVSValues;
    lowcutoff=1E-9;
    highcutoff=.99;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(QVSValues,lowcutoff,highcutoff);
    QVS01(framecounter,1)=val01;
    QVS25(framecounter,1)=val25;
    QVS50(framecounter,1)=val50;
    QVS75(framecounter,1)=val75;
    QVS90(framecounter,1)=val90;
    QVS100(framecounter,1)=val100;
    QVSLow(framecounter,1)=fraclow;
    QVSHigh(framecounter,1)=frachigh;
    QVSNaN(framecounter,1)=fracNaN; 
    iSubtract=0;
    iSubval=0;
 % Compute the Stats for Mask 1-Germany
    sumMaskArea1=sum(sum(RasterAreaGrid.*Merra2WorkingMask1));
    QVSValues1=QVSValues1.*Merra2WorkingMask1;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues1,sumMaskArea1,lowcutoff,highcutoff);
    QVStats(framecounter,1)=val50W;
 % Compute the Stats for Mask 2-Finland
    sumMaskArea2=sum(sum(RasterAreaGrid.*Merra2WorkingMask2));
    QVSValues2=QVSValues2.*Merra2WorkingMask2;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues2,sumMaskArea2,lowcutoff,highcutoff);
    QVStats(framecounter,2)=val50W;
 % Compute the Stats for Mask 3-UK
    sumMaskArea3=sum(sum(RasterAreaGrid.*Merra2WorkingMask3));
    QVSValues3=QVSValues3.*Merra2WorkingMask3;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues3,sumMaskArea3,lowcutoff,highcutoff);
    QVStats(framecounter,3)=val50W;
 % Compute the Stats for Mask 4-Sudan
    sumMaskArea4=sum(sum(RasterAreaGrid.*Merra2WorkingMask4));
    QVSValues4=QVSValues4.*Merra2WorkingMask4;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues4,sumMaskArea4,lowcutoff,highcutoff);
    QVStats(framecounter,4)=val50W;
 % Compute the Stats for Mask 5-SouthArica
    sumMaskArea5=sum(sum(RasterAreaGrid.*Merra2WorkingMask5));
    QVSValues5=QVSValues5.*Merra2WorkingMask5;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues5,sumMaskArea5,lowcutoff,highcutoff);
    QVStats(framecounter,5)=val50W;
 % Compute the Stats for Mask 6-India
    sumMaskArea6=sum(sum(RasterAreaGrid.*Merra2WorkingMask6));
    QVSValues6=QVSValues6.*Merra2WorkingMask6;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues6,sumMaskArea6,lowcutoff,highcutoff);
    QVStats(framecounter,6)=val50W;
 % Compute the Stats for Mask 7-Australia
    sumMaskArea7=sum(sum(RasterAreaGrid.*Merra2WorkingMask7));
    QVSValues7=QVSValues7.*Merra2WorkingMask7;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues7,sumMaskArea7,lowcutoff,highcutoff);
    QVStats(framecounter,7)=val50W;
 % Compute the Stats for Mask 8-California
    sumMaskArea8=sum(sum(RasterAreaGrid.*Merra2WorkingMask8));
    QVSValues8=QVSValues8.*Merra2WorkingMask8;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues8,sumMaskArea8,lowcutoff,highcutoff);
    QVStats(framecounter,8)=val50W;
 % Compute the Stats for Mask 9-Texas
    sumMaskArea9=sum(sum(RasterAreaGrid.*Merra2WorkingMask9));
    QVSValues9=QVSValues9.*Merra2WorkingMask9;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues9,sumMaskArea9,lowcutoff,highcutoff);
    QVStats(framecounter,9)=val50W;
 % Compute the Stats for Mask 10-Peru
    sumMaskArea10=sum(sum(RasterAreaGrid.*Merra2WorkingMask10));
    QVSValues10=QVSValues10.*Merra2WorkingMask10;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(QVSValues10,sumMaskArea10,lowcutoff,highcutoff);
    QVStats(framecounter,10)=val50W;
    ab=1;
 % Continue with the Sea Level Pressure (kPA)
    SLPSValues=SLPS.values(:,:,iTimeSlice)/1000;
    fillvalue=SLPS.FillValue;
    SLPSValues(SLPSValues==fillvalue)=NaN;
    lowcutoff=.01;
    highcutoff=120;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(SLPSValues,lowcutoff,highcutoff);
    SLPS01(framecounter,1)=val01;
    SLPS25(framecounter,1)=val25;
    SLPS50(framecounter,1)=val50;
    SLPS75(framecounter,1)=val75;
    SLPS90(framecounter,1)=val90;
    SLPS100(framecounter,1)=val100;
    SLPSLow(framecounter,1)=fraclow;
    SLPSHigh(framecounter,1)=frachigh;
    SLPSNaN(framecounter,1)=fracNaN;
  % Temperature (Deg-K)
    TSValues=TS.values(:,:,iPress42,iTimeSlice);
    fillvalue=TS.FillValue;
    xcedvalue=0.99*TS.FillValue;
    [nnrows,nncols]=size(TSValues);
    nantot=0;
    for ii=1:nnrows
        for jj=1:nncols
            nowVal=TSValues(ii,jj);
            if(nowVal>=xcedvalue)
                TSValues(ii,jj)=NaN;
                nantot=nantot+1;
            else
                nowVal=nowVal-273.5;
                TSValues(ii,jj)=nowVal;
            end
        end
    end
    lowcutoff=-100;
    highcutoff=100;
    TSValues1=TSValues+273.15;
    TSValues2=TSValues1;
    TSValues3=TSValues1;
    TSValues4=TSValues1;
    TSValues5=TSValues1;
    TSValues6=TSValues1;
    TSValues7=TSValues1;
    TSValues8=TSValues1;
    TSValues9=TSValues1;
    TSValues10=TSValues1;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(TSValues,lowcutoff,highcutoff);
    TS01(framecounter,1)=val01;
    TS25(framecounter,1)=val25;
    TS50(framecounter,1)=val50;
    TS75(framecounter,1)=val75;
    TS90(framecounter,1)=val90;
    TS100(framecounter,1)=val100;
    TSLow(framecounter,1)=fraclow;
    TSHigh(framecounter,1)=frachigh;
    TSNaN(framecounter,1)=fracNaN;  
    iSubtract=1;
    iSubval=273.15;
%% Make a summary table for the Air Temperature 
 % Compute the Stats for Mask 1-Germany
    sumMaskArea1=sum(sum(RasterAreaGrid.*Merra2WorkingMask1));
    TSValues1=TSValues1.*Merra2WorkingMask1;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues1,sumMaskArea1,100,400);
    TSStats(framecounter,1)=val50W;
 % Compute the Stats for Mask 2-Finland
    sumMaskArea2=sum(sum(RasterAreaGrid.*Merra2WorkingMask2));
    TSValues2=TSValues2.*Merra2WorkingMask2;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues2,sumMaskArea2,100,400);
    TSStats(framecounter,2)=val50W;
 % Compute the Stats for Mask 3-UK
    sumMaskArea3=sum(sum(RasterAreaGrid.*Merra2WorkingMask3));
    TSValues3=TSValues3.*Merra2WorkingMask3;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues3,sumMaskArea3,100,400);
    TSStats(framecounter,3)=val50W;
 % Compute the Stats for Mask 4-Sudan
    sumMaskArea4=sum(sum(RasterAreaGrid.*Merra2WorkingMask4));
    TSValues4=TSValues4.*Merra2WorkingMask4;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues4,sumMaskArea4,100,400);
    TSStats(framecounter,4)=val50W;
 % Compute the Stats for Mask 5-SouthArica
    sumMaskArea5=sum(sum(RasterAreaGrid.*Merra2WorkingMask5));
    TSValues5=TSValues5.*Merra2WorkingMask5;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues5,sumMaskArea5,100,400);
    TSStats(framecounter,5)=val50W;
 % Compute the Stats for Mask 6-India
    sumMaskArea6=sum(sum(RasterAreaGrid.*Merra2WorkingMask6));
    TSValues6=TSValues6.*Merra2WorkingMask6;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues6,sumMaskArea6,100,400);
    TSStats(framecounter,6)=val50W;
 % Compute the Stats for Mask 7-Australia
    sumMaskArea7=sum(sum(RasterAreaGrid.*Merra2WorkingMask7));
    TSValues7=TSValues7.*Merra2WorkingMask7;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues7,sumMaskArea7,100,400);
    TSStats(framecounter,7)=val50W;
 % Compute the Stats for Mask 8-California
    sumMaskArea8=sum(sum(RasterAreaGrid.*Merra2WorkingMask8));
    TSValues8=TSValues8.*Merra2WorkingMask8;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues8,sumMaskArea8,100,400);
    TSStats(framecounter,8)=val50W;
 % Compute the Stats for Mask 9-Texas
    sumMaskArea9=sum(sum(RasterAreaGrid.*Merra2WorkingMask9));
    TSValues9=TSValues9.*Merra2WorkingMask9;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues9,sumMaskArea9,100,400);
    TSStats(framecounter,9)=val50W;
 % Compute the Stats for Mask 10-Peru
    sumMaskArea10=sum(sum(RasterAreaGrid.*Merra2WorkingMask10));
    TSValues10=TSValues10.*Merra2WorkingMask10;
    [val01W,val25W,val50W,val75W,val90W,val100W,fraclowW,frachighW,fracgoodW,fracNaNW] = GetWDistributionStats(TSValues10,sumMaskArea10,100,400);
    TSStats(framecounter,10)=val50W;
  % East Wind Component(m/s)
    USValues=US.values(:,:,iPress42,iTimeSlice);
    fillvalue=US.FillValue;
    USValues(USValues==fillvalue)=NaN;
    lowcutoff=-50;
    highcutoff=50;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(USValues,lowcutoff,highcutoff);
    US01(framecounter,1)=val01;
    US25(framecounter,1)=val25;
    US50(framecounter,1)=val50;
    US75(framecounter,1)=val75;
    US90(framecounter,1)=val90;
    US100(framecounter,1)=val100;
    USLow(framecounter,1)=fraclow;
    USHigh(framecounter,1)=frachigh;
    USNaN(framecounter,1)=fracNaN;
  % North Wind Component(m/s)
    VSValues=VS.values(:,:,iPress42,iTimeSlice);
    fillvalue=VS.FillValue;
    VSValues(VSValues==fillvalue)=NaN;
    lowcutoff=-50;
    highcutoff=50;
    [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev4(VSValues,lowcutoff,highcutoff);
    VS01(framecounter,1)=val01;
    VS25(framecounter,1)=val25;
    VS50(framecounter,1)=val50;
    VS75(framecounter,1)=val75;
    VS90(framecounter,1)=val90;
    VS100(framecounter,1)=val100;
    VSLow(framecounter,1)=fraclow;
    VSHigh(framecounter,1)=frachigh;
    VSNaN(framecounter,1)=fracNaN; 
    ab=2;
end
%% Gets stats on Selected Variables On Defined Map Areas
if(framecounter<=numSelectedFiles)

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
% Display Ozone Mixing Ratio
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
% Continue with the Surface Pressure
ikind=3;
itype=3;
iCityPlot=0;
varname='PSS';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the Specific Humidity at the selected level
ikind=4;
itype=3;
iCityPlot=0;
varname='QVS';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the Sea Level Pressure
ikind=5;
itype=3;
iCityPlot=0;
varname='SLP';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the Temperature at the chosen level and time
ikind=6;
itype=3;
iCityPlot=0;
varname='TS';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the East Wind Component at the chosen level and time
ikind=7;
itype=3;
iCityPlot=0;
varname='US';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=0;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now plot the North Wind Component at the chosen level and time
ikind=8;
itype=3;
iCityPlot=0;
varname='VS';
iAddToReport=1;
iNewChapter=0;
iCloseChapter=1;
DisplayMerra2Dataset03(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Now display the wind velocity components and Windstress
% ikind=9;
% itype=3;
% iCityPlot=0;
% varname='WS';
% iAddToReport=1;
% iNewChapter=1;
% iCloseChapter=1;
% DisplayMerra2DatasetWindStress(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
if(framecounter==1)
    yd=str2double(YearMonthStr(1:4));
    md=str2double(YearMonthStr(5:6));
    dd=15;
end
%% Create a series of timetables
if(framecounter==numSelectedFiles)
    if(iTimeSlice==1)
        TimeStr='-00-Hrs-GMT';
    elseif(iTimeSlice==2)
        TimeStr='-06-Hrs-GMT';
    elseif(iTimeSlice==3)
        TimeStr='-12-Hrs-GMT';
    elseif(iTimeSlice==4)
        TimeStr='-18-Hrs-GMT';
    end
  stime=datetime(yd,md,dd);
  timestep=calmonths(1);
  fprintf(fid,'%s\n','----Start Creating Tables----');
% Create the Geopotential Height Table ikind=1
  HSTable=table(HS01(:,1),HS25(:,1),HS50(:,1),HS75(:,1),...
      HS90(:,1),HS100(:,1),...
            'VariableNames',{'HS01','HS25','HS50',...
            'HS75','HS90','HS100'});
  HSTT = table2timetable(HSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='HSTable HSTT';
  MatFileName=strcat('HSTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  hsstr=strcat('Created HSTT-','Contains Temperature Data-',num2str(4));
  fprintf(fid,'%s\n',hsstr);
% Create the Ozone Mixing Ratio Table ikind=2
  O3STable=table(O3S01(:,1),O3S25(:,1),O3S50(:,1),O3S75(:,1),...
      O3S90(:,1),O3S100(:,1),...
            'VariableNames',{'O3S01','O3S25','O3S50',...
            'O3S75','O3S90','O3S100'});
  O3STT = table2timetable(O3STable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='O3STable O3STT';
  MatFileName=strcat('O3STable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  o3sstr=strcat('Created O3STT-','Contains Ozone Mixing Ratio Data-',num2str(4));
  fprintf(fid,'%s\n',o3sstr);
% Create Surface Pressure  Table ikind=3
  PSSTable=table(PSS01(:,1),PSS25(:,1),PSS50(:,1),PSS75(:,1),...
      PSS90(:,1),PSS100(:,1),...
            'VariableNames',{'PSS01','PSS25','PSS50',...
            'PSS75','PSS90','PSS100'});
  PSSTT = table2timetable(PSSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='PSSTable PSSTT';
  MatFileName=strcat('PSSTable',YearMonthStr,TimeStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  psstr=strcat('Created PSSTT-','Contains Surface Pressure Data-',num2str(4));
  fprintf(fid,'%s\n',psstr);
% Create the Specific Humidity Table ikind=4
  QVSTable=table(QVS01(:,1),QVS25(:,1),QVS50(:,1),QVS75(:,1),...
      QVS90(:,1),QVS100(:,1),...
            'VariableNames',{'QVS01','QVS25','QVS50',...
            'QVS75','QVS90','QVS100'});
  QVSTT = table2timetable(QVSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='QVSTable QVSTT';
  MatFileName=strcat('QVSTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  qvsstr=strcat('Created QVSTT-','Contains Speific Humidity at One Pressure Level-',num2str(5));
  fprintf(fid,'%s\n',qvsstr);
%% Create the Sea Level Pressure ikind=5
  SLPSTable=table(SLPS01(:,1),SLPS25(:,1),SLPS50(:,1),SLPS75(:,1),...
      SLPS90(:,1),SLPS100(:,1),...
            'VariableNames',{'SLPS01','SLPS25','SLPS50',...
            'SLPS75','SLPS90','SLPS100'});
  SLPSTT = table2timetable(SLPSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SLPSTable SLPSTT';
  MatFileName=strcat('SLPSTable',YearMonthStr,TimeStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  slpsstr=strcat('Created SLPSTT-','Contains Sea Level Pressure-',num2str(7));
  fprintf(fid,'%s\n',slpsstr);
%% Create the Temperature Table ikind=6
  TSTable=table(TS01(:,1),TS25(:,1),TS50(:,1),TS75(:,1),...
      TS90(:,1),TS100(:,1),...
            'VariableNames',{'TS01','TS25','TS50',...
            'TS75','TS90','TS100'});
  TSTT = table2timetable(TSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TSTable TSTT';
  MatFileName=strcat('TSTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tsstr=strcat('Created TSTT-','Contains Temperature Data-',num2str(4));
  fprintf(fid,'%s\n',tsstr);
%% Create East Wind Component Table ikind=7
  USTable=table(US01(:,1),US25(:,1),US50(:,1),US75(:,1),...
      US90(:,1),US100(:,1),...
            'VariableNames',{'US01','US25','US50',...
            'US75','US90','US100'});
  USTT = table2timetable(USTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='USTable USTT';
  MatFileName=strcat('USTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  usstr=strcat('Created USTT-','Contains East Wind Data-',num2str(4));
  fprintf(fid,'%s\n',usstr);
%% Create North Wind Component Table ikind=8
  VSTable=table(VS01(:,1),VS25(:,1),VS50(:,1),VS75(:,1),...
      VS90(:,1),VS100(:,1),...
            'VariableNames',{'VS01','VS25','VS50',...
            'VS75','VS90','VS100'});
  VSTT = table2timetable(VSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='VSTable VSTT';
  MatFileName=strcat('VSTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  vsstr=strcat('Created VSTT-','Contains North Wind Data-',num2str(4));
  fprintf(fid,'%s\n',vsstr);
%% Create Table For Temps For First 5 Countries
    TSStatsTable=table(TSStats(:,1),TSStats(:,2),TSStats(:,3),TSStats(:,4),TSStats(:,5),...
         'VariableNames',{'Germany','Finland','UK','Sudan','SouthAfrica'});
    TSSTT = table2timetable(TSStatsTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TSStatsTable TSSTT';
    MatFileName=strcat('TSStatsTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    tssstr=strcat('Created TSSTT-','Contains Five Country Temp Data-',num2str(4));
    fprintf(fid,'%s\n',tssstr);
%% Create Table For Temps For Second 5 Countries
    TSStats2Table=table(TSStats(:,6),TSStats(:,7),TSStats(:,8),TSStats(:,9),TSStats(:,10),...
         'VariableNames',{'India','Australia','California','Texas','Peru'});
    TSS2TT = table2timetable(TSStats2Table,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='TSStats2Table TSS2TT';
    MatFileName=strcat('TSStats2Table',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    tss2str=strcat('Created TSS2TT-','Contains Second 6 Country Country Temp Data-',num2str(4));
    fprintf(fid,'%s\n',tss2str);
    ab=1;
%% Create Table For Specific Humidity For First 5 Countries
    QVStatsTable=table(QVStats(:,1),QVStats(:,2),QVStats(:,3),QVStats(:,4),QVStats(:,5),...
         'VariableNames',{'Germany','Finland','UK','Sudan','SouthAfrica'});
    QVStatTT = table2timetable(QVStatsTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='QVStatsTable QVStatTT';
    MatFileName=strcat('QVStatsTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    qvsstr=strcat('Created QVStatSTT-','Contains Five Country QV Data-',num2str(4));
    fprintf(fid,'%s\n',qvsstr);
%% Create Table For Temps For Second 5 Countries
    QVStats2Table=table(QVStats(:,6),QVStats(:,7),QVStats(:,8),QVStats(:,9),QVStats(:,10),...
         'VariableNames',{'India','Australia','California','Texas','Peru'});
    QVStat2TT = table2timetable(QVStats2Table,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='QVStats2Table QVStat2TT';
    MatFileName=strcat('QVStats2Table',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    qvss2str=strcat('Created QVStat2TT-','Contains Second 6 Country Country QV Data-',num2str(4));
    fprintf(fid,'%s\n',qvss2str);
    ab=1;
%% Create Table For Ozone Mixing Ratio For First 5 Countries
    O3StatsTable=table(O3Stats(:,1),O3Stats(:,2),O3Stats(:,3),O3Stats(:,4),O3Stats(:,5),...
         'VariableNames',{'Germany','Finland','UK','Sudan','SouthAfrica'});
    O3StatTT = table2timetable(O3StatsTable,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='O3StatsTable O3StatTT';
    MatFileName=strcat('O3StatsTable',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    o3str=strcat('Created O3StatSTT-','Contains Five Country O3 Data-',num2str(4));
    fprintf(fid,'%s\n',o3str);
%% Create Table For Temps For Second 5 Countries
    O3Stats2Table=table(O3Stats(:,6),O3Stats(:,7),O3Stats(:,8),O3Stats(:,9),O3Stats(:,10),...
         'VariableNames',{'India','Australia','California','Texas','Peru'});
    O3Stat2TT = table2timetable(O3Stats2Table,'TimeStep',timestep,'StartTime',stime);
    eval(['cd ' tablepath(1:length(tablepath)-1)]);
    actionstr='save';
    varstr1='O3Stats2Table O3Stat2TT';
    MatFileName=strcat('O3Stats2Table',YearMonthStr,TimeStr,'-PrsLvl-',num2str(iPress42,2),'.mat');
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
    eval(cmdString)
    o32str=strcat('Created O3Stat2TT-','Contains Second 6 Country Country O3 Data-',num2str(4));
    fprintf(fid,'%s\n',o32str);
    ab=1;
%% Plot the Geopotential Height Results
   titlestr=strcat('Monthly-Averaged-GeoPotential-Temp-',num2str(yd));
   ikind=1;
   iAddToReport=1;
   iNewChapter=1;
   iCloseChapter=0;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Continue Ozone Mixing Ratio
   titlestr=strcat('Monthly-Averaged-OzoneMixingRatio-',num2str(yd));
   ikind=2;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Continue Surface Pressure
   titlestr=strcat('Monthly-Averaged-Surface-Pressure-',num2str(yd));
   ikind=3;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Continue Specific Humidity
   titlestr=strcat('Monthly-Averaged-Specific-Humidity-',num2str(yd));
   ikind=4;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Continue Sea Level Pressure
   titlestr=strcat('Monthly-Averaged-SeaLevel-Pressure-',num2str(yd));
   ikind=5;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Continue with the Monthly Averaged Air Temp
   titlestr=strcat('Monthly-Averaged-Global-Temp-',num2str(yd));
   ikind=6;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Continue with the Monthly Averaged East Wind Magnitude
   titlestr=strcat('Monthly-Averaged-East-Wind-',num2str(yd));
   ikind=7;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Continue with the Monthly Averaged North Wind Magnitude
   titlestr=strcat('Monthly-Averaged-North-Wind-',num2str(yd));
   ikind=8;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=1;
   PlotDataset03Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
%% Now create a section for the Region 1 Median Temperatures
   titlestr=strcat('Monthly-Averaged-Region1-Temps-',num2str(yd));
   ikind=10;
   iAddToReport=1;
   iNewChapter=1;
   iCloseChapter=0;
   PlotDataset03RegionsTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Now create a section for the Region 2 Median Temperatures
   titlestr=strcat('Monthly-Averaged-Region2-Temps-',num2str(yd));
   ikind=11;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03RegionsTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Now create a section for the Region 1 Median Specific Humidity
   titlestr=strcat('Monthly-Averaged-Region1-SHumidity-',num2str(yd));
   ikind=12;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03RegionsTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Now create a section for the Region 2 Median Specific Humidity
   titlestr=strcat('Monthly-Averaged-Region2-SHumidity-',num2str(yd));
   ikind=13;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03RegionsTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Now create a section for the Region 1 Median Ozone Mixing Ratio
   titlestr=strcat('Monthly-Averaged-Region1-O3Ratio-',num2str(yd));
   ikind=14;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotDataset03RegionsTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Now create a section for the Region 2 Median Ozone Mixing Ratio
   titlestr=strcat('Monthly-Averaged-Region2-O3Ratio-',num2str(yd));
   ikind=15;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=1;
   PlotDataset03RegionsTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
end

