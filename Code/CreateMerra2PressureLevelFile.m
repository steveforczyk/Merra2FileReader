% This script will create a file of pressure levels used in the Merra-2
% datasets

% Written By: Stephen Forczyk
% Created: Mar 18,2023
% Revised: -----
% Classification: Public Domain

% Data Source:https://gmao.gsfc.nasa.gov/pubs/docs/Bosilovich785.pdf

global PressureLevel42 PressureLevel72 savepath datapath;
global Merra2PressureDataFile AtmosphereFile;

Merra2PressureDataFile='Merra2ModelPressures.mat';
AtmosphereFile='StandardAtmosphere.mat';

savepath='K:\Merra-2\';
datapath='D:\Goes16\Matlab_Data\';

PressureLevel42=zeros(42,3);
PressureLevel42(1,1)=1;
PressureLevel42(1,2)=1000;
PressureLevel42(2,1)=2;
PressureLevel42(2,2)=975;
PressureLevel42(3,1)=3;
PressureLevel42(3,2)=950;
PressureLevel42(4,1)=4;
PressureLevel42(4,2)=925;
PressureLevel42(5,1)=5;
PressureLevel42(5,2)=900;
PressureLevel42(6,1)=6;
PressureLevel42(6,2)=875;
PressureLevel42(7,1)=7;
PressureLevel42(7,2)=850;
PressureLevel42(8,1)=8;
PressureLevel42(8,2)=825;
PressureLevel42(9,1)=9;
PressureLevel42(9,2)=800;
PressureLevel42(10,1)=10;
PressureLevel42(10,2)=775;
PressureLevel42(11,1)=11;
PressureLevel42(11,2)=750;
PressureLevel42(12,1)=12;
PressureLevel42(12,2)=725;
PressureLevel42(13,1)=13;
PressureLevel42(13,2)=700;
PressureLevel42(14,1)=14;
PressureLevel42(14,2)=650;
PressureLevel42(15,1)=15;
PressureLevel42(15,2)=600;
PressureLevel42(16,1)=16;
PressureLevel42(16,2)=550;
PressureLevel42(17,1)=17;
PressureLevel42(17,2)=500;
PressureLevel42(18,1)=18;
PressureLevel42(18,2)=450;
PressureLevel42(19,1)=19;
PressureLevel42(19,2)=400;
PressureLevel42(20,1)=20;
PressureLevel42(20,2)=350;
PressureLevel42(21,1)=21;
PressureLevel42(21,2)=300;
PressureLevel42(22,1)=22;
PressureLevel42(22,2)=250;
PressureLevel42(23,1)=23;
PressureLevel42(23,2)=200;
PressureLevel42(24,1)=24;
PressureLevel42(24,2)=150;
PressureLevel42(25,1)=25;
PressureLevel42(25,2)=100;
PressureLevel42(26,1)=26;
PressureLevel42(26,2)=70;
PressureLevel42(27,1)=27;
PressureLevel42(27,2)=50;
PressureLevel42(28,1)=28;
PressureLevel42(28,2)=40;
PressureLevel42(29,1)=29;
PressureLevel42(29,2)=30;
PressureLevel42(30,1)=30;
PressureLevel42(30,2)=20;
PressureLevel42(31,1)=31;
PressureLevel42(31,2)=10;
PressureLevel42(32,1)=32;
PressureLevel42(32,2)=7;
PressureLevel42(33,1)=33;
PressureLevel42(33,2)=5;
PressureLevel42(34,1)=34;
PressureLevel42(34,2)=4;
PressureLevel42(35,1)=35;
PressureLevel42(35,2)=3;
PressureLevel42(36,1)=36;
PressureLevel42(36,2)=2;
PressureLevel42(37,1)=37;
PressureLevel42(37,2)=1;
PressureLevel42(38,1)=38;
PressureLevel42(38,2)=0.7;
PressureLevel42(39,1)=39;
PressureLevel42(39,2)=0.5;
PressureLevel42(40,1)=40;
PressureLevel42(40,2)=0.4;
PressureLevel42(41,1)=41;
PressureLevel42(41,2)=0.3;
PressureLevel42(42,1)=42;
PressureLevel42(42,2)=0.1;
PressureLevel72=zeros(72,3);
PressureLevel72(1,1)=1;
PressureLevel72(1,2)=0.01;
PressureLevel72(2,1)=2;
PressureLevel72(2,2)=0.02;
PressureLevel72(3,1)=3;
PressureLevel72(3,2)=0.0327;
PressureLevel72(4,1)=4;
PressureLevel72(4,2)=0.0476;
PressureLevel72(5,1)=5;
PressureLevel72(5,2)=0.0660;
PressureLevel72(6,1)=6;
PressureLevel72(6,2)=0.0893;
PressureLevel72(7,1)=7;
PressureLevel72(7,2)=0.1197;
PressureLevel72(8,1)=8;
PressureLevel72(8,2)=0.1595;
PressureLevel72(9,1)=9;
PressureLevel72(9,2)=0.2113;
PressureLevel72(10,1)=10;
PressureLevel72(10,2)=0.2785;
PressureLevel72(11,1)=11;
PressureLevel72(11,2)=0.3650;
PressureLevel72(12,1)=12;
PressureLevel72(12,2)=0.4758;
PressureLevel72(13,1)=13;
PressureLevel72(13,2)=0.6168;
PressureLevel72(14,1)=14;
PressureLevel72(14,2)=0.7951;
PressureLevel72(15,1)=15;
PressureLevel72(15,2)=1.0194;
PressureLevel72(16,1)=16;
PressureLevel72(16,2)=1.3005;
PressureLevel72(17,1)=17;
PressureLevel72(17,2)=1.6508;
PressureLevel72(18,1)=18;
PressureLevel72(18,2)=2.0850;
PressureLevel72(19,1)=19;
PressureLevel72(19,2)=2.6202;
PressureLevel72(20,1)=20;
PressureLevel72(20,2)=3.2764;
PressureLevel72(21,1)=21;
PressureLevel72(21,2)=4.0766;
PressureLevel72(22,1)=22;
PressureLevel72(22,2)=5.0468;
PressureLevel72(23,1)=23;
PressureLevel72(23,2)=6.2168;
PressureLevel72(24,1)=24;
PressureLevel72(24,2)=7.6198;
PressureLevel72(25,1)=25;
PressureLevel72(25,2)=9.2929;
PressureLevel72(26,1)=26;
PressureLevel72(26,2)=11.2769;
PressureLevel72(27,1)=27;
PressureLevel72(27,2)=13.6434;
PressureLevel72(28,1)=28;
PressureLevel72(28,2)=16.4571;
PressureLevel72(29,1)=29;
PressureLevel72(29,2)=19.7916;
PressureLevel72(30,1)=30;
PressureLevel72(30,2)=23.7304;
PressureLevel72(31,1)=31;
PressureLevel72(31,2)=28.3678;
PressureLevel72(32,1)=32;
PressureLevel72(32,2)=33.8100;
PressureLevel72(33,1)=33;
PressureLevel72(33,2)=40.1754;
PressureLevel72(34,1)=34;
PressureLevel72(34,2)=47.6439;
PressureLevel72(35,1)=35;
PressureLevel72(35,2)=56.3879;
PressureLevel72(36,1)=36;
PressureLevel72(36,2)=66.6034;
PressureLevel72(37,1)=37;
PressureLevel72(37,2)=78.5123;
PressureLevel72(38,1)=38;
PressureLevel72(38,2)=92.3657;
PressureLevel72(39,1)=39;
PressureLevel72(39,2)=108.663;
PressureLevel72(40,1)=40;
PressureLevel72(40,2)=127.837;
PressureLevel72(41,1)=41;
PressureLevel72(41,2)=150.393;
PressureLevel72(42,1)=42;
PressureLevel72(42,2)=176.930;
PressureLevel72(43,1)=43;
PressureLevel72(43,2)=208.152;
PressureLevel72(44,1)=44;
PressureLevel72(44,2)=244.875;
PressureLevel72(45,1)=45;
PressureLevel72(45,2)=288.083;
PressureLevel72(46,1)=46;
PressureLevel72(46,2)=337.500;
PressureLevel72(47,1)=47;
PressureLevel72(47,2)=375.000;
PressureLevel72(48,1)=48;
PressureLevel72(48,2)=412.500;
PressureLevel72(49,1)=49;
PressureLevel72(49,2)=450.000;
PressureLevel72(50,1)=50;
PressureLevel72(50,2)=487.500;
PressureLevel72(51,1)=51;
PressureLevel72(51,2)=525.000;
PressureLevel72(52,1)=52;
PressureLevel72(52,2)=562.500;
PressureLevel72(53,1)=53;
PressureLevel72(53,2)=600.000;
PressureLevel72(54,1)=54;
PressureLevel72(54,2)=637.500;
PressureLevel72(55,1)=55;
PressureLevel72(55,2)=675.000;
PressureLevel72(56,1)=56;
PressureLevel72(56,2)=700.000;
PressureLevel72(57,1)=57;
PressureLevel72(57,2)=725.000;
PressureLevel72(58,1)=58;
PressureLevel72(58,2)=750.000;
PressureLevel72(59,1)=59;
PressureLevel72(59,2)=775.000;
PressureLevel72(60,1)=60;
PressureLevel72(60,2)=800.000;
PressureLevel72(61,1)=61;
PressureLevel72(61,2)=820.000;
PressureLevel72(62,1)=62;
PressureLevel72(62,2)=835.000;
PressureLevel72(63,1)=63;
PressureLevel72(63,2)=850.000;
PressureLevel72(64,1)=64;
PressureLevel72(64,2)=865.000;
PressureLevel72(65,1)=65;
PressureLevel72(65,2)=880.000;
PressureLevel72(66,1)=66;
PressureLevel72(66,2)=895.000;
PressureLevel72(67,1)=67;
PressureLevel72(67,2)=910.000;
PressureLevel72(68,1)=68;
PressureLevel72(68,2)=925.000;
PressureLevel72(69,1)=69;
PressureLevel72(69,2)=940.000;
PressureLevel72(70,1)=70;
PressureLevel72(70,2)=955.000;
PressureLevel72(71,1)=71;
PressureLevel72(71,2)=970.000;
PressureLevel72(72,1)=72;
PressureLevel72(72,2)=985.000;
% Load in the standard atmosphere data to calulate a rough equivalence
% between atmospheric pressure and altitude in km
eval(['cd ' datapath(1:length(datapath)-1)]);
load(AtmosphereFile,'PhPA','rho','zPress');
zPressKm=zPress/1000;
% Now interpolate the data
for n=1:42
    xq=PressureLevel42(n,2);
    vq = interp1(PhPA,zPressKm,xq,'spline');
    PressureLevel42(n,3)=vq;
end
plot(zPressKm,PhPA,'b');
hold on
plot(PressureLevel42(:,3),PressureLevel42(:,2),'r+');
pause(5)
close('all')
for n=1:72
    xq=PressureLevel72(n,2);
    vq = interp1(PhPA,zPressKm,xq,'spline');
    PressureLevel72(n,3)=vq;
end
plot(zPressKm,PhPA,'b');
hold on
plot(PressureLevel72(:,3),PressureLevel72(:,2),'r+');
ab=1;

% Now fit the 42 level data 
[height2,hof] = fit(zPressKm,PhPA,'smoothingspline');
% plot(height,zPressKm,PhPA);
ab=1;
% s = fitoptions('Method','NonlinearLeastSquares',...
%                'Lower',[0,0],...
%                'Upper',[Inf,max(zPressKm)],...
%                'Startpoint',[1 1]);
% f = fittype('a*(x-b)^n','problem','n','options',s);
% [height2,ht2] = fit(zPressKm,PhPA,f,'problem',2);
ab=2;
plot(zPressKm,PhPA,'b');
hold on
plot(height2,'r');

ab=1;
%Now Save the Results
eval(['cd ' savepath(1:length(savepath)-1)]);
save Merra2PressureDataFile PressureLevel42 PressureLevel72




