% This script will inventory the data files available to find missing files
% This was written as dwnloads of weather data using wget show many missing
% entries
% Written By: Stephen Forczyk
% Created: Jan 31,2024
% Revised:  -------
% Classification: Public Domain/Unclassified


global datapath;
datapath='K:\Merra-2\netCDF\Dataset04\Data\';
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
% Set up parameters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;
idirector=1;
initialtimestr=datestr(now);

%% Make the initial inventory
eval(['cd ' datapath(1:length(datapath)-1)]);
suffix='.nc4';
topDir=datapath;
[ FileList ] = getfilelist( topDir, suffix, 0);
numfiles=length(FileList);

%% now create a new cell that has the filename,year,month,day,and julian day info and gap
FileJulianDates=cell(numfiles,6);
ab=1;
format longG;
diff=1;
for i=1:numfiles
    nowFile=char(FileList{i,1});
    strlen=length(nowFile);
    [islash]=strfind(nowFile,'\');
    numslash=length(islash);
    is=islash(5)+1;
    ie=strlen;
    shortFile=nowFile(is:ie);
    [ipos]=strfind(nowFile,'.nc4');
    is=(ipos(1)-8);
    ie=is+7;
    dstr=nowFile(is:ie);
    yrstr=dstr(1:4);
    monthstr=dstr(5:6);
    daystr=dstr(7:8);

    tstring=strcat(yrstr,'-',monthstr,'-',daystr,' 00:00:00.0');
    t1 = datetime(tstring);
    jd2=juliandate(t1);
    if(i==1)
        jd1=jd2-1;
        FileJulianDates{i,1}=shortFile;
        FileJulianDates{i,2}=str2double(yrstr);
        FileJulianDates{i,3}=str2double(monthstr);
        FileJulianDates{i,4}=str2double(daystr);
        str_f = sprintf('%0.2f',jd2);
        FileJulianDates{i,5}=str_f;
        FileJulianDates{i,6}=jd2-jd1;
        jd1=jd2;
    else
        FileJulianDates{i,1}=shortFile;
        FileJulianDates{i,2}=str2double(yrstr);
        FileJulianDates{i,3}=str2double(monthstr);
        FileJulianDates{i,4}=str2double(daystr);
        str_f = sprintf('%0.2f',jd2);
        FileJulianDates{i,5}=str_f;
        FileJulianDates{i,6}=jd2-jd1;
        jd1=jd2;
    end

    end
    ab=1;

