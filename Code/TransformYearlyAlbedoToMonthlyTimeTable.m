function  TransformYearlyAlbedoToMonthlyTimeTable
% This function will take a year Albedo Table and recrete it as 12 monthly
% timetables. % This will done to search for monthly trends
% 
% Written By Stephen Forczyk;
% Created: April 1,2024
% Revised: -----
% Classification: Unclassified Public Domain

global tablepath tablename newtablename;
global AlbedoTable AlbedoTT;
global AlbedoJanTT AlbedoFebTT AlbedoMarTT AlbedoAprTT;
global AlbedoMayTT AlbedoJunTT AlbedoJulTT AlbedoAugTT;
global AlbedoSepTT AlbedoOctTT AlbedoNovTT AlbedoDecTT;

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
%AlbedoJanTT
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
%AlbedoFebTT
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
%AlbedoMarTT
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
%AlbedoAprTT
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
%AlbedoMayTT

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
%AlbedoJunTT
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
%AlbedoJulTT
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
%AlbedoAugTT
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
%AlbedoSepTT
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
%AlbedoOctTT
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
%AlbedoNovTT
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
%AlbedoDecTT
end