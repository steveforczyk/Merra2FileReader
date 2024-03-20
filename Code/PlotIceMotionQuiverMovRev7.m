function PlotIceMotionQuiverMovRev7(ikind,np,nowFile,titlestr)
% This routine will plot the ice movement velocity over a raster field
% The big difference from all the previous is the use of the quiver function
% using mapshow which works for unprojected coordinates
% 
% Another big change is that the quiver will be broken up into 4 portions
% based on the ice velocity not the movement direction
% The desire is to correctly create a quiver plot to display the ice motion
% in a fast enough time to make legible plots for movies
% Written By: Stephen Forczyk
% Created: Feb 22,2023
% Revised: Feb 25,2023 made 8 arrays of 120 x 120 size to to U and V
% velocity components
%

% Classification: Unclassified
global crsS icemotionerrorS timeS xS yS SeaIceConc NobS NobVals Nob Nob75km;
global latitudeS longitudeS uS vS SeaIceVel SeaIceVel1D;
global U0 V0 U0R V0R;
global U0R1 V0R1 VDir75Q1 VDIR75Q1F U0R1F V0R1F;
global U0R2 V0R2 VDir75Q2 VDIR75Q2F U0R2F V0R2F;
global U0R3 V0R3 VDir75Q3 VDIR75Q3F U0R3F V0R3F;
global U0R4 V0R4 VDir75Q4 VDIR75Q4F U0R4F V0R4F;
global U0Vel1 V0Vel1 U0Vel2 V0Vel2 U0Vel3 V0Vel3 U0Vel4 V0Vel4;
global X0 Y0;
global DistKmQ1F DistKmQ1 DistKmQ2F DistKmQ2;
global DistKmQ3F DistKmQ3 DistKmQ4F DistKmQ4;
global VelMagUsed1F VelMagUsed2F VelMagUsed3F VelMagUsed4F;
global SeaIceVel75km  SeaIceVelLat75km SeaIceVelLon75km ;
global VEast VNorth VDir VEast75km VNorth75km VDir75km VDir75km1D;
global VQuad1 VQuad2 VQuad3 VQuad4;
global RasterLatsR RasterLonsR;

global RasterLats RasterLons GridFileName GeoSpatialS;
global VelEast VelNorth VelMag VelDir;
global iNorthPole iSouthPole;
global S0 S1 S2;
global VelMagDistribution VelMag2to5 VelMag5to10 VelMag10to15 VelMagover15;

global idebug isavefiles;
global westEdge eastEdge northEdge southEdge;
global MonthDayYearStr ichannelSelect YearStr;
global orange bubblegum brown brightblue;
global MovieName vTemp;
global GreenLandShapeFile NorwayShapeFile IceLandShapeFile;
global LandColors;
global iDaily iWeekly;

global vert1 hor1 widd lend;
global vert2 hor2 lend2 machine;
global chart_timel;
global Fz1 Fz2 chart_time;

global idirector igrid fid;
global matpath moviepath mappath figpath velpath;
global jpegpath powerpath gridpath combinedpath excelpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global iCreatePDFReport RptGenPresent;
combinedpath='D:\Mathworks\Climate_Data_Toolbox\cdt\cdt_data\';
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
end
orange=[.9765 .4510 .0235];
bubblegum=[1 .4235 .7098];
brown=[.396 .263 .129];
brightblue=[.0039 .3961 .9882];
numgood1=0;
numgood2=0;
numgood3=0;
numgood4=0;
% Remove the underscores from the file name
nowFile2=RemoveUnderScores(nowFile);
% Get the basic data for this frame starting with the velocity magnitude
[nnnrows,nnncols,nslices]=size(VelMag);
if(np==1)
    VelMagDistribution=zeros(nslices,4);
    VelMag2to5=zeros(nslices,1);
    VelMag5to10=zeros(nslices,1);
    VelMag10to15=zeros(nslices,1);
    VelMagover15=zeros(nslices,1);
    VQuad1=zeros(nslices,1);
    VQuad2=zeros(nslices,1);
    VQuad3=zeros(nslices,1);
    VQuad4=zeros(nslices,1);
end
SeaIceVel(:,:)=VelMag(:,:,np);
[nrows,ncols]=size(SeaIceVel);
numvals=nrows*ncols;
U0=uS.values(:,:,np);
V0=vS.values(:,:,np);
try
    X0=xS.values(:,:,np);
catch
    X0=xS.values;
end
try
    Y0=yS.values(:,:,np);
catch
    Y0=yS.values;
end
X02D=zeros(nrows,ncols);
Y02D=zeros(nrows,ncols);
% for i=1:nrows
%     for j=1:ncols
%         X02D(i,j)=X0(i,1)
%     end
% end
[X02D,Y02D] = meshgrid(X0,Y0);
SeaIceVel1D=reshape(SeaIceVel,nrows*ncols,1);
VEast(:,:)=VelEast(:,:,np);
VNorth(:,:)=VelNorth(:,:,np);
VDir(:,:)=VelDir(:,:,np);
% Create a Referencing Object
xmin=min(min(X02D));
xmax=max(max(X02D));
ymin=min(min(Y02D));
ymax=max(max(Y02D));
xlimits=[xmin xmax];
ylimits=[ymin ymax];
rasterSize=[nrows ncols];
R = maprefcells(xlimits,ylimits,rasterSize);
% % Load IceLandData
% IceG=shaperead(IceLandShapeFile,'UseGeoCoords',true);
% LatIce=IceG.Lat;
% LonIce=IceG.Lon;
% %[Greenx,Greeny] = pol2cart(Lat,Lon);
% [IceLandx,IceLandy,IceLandz] = sph2cart(LonIce*pi/180,LatIce*pi/180,6371000);
% %[IceLandx,IceLandy,IceLandz] = sph2cart(Lat,Lon,6371000);
% IceLandx=IceLandx';
% %IceLandx=flipud(IceLandx);
% IceLandy=IceLandy';
% %IceLandy=-IceLandy;
% IceLandy1=flipud(IceLandy);
% IceLandy2=fliplr(IceLandy1);
% IceLandx1=flipud(IceLandx);
% IceLandx2=fliplr(IceLandx1);
% %IceLandy=flipud(IceLandy);
% wgs84 = wgs84Ellipsoid('kilometer');
% [ICX,ICY,ICZ] = geodetic2ecef(wgs84,LatIce,LonIce,0);
% llaIce(:,1)=LatIce;
% llaIce(:,2)=LonIce;
% numlatsIce=length(LatIce);
% ht=zeros(numlatsIce,1);
% llaIce(:,3)=ht;
% pCoord = lla2ecef(llaIce,'Wgs84');
% % Load NorwayData
% NorG=shaperead(NorwayShapeFile,'UseGeoCoords',true);
% LatNor=NorG.Lat;
% LonNor=NorG.Lon;
% [NorLandx,NorLandy,NorLandzLandz] = sph2cart(LatNor*pi/180,LonNor*pi/180,6371000);
% LatNor=LatNor';
% LonNor=LonNor';
% NorLandx=NorLandx';
% NorLandy=NorLandy';
% T=horzcat(LatNor,LonNor,NorLandx,NorLandy);
% Use the U0 and V0 components to set the direction
% figure
% plot(Lon,Lat,'r');
% figure
% patch(IceLandy,IceLandx,0); this produces expected result
% %
% % patch(IceLandy,IceLandy,0);
% figure
% patch(IceLandy2,IceLandx2,0);
% figure
% patch(pCoord(:,1),pCoord(:,2),pCoord(:,3));
for kk=1:nrows
    for jj=1:ncols
        vnorth=V0(kk,jj);
        veast=U0(kk,jj);
        vdir1=atan2d(vnorth,veast);
        if(vdir1<0)
            vdir1=vdir1+360;
        end
        if(vdir1>360)
            vdir1=vdir1-360;
        end
        VDir(kk,jj)=vdir1;
    end
end
% Set up the 75 km grid
SeaIceVel75km=zeros(120,120);
SeaIceVelLat75km=zeros(120,120);
SeaIceVelLon75km=zeros(120,120);
VEast75km=zeros(120,120);
VNorth75km=zeros(120,120);
VDir75km=zeros(120,120);
NobVals=NobS.values;
Nob(:,:)=NobVals(:,:,np);
Nob75km=zeros(120,120);
RasterLatsR=zeros(120,120);
RasterLonsR=zeros(120,120);
U0R=zeros(120,120);
V0R=zeros(120,120);
nnrows=0;
nncols=0;
ilowvals=0;
for i=2:3:nrows
    nnrows=nnrows+1;
    nncols=0;
    for j=2:3:ncols
        nncols=nncols+1;
        SeaIceVel75km(nnrows,nncols)=SeaIceVel(i,j);
        RasterLatsR(nnrows,nncols)=RasterLats(i,j);
        RasterLonsR(nnrows,nncols)=RasterLons(i,j);
        VEast75km(nnrows,nncols)=VEast(i,j);
        VNorth75km(nnrows,nncols)=VNorth(i,j);
        VDir75km(nnrows,nncols)=VDir(i,j);
        U0R(nnrows,nncols)=U0(i,j);
        V0R(nnrows,nncols)=V0(i,j);
        nowVal=Nob(i,j);
        if(nowVal<0)
            nowVal=NaN;
        end
        if((U0(i,j)<-9998) || (V0(i,j)<-9998))
            U0R(nnrows,nncols)=NaN;
            V0R(nnrows,nncols)=NaN;
            ilowvals=ilowvals+1;
        end
        Nob75km(nnrows,nncols)=nowVal;
    end
end
ab=1;
numreduced=120*120;
VDir75km1D=reshape(VDir75km,nnrows*nncols,1);
if(iWeekly==1)
    NobVals=NobS.values;
    Nob(:,:)=NobVals(:,:,np);
    ineg=0;
    ipos=0;
    for ii=1:nrows
        for jj=1:ncols
            nowValue=Nob(ii,jj);
            if(nowValue<0)
                Nob(ii,jj)=0;
                ineg=ineg+1;
            elseif(nowValue>0)
                ipos=ipos+1;
            end
        end
    end
    fracmissing=ineg/(nrows*ncols);
    fracpresent=ipos/(nrows*ncols);
    fractot=fracmissing+fracpresent;
    startstr1=strcat(' ----Details On Number of All Weekly Observations---for time slice-',num2str(np));
    nowDate=timeS.CalendarDates(np);
    startstr2=strcat('Time Slice Start Date-',string(nowDate));
    fprintf(fid,'%s\n',startstr1);
    fprintf(fid,'%s\n',startstr2);
    fracstr1=strcat('Fraction Of Rasters with <0 Observations-',num2str(fracmissing));
    fracstr2=strcat('Fraction Of Rasters with >0 Observations-',num2str(fracpresent));
    fracstr3=strcat('Fraction Of Rasters Accounted For-',num2str(fractot));
    fprintf(fid,'%s\n',fracstr1);
    fprintf(fid,'%s\n',fracstr2);
    fprintf(fid,'%s\n',fracstr3);
    fprintf(fid,'%s\n',' ----End Details On Number of Weekly Observations---');
    fprintf(fid,'\n');
end
% Get the data into 4 groups based on the ice velocity not the direction
[iquad1x,iquad1y]=find(SeaIceVel75km>=1 & SeaIceVel75km<3);
[iquad2x,iquad2y]=find(SeaIceVel75km>=3 & SeaIceVel75km<5);
[iquad3x,iquad3y]=find(SeaIceVel75km>=5 & SeaIceVel75km<7);
[iquad4x,iquad4y]=find(SeaIceVel75km>=7);
numquad1=length(iquad1x);
numquad2=length(iquad2x);
numquad3=length(iquad3x);
numquad4=length(iquad4x);
num1to3=numquad1;
num3to5=numquad2;
num5to7=numquad3;
numover7=numquad4;
totalquads=numquad1+numquad2+numquad3+numquad4;
frac=totalquads/numreduced;
distscale=0.50;
maxnumgood=5000;
scale=1.0;
minvel=1;
lonlim=.5;
latlim=.3;
U0Vel1=NaN(120,120);
V0Vel1=NaN(120,120);
U0Vel2=NaN(120,120);
V0Vel2=NaN(120,120);
U0Vel3=NaN(120,120);
V0Vel3=NaN(120,120);
U0Vel4=NaN(120,120);
V0Vel4=NaN(120,120);
%% Put the data in the correct format to create a quiver plot for motion point to the first quadrant
if(numquad1>0)
    lonquad1=zeros(numquad1,1);
    lonquad2=zeros(numquad1,1);
    latquad1=zeros(numquad1,1);
    latquad2=zeros(numquad1,1);
    deltalat1=zeros(numquad1,1);
    deltalon1=zeros(numquad1,1);
    nnsave=zeros(numquad1,1);
    VelMagUsed1=zeros(numquad1,1);
    nowDistKm1=zeros(numquad1,1);
    VDir75Q1=zeros(numquad1,1);
    U0R1=zeros(numquad1,1);
    V0R1=zeros(numquad1,1);
    DistKmQ1=zeros(numquad1,1);
    ihigh1ctr=zeros(numquad1,1);
    ihigh1=0;
    for nn=1:numquad1
        ix=iquad1x(nn,1);
        iy=iquad1y(nn,1);
        lonquad1(nn,1)=RasterLonsR(ix,iy);
        latquad1(nn,1)=RasterLatsR(ix,iy);
        U0R1(nn,1)=U0R(ix,iy);
        V0R1(nn,1)=V0R(ix,iy);
        VDir75Q1(nn,1)=VDir75km(ix,iy);
        nowVelMag=SeaIceVel75km(ix,iy);% This is in cm sec
        U0Vel1(ix,iy)=U0R(ix,iy);
        V0Vel1(ix,iy)=V0R(ix,iy);
        a1=isnan(nowVelMag);
        ihigh=0;
        if(a1==0)
            VelMagUsed1(nn,1)=nowVelMag;
            nowDistKm1(nn,1)=nowVelMag*86400/(100*1000);% distance travelled in day in km
            nowDistKm1(nn,1)=nowDistKm1(nn,1)/distscale;
            DistKmQ1(nn,1)=nowDistKm1(nn,1);
            arclen=km2deg(nowDistKm1(nn,1));
            az=VDir75km(ix,iy);
            nowlat=latquad1(nn,1);
            nowlon=lonquad1(nn,1);
            [latgc,longc] = track1(nowlat,nowlon,az,arclen);
            numlats=length(latgc);
            endlat=latgc(numlats,1);
            endlon=longc(numlats,1);
            lonquad2(nn,1)=endlon;
            latquad2(nn,1)=endlat;
            d1=endlat-nowlat;
            d2a=endlon-nowlon;
            d2b=nowlon-endlon;
            d2c=min(abs(d2a),abs(d2b));
            if((abs(d2c)>0.3) || (abs(d1)>0.3))
                   ihigh1=ihigh1+1;
                   ihigh=1;
                   ab=1;
            else
                   ihigh=0;
            end
            trialdist=sqrt(d1^2 + d2c^2);
            if(trialdist>.3)
                scdist=.3/trialdist;
                d1=d1/scdist;
                d2c=d2c/scdist;
            end
            deltalat1(nn,1)=d1;
            deltalon1(nn,1)=d2c;

            ihigh1ctr(nn,1)=ihigh1;
            nnsave(nn,1)=1;
        elseif(a1==1)
            VelMagUsed1(nn,1)=0;
            lonquad2(nn,1)=lonquad1(nn,1);
            latquad2(nn,1)=latquad1(nn,1);
            deltalat1(nn,1)=0;
            deltalon1(nn,1)=0;
            nnsave(nn,1)=0;
        end
        ab=2;
    end
    numgood1=sum(nnsave);
    if(numgood1>maxnumgood)
            numgood1=maxnumgood; 
    end
    [SortVelMagUsed1,index]=sort(VelMagUsed1,'descend');
    [ibig]=find(SortVelMagUsed1>minvel);
    numbig=length(ibig);
    numgood1=min(numbig,numgood1);
    lonquad1F=zeros(numgood1,1);
    lonquad2F=zeros(numgood1,1);
    latquad1F=zeros(numgood1,1);
    latquad2F=zeros(numgood1,1);
    deltalat1F=zeros(numgood1,1);
    deltalon1F=zeros(numgood1,1);
    VelMagUsed1F=zeros(numgood1,1);
    VDIR75Q1F=zeros(numgood1,1);
    U0R1F=zeros(numgood1,1);
    V0R1F=zeros(numgood1,1);
    DistKmQ1F=zeros(numgood1,1);
    Quad1Data=cell(numgood1,12);
    Quad1Hdr=cell(1,12);
    Quad1Hdr{1,1}='Unsorted Index';
    Quad1Hdr{1,2}='lon';
    Quad1Hdr{1,3}='lat';
    Quad1Hdr{1,4}='deltaLon';
    Quad1Hdr{1,5}='deltaLat';
    Quad1Hdr{1,6}='VelMag';
    Quad1Hdr{1,7}='VelDir';
    Quad1Hdr{1,8}='UO1RF';
    Quad1Hdr{1,9}='VO1RF';
    Quad1Hdr{1,10}='DistKmQ1F';
    Quad1Hdr{1,11}='ihigh';
    Quad1Hdr{1,12}='ihigh1';
    ihgh1ctrF=zeros(numgood1);
    for nn=1:numgood1
        ind=index(nn,1);
        lonquad1F(nn,1)=lonquad1(ind,1);
        latquad1F(nn,1)=latquad1(ind,1);
        deltalat1F(nn,1)=deltalat1(ind,1);
        deltalon1F(nn,1)=deltalon1(ind,1);
        U0R1F(nn,1)=U0R1(ind,1);
        V0R1F(nn,1)=V0R1(ind,1);
        VDIR75Q1F(nn,1)=VDir75Q1(ind,1);
        DistKmQ1F(nn,1)=DistKmQ1(ind,1);
        lonmaxval=lonlim*cosd(latquad1(ind,1));
        if(deltalon1F(nn,1)>lonmaxval)
            deltalon1F(nn,1)=lonmaxval;
        elseif(deltalon1F(nn,1)<lonmaxval)
            deltalon1F(nn,1)=-1*lonmaxval;
        end
        if(deltalat1F(nn,1)>.3)
            deltalat1F(nn,1)=.3;
        elseif(deltalat1F(nn,1)<-.3)
            deltalat1F(nn,1)=-.3;
        end
        VelMagUsed1F(nn,1)=SortVelMagUsed1(nn,1);
        Quad1Data{nn,1}=ind;
        Quad1Data{nn,2}=lonquad1(ind,1);
        Quad1Data{nn,3}=latquad1(ind,1);
        Quad1Data{nn,4}=deltalon1(ind,1);
        Quad1Data{nn,5}=deltalat1(ind,1);
        Quad1Data{nn,6}=SortVelMagUsed1(nn,1);
        Quad1Data{nn,7}=VDIR75Q1F(nn,1);
        Quad1Data{nn,8}=U0R1F(nn,1);
        Quad1Data{nn,9}=V0R1F(nn,1);
        Quad1Data{nn,10}=DistKmQ1F(nn,1);
        Quad1Data{nn,11}=ihigh;
        Quad1Data{nn,12}=ihigh1ctr(ind,1);
    end
    ab=1;
    if(np<-1)
        slicestr=strcat('-Wk-0',num2str(np));
    else
        slicestr=strcat('-Wk-',num2str(np));
    end
    ExcelExportFile=strcat('IceVel-',YearStr,slicestr,'.xlsx');
    TabName='Vel1';
    eval(['cd ' excelpath(1:length(excelpath)-1)]);
    if(np<=-1)
        [status1,msg1]=xlswrite(ExcelExportFile,Quad1Hdr,TabName,'a1');
        [status2,msg2]=xlswrite(ExcelExportFile,Quad1Data,TabName,'a2');
    end
end
ab=2;
%% Put the data in the correct format to create a quiver plot for motion point to the second quadrant 
if(numquad2>0)
    lonquad2=zeros(numquad2,1);
    lonquad3=zeros(numquad2,1);
    latquad2=zeros(numquad2,1);
    latquad3=zeros(numquad2,1);
    deltalat2=zeros(numquad2,1);
    deltalon2=zeros(numquad2,1);
    nnsave=zeros(numquad2,1);
    VelMagUsed2=zeros(numquad2,1);
    nowDistKm2=zeros(numquad2,1);
    VDir75Q2=zeros(numquad2,1);
    U0R2=zeros(numquad2,1);
    V0R2=zeros(numquad2,1);
    DistKmQ2=zeros(numquad2,1);
    ihigh2=0;
    for nn=1:numquad2
        ix=iquad2x(nn,1);
        iy=iquad2y(nn,1);
        lonquad2(nn,1)=RasterLonsR(ix,iy);
        latquad2(nn,1)=RasterLatsR(ix,iy);
        U0R2(nn,1)=U0R(ix,iy);
        V0R2(nn,1)=V0R(ix,iy);
        VDir75Q2(nn,1)=VDir75km(ix,iy);
        nowVelMag=SeaIceVel75km(ix,iy);% This is in cm sec
        U0Vel2(ix,iy)=U0R(ix,iy);
        V0Vel2(ix,iy)=V0R(ix,iy);
        a1=isnan(nowVelMag);
        if(a1==0)
            VelMagUsed2(nn,1)=nowVelMag;
            nowDistKm2(nn,1)=nowVelMag*86400/(100*1000);% distance travelled in day in km
            nowDistKm2(nn,1)=nowDistKm2(nn,1)/distscale;
            DistKmQ2(nn,1)=nowDistKm2(nn,1);
            arclen=km2deg(nowDistKm2(nn,1));
            az=VDir75km(ix,iy);
            nowlat=latquad2(nn,1);
            nowlon=lonquad2(nn,1);
            [latgc,longc] = track1(nowlat,nowlon,az,arclen);
            numlats=length(latgc);
            endlat=latgc(numlats,1);
            endlon=longc(numlats,1);
            lonquad3(nn,1)=endlon;
            latquad3(nn,1)=endlat;
            d1=endlat-nowlat;
            d2a=endlon-nowlon;
            d2b=nowlon-endlon;
            d2c=min(abs(d2a),abs(d2b));
            trialdist=sqrt(d1^2 + d2c^2);
            if(trialdist>.5)
                scdist=.5/trialdist;
                d1=d1/scdist;
                d2c=d2c/scdist;
            end
            deltalat2(nn,1)=d1;
            deltalon2(nn,1)=d2c;
            if((abs(d2c)>.5) || (abs(d1)>.5))
                ihigh2=ihigh2+1;
                ihigh=1;
            else
                ihigh=0;
            end
            nnsave(nn,1)=1;
        elseif(a1==1)
            VelMagUsed2(nn,1)=0;
            lonquad3(nn,1)=lonquad2(nn,1);
            latquad3(nn,1)=latquad2(nn,1);
            deltalat2(nn,1)=0;
            deltalon2(nn,1)=0;
            nnsave(nn,1)=0;
        end
        ab=2;
    end
    numgood2=sum(nnsave);
    if(numgood2>maxnumgood)
            numgood2=maxnumgood;
    end
    [SortVelMagUsed2,index]=sort(VelMagUsed2,'descend');
    [ibig]=find(SortVelMagUsed2>minvel);
    numbig=length(ibig);
    numgood2=min(numbig,numgood2);
    lonquad2F=zeros(numgood2,1);
    lonquad3F=zeros(numgood2,1);
    latquad2F=zeros(numgood2,1);
    latquad3F=zeros(numgood2,1);
    deltalat2F=zeros(numgood2,1);
    deltalon2F=zeros(numgood2,1);
    VelMagUsed2F=zeros(numgood2,1);
    VDIR75Q2F=zeros(numgood2,1);
    U0R2F=zeros(numgood2,1);
    V0R2F=zeros(numgood2,1);
    DistKmQ2F=zeros(numgood2,1);
    Quad2Data=cell(numgood2,12);
    Quad2Hdr=cell(1,12);
    Quad2Hdr{1,1}='Unsorted Index';
    Quad2Hdr{1,2}='lon';
    Quad2Hdr{1,3}='lat';
    Quad2Hdr{1,4}='deltaLon';
    Quad2Hdr{1,5}='deltaLat';
    Quad2Hdr{1,6}='VelMag';
    Quad2Hdr{1,7}='VelDir';
    Quad2Hdr{1,8}='UO2RF';
    Quad2Hdr{1,9}='VO2RF';
    Quad2Hdr{1,10}='DistKmQ2F';
    Quad2Hdr{1,11}='ihigh';
    Quad2Hdr{1,12}='ihigh2';
    for nn=1:numgood2
        ind=index(nn,1);
        lonquad2F(nn,1)=lonquad2(ind,1);
        latquad2F(nn,1)=latquad2(ind,1);
        deltalat2F(nn,1)=deltalat2(ind,1);
        deltalon2F(nn,1)=deltalon2(ind,1);
        U0R2F(nn,1)=U0R2(ind,1);
        V0R2F(nn,1)=V0R2(ind,1);
        VDIR75Q2F(nn,1)=VDir75Q2(ind,1);
        DistKmQ2F(nn,1)=DistKmQ2(ind,1);

        d1=endlat-nowlat;
        d2a=endlon-nowlon;
        d2b=nowlon-endlon;
        d2c=min(abs(d2a),abs(d2b));
        trialdist=sqrt(d1^2 + d2c);
        if(trialdist>.5)
            scdist=.5/trialdist;
            d1=d1/scdist;
            d2c=d2c/scdist;
        end
        deltalat2(nn,1)=d1;
        deltalon2(nn,1)=d2c;
        if(abs(d2c)>0.5)
               ihigh1=ihigh1+1;
               ihigh=1;
               ab=1;
        else
               ihigh=0;
        end
        VelMagUsed2F(nn,1)=SortVelMagUsed2(nn,1);
        Quad2Data{nn,1}=ind;
        Quad2Data{nn,2}=lonquad2(ind,1);
        Quad2Data{nn,3}=latquad2(ind,1);
        Quad2Data{nn,4}=deltalon2(ind,1);
        Quad2Data{nn,5}=deltalat2(ind,1);
        Quad2Data{nn,6}=SortVelMagUsed2(nn,1);
        Quad2Data{nn,7}=VDIR75Q2F(nn,1);
        Quad2Data{nn,8}=U0R2F(nn,1);
        Quad2Data{nn,9}=V0R2F(nn,1);
        Quad2Data{nn,10}=DistKmQ2F(nn,1);
        Quad2Data{nn,11}=ihigh;
        Quad2Data{nn,12}=ihigh2;
    end
    TabName='Vel2';
    eval(['cd ' excelpath(1:length(excelpath)-1)]);
    if(np<=-1)
        [status1,msg1]=xlswrite(ExcelExportFile,Quad2Hdr,TabName,'a1');
        [status2,msg2]=xlswrite(ExcelExportFile,Quad2Data,TabName,'a2');
    end
end
ab=2;
%% Put the data in the correct format to create a quiver plot for motion point to the third quadrant 
if(numquad3>0)
    lonquad3=zeros(numquad3,1);
    lonquad4=zeros(numquad3,1);
    latquad3=zeros(numquad3,1);
    latquad4=zeros(numquad3,1);
    deltalat3=zeros(numquad3,1);
    deltalon3=zeros(numquad3,1);
    nnsave=zeros(numquad3,1);
    VelMagUsed3=zeros(numquad3,1);
    nowDistKm3=zeros(numquad3,1);
    VDir75Q3=zeros(numquad3,1);
    U0R3=zeros(numquad3,1);
    V0R3=zeros(numquad3,1);
    DistKmQ3=zeros(numquad3,1);
    ihigh3=0;
    for nn=1:numquad3
        ix=iquad3x(nn,1);
        iy=iquad3y(nn,1);
        lonquad3(nn,1)=RasterLonsR(ix,iy);
        latquad3(nn,1)=RasterLatsR(ix,iy);
        U0R3(nn,1)=U0R(ix,iy);
        V0R3(nn,1)=V0R(ix,iy);
        VDir75Q3(nn,1)=VDir75km(ix,iy);
        nowVelMag=SeaIceVel75km(ix,iy);% This is in cm sec
        U0Vel3(ix,iy)=U0R(ix,iy);
        V0Vel3(ix,iy)=V0R(ix,iy);
        a1=isnan(nowVelMag);
        if(a1==0)
            VelMagUsed3(nn,1)=nowVelMag;
            nowDistKm3(nn,1)=nowVelMag*86400/(100*1000);% distance travelled in day in km
            nowDistKm3(nn,1)=nowDistKm3(nn,1)/distscale;
            DistKmQ3(nn,1)=nowDistKm3(nn,1);
            arclen=km2deg(nowDistKm3(nn,1));
            az=VDir75km(ix,iy);
            nowlat=latquad3(nn,1);
            nowlon=lonquad3(nn,1);
            [latgc,longc] = track1(nowlat,nowlon,az,arclen);
            numlats=length(latgc);
            endlat=latgc(numlats,1);
            endlon=longc(numlats,1);
            d1=endlat-nowlat;
            d2a=endlon-nowlon;
            d2b=nowlon-endlon;
            d2c=min(abs(d2a),abs(d2b));
            if((abs(d2c)>0.75) || (abs(d1)>.75))
                   ihigh3=ihigh3+1;
                   ihigh=1;
                   ab=1;
            else
                   ihigh=0;
            end
            trialdist=sqrt(d1^2 + d2c^2);
            if(trialdist>.75)
                scdist=.75/trialdist;
                d1=d1/scdist;
                d2c=d2c/scdist;
            end


            lonquad4(nn,1)=endlon;
            latquad4(nn,1)=endlat;
            deltalat3(nn,1)=d1;
            deltalon3(nn,1)=d2c;
            nnsave(nn,1)=1;
        elseif(a1==1)
            VelMagUsed3(nn,1)=0;
            lonquad3(nn,1)=lonquad3(nn,1);
            latquad3(nn,1)=latquad3(nn,1);
            deltalat3(nn,1)=0;
            deltalon3(nn,1)=0;
            nnsave(nn,1)=0;
        end
        ab=2;
    end

    numgood3=sum(nnsave);
    if(numgood3>maxnumgood)
        numgood3=maxnumgood;
    end
    [SortVelMagUsed3,index]=sort(VelMagUsed3,'descend');
    [ibig]=find(SortVelMagUsed3>minvel);
    numbig=length(ibig);
    numgood3=min(numbig,numgood3);
    lonquad3F=zeros(numgood3,1);
    lonquad4F=zeros(numgood3,1);
    latquad3F=zeros(numgood3,1);
    latquad4F=zeros(numgood3,1);
    deltalat3F=zeros(numgood3,1);
    deltalon3F=zeros(numgood3,1);
    VelMagUsed3F=zeros(numgood3,1);
    VDIR75Q3F=zeros(numgood3,1);
    U0R3F=zeros(numgood3,1);
    V0R3F=zeros(numgood3,1);
    DistKmQ3F=zeros(numgood3,1);
    Quad3Data=cell(numgood3,12);
    Quad3Hdr=cell(1,10);
    Quad3Hdr{1,1}='Unsorted Index';
    Quad3Hdr{1,2}='lon';
    Quad3Hdr{1,3}='lat';
    Quad3Hdr{1,4}='deltaLon';
    Quad3Hdr{1,5}='deltaLat';
    Quad3Hdr{1,6}='VelMag';
    Quad3Hdr{1,7}='VelDir';
    Quad3Hdr{1,8}='UO3RF';
    Quad3Hdr{1,9}='VO3RF';
    Quad3Hdr{1,10}='DistKmQ3F';
    Quad3Hdr{1,11}='ihigh';
    Quad3Hdr{1,12}='ihigh3';
    for nn=1:numgood3
        ind=index(nn,1);
        lonquad3F(nn,1)=lonquad3(ind,1);
        latquad3F(nn,1)=latquad3(ind,1);
        deltalat3F(nn,1)=deltalat3(ind,1);
        deltalon3F(nn,1)=deltalon3(ind,1);
        U0R3F(nn,1)=U0R3(ind,1);
        V0R3F(nn,1)=V0R3(ind,1);
        VDIR75Q3F(nn,1)=VDir75Q3(ind,1);
        DistKmQ3F(nn,1)=DistKmQ3(ind,1);
        if(deltalon3F(nn,1)>.75)
            deltalon3F(nn,1)=.75;
        elseif(deltalon3F(nn,1)<-.75)
            deltalon3F(nn,1)=-.75;
        end
         if(deltalat3F(nn,1)>.75)
            deltalat3F(nn,1)=.75;
        elseif(deltalat3F(nn,1)<-.75)
            deltalat3F(nn,1)=-.75;
        end
        VelMagUsed3F(nn,1)=SortVelMagUsed3(nn,1);
        Quad3Data{nn,1}=ind;
        Quad3Data{nn,2}=lonquad3(ind,1);
        Quad3Data{nn,3}=latquad3(ind,1);
        Quad3Data{nn,4}=deltalon3(ind,1);
        Quad3Data{nn,5}=deltalat3(ind,1);
        Quad3Data{nn,6}=SortVelMagUsed3(nn,1);
        Quad3Data{nn,7}=VDIR75Q3F(nn,1);
        Quad3Data{nn,8}=U0R3F(nn,1);
        Quad3Data{nn,9}=V0R3F(nn,1);
        Quad3Data{nn,10}=DistKmQ3F(nn,1);
        Quad3Data{nn,11}=ihigh;
        Quad3Data{nn,12}=ihigh3;
    end
    TabName='Vel3';
    eval(['cd ' excelpath(1:length(excelpath)-1)]);
    if(np<=-1)
        [status1,msg1]=xlswrite(ExcelExportFile,Quad3Hdr,TabName,'a1');
        [status2,msg2]=xlswrite(ExcelExportFile,Quad3Data,TabName,'a2');
    end
end
ab=2;
%% Put the data in the correct format to create a quiver plot for motion point to the fourth quadrant 
if(numquad4>0)
    lonquad4=zeros(numquad4,1);
    lonquad5=zeros(numquad4,1);
    latquad4=zeros(numquad4,1);
    latquad5=zeros(numquad4,1);
    deltalat4=zeros(numquad4,1);
    deltalon4=zeros(numquad4,1);
    nnsave=zeros(numquad4,1);
    VelMagUsed4=zeros(numquad4,1);
    nowDistKm4=zeros(numquad4,1);
    VDir75Q4=zeros(numquad4,1);
    U0R4=zeros(numquad4,1);
    V0R4=zeros(numquad4,1);
    DistKmQ4=zeros(numquad4,1);
    itoobig4=zeros(numquad4,1);
    ihigh4=0;
    if(np==4)
        ab=1;
    end
    for nn=1:numquad4
        ix=iquad4x(nn,1);
        iy=iquad4y(nn,1);
        lonquad4(nn,1)=RasterLonsR(ix,iy);
        latquad4(nn,1)=RasterLatsR(ix,iy);
        nowVelMag=SeaIceVel75km(ix,iy);% This is in cm sec
        U0R4(nn,1)=U0R(ix,iy);
        V0R4(nn,1)=V0R(ix,iy);
        VDir75Q4(nn,1)=VDir75km(ix,iy);
        U0Vel4(ix,iy)=U0R(ix,iy);
        V0Vel4(ix,iy)=V0R(ix,iy);
        a1=isnan(nowVelMag);
        if(a1==0)
            VelMagUsed4(nn,1)=nowVelMag;
            nowDistKm4(nn,1)=nowVelMag*86400/(100*1000);% distance travelled in day in km
            nowDistKm4(nn,1)=nowDistKm4(nn,1)/distscale;
            DistKmQ4(nn,1)=nowDistKm4(nn,1);
            arclen=km2deg(nowDistKm4(nn,1));
            az=VDir75km(ix,iy);
            nowlat=latquad4(nn,1);
            nowlon=lonquad4(nn,1);
            [latgc,longc] = track1(nowlat,nowlon,az,arclen);
            numlats=length(latgc);
            endlat=latgc(numlats,1);
            endlon=longc(numlats,1);
            d1=endlat-nowlat;
            d2a=endlon-nowlon;
            d2b=nowlon-endlon;
            d2c=min(abs(d2a),abs(d2b));
            if((abs(d2c)>0.75) || (abs(d1)>.75))
                   ihigh4=ihigh4+1;
                   ihigh=1;
                   ab=1;
            else
                   ihigh=0;
            end
            itoobig4(nn,1)=ihigh;
            trialdist=sqrt(d1^2 + d2c^2);
            if(trialdist>1.0)
                scdist=1.0/trialdist;
                d1=d1/scdist;
                d2a=d2a/scdist;
                ihigh=1;
            else
               
                ihigh=0;
            end


            lonquad5(nn,1)=endlon;
            latquad5(nn,1)=endlat;
%             deltalat4(nn,1)=latquad5(nn,1)-latquad4(nn,1);
%             deltalon4(nn,1)=lonquad5(nn,1)-lonquad4(nn,1);
            deltalat4(nn,1)=d1;
            deltalon4(nn,1)=d2a;
            nnsave(nn,1)=1;
        elseif(a1==1)
            VelMagUsed4(nn,1)=0;
            lonquad4(nn,1)=lonquad4(nn,1);
            latquad4(nn,1)=latquad4(nn,1);
            deltalat4(nn,1)=0;
            deltalon4(nn,1)=0;
            nnsave(nn,1)=0;
        end
       
    end

    numgood4=sum(nnsave);
    if(numgood4>maxnumgood)
            numgood4=maxnumgood;
    end
    [SortVelMagUsed4,index]=sort(VelMagUsed4,'descend');
    [ibig]=find(SortVelMagUsed4>minvel);
    numbig=length(ibig);
    numgood4=min(numbig,numgood4);
    lonquad4F=zeros(numgood4,1);
    lonquad5F=zeros(numgood4,1);
    latquad4F=zeros(numgood4,1);
    latquad4F=zeros(numgood4,1);
    deltalat4F=zeros(numgood4,1);
    deltalon4F=zeros(numgood4,1);
    VelMagUsed4F=zeros(numgood4,1);
    VDIR75Q4F=zeros(numgood4,1);
    U0R4F=zeros(numgood4,1);
    V0R4F=zeros(numgood4,1);
    DistKmQ4F=zeros(numgood4,1);
    itoobigF4=zeros(numgood4,1);
    Quad4Data=cell(numgood4,12);
    Quad4Hdr=cell(1,9);
    Quad4Hdr{1,1}='Unsorted Index';
    Quad4Hdr{1,2}='lon';
    Quad4Hdr{1,3}='lat';
    Quad4Hdr{1,4}='deltaLon';
    Quad4Hdr{1,5}='deltaLat';
    Quad4Hdr{1,6}='VelMag';
    Quad4Hdr{1,7}='VelDir';
    Quad4Hdr{1,8}='UO4RF';
    Quad4Hdr{1,9}='VO4RF';
    Quad4Hdr{1,10}='DistKmQ4F';
    Quad4Hdr{1,11}='ihigh';
    Quad4Hdr{1,12}='itoobigF4';
    for nn=1:numgood4
        ind=index(nn,1);
        lonquad4F(nn,1)=lonquad4(ind,1);
        latquad4F(nn,1)=latquad4(ind,1);
        deltalat4F(nn,1)=deltalat4(ind,1);
        deltalon4F(nn,1)=deltalon4(ind,1);
        itoobigF4(nn,1)=itoobig4(ind,1);
        U0R4F(nn,1)=U0R4(ind,1);
        V0R4F(nn,1)=V0R4(ind,1);
        VDIR75Q4F(nn,1)=VDir75Q4(ind,1);
        DistKmQ4F(nn,1)=DistKmQ4(ind,1);
        if(deltalon4F(nn,1)>.75)
            deltalon4F(nn,1)=.75;
        elseif(deltalon4F(nn,1)<-.75)
            deltalon4F(nn,1)=-.3;
        end
        if(deltalat4F(nn,1)>.75)
            deltalat4F(nn,1)=.75;
        elseif(deltalat4F(nn,1)<-.75)
            deltalat4F(nn,1)=-.75;
        end
        VelMagUsed4F(nn,1)=SortVelMagUsed4(nn,1);
        Quad4Data{nn,1}=ind;
        Quad4Data{nn,2}=lonquad4(ind,1);
        Quad4Data{nn,3}=latquad4(ind,1);
        Quad4Data{nn,4}=deltalon4(ind,1);
        Quad4Data{nn,5}=deltalat4(ind,1);
        Quad4Data{nn,6}=SortVelMagUsed4(nn,1);
        Quad4Data{nn,7}=VDIR75Q4F(nn,1);
        Quad4Data{nn,8}=U0R4F(nn,1);
        Quad4Data{nn,9}=V0R4F(nn,1);
        Quad4Data{nn,10}=DistKmQ4F(nn,1);
        Quad4Data{nn,11}=ihigh;
        Quad4Data{nn,12}=itoobigF4(nn,1);
    end
    TabName='Vel4';
    eval(['cd ' excelpath(1:length(excelpath)-1)]);
    if(np<=-1)
        [status1,msg1]=xlswrite(ExcelExportFile,Quad4Hdr,TabName,'a1');
        [status2,msg2]=xlswrite(ExcelExportFile,Quad4Data,TabName,'a2');
    end

end
ab=1;
% Now put the sorted velocities in one big array for all quadrants
numallquads=numgood1+numgood2+numgood3+numgood4;
fprintf(fid,'%s\n','------Distribution by Velocity-----');
quad1str=strcat('Sea Ice Velocity Observation Between 1 and 3 cm/sec=',num2str(numgood1));
quad2str=strcat('Sea Ice Velocity Observation Between 3 and 5 cm/sec=',num2str(numgood2));
quad3str=strcat('Sea Ice Velocity Observation Between 5 and 7 cm/sec=',num2str(numgood3));
quad4str=strcat('Sea Ice Velocity Observation Over 7 cm/sec=',num2str(numgood4));
fprintf(fid,'%s\n',quad1str);
fprintf(fid,'%s\n',quad2str);
fprintf(fid,'%s\n',quad3str);
fprintf(fid,'%s\n',quad4str);
fprintf(fid,'%s\n','----- End Distribution By Velocity-----');
try
    AllVelMagUsedF=[VelMagUsed1F;VelMagUsed2F;VelMagUsed3F;VelMagUsed4F];
catch
    ab=2;
end
%AllVelMagUsedF=cat(1,VelMagUsed1F,VelMagUsed2F,VelMagUsed3F,VelMagUsed4F);
[SortedAllVelMagUsedF,index]=sort(AllVelMagUsedF,'descend');
[ir25]=find((SortedAllVelMagUsedF>=2) & (SortedAllVelMagUsedF<5));
a1=isempty(ir25);
if(a1==0)
    num2to5=length(ir25);
elseif(a1==1)
    num2to5=0;
end
[ir510]=find((SortedAllVelMagUsedF>=5) & (SortedAllVelMagUsedF<10));
a2=isempty(ir510);
if(a2==0)
    num5to10=length(ir510);
elseif(a2==1)
    num5to10=0;
end
[ir1015]=find((SortedAllVelMagUsedF>=10) & (SortedAllVelMagUsedF<15));
a3=isempty(ir1015);
if(a3==0)
    num10to15=length(ir1015);
elseif(a3==1)
    num10to15=0;
end
[irabove15]=find(SortedAllVelMagUsedF>15);
a4=isempty(irabove15);
if(a4==0)
    numabove15=length(irabove15);
elseif(a4==1)
    numabove15=0;
end
VelMagDistribution(np,1)=num1to3;
VelMagDistribution(np,2)=num3to5;
VelMagDistribution(np,3)=num5to7;
VelMagDistribution(np,3)=numover7;
VelMag2to5(np,1)=num2to5;
VelMag5to10(np,1)=num5to10;
VelMag10to15(np,1)=num10to15;
VelMagover15(np,1)=numabove15;
VQuad1(np,1)=numquad1;
VQuad2(np,1)=numquad2;
VQuad3(np,1)=numquad3;
VQuad4(np,1)=numquad4;
ab=2;

% Set up the map axis
westEdge=-130;
eastEdge=-60;
southEdge=18;
northEdge=52;

if(ikind==2)
    southEdge=19;
    northEdge=50;
    westEdge=-130;
    eastEdge=-60;
end
if(ikind==3)
    southEdge=-60;
    northEdge=20;
    westEdge=-110;
    eastEdge=-40;
end
if(ikind==4)
    southEdge=5;
    northEdge=40;
    westEdge=60;
    eastEdge=100;
end
if(ikind==5)
    southEdge=20;
    northEdge=70;
    westEdge=-15;
    eastEdge=60;
end
if(ikind==6)
    southEdge=15;
    northEdge=60;
    westEdge=80;
    eastEdge=140;
end
%% Set up the map axis
if(ikind==1)
    axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
        'plabellocation',[-60 -50 -40 -30 -20 -10 0 10 20 30 40 50 60],'mlabellocation',[]);
elseif(ikind==2)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0]','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);    
elseif(ikind==3)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',20,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',20);
elseif(ikind==4)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);
elseif(ikind==5)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);
elseif(ikind==6)
    axesm ('pcarree','Frame','on','Grid','on','GColor',[1 1 0],'MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',10,'mlabellocation',10,...
     'MLabelParallel','south','MLineLocation',10,'PLineLocation',10);
elseif(ikind==7) % Use this option for North Pole (old limit was 56-90)
    ax=axesm('eqaazim','MapLatLimit',[56 90],'FontSize',10,'FontWeight','bold','plabellocation',10,'mlabellocation',20,...
        'Grid','on','GColor',[0 0 0],'MLineLocation',20,'PLineLocation',10);
%    ax.Color='cyan';
    setm(ax,'glinewidth',1,'glinestyle','-')
    gridm on
    mlabel on
    plabel on;
    setm(gca,'MLabelParallel',5);
    Proj='equazim';
elseif(ikind==8) % Use this option for South Pole
    axesm('eqaazim','MapLatLimit',[-90 -65],'FontSize',10,'FontWeight','bold','plabellocation',10,'mlabellocation',20,...
        'Grid','on','GColor',[1 0 1],'MLineLocation',20,'PLineLocation',10);
    gridm on
    mlabel on
    plabel on;
    setm(gca,'MLabelParallel',5);
    Proj='equazim';
elseif(ikind==9) % Use this option for North Pole and the globequiver function
    axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
        'plabellocation',[60 70 80 ],'mlabellocation',[0 30 60 90]);
    gridm on
    mlabel on
    plabel on;
    setm(gca,'MLabelParallel',5);
    Proj='equazim';
end
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
setm(gca,'galtitude',.1)
maxval2=.1;
%% load the country borders and plot them
eval(['cd ' mappath(1:length(mappath)-1)]);
if(ikind<7)
    load('USAHiResBoundaries.mat','USALat','USALon');
    plot3m(USALat,USALon,maxval2,'r');
    load('CanadaBoundaries.mat','CanadaLat','CanadaLon');
    plot3m(CanadaLat,CanadaLon,maxval2,'r');
    load('AsiaHiResBoundaries.mat','AsiaLat','AsiaLon');
    plot3m(AsiaLat,AsiaLon,maxval2,'r');
    load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');
    plot3m(EuropeLat,EuropeLon,maxval2,'r');
    load('AfricaHiResBoundaries.mat','AfricaLat','AfricaLon');
    plot3m(AfricaLat,AfricaLon,maxval2,'r');
    load('SouthAmericaHiResBoundaries.mat','SouthAmericaLat','SouthAmericaLon');
    plot3m(SouthAmericaLat,SouthAmericaLon,maxval2,'r');
    load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
    plot3m(AustraliaLat,AustraliaLon,maxval2,'r');
    load('MexicoBoundaries.mat','MexicoLat','MexicoLon');
    plot3m(MexicoLat,MexicoLon,maxval2,'r');
    load('CubaBoundaries.mat','CubaLat','CubaLon');
    plot3m(CubaLat,CubaLon,maxval2,'r');
    load('DominicanRepublicBoundaries.mat','DRLat','DRLon');
    plot3m(DRLat,DRLon,maxval2,'r');
    load('HaitiBoundaries.mat','HaitiLat','HaitiLon');
    plot3m(HaitiLat,HaitiLon,maxval2,'r');
    load('BelizeBoundaries.mat','BelizeLat','BelizeLon');
    plot3m(BelizeLat,BelizeLon,maxval2,'r');
    load('GautemalaBoundaries.mat','GautemalaLat','GautemalaLon');
    plot3m(GautemalaLat,GautemalaLon,maxval2,'r')
    load('JamaicaBoundaries.mat','JamaicaLat','JamaicaLon');
    plot3m(JamaicaLat,JamaicaLon,maxval2,'r');
    load('NicaraguaBoundaries.mat','NicaraguaLat','NicaraguaLon');
    plot3m(NicaraguaLat,NicaraguaLon,maxval2,'r')
    load('HondurasBoundaries.mat','HondurasLat','HondurasLon');
    plot3m(HondurasLat,HondurasLon,maxval2,'r')
    load('ElSalvadorBoundaries.mat','ElSalvadorLat','ElSalvadorLon');
    plot3m(ElSalvadorLat,ElSalvadorLon,maxval2,'r');
    load('PanamaBoundaries.mat','PanamaLat','PanamaLon');
    plot3m(PanamaLat,PanamaLon,maxval2,'r');
    load('SaudiBoundaries.mat','SaudiLat','SaudiLon');
    plot3m(SaudiLat,SaudiLon,'r');
    load('TurkeyBoundaries.mat','TurkeyLat','TurkeyLon');
    plot3m(TurkeyLat,TurkeyLon,'r');
    load('IranBoundaries.mat','IranLat','IranLon');
    plot3m(IranLat,IranLon,'r');
    load('IraqBoundaries.mat','IraqLat','IraqLon');
    plot3m(IraqLat,IraqLon,'r');
    load('YemenBoundaries.mat','YemenLat','YemenLon');
    plot3m(YemenLat,YemenLon,'r');
    load('OmanBoundaries.mat','OmanLat','OmanLon');
    plot3m(OmanLat,OmanLon,'r');
    load('SyriaBoundaries.mat','SyriaLat','SyriaLon');
    plot3m(SyriaLat,SyriaLon,'r');
    load('LebanonBoundaries.mat','LebanonLat','LebanonLon');
    plot3m(LebanonLat,LebanonLon,'r');
elseif((ikind==7) || (ikind==9))
    tic;
% Load OceanBoundaries
%     S0=shaperead('ne_10m_ocean.shp','UseGeoCoords',true);
%     OceanLat=S0.Lat';
%     OceanLon=S0.Lon';
%     patchm(OceanLat,OceanLon,brightblue);
    load('OceanBoundariesRed.mat','OceanLat','OceanLon')
    patchm(OceanLat,OceanLon,brightblue);
% Get Greenland
    load('GreenLandBoundariesRed4.mat','GreenLandLat','GreenLandLon')
    patchesm(GreenLandLat,GreenLandLon,[0.9 0.9 0.5]);
% Get Spitzbergen
    load('SpitzbergenBoundariesRed.mat','SpitzLat','SpitzLon')
    patchm(SpitzLat,SpitzLon,bubblegum);
% Get Norway
    load('NorwayBoundariesRed.mat','NorwayLat','NorwayLon');
    patchm(NorwayLat,NorwayLon,bubblegum);
% Get Sweden
    load('SwedenBoundaries.mat','SwedenLat','SwedenLon');
    patchm(SwedenLat,SwedenLon,[0 1 0]);
% Get Finland
    load('FinlandBoundaries.mat','FinlandLat','FinlandLon')
    patchm(FinlandLat,FinlandLon,[0 .8 .2]);
% Get Canada
    load('CanadaBoundariesRed4.mat','CanadaLat','CanadaLon')
    nowColor=[LandColors(4,1) LandColors(4,2) LandColors(4,3)];
    patchm(CanadaLat,CanadaLon,nowColor);
% Get Russia
    load('RussiaBoundariesRed4.mat','RussiaLat','RussiaLon')
    nowColor=[LandColors(3,1) LandColors(3,2) LandColors(3,3)];
    patchm(RussiaLat,RussiaLon,nowColor);
% Get Iceland
    load('IcelandBoundaries.mat','IcelandLat','IcelandLon')
    patchm(IcelandLat,IcelandLon,[0.9 0.9 0.2]);
% Get Alaska
    load('AlaskaBoundariesRed.mat','AlaskaLat','AlaskaLon')
    nowColor=[LandColors(8,1) LandColors(8,2) LandColors(8,3)];
    patchm(AlaskaLat,AlaskaLon,[0 .8 .2]);
% Get the UK
    load('UKBoundariesRed.mat','UKLat','UKLon')
    patchm(UKLat,UKLon,[0 .7 .4]);
% Get Estonia
    load('EstoniaBoundaries.mat','EstoniaLat','EstoniaLon');
    patchm(EstoniaLat,EstoniaLon,[0.5 .7 .2]);
% Get Denmark
    load('DenmarkBoundaries.mat','DenmarkLat','DenmarkLon');
    patchm(DenmarkLat,DenmarkLon,[0.6 .3 .1]);
% Get Lithuania
    load('LithuaniaBoundaries.mat','LithuaniaLat','LithuaniaLon')
    patchm(LithuaniaLat,LithuaniaLon,[0.5 .3 .3]);
% Get Latvia
    load('LatviaBoundaries.mat','LatviaLat','LatviaLon')
    patchm(LatviaLat,LatviaLon,[0.7 .7 .3]);
    elapsed_time=toc;

    if(np==1)
        dispstr=strcat('Time to plot countries-',num2str(elapsed_time),'-seconds');
        disp(dispstr)
        [userview,systemview] = memory;
        fprintf(fid,'%s\n','-----Memory Info-----');
        memstr1=strcat('Memory Used By Matlab-GB=',num2str(userview.MemUsedMATLAB/1E9));
        availmemGB=systemview.PhysicalMemory.Available/1E9;
        totalmemGB=systemview.PhysicalMemory.Total/1E9;
        memstr2=strcat('SystemTotalMem-GB-',num2str(totalmemGB),'-SystemAvailableMem-GB-',num2str(availmemGB));
        fprintf(fid,'%s\n',memstr1);
        fprintf(fid,'%s\n',memstr2);
        fprintf(fid,'%s\n','-----End Memory Info-----');
    end
    ab=1;
elseif(ikind==8)
    eval(['cd ' antarcticpath(1:length(antarcticpath)-1)]);
    S0=shaperead(antarcticshapefile,'UseGeoCoords',true);
    SouthPoleLat=S0.Lat;
    SouthPoleLon=S0.Lon;
    plot3m(SouthPoleLat,SouthPoleLon,20,'r');
end

hold on

% add a quiver plot
% if(numWind>500)
%     numWind=500;
% end

if(numgood1>0)
    quiverm(latquad1F,lonquad1F,deltalat1F,deltalon1F,'r',1);
end
if(numgood2>0)
    quiverm(latquad2F,lonquad2F,deltalat2F,deltalon2F,'g',1);
end
if(numgood3>0)
    quiverm(latquad3F,lonquad3F,deltalat3F,deltalon3F,'m',1);
end
if(numgood4>0)
    quiverm(latquad4F,lonquad4F,deltalat4F,deltalon4F,'y',1);
end
itype=2;
if(itype==1)
    view(0,0);
end
ab=1;
%q = globequiver(RasterLats,RasterLons,U0,V0,'density',20,'r');
%quivermc(RasterLatsR,RasterLonsR,U0R,V0R,'density',100,'colormap',jet,'linewidth',2)
% The Nan values can be id'ed by having the fill value of -9999 replace
% these will actual Nans
[ilow,jlow]=find(U0R<-9998);
numlow=length(ilow);
for kk=1:numlow
    in=ilow(kk,1);
    jn=jlow(kk,1);
    U0R(in,jn)=NaN;
    V0R(in,jn)=NaN;
end
ab=2;
%q = globequiver(RasterLatsR,RasterLonsR,U0R,V0R,2,'density',100,'r');
%ncquiref(RasterLats,RasterLons,U0,V0);
% The Nan values can be id'ed by having the fill value of -9999 replace
% these will actial Nans

% [ilow,jlow]=find(U0R<-9998);
% numlow=length(ilow);
% for kk=1:numlow
%     in=ilow(kk,1);
%     jn=jlow(kk,1);
%     U0R(in,jn)=NaN;
%     V0R(in,jn)=NaN;
% end
ab=1;
% Write File
xval=xS.values;
yval=yS.values;
x=xval(1:3:360);
y=yval(1:3:360);
if(np<10)
    MatFileName=strcat('IceMovementVelVectors-',YearStr,'-Wk-','0',num2str(np),'.mat');
else
    MatFileName=strcat('IceMovementVelVectors-',YearStr,'-Wk-',num2str(np),'.mat');
end
eval(['cd ' velpath(1:length(velpath)-1)]);
actionstr='save';
varstr1='RasterLatsR RasterLonsR U0R V0R x y np titlestr SeaIceVel75km';
varstr2=' U0R1 U0R2 U0R3 U0R4 V0R1 V0R2 V0R3 V0R4';
varstr3=' U0Vel1 V0Vel1 U0Vel2 V0Vel2 U0Vel3 V0Vel3 U0Vel4 V0Vel4';
varstr4=' num1to3 num3to5 num5to7 numover7';
varstr=strcat(varstr1,varstr2,varstr3,varstr4);
qualstr='-v7.3';
[cmdString2]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString2)
dispstr=strcat('Wrote Matlab File-',MatFileName);
disp(dispstr);

set(gcf,'Position',[hor1 vert1 widd lend])
title(titlestr)
hold off
set(gca,'Position',[.12 .18 .70 .70]);
hold on
set(gca,'FontWeight','bold');
hold off
ht=title(titlestr);
set(ht,'FontWeight','bold');
if(np<10)
    figstr=strcat('image00',num2str(np));
elseif((np>=10) && (np<100))
    figstr=strcat('image0',num2str(np));
end
figstr=strcat(figstr,'.jpg');
ax=gca;
% Set up the axis for writing at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.10;
if(iDaily==1)
    ndate=timeS.CalendarDates(np);
    nchr=string(ndate);
end
if(iWeekly==1)
    values=timeS.values;
    numvals=length(values);
    ndate1=timeS.CalendarDates(np);
    nchr1=string(ndate1);

    if(np<52)
        ndate2=timeS.CalendarDates(np+1);
        nchr2=string(ndate2);
    elseif(np==52)
        nchr2=strcat('Dec-31-',YearStr);
    end
end
nowFile2=RemoveUnderScores(nowFile);
if(iDaily==1)
    txtstr1=strcat('Data For Date-',nchr,'-taken from file-',nowFile2);
else
    txtstr1=strcat('Data For StartDate-',nchr1,'-up to-',nchr2,'-taken from file-',nowFile2);
end
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',10);
tx2=.10;
tx2a=.10;
tx2b=.17;
tx2c=.25;
tx2d=.33;
ty2=.07;
txtstr2a=strcat('Vel 1-',num2str(numgood1));
txtstr2b=strcat('-Vel 2-',num2str(numgood2));
txtstr2c=strcat('-Vel 3-',num2str(numgood3));
txtstr2d=strcat('-Vel 4-',num2str(numgood4));
txt2a=text(tx2a,ty2,txtstr2a,'FontWeight','bold','FontSize',10,'Color','red');
txt2b=text(tx2b,ty2,txtstr2b,'FontWeight','bold','FontSize',10,'Color','green');
txt2c=text(tx2c,ty2,txtstr2c,'FontWeight','bold','FontSize',10,'Color','magenta');
txt2d=text(tx2d,ty2,txtstr2d,'FontWeight','bold','FontSize',10,'Color','yellow');
tx3=.10;
ty3=.04;
txtstr3=strcat('Vel 1 to 3-',num2str(num1to3),'-Vel 3 to 5-',num2str(num3to5),'-Vel 5 to 7-',...
    num2str(num5to7),'-Vel >7-',num2str(numover7),'-Vel in cm/sec');
txt3=text(tx3,ty3,txtstr3,'FontWeight','bold','FontSize',10);
set(newaxesh,'Visible','Off');
pause(chart_time);
frame=getframe(gcf);
writeVideo(vTemp,frame);
dispstr=strcat('Grabbed movie frame-',num2str(np),'-of total-',num2str(nslices));
disp(dispstr)
pause(5)
close('all');


end

