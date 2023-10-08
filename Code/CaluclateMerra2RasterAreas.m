function  CaluclateMerra2RasterAreas
% Now calculate the area of each Raster point. This on varies by latitude
% Get the area of each cell based on the latitude
% Written By: Stephen Forczyk
% Created: Jun 24,2023
% Revised: -----
% Classification: Public Domain

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