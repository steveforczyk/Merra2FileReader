function ReadMonthlyMeanRadDiagnostics(nowFile,path)
% Modified: This function will read in the the Merra-2 data set 2D monthly
% mean averaged radiation diagnostics
% This is dataset 8
% Written By: Stephen Forczyk
% Created: Apr 5,2023
% Revised: Apr 10-12: Added code to save selected variables on a per
% Revised: Apr 13-22 Added code the plot additional variables
% Revised: May 7,2023 added table for ikind 26,27,28
% Revised: May 10,2023 added 3 additional variables to correlation study
% Revised: May 11,2023 added 1 addiional variable to correlation study
% ikind==33
% Revised: May 12,2023 added 1 additional value to plot ikind=37 TAUTOT
% frame basis to create tables
% Classification: Unclassified

global BandDataS MetaDataS;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global numlat numlon Rpix latlim lonlim rasterSize;
global yd md dd;

global idebug;
global LonS LatS TimeS AlbedoS AlbnirdfS AlbnirdrS AlbvisdfS;
global AlbvisdrS CLDHGHS CLDLOWS CLDMIDS CLDTOTS;
global EmissS LWGABS LWGABCLRS LWGABCLRCLNS;
global LWGEMS LWGNTS LWGNTCLRS LWGNTCLRCLNS LWTUPS LWTUPCLRS;
global LWTUPCLRCLNS SWGDNS SWGDNCLRS SWGNTS SWGNTCLNS;
global SWGNTCLRS SWGNTCLRCLNS SWTDNS SWTNTS;
global SWTNTCLNS SWTNTCLRS SWTNTCLRCLNS TAUHGHS TAULOWS TAUMIDS TAUTOTS TSS;
global Var_ALBEDOS Var_ALBNIRDFS Var_ALBNIRDRS Var_ALBVISDFS Var_ALBVISDRS;
global Var_CLDHGHS Var_CLDLOWS Var_CLDMIDS Var_CLDTOTS;
global Var_EMISS Var_LWGABS Var_LWGABCLRS Var_LWGABCLRCLNS;
global Var_LWGEMS Var_LWGNTS Var_LWGNTCLRS Var_LWGNTCLRCLNS;
global Var_LWTUPS Var_LWTUPCLRS Var_LWTUPCLRCLNS Var_SWGDNS;
global Var_SWGDNCLRS Var_SWGNTS Var_SWGNTCLNS Var_SWGNTCLRS;
global Var_SWGNTCLRCLNS Var_SWTDNS Var_SWTNTS;
global Var_SWTNTCLNS Var_SWTNTCLRS Var_SWTNTCLRCLNS Var_TAUHGHS;
global Var_TAULOWS Var_TAUMIDS Var_TAUTOTS Var_TSS;

global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;
global YearMonthStrStart YearMonthStrEnd
global AlbedoTable AlbedoTT CLDHGHTable CLDHGHTT CLDTOTTable CLDTOTTT;
global CLDLOWTable CLDLOWTT CLDMIDTable CLDMIDTT;
global AlbvisdfTable  AlbvisdfTT;
global SurfaceEmissTable SurfaceEmissTT;
global LWGABTable LWGABTT LWTUPTable LWTUPTT;
global LWTUPCLRTable LWTUPCLRTT LWTUPCLRCLNTable LWTUPCLRCLNTT;
global LWGABCLRTable LWGABCLRTT LWGABCLRCLNTable LWGABCLRCLNTT;
global LWGEMTable LWGEMTT SWGDNTable SWGDNTT;
global LWGNTTable LWGNTTT LWGNTCLRTable LWGNTCLRTT;
global LWGNTCLRCLNTable LWGNTCLRCLNTT;
global SWTDNTable SWTDNTT TAUHGHTable TAUHGHTT;
global TAULOWTable TAULOWTT TAUMIDTable TAUMIDTT TAUTOTTable TAUTOTTT;
global SWGDNCLRTable SWGDNCLRTT SWGNTTable SWGNTTT;
global SWGNTCLNTable SWGNTCLNTT SWGNTCLRTable SWGNTCLRTT;
global SWGNTCLRCLNTable SWGNTCLRCLNTT SWTNTTable SWTNTTT;
global SWTNTCLNTable SWTNTCLNTT SWTNTCLRTable SWTNTCLRTT;
global SWTNTCLRCLNTable SWTNTCLRCLNTT  TSTable TSTT;
global AlbnirdfTable  AlbnirdfTT AlbnirdrTable AlbnirdrTT;
global AlbvisdrTable  AlbvisdrTT ;
global westEdge eastEdge southEdge northEdge;

% Create some holding arrays for data that will be put into tables
global Albedo10 Albedo20 Albedo30 Albedo40 Albedo50 Albedo60 Albedo70 Albedo80;
global Albedo90 Albedo100 AlbedoLow AlbedoHigh AlbedoNaN AlbedoValues;
global Albnirdf10 Albnirdf20 Albnirdf30 Albnirdf40 Albnirdf50 Albnirdf60 Albnirdf70 Albnirdf80;
global Albnirdf90 Albnirdf100 AlbnirdfLow AlbnirdfHigh AlbnirdfNaN AlbnirdfValues;
global Albnirdr10 Albnirdr20 Albnirdr30 Albnirdr40 Albnirdr50 Albnirdr60 Albnirdr70 Albnirdr80;
global Albnirdr90 Albnirdr100 AlbnirdrLow AlbnirdrHigh AlbnirdrNaN AlbnirdrValues;
global Albvisdr10 Albvisdr20 Albvisdr30 Albvisdr40 Albvisdr50 Albvisdr60 Albvisdr70 Albvisdr80;
global Albvisdr90 Albvisdr100 AlbvisdrLow AlbvisdrHigh AlbvisdrNaN AlbvisdrValues;
global Albvisdf10  Albvisdf20  Albvisdf30  Albvisdf40  Albvisdf50  Albvisdf60  Albvisdf70  Albvisdf80;
global Albvisdf90 Albvisdf100 AlbvisdfLow AlbvisdfHigh AlbvisdfNaN AlbvisdfValues;
global CLDHGH10 CLDHGH20 CLDHGH30 CLDHGH40 CLDHGH50 CLDHGH60 CLDHGH70 CLDHGH80;
global CLDHGH90 CLDHGH100 CLDHGHLow CLDHGHHigh CLDHGHNaN CLDHGHValues;
global CLDLOW10 CLDLOW20 CLDLOW30 CLDLOW40 CLDLOW50 CLDLOW60 CLDLOW70 CLDLOW80;
global CLDLOW90 CLDLOW100 CLDLOWLow CLDLOWHigh CLDLOWNaN CLDLOWValues;
global CLDMID10 CLDMID20 CLDMID30 CLDMID40 CLDMID50 CLDMID60 CLDMID70 CLDMID80;
global CLDMID90 CLDMID100 CLDMIDLow CLDMIDHigh CLDMIDNaN CLDMIDValues;
global CLDTOT10 CLDTOT20 CLDTOT30 CLDTOT40 CLDTOT50 CLDTOT60 CLDTOT70 CLDTOT80;
global CLDTOT90 CLDTOT100 CLDTOTLow CLDTOTHigh CLDTOTNaN CLDTOTValues;
global LWGAB10 LWGAB20 LWGAB30 LWGAB40 LWGAB50 LWGAB60 LWGAB70 LWGAB80;
global LWGAB90 LWGAB100 LWGABLow LWGABHigh LWGABNaN LWGABValues;
global LWGABCLR10 LWGABCLR20 LWGABCLR30 LWGABCLR40 LWGABCLR50 LWGABCLR60 LWGABCLR70 LWGABCLR80;
global LWGABCLR90 LWGABCLR100 LWGABCLRLow LWGABCLRHigh LWGABCLRNaN LWGABCLRValues;
global LWGABCLRCLN10 LWGABCLRCLN20 LWGABCLRCLN30 LWGABCLRCLN40 LWGABCLRCLN50 LWGABCLRCLN60 LWGABCLRCLN70 LWGABCLRCLN80;
global LWGABCLRCLN90 LWGABCLRCLN100 LWGABCLRCLNLow LWGABCLRCLNHigh LWGABCLRCLNNaN LWGABCLRCLNValues;
global LWGEM10 LWGEM20 LWGEM30 LWGEM40 LWGEM50 LWGEM60 LWGEM70 LWGEM80;
global LWGEM90 LWGEM100 LWGEMLow LWGEMHigh LWGEMNaN LWGEMValues;
global LWGNT10 LWGNT20 LWGNT30 LWGNT40 LWGNT50 LWGNT60 LWGNT70 LWGNT80;
global LWGNT90 LWGNT100 LWGNTLow LWGNTHigh LWGNTNaN LWGNTValues;
global LWGNTCLR10 LWGNTCLR20 LWGNTCLR30 LWGNTCLR40 LWGNTCLR50 LWGNTCLR60 LWGNTCLR70 LWGNTCLR80;
global LWGNTCLR90 LWGNTCLR100 LWGNTCLRLow LWGNTCLRHigh LWGNTCLRNaN LWGNTCLRValues;
global LWGNTCLRCLN10 LWGNTCLRCLN20 LWGNTCLRCLN30 LWGNTCLRCLN40 LWGNTCLRCLN50 LWGNTCLRCLN60 LWGNTCLRCLN70 LWGNTCLRCLN80;
global LWGNTCLRCLN90 LWGNTCLRCLN100 LWGNTCLRCLNLow LWGNTCLRCLNHigh LWGNTCLRCLNNaN LWGNTCLRCLNValues;
global LWTUP10 LWTUP20 LWTUP30 LWTUP40 LWTUP50 LWTUP60 LWTUP70 LWTUP80;
global LWTUP90 LWTUP100 LWTUPLow LWTUPHigh LWTUPNaN LWTUPValues;
global LWTUPCLR10 LWTUPCLR20 LWTUPCLR30 LWTUPCLR40 LWTUPCLR50 LWTUPCLR60 LWTUPCLR70 LWTUPCLR80;
global LWTUPCLR90 LWTUPCLR100 LWTUPCLRLow LWTUPCLRHigh LWTUPCLRNaN LWTUPCLRValues;
global LWTUPCLRCLN10 LWTUPCLRCLN20 LWTUPCLRCLN30 LWTUPCLRCLN40 LWTUPCLRCLN50 LWTUPCLRCLN60 LWTUPCLRCLN70 LWTUPCLRCLN80;
global LWTUPCLRCLN90 LWTUPCLRCLN100 LWTUPCLRCLNLow LWTUPCLRCLNHigh LWTUPCLRCLNNaN LWTUPCLRCLNValues;
global SWGDN10 SWGDN20 SWGDN30 SWGDN40 SWGDN50 SWGDN60 SWGDN70 SWGDN80;
global SWGDN90 SWGDN100 SWGDNLow SWGDNHigh SWGDNNaN SWGDNValues;
global SWGDNCLR10 SWGDNCLR20 SWGDNCLR30 SWGDNCLR40 SWGDNCLR50 SWGDNCLR60 SWGDNCLR70 SWGDNCLR80;
global SWGDNCLR90 SWGDNCLR100 SWGDNCLRLow SWGDNCLRHigh SWGDNCLRNaN SWGDNCLRValues;
global SWTDN10 SWTDN20 SWTDN30 SWTDN40 SWTDN50 SWTDN60 SWTDN70 SWTDN80;
global SWTDN90 SWTDN100 SWTDNLow SWTDNHigh SWTDNNaN SWTDNValues;
global SWGNT10 SWGNT20 SWGNT30 SWGNT40 SWGNT50 SWGNT60 SWGNT70 SWGNT80;
global SWGNT90 SWGNT100 SWGNTLow SWGNTHigh SWGNTNaN SWGNTValues;
global SWGNTCLN10 SWGNTCLN20 SWGNTCLN30 SWGNTCLN40 SWGNTCLN50 SWGNTCLN60 SWGNTCLN70 SWGNTCLN80;
global SWGNTCLN90 SWGNTCLN100 SWGNTCLNLow SWGNTCLNHigh SWGNTCLNNaN SWGNTCLNValues;
global SWGNTCLR10 SWGNTCLR20 SWGNTCLR30 SWGNTCLR40 SWGNTCLR50 SWGNTCLR60 SWGNTCLR70 SWGNTCLR80;
global SWGNTCLR90 SWGNTCLR100 SWGNTCLRLow SWGNTCLRHigh SWGNTCLRNaN SWGNTCLRValues;
global SWGNTCLRCLN10 SWGNTCLRCLN20 SWGNTCLRCLN30 SWGNTCLRCLN40 SWGNTCLRCLN50 SWGNTCLRCLN60 SWGNTCLRCLN70 SWGNTCLRCLN80;
global SWGNTCLRCLN90 SWGNTCLRCLN100 SWGNTCLRCLNLow SWGNTCLRCLNHigh SWGNTCLRCLNNaN SWGNTCLRCLNValues;
global SWTNT10 SWTNT20 SWTNT30 SWTNT40 SWTNT50 SWTNT60 SWTNT70 SWTNT80;
global SWTNT90 SWTNT100 SWTNTLow SWTNTHigh SWTNTNaN SWTNTValues;
global SWTNTCLN10 SWTNTCLN20 SWTNTCLN30 SWTNTCLN40 SWTNTCLN50 SWTNTCLN60 SWTNTCLN70 SWTNTCLN80;
global SWTNTCLN90 SWTNTCLN100 SWTNTCLNLow SWTNTCLNHigh SWTNTCLNNaN SWTNTCLNValues;
global SWTNTCLR10 SWTNTCLR20 SWTNTCLR30 SWTNTCLR40 SWTNTCLR50 SWTNTCLR60 SWTNTCLR70 SWTNTCLR80;
global SWTNTCLR90 SWTNTCLR100 SWTNTCLRLow SWTNTCLRHigh SWTNTCLRNaN SWTNTCLRValues;
global SWTNTCLRCLN10 SWTNTCLRCLN20 SWTNTCLRCLN30 SWTNTCLRCLN40 SWTNTCLRCLN50 SWTNTCLRCLN60 SWTNTCLRCLN70 SWTNTCLRCLN80;
global SWTNTCLRCLN90 SWTNTCLRCLN100 SWTNTCLRCLNLow SWTNTCLRCLNHigh SWTNTCLRCLNNaN SWTNTCLRCLNValues;
global SEmis10 SEmis20 SEmis30 SEmis40 SEmis50 SEmis60 SEmis70 SEmis80;
global SEmis90 SEmis100 SEmisLow SEmisHigh SEmisNaN SEmisValues;
global TAUHGH10 TAUHGH20 TAUHGH30 TAUHGH40 TAUHGH50 TAUHGH60 TAUHGH70 TAUHGH80;
global TAUHGH90 TAUHGH100 TAUHGHLow TAUHGHHigh TAUHGHNaN TAUHGHValues;
global TAULOW10 TAULOW20 TAULOW30 TAULOW40 TAULOW50 TAULOW60 TAULOW70 TAULOW80;
global TAULOW90 TAULOW100 TAULOWLow TAULOWHigh TAULOWNaN TAULOWValues;
global TAUMID10 TAUMID20 TAUMID30 TAUMID40 TAUMID50 TAUMID60 TAUMID70 TAUMID80;
global TAUMID90 TAUMID100 TAUMIDLow TAUMIDHigh TAUMIDNaN TAUMIDValues;
global TAUTOT10 TAUTOT20 TAUTOT30 TAUTOT40 TAUTOT50 TAUTOT60 TAUTOT70 TAUTOT80;
global TAUTOT90 TAUTOT100 TAUTOTLow TAUTOTHigh TAUTOTNaN TAUTOTValues;
global TS10 TS20 TS30 TS40 TS50 TS60 TS70 TS80;
global TS90 TS100 TSLow TSHigh TSNaN TSValues;
global EMISValues TSValues;

global RCOEFF RCOEFFHist RCOEFFLabels;
global iCityPlot;

% additional paths needed for mapping
global matpath1 mappath ;
global jpegpath savepath tablepath;

global fid isavefiles;


fprintf(fid,'\n');
fprintf(fid,'%s\n','**************Start reading dataset 08 Radiation Diagnostics data***************');

%[nc_filenamesuf,path]=uigetfile('*nc','Select One Data File');% SMF Modification
nc_filenamesuf=nowFile;
Merra2FileName=RemoveUnderScores(nowFile);
nc_filename=strcat(path,nc_filenamesuf);
ncid=netcdf.open(nc_filename,'nowrite');
openfilestr=strcat('Opening file-',Merra2FileName,'-for reading');
fprintf(fid,'%s\n',openfilestr);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
shortlen=length(Merra2ShortFileName);
is=shortlen-5;
ie=shortlen;
datestub=Merra2ShortFileName(is:ie);
YearStr=datestub(1:4);
MonthStr=datestub(5:6);
YearMonthStr=strcat(YearStr,MonthStr);
%% Set up the structs which will hold the data
LonS=struct('values',[],'long_name',[],'units',[],'vmax',[],'vmin',[],'valid_range',[]);
LatS=LonS;
TimeS=struct('values',[],'long_name',[],'units',[],'time_increment',[],...
     'begin_date',[],'begin_time',[],'vmax',[],'vmin',[],'valid_range',[]);
AlbedoS=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'vmax',[],'vmin',[],'valid_range',[]);
AlbnirdfS=AlbedoS;
AlbnirdrS=AlbedoS;
AlbvisdfS=AlbedoS;
AlbvisdrS=AlbedoS;
CLDHGHS=AlbedoS;
CLDLOWS=AlbedoS;
CLDMIDS=AlbedoS;
CLDTOTS=AlbedoS;
EmissS=AlbedoS;
LWGABS=AlbedoS;
LWGABCLRS=AlbedoS;
LWGABCLRCLNS=AlbedoS;
LWGEMS=AlbedoS;
LWGNTS=AlbedoS;
LWTUPS=AlbedoS;
LWTUPCLRS=AlbedoS;
LWTUPCLRCLNS=AlbedoS;
SWGDNS=AlbedoS;
SWGDNCLRS=AlbedoS;
SWGNTS=AlbedoS;
SWGNTCLNS=AlbedoS;
SWGNTCLRS=AlbedoS;
SWGNTCLRCLNS=AlbedoS;
SWTDNS=AlbedoS;
SWTNTS=AlbedoS;
SWTNTCLNS=AlbedoS;
SWTNTCLRS=AlbedoS;
SWTNTCLRCLNS=AlbedoS;
TAUHGHS=AlbedoS;
TAULOWS=AlbedoS;
TAUMIDS=AlbedoS;
TAUTOTS=AlbedoS;
TSS=AlbedoS;
Var_ALBEDOS=AlbedoS;
Var_ALBNIRDFS=AlbedoS;
Var_ALBNIRDRS=AlbedoS;
Var_ALBVISDFS=AlbedoS;
Var_ALBVISDRS=AlbedoS;
Var_CLDHGHS=AlbedoS;
Var_CLDLOWS=AlbedoS;
Var_CLDMIDS=AlbedoS;
Var_CLDTOTS=AlbedoS;
Var_EMISS=AlbedoS;
Var_LWGABS=AlbedoS;
Var_LWGABCLRS=AlbedoS;
Var_LWGABCLRCLNS=AlbedoS;
Var_LWGEMS=AlbedoS;
Var_LWGNTS=AlbedoS;
Var_LWGNTCLRS=AlbedoS;
Var_LWGNTCLRCLNS=AlbedoS;
Var_LWTUPS=AlbedoS;
Var_LWTUPCLRS=AlbedoS;
Var_LWTUPCLRCLNS=AlbedoS;
Var_SWGDNS=AlbedoS;
Var_SWGDNCLRS=AlbedoS;
Var_SWGNTS=AlbedoS;
Var_SWGNTCLNS=AlbedoS;
Var_SWGNTCLRS=AlbedoS;
Var_SWGNTCLRCLNS=AlbedoS;
Var_SWTDNS=AlbedoS;
Var_SWTNTS=AlbedoS;
Var_SWTNTCLNS=AlbedoS;
Var_SWTNTCLRS=AlbedoS;
Var_SWTNTCLRCLNS=AlbedoS;
Var_TAUHGHS=AlbedoS;
Var_TAULOWS=AlbedoS;
Var_TAUMIDS=AlbedoS;
Var_TAUTOTS=AlbedoS;
Var_TSS=AlbedoS;
% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
numvarstr=strcat('The number of variables read from the Monthly Mean Rad Diagnostics file=',num2str(numvars));
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
       a220=strcmp(varname,'LWTUPCLR');
       a230=strcmp(varname,'LWTUPCLRCLN');
       a240=strcmp(varname,'SWGDN');
       a250=strcmp(varname,'SWGDNCLR');
       a260=strcmp(varname,'SWGNT');
       a270=strcmp(varname,'SWGNTCLN');
       a280=strcmp(varname,'SWGNTCLR');
       a290=strcmp(varname,'SWGNTCLRCLN');
       a300=strcmp(varname,'SWTDN');
       a310=strcmp(varname,'SWTNT');
       a320=strcmp(varname,'SWTNTCLN');
       a330=strcmp(varname,'SWTNTCLR');
       a340=strcmp(varname,'SWTNTCLRCLN');
       a350=strcmp(varname,'TAUHGH');
       a360=strcmp(varname,'TAULOW');
       a370=strcmp(varname,'TAUMID');
       a380=strcmp(varname,'TAUTOT');
       a390=strcmp(varname,'TS');
       a400=strcmp(varname,'Var_ALBEDO');
       a410=strcmp(varname,'Var_ALBNIRDF');
       a420=strcmp(varname,'Var_ALBNIRDR');
       a430=strcmp(varname,'Var_ALBVISDF');
       a440=strcmp(varname,'Var_ALBVISDR');
       a450=strcmp(varname,'Var_CLDHGH');
       a460=strcmp(varname,'Var_CLDLOW');
       a470=strcmp(varname,'Var_CLDMID');
       a480=strcmp(varname,'Var_CLDTOT');
       a490=strcmp(varname,'Var_EMIS');
       a500=strcmp(varname,'Var_LWGAB');
       a510=strcmp(varname,'Var_LWGABCLR');
       a520=strcmp(varname,'Var_LWGABCLRCLN');
       a530=strcmp(varname,'Var_LWGEM');
       a540=strcmp(varname,'Var_LWGNT');
       a550=strcmp(varname,'Var_LWGNTCLR');
       a560=strcmp(varname,'Var_LWGNTCLRCLN');
       a570=strcmp(varname,'Var_LWTUP');
       a580=strcmp(varname,'Var_LWTUPCLR');
       a590=strcmp(varname,'Var_LWTUPCLRCLN');
       a600=strcmp(varname,'Var_SWGDN');
       a610=strcmp(varname,'Var_SWGDNCLR');
       a620=strcmp(varname,'Var_SWGNT');
       a630=strcmp(varname,'Var_SWGNTCLN');
       a640=strcmp(varname,'Var_SWGNTCLR');
       a650=strcmp(varname,'Var_SWGNTCLRCLN');
       a660=strcmp(varname,'Var_SWTDN');
       a670=strcmp(varname,'Var_SWTNT');
       a680=strcmp(varname,'Var_SWTNTCLN');
       a690=strcmp(varname,'Var_SWTNTCLR');
       a700=strcmp(varname,'Var_SWTNTCLRCLN');
       a710=strcmp(varname,'Var_TAUHGH');
       a720=strcmp(varname,'Var_TAULOW');
       a730=strcmp(varname,'Var_TAUMID');
       a740=strcmp(varname,'Var_TAUTOT');
       a750=strcmp(varname,'Var_TS');



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
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 TimeS.vmin=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 TimeS.vmax=attname2;
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
            if(framecounter==1)
                Albedo10=zeros(numSelectedFiles,1);
                Albedo20=zeros(numSelectedFiles,1);
                Albedo30=zeros(numSelectedFiles,1);
                Albedo40=zeros(numSelectedFiles,1);
                Albedo50=zeros(numSelectedFiles,1);
                Albedo60=zeros(numSelectedFiles,1);
                Albedo70=zeros(numSelectedFiles,1);
                Albedo80=zeros(numSelectedFiles,1);
                Albedo90=zeros(numSelectedFiles,1);
                Albedo100=zeros(numSelectedFiles,1);
                AlbedoLow=zeros(numSelectedFiles,1);
                AlbedoHigh=zeros(numSelectedFiles,1);
                AlbedoNaN=zeros(numSelectedFiles,1);
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
                 AlbnirdfS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 AlbnirdfS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 AlbnirdfS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 AlbnirdfS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 AlbnirdfS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 AlbnirdfS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 AlbnirdfS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 AlbnirdfS.valid_range=attname2;
            end
            if(framecounter==1)
                Albnirdf10=zeros(numSelectedFiles,1);
                Albnirdf20=zeros(numSelectedFiles,1);
                Albnirdf30=zeros(numSelectedFiles,1);
                Albnirdf40=zeros(numSelectedFiles,1);
                Albnirdf50=zeros(numSelectedFiles,1);
                Albnirdf60=zeros(numSelectedFiles,1);
                Albnirdf70=zeros(numSelectedFiles,1);
                Albnirdf80=zeros(numSelectedFiles,1);
                Albnirdf90=zeros(numSelectedFiles,1);
                Albnirdf100=zeros(numSelectedFiles,1);
                AlbnirdfLow=zeros(numSelectedFiles,1);
                AlbnirdfHigh=zeros(numSelectedFiles,1);
                AlbnirdfNaN=zeros(numSelectedFiles,1);
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
                 AlbnirdrS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 AlbnirdrS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 AlbnirdrS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 AlbnirdrS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 AlbnirdrS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 AlbnirdrS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 AlbnirdrS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 AlbnirdrS.valid_range=attname2;
            end
            if(framecounter==1)
                Albnirdf10=zeros(numSelectedFiles,1);
                Albnirdf20=zeros(numSelectedFiles,1);
                Albnirdf30=zeros(numSelectedFiles,1);
                Albnirdf40=zeros(numSelectedFiles,1);
                Albnirdf50=zeros(numSelectedFiles,1);
                Albnirdf60=zeros(numSelectedFiles,1);
                Albnirdf70=zeros(numSelectedFiles,1);
                Albnirdf80=zeros(numSelectedFiles,1);
                Albnirdf90=zeros(numSelectedFiles,1);
                Albnirdf100=zeros(numSelectedFiles,1);
                AlbnirdfLow=zeros(numSelectedFiles,1);
                AlbnirdfHigh=zeros(numSelectedFiles,1);
                AlbnirdfNaN=zeros(numSelectedFiles,1);
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
                 AlbvisdfS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 AlbvisdfS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 AlbvisdfS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 AlbvisdfS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 AlbvisdfS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 AlbvisdfS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 AlbvisdfS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 AlbvisdfS.valid_range=attname2;
            end
         
            if(framecounter==1)
                Albvisdf10=zeros(numSelectedFiles,1);
                Albvisdf20=zeros(numSelectedFiles,1);
                Albvisdf30=zeros(numSelectedFiles,1);
                Albvisdf40=zeros(numSelectedFiles,1);
                Albvisdf50=zeros(numSelectedFiles,1);
                Albvisdf60=zeros(numSelectedFiles,1);
                Albvisdf70=zeros(numSelectedFiles,1);
                Albvisdf80=zeros(numSelectedFiles,1);
                Albvisdf90=zeros(numSelectedFiles,1);
                Albvisdf100=zeros(numSelectedFiles,1);
                AlbvisdfLow=zeros(numSelectedFiles,1);
                AlbvisdfHigh=zeros(numSelectedFiles,1);
                AlbvisdfNaN=zeros(numSelectedFiles,1);
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
                 AlbvisdrS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 AlbvisdrS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 AlbvisdrS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 AlbvisdrS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 AlbvisdrS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 AlbvisdrS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 AlbvisdrS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 AlbvisdrS.valid_range=attname2;
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
            if(framecounter==1)
                CLDHGH10=zeros(numSelectedFiles,1);
                CLDHGH20=zeros(numSelectedFiles,1);
                CLDHGH30=zeros(numSelectedFiles,1);
                CLDHGH40=zeros(numSelectedFiles,1);
                CLDHGH50=zeros(numSelectedFiles,1);
                CLDHGH60=zeros(numSelectedFiles,1);
                CLDHGH70=zeros(numSelectedFiles,1);
                CLDHGH80=zeros(numSelectedFiles,1);
                CLDHGH90=zeros(numSelectedFiles,1);
                CLDHGH100=zeros(numSelectedFiles,1);
                CLDHGHLow=zeros(numSelectedFiles,1);
                CLDHGHHigh=zeros(numSelectedFiles,1);
                CLDHGHNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                CLDTOT10=zeros(numSelectedFiles,1);
                CLDTOT20=zeros(numSelectedFiles,1);
                CLDTOT30=zeros(numSelectedFiles,1);
                CLDTOT40=zeros(numSelectedFiles,1);
                CLDTOT50=zeros(numSelectedFiles,1);
                CLDTOT60=zeros(numSelectedFiles,1);
                CLDTOT70=zeros(numSelectedFiles,1);
                CLDTOT80=zeros(numSelectedFiles,1);
                CLDTOT90=zeros(numSelectedFiles,1);
                CLDTOT100=zeros(numSelectedFiles,1);
                CLDTOTLow=zeros(numSelectedFiles,1);
                CLDTOTHigh=zeros(numSelectedFiles,1);
                CLDTOTNaN=zeros(numSelectedFiles,1);
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
                 EmissS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 EmissS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 EmissS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 EmissS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 EmissS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 EmissS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 EmissS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 EmissS.valid_range=attname2;
            end
            if(framecounter==1)
                SEmis10=zeros(numSelectedFiles,1);
                SEmis20=zeros(numSelectedFiles,1);
                SEmis30=zeros(numSelectedFiles,1);
                SEmis40=zeros(numSelectedFiles,1);
                SEmis50=zeros(numSelectedFiles,1);
                SEmis60=zeros(numSelectedFiles,1);
                SEmis70=zeros(numSelectedFiles,1);
                SEmis80=zeros(numSelectedFiles,1);
                SEmis90=zeros(numSelectedFiles,1);
                SEmis100=zeros(numSelectedFiles,1);
                SEmisLow=zeros(numSelectedFiles,1);
                SEmisHigh=zeros(numSelectedFiles,1);
                SEmisNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWGAB10=zeros(numSelectedFiles,1);
                LWGAB20=zeros(numSelectedFiles,1);
                LWGAB30=zeros(numSelectedFiles,1);
                LWGAB40=zeros(numSelectedFiles,1);
                LWGAB50=zeros(numSelectedFiles,1);
                LWGAB60=zeros(numSelectedFiles,1);
                LWGAB70=zeros(numSelectedFiles,1);
                LWGAB80=zeros(numSelectedFiles,1);
                LWGAB90=zeros(numSelectedFiles,1);
                LWGAB100=zeros(numSelectedFiles,1);
                LWGABLow=zeros(numSelectedFiles,1);
                LWGABHigh=zeros(numSelectedFiles,1);
                LWGABNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWGABCLR10=zeros(numSelectedFiles,1);
                LWGABCLR20=zeros(numSelectedFiles,1);
                LWGABCLR30=zeros(numSelectedFiles,1);
                LWGABCLR40=zeros(numSelectedFiles,1);
                LWGABCLR50=zeros(numSelectedFiles,1);
                LWGABCLR60=zeros(numSelectedFiles,1);
                LWGABCLR70=zeros(numSelectedFiles,1);
                LWGABCLR80=zeros(numSelectedFiles,1);
                LWGABCLR90=zeros(numSelectedFiles,1);
                LWGABCLR100=zeros(numSelectedFiles,1);
                LWGABCLRLow=zeros(numSelectedFiles,1);
                LWGABCLRHigh=zeros(numSelectedFiles,1);
                LWGABCLRNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWGABCLRCLN10=zeros(numSelectedFiles,1);
                LWGABCLRCLN20=zeros(numSelectedFiles,1);
                LWGABCLRCLN30=zeros(numSelectedFiles,1);
                LWGABCLRCLN40=zeros(numSelectedFiles,1);
                LWGABCLRCLN50=zeros(numSelectedFiles,1);
                LWGABCLRCLN60=zeros(numSelectedFiles,1);
                LWGABCLRCLN70=zeros(numSelectedFiles,1);
                LWGABCLRCLN80=zeros(numSelectedFiles,1);
                LWGABCLRCLN90=zeros(numSelectedFiles,1);
                LWGABCLRCLN100=zeros(numSelectedFiles,1);
                LWGABCLRCLNLow=zeros(numSelectedFiles,1);
                LWGABCLRCLNHigh=zeros(numSelectedFiles,1);
                LWGABCLRCLNNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWGEM10=zeros(numSelectedFiles,1);
                LWGEM20=zeros(numSelectedFiles,1);
                LWGEM30=zeros(numSelectedFiles,1);
                LWGEM40=zeros(numSelectedFiles,1);
                LWGEM50=zeros(numSelectedFiles,1);
                LWGEM60=zeros(numSelectedFiles,1);
                LWGEM70=zeros(numSelectedFiles,1);
                LWGEM80=zeros(numSelectedFiles,1);
                LWGEM90=zeros(numSelectedFiles,1);
                LWGEM100=zeros(numSelectedFiles,1);
                LWGEMLow=zeros(numSelectedFiles,1);
                LWGEMHigh=zeros(numSelectedFiles,1);
                LWGEMNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWGNT10=zeros(numSelectedFiles,1);
                LWGNT20=zeros(numSelectedFiles,1);
                LWGNT30=zeros(numSelectedFiles,1);
                LWGNT40=zeros(numSelectedFiles,1);
                LWGNT50=zeros(numSelectedFiles,1);
                LWGNT60=zeros(numSelectedFiles,1);
                LWGNT70=zeros(numSelectedFiles,1);
                LWGNT80=zeros(numSelectedFiles,1);
                LWGNT90=zeros(numSelectedFiles,1);
                LWGNT100=zeros(numSelectedFiles,1);
                LWGNTLow=zeros(numSelectedFiles,1);
                LWGNTHigh=zeros(numSelectedFiles,1);
                LWGNTNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWGNTCLR10=zeros(numSelectedFiles,1);
                LWGNTCLR20=zeros(numSelectedFiles,1);
                LWGNTCLR30=zeros(numSelectedFiles,1);
                LWGNTCLR40=zeros(numSelectedFiles,1);
                LWGNTCLR50=zeros(numSelectedFiles,1);
                LWGNTCLR60=zeros(numSelectedFiles,1);
                LWGNTCLR70=zeros(numSelectedFiles,1);
                LWGNTCLR80=zeros(numSelectedFiles,1);
                LWGNTCLR90=zeros(numSelectedFiles,1);
                LWGNTCLR100=zeros(numSelectedFiles,1);
                LWGNTCLRLow=zeros(numSelectedFiles,1);
                LWGNTCLRHigh=zeros(numSelectedFiles,1);
                LWGNTCLRNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWGNTCLRCLN10=zeros(numSelectedFiles,1);
                LWGNTCLRCLN20=zeros(numSelectedFiles,1);
                LWGNTCLRCLN30=zeros(numSelectedFiles,1);
                LWGNTCLRCLN40=zeros(numSelectedFiles,1);
                LWGNTCLRCLN50=zeros(numSelectedFiles,1);
                LWGNTCLRCLN60=zeros(numSelectedFiles,1);
                LWGNTCLRCLN70=zeros(numSelectedFiles,1);
                LWGNTCLRCLN80=zeros(numSelectedFiles,1);
                LWGNTCLRCLN90=zeros(numSelectedFiles,1);
                LWGNTCLRCLN100=zeros(numSelectedFiles,1);
                LWGNTCLRCLNLow=zeros(numSelectedFiles,1);
                LWGNTCLRCLNHigh=zeros(numSelectedFiles,1);
                LWGNTCLRCLNNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWTUP10=zeros(numSelectedFiles,1);
                LWTUP20=zeros(numSelectedFiles,1);
                LWTUP30=zeros(numSelectedFiles,1);
                LWTUP40=zeros(numSelectedFiles,1);
                LWTUP50=zeros(numSelectedFiles,1);
                LWTUP60=zeros(numSelectedFiles,1);
                LWTUP70=zeros(numSelectedFiles,1);
                LWTUP80=zeros(numSelectedFiles,1);
                LWTUP90=zeros(numSelectedFiles,1);
                LWTUP100=zeros(numSelectedFiles,1);
                LWTUPLow=zeros(numSelectedFiles,1);
                LWTUPHigh=zeros(numSelectedFiles,1);
                LWTUPNaN=zeros(numSelectedFiles,1);
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

            if(framecounter==1)
                LWTUPCLR10=zeros(numSelectedFiles,1);
                LWTUPCLR20=zeros(numSelectedFiles,1);
                LWTUPCLR30=zeros(numSelectedFiles,1);
                LWTUPCLR40=zeros(numSelectedFiles,1);
                LWTUPCLR50=zeros(numSelectedFiles,1);
                LWTUPCLR60=zeros(numSelectedFiles,1);
                LWTUPCLR70=zeros(numSelectedFiles,1);
                LWTUPCLR80=zeros(numSelectedFiles,1);
                LWTUPCLR90=zeros(numSelectedFiles,1);
                LWTUPCLR100=zeros(numSelectedFiles,1);
                LWTUPCLRLow=zeros(numSelectedFiles,1);
                LWTUPCLRHigh=zeros(numSelectedFiles,1);
                LWTUPCLRNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                LWTUPCLRCLN10=zeros(numSelectedFiles,1);
                LWTUPCLRCLN20=zeros(numSelectedFiles,1);
                LWTUPCLRCLN30=zeros(numSelectedFiles,1);
                LWTUPCLRCLN40=zeros(numSelectedFiles,1);
                LWTUPCLRCLN50=zeros(numSelectedFiles,1);
                LWTUPCLRCLN60=zeros(numSelectedFiles,1);
                LWTUPCLRCLN70=zeros(numSelectedFiles,1);
                LWTUPCLRCLN80=zeros(numSelectedFiles,1);
                LWTUPCLRCLN90=zeros(numSelectedFiles,1);
                LWTUPCLRCLN100=zeros(numSelectedFiles,1);
                LWTUPCLRCLNLow=zeros(numSelectedFiles,1);
                LWTUPCLRCLNHigh=zeros(numSelectedFiles,1);
                LWTUPCLRCLNNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                SWGDN10=zeros(numSelectedFiles,1);
                SWGDN20=zeros(numSelectedFiles,1);
                SWGDN30=zeros(numSelectedFiles,1);
                SWGDN40=zeros(numSelectedFiles,1);
                SWGDN50=zeros(numSelectedFiles,1);
                SWGDN60=zeros(numSelectedFiles,1);
                SWGDN70=zeros(numSelectedFiles,1);
                SWGDN80=zeros(numSelectedFiles,1);
                SWGDN90=zeros(numSelectedFiles,1);
                SWGDN100=zeros(numSelectedFiles,1);
                SWGDNLow=zeros(numSelectedFiles,1);
                SWGDNHigh=zeros(numSelectedFiles,1);
                SWGDNNaN=zeros(numSelectedFiles,1);
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

            if(framecounter==1)
                SWGDNCLR10=zeros(numSelectedFiles,1);
                SWGDNCLR20=zeros(numSelectedFiles,1);
                SWGDNCLR30=zeros(numSelectedFiles,1);
                SWGDNCLR40=zeros(numSelectedFiles,1);
                SWGDNCLR50=zeros(numSelectedFiles,1);
                SWGDNCLR60=zeros(numSelectedFiles,1);
                SWGDNCLR70=zeros(numSelectedFiles,1);
                SWGDNCLR80=zeros(numSelectedFiles,1);
                SWGDNCLR90=zeros(numSelectedFiles,1);
                SWGDNCLR100=zeros(numSelectedFiles,1);
                SWGDNCLRLow=zeros(numSelectedFiles,1);
                SWGDNCLRHigh=zeros(numSelectedFiles,1);
                SWGDNCLRNaN=zeros(numSelectedFiles,1);
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

            if(framecounter==1)
                SWGNT10=zeros(numSelectedFiles,1);
                SWGNT20=zeros(numSelectedFiles,1);
                SWGNT30=zeros(numSelectedFiles,1);
                SWGNT40=zeros(numSelectedFiles,1);
                SWGNT50=zeros(numSelectedFiles,1);
                SWGNT60=zeros(numSelectedFiles,1);
                SWGNT70=zeros(numSelectedFiles,1);
                SWGNT80=zeros(numSelectedFiles,1);
                SWGNT90=zeros(numSelectedFiles,1);
                SWGNT100=zeros(numSelectedFiles,1);
                SWGNTLow=zeros(numSelectedFiles,1);
                SWGNTHigh=zeros(numSelectedFiles,1);
                SWGNTNaN=zeros(numSelectedFiles,1);
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
           if(framecounter==1)
                SWGNTCLN10=zeros(numSelectedFiles,1);
                SWGNTCLN20=zeros(numSelectedFiles,1);
                SWGNTCLN30=zeros(numSelectedFiles,1);
                SWGNTCLN40=zeros(numSelectedFiles,1);
                SWGNTCLN50=zeros(numSelectedFiles,1);
                SWGNTCLN60=zeros(numSelectedFiles,1);
                SWGNTCLN70=zeros(numSelectedFiles,1);
                SWGNTCLN80=zeros(numSelectedFiles,1);
                SWGNTCLN90=zeros(numSelectedFiles,1);
                SWGNTCLN100=zeros(numSelectedFiles,1);
                SWGNTCLNLow=zeros(numSelectedFiles,1);
                SWGNTCLNHigh=zeros(numSelectedFiles,1);
                SWGNTCLNNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                SWGNTCLR10=zeros(numSelectedFiles,1);
                SWGNTCLR20=zeros(numSelectedFiles,1);
                SWGNTCLR30=zeros(numSelectedFiles,1);
                SWGNTCLR40=zeros(numSelectedFiles,1);
                SWGNTCLR50=zeros(numSelectedFiles,1);
                SWGNTCLR60=zeros(numSelectedFiles,1);
                SWGNTCLR70=zeros(numSelectedFiles,1);
                SWGNTCLR80=zeros(numSelectedFiles,1);
                SWGNTCLR90=zeros(numSelectedFiles,1);
                SWGNTCLR100=zeros(numSelectedFiles,1);
                SWGNTCLRLow=zeros(numSelectedFiles,1);
                SWGNTCLRHigh=zeros(numSelectedFiles,1);
                SWGNTCLRNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                SWGNTCLRCLN10=zeros(numSelectedFiles,1);
                SWGNTCLRCLN20=zeros(numSelectedFiles,1);
                SWGNTCLRCLN30=zeros(numSelectedFiles,1);
                SWGNTCLRCLN40=zeros(numSelectedFiles,1);
                SWGNTCLRCLN50=zeros(numSelectedFiles,1);
                SWGNTCLRCLN60=zeros(numSelectedFiles,1);
                SWGNTCLRCLN70=zeros(numSelectedFiles,1);
                SWGNTCLRCLN80=zeros(numSelectedFiles,1);
                SWGNTCLRCLN90=zeros(numSelectedFiles,1);
                SWGNTCLRCLN100=zeros(numSelectedFiles,1);
                SWGNTCLRCLNLow=zeros(numSelectedFiles,1);
                SWGNTCLRCLNHigh=zeros(numSelectedFiles,1);
                SWGNTCLRCLNNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                SWTDN10=zeros(numSelectedFiles,1);
                SWTDN20=zeros(numSelectedFiles,1);
                SWTDN30=zeros(numSelectedFiles,1);
                SWTDN40=zeros(numSelectedFiles,1);
                SWTDN50=zeros(numSelectedFiles,1);
                SWTDN60=zeros(numSelectedFiles,1);
                SWTDN70=zeros(numSelectedFiles,1);
                SWTDN80=zeros(numSelectedFiles,1);
                SWTDN90=zeros(numSelectedFiles,1);
                SWTDN100=zeros(numSelectedFiles,1);
                SWTDNLow=zeros(numSelectedFiles,1);
                SWTDNHigh=zeros(numSelectedFiles,1);
                SWTDNNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                SWTNT10=zeros(numSelectedFiles,1);
                SWTNT20=zeros(numSelectedFiles,1);
                SWTNT30=zeros(numSelectedFiles,1);
                SWTNT40=zeros(numSelectedFiles,1);
                SWTNT50=zeros(numSelectedFiles,1);
                SWTNT60=zeros(numSelectedFiles,1);
                SWTNT70=zeros(numSelectedFiles,1);
                SWTNT80=zeros(numSelectedFiles,1);
                SWTNT90=zeros(numSelectedFiles,1);
                SWTNT100=zeros(numSelectedFiles,1);
                SWTNTLow=zeros(numSelectedFiles,1);
                SWTNTHigh=zeros(numSelectedFiles,1);
                SWTNTNaN=zeros(numSelectedFiles,1);
            end

            
         elseif (a320==1)
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
            if(framecounter==1)
                SWTNTCLN10=zeros(numSelectedFiles,1);
                SWTNTCLN20=zeros(numSelectedFiles,1);
                SWTNTCLN30=zeros(numSelectedFiles,1);
                SWTNTCLN40=zeros(numSelectedFiles,1);
                SWTNTCLN50=zeros(numSelectedFiles,1);
                SWTNTCLN60=zeros(numSelectedFiles,1);
                SWTNTCLN70=zeros(numSelectedFiles,1);
                SWTNTCLN80=zeros(numSelectedFiles,1);
                SWTNTCLN90=zeros(numSelectedFiles,1);
                SWTNTCLN100=zeros(numSelectedFiles,1);
                SWTNTCLNLow=zeros(numSelectedFiles,1);
                SWTNTCLNHigh=zeros(numSelectedFiles,1);
                SWTNTCLNNaN=zeros(numSelectedFiles,1);
            end
         
         elseif (a330==1)
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
            if(framecounter==1)
                SWTNTCLR10=zeros(numSelectedFiles,1);
                SWTNTCLR20=zeros(numSelectedFiles,1);
                SWTNTCLR30=zeros(numSelectedFiles,1);
                SWTNTCLR40=zeros(numSelectedFiles,1);
                SWTNTCLR50=zeros(numSelectedFiles,1);
                SWTNTCLR60=zeros(numSelectedFiles,1);
                SWTNTCLR70=zeros(numSelectedFiles,1);
                SWTNTCLR80=zeros(numSelectedFiles,1);
                SWTNTCLR90=zeros(numSelectedFiles,1);
                SWTNTCLR100=zeros(numSelectedFiles,1);
                SWTNTCLRLow=zeros(numSelectedFiles,1);
                SWTNTCLRHigh=zeros(numSelectedFiles,1);
                SWTNTCLRNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                SWTNTCLRCLN10=zeros(numSelectedFiles,1);
                SWTNTCLRCLN20=zeros(numSelectedFiles,1);
                SWTNTCLRCLN30=zeros(numSelectedFiles,1);
                SWTNTCLRCLN40=zeros(numSelectedFiles,1);
                SWTNTCLRCLN50=zeros(numSelectedFiles,1);
                SWTNTCLRCLN60=zeros(numSelectedFiles,1);
                SWTNTCLRCLN70=zeros(numSelectedFiles,1);
                SWTNTCLRCLN80=zeros(numSelectedFiles,1);
                SWTNTCLRCLN90=zeros(numSelectedFiles,1);
                SWTNTCLRCLN100=zeros(numSelectedFiles,1);
                SWTNTCLRCLNLow=zeros(numSelectedFiles,1);
                SWTNTCLRCLNHigh=zeros(numSelectedFiles,1);
                SWTNTCLRCLNNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                TAUHGH10=zeros(numSelectedFiles,1);
                TAUHGH20=zeros(numSelectedFiles,1);
                TAUHGH30=zeros(numSelectedFiles,1);
                TAUHGH40=zeros(numSelectedFiles,1);
                TAUHGH50=zeros(numSelectedFiles,1);
                TAUHGH60=zeros(numSelectedFiles,1);
                TAUHGH70=zeros(numSelectedFiles,1);
                TAUHGH80=zeros(numSelectedFiles,1);
                TAUHGH90=zeros(numSelectedFiles,1);
                TAUHGH100=zeros(numSelectedFiles,1);
                TAUHGHLow=zeros(numSelectedFiles,1);
                TAUHGHHigh=zeros(numSelectedFiles,1);
                TAUHGHNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                TAULOW10=zeros(numSelectedFiles,1);
                TAULOW20=zeros(numSelectedFiles,1);
                TAULOW30=zeros(numSelectedFiles,1);
                TAULOW40=zeros(numSelectedFiles,1);
                TAULOW50=zeros(numSelectedFiles,1);
                TAULOW60=zeros(numSelectedFiles,1);
                TAULOW70=zeros(numSelectedFiles,1);
                TAULOW80=zeros(numSelectedFiles,1);
                TAULOW90=zeros(numSelectedFiles,1);
                TAULOW100=zeros(numSelectedFiles,1);
                TAULOWLow=zeros(numSelectedFiles,1);
                TAULOWHigh=zeros(numSelectedFiles,1);
                TAULOWNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                TAUMID10=zeros(numSelectedFiles,1);
                TAUMID20=zeros(numSelectedFiles,1);
                TAUMID30=zeros(numSelectedFiles,1);
                TAUMID40=zeros(numSelectedFiles,1);
                TAUMID50=zeros(numSelectedFiles,1);
                TAUMID60=zeros(numSelectedFiles,1);
                TAUMID70=zeros(numSelectedFiles,1);
                TAUMID80=zeros(numSelectedFiles,1);
                TAUMID90=zeros(numSelectedFiles,1);
                TAUMID100=zeros(numSelectedFiles,1);
                TAUMIDLow=zeros(numSelectedFiles,1);
                TAUMIDHigh=zeros(numSelectedFiles,1);
                TAUMIDNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                TAUTOT10=zeros(numSelectedFiles,1);
                TAUTOT20=zeros(numSelectedFiles,1);
                TAUTOT30=zeros(numSelectedFiles,1);
                TAUTOT40=zeros(numSelectedFiles,1);
                TAUTOT50=zeros(numSelectedFiles,1);
                TAUTOT60=zeros(numSelectedFiles,1);
                TAUTOT70=zeros(numSelectedFiles,1);
                TAUTOT80=zeros(numSelectedFiles,1);
                TAUTOT90=zeros(numSelectedFiles,1);
                TAUTOT100=zeros(numSelectedFiles,1);
                TAUTOTLow=zeros(numSelectedFiles,1);
                TAUTOTHigh=zeros(numSelectedFiles,1);
                TAUTOTNaN=zeros(numSelectedFiles,1);
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
            if(framecounter==1)
                TS10=zeros(numSelectedFiles,1);
                TS20=zeros(numSelectedFiles,1);
                TS30=zeros(numSelectedFiles,1);
                TS40=zeros(numSelectedFiles,1);
                TS50=zeros(numSelectedFiles,1);
                TS60=zeros(numSelectedFiles,1);
                TS70=zeros(numSelectedFiles,1);
                TS80=zeros(numSelectedFiles,1);
                TS90=zeros(numSelectedFiles,1);
                TS100=zeros(numSelectedFiles,1);
                TSLow=zeros(numSelectedFiles,1);
                TSHigh=zeros(numSelectedFiles,1);
                TSNaN=zeros(numSelectedFiles,1);
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
                 Var_ALBEDOS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_ALBEDOS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_ALBEDOS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_ALBEDOS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_ALBEDOS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_ALBEDOS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_ALBEDOS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_ALBEDOS.valid_range=attname2;
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
                 Var_ALBNIRDFS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_ALBNIRDFS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_ALBNIRDFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_ALBNIRDFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_ALBNIRDFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_ALBNIRDFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_ALBNIRDFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_ALBNIRDFS.valid_range=attname2;
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
                 Var_ALBNIRDRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_ALBNIRDRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_ALBNIRDRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_ALBNIRDRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_ALBNIRDRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_ALBNIRDRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_ALBNIRDRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_ALBNIRDRS.valid_range=attname2;
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
                 Var_ALBVISDFS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_ALBVISDFS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_ALBVISDFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_ALBVISDFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_ALBVISDFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_ALBVISDFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_ALBVISDFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_ALBVISDFS.valid_range=attname2;
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
                 Var_ALBVISDRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_ALBVISDRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_ALBVISDRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_ALBVISDRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_ALBVISDRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_ALBVISDRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_ALBVISDRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_ALBVISDRS.valid_range=attname2;
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
                 Var_CLDHGHS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_CLDHGHS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_CLDHGHS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_CLDHGHS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_CLDHGHS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_CLDHGHS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_CLDHGHS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_CLDHGHS.valid_range=attname2;
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
                 Var_CLDLOWS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_CLDLOWS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_CLDLOWS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_CLDLOWS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_CLDLOWS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_CLDLOWS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_CLDLOWS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_CLDLOWS.valid_range=attname2;
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
                 Var_CLDMIDS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_CLDMIDS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_CLDMIDS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_CLDMIDS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_CLDMIDS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_CLDMIDS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_CLDMIDS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_CLDMIDS.valid_range=attname2;
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
                 Var_CLDTOTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_CLDTOTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_CLDTOTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_CLDTOTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_CLDTOTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_CLDTOTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_CLDTOTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_CLDTOTS.valid_range=attname2;
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
                 Var_EMISS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_EMISS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_EMISS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_EMISS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_EMISS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_EMISS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_EMISS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_EMISS.valid_range=attname2;
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
                 Var_LWGABS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWGABS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWGABS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWGABS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWGABS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWGABS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWGABS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWGABS.valid_range=attname2;
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
                 Var_LWGABCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWGABCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWGABCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWGABCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWGABCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWGABCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWGABCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWGABCLRS.valid_range=attname2;
            end

         elseif (a520==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWGABCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWGABCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWGABCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWGABCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWGABCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWGABCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWGABCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWGABCLRCLNS.valid_range=attname2;
            end

          elseif (a530==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWGEMS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWGEMS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWGEMS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWGEMS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWGEMS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWGEMS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWGEMS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWGEMS.valid_range=attname2;
            end

         elseif (a540==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWGNTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWGNTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWGNTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWGNTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWGNTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWGNTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWGNTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWGNTS.valid_range=attname2;
            end

          elseif (a550==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWGNTCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWGNTCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWGNTCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWGNTCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWGNTCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWGNTCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWGNTCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWGNTCLRS.valid_range=attname2;
            end

          elseif (a560==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWGNTCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWGNTCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWGNTCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWGNTCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWGNTCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWGNTCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWGNTCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWGNTCLRCLNS.valid_range=attname2;
            end


          elseif (a570==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWTUPS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWTUPS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWTUPS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWTUPS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWTUPS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWTUPS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWTUPS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWTUPS.valid_range=attname2;
            end

         elseif (a580==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWTUPCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWTUPCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWTUPCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWTUPCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWTUPCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWTUPCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWTUPCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWTUPCLRS.valid_range=attname2;
            end

         elseif (a590==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 Var_LWTUPCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Var_LWTUPCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 Var_LWTUPCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 Var_LWTUPCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 Var_LWTUPCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 Var_LWTUPCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 Var_LWTUPCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 Var_LWTUPCLRCLNS.valid_range=attname2;
            end

          elseif (a600==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWGDNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWGDNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWGDNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWGDNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_SWGDNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWGDNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_SWGDNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_SWGDNS.valid_range=attname2;
            end

          elseif (a610==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWGDNCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWGDNCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWGDNCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWGDNCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_SWGDNCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWGDNCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_SWGDNCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_SWGDNCLRS.valid_range=attname2;
            end

          elseif (a620==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWGNTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWGNTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWGNTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWGNTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_SWGNTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWGNTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_SWGNTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_SWGNTS.valid_range=attname2;
            end

  
         elseif (a630==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWGNTCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWGNTCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWGNTCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWGNTCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_SWGNTCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWGNTCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_SWGNTCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_SWGNTCLNS.valid_range=attname2;
            end

         elseif (a640==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWGNTCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                   Var_SWGNTCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                   Var_SWGNTCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                   Var_SWGNTCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_SWGNTCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                    Var_SWGNTCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_SWGNTCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_SWGNTCLRS.valid_range=attname2;
            end

          elseif (a650==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWGNTCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                   Var_SWGNTCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                   Var_SWGNTCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                   Var_SWGNTCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_SWGNTCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                    Var_SWGNTCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_SWGNTCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_SWGNTCLRCLNS.valid_range=attname2;
            end

          elseif (a660==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWTDNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                   Var_SWTDNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                   Var_SWTDNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                   Var_SWTDNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_SWTDNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                    Var_SWTDNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_SWTDNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_SWTDNS.valid_range=attname2;
            end

         elseif (a670==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWTNTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWTNTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWTNTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWTNTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_SWTNTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWTNTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_SWTNTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_SWTNTS.valid_range=attname2;
            end


          elseif (a680==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWTNTCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWTNTCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWTNTCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWTNTCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_SWTNTCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWTNTCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_SWTNTCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_SWTNTCLNS.valid_range=attname2;
            end

         elseif (a690==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWTNTCLRS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWTNTCLRS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWTNTCLRS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWTNTCLRS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_SWTNTCLRS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWTNTCLRS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_SWTNTCLRS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_SWTNTCLRS.valid_range=attname2;
            end
            Var_SWTNTCLRCLNS=AlbedoS;
            Var_TAUHGHS=AlbedoS;

         elseif (a700==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_SWTNTCLRCLNS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_SWTNTCLRCLNS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_SWTNTCLRCLNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_SWTNTCLRCLNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_SWTNTCLRCLNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_SWTNTCLRCLNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_SWTNTCLRCLNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_SWTNTCLRCLNS.valid_range=attname2;
            end

         elseif (a710==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_TAUHGHS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_TAUHGHS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_TAUHGHS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_TAUHGHS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_TAUHGHS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                  Var_TAUHGHS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_TAUHGHS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_TAUHGHS.valid_range=attname2;
            end

          elseif (a720==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_TAULOWS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_TAULOWS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_TAULOWS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_TAULOWS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_TAULOWS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                  Var_TAULOWS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_TAULOWS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_TAULOWS.valid_range=attname2;
            end

          elseif (a730==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                   Var_TAUMIDS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                   Var_TAUMIDS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                   Var_TAUMIDS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                   Var_TAUMIDS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                   Var_TAUMIDS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                   Var_TAUMIDS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                   Var_TAUMIDS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                   Var_TAUMIDS.valid_range=attname2;
            end

          elseif (a740==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_TAUTOTS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_TAUTOTS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_TAUTOTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_TAUTOTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_TAUTOTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                  Var_TAUTOTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_TAUTOTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_TAUTOTS.valid_range=attname2;
            end

          elseif (a750==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                  Var_TSS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                  Var_TSS.units=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                  Var_TSS.FillValue=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                  Var_TSS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                  Var_TSS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                  Var_TSS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                  Var_TSS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                  Var_TSS.valid_range=attname2;
            end


 
       end % Loop over all variables
    end
    if(idebug==1)
        disp(' ')
    end
    
    if flag


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
            AlbnirdfS.values=ALBNIRDF;
        end

        if(a60==1)
            AlbnirdrS.values=ALBNIRDR;
        end
      
        if(a70==1)
            AlbvisdfS.values=ALBVISDF;
        end

        if(a80==1)
            AlbvisdrS.values=ALBVISDR;
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
            EmissS.values=EMIS;
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
            LWTUPCLRS.values=LWTUPCLR;
        end

        if(a230==1)
            LWTUPCLRCLNS.values=LWTUPCLRCLN;
        end
 
        if(a240==1)
            SWGDNS.values=SWGDN;
        end

        if(a250==1)
            SWGDNCLRS.values=SWGDNCLR;
        end

        if(a260==1)
            SWGNTS.values=SWGNT;
        end
   
        if(a270==1)
            SWGNTCLNS.values=SWGNTCLN;
        end
      
        if(a280==1)
            SWGNTCLRS.values=SWGNTCLR;
        end
        
        if(a290==1)
            SWGNTCLRCLNS.values=SWGNTCLRCLN;
        end
      
        if(a300==1)
            SWTDNS.values=SWTDN;
        end
    
        if(a310==1)
            SWTNTS.values=SWTNT;
        end
        
        if(a320==1)
            SWTNTCLNS.values=SWTNTCLN;
        end

        if(a330==1)
            SWTNTCLRS.values=SWTNTCLR;
        end
         
        if(a340==1)
            SWTNTCLRCLNS.values=SWTNTCLRCLN;
        end

        if(a350==1)
            TAUHGHS.values=TAUHGH;
        end

        if(a360==1)
            TAULOWS.values=TAULOW;
        end

        if(a370==1)
            TAUMIDS.values=TAUMID;
        end

        if(a380==1)
            TAUTOTS.values=TAUTOT;
        end

        if(a390==1)
            TSS.values=TS;
        end

        if(a400==1)
            Var_ALBEDOS.values=Var_ALBEDO;
        end

        if(a410==1)
            Var_ALBNIRDFS.values=Var_ALBNIRDF;
        end
       
        if(a420==1)
            Var_ALBNIRDRS.values=Var_ALBNIRDR;
        end

        if(a430==1)
            Var_ALBVISDFS.values=Var_ALBVISDF;
        end

        if(a440==1)
            Var_ALBVISDRS.values=Var_ALBVISDR;
        end

        if(a450==1)
             Var_CLDHGHS.values= Var_CLDHGH;
        end

        if(a460==1)
             Var_CLDLOWS.values= Var_CLDLOW;
        end
    
        if(a470==1)
             Var_CLDMIDS.values= Var_CLDMID;
        end

        if(a480==1)
             Var_CLDTOTS.values= Var_CLDTOT;
        end

        if(a490==1)
             Var_EMISS.values= Var_EMIS;
        end

        if(a500==1)
             Var_LWGABS.values= Var_LWGAB;
        end
       
        if(a510==1)
             Var_LWGABCLRS.values= Var_LWGABCLR;
        end

        if(a520==1)
             Var_LWGABCLRCLNS.values= Var_LWGABCLRCLN;
        end
    
        if(a530==1)
             Var_LWGEMS.values= Var_LWGEM;
        end

        if(a540==1)
             Var_LWGNTS.values= Var_LWGNT;
        end
        
        if(a550==1)
             Var_LWGNTCLRS.values= Var_LWGNTCLR;
        end

        if(a560==1)
             Var_LWGNTCLRCLNS.values= Var_LWGNTCLRCLN;
        end

        if(a570==1)
             Var_LWTUPS.values= Var_LWTUP;
        end

        if(a580==1)
             Var_LWTUPCLRS.values= Var_LWTUPCLR;
        end
   
        if(a590==1)
             Var_LWTUPCLRCLNS.values= Var_LWTUPCLRCLN;
        end

        if(a600==1)
             Var_SWGDNS.values= Var_SWGDN;
        end
    
        if(a610==1)
             Var_SWGDNCLRS.values= Var_SWGDNCLR;
        end

        if(a620==1)
             Var_SWGNTS.values= Var_SWGNT;
        end

        if(a630==1)
              Var_SWGNTCLNS.values=  Var_SWGNTCLN;
        end

        if(a640==1)
              Var_SWGNTCLRS.values=  Var_SWGNTCLN;
        end
  
        if(a650==1)
              Var_SWGNTCLRCLNS.values=  Var_SWGNTCLRCLN;
        end
   
        if(a660==1)
              Var_SWTDNS.values=  Var_SWTDN;
        end

        if(a670==1)
              Var_SWTNTS.values=  Var_SWTNT;
        end

        if(a680==1)
               Var_SWTNTCLNS.values= Var_SWTNTCLN;
        end

        if(a690==1)
               Var_SWTNTCLRS.values= Var_SWTNTCLR;
        end

        if(a700==1)
               Var_SWTNTCLRCLNS.values= Var_SWTNTCLRCLN;
        end

        if(a710==1)
               Var_TAUHGHS.values= Var_TAUHGH;
        end

        if(a720==1)
               Var_TAULOWS.values= Var_TAULOW;
        end

        if(a730==1)
               Var_TAUMIDS.values= Var_TAUMID;
        end

        if(a740==1)
               Var_TAUTOTS.values= Var_TAUTOT;
        end

        if(a750==1)
               Var_TSS.values= Var_TS;
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
%Now write a Matlab file containing the decoded data
%use the original file name with a .mat extension
MatFileName=strcat('MonthlyRadDiag-',Merra2ShortFileName,'.mat');
if(isavefiles==1)
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='LonS LatS TimeS AlbedoS AlbnirdfS AlbnirdrS AlbvisdfS';
    varstr2='  AlbvisdrS CLDHGHS CLDLOWS CLDMIDS CLDTOTS';
    varstr3=' EmissS LWGABS LWGABCLRS LWGABCLRCLNS';
    varstr4=' LWGEMS LWGNTS LWGNTCLRS LWGNTCLRCLNS LWTUPS LWTUPCLRS';
    varstr5=' LWTUPCLRCLNS SWGDNS SWGDNCLRS SWGNTS SWGNTCLNS';
    varstr6=' SWGNTCLRS SWGNTCLRCLNS SWTDNS SWTNTS';
    varstr7=' SWTNTCLNS SWTNTCLRS SWTNTCLRCLNS TAUHGHS TAULOWS TAUMIDS TAUTOTS TSS';
    varstr8=' YearMonthStr YearStr MonthStr';
    varstr9=' numlat numlon Rpix latlim lonlim rasterSize';
    varstr=strcat(varstr1,varstr2,varstr3,varstr4,varstr5,varstr6,varstr7,varstr8,varstr9);
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr);
    savestr=strcat('Saved Decode Data to File=',MatFileName);
    fprintf(fid,'%s\n',savestr);
    disp(savestr)
else
    if(framecounter==1)
        dispstr=strcat('Did Not save Decoded Data to File-',MatFileName);
        disp(dispstr);
        fprintf(fid,'%s\n',dispstr);
    else

    end
end

%% Display the Plot Selected Parameters
 ikind=1;
 itype=3;
 varname='Albedo';
 iAddToReport=1;
 iNewChapter=1;
 iCloseChapter=0;
 iCityPlot=1;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=2;
 itype=3;
 varname='ALBIRDF';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 iCityPlot=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=3;
 itype=3;
 varname='ALBIRDR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=4;
 itype=3;
 varname='ALVISDF';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=5;
 itype=3;
 varname='ALVISDR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=6;
 itype=3;
 varname='CLDHGH';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=7;
 itype=3;
 varname='CLDLOW';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=8;
 itype=3;
 varname='CLDMID';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=9;
 itype=3;
 varname='CLDTOT';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=10;
 itype=3;
 varname='EMIS';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=13;
 itype=3;
 varname='LWGAB';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=14;
 itype=3;
 varname='LWGABCLR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=15;
 itype=3;
 varname='LWGABCLRCLN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=16;
 itype=3;
 varname='LWGEM';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=17;
 itype=3;
 varname='LWGNT';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=18;
 itype=3;
 varname='LWGNTCLR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=19;
 itype=3;
 varname='LWGNTCLRCLN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=20;
 itype=3;
 varname='LWTUP';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=21;
 itype=3;
 varname='LWTUPCLR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=22;
 itype=3;
 varname='LWTUPCLRCLN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=23;
 itype=3;
 varname='SWGDN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=24;
 itype=3;
 varname='SWGDNCLR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=25;
 itype=3;
 varname='SWGNT';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=26;
 itype=3;
 varname='SWGNTCLN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=27;
 itype=3;
 varname='SWGNTCLR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=28;
 itype=3;
 varname='SWGNTCLRCLN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=29;
 itype=3;
 varname='SWTDN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=30;
 itype=3;
 varname='SWTNT';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=31;
 itype=3;
 varname='SWTNTCLN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=32;
 itype=3;
 varname='SWTNTCLR';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=33;
 itype=3;
 varname='SWTNTCLRCLN';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=34;
 itype=3;
 varname='TAUHGH';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=35;
 itype=3;
 varname='TAULOW';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=36;
 itype=3;
 varname='TAUMID';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=37;
 itype=3;
 varname='TAUTOT';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
 ikind=39;
 itype=3;
 varname='TS';
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=1;
 DisplayMerra2MonthlyRadDiagnostics(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)



%% Capture Selected Statistics to Holding Arrays
if(framecounter<=numSelectedFiles)
% Start with the Alebedo ikind=1
  AlbedoValues=AlbedoS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(AlbedoValues,lowcutoff,highcutoff);
  Albedo10(framecounter,1)=val10;
  Albedo20(framecounter,1)=val20;
  Albedo30(framecounter,1)=val30;
  Albedo40(framecounter,1)=val40;
  Albedo50(framecounter,1)=val50;
  Albedo60(framecounter,1)=val60;
  Albedo70(framecounter,1)=val70;
  Albedo80(framecounter,1)=val80;
  Albedo90(framecounter,1)=val90;
  Albedo100(framecounter,1)=val100;
  AlbedoLow(framecounter,1)=fraclow;
  AlbedoHigh(framecounter,1)=frachigh;
  AlbedoNaN(framecounter,1)=fracNaN;
% Continue with the Surface Albedo for NearIR Diffuse ikind=2 
  AlbnirdfValues=AlbnirdfS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(AlbnirdfValues,lowcutoff,highcutoff);
  Albnirdf10(framecounter,1)=val10;
  Albnirdf20(framecounter,1)=val20;
  Albnirdf30(framecounter,1)=val30;
  Albnirdf40(framecounter,1)=val40;
  Albnirdf50(framecounter,1)=val50;
  Albnirdf60(framecounter,1)=val60;
  Albnirdf70(framecounter,1)=val70;
  Albnirdf80(framecounter,1)=val80;
  Albnirdf90(framecounter,1)=val90;
  Albnirdf100(framecounter,1)=val100;
  AlbnirdfLow(framecounter,1)=fraclow;
  AlbnirdfHigh(framecounter,1)=frachigh;
  AlbnirdfNaN(framecounter,1)=fracNaN;
% Continue with the Surface Albedo for NearIR Beam ikind=3
  AlbnirdrValues=AlbnirdrS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(AlbnirdrValues,lowcutoff,highcutoff);
  Albnirdr10(framecounter,1)=val10;
  Albnirdr20(framecounter,1)=val20;
  Albnirdr30(framecounter,1)=val30;
  Albnirdr40(framecounter,1)=val40;
  Albnirdr50(framecounter,1)=val50;
  Albnirdr60(framecounter,1)=val60;
  Albnirdr70(framecounter,1)=val70;
  Albnirdr80(framecounter,1)=val80;
  Albnirdr90(framecounter,1)=val90;
  Albnirdr100(framecounter,1)=val100;
  AlbnirdrLow(framecounter,1)=fraclow;
  AlbnirdrHigh(framecounter,1)=frachigh;
  AlbnirdrNaN(framecounter,1)=fracNaN;
% Continue with the Surface Albedo for VIS diffuse ikind=4
  AlbvisdfValues=AlbvisdfS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats( AlbvisdfValues,lowcutoff,highcutoff);
  Albvisdf10(framecounter,1)=val10;
  Albvisdf20(framecounter,1)=val20;
  Albvisdf30(framecounter,1)=val30;
  Albvisdf40(framecounter,1)=val40;
  Albvisdf50(framecounter,1)=val50;
  Albvisdf60(framecounter,1)=val60;
  Albvisdf70(framecounter,1)=val70;
  Albvisdf80(framecounter,1)=val80;
  Albvisdf90(framecounter,1)=val90;
  Albvisdf100(framecounter,1)=val100;
  AlbvisdfLow(framecounter,1)=fraclow;
  AlbvisdfHigh(framecounter,1)=frachigh;
  AlbvisdfNaN(framecounter,1)=fracNaN;
% Continue with the Surface Albedo for VIS diffuse ikind=5
  AlbvisdrValues=AlbvisdrS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(AlbvisdrValues,lowcutoff,highcutoff);
  Albvisdr10(framecounter,1)=val10;
  Albvisdr20(framecounter,1)=val20;
  Albvisdr30(framecounter,1)=val30;
  Albvisdr40(framecounter,1)=val40;
  Albvisdr50(framecounter,1)=val50;
  Albvisdr60(framecounter,1)=val60;
  Albvisdr70(framecounter,1)=val70;
  Albvisdr80(framecounter,1)=val80;
  Albvisdr90(framecounter,1)=val90;
  Albvisdr100(framecounter,1)=val100;
  AlbvisdrLow(framecounter,1)=fraclow;
  AlbvisdrHigh(framecounter,1)=frachigh;
  AlbvisdrNaN(framecounter,1)=fracNaN;
% Continue with the High Altitude cloud fraction ikind=6
  CLDHGHValues=CLDHGHS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(CLDHGHValues,lowcutoff,highcutoff);
  CLDHGH10(framecounter,1)=val10;
  CLDHGH20(framecounter,1)=val20;
  CLDHGH30(framecounter,1)=val30;
  CLDHGH40(framecounter,1)=val40;
  CLDHGH50(framecounter,1)=val50;
  CLDHGH60(framecounter,1)=val60;
  CLDHGH70(framecounter,1)=val70;
  CLDHGH80(framecounter,1)=val80;
  CLDHGH90(framecounter,1)=val90;
  CLDHGH100(framecounter,1)=val100;
  CLDHGHLow(framecounter,1)=fraclow;
  CLDHGHHigh(framecounter,1)=frachigh;
  CLDHGHNaN(framecounter,1)=fracNaN;
 % Continue with the Low Altitude cloud fraction ikind=7
  CLDLOWValues=CLDLOWS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(CLDLOWValues,lowcutoff,highcutoff);
  CLDLOW10(framecounter,1)=val10;
  CLDLOW20(framecounter,1)=val20;
  CLDLOW30(framecounter,1)=val30;
  CLDLOW40(framecounter,1)=val40;
  CLDLOW50(framecounter,1)=val50;
  CLDLOW60(framecounter,1)=val60;
  CLDLOW70(framecounter,1)=val70;
  CLDLOW80(framecounter,1)=val80;
  CLDLOW90(framecounter,1)=val90;
  CLDLOW100(framecounter,1)=val100;
  CLDLOWLow(framecounter,1)=fraclow;
  CLDLOWHigh(framecounter,1)=frachigh;
  CLDLOWNaN(framecounter,1)=fracNaN;
% Continue with the Mid Altitude cloud fraction ikind=8
  CLDMIDValues=CLDMIDS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(CLDMIDValues,lowcutoff,highcutoff);
  CLDMID10(framecounter,1)=val10;
  CLDMID20(framecounter,1)=val20;
  CLDMID30(framecounter,1)=val30;
  CLDMID40(framecounter,1)=val40;
  CLDMID50(framecounter,1)=val50;
  CLDMID60(framecounter,1)=val60;
  CLDMID70(framecounter,1)=val70;
  CLDMID80(framecounter,1)=val80;
  CLDMID90(framecounter,1)=val90;
  CLDMID100(framecounter,1)=val100;
  CLDMIDLow(framecounter,1)=fraclow;
  CLDMIDHigh(framecounter,1)=frachigh;
  CLDMIDNaN(framecounter,1)=fracNaN;
% Continue with the Total cloud fraction ikind=9
  CLDTOTValues=CLDTOTS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(CLDHGHValues,lowcutoff,highcutoff);
  CLDTOT10(framecounter,1)=val10;
  CLDTOT20(framecounter,1)=val20;
  CLDTOT30(framecounter,1)=val30;
  CLDTOT40(framecounter,1)=val40;
  CLDTOT50(framecounter,1)=val50;
  CLDTOT60(framecounter,1)=val60;
  CLDTOT70(framecounter,1)=val70;
  CLDTOT80(framecounter,1)=val80;
  CLDTOT90(framecounter,1)=val90;
  CLDTOT100(framecounter,1)=val100;
  CLDTOTLow(framecounter,1)=fraclow;
  CLDTOTHigh(framecounter,1)=frachigh;
  CLDTOTNaN(framecounter,1)=fracNaN;
 % Continue with the Surface Emissivity ikind==10
  SEmisValues=EmissS.values;
  lowcutoff=0;
  highcutoff=1;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(CLDHGHValues,lowcutoff,highcutoff);
  SEmis10(framecounter,1)=val10;
  SEmis20(framecounter,1)=val20;
  SEmis30(framecounter,1)=val30;
  SEmis40(framecounter,1)=val40;
  SEmis50(framecounter,1)=val50;
  SEmis60(framecounter,1)=val60;
  SEmis70(framecounter,1)=val70;
  SEmis80(framecounter,1)=val80;
  SEmis90(framecounter,1)=val90;
  SEmis100(framecounter,1)=val100;
  SEmisLow(framecounter,1)=fraclow;
  SEmisHigh(framecounter,1)=frachigh;
  SEmisNaN(framecounter,1)=fracNaN;
 % Continue with the Surface Absorbed Long Wave Radiation ikind==13
  LWGABValues=LWGABS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWGABValues,lowcutoff,highcutoff);
  LWGAB10(framecounter,1)=val10;
  LWGAB20(framecounter,1)=val20;
  LWGAB30(framecounter,1)=val30;
  LWGAB40(framecounter,1)=val40;
  LWGAB50(framecounter,1)=val50;
  LWGAB60(framecounter,1)=val60;
  LWGAB70(framecounter,1)=val70;
  LWGAB80(framecounter,1)=val80;
  LWGAB90(framecounter,1)=val90;
  LWGAB100(framecounter,1)=val100;
  LWGABLow(framecounter,1)=fraclow;
  LWGABHigh(framecounter,1)=frachigh;
  LWGABNaN(framecounter,1)=fracNaN;
% Continue with the Surface Absorbed Long Wave Radiation For Clear Sky ikind==14
  LWGABCLRValues=LWGABCLRS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWGABCLRValues,lowcutoff,highcutoff);
  LWGABCLR10(framecounter,1)=val10;
  LWGABCLR20(framecounter,1)=val20;
  LWGABCLR30(framecounter,1)=val30;
  LWGABCLR40(framecounter,1)=val40;
  LWGABCLR50(framecounter,1)=val50;
  LWGABCLR60(framecounter,1)=val60;
  LWGABCLR70(framecounter,1)=val70;
  LWGABCLR80(framecounter,1)=val80;
  LWGABCLR90(framecounter,1)=val90;
  LWGABCLR100(framecounter,1)=val100;
  LWGABCLRLow(framecounter,1)=fraclow;
  LWGABCLRHigh(framecounter,1)=frachigh;
  LWGABCLRNaN(framecounter,1)=fracNaN;
% Continue with the Surface Absorbed Long Wave Radiation For Clear Sky No
% Aerosol ikind==15
  LWGABCLRCLNValues=LWGABCLRCLNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWGABCLRCLNValues,lowcutoff,highcutoff);
  LWGABCLRCLN10(framecounter,1)=val10;
  LWGABCLRCLN20(framecounter,1)=val20;
  LWGABCLRCLN30(framecounter,1)=val30;
  LWGABCLRCLN40(framecounter,1)=val40;
  LWGABCLRCLN50(framecounter,1)=val50;
  LWGABCLRCLN60(framecounter,1)=val60;
  LWGABCLRCLN70(framecounter,1)=val70;
  LWGABCLRCLN80(framecounter,1)=val80;
  LWGABCLRCLN90(framecounter,1)=val90;
  LWGABCLRCLN100(framecounter,1)=val100;
  LWGABCLRCLNLow(framecounter,1)=fraclow;
  LWGABCLRCLNHigh(framecounter,1)=frachigh;
  LWGABCLRCLNNaN(framecounter,1)=fracNaN ;
  %disp('Finish Stats on ikind=15')
  % Continue with LWGEM or Longwave emitted flux from surface Index==16
  LWGEMValues=LWGEMS.values;
  lowcutoff=0;
  highcutoff=1000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWGEMValues,lowcutoff,highcutoff);
  LWGEM10(framecounter,1)=val10;
  LWGEM20(framecounter,1)=val20;
  LWGEM30(framecounter,1)=val30;
  LWGEM40(framecounter,1)=val40;
  LWGEM50(framecounter,1)=val50;
  LWGEM60(framecounter,1)=val60;
  LWGEM70(framecounter,1)=val70;
  LWGEM80(framecounter,1)=val80;
  LWGEM90(framecounter,1)=val90;
  LWGEM100(framecounter,1)=val100;
  LWGEMLow(framecounter,1)=fraclow;
  LWGEMHigh(framecounter,1)=frachigh;
  LWGEMNaN(framecounter,1)=fracNaN;
% Continue with LWGNT or Longwave emitted flux from surface ikind==17
  LWGNTValues=LWGNTS.values;
  lowcutoff=-1000;
  highcutoff=1000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWGNTValues,lowcutoff,highcutoff);
  LWGNT10(framecounter,1)=val10;
  LWGNT20(framecounter,1)=val20;
  LWGNT30(framecounter,1)=val30;
  LWGNT40(framecounter,1)=val40;
  LWGNT50(framecounter,1)=val50;
  LWGNT60(framecounter,1)=val60;
  LWGNT70(framecounter,1)=val70;
  LWGNT80(framecounter,1)=val80;
  LWGNT90(framecounter,1)=val90;
  LWGNT100(framecounter,1)=val100;
  LWGNTLow(framecounter,1)=fraclow;
  LWGNTHigh(framecounter,1)=frachigh;
  LWGNTNaN(framecounter,1)=fracNaN;
 
 % Continue with LWGNTCLR Surface LW net downward flux for clear sky ikind==18
  LWGNTCLRValues=LWGNTCLRS.values;
  lowcutoff=-1000;
  highcutoff=1000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWGNTCLRValues,lowcutoff,highcutoff);
  LWGNTCLR10(framecounter,1)=val10;
  LWGNTCLR20(framecounter,1)=val20;
  LWGNTCLR30(framecounter,1)=val30;
  LWGNTCLR40(framecounter,1)=val40;
  LWGNTCLR50(framecounter,1)=val50;
  LWGNTCLR60(framecounter,1)=val60;
  LWGNTCLR70(framecounter,1)=val70;
  LWGNTCLR80(framecounter,1)=val80;
  LWGNTCLR90(framecounter,1)=val90;
  LWGNTCLR100(framecounter,1)=val100;
  LWGNTCLRLow(framecounter,1)=fraclow;
  LWGNTCLRHigh(framecounter,1)=frachigh;
  LWGNTCLRNaN(framecounter,1)=fracNaN;
% Continue with LWGNTCLRCLN Surface LW net downward flux for clear sky-no
% aerosol ikind==19
  LWGNTCLRCLNValues=LWGNTCLRCLNS.values;
  lowcutoff=-1000;
  highcutoff=1000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWGNTCLRCLNValues,lowcutoff,highcutoff);
  LWGNTCLRCLN10(framecounter,1)=val10;
  LWGNTCLRCLN20(framecounter,1)=val20;
  LWGNTCLRCLN30(framecounter,1)=val30;
  LWGNTCLRCLN40(framecounter,1)=val40;
  LWGNTCLRCLN50(framecounter,1)=val50;
  LWGNTCLRCLN60(framecounter,1)=val60;
  LWGNTCLRCLN70(framecounter,1)=val70;
  LWGNTCLRCLN80(framecounter,1)=val80;
  LWGNTCLRCLN90(framecounter,1)=val90;
  LWGNTCLRCLN100(framecounter,1)=val100;
  LWGNTCLRCLNLow(framecounter,1)=fraclow;
  LWGNTCLRCLNHigh(framecounter,1)=frachigh;
  LWGNTCLRCLNNaN(framecounter,1)=fracNaN;
  % Continue with the LWTUP or LW upwelling flux at TOA ikind=20
  LWTUPValues=LWTUPS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWTUPValues,lowcutoff,highcutoff);
  LWTUP10(framecounter,1)=val10;
  LWTUP20(framecounter,1)=val20;
  LWTUP30(framecounter,1)=val30;
  LWTUP40(framecounter,1)=val40;
  LWTUP50(framecounter,1)=val50;
  LWTUP60(framecounter,1)=val60;
  LWTUP70(framecounter,1)=val70;
  LWTUP80(framecounter,1)=val80;
  LWTUP90(framecounter,1)=val90;
  LWTUP100(framecounter,1)=val100;
  LWTUPLow(framecounter,1)=fraclow;
  LWTUPHigh(framecounter,1)=frachigh;
  LWTUPNaN(framecounter,1)=fracNaN;
% Continue with the LWTUPCLN or LW clear sky upwelling flux at TOA ikind=21
  LWTUPCLRValues=LWTUPCLRS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWTUPCLRValues,lowcutoff,highcutoff);
  LWTUPCLR10(framecounter,1)=val10;
  LWTUPCLR20(framecounter,1)=val20;
  LWTUPCLR30(framecounter,1)=val30;
  LWTUPCLR40(framecounter,1)=val40;
  LWTUPCLR50(framecounter,1)=val50;
  LWTUPCLR60(framecounter,1)=val60;
  LWTUPCLR70(framecounter,1)=val70;
  LWTUPCLR80(framecounter,1)=val80;
  LWTUPCLR90(framecounter,1)=val90;
  LWTUPCLR100(framecounter,1)=val100;
  LWTUPCLRLow(framecounter,1)=fraclow;
  LWTUPCLRHigh(framecounter,1)=frachigh;
  LWTUPCLRNaN(framecounter,1)=fracNaN;
% Continue with the LWTUPCLN or LW clear sky no/aero upwelling flux at TOA ikind=22
  LWTUPCLRCLNValues=LWTUPCLRCLNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(LWTUPCLRCLNValues,lowcutoff,highcutoff);
  LWTUPCLRCLN10(framecounter,1)=val10;
  LWTUPCLRCLN20(framecounter,1)=val20;
  LWTUPCLRCLN30(framecounter,1)=val30;
  LWTUPCLRCLN40(framecounter,1)=val40;
  LWTUPCLRCLN50(framecounter,1)=val50;
  LWTUPCLRCLN60(framecounter,1)=val60;
  LWTUPCLRCLN70(framecounter,1)=val70;
  LWTUPCLRCLN80(framecounter,1)=val80;
  LWTUPCLRCLN90(framecounter,1)=val90;
  LWTUPCLRCLN100(framecounter,1)=val100;
  LWTUPCLRCLNLow(framecounter,1)=fraclow;
  LWTUPCLRCLNHigh(framecounter,1)=frachigh;
  LWTUPCLRCLNNaN(framecounter,1)=fracNaN;
% Continue with the SWGDN or Surface Incoming Shortwave Flux - ikind=23
  SWGDNValues=SWGDNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWGDNValues,lowcutoff,highcutoff);
  SWGDN10(framecounter,1)=val10;
  SWGDN20(framecounter,1)=val20;
  SWGDN30(framecounter,1)=val30;
  SWGDN40(framecounter,1)=val40;
  SWGDN50(framecounter,1)=val50;
  SWGDN60(framecounter,1)=val60;
  SWGDN70(framecounter,1)=val70;
  SWGDN80(framecounter,1)=val80;
  SWGDN90(framecounter,1)=val90;
  SWGDN100(framecounter,1)=val100;
  SWGDNLow(framecounter,1)=fraclow;
  SWGDNHigh(framecounter,1)=frachigh;
  SWGDNNaN(framecounter,1)=fracNaN;
% Continue with the SWGDNCLR or Surface Incoming Shortwave Flux Clear Sky -
% ikind=24
  SWGDNCLRValues=SWGDNCLRS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWGDNCLRValues,lowcutoff,highcutoff);
  SWGDNCLR10(framecounter,1)=val10;
  SWGDNCLR20(framecounter,1)=val20;
  SWGDNCLR30(framecounter,1)=val30;
  SWGDNCLR40(framecounter,1)=val40;
  SWGDNCLR50(framecounter,1)=val50;
  SWGDNCLR60(framecounter,1)=val60;
  SWGDNCLR70(framecounter,1)=val70;
  SWGDNCLR80(framecounter,1)=val80;
  SWGDNCLR90(framecounter,1)=val90;
  SWGDNCLR100(framecounter,1)=val100;
  SWGDNCLRLow(framecounter,1)=fraclow;
  SWGDNCLRHigh(framecounter,1)=frachigh;
  SWGDNCLRNaN(framecounter,1)=fracNaN;
% Continue with the SWGNT or Surface net downward shortwave flux ikind=25
  SWGNTValues=SWGNTS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWGNTValues,lowcutoff,highcutoff);
  SWGNT10(framecounter,1)=val10;
  SWGNT20(framecounter,1)=val20;
  SWGNT30(framecounter,1)=val30;
  SWGNT40(framecounter,1)=val40;
  SWGNT50(framecounter,1)=val50;
  SWGNT60(framecounter,1)=val60;
  SWGNT70(framecounter,1)=val70;
  SWGNT80(framecounter,1)=val80;
  SWGNT90(framecounter,1)=val90;
  SWGNT100(framecounter,1)=val100;
  SWGNTLow(framecounter,1)=fraclow;
  SWGNTHigh(framecounter,1)=frachigh;
  SWGNTNaN(framecounter,1)=fracNaN;
  % Continue with the SWGNTCLN or Surface net downward shortwave flux-no
  % aerosol ikind=26
  SWGNTCLNValues=SWGNTCLNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWGNTCLNValues,lowcutoff,highcutoff);
  SWGNTCLN10(framecounter,1)=val10;
  SWGNTCLN20(framecounter,1)=val20;
  SWGNTCLN30(framecounter,1)=val30;
  SWGNTCLN40(framecounter,1)=val40;
  SWGNTCLN50(framecounter,1)=val50;
  SWGNTCLN60(framecounter,1)=val60;
  SWGNTCLN70(framecounter,1)=val70;
  SWGNTCLN80(framecounter,1)=val80;
  SWGNTCLN90(framecounter,1)=val90;
  SWGNTCLN100(framecounter,1)=val100;
  SWGNTCLNLow(framecounter,1)=fraclow;
  SWGNTCLNHigh(framecounter,1)=frachigh;
  SWGNTCLNNaN(framecounter,1)=fracNaN;
 % Continue with the SWGNTCLR or Surface net downward shortwave flux-clear
 % sky ikind=27
  SWGNTCLRValues=SWGNTCLRS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWGNTCLRValues,lowcutoff,highcutoff);
  SWGNTCLR10(framecounter,1)=val10;
  SWGNTCLR20(framecounter,1)=val20;
  SWGNTCLR30(framecounter,1)=val30;
  SWGNTCLR40(framecounter,1)=val40;
  SWGNTCLR50(framecounter,1)=val50;
  SWGNTCLR60(framecounter,1)=val60;
  SWGNTCLR70(framecounter,1)=val70;
  SWGNTCLR80(framecounter,1)=val80;
  SWGNTCLR90(framecounter,1)=val90;
  SWGNTCLR100(framecounter,1)=val100;
  SWGNTCLRLow(framecounter,1)=fraclow;
  SWGNTCLRHigh(framecounter,1)=frachigh;
  SWGNTCLRNaN(framecounter,1)=fracNaN;
 % Continue with the SWGNTCLRCLN or Surface net downward shortwave flux-clear
 % sky no aerosol ikind=28
  SWGNTCLRCLNValues=SWGNTCLRCLNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWGNTCLRCLNValues,lowcutoff,highcutoff);
  SWGNTCLRCLN10(framecounter,1)=val10;
  SWGNTCLRCLN20(framecounter,1)=val20;
  SWGNTCLRCLN30(framecounter,1)=val30;
  SWGNTCLRCLN40(framecounter,1)=val40;
  SWGNTCLRCLN50(framecounter,1)=val50;
  SWGNTCLRCLN60(framecounter,1)=val60;
  SWGNTCLRCLN70(framecounter,1)=val70;
  SWGNTCLRCLN80(framecounter,1)=val80;
  SWGNTCLRCLN90(framecounter,1)=val90;
  SWGNTCLRCLN100(framecounter,1)=val100;
  SWGNTCLRCLNLow(framecounter,1)=fraclow;
  SWGNTCLRCLNHigh(framecounter,1)=frachigh;
  SWGNTCLRCLNNaN(framecounter,1)=fracNaN;
 % Continue with SWTDN or TOA Incoming Shortwave Flux - ikind=29
  SWTDNValues=SWTDNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWTDNValues,lowcutoff,highcutoff);
  SWTDN10(framecounter,1)=val10;
  SWTDN20(framecounter,1)=val20;
  SWTDN30(framecounter,1)=val30;
  SWTDN40(framecounter,1)=val40;
  SWTDN50(framecounter,1)=val50;
  SWTDN60(framecounter,1)=val60;
  SWTDN70(framecounter,1)=val70;
  SWTDN80(framecounter,1)=val80;
  SWTDN90(framecounter,1)=val90;
  SWTDN100(framecounter,1)=val100;
  SWTDNLow(framecounter,1)=fraclow;
  SWTDNHigh(framecounter,1)=frachigh;
  SWTDNNaN(framecounter,1)=fracNaN; 
% Continue with SWTNT or TOA Net Downward Shortwave Flux - ikind=30
  SWTNTValues=SWTNTS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWTNTValues,lowcutoff,highcutoff);
  SWTNT10(framecounter,1)=val10;
  SWTNT20(framecounter,1)=val20;
  SWTNT30(framecounter,1)=val30;
  SWTNT40(framecounter,1)=val40;
  SWTNT50(framecounter,1)=val50;
  SWTNT60(framecounter,1)=val60;
  SWTNT70(framecounter,1)=val70;
  SWTNT80(framecounter,1)=val80;
  SWTNT90(framecounter,1)=val90;
  SWTNT100(framecounter,1)=val100;
  SWTNTLow(framecounter,1)=fraclow;
  SWTNTHigh(framecounter,1)=frachigh;
  SWTNTNaN(framecounter,1)=fracNaN; 
 % Continue with SWTNTCLN or TOA Net Downward Shortwave Flux No Aero  - ikind=31
  SWTNTCLNValues=SWTNTCLNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWTNTCLNValues,lowcutoff,highcutoff);
  SWTNTCLN10(framecounter,1)=val10;
  SWTNTCLN20(framecounter,1)=val20;
  SWTNTCLN30(framecounter,1)=val30;
  SWTNTCLN40(framecounter,1)=val40;
  SWTNTCLN50(framecounter,1)=val50;
  SWTNTCLN60(framecounter,1)=val60;
  SWTNTCLN70(framecounter,1)=val70;
  SWTNTCLN80(framecounter,1)=val80;
  SWTNTCLN90(framecounter,1)=val90;
  SWTNTCLN100(framecounter,1)=val100;
  SWTNTCLNLow(framecounter,1)=fraclow;
  SWTNTCLNHigh(framecounter,1)=frachigh;
  SWTNTCLNNaN(framecounter,1)=fracNaN; 
 % Continue with SWTNTCLN or TOA Net Downward Shortwave Flux No Aero  -
 % ikind=32
  SWTNTCLRValues=SWTNTCLRS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWTNTCLRValues,lowcutoff,highcutoff);
  SWTNTCLR10(framecounter,1)=val10;
  SWTNTCLR20(framecounter,1)=val20;
  SWTNTCLR30(framecounter,1)=val30;
  SWTNTCLR40(framecounter,1)=val40;
  SWTNTCLR50(framecounter,1)=val50;
  SWTNTCLR60(framecounter,1)=val60;
  SWTNTCLR70(framecounter,1)=val70;
  SWTNTCLR80(framecounter,1)=val80;
  SWTNTCLR90(framecounter,1)=val90;
  SWTNTCLR100(framecounter,1)=val100;
  SWTNTCLRLow(framecounter,1)=fraclow;
  SWTNTCLRHigh(framecounter,1)=frachigh;
  SWTNTCLRNaN(framecounter,1)=fracNaN; 
 % Continue with SWTNTCLRCLN or TOA Net Downward Shortwave Flux No Aero/Clear Sky  -
 % ikind=33
  SWTNTCLRCLNValues=SWTNTCLRCLNS.values;
  lowcutoff=0;
  highcutoff=2000;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(SWTNTCLRCLNValues,lowcutoff,highcutoff);
  SWTNTCLRCLN10(framecounter,1)=val10;
  SWTNTCLRCLN20(framecounter,1)=val20;
  SWTNTCLRCLN30(framecounter,1)=val30;
  SWTNTCLRCLN40(framecounter,1)=val40;
  SWTNTCLRCLN50(framecounter,1)=val50;
  SWTNTCLRCLN60(framecounter,1)=val60;
  SWTNTCLRCLN70(framecounter,1)=val70;
  SWTNTCLRCLN80(framecounter,1)=val80;
  SWTNTCLRCLN90(framecounter,1)=val90;
  SWTNTCLRCLN100(framecounter,1)=val100;
  SWTNTCLRCLNLow(framecounter,1)=fraclow;
  SWTNTCLRCLNHigh(framecounter,1)=frachigh;
  SWTNTCLRCLNNaN(framecounter,1)=fracNaN; 
% Continue with TAUHGH or High Cloud Optical Thickness - ikind= 34
  TAUHGHValues=TAUHGHS.values;
  lowcutoff=0;
  highcutoff=20;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(TAUHGHValues,lowcutoff,highcutoff);
  TAUHGH10(framecounter,1)=val10;
  TAUHGH20(framecounter,1)=val20;
  TAUHGH30(framecounter,1)=val30;
  TAUHGH40(framecounter,1)=val40;
  TAUHGH50(framecounter,1)=val50;
  TAUHGH60(framecounter,1)=val60;
  TAUHGH70(framecounter,1)=val70;
  TAUHGH80(framecounter,1)=val80;
  TAUHGH90(framecounter,1)=val90;
  TAUHGH100(framecounter,1)=val100;
  TAUHGHLow(framecounter,1)=fraclow;
  TAUHGHHigh(framecounter,1)=frachigh;
  TAUHGHNaN(framecounter,1)=fracNaN;
% Continue with TAULOW or LOW Cloud Optical Thickness - ikind= 35
  TAULOWValues=TAULOWS.values;
  lowcutoff=0;
  highcutoff=20;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(TAULOWValues,lowcutoff,highcutoff);
  TAULOW10(framecounter,1)=val10;
  TAULOW20(framecounter,1)=val20;
  TAULOW30(framecounter,1)=val30;
  TAULOW40(framecounter,1)=val40;
  TAULOW50(framecounter,1)=val50;
  TAULOW60(framecounter,1)=val60;
  TAULOW70(framecounter,1)=val70;
  TAULOW80(framecounter,1)=val80;
  TAULOW90(framecounter,1)=val90;
  TAULOW100(framecounter,1)=val100;
  TAULOWLow(framecounter,1)=fraclow;
  TAULOWHigh(framecounter,1)=frachigh;
  TAULOWNaN(framecounter,1)=fracNaN;
% Continue with TAUMID or MID Cloud Optical Thickness - ikind= 36
  TAUMIDValues=TAUMIDS.values;
  lowcutoff=0;
  highcutoff=20;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(TAUMIDValues,lowcutoff,highcutoff);
  TAUMID10(framecounter,1)=val10;
  TAUMID20(framecounter,1)=val20;
  TAUMID30(framecounter,1)=val30;
  TAUMID40(framecounter,1)=val40;
  TAUMID50(framecounter,1)=val50;
  TAUMID60(framecounter,1)=val60;
  TAUMID70(framecounter,1)=val70;
  TAUMID80(framecounter,1)=val80;
  TAUMID90(framecounter,1)=val90;
  TAUMID100(framecounter,1)=val100;
  TAUMIDLow(framecounter,1)=fraclow;
  TAUMIDHigh(framecounter,1)=frachigh;
  TAUMIDNaN(framecounter,1)=fracNaN;
% Continue with TAUTOT or TOT Cloud Optical Thickness - ikind= 37
  TAUTOTValues=TAUTOTS.values;
  lowcutoff=0;
  highcutoff=20;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(TAUTOTValues,lowcutoff,highcutoff);
  TAUTOT10(framecounter,1)=val10;
  TAUTOT20(framecounter,1)=val20;
  TAUTOT30(framecounter,1)=val30;
  TAUTOT40(framecounter,1)=val40;
  TAUTOT50(framecounter,1)=val50;
  TAUTOT60(framecounter,1)=val60;
  TAUTOT70(framecounter,1)=val70;
  TAUTOT80(framecounter,1)=val80;
  TAUTOT90(framecounter,1)=val90;
  TAUTOT100(framecounter,1)=val100;
  TAUTOTLow(framecounter,1)=fraclow;
  TAUTOTHigh(framecounter,1)=frachigh;
  TAUTOTNaN(framecounter,1)=fracNaN;
% Continue with TS or Skin Temperature - ikind= 39
  TSValues=TSS.values;
  lowcutoff=0;
  highcutoff=500;
  [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(TSValues,lowcutoff,highcutoff);
  TS10(framecounter,1)=val10;
  TS20(framecounter,1)=val20;
  TS30(framecounter,1)=val30;
  TS40(framecounter,1)=val40;
  TS50(framecounter,1)=val50;
  TS60(framecounter,1)=val60;
  TS70(framecounter,1)=val70;
  TS80(framecounter,1)=val80;
  TS90(framecounter,1)=val90;
  TS100(framecounter,1)=val100;
  TSLow(framecounter,1)=fraclow;
  TSHigh(framecounter,1)=frachigh;
  TSNaN(framecounter,1)=fracNaN;
end
if(framecounter==1)
    yd=str2double(YearMonthStr(1:4));
    md=str2double(YearMonthStr(5:6));
    dd=15;
end
%% Calcuate the Correlation Matrices for selected variables
% Correlation Matrice variables
% Albedo  #1 ikind==1
% CLDHGH  #2 ikind==6
% EMIS    #3 ikind==10
% LWGAB   #4 ikind==13
% LWGEM   #5 ikind==16
% SWGDN   #6 ikind==23
% TAUHGH  #7 ikind==34
% TS      #8 ikind==39

AlbedoValues=AlbedoS.values;
CLDHGHValues=CLDHGHS.values;
EMISValues=EmissS.values;
LWGABValues=LWGABS.values;
LWGEMValues=LWGEMS.values;
SWGDNValues=SWGDNS.values;
TAUHGHValues=TAUHGHS.values;
TSValues=TSS.values;
if(framecounter==1)
    RCOEFF=zeros(8,8);
    RCOEFFHist=zeros(8,8,numSelectedFiles);
end
if(framecounter>0)
    rho11a=corrcoef(AlbedoValues,AlbedoValues);
    rho11=rho11a(1,2);
    rho12a=corrcoef(AlbedoValues,CLDHGHValues);
    rho12=rho12a(1,2);
    rho13a=corrcoef(AlbedoValues,EMISValues);
    rho13=rho13a(1,2);
    rho14a=corrcoef(AlbedoValues,LWGABValues);
    rho14=rho14a(1,2);
    rho15a=corrcoef(AlbedoValues,LWGEMValues);
    rho15=rho15a(1,2);
    rho15=rho15a(1,2);
    rho16a=corrcoef(AlbedoValues,SWGDNValues);
    rho16=rho16a(1,2);
    rho17a=corrcoef(AlbedoValues,TAUHGHValues);
    rho17=rho17a(1,2);
    rho18a=corrcoef(AlbedoValues,TSValues);
    rho18=rho18a(1,2);
    rho21=rho12;
    rho31=rho13;
    rho41=rho14;
    rho51=rho15;
    rho61=rho16;
    rho71=rho17;
    rho81=rho18;
    rho22a=corrcoef(CLDHGHValues,CLDHGHValues);
    rho22=rho22a(1,2);
    rho23a=corrcoef(CLDHGHValues,EMISValues);
    rho23=rho23a(1,2);
    rho24a=corrcoef(CLDHGHValues,LWGABValues);
    rho24=rho24a(1,2);
    rho25a=corrcoef(CLDHGHValues,LWGEMValues);
    rho25=rho25a(1,2);
    rho26a=corrcoef(CLDHGHValues,SWGDNValues);
    rho26=rho26a(1,2);
    rho27a=corrcoef(CLDHGHValues,TAUHGHValues);
    rho27=rho27a(1,2);
    rho28a=corrcoef(CLDHGHValues,TSValues);
    rho28=rho28a(1,2);
    rho32=rho23;
    rho42=rho24;
    rho52=rho25;
    rho62=rho26;
    rho72=rho27;
    rho82=rho28;
    rho33a=corrcoef(EMISValues,EMISValues);
    rho33=rho33a(1,2);
    rho34a=corrcoef(EMISValues,LWGABValues);
    rho34=rho34a(1,2);
    rho35a=corrcoef(EMISValues,LWGEMValues);
    rho35=rho35a(1,2);
    rho36a=corrcoef(EMISValues,SWGDNValues);
    rho36=rho36a(1,2);
    rho37a=corrcoef(EMISValues,TAUHGHValues);
    rho37=rho37a(1,2);
    rho38a=corrcoef(EMISValues,TSValues);
    rho38=rho38a(1,2);
    rho43=rho34;
    rho53=rho35;
    rho63=rho36;
    rho73=rho37;
    rho83=rho38;
    rho44a=corrcoef(LWGABValues,LWGABValues);
    rho44=rho44a(1,2);
    rho45a=corrcoef(LWGABValues,LWGEMValues);
    rho45=rho45a(1,2);
    rho46a=corrcoef(LWGABValues,SWGDNValues);
    rho46=rho46a(1,2);
    rho47a=corrcoef(LWGABValues,TAUHGHValues);
    rho47=rho47a(1,2);
    rho48a=corrcoef(LWGABValues,TSValues);
    rho48=rho48a(1,2);
    rho54=rho45;
    rho64=rho46;
    rho74=rho47;
    rho84=rho48;
    rho55a=corrcoef(LWGEMValues,LWGEMValues);
    rho55=rho55a(1,2);
    rho56a=corrcoef(LWGEMValues,SWGDNValues);
    rho56=rho56a(1,2);
    rho57a=corrcoef(LWGEMValues,TAUHGHValues);
    rho57=rho57a(1,2);
    rho58a=corrcoef(LWGEMValues,TSValues);
    rho58=rho58a(1,2);
    rho65=rho56;
    rho66a=corrcoef(SWGDNValues,SWGDNValues);
    rho66=rho66a(1,2);
    rho67a=corrcoef(SWGDNValues,TAUHGHValues);
    rho67=rho67a(1,2);
    rho68a=corrcoef(SWGDNValues,TSValues);
    rho68=rho68a(1,2);
    rho75=rho57;
    rho76=rho67;
    rho86=rho68;
    rho77a=corrcoef(TAUHGHValues,TAUHGHValues);
    rho77=rho77a(1,2);
    rho78a=corrcoef(TAUHGHValues,TSValues);
    rho78=rho78a(1,2);
    rho85=rho58;
    rho87=rho78;
    rho88=1;
    RCOEFF=[ rho11 rho12 rho13 rho14 rho15 rho16 rho17 rho18;
             rho21 rho22 rho23 rho24 rho25 rho26 rho27 rho28;
             rho31 rho32 rho33 rho34 rho35 rho36 rho37 rho38;
             rho41 rho42 rho43 rho44 rho45 rho46 rho47 rho48;
             rho51 rho52 rho53 rho54 rho55 rho56 rho57 rho58;
             rho61 rho62 rho63 rho64 rho65 rho66 rho67 rho68;
             rho71 rho72 rho73 rho74 rho75 rho76 rho77 rho78;
             rho81 rho82 rho83 rho84 rho85 rho86 rho87 rho88];
    RCOEFFHist(:,:,framecounter)=RCOEFF(:,:);

end
%% Create a series of timetables
if(framecounter==numSelectedFiles)

  stime=datetime(yd,md,dd);
  timestep=calmonths(1);
  fprintf(fid,'%s\n','----Start Creating Tables----');
% Create the Albedo Table ikind=1
  AlbedoTable=table(Albedo10(:,1),Albedo20(:,1),Albedo30(:,1),...
            Albedo40(:,1),Albedo50(:,1),Albedo60(:,1),...
            Albedo70(:,1),Albedo80(:,1),Albedo90(:,1),Albedo100(:,1),...
            'VariableNames',{'Albedo10','Albedo20','Albedo30',...
            'Albedo40','Albedo50','Albedo60','Albedo70',...
            'Albedo80','Albedo90','Albedo100'});
  AlbedoTT = table2timetable(AlbedoTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='AlbedoTable AlbedoTT';
  MatFileName=strcat('AlbedoTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  albedostr=strcat('Created AlbedoTT-','Contains Surface Alebedo Data-',num2str(1));
  fprintf(fid,'%s\n',albedostr);

% Create the Albedo Table ikind=2
  AlbnirdfTable=table(Albnirdf10(:,1),Albnirdf20(:,1),Albnirdf30(:,1),...
            Albnirdf40(:,1),Albnirdf50(:,1),Albnirdf60(:,1),...
            Albnirdf70(:,1),Albnirdf80(:,1),Albnirdf90(:,1),Albnirdf100(:,1),...
            'VariableNames',{'Albnirdf10','Albnirdf20','Albnirdf30',...
            'Albnirdf40','Albnirdf50','Albnirdf60','Albnirdf70',...
            'Albnirdf80','Albnirdf90','Albnirdf100'});
  AlbnirdfTT = table2timetable(AlbnirdfTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='AlbnirdfTable AlbnirdfTT';
  MatFileName=strcat('AlbnirdfTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  albedonirstr=strcat('Created AlbnirdfTT-','Contains Surface NearIRAlebedo Data-',num2str(2));
  fprintf(fid,'%s\n',albedonirstr);

  % Create the Albedo Table ikind=3
  AlbnirdrTable=table(Albnirdr10(:,1),Albnirdr20(:,1),Albnirdr30(:,1),...
            Albnirdr40(:,1),Albnirdr50(:,1),Albnirdr60(:,1),...
            Albnirdr70(:,1),Albnirdr80(:,1),Albnirdr90(:,1),Albnirdr100(:,1),...
            'VariableNames',{'Albnirdr10','Albnirdr20','Albnirdr30',...
            'Albnirdr40','Albnirdr50','Albnirdr60','Albnirdr70',...
            'Albnirdr80','Albnirdr90','Albnirdr100'});
  AlbnirdrTT = table2timetable(AlbnirdrTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='AlbnirdrTable AlbnirdrTT';
  MatFileName=strcat('AlbnirdrTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  albedonirdstr=strcat('Created AlbnirdrTT-','Contains Surface NearIR Albedo Beam Data -',num2str(3));
  fprintf(fid,'%s\n',albedonirdstr);

% Create the Albedo Table ikind=4
  AlbvisdfTable=table(Albvisdf10(:,1),Albvisdf20(:,1),Albvisdf30(:,1),...
            Albvisdf40(:,1),Albvisdf50(:,1),Albvisdf60(:,1),...
            Albvisdf70(:,1),Albvisdf80(:,1),Albvisdf90(:,1),Albvisdf100(:,1),...
            'VariableNames',{'Albvisdf10','Albvisdf20','Albvisdf30',...
            'Albvisdf40','Albvisdf50','Albvisdf60','Albvisdf70',...
            'Albvisdf80','Albvisdf90','Albvisdf100'});
  AlbvisdfTT = table2timetable(AlbvisdfTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='AlbvisdfTable AlbvisdfTT';
  MatFileName=strcat('AlbvisdfTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  albedovisdstr=strcat('Created AlbvisdfTableTT-','Contains Surface Visible Albedo Difuse Data -',num2str(3));
  fprintf(fid,'%s\n',albedovisdstr);

 % Create the Albedo Table ikind=5
  AlbvisdrTable=table(Albvisdr10(:,1),Albvisdr20(:,1),Albvisdr30(:,1),...
            Albvisdr40(:,1),Albvisdr50(:,1),Albvisdr60(:,1),...
            Albvisdr70(:,1),Albvisdr80(:,1),Albvisdr90(:,1),Albvisdr100(:,1),...
            'VariableNames',{'Albvisdr10','Albvisdr20','Albvisdr30',...
            'Albvisdr40','Albvisdr50','Albvisdr60','Albvisdr70',...
            'Albvisdr80','Albvisdr90','Albvisdr100'});
  AlbvisdrTT = table2timetable(AlbvisdrTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='AlbvisdrTable AlbvisdrTT';
  MatFileName=strcat('AlbvisdrTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  albedovisdstr=strcat('Created AlbvisdrTableTT-','Contains Surface Visible Albedo Beam Data -',num2str(3));
  fprintf(fid,'%s\n',albedovisdstr);

% Create the High Altitude Cloud Fraction Table ikind=6
  CLDHGHTable=table(CLDHGH10(:,1),CLDHGH20(:,1),CLDHGH30(:,1),...
            CLDHGH40(:,1),CLDHGH50(:,1),CLDHGH60(:,1),...
            CLDHGH70(:,1),CLDHGH80(:,1),CLDHGH90(:,1),CLDHGH100(:,1),...
            'VariableNames',{'CLDHGH10','CLDHGH20','CLDHGH30',...
            'CLDHGH40','CLDHGH50','CLDHGH60','CLDHGH70',...
            'CLDHGH80','CLDHGH90','CLDHGH100'});
  CLDHGHTT = table2timetable(CLDHGHTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='CLDHGHTable CLDHGHTT';
  MatFileName=strcat('CLDHGHTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  cloudhighstr=strcat('Created CLDHGHTTTT-','Contains High Cloud Area Fraction-',num2str(6));
  fprintf(fid,'%s\n',cloudhighstr);

 % Create the Low Altitude Cloud Fraction Table ikind=7
  CLDLOWTable=table(CLDLOW10(:,1),CLDLOW20(:,1),CLDLOW30(:,1),...
            CLDLOW40(:,1),CLDLOW50(:,1),CLDLOW60(:,1),...
            CLDLOW70(:,1),CLDLOW80(:,1),CLDLOW90(:,1),CLDLOW100(:,1),...
            'VariableNames',{'CLDLOW10','CLDLOW20','CLDLOW30',...
            'CLDLOW40','CLDLOW50','CLDLOW60','CLDLOW70',...
            'CLDLOW80','CLDLOW90','CLDLOW100'});
  CLDLOWTT = table2timetable(CLDLOWTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='CLDLOWTable CLDLOWTT';
  MatFileName=strcat('CLDLOWTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  cloudlowstr=strcat('Created CLDLOWTT-','Contains Low Cloud Area Fraction-',num2str(6));
  fprintf(fid,'%s\n',cloudlowstr);

 % Create the Mid Altitude Cloud Fraction Table ikind=8
  CLDMIDTable=table(CLDMID10(:,1),CLDMID20(:,1),CLDMID30(:,1),...
            CLDMID40(:,1),CLDMID50(:,1),CLDMID60(:,1),...
            CLDMID70(:,1),CLDMID80(:,1),CLDMID90(:,1),CLDMID100(:,1),...
            'VariableNames',{'CLDMID10','CLDMID20','CLDMID30',...
            'CLDMID40','CLDMID50','CLDMID60','CLDMID70',...
            'CLDMID80','CLDMID90','CLDMID100'});
  CLDMIDTT = table2timetable(CLDMIDTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='CLDMIDTable CLDMIDTT';
  MatFileName=strcat('CLDMIDTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  cloudmidstr=strcat('Created CLDMIDTT-','Contains Mid Cloud Area Fraction-',num2str(6));
  fprintf(fid,'%s\n',cloudmidstr);

 % Create the High Total Cloud Fraction Table ikind=9
  CLDTOTTable=table(CLDTOT10(:,1),CLDTOT20(:,1),CLDTOT30(:,1),...
            CLDTOT40(:,1),CLDTOT50(:,1),CLDTOT60(:,1),...
            CLDTOT70(:,1),CLDTOT80(:,1),CLDTOT90(:,1),CLDTOT100(:,1),...
            'VariableNames',{'CLDTOT10','CLDTOT20','CLDTOT30',...
            'CLDTOT40','CLDTOT50','CLDTOT60','CLDTOT70',...
            'CLSTOT80','CLDTOT90','CLDTOT100'});
  CLDTOTTT = table2timetable(CLDTOTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='CLDTOTTable CLDTOTTT';
  MatFileName=strcat('CLDTOTTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  cloudtotstr=strcat('Created CLDTOTTTTT-','Contains Total Cloud Area Fraction-',num2str(9));
  fprintf(fid,'%s\n',cloudtotstr);
  % Create the Surface Emissivity Table ikind=11
  SurfaceEmissTable=table(SEmis10(:,1),SEmis20(:,1),SEmis30(:,1),...
            SEmis40(:,1),SEmis50(:,1),SEmis60(:,1),...
            SEmis70(:,1),SEmis80(:,1),SEmis90(:,1),SEmis100(:,1),...
            'VariableNames',{'SEmis10','SEmis20','SEmis30',...
            'SEmis40','SEmis50','SEmis60','SEmis70',...
            'SEmis80','SEmis90','SEmis100'});
  SurfaceEmissTT = table2timetable(SurfaceEmissTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SurfaceEmissTable SurfaceEmissTT';
  MatFileName=strcat('SurfaceEmissivityTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)

% Create the Long Wave Surface Absorption Table ikind=13
  LWGABTable=table(LWGAB10(:,1),LWGAB20(:,1),LWGAB30(:,1),...
            LWGAB40(:,1),LWGAB50(:,1),LWGAB60(:,1),...
            LWGAB70(:,1),LWGAB80(:,1),LWGAB90(:,1),LWGAB100(:,1),...
            'VariableNames',{'LWGAB10','LWGAB20','LWGAB30',...
            'LWGAB40','LWGAB50','LWGAB60','LWGAB70',...
            'LWGAB80','LWGAB90','LWGAB100'});
  LWGABTT = table2timetable(LWGABTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWGABTable LWGABTT';
  MatFileName=strcat('LWGABTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwgabstr=strcat('Created LWGABTT-','Contains Long Wave Surface Absorption-',num2str(13));
  fprintf(fid,'%s\n',lwgabstr);

 % Create the Long Wave Surface Absorption Clear Sky Table ikind=14
  LWGABCLRTable=table(LWGABCLR10(:,1),LWGABCLR20(:,1),LWGABCLR30(:,1),...
            LWGABCLR40(:,1),LWGABCLR50(:,1),LWGABCLR60(:,1),...
            LWGABCLR70(:,1),LWGABCLR80(:,1),LWGABCLR90(:,1),LWGABCLR100(:,1),...
            'VariableNames',{'LWGABCLR10','LWGABCLR20','LWGABCLR30',...
            'LWGABCLR40','LWGABCLR50','LWGABCLR60','LWGABCLR70',...
            'LWGABCLR80','LWGABCLR90','LWGABCLR100'});
  LWGABCLRTT = table2timetable(LWGABCLRTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWGABCLRTable LWGABCLRTT';
  MatFileName=strcat('LWGABCLRTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwgab1str=strcat('Created LWGABCLRTT-','Contains Long Wave Surface Absorption Clear Sky-',num2str(14));
  fprintf(fid,'%s\n',lwgab1str);

  % Create the Long Wave Surface Absorption Clear Sky Table No Aerosol ikind=15
  LWGABCLRCLNTable=table(LWGABCLRCLN10(:,1),LWGABCLRCLN20(:,1),LWGABCLRCLN30(:,1),...
            LWGABCLRCLN40(:,1),LWGABCLRCLN50(:,1),LWGABCLRCLN60(:,1),...
            LWGABCLRCLN70(:,1),LWGABCLRCLN80(:,1),LWGABCLRCLN90(:,1),LWGABCLRCLN100(:,1),...
            'VariableNames',{'LWGABCLRCLN10','LWGABCLRCLN20','LWGABCLRCLN30',...
            'LWGABCLRCLN40','LWGABCLRCLN50','LWGABCLRCLN60','LWGABCLRCLN70',...
            'LWGABCLRCLN80','LWGABCLRCLN90','LWGABCLRCLN100'});
  LWGABCLRCLNTT = table2timetable(LWGABCLRCLNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWGABCLRCLNTable LWGABCLRCLNTT';
  MatFileName=strcat('LWGABCLRCLNTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwgab2str=strcat('Created LWGABCLRCLNTT-','Contains Long Wave Surface Absorption Clear Sky No Aerosol-',num2str(15));
  fprintf(fid,'%s\n',lwgab2str);

  % Create the Long Wave Surface Emission Table ikind=16
  LWGEMTable=table(LWGEM10(:,1),LWGEM20(:,1),LWGEM30(:,1),...
            LWGEM40(:,1),LWGEM50(:,1),LWGEM60(:,1),...
            LWGEM70(:,1),LWGEM80(:,1),LWGEM90(:,1),LWGEM100(:,1),...
            'VariableNames',{'LWGEM10','LWGEM20','LWGEM30',...
            'LWGEM40','LWGEM50','LWGEM60','LWGEM70',...
            'LWGEM80','LWGEM90','LWGEM100'});
  LWGEMTT = table2timetable(LWGEMTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWGEMTable LWGEMTT';
  MatFileName=strcat('LWGEMTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwgemstr=strcat('Created LWGEMTT-','Contains Long Wave Surface Emission-',num2str(16));
  fprintf(fid,'%s\n',lwgemstr);

% Create the Long Wave Surface Net Downward Flux ikind=17
  LWGNTTable=table(LWGNT10(:,1),LWGNT20(:,1),LWGNT30(:,1),...
            LWGNT40(:,1),LWGNT50(:,1),LWGNT60(:,1),...
            LWGNT70(:,1),LWGNT80(:,1),LWGNT90(:,1),LWGNT100(:,1),...
            'VariableNames',{'LWGNT10','LWGNT20','LWGNT30',...
            'LWGNT40','LWGNT50','LWGNT60','LWGNT70',...
            'LWGNT80','LWGNT90','LWGNT100'});
  LWGNTTT = table2timetable(LWGNTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWGNTTable LWGNTTT';
  MatFileName=strcat('LWGNTTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwgem2str=strcat('Created LWGNTTT-','Contains Long Wave Surface Net Downwards Flux-',num2str(17));
  fprintf(fid,'%s\n',lwgem2str);

 % Create the Long Wave Surface Net Downward Clear Sky Flux ikind=18
  LWGNTCLRTable=table(LWGNTCLR10(:,1),LWGNTCLR20(:,1),LWGNTCLR30(:,1),...
            LWGNTCLR40(:,1),LWGNTCLR50(:,1),LWGNTCLR60(:,1),...
            LWGNTCLR70(:,1),LWGNTCLR80(:,1),LWGNTCLR90(:,1),LWGNTCLR100(:,1),...
            'VariableNames',{'LWGNTCLR10','LWGNTCLR20','LWGNTCLR30',...
            'LWGNTCLR40','LWGNTCLR50','LWGNTCLR60','LWGNTCLR70',...
            'LWGNTCLR80','LWGNTCLR90','LWGNTCLR100'});
  LWGNTCLRTT = table2timetable(LWGNTCLRTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWGNTCLRTable LWGNTCLRTT';
  MatFileName=strcat('LWGNTCLRTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwgem3str=strcat('Created LWGNTCLRTT-','Contains Long Wave Surface Net Downwards Clear Sky Flux-',num2str(18));
  fprintf(fid,'%s\n',lwgem3str);

 % Create the Long Wave Surface Net Downward Clear Sky/No Aero Flux
 % ikind=19
  LWGNTCLRCLNTable=table(LWGNTCLRCLN10(:,1),LWGNTCLRCLN20(:,1),LWGNTCLRCLN30(:,1),...
            LWGNTCLRCLN40(:,1),LWGNTCLRCLN50(:,1),LWGNTCLRCLN60(:,1),...
            LWGNTCLRCLN70(:,1),LWGNTCLRCLN80(:,1),LWGNTCLRCLN90(:,1),LWGNTCLRCLN100(:,1),...
            'VariableNames',{'LWGNTCLRCLN10','LWGNTCLRCLN20','LWGNTCLRCLN30',...
            'LWGNTCLRCLN40','LWGNTCLRCLN50','LWGNTCLRCLN60','LWGNTCLRCLN70',...
            'LWGNTCLRCLN80','LWGNTCLRCLN90','LWGNTCLRCLN100'});
  LWGNTCLRCLNTT = table2timetable(LWGNTCLRCLNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWGNTCLRCLNTable LWGNTCLRCLNTT';
  MatFileName=strcat('LWGNTCLRCLNTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwgem4str=strcat('Created LWGNTCLRCLNTT-','Contains Long Wave Surface Net Downwards Clear Sky/No Aero Flux-',num2str(19));
  fprintf(fid,'%s\n',lwgem4str);

 % Create the Long Wave upwelling radiation at the TOA (LWTUP) ikind=20
  LWTUPTable=table(LWTUP10(:,1),LWTUP20(:,1),LWTUP30(:,1),...
            LWTUP40(:,1),LWTUP50(:,1),LWTUP60(:,1),...
            LWTUP70(:,1),LWTUP80(:,1),LWTUP90(:,1),LWTUP100(:,1),...
            'VariableNames',{'LWTUP10','LWTUP20','LWTUP30',...
            'LWTUP40','LWTUP50','LWTUP60','LWTUP70',...
            'LWTUP80','LWTUP90','LWTUP100'});
  LWTUPTT = table2timetable(LWTUPTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWTUPTable LWTUPTT';
  MatFileName=strcat('LWTUPTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwtupstr=strcat('Created LWTUPTT-','Contains Long Wave Upwelling radiation-',num2str(20));
  fprintf(fid,'%s\n',lwtupstr);

 % Create the Long Wave clear sky upwelling radiation at the TOA (LWTUPCLR) ikind=21
  LWTUPCLRTable=table(LWTUPCLR10(:,1),LWTUPCLR20(:,1),LWTUPCLR30(:,1),...
            LWTUPCLR40(:,1),LWTUPCLR50(:,1),LWTUPCLR60(:,1),...
            LWTUPCLR70(:,1),LWTUPCLR80(:,1),LWTUPCLR90(:,1),LWTUPCLR100(:,1),...
            'VariableNames',{'LWTUPCLR10','LWTUPCLR20','LWTUPCLR30',...
            'LWTUPCLR40','LWTUPCLR50','LWTUPCLR60','LWTUPCLR70',...
            'LWTUPCLR80','LWTUPCLR90','LWTUPCLR100'});
  LWTUPCLRTT = table2timetable(LWTUPCLRTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWTUPCLRTable LWTUPCLRTT';
  MatFileName=strcat('LWTUPCLRTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwtup1str=strcat('Created LWTUPCLRTT-','Contains Long Wave clear sky Upwelling radiation-',num2str(21));
  fprintf(fid,'%s\n',lwtup1str);

 % Create the Long Wave clear sky no/aero upwelling radiation at the TOA (LWTUPCLRCLN)
 % ikind=22
  LWTUPCLRCLNTable=table(LWTUPCLRCLN10(:,1),LWTUPCLRCLN20(:,1),LWTUPCLRCLN30(:,1),...% Fix this
            LWTUPCLRCLN40(:,1),LWTUPCLRCLN50(:,1),LWTUPCLRCLN60(:,1),...
            LWTUPCLRCLN70(:,1),LWTUPCLRCLN80(:,1),LWTUPCLRCLN90(:,1),LWTUPCLRCLN100(:,1),...
            'VariableNames',{'LWTUPCLRCLN10','LWTUPCLRCLN20','LWTUPCLRCLN30',...
            'LWTUPCLRCLN40','LWTUPCLRCLN50','LWTUPCLRCLN60','LWTUPCLRCLN70',...
            'LWTUPCLRCLN80','LWTUPCLRCLN90','LWTUPCLRCLN100'});
  LWTUPCLRCLNTT = table2timetable(LWTUPCLRCLNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='LWTUPCLRCLNTable LWTUPCLRCLNTT';
  MatFileName=strcat('LWTUPCLRCLNTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwtup2str=strcat('Created LWTUPCLRCLNTT-','Contains Long Wave clear sky no/aero Upwelling radiation-',num2str(22));
  fprintf(fid,'%s\n',lwtup2str);

 % Create the Surface Incoming ShortWave Flux ikind=23
   SWGDNTable=table(SWGDN10(:,1),SWGDN20(:,1),SWGDN30(:,1),...
            SWGDN40(:,1),SWGDN50(:,1),SWGDN60(:,1),...
            SWGDN70(:,1),SWGDN80(:,1),SWGDN90(:,1),SWGDN100(:,1),...
            'VariableNames',{'SWGDN10','SWGDN20','SWGDN30',...
            'SWGDN40','SWGDN50','SWGDN60','SWGDN70',...
            'SWGDN80','SWGDN90','SWGDN100'});
  SWGDNTT = table2timetable(SWGDNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWGDNTable SWGDNTT';
  MatFileName=strcat('SWGDNTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  lwtupstr=strcat('Created SWGDNTT-','Contains Surface Incoming ShortWave Flux-',num2str(23));
  fprintf(fid,'%s\n',lwtupstr);

 % Create the Surface Incoming Clear Sky ShortWave Flux ikind=24
   SWGDNCLRTable=table(SWGDNCLR10(:,1),SWGDNCLR20(:,1),SWGDNCLR30(:,1),...
            SWGDNCLR40(:,1),SWGDNCLR50(:,1),SWGDNCLR60(:,1),...
            SWGDNCLR70(:,1),SWGDNCLR80(:,1),SWGDNCLR90(:,1),SWGDNCLR100(:,1),...
            'VariableNames',{'SWGDNCLR10','SWGDNCLR20','SWGDNCLR30',...
            'SWGDNCLR40','SWGDNCLR50','SWGDNCLR60','SWGDNCLR70',...
            'SWGDNCLR80','SWGDNCLR90','SWGDNCLR100'});
  SWGDNCLRTT = table2timetable(SWGDNCLRTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWGDNCLRTable SWGDNCLRTT';
  MatFileName=strcat('SWGDNCLRTable',YearMonthStrStart,'-',YearMonthStrEnd,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swdgn1str=strcat('Created SWDGNCLRTT-','Contains Surface Clear Sky Incoming ShortWave Flux-',num2str(24));
  fprintf(fid,'%s\n',swdgn1str);

% Create the Surface Net Downwards Flux ikind=25
   SWGNTTable=table(SWGNT10(:,1),SWGNT20(:,1),SWGNT30(:,1),...
            SWGNT40(:,1),SWGNT50(:,1),SWGNT60(:,1),...
            SWGNT70(:,1),SWGNT80(:,1),SWGNT90(:,1),SWGNT100(:,1),...
            'VariableNames',{'SWGNT10','SWGNT20','SWGNT30',...
            'SWGNT40','SWGNT50','SWGNT60','SWGNT70',...
            'SWGNT80','SWGNT90','SWGNT100'});
  SWGNTTT = table2timetable(SWGNTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWGNTTable SWGNTTT';
  MatFileName=strcat('SWGNTTable',YearMonthStrStart,'-',YearMonthStrEnd,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swdgn1str=strcat('Created SWGNTTT-','Contains Surface Net Downwards Flux-',num2str(25));
  fprintf(fid,'%s\n',swdgn1str);

% Create the Surface Net Downwards Flux ikind=26
   SWGNTCLNTable=table(SWGNTCLN10(:,1),SWGNTCLN20(:,1),SWGNTCLN30(:,1),...
            SWGNTCLN40(:,1),SWGNTCLN50(:,1),SWGNTCLN60(:,1),...
            SWGNTCLN70(:,1),SWGNTCLN80(:,1),SWGNTCLN90(:,1),SWGNTCLN100(:,1),...
            'VariableNames',{'SWGNTCLN10','SWGNTCLN20','SWGNTCLN30',...
            'SWGNTCLN40','SWGNTCLN50','SWGNTCLN60','SWGNTCLN70',...
            'SWGNTCLN80','SWGNTCLN90','SWGNTCLN100'});
  SWGNTCLNTT = table2timetable(SWGNTCLNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWGNTCLNTable  SWGNTCLNTT';
  MatFileName=strcat('SWGNTCLNTable',YearMonthStrStart,'-',YearMonthStrEnd,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swdgn2str=strcat('Created SWGNTCLNTT-','Contains Surface Net Downwards Flux No Aerosol-',num2str(26));
  fprintf(fid,'%s\n',swdgn2str);

 % Create the Surface Net Downwards Flux ikind=27
   SWGNTCLRTable=table(SWGNTCLR10(:,1),SWGNTCLR20(:,1),SWGNTCLR30(:,1),...
            SWGNTCLR40(:,1),SWGNTCLR50(:,1),SWGNTCLR60(:,1),...
            SWGNTCLR70(:,1),SWGNTCLR80(:,1),SWGNTCLR90(:,1),SWGNTCLR100(:,1),...
            'VariableNames',{'SWGNTCLR10','SWGNTCLR20','SWGNTCLR30',...
            'SWGNTCLR40','SWGNTCLR50','SWGNTCLR60','SWGNTCLR70',...
            'SWGNTCLR80','SWGNTCLR90','SWGNTCLR100'});
  SWGNTCLRTT = table2timetable(SWGNTCLRTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWGNTCLRTable SWGNTCLRTT';
  MatFileName=strcat('SWGNTCLRTable',YearMonthStrStart,'-',YearMonthStrEnd,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swdgn3str=strcat('Created SWGNTCLRTT-','Contains Surface Net Downwards Flux Clear Sky-',num2str(27));
  fprintf(fid,'%s\n',swdgn3str);
 
 % Create the Surface Net Downwards Flux ikind=28
   SWGNTCLRCLNTable=table(SWGNTCLRCLN10(:,1),SWGNTCLRCLN20(:,1),SWGNTCLRCLN30(:,1),...
            SWGNTCLRCLN40(:,1),SWGNTCLRCLN50(:,1),SWGNTCLRCLN60(:,1),...
            SWGNTCLRCLN70(:,1),SWGNTCLRCLN80(:,1),SWGNTCLRCLN90(:,1),SWGNTCLRCLN100(:,1),...
            'VariableNames',{'SWGNTCLRCLN10','SWGNTCLRCLN20','SWGNTCLRCLN30',...
            'SWGNTCLRCLN40','SWGNTCLRCLN50','SWGNTCLRCLN60','SWGNTCLRCLN70',...
            'SWGNTCLRCLN80','SWGNTCLRCLN90','SWGNTCLRCLN100'});
  SWGNTCLRCLNTT = table2timetable(SWGNTCLRCLNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWGNTCLRCLNTable SWGNTCLRCLNTT';
  MatFileName=strcat('SWGNTCLRCLNTable',YearMonthStrStart,'-',YearMonthStrEnd,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swdgn4str=strcat('Created SWGNTCLRCLNTT-','Contains Surface Net Downwards Flux Clear Sky No Aero-',num2str(27));
  fprintf(fid,'%s\n',swdgn4str);
  

% Create the Toa Incoming ShortWave Flux ikind=29
   SWTDNTable=table(SWTDN10(:,1),SWTDN20(:,1),SWTDN30(:,1),...
            SWTDN40(:,1),SWTDN50(:,1),SWTDN60(:,1),...
            SWTDN70(:,1),SWTDN80(:,1),SWTDN90(:,1),SWTDN100(:,1),...
            'VariableNames',{'SWTDN10','SWTDN20','SWTDN30',...
            'SWTDN40','SWTDN50','SWTDN60','SWTDN70',...
            'SWTDN80','SWTDN90','SWTDN100'});
  SWTDNTT = table2timetable(SWTDNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWTDNTable SWTDNTT';
  MatFileName=strcat('SWTDNTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swtdnstr=strcat('Created SWTDNTT-','Contains Toa Incoming ShortWave Flux-',num2str(29));
  fprintf(fid,'%s\n',swtdnstr);

 % Create the Toa Net ShortWave Flux ikind=30
   SWTNTTable=table(SWTNT10(:,1),SWTNT20(:,1),SWTNT30(:,1),...
            SWTNT40(:,1),SWTNT50(:,1),SWTNT60(:,1),...
            SWTNT70(:,1),SWTNT80(:,1),SWTNT90(:,1),SWTNT100(:,1),...
            'VariableNames',{'SWTNT10','SWTNT20','SWTNT30',...
            'SWTNT40','SWTNT50','SWTNT60','SWTNT70',...
            'SWTNT80','SWTNT90','SWTNT100'});
  SWTNTTT = table2timetable(SWTNTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWTNTTable SWTNTTT';
  MatFileName=strcat('SWTNTTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swtntstr=strcat('Created SWTNTTT-','Contains Toa Net ShortWave Flux-',num2str(29));
  fprintf(fid,'%s\n',swtntstr);

 % Create the Toa Net ShortWave Flux No Aero ikind=31
   SWTNTCLNTable=table(SWTNTCLN10(:,1),SWTNTCLN20(:,1),SWTNTCLN30(:,1),...
            SWTNTCLN40(:,1),SWTNTCLN50(:,1),SWTNTCLN60(:,1),...
            SWTNTCLN70(:,1),SWTNTCLN80(:,1),SWTNTCLN90(:,1),SWTNTCLN100(:,1),...
            'VariableNames',{'SWTNTCLN10','SWTNTCLN20','SWTNTCLN30',...
            'SWTNTCLN40','SWTNTCLN50','SWTNTCLN60','SWTNTCLN70',...
            'SWTNTCLN80','SWTNTCLN90','SWTNTCLN100'});
  SWTNTCLNTT = table2timetable(SWTNTCLNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWTNTCLNTable SWTNTCLNTT';
  MatFileName=strcat('SWTNTCLNTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swtntstr1=strcat('Created SWTNTCLNTT-','Contains Toa Net No Aero ShortWave Flux-',num2str(31));
  fprintf(fid,'%s\n',swtntstr1);

 % Create the Toa Net ShortWave Flux Clear Sky ikind=32
   SWTNTCLRTable=table(SWTNTCLR10(:,1),SWTNTCLR20(:,1),SWTNTCLR30(:,1),...
            SWTNTCLR40(:,1),SWTNTCLR50(:,1),SWTNTCLR60(:,1),...
            SWTNTCLR70(:,1),SWTNTCLR80(:,1),SWTNTCLR90(:,1),SWTNTCLR100(:,1),...
            'VariableNames',{'SWTNTCLR10','SWTNTCLR20','SWTNTCLR30',...
            'SWTNTCLR40','SWTNTCLR50','SWTNTCLR60','SWTNTCLR70',...
            'SWTNTCLR80','SWTNTCLR90','SWTNTCLR100'});
  SWTNTCLRTT = table2timetable(SWTNTCLRTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWTNTCLRTable SWTNTCLRTT';
  MatFileName=strcat('SWTNTCLRTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swtntstr2=strcat('Created SWTNTCLRTT-','Contains Toa Net Clear Sky ShortWave Flux-',num2str(32));
  fprintf(fid,'%s\n',swtntstr2);

 % Create the Toa Net ShortWave Flux Clear Sky/No Aero ikind=33
   SWTNTCLRCLNTable=table(SWTNTCLRCLN10(:,1),SWTNTCLRCLN20(:,1),SWTNTCLRCLN30(:,1),...
            SWTNTCLRCLN40(:,1),SWTNTCLRCLN50(:,1),SWTNTCLRCLN60(:,1),...
            SWTNTCLRCLN70(:,1),SWTNTCLRCLN80(:,1),SWTNTCLRCLN90(:,1),SWTNTCLRCLN100(:,1),...
            'VariableNames',{'SWTNTCLRCLN10','SWTNTCLRCLN20','SWTNTCLRCLN30',...
            'SWTNTCLRCLN40','SWTNTCLRCLN50','SWTNTCLRCLN60','SWTNTCLRCLN70',...
            'SWTNTCLRCLN80','SWTNTCLRCLN90','SWTNTCLRCLN100'});
  SWTNTCLRCLNTT = table2timetable(SWTNTCLRCLNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SWTNTCLRCLNTable SWTNTCLRCLNTT';
  MatFileName=strcat('SWTNTCLRCLNTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  swtntstr3=strcat('Created SWTNTCLRCLNTT-','Contains Toa Net Clear Sky/No Aero ShortWave Flux-',num2str(32));
  fprintf(fid,'%s\n',swtntstr3);

% Create the High Cloud Optical Thickness ikind=34
   TAUHGHTable=table(TAUHGH10(:,1),TAUHGH20(:,1),TAUHGH30(:,1),...
            TAUHGH40(:,1),TAUHGH50(:,1),TAUHGH60(:,1),...
            TAUHGH70(:,1),TAUHGH80(:,1),TAUHGH90(:,1),TAUHGH100(:,1),...
            'VariableNames',{'TAUHGH10','TAUHGH20','TAUHGH30',...
            'TAUHGH40','TAUHGH50','TAUHGH60','TAUHGH70',...
            'TAUHGH80','TAUHGH90','TAUHGH100'});
  TAUHGHTT = table2timetable(TAUHGHTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TAUHGHTable TAUHGHTT';
  MatFileName=strcat('TAUHGHTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tauhghstr=strcat('Created TAUHGHTT-','Contains High Cloud Optical Thickness-',num2str(34));
  fprintf(fid,'%s\n',tauhghstr);

 % Create the Low Cloud Optical Thickness ikind=35
   TAULOWTable=table(TAULOW10(:,1),TAULOW20(:,1),TAULOW30(:,1),...
            TAULOW40(:,1),TAULOW50(:,1),TAULOW60(:,1),...
            TAULOW70(:,1),TAULOW80(:,1),TAULOW90(:,1),TAULOW100(:,1),...
            'VariableNames',{'TAULOW10','TAULOW20','TAULOW30',...
            'TAULOW40','TAULOW50','TAULOW60','TAULOW70',...
            'TAULOW80','TAULOW90','TAULOW100'});
  TAULOWTT = table2timetable(TAULOWTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TAULOWTable TAULOWTT';
  MatFileName=strcat('TAULOWTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tauhghstr1=strcat('Created TAULOWTT-','Contains LOW Cloud Optical Thickness-',num2str(35));
  fprintf(fid,'%s\n',tauhghstr1);

 % Create the Mid Cloud Optical Thickness ikind=36
   TAUMIDTable=table(TAUMID10(:,1),TAUMID20(:,1),TAUMID30(:,1),...
            TAUMID40(:,1),TAUMID50(:,1),TAUMID60(:,1),...
            TAUMID70(:,1),TAUMID80(:,1),TAUMID90(:,1),TAUMID100(:,1),...
            'VariableNames',{'TAUMID10','TAUMID20','TAUMID30',...
            'TAUMID40','TAUMID50','TAUMID60','TAUMID70',...
            'TAUMID80','TAUMID90','TAUMID100'});
  TAUMIDTT = table2timetable(TAUMIDTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TAUMIDTable TAUMIDTT';
  MatFileName=strcat('TAUMIDTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tauhghstr2=strcat('Created TAUMIDTT-','Contains Mid Cloud Optical Thickness-',num2str(36));
  fprintf(fid,'%s\n',tauhghstr2);

% Create the Tot Cloud Optical Thickness ikind=37
   TAUTOTTable=table(TAUTOT10(:,1),TAUTOT20(:,1),TAUTOT30(:,1),...
            TAUTOT40(:,1),TAUTOT50(:,1),TAUTOT60(:,1),...
            TAUTOT70(:,1),TAUTOT80(:,1),TAUTOT90(:,1),TAUTOT100(:,1),...
            'VariableNames',{'TAUTOT10','TAUTOT20','TAUTOT30',...
            'TAUTOT40','TAUTOT50','TAUTOT60','TAUTOT70',...
            'TAUTOT80','TAUTOT90','TAUTOT100'});
  TAUTOTTT = table2timetable(TAUTOTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TAUTOTTable TAUTOTTT';
  MatFileName=strcat('TAUTOTTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tauhghstr3=strcat('Created TAUTOTTT-','Contains Tot Cloud Optical Thickness-',num2str(37));
  fprintf(fid,'%s\n',tauhghstr3);

% Create the TS or Skin Temperature ikind=39
   TSTable=table(TS10(:,1),TS20(:,1),TS30(:,1),...
            TS40(:,1),TS50(:,1),TS60(:,1),...
            TS70(:,1),TS80(:,1),TS90(:,1),TS100(:,1),...
            'VariableNames',{'TS10','TS20','TS30',...
            'TS40','TS50','TS60','TS70',...
            'TS80','TS90','TS100'});
  TSTT = table2timetable(TSTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='TSTable TSTT';
  MatFileName=strcat('TSTable',YearMonthStr,'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  tsstr=strcat('Created TSTT-','Contains Skin Temp-',num2str(39));
  fprintf(fid,'%s\n',tsstr);

  fprintf(fid,'%s\n','----End Creating Tables----');
end


end

