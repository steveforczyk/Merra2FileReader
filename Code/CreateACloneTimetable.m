% Create a new time table from an existing timetable for an existing run
% This is just a test to set up separate monthly TimeTables from an
% existing set of yearly tables
%
% Written By: Stepehn Forczyk
% Created: April 1,2024
% Revised:-------
% Classification: Unclassified/Public Domain

global tablepath tablename newtablename;
global AlbedoJanTT AlbedoFebTT AlbedoMarTT AlbedoAprTT;
global AlbedoMayTT AlbedoJunTT AlbedoJulTT AlbedoAugTT;
global AlbedoSepTT AlbedoOctT AlbedoNovTT AlbedoDecTT;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog ;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
tablename='AlbedoTable200412.mat';
newtablename='AlbedoTableJan2004.mat';
tablepath=' K:\Merra-2\netCDF\Dataset08\Tables\';

% Set up some data for creating plots
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
eval(['cd ' tablepath(1:length(tablepath)-1)]);
load(tablename);
[nrows,ncols]=size(AlbedoTT);
%% Build the January only table
AlbedoJanTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Jan');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoJanTT(ToDelete,:)=[];
clear ToDelete;
disp('Created Jan Only Albedo Table')
AlbedoJanTT
%% Build the Feb only table
AlbedoFebTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Feb');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoFebTT(ToDelete,:)=[];
clear ToDelete
disp('Created Feb Only Albedo Table')
AlbedoFebTT
%% Build the Mar only table
AlbedoMarTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Mar');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoMarTT(ToDelete,:)=[];
clear ToDelete
disp('Created Mar Only Albedo Table')
AlbedoMarTT
%% Build the Apr only table
AlbedoAprTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Apr');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoAprTT(ToDelete,:)=[];
clear ToDelete
disp('Created Apr Only Albedo Table')
AlbedoAprTT
%% Build the May only table
AlbedoMayTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'May');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoMayTT(ToDelete,:)=[];
clear ToDelete
disp('Created May Only Albedo Table')
AlbedoMayTT

%% Build the June only table
AlbedoJunTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Jun');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoJunTT(ToDelete,:)=[];
clear ToDelete
disp('Created Jun Only Albedo Table')
AlbedoJunTT
%% Build the Jul only table
AlbedoJulTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Jul');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoJulTT(ToDelete,:)=[];
clear ToDelete
disp('Created Jul Only Albedo Table')
AlbedoJulTT
%% Build the Aug only table
AlbedoAugTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Aug');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoAugTT(ToDelete,:)=[];
clear ToDelete
disp('Created Aug Only Albedo Table')
AlbedoAugTT
%% Build the Sep only table
AlbedoSepTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Sep');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoSepTT(ToDelete,:)=[];
clear ToDelete
disp('Created Sep Only Albedo Table')
AlbedoSepTT
%% Build the Oct only table
AlbedoOctTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Oct');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoOctTT(ToDelete,:)=[];
clear ToDelete
disp('Created Oct Only Albedo Table')
AlbedoOctTT
%% Build the Nov only table
AlbedoNovTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Nov');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoNovTT(ToDelete,:)=[];
clear ToDelete
disp('Created Nov Only Albedo Table')
AlbedoNovTT
%% Build the Dec only table
AlbedoDecTT=AlbedoTT;
ik=0;
for n=1:nrows
    timestr=char(AlbedoTT.Time(n,1));
    tf=contains(timestr,'Dec');
    if(tf==0)
        ik=ik+1;
        ToDelete(ik,1)=n;
    end
end
ToDelete=ToDelete';
AlbedoDecTT(ToDelete,:)=[];
clear ToDelete
disp('Created Dec Only Albedo Table')
AlbedoDecTT
%% Try a test plot on the January Data
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
titlestr='JanAlbedoData';
plot(AlbedoJanTT.Time,AlbedoJanTT.Albedo50,'b',AlbedoJanTT.Time,AlbedoJanTT.Albedo90,'r');
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
hl=legend('Albedo 50 ptile','Albedo 90 ptile');
ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
ylabelstr='Albedo';
ylabel('Albedo','FontWeight','bold','FontSize',12);
ab=1;

