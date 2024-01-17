% This script will read a shapefile and try to create a boundary file from
% it
%
% Written By: Stephen Forczyk
% Created: August 2,2023
% Revised: August 17,2023
% Classification: Unclassified

global shapepath shapefilename shapefilename2 boundarypath;
global shapefilename3;
global MexicoLat MexicoLon AntarcticLat AntarcticLon;
global TajikistanLon TajikistanLat;
global STATEABREV;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;

%% Call some routines that will create nice plot window sizes and locations
% Establish selected run parameters
imachine=2;
if(imachine==1)
    widd=720;
    lend=580;
    widd2=1000;
    lend2=700;
elseif(imachine==2)
    widd=1080;
    lend=812;
    widd2=1000;
    lend2=700;
elseif(imachine==3)
    widd=1296;
    lend=974;
    widd2=1200;
    lend2=840;
end
% Set a specific color order
set(0,'DefaultAxesColorOrder',[1 0 0;
    1 1 0;0 1 0;0 0 1;0.75 0.50 0.25;
    0.5 0.75 0.25; 0.25 1 0.25;0 .50 .75]);
% Set up some defaults for a PowerPoint presentationwhos
scaling='true';
stretching='false';
padding=[75 75 75 75];
igrid=1;
% Set up paramters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=2;
idirector=1;
shapepath='D:\Forczyk\Map_Data\Extra\';
boundarypath='D:\Forczyk\Map_Data\Matlab_Maps_New\';
eval(['cd ' shapepath(1:length(shapepath)-1)]);
tic;
%shapefilename='Railroads_Shapefiles_NA_Railroads_data_rail_l_railroads_l_v2.shp';
shapefilename='Mexico_States.shp';
shapefilename='GSHHS_f_L6.shp';
shapefilename2='Wyoming_Rail_Lines.shp';
shapefilename2='Wyoming_Rail_Lines.shp';
shapefilename3='rn320gq6238.shp';
icase=3;
% STATEABREV='WY';
% stateselector= {@statefilter, 'STATEAB'};
%S1=shaperead(shapefilename,'UseGeoCoords',true);
% S2=shaperead(shapefilename,'Selector',stateselector);
%shapewrite(S2,shapefilename2);
% S2=shaperead(shapefilename,'UseGeoCoords',true);
% numrecords=length(S2);
% a2=shapeinfo(shapefilename);
% disp(a2);
% elapsed_time=toc;
% dispstr=strcat('Time to load shapefile-',shapefilename,'-',num2str(elapsed_time),'-sec');
% disp(dispstr)
% nvals=0;
% % Now found out how many points exist so we can preallocate the arrays
% for n=1:numrecords
%     Lats=S2(n).Lat;
%     Lats=Lats';
%     npts=length(Lats);
%     nvals=nvals+npts;
% end
% % MexicoLat=NaN(nvals,1);
% % MexicoLon=NaN(nvals,1);
% AntarcticLat=NaN(nvals,1);
% AntarcticLon=NaN(nvals,1);
% % Now found pull out the data for each record and add it to the file
% nvals2s=0;
% nvals2e=1;
% for n=1:numrecords
%     Lats=S2(n).Lat;
%     Lats=Lats';
%     Lons=S2(n).Lon;
%     Lons=Lons';
%     npts2=length(Lats);
%     nvals2s=nvals2e+1;
%     nvals2e=nvals2s+npts2-1;
%     ip=0;
%     for k=nvals2s:nvals2e
%         ip=ip+1;
% %         MexicoLat(k,1)=Lats(ip,1);
% %         MexicoLon(k,1)=Lons(ip,1);
%         AntarcticLat(k,1)=Lats(ip,1);
%         AntarcticLon(k,1)=Lons(ip,1);
%     end
% end
% eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
% actionstr='save';
% varstr='AntarcticLat AntarcticLon';
% MatFileName= 'AntarcticBoundaries.mat';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
if(icase==3)
    S3=shaperead(shapefilename3,'UseGeoCoords',true);
    Lons=(S3.Lon)';
    Lats=(S3.Lat)';
    numrecords=length(Lons);
    TajikistanLon=zeros(numrecords,1);
    TajikistanLat=zeros(numrecords,1);
    a2=shapeinfo(shapefilename3);
    disp(a2);
    for k=1:numrecords
        TajikistanLon(k,1)=Lons(k,1);
        TajikistanLat(k,1)=Lats(k,1);
    end
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    actionstr='save';
    varstr='TajikistanLat TajikistanLon';
    MatFileName= 'TajikistanBoundaries.mat';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Matlab File-',MatFileName);
    disp(dispstr)
    elapsed_time=toc;
    dispstr=strcat('Time to load shapefile-',shapefilename3,'-',num2str(elapsed_time),'-sec');
    disp(dispstr)
    ab=3;
end

ab=1;
