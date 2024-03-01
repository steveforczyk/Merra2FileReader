% This is a compendium of Matlab Web Based Maps

icase=2;
if(icase==1)
    %For this example, search the WMS Database for layers that mention eox. For more information about
    %EOX::Maps, see EOX::Maps.
    eox = wmsfind("eox");
    
    %For this example, refine your search to find layers in the WMS Database that also contain blue marble
    %imagery from the NASA Earth Observatory.
    eox_marble = refine(eox,"blue marble");
    
    %In this case, there are multiple layers in the WMS Database from EOX::Maps that contain blue marble
    %imagery. Refine your search again to find layers with valid latitude limits.
    eox_marble_limits = refineLimits(eox_marble,"Latlim",[-90 90]);
    
    %Update the layer.
    eox_update = wmsupdate(eox_marble_limits);
    
    % For this example, create an axesm-based map with geographic limits that are appropriate for Europe.
    % Get the current map projection structure (mstruct), which contains properties of the current map.
    figure
    worldmap europe
    mstruct = gcm;
    latlim = mstruct.maplatlimit;
    lonlim = mstruct.maplonlimit;
    %Read the layer as an array and a GeographicCellsReference object, which ties the map to a
    %specific location on Earth. Specify the latitude and longitude limits as the current map limits.
    [A,R] = wmsread(eox_update,"Latlim",latlim,"Lonlim",lonlim);
    %Display the map. Add a title by specifying the layer title.
    geoshow(A,R)
    title(eox_update.LayerTitle)
    plabel off
    mlabel off
    pause()
elseif(icase==2)
%Search the WMS Database for layers from the NASA Goddard Space Flight SVS Image Server, then
%   find the layer that contains urban temperature signatures. Synchronize the layer with the server by
%   using the wmsupdate function. To access the legend image, you must synchronize the layer with the
%   server.
    layers = wmsfind('svs.gsfc.nasa.gov','SearchField','serverurl');
    urban_temperature = refine(layers,'urban*temperature');
    urban_temperature = wmsupdate(urban_temperature);
%    Read and display the layer on a map.
    [A,R] = wmsread(urban_temperature);
    mapFigure = figure;
    usamap(A,R)
    geoshow(A,R)
% Customize the map by adding city markers, state boundaries, meridian and parallel labels, a north
% arrow, and a title.
latlim = R.LatitudeLimits;
lonlim = R.LongitudeLimits;
GT = readgeotable('worldcities.shp');
cities = geoclip(GT.Shape,latlim,lonlim);
GT = GT(cities.NumPoints ~= 0,:);
geoshow(GT,'MarkerEdgeColor','w','Color','w')
for k=1:height(GT)
lat = GT(k,:).Shape.Latitude;
lon = GT(k,:).Shape.Longitude;
n = GT(k,:).Name;
textm(lat,lon,n,'Color','w','FontWeight','bold')
end
geoshow('usastatehi.shp', 'FaceColor', 'none',...
'EdgeColor','black')
mlabel('FontWeight','bold')
plabel('FontWeight','bold')
northarrow('Facecolor','w','EdgeColor','w',...
'Latitude',36.249,'Longitude',-71.173)
title('Urban Temperature Signatures')
%Determine if a legend image is available by accessing the Details.Style.LegendURL field of the
%layer.
%urban_temperature.Details.Style.LegendURL;
%The fields are not empty, so a legend is available. Download the legend image.
url = urban_temperature.Details.Style.LegendURL.OnlineResource;
legendImage = webread(url);
%Create a figure and axes that are the same size as the image. Then, display the image. Note that the
%legend is an image of a colorbar, not a Legend object.
sz = size(legendImage);
legendFigure = figure;
pos = legendFigure.Position;
legendFigure.Position = [pos(1) pos(2) sz(2) sz(1)];
ax.Units = 'pixels';
ax.Position = [0 0 sz(2) sz(1)];
imshow(legendImage)
%Combine Map and Legend
%When you display images using the geoshow function, the map projection might cause text to appear
%warped. Instead, convert the map into an image and combine the map image with the legend image.
%Convert the map into an image by using the getframe and frame2im functions.
mapImage = getframe(mapFigure);
mapImage = frame2im(mapImage);
%To combine the images, the width of the images must be equal. In this example, the width of the
%legend image is smaller than the width of the map image. Make the widths the same bymapImage = frame2im(mapImage);
%To combine the images, the width of the images must be equal. In this example, the width of the
%legend image is smaller than the width of the map image. Make the widths the same by
% by padding the legend image
p = (size(mapImage,2) - size(legendImage,2))/2;
legendImage = padarray(legendImage,[0 p 0],255,'both');
%Combine the images.
combinedImage = [mapImage; legendImage];
%Create a figure and axes that are the same size as the combined image. Display the combined image
%in the figure.
combinedsz = size(combinedImage);
combinedFigure = figure;
pos = combinedFigure.Position;
combinedFigure.Position = ...
[pos(1) pos(2) combinedsz(2) combinedsz(1)];
ax = gca;
ax.Units = 'pixels';
ax.Position = [0 0 combinedsz(2) combinedsz(1)];
imshow(combinedImage)

end

