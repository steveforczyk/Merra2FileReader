function ReadCOTData()
% Modified: This function will read in the the Merra-2 data set for Cloud
% Optical Thickness
% Written By: Stephen Forczyk
% Created: Oct 23,2022
% Revised: Oct 25,2022 added code to comoute area of each pixel
% Classification: Unclassified

global BandDataS MetaDataS;
global LatSpacing LonSpacing RasterAreas;
global RasterLats RasterLons;
global Merra2FileName Merra2ShortFileName Merra2Dat;

global idebug;
global LonS LatS;
global Lat_BNDS Lon_BNDS;
global YearMonthStr YearStr MonthStr;
global TAUHGHS;

% additional paths needed for mapping
global matpath1 mappath GOES16path;
global jpegpath savepath;

global fid isavefiles;


fprintf(fid,'\n');
fprintf(fid,'%s\n','**************Start reading dataset 08 COT data***************');

[nc_filenamesuf,path]=uigetfile('*nc','Select One Data File');% SMF Modification
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
YearStr=Merra2ShortFileName(1:4);
MonthStr=Merra2ShortFileName(5:6);
YearMonthStr=strcat(YearStr,MonthStr);
Lat_BNDS=struct('values',[],'units',[]);
Lon_BNDS=struct('values',[],'units',[]);
LonS=struct('values',[],'standard_name',[],'units',[],'vmax',[],'vmin',[],'origname',[]);
LatS=LonS;
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
       a10=strcmp(varname,'lat');
       a20=strcmp(varname,'lat_bnds');
       a30=strcmp(varname,'lon');
       a40=strcmp(varname,'lon_bnds');
       a50=strcmp(varname,'M2TMNXRAD_5_12_4_TAUHGH');

       if (a10==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                 LatS.standard_name=attname2;
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
            a1=strcmp(attname1,'origname');
            if(a1==1)
                 LatS.origname=attname2;
            end
        elseif (a20==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Lat_BNDS.units=attname2;
            end
        elseif (a30==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                 LonS.standard_name=attname2;
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
            a1=strcmp(attname1,'origname');
            if(a1==1)
                 LonS.origname=attname2;
            end
        elseif (a40==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 Lon_BNDS.units=attname2;
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
                 TAUHGHS.long_name=attname2;
            end
            a1=strcmp(attname1,'product_short_name');
            if(a1==1)
                 TAUHGHS.product_short_name=attname2;
            end
            a1=strcmp(attname1,'product_version');
            if(a1==1)
                 TAUHGHS.product_version=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                 TAUHGHS.standard_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 TAUHGHS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 TAUHGHS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 TAUHGHS.vmin=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 TAUHGHS.Fill_Value=attname2;
            end
            a1=strcmp(attname1,'origname');
            if(a1==1)
                 TAUHGHS.origname=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 TAUHGHS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 TAUHGHS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'quantity_type');
            if(a1==1)
                 TAUHGHS.quantity_type=attname2;
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 TAUHGHS.long_name=attname2;
            end
            a1=strcmp(attname1,'cell_methods');
            if(a1==1)
                 TAUHGHS.cell_methods=attname2;
            end
            a1=strcmp(attname1,'latitude_resolution');
            if(a1==1)
                 TAUHGHS.latitude_resolution=attname2;
            end
            a1=strcmp(attname1,'longitude_resolution');
            if(a1==1)
                 TAUHGHS.longitude_resolution=attname2;
            end
            a1=strcmp(attname1,'coordinates');
            if(a1==1)
                 TAUHGHS.coordinates=attname2;
            end

            
 
        end
    end
    if(idebug==1)
        disp(' ')
    end
    
    if flag


    else
        eval([varname '= double(netcdf.getVar(ncid,i));'])   
        if(a10==1)
            LatS.values=lat;
            RasterLats=LatS.values;
        end
        if(a20==1)
            Lat_BNDS.values=lat_bnds';
        end
        if(a30==1)
            LonS.values=lon;
            RasterLons=LonS.values;
        end
        if(a40==1)
            Lon_BNDS.values=lon_bnds';
        end
        if(a50==1)
            ab=1;
            TAUHGHS.values=M2TMNXRAD_5_12_4_TAUHGH;
            ab=2;
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
% Now calculate the area of each Raster point. This on varies by latitude
% Get the area of each cell based on the latitude
nlats=length(RasterLats);
nlons=length(RasterLons);
RadiusCalc=zeros(nlats,1);
LatSpacing=abs(RasterLats(2,1)-RasterLats(1,1));
LonSpacing=abs(RasterLons(2,1)-RasterLons(1,1));
lon1=10;
lon2=lon1+LonSpacing;
deg2rad=pi/180;
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
        areaused=1;
    else
        areaused=areakm;
    end
    RasterAreas(k,1)=areaused;
    RadiusCalc(k,1)=radius;
end
%Now write a Matlab file containing the decoded data
%use the original file name with a .mat extension
MatFileName=strcat('COT-Merra2ShortFileName','.mat');
if(isavefiles==1)
    eval(['cd ' savepath(1:length(savepath)-1)]);
    actionstr='save';
    varstr1='LonS LatS Merra2FileName Merra2ShortFileName';
    varstr2=' Lat_BNDS Lon_BNDS TAUHGHS YearMonthStr YearStr MonthStr';
    varstr=strcat(varstr1,varstr2);
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

Merra2ShortFileName=Merra2FileName(is:ie);
% Display the Cloud Optical Thickness
ikind=1;
titlestr=strcat('CloudOpticalThickness-400hPA-',Merra2ShortFileName);
DisplayMerra2TAUCloud(ikind,titlestr)
% Display the Cloud Optical Thickness as a density
titlestr=strcat('CloudOpticalDensity-400hPA-',Merra2ShortFileName);
DisplayMerra2TAUCloudDensity(ikind,titlestr)


end

