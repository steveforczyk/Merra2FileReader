% Create a Matlab file to store Antarctic Bases
% Purpose of this script it to create a file of antarctic bases
% for maps. Stored as points-list in not exhaustive but focusses on larger
% bases
% Written By: Stephen Forczyk
% Created: Fabe 20,2024
% Revised: -----
% Classification: Unclassified/Public Domain

global BaseNames BaseLats BaseLons BaseType BasePop BaseCountry;
global sourceURL;
global matlabpath

matlabpath='K:\Merra-2\Matlab_Data\';

BaseNames=cell(12,1);
BaseLats=zeros(12,1);
BaseLons=zeros(12,1);
BaseType=cell(12,1);
BasePop=zeros(12,1);
BaseCountry=cell(12,1);
sourceURL='https://www.add.scar.org/';
% Store a list of base names
BaseNames{1,1}='Amundsen';
BaseNames{2,1}='McMurdo';
BaseNames{3,1}='Vostok';
BaseNames{4,1}='Russkaya';
BaseNames{5,1}='Wasa';
BaseNames{6,1}='Jang Bogo';
BaseNames{7,1}='Mirny';
BaseNames{8,1}='Davis';
BaseNames{9,1}='Casey';
BaseNames{10,1}='Artigas';
BaseNames{11,1}='Petrel';
BaseNames{12,1}='Morambio';
% Store a List of Base Lats
BaseLats(1,1)=-89.9975;
BaseLats(2,1)=-77.8494;
BaseLats(3,1)=-78.4642;
BaseLats(4,1)=-74.7657;
BaseLats(5,1)=-73.0423;
BaseLats(6,1)=-74.6355;
BaseLats(7,1)=-66.5522;
BaseLats(8,1)=-68.5759;
BaseLats(9,1)=-66.2823;
BaseLats(10,1)=-62.1846;
BaseLats(11,1)=-63.3210;
BaseLats(12,1)=-64.2418;
% Store a List of Base Lons
BaseLons(1,1)=19.2728;
BaseLons(2,1)=166.7673;
BaseLons(3,1)=106.8369;
BaseLons(4,1)=-136.8001;
BaseLons(5,1)=-13.4074;
BaseLons(6,1)=164.2212;
BaseLons(7,1)=93.0096;
BaseLons(8,1)=77.9695;
BaseLons(9,1)=110.5268;
BaseLons(10,1)=-58.9024;
BaseLons(11,1)=-57.8998;
BaseLons(12,1)=-56.6266;
% Store a List of Base Type (Year Round/Seasonal)
BaseType{1,1}='Year Round';
BaseType{2,1}='Year Round';
BaseType{3,1}='Year Round';
BaseType{4,1}='Year Round';
BaseType{5,1}='Seasonal';
BaseType{6,1}='Seasonal';
BaseType{7,1}='Year Round';
BaseType{8,1}='Year Round';
BaseType{9,1}='Year Round';
BaseType{10,1}='Year Round';
BaseType{11,1}='Year Round';
BaseType{12,1}='Year Round';
% Store a List Of Max Base Population
BasePop(1,1)=153;
BasePop(2,1)=86;
BasePop(3,1)=30;
BasePop(4,1)=10;
BasePop(5,1)=17;
BasePop(6,1)=20;
BasePop(7,1)=50;
BasePop(8,1)=91;
BasePop(9,1)=99;
BasePop(10,1)=60;
BasePop(11,1)=60;
BasePop(12,1)=165;
% Store A List Of BaseCountries
BaseCountry{1,1}='USA';
BaseCountry{2,1}='NZ';
BaseCountry{3,1}='RFR';
BaseCountry{4,1}='RFR';
BaseCountry{5,1}='FIN';
BaseCountry{6,1}='GER';
BaseCountry{7,1}='RFR';
BaseCountry{8,1}='Aus';
BaseCountry{9,1}='Aus';
BaseCountry{10,1}='URG';
BaseCountry{11,1}='CHI';
BaseCountry{11,1}='ARG';
%% Now save the data
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
MatFileName='AntarcticBases.mat';
actionstr='save';
varstr='BaseNames BaseLats BaseLons BaseType BasePop BaseCountry sourceURL';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Matlab File-',MatFileName);
disp(dispstr);










