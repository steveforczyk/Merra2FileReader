function CreateMerra2Dataset03Report
% This function will create a report detailing the purpose and capabilities
% of the Aerosol Diagnostics Product for the Merra2 Program
% for the Merra2 Program
% Written By: Stephen Forczyk
% Created: Nov 14,2023
% Revised: 
%
% Classification: Unclassified
global Merra2Dataset03Variables Merra2Dataset03Hdrs;

global minTauValue PressureLevel42 PressureLevel72 iPress42 iPress72;
global PressureLevelUsed PressureLabels42 PressureLabels72 framecounter;
global TimeSlices iTimeSlice numtimeslice;
global Merra2FileName Merra2Dat Merra2ShortFileName numSelectedFiles;

global idebug;
global LatitudesS LongitudesS LevS;
global O3S PSS QVS HS QV2MS SLPS TS T2MS;
global HS01 HS25 HS50 HS75 HS90 HS100 HSLow HSHigh HSNaN;
global O3S01 O3S25 O3S50 O3S75 O3S90 O3S100 O3SLow O3SHigh O3SNaN;

global PSS01 PSS25 PSS50 PSS75 PSS90 PSS100 PSSLow PSSHigh PSSNaN;
global QVS01 QVS25 QVS50 QVS75 QVS90 QVS100 QVSLow QVSHigh QVSNaN;
global SLPS01 SLPS25 SLPS50 SLPS75 SLPS90 SLPS100 SLPSLow SLPSHigh SLPSNaN;
global TS01 TS25 TS50 TS75 TS90 TS100 TSLow TSHigh TSNaN;
global US01 US25 US50 US75 US90 US100 USLow USHigh USNaN;
global VS01 VS25 VS50 VS75 VS90 VS100 VSLow VSHigh VSNaN;
global HSValues O3SValues PSSValues QVSValues SLPSValues TSValues;
global USValues VSValues;
global timeS US VS;
global LatitudesS LongitudesS ;
global YearMonthDayStr1 YearMonthDayStr2;
global ChoiceList;
global PascalsToMilliBars PascalsToPsi;
global PSTable PSTT;
global SLPTable SLPTT;


global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;

global matpath datapath;
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;

global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
% additional paths needed for mapping
global pdfpath govjpegpath;

global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;
global pwd;

import mlreportgen.dom.*;
import mlreportgen.report.*;
import mlreportgen.utils.*
%% Build some tables
% Start with the Hourly data but break this up into 2 tables because of the
% length

Merra2Dataset03Variables=cell(12,5);
Merra2Dataset03Hdrs=cell(1,5);
Merra2Dataset03Hdrs{1,1}='List Number';
Merra2Dataset03Hdrs{1,2}='Short Name';
Merra2Dataset03Hdrs{1,3}='Description';
Merra2Dataset03Hdrs{1,4}='Units';
Merra2Dataset03Hdrs{1,5}='Type';
Merra2Dataset03Variables{1,1}='1';
Merra2Dataset03Variables{1,2}='HS';
Merra2Dataset03Variables{1,3}='Geopotential Height';
Merra2Dataset03Variables{1,4}='meters';
Merra2Dataset03Variables{1,5}='Geo2D';
Merra2Dataset03Variables{2,1}='2';
Merra2Dataset03Variables{2,2}='LatitudesS';
Merra2Dataset03Variables{2,3}='latitude';
Merra2Dataset03Variables{2,4}='deg';
Merra2Dataset03Variables{2,5}='1-D';
Merra2Dataset03Variables{3,1}='3';
Merra2Dataset03Variables{3,2}='LevS';
Merra2Dataset03Variables{3,3}='altitude level';
Merra2Dataset03Variables{3,4}='-';
Merra2Dataset03Variables{3,5}='1-D';
Merra2Dataset03Variables{4,1}='4';
Merra2Dataset03Variables{4,2}='LongitudeS';
Merra2Dataset03Variables{4,3}='longitude';
Merra2Dataset03Variables{4,4}='deg';
Merra2Dataset03Variables{4,5}='1-D';
Merra2Dataset03Variables{5,1}='5';
Merra2Dataset03Variables{5,2}='O3S';
Merra2Dataset03Variables{5,3}='Ozone Mixing Ratio';
Merra2Dataset03Variables{5,4}='kg/kg';
Merra2Dataset03Variables{5,5}='Geo2D';
Merra2Dataset03Variables{6,1}='6';
Merra2Dataset03Variables{6,2}='PSS';
Merra2Dataset03Variables{6,3}='Surface Pressure';
Merra2Dataset03Variables{6,4}='Pa';
Merra2Dataset03Variables{6,5}='Geo2D';
Merra2Dataset03Variables{7,1}='7';
Merra2Dataset03Variables{7,2}='QVS';
Merra2Dataset03Variables{7,3}='Specific Humidity';
Merra2Dataset03Variables{7,4}='Kg/Kg';
Merra2Dataset03Variables{7,5}='Geo2D';
Merra2Dataset03Variables{8,1}='8';
Merra2Dataset03Variables{8,2}='SLPS';
Merra2Dataset03Variables{8,3}='Sea Level Pressure';
Merra2Dataset03Variables{8,4}='Pa';
Merra2Dataset03Variables{8,5}='Geo2D';
Merra2Dataset03Variables{9,1}='9';
Merra2Dataset03Variables{9,2}='TS';
Merra2Dataset03Variables{9,3}='Air Temp';
Merra2Dataset03Variables{9,4}='Deg-K';
Merra2Dataset03Variables{9,5}='Geo2D';
Merra2Dataset03Variables{10,1}='10';
Merra2Dataset03Variables{10,2}='timeS';
Merra2Dataset03Variables{10,3}='Time';
Merra2Dataset03Variables{10,4}='minutes since GMT 00 hrs';
Merra2Dataset03Variables{10,5}='Geo2D';
Merra2Dataset03Variables{11,1}='11';
Merra2Dataset03Variables{11,2}='US';
Merra2Dataset03Variables{11,3}='East Wards Wind Component';
Merra2Dataset03Variables{11,4}='m/s';
Merra2Dataset03Variables{11,5}='Geo2D';
Merra2Dataset03Variables{12,1}='11';
Merra2Dataset03Variables{12,2}='US';
Merra2Dataset03Variables{12,3}='North Wards Wind Component';
Merra2Dataset03Variables{12,4}='m/s';
Merra2Dataset03Variables{12,5}='Geo2D';


% Set some flags




%% Create New Chapter with Information Specific to 
    chapter = Chapter("Title", "Merra-2 Instantaneous Pressure Level Data");
    chapter.Layout.Landscape = true;
    add(chapter,Section('M2IUNPANA Dataset'));
    br = PageBreak();
    parastr1='This section is designed to provide info on the M2IUNPANA dataset available as an output product from Merra 2.';
    parastr2=' The M2IUNPANA is defined as a 3D monthly diurnal pressure level analysis.'; 
    parastr3=' Specifically, the data is averaged hourly over a period of 1 month and each of 42 atmospheric pressure levels.';
    parastr4=' Each months data is average at 0,6,12,and 18 hours GMT .';
    parastr5=' Only  8 variables are reported on for this dataset at one of more pressure levels';
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    parastr31='The pressure levels go from the lowest altitude at level 1 (sea level)  to the highest at about 60 km .';
    parastr32=' A file holds data for a standard atmosphere which relates the model pressure levels to atmospheric pressure.';
    parastr33=' Of the 8 variables reported on by pressure level,6 are reported at 42 pressure levels.'; 
    parastr34=' The remaining 2 are provided only at one level-this is the surface pressure and the sea level pressure.';
    parastr39=strcat(parastr31,parastr32,parastr33,parastr34);
    p4 = Paragraph(parastr39);
    p4.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p4);
% Show an Example of the atmospheric pressure levels
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    imdata = imread('StandardAtmosphere-PressureVsDensity.jpg');
    [nhigh,nwid,~]=size(imdata);
    nhigh2=floor(nhigh/2.1);
    nwid2=floor(nwid/2.1);
    image = mlreportgen.report.FormalImage();
    image.Image = which('StandardAtmosphere-PressureVsDensity.jpg');
    text = Text('Standard Atmosphere');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh2),'px');
    widthstr=strcat(num2str(nwid2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    image1=image;
    add(chapter,image); 
    parastr51='The plot above shows the pressure in Pa on the x axis over the 42 levels used in the Merra2 data accumilation.';
    parastr52=' A double y axis was used to plot two separate atmospheric quantities.';
    parastr53=' On the left side of the chart shown in blue is the height of the corresponding level in km.';
    parastr54=' Correspondingly,the right side of the chart depicts the atmospheric density in red.';
    parastr55=' Level 1 is the lowest level and 42 is the highest altitude band.';
    parastr59=strcat(parastr51,parastr52,parastr53,parastr54,parastr55);
    p5 = Paragraph(parastr59);
    p5.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p5);
    add(chapter,br);
% Show an Geopotential Height
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    imdata = imread('GeopotentialHeight.jpg');
    [nhigh,nwid,~]=size(imdata);
    nhigh2=floor(nhigh/2.1);
    nwid2=floor(nwid/2.1);
    image = mlreportgen.report.FormalImage();
    image.Image = which('GeopotentialHeight.jpg');
    text = Text('Example Geopotential Height Contours');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh2),'px');
    widthstr=strcat(num2str(nwid2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    image2=image;
    add(chapter,image); 
    parastr61='Geopotential Height is an important concept in weather models and a such was included in this dataset.';
    parastr62=' Downloaded data is for 42 pressure levels-the example chart here is to the 500 mBar level.';
    parastr63=' Geopotential height is related to but does not equal actual geometric height.';
    parastr64=' This difference stems from the fact that the earth gravity is not equal everywhere.';
    parastr65=' The biggest difference is caused by the fact that the radius of the earth varies with latitude.';
    parastr66=' The radius of the earth at the poles is less than at the equator so gravity is stronger near the poles.';
    parastr67=' In a general way,higher geopotential correlated to higher surafce pressure and lower potential relates to low pressure cells.';
    parastr68=' Thus it can be expected that higher geopotential height is associated with better weather.';
    parastr69=strcat(parastr61,parastr62,parastr63,parastr64,parastr65,parastr66,parastr67,parastr68);
    p7 = Paragraph(parastr69);
    p7.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p7);
    add(chapter,br);

% Ozone Mixing Ratio
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    imdata = imread('OzoneLayer.jpg');
    [nhigh,nwid,~]=size(imdata);
    nhigh2=floor(nhigh/2.1);
    nwid2=floor(nwid/2.1);
    image = mlreportgen.report.FormalImage();
    image.Image = which('OzoneLayer.jpg');
    text = Text('Ozone Layer Overview');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh2),'px');
    widthstr=strcat(num2str(nwid2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    image2=image;
    add(chapter,image); 
    parastr71='The Ozone layer density has been reduced in density in the 20th century by certain chemicals.';
    parastr72=' International treaties were made to restrict the use of these gasses to reverse this situation.';
    parastr73=' The ozone to oxygen ratio varies with height and the region with higher ozone is called the ozone layer.';
    parastr74=' There are typicallly about 40 O3 molecules per billion O2 molecules ,this is the mixing ratio.';
    parastr75=' For modelling purposes, it is customary to express this as a ratio of kg ozone/kg of O2.';
    parastr76=' Accordingly, the Merra 2 data for this quantity is reported in units of kg/kg.';
    parastr77=' If there is an ozone hole this can be seen from this dataset.';
    parastr79=strcat(parastr71,parastr72,parastr73,parastr74,parastr75,parastr76,parastr77);
    p8 = Paragraph(parastr79);
    p8.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p8);
    add(chapter,br);
    

%% Start a new section that describes the specific data set used
%     add(chapter,Section('Aerosol Diagnostics Information'));
%     parastr201='This section describes the specific data files used to perform the Aerosol diagnostics.';
%     parastr202=' All the files in this group cover a 1 day time period with 24 time slices at hourly frequency.'; 
%     parastr203=' These are relatively large files at about 756 MBytes per file.';
%     parastr204=' Below this paragraph is a screenshot of the landing page for this data set which provides some very useful information .';
%     parastr205=' At the very top of this landing page the text reveals that this is hourly time averaged data.';
%     parastr206=' In addition this is 2D data,namely lat and lon values specified by the grid and the adg text reveals this is an aerosol diagnostic file.';
%     parastr207=' Spatial and temporal resolution data is provided at the very bottom of the page.';
%     parastr21=strcat(parastr201,parastr202,parastr203,parastr204,parastr205,parastr206,parastr207);
%     p21 = Paragraph(parastr21);
%     p21.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p21);
    %% Add a Jpeg of the Landing page
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('AerosolDiagnosticsLandingPage.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('AerosolDiagnosticsLandingPage.jpg');
%     text = Text('Basic Info On Aerosol Diagnostics File');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr221='The figure above is a screen grab of the Aerosol Diagnostics File Landing Page.';
%     parastr222=' Page URL is https://disc.gsfc.nasa.gov/api/jobs/results/64bd4588dc82ce856f8360d9.';
%     parastr223=' The most important function of the landing page is to allow the user to download the desird datasets.';
%     parastr224=' A series of images will display to techniques for doing this.';
%     parastr22=strcat(parastr221,parastr222,parastr223,parastr224);
%     p22 = Paragraph(parastr22);
%     p22.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p22);
%     add(chapter,br);
%% Add a Jpeg showing the File Dialog Box
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('DataAccessDialogBox.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('DataAccessDialogBox.jpg');
%     text = Text('File selection For Download');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr231='The dialog box to select files for download is shown in this graphic.';
%     parastr232=' It is actually on the right side of the landing page but was cropped out in the landing page image for clarity.';
%     parastr233=' With this dialog the user can select which files can be downloaded and the method to be used.';
%     parastr234=' In the example case shown the entire file is downloaded but the user can download a much smaller version of the file with fewer variables.';
%     parastr235=' To get the process started the user can click on the very bottom of the box where is labelled="subset get data".';
%     parastr23=strcat(parastr231,parastr232,parastr233,parastr234,parastr235);
%     p23 = Paragraph(parastr23);
%     p23.Style = {OuterMargin("0pt", "0pt","10pt","50pt")};
%     add(chapter,p23);
%     add(chapter,br);

   %% Add a Jpeg showing File Selection
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('DataAccessPt1.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('DataAccessPt1.jpg');
%     text = Text('Initial File Selection');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr241='After pressing the subset get data tab in from the previous image the next screen appears.';
%     parastr242=' A calender like dialog appears and the user selects 31 files for the month of Jul 2022.';
%     parastr243=' Before the download can begin the user must press the green get data button on the lower right side of the box.';
%     parastr244=' This example shows that Jul 2022 was selected but in the next chart the user changed this to Aug 2022.';
%     parastr245=' This process can be time consuming so it is good practice to select no more than 1 or 2 months worth of data at a time.';
%     parastr24=strcat(parastr241,parastr242,parastr243,parastr244,parastr245);
%     p24 = Paragraph(parastr24);
%     p24.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p24);
%     add(chapter,br);
 %% Add a Jpeg showing File Selection for Jul 2022
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('DataAccessPt2.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('DataAccessPt2.jpg');
%     text = Text('Initial File Selection');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr251='After pressing the subset get data tab in from the previous image the next screen appears.';
%     parastr252=' A calender like dialog appears and this time the user selects 31 files for the month of Aug 2022.';
%     parastr25=strcat(parastr251,parastr252);
%     p25 = Paragraph(parastr25);
%     p25.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p25);
%     add(chapter,br);
  %% Add a Jpeg showing Manual File Download
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('DataAccessPt3.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('DataAccessPt3.jpg');
%     text = Text('HTTP Manual Download');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr261='A user can manually download the selected files one at a time using manual pointing and clicking.';
%     parastr262=' Multiple files can be downloaded if the user clicks one file at a time after a few seconds wait.';
%     parastr263=' Selecting more than 10 files for download at one time starts to increase the time required so it is best to do this in 3-6 batches.';
%     parastr264=' This method works although it requires more user intervention-time to download 30 files in this fashion will be aboue 1 hour.';
%     parastr26=strcat(parastr261,parastr262,parastr263,parastr264);
%     p26 = Paragraph(parastr26);
%     p26.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p26);
%     add(chapter,br);
  %% Add a Jpeg showing Wget File Download
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('DataAccessPt4.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('DataAccessPt4.jpg');
%     text = Text('HTTP Scripted Download');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr271='Another convenient method to download files it to use the wget function from the command line.';
%     parastr272=' The chart above is essential the one shown in the preceeding graphic except the users cursor is set to hover over the download instructions .';
%     parastr273=' If the user selects option 2 a list of url links will be generated in a simple text file.';
%     parastr274=' This list can be inserted into a wget command line and the download will proceed through the list of links one by one.';
%     parastr275=' All the user need do is save this into a simple text file and ingest into into wget.';
%     parastr27=strcat(parastr271,parastr272,parastr273,parastr274,parastr275);
%     p27 = Paragraph(parastr27);
%     p27.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p27);
%     add(chapter,br);
 %% Add a Jpeg showing Wget URL links file
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('DataAccessLinks.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('DataAccessLinks.jpg');
%     text = Text('URL File Links');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr281='This graphic shows the list of file links that are created when option 2 is selected.';
%     parastr282=' The readme file is unneeded and can be edited out-just save this file with a simple name and the wget command will be executed in the command line .';
%     parastr28=strcat(parastr281,parastr282);
%     p28 = Paragraph(parastr28);
%     p28.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p28);
%     add(chapter,br);
%% Add a Jpeg showing Wget command to download the data
%     eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
%     imdata = imread('wget_example.jpg');
%     [nhigh,nwid,~]=size(imdata);
%     nhigh2=floor(nhigh/1.2);
%     nwid2=floor(nwid/1.2);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('wget_example.jpg');
%     text = Text('Download with wget');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh2),'px');
%     widthstr=strcat(num2str(nwid2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr291='This is a screen shot in the command line using the wget command to download the data.';
%     parastr292=' The command fits on 1 line-wget is called the http protocal will be used the user login credentials are read in .';
%     parastr293=' Once this is accomplished the file MT21NXADG_Aug2022_.txt is read in to process each download link one at a time.';
%     parastr29=strcat(parastr291,parastr292,parastr293);
%     p29 = Paragraph(parastr29);
%     p29.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p29);
%     add(chapter,br);

%% Add another section to Chapter 2 on Aerosol Diagnostic Files
%     add(chapter,Section('Merra-2 Aerosol Diagnostic Files'));
%     parastr51='This section will provide some details on the Aerosol Diagnostic Files.';
%     parastr52=' A typical file name in this series is "Merra2_100.tavg1_2d_adg_Nx.19800101".';
%     parastr53=' The 100 series means that this was in the time period of the first data assimulation and later files have numbers up to 400.'; 
%     parastr54=' Tavg1 is a key that tells the user is is time averaged data at 1 hr intervals.';
%     parastr55=' The key 2d means that this data is on a 2 d lat/lon grid and adg means that this is an aerosol diagnostic file.';
%     parastr56=' Nx is another key word that means it is native format 2 d data.';
%     parastr57=' The final 8 digits states that the file is for 1980 month 1 day or Jan1 1980.';
%     parastr58=' The extentsion is netCDF which stands for net Common Data Format which many datasets are written in-this is similar to HDF.';
%     parastr6=strcat(parastr51,parastr52,parastr53,parastr54,parastr55,parastr56,parastr57,parastr58);
%     p6 = Paragraph(parastr6);
%     p6.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p6);
%     parastr61='This particular set of files is quite large averages about 780 MB in size.';
%     parastr62=' Aerosol diagnostic files are so large for two reasons, the large number of variables stored on it is the first .';
%     parastr63=' Secondly there are 117 georeferenced variable with each variable having a dimension of 576 x 361 x 24.'; 
%     parastr64=' The longitude is stored in 576 grid points and the latitude in 361 points and there are 24 time slices in it.';
%     parastr65=' The corresponding latitude limits of +/-90 deg are mapped into 361 points.';
%     parastr66=' In practice this means that the spatial resolution is 0.5 x 0.625 deg.';
%     parastr67=' As such,the grids are equally size in angular measure but not in linear extent.';
%     parastr7=strcat(parastr61,parastr62,parastr63,parastr64,parastr65,parastr66,parastr67);
%     p7 = Paragraph(parastr7);
%     p7.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
%     add(chapter,p7);
% Add Table showing Black Carbon Variables
%     add(chapter,br);
%     T2=[VariableTableHdr;VariableTableBC];
%     tbl2=Table(T2);
%     tbl2.Style = [tbl2.Style {Border('solid','black','3px')}];
%     tbl2.TableEntriesHAlign = 'center';
%     tbl2.HAlign='center';
%     tbl2.ColSep = 'single';
%     tbl2.RowSep = 'single';
%     r = row(tbl2,1);
%     r.Style = [r.Style {Color('red'),Bold(true)}];
%     bt2 = BaseTable(tbl2);
%     tabletitle = Text('Variable List For Black Carbon');
%     tabletitle.Bold = false;
%     bt2.Title = tabletitle;
%     bt2.TableWidth="7in";
%     add(chapter,bt2);
%     parastr201='The table above shows the 14 variables that are stored in the aerosol diagnostic file that are related to Black Carbon.';
%     parastr202=' Column 1 shows he short name for each variable while column 2 provides a brief description of the variable.';
%     parastr203=' The structure of the variable is Geo2d means that it is a 2 dimension georeference variable on the standard Merra2 grid.';
%     parastr204=' All the variables are plotted will be plotted using the same subroutine,ikind is the tag number used by the plot routine.';
%     parastr205=' The final column details whether the variable is a source,or sink for that aerosol species or a chemical process.';
%     parastr206=' Black carbon is he dominant type of light absorbing particulate matter in the atmosphere-it has a life time of about 2 weeks.';
%     parastr207=' As such this aerosol can absorb visible and IR light and thus heat the atmosphere and darken surfaces.';
%     parastr209=strcat(parastr201,parastr202,parastr203,parastr204,parastr205,parastr206,parastr207);
%     p21= Paragraph(parastr209);
%     p21.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
%     add(chapter,p21);

% 
    ab=1;
    add(rpt,chapter);
    ab=2;
end

