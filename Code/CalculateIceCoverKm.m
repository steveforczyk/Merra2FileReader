function [IceAreaWorld,IceAreaNP,IceAreaSP] = CalculateIceCoverKm(SeaIce)
% This function will calculate the Area of the Sea Ice cover in sq km
% using the 2D array Sea Ice
% Written By: Stephen Forczyk
% Created: Feb 11,2024
% Revised: -----
% Classification: Public Domain/Unclassified
%
% Inputs
% SeaIce 2 D Array of ice fraction per grid point using the Merra 2 grid
% iwindow: Flag to limit calculations as follows
% iwindow=1  Use entire earth (Use All Raster Lats Columns )
% iwindow=2  Use North Pole Region only (i.e. Lat >=65 N) (Use Raster
% Lats(311-361)
% Cols 
% iwindow=3  Use South Pole Region Only (i.e. Lat<=-65S) (Use Raster Lats
% (1-51)
%
global RasterLats RasterLons Rpix RasterAreas RadiusCalc RasterPtLats RasterLatAreas;
IceAreaWorld=0;
IceAreaNP=0;
IceAreaSP=0;
[irows,jcols]=size(SeaIce);
% Calculate the Ice Covered Area of the whole World
for i=1:irows
    for j=1:jcols
        nowRasterArea=RasterLatAreas(j,1);
        nowFrac=SeaIce(i,j);
        IceAreaWorld=IceAreaWorld+nowRasterArea*nowFrac;
    end
end
% Calculate For the North Pole Region
% Calculate the Ice Covered Area of the whole World
for i=1:irows
    for j=311:361
        nowRasterArea=RasterLatAreas(j,1);
        nowFrac=SeaIce(i,j);
        IceAreaNP=IceAreaNP+nowRasterArea*nowFrac;
    end
end
% Calculate the Ice Covered Area of the whole World
for i=1:irows
    for j=1:51
        nowRasterArea=RasterLatAreas(j,1);
        nowFrac=SeaIce(i,j);
        IceAreaSP=IceAreaSP+nowRasterArea*nowFrac;
    end
end

end