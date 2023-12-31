function CreateMaskList()
%UNTITLED2 Summary of this function goes here
%   This will create a Mask List cell
% This cell holds key data related to Continents,Countries and US States
% The mask is specifically intended for the Merra2 global mask which has
% dimensions of 576 x 361. This mask spans the globe with a resolution of
% .625 deg lon and .5 deg latitude
% This will not work for any masks of different extent or resolution
% The actuals masks are created by the routine CreateMerra2DataMasks
% The MaskList cell contains data about the mask and will be used in a
% dialog to allow the user to select a particular mask


% Written By: Stephen Forczyk
% Created: Aug 12,2023
% Revised: -----
% Classification: Unclassified/Public Domain
global MaskList MaskListFileName;
global maskpath;
maskpath='K:\Merra-2\Masks\';
MaskListFileName='MerraConsolidatedMaskList.mat';
MaskList=cell(192,5);
%% Set working directory to the mask directory
eval(['cd ' maskpath(1:length(maskpath)-1)]);
%% Start with the continents
MaskList{1,1}='AfricaMask.mat';
MaskList{1,2}='Merra2AfricaMask';
MaskList{1,3}='Africa';
MaskList{1,4}=3.030E+07;
MaskList{1,5}=1;
MaskList{2,1}='AntarticMask.mat';
MaskList{2,2}='Merra2AntarcticMask';
MaskList{2,3}='Antartic';
MaskList{2,4}=1.420E+07;
MaskList{2,5}=2;
MaskList{3,1}='AsiaMask.mat';
MaskList{3,2}='Merra2AsiaMask';
MaskList{3,3}='Asia';
MaskList{3,4}=4.570E+07;
MaskList{3,5}=3;
MaskList{4,1}='AustraliaMask.mat';
MaskList{4,2}='Merra2AustraliaMask';
MaskList{4,3}='Australia';
MaskList{4,4}=7.682E+06;
MaskList{4,5}=4;
MaskList{5,1}='EuropeMask.mat';
MaskList{5,2}='Merra2EuropeMask';
MaskList{5,3}='Europe';
MaskList{5,4}=1.018E+07;
MaskList{5,5}=5;
MaskList{6,1}='NorthAmericaMask.mat';
MaskList{6,2}='Merra2NorthAmericaMask';
MaskList{6,3}='NorthAmerica';
MaskList{6,4}=2.479E+07;
MaskList{6,5}=6;
MaskList{7,1}='SouthAmericaMask.mat';
MaskList{7,2}='Merra2SouthAmericaMask';
MaskList{7,3}='SouthAmerica';
MaskList{7,4}=1.784E+07;
MaskList{7,5}=7;
%% Continue with Countries
MaskList{8,1}='AfganistanMask.mat';
MaskList{8,2}='Merra2AfganistanMask';
MaskList{8,3}='Afganistan';
MaskList{8,4}=6.470E+05;
MaskList{8,5}=8;
MaskList{9,1}='AlbaniaMask.mat';
MaskList{9,2}='Merra2AlbaniaMask';
MaskList{9,3}='Albania';
MaskList{9,4}=2.875E+04;
MaskList{9,5}=9;
MaskList{10,1}='AlgeriaMask.mat';
MaskList{10,2}='Merra2AlgeriaMask';
MaskList{10,3}='Algeria';
MaskList{10,4}=2.382E+06;
MaskList{10,5}=10;
MaskList{11,1}='AngolaMask.mat';
MaskList{11,2}='Merra2AngolaMask';
MaskList{11,3}='Angola';
MaskList{11,4}=1.247E+06;
MaskList{11,5}=11;
MaskList{12,1}='AntiguaMask.mat';
MaskList{12,2}='Merra2AntiguaMask';
MaskList{12,3}='Antigua';
MaskList{12,4}=4.400E+02;
MaskList{12,5}=12;
MaskList{13,1}='ArgentinaMask.mat';
MaskList{13,2}='Merra2ArgentinaMask';
MaskList{13,3}='Argentina';
MaskList{13,4}=2.780E+06;
MaskList{13,5}=13;
MaskList{14,1}='ArmeniaMask.mat';
MaskList{14,2}='Merra2ArmeniaMask';
MaskList{14,3}='Armenia';
MaskList{14,4}=2.974E+04;
MaskList{14,5}=14;
MaskList{15,1}='ArubaMask.mat';
MaskList{15,2}='Merra2ArubaMask';
MaskList{15,3}='Aruba';
MaskList{15,4}=180;
MaskList{15,5}=15;
MaskList{16,1}='AustriaMask.mat';
MaskList{16,2}='Merra2AustriaMask';
MaskList{16,3}='Austria';
MaskList{16,4}=8.387E+04;
MaskList{16,5}=16;
MaskList{17,1}='AzerbaijanMask.mat';
MaskList{17,2}='Merra2AzerbaijanMask';
MaskList{17,3}='Azerbaijan';
MaskList{17,4}=8.660E+04;
MaskList{17,5}=17;
MaskList{18,1}='BahamasMask.mat';
MaskList{18,2}='Merra2BahamasMask';
MaskList{18,3}='Bahamas';
MaskList{18,4}=1.3880E+04;
MaskList{18,5}=18;
MaskList{19,1}='BahrainMask.mat';
MaskList{19,2}='Merra2BahrainMask';
MaskList{19,3}='Bahrain';
MaskList{19,4}=760;
MaskList{19,5}=19;
MaskList{20,1}='BangladeshMask.mat';
MaskList{20,2}='Merra2BangladeshMask';
MaskList{20,3}='Banglasdesh';
MaskList{20,4}=1.485E+05;
MaskList{20,5}=20;
MaskList{21,1}='BelarusMask.mat';
MaskList{21,2}='Merra2BelarusMask';
MaskList{21,3}='Belarus';
MaskList{21,4}=207600;
MaskList{21,5}=21;
MaskList{22,1}='BelgiumMask.mat';
MaskList{22,2}='Merra2BelgiumMask';
MaskList{22,3}='Belgium';
MaskList{22,4}=30688;
MaskList{22,5}=22;
MaskList{23,1}='BelizeMask.mat';
MaskList{23,2}='Merra2BelizeMask';
MaskList{23,3}='Belize';
MaskList{23,4}=22970;
MaskList{23,5}=23;
MaskList{24,1}='BeninMask.mat';
MaskList{24,2}='Merra2BeninMask';
MaskList{24,3}='Benin';
MaskList{24,4}=114760;
MaskList{24,5}=24;
MaskList{25,1}='BhutanMask.mat';
MaskList{25,2}='Merra2BhutanMask';
MaskList{25,3}='Bhutan';
MaskList{25,4}=38394;
MaskList{25,5}=25;
MaskList{26,1}='BoliviaMask.mat';
MaskList{26,2}='Merra2BoliviaMask';
MaskList{26,3}='Bolivia';
MaskList{26,4}=1099000;
MaskList{26,5}=26;
MaskList{27,1}='BosniaMask.mat';
MaskList{27,2}='Merra2BosniaMask';
MaskList{27,3}='Bosnia';
MaskList{27,4}=51209;
MaskList{27,5}=27;
MaskList{28,1}='BotswanaMask.mat';
MaskList{28,2}='Merra2BotswanaMask';
MaskList{28,3}='Botswana';
MaskList{28,4}=581729;
MaskList{28,5}=28;
MaskList{29,1}='BouvetIslandMask.mat';
MaskList{29,2}='Merra2BouvetIslandMask';
MaskList{29,3}='BouvetIsland';
MaskList{29,4}=NaN;
MaskList{29,5}=-29;
MaskList{30,1}='BrazilMask.mat';
MaskList{30,2}='Merra2BrazilMask';
MaskList{30,3}='Brazil';
MaskList{30,4}=8510000;
MaskList{30,5}=30;
MaskList{31,1}='BritishVirginIslandsMask.mat';
MaskList{31,2}='Merra2BritishVirginIslandsMask';
MaskList{31,3}='BritishVirginIslands';
MaskList{31,4}=153;
MaskList{31,5}=-31;
MaskList{32,1}='BulgariaMask.mat';
MaskList{32,2}='Merra2BulgariaMask';
MaskList{32,3}='Bulgaria';
MaskList{32,4}=110990;
MaskList{32,5}=32;
MaskList{33,1}='BurkinaFasoMask.mat';
MaskList{33,2}='Merra2BurkinaFasoMask';
MaskList{33,3}='BurkinaFaso';
MaskList{33,4}=274000;
MaskList{33,5}=33;
MaskList{34,1}='BurmaMask.mat';
MaskList{34,2}='Merra2BurmaMask';
MaskList{34,3}='Burma';
MaskList{34,4}=676577;
MaskList{34,5}=34;
MaskList{35,1}='CODMask.mat';
MaskList{35,2}='Merra2CODMask';
MaskList{35,3}='Congo Dem Republic';
MaskList{35,4}=2345000;
MaskList{35,5}=35;
MaskList{36,1}='CORMask.mat';
MaskList{36,2}='Merra2CORMask';
MaskList{36,3}='Republic Of Congo';
MaskList{36,4}=342000;
MaskList{36,5}=36;
MaskList{37,1}='CambodiaMask.mat';
MaskList{37,2}='Merra2CambodiaMask';
MaskList{37,3}='Cambodia';
MaskList{37,4}=181030;
MaskList{37,5}=37;
MaskList{38,1}='CameroonMask.mat';
MaskList{38,2}='Merra2CameroonMask';
MaskList{38,3}='Cameroon';
MaskList{38,4}=474442;
MaskList{38,5}=38;
MaskList{39,1}='CanadaMask.mat';
MaskList{39,2}='Merra2CanadaMask';
MaskList{39,3}='Canada';
MaskList{39,4}=9985000;
MaskList{39,5}=39;
MaskList{40,1}='CaymanMask.mat';
MaskList{40,2}='Merra2CaymanMask';
MaskList{40,3}='Cayman Islands';
MaskList{40,4}=264;
MaskList{40,5}=40;
MaskList{41,1}='CentralAfricanRepublicMask.mat';
MaskList{41,2}='Merra2CentralAfricanRepublicMask';
MaskList{41,3}='CentralAfricanRepublic';
MaskList{41,4}=623001;
MaskList{41,5}=41;
MaskList{42,1}='ChadMask.mat';
MaskList{42,2}='Merra2ChadMask';
MaskList{42,3}='Chad';
MaskList{42,4}=1284000;
MaskList{42,5}=42;
MaskList{43,1}='ChileMask.mat';
MaskList{43,2}='Merra2ChileMask';
MaskList{43,3}='Chile';
MaskList{43,4}=756626;
MaskList{43,5}=43;
MaskList{44,1}='ChinaMask.mat';
MaskList{44,2}='Merra2ChinaMask';
MaskList{44,3}='China';
MaskList{44,4}=9597000;
MaskList{44,5}=44;
MaskList{45,1}='ColumbiaMask.mat';
MaskList{45,2}='Merra2ColumbiaMask';
MaskList{45,3}='Columbia';
MaskList{45,4}=1142000;
MaskList{45,5}=45;
MaskList{46,1}='CostaRicaMask.mat';
MaskList{46,2}='Merra2CostaRicaMask';
MaskList{46,3}='CostaRica';
MaskList{46,4}=51100;
MaskList{46,5}=46;
MaskList{47,1}='CroatiaMask.mat';
MaskList{47,2}='Merra2CroatiaMask';
MaskList{47,3}='Croatia';
MaskList{47,4}=56594;
MaskList{47,5}=47;
MaskList{48,1}='CubaMask.mat';
MaskList{48,2}='Merra2CubaMask';
MaskList{48,3}='Cuba';
MaskList{48,4}=109880;
MaskList{48,5}=48;
MaskList{49,1}='CyprusMask.mat';
MaskList{49,2}='Merra2CyprusMask';
MaskList{49,3}='Cyprus';
MaskList{49,4}=9251;
MaskList{49,5}=49;
MaskList{50,1}='CzechMask.mat';
MaskList{50,2}='Merra2CzechMask';
MaskList{50,3}='Czech';
MaskList{50,4}=78867;
MaskList{50,5}=50;
MaskList{51,1}='DenmarkMask.mat';
MaskList{51,2}='Merra2DenmarkMask';
MaskList{51,3}='Denmark';
MaskList{51,4}=42952;
MaskList{51,5}=51;
MaskList{52,1}='DjiboutiMask.mat';
MaskList{52,2}='Merra2DjiboutiMask';
MaskList{52,3}='Djibouti';
MaskList{52,4}=23200;
MaskList{52,5}=52;
MaskList{53,1}='DominicaMask.mat';
MaskList{53,2}='Merra2DomincaMask';
MaskList{53,3}='Dominica';
MaskList{53,4}=750;
MaskList{53,5}=-53;
MaskList{54,1}='DominicanRepublicMask.mat';
MaskList{54,2}='Merra2DominicanRepublicMask';
MaskList{54,3}='DominicanRepublic';
MaskList{54,4}=48442;
MaskList{54,5}=54;
MaskList{55,1}='EcuadorMask.mat';
MaskList{55,2}='Merra2EcuadorMask';
MaskList{55,3}='Ecuador';
MaskList{55,4}=256370;
MaskList{55,5}=55;
MaskList{56,1}='EgyptMask.mat';
MaskList{56,2}='Merra2EgyptMask';
MaskList{56,3}='Egypt';
MaskList{56,4}=1002000;
MaskList{56,5}=56;
MaskList{57,1}='ElSalvadorMask.mat';
MaskList{57,2}='Merra2ElSalvadorMask';
MaskList{57,3}='ElSalvador';
MaskList{57,4}=21040;
MaskList{57,5}=57;
MaskList{58,1}='EquatorialGuineaMask.mat';
MaskList{58,2}='Merra2EquatorialGuineaMask';
MaskList{58,3}='EquatorialGuinea';
MaskList{58,4}=28051;
MaskList{58,5}=58;
MaskList{59,1}='EritreaMask.mat';
MaskList{59,2}='Merra2EritreaMask';
MaskList{59,3}='Eritrea';
MaskList{59,4}=117600;
MaskList{59,5}=59;
MaskList{60,1}='EstoniaMask.mat';
MaskList{60,2}='Merra2EstoniaMask';
MaskList{60,3}='Estonia';
MaskList{60,4}=45339;
MaskList{60,5}=60;
MaskList{61,1}='EthiopiaMask.mat';
MaskList{61,2}='Merra2EthiopiaMask';
MaskList{61,3}='Ethiopia';
MaskList{61,4}=1112000;
MaskList{61,5}=61;
MaskList{62,1}='FTSMask.mat';
MaskList{62,2}='Merra2FTSMask';
MaskList{62,3}='FTS';
MaskList{62,4}=NaN;
MaskList{62,5}=-62;
MaskList{63,1}='FinlandMask.mat';
MaskList{63,2}='Merra2FinlandMask';
MaskList{63,3}='Finland';
MaskList{63,4}=338462;
MaskList{63,5}=63;
MaskList{64,1}='FranceMask.mat';
MaskList{64,2}='Merra2FranceMask';
MaskList{64,3}='France';
MaskList{64,4}=551696;
MaskList{64,5}=64;
MaskList{65,1}='FrenchGuianaMask.mat';
MaskList{65,2}='Merra2FrenchGuianaMask';
MaskList{65,3}='FrenchGuiana';
MaskList{65,4}=83846;
MaskList{65,5}=65;
MaskList{66,1}='GuineaBissauMask.mat';
MaskList{66,2}='Merra2GuineaBissauMask';
MaskList{66,3}='GuineaBissau';
MaskList{66,4}=36120;
MaskList{66,5}=66;
MaskList{67,1}='GabonMask.mat';
MaskList{67,2}='Merra2GabonMask';
MaskList{67,3}='Gabon';
MaskList{67,4}=267668;
MaskList{67,5}=67;
MaskList{68,1}='GambiaMask.mat';
MaskList{68,2}='Merra2GambiaMask';
MaskList{68,3}='Gambia';
MaskList{68,4}=11300;
MaskList{68,5}=68;
MaskList{69,1}='GuatemalaMask.mat';
MaskList{69,2}='Merra2GuatemalaMask';
MaskList{69,3}='Guatemala';
MaskList{69,4}=42042;
MaskList{69,5}=69;
MaskList{70,1}='GermanyMask.mat';
MaskList{70,2}='Merra2GermanyMask';
MaskList{70,3}='Germany';
MaskList{70,4}=357587;
MaskList{70,5}=70;
MaskList{71,1}='GhanaMask.mat';
MaskList{71,2}='Merra2GhanaMask';
MaskList{71,3}='Ghana';
MaskList{71,4}=238530;
MaskList{71,5}=71;
MaskList{72,1}='GreeceMask.mat';
MaskList{72,2}='Merra2GreeceMask';
MaskList{72,3}='Greece';
MaskList{72,4}=131960;
MaskList{72,5}=72;
MaskList{73,1}='GreenlandMask.mat';
MaskList{73,2}='Merra2GreenlandMask';
MaskList{73,3}='Greenland';
MaskList{73,4}=2166000;
MaskList{73,5}=73;
MaskList{74,1}='GrenadaMask.mat';
MaskList{74,2}='Merra2GrenadaMask';
MaskList{74,3}='Grenada';
MaskList{74,4}=344;
MaskList{74,5}=74;
MaskList{75,1}='GuadeloupeMask.mat';
MaskList{75,2}='Merra2GuadeloupeMask';
MaskList{75,3}='Guadeloupe';
MaskList{75,4}=1630;
MaskList{75,5}=75;
MaskList{76,1}='GuianaMask.mat';
MaskList{76,2}='Merra2GuianaMask';
MaskList{76,3}='Guiana';
MaskList{76,4}=83846;
MaskList{76,5}=76;
MaskList{77,1}='GuineaMask.mat';
MaskList{77,2}='Merra2GuineaMask';
MaskList{77,3}='Guinea';
MaskList{77,4}=245860;
MaskList{77,5}=77;
MaskList{78,1}='GuyanaMask.mat';
MaskList{78,2}='Merra2GuyanaMask';
MaskList{78,3}='Guyana';
MaskList{78,4}=214970;
MaskList{78,5}=78;
MaskList{79,1}='HaitiMask.mat';
MaskList{79,2}='Merra2HaitiMask';
MaskList{79,3}='Haiti';
MaskList{79,4}=27750;
MaskList{79,5}=79;
MaskList{80,1}='HondurasMask.mat';
MaskList{80,2}='Merra2HondurasMask';
MaskList{80,3}='Honduras';
MaskList{80,4}=112490;
MaskList{80,5}=80;
MaskList{81,1}='HungaryMask.mat';
MaskList{81,2}='Merra2HungaryMask';
MaskList{81,3}='Hungary';
MaskList{81,4}=93026;
MaskList{81,5}=81;
MaskList{82,1}='IcelandMask.mat';
MaskList{82,2}='Merra2IcelandMask';
MaskList{82,3}='Iceland';
MaskList{82,4}=103000;
MaskList{82,5}=82;
MaskList{83,1}='IndiaMask.mat';
MaskList{83,2}='Merra2IndiaMask';
MaskList{83,3}='India';
MaskList{83,4}=3287590;
MaskList{83,5}=83;
MaskList{84,1}='IndonesiaMask.mat';
MaskList{84,2}='Merra2IndonesiaMask';
MaskList{84,3}='Indonesia';
MaskList{84,4}=1905000;
MaskList{84,5}=84;
MaskList{85,1}='IranMask.mat';
MaskList{85,2}='Merra2IranMask';
MaskList{85,3}='Iran';
MaskList{85,4}=1648000;
MaskList{85,5}=85;
MaskList{86,1}='IraqMask.mat';
MaskList{86,2}='Merra2IraqMask';
MaskList{86,3}='Iraq';
MaskList{86,4}=438314;
MaskList{86,5}=86;
MaskList{87,1}='IrelandMask.mat';
MaskList{87,2}='Merra2IrelandMask';
MaskList{87,3}='Ireland';
MaskList{87,4}=84421;
MaskList{87,5}=87;
MaskList{88,1}='IsraelMask.mat';
MaskList{88,2}='Merra2IsraelMask';
MaskList{88,3}='Israel';
MaskList{88,4}=84421;
MaskList{88,5}=88;
MaskList{89,1}='ItalyMask.mat';
MaskList{89,2}='Merra2ItalyMask';
MaskList{89,3}='Italy';
MaskList{89,4}=302073;
MaskList{89,5}=89;
MaskList{90,1}='IvoryCoastMask.mat';
MaskList{90,2}='Merra2IvoryCoastMask';
MaskList{90,3}='IvoryCoast';
MaskList{90,4}=322416;
MaskList{90,5}=90;
MaskList{91,1}='JamaicaMask.mat';
MaskList{91,2}='Merra2JamaicaMask';
MaskList{91,3}='Jamaica';
MaskList{91,4}=10990;
MaskList{91,5}=91;
MaskList{92,1}='JapanMask.mat';
MaskList{92,2}='Merra2JapanMask';
MaskList{92,3}='Japan';
MaskList{92,4}=377973;
MaskList{92,5}=92;
MaskList{93,1}='JordanMask.mat';
MaskList{93,2}='Merra2JordanMask';
MaskList{93,3}='Jordan';
MaskList{93,4}=89342;
MaskList{93,5}=93;
MaskList{94,1}='KazakhstanMask.mat';
MaskList{94,2}='Merra2KazakhstanMask';
MaskList{94,3}='Kazakhstan';
MaskList{94,4}=2725000;
MaskList{94,5}=94;
MaskList{95,1}='KenyaMask.mat';
MaskList{95,2}='Merra2KenyaMask';
MaskList{95,3}='Kenya';
MaskList{95,4}=582646;
MaskList{95,5}=95;
MaskList{96,1}='KosovoMask.mat';
MaskList{96,2}='Merra2KosovoMask';
MaskList{96,3}='Kosovo';
MaskList{96,4}=10890;
MaskList{96,5}=96;
MaskList{97,1}='KuwaitMask.mat';
MaskList{97,2}='Merra2KuwaitMask';
MaskList{97,3}='Kuwait';
MaskList{97,4}=17820;
MaskList{97,5}=97;
MaskList{98,1}='KyrgyzstanMask.mat';
MaskList{98,2}='Merra2KyrgyzstanMask';
MaskList{98,3}='Kyrgyzstan';
MaskList{98,4}=199900;
MaskList{98,5}=98;
MaskList{99,1}='LaosMask.mat';
MaskList{99,2}='Merra2LaosMask';
MaskList{99,3}='Laos';
MaskList{99,4}=236800;
MaskList{99,5}=99;
MaskList{100,1}='LatviaMask.mat';
MaskList{100,2}='Merra2LatviaMask';
MaskList{100,3}='Latvia';
MaskList{100,4}=64589;
MaskList{100,5}=100;
MaskList{101,1}='LebanonMask.mat';
MaskList{101,2}='Merra2LebanonMask';
MaskList{101,3}='Lebanon';
MaskList{101,4}=10450;
MaskList{101,5}=101;
MaskList{102,1}='LesothoMask.mat';
MaskList{102,2}='Merra2LesothoMask';
MaskList{102,3}='Lesotho';
MaskList{102,4}=30355;
MaskList{102,5}=102;
MaskList{103,1}='LiberiaMask.mat';
MaskList{103,2}='Merra2LiberiaMask';
MaskList{103,3}='Liberia';
MaskList{103,4}=111370;
MaskList{103,5}=103;
MaskList{104,1}='LibyaMask.mat';
MaskList{104,2}='Merra2LiberiaMask';
MaskList{104,3}='Libya';
MaskList{104,4}=1760000;
MaskList{104,5}=104;
MaskList{105,1}='LithuaniaMask.mat';
MaskList{105,2}='Merra2LithuaniaMask';
MaskList{105,3}='Lithuania';
MaskList{105,4}=6.530E+04;
MaskList{105,5}=105;
MaskList{106,1}='LuxembourgMask.mat';
MaskList{106,2}='Merra2LuxembourgMask';
MaskList{106,3}='Luxembourg';
MaskList{106,4}=2590;
MaskList{106,5}=106;
MaskList{107,1}='MacedoniaMask.mat';
MaskList{107,2}='Merra2MacedoniaMask';
MaskList{107,3}='Macedonia';
MaskList{107,4}=25710;
MaskList{107,5}=107;
MaskList{108,1}='MadagascarMask.mat';
MaskList{108,2}='Merra2MadagascarMask';
MaskList{108,3}='Madagascar';
MaskList{108,4}=586884;
MaskList{108,5}=108;
MaskList{109,1}='MalawiMask.mat';
MaskList{109,2}='Merra2MalawiMask';
MaskList{109,3}='Malawi';
MaskList{109,4}=586884;
MaskList{109,5}=109;
MaskList{110,1}='MalaysiaMask.mat';
MaskList{110,2}='Merra2MalaysiaMask';
MaskList{110,3}='Malaysia';
MaskList{110,4}=330804;
MaskList{110,5}=110;
MaskList{111,1}='MaldivesMask.mat';
MaskList{111,2}='Merra2MaldivesMask';
MaskList{111,3}='Maldives';
MaskList{111,4}=297;
MaskList{111,5}=111;
MaskList{112,1}='MaliMask.mat';
MaskList{112,2}='Merra2MaliMask';
MaskList{112,3}='Mali';
MaskList{112,4}=1240000;
MaskList{112,5}=112;
MaskList{113,1}='MaltaMask.mat';
MaskList{113,2}='Merra2MaltaMask';
MaskList{113,3}='Malta';
MaskList{113,4}=316;
MaskList{113,5}=113;
MaskList{114,1}='MarshalIslandsMask.mat';
MaskList{114,2}='Merra2MarshalIslandsMask';
MaskList{114,3}='MarshalIslands';
MaskList{114,4}=181;
MaskList{114,5}=114;
MaskList{115,1}='MartiniqueMask.mat';
MaskList{115,2}='Merra2MartiniqueMask';
MaskList{115,3}='Martinique';
MaskList{115,4}=1060;
MaskList{115,5}=115;
MaskList{116,1}='MauritaniaMask.mat';
MaskList{116,2}='Merra2MauritaniaMask';
MaskList{116,3}='Mauritania';
MaskList{116,4}=1025000;
MaskList{116,5}=116;
MaskList{117,1}='MexicoMask.mat';
MaskList{117,2}='Merra2MexicoMask';
MaskList{117,3}='Mexico';
MaskList{117,4}=1973000;
MaskList{117,5}=117;
MaskList{118,1}='MicronesiaMask.mat';
MaskList{118,2}='Merra2MicronesiaMask';
MaskList{118,3}='Micronesia';
MaskList{118,4}=702;
MaskList{118,5}=118;
MaskList{119,1}='MoldovaMask.mat';
MaskList{119,2}='Merra2MoldovaMask';
MaskList{119,3}='Moldova';
MaskList{119,4}=33846;
MaskList{119,5}=119;
MaskList{120,1}='MongoliaMask.mat';
MaskList{120,2}='Merra2MongoliaMask';
MaskList{120,3}='Mongolia';
MaskList{120,4}=1564000;
MaskList{120,5}=120;
MaskList{121,1}='MontenegroMask.mat';
MaskList{121,2}='Merra2MontenegroMask';
MaskList{121,3}='Montenegro';
MaskList{121,4}=13810;
MaskList{121,5}=121;
MaskList{122,1}='MoroccoMask.mat';
MaskList{122,2}='Merra2MoroccoMask';
MaskList{122,3}='Morocco';
MaskList{122,4}=710850;
MaskList{122,5}=122;
MaskList{123,1}='MozambiqueMask.mat';
MaskList{123,2}='Merra2MozambiqueMask';
MaskList{123,3}='Mozambique';
MaskList{123,4}=799379;
MaskList{123,5}=123;
MaskList{124,1}='NamibiaMask.mat';
MaskList{124,2}='Merra2NamibiaMask';
MaskList{124,3}='Namibia';
MaskList{124,4}=824292;
MaskList{124,5}=124;
MaskList{125,1}='NepalMask.mat';
MaskList{125,2}='Merra2NepalMask';
MaskList{125,3}='Nepal';
MaskList{125,4}=147180;
MaskList{125,5}=125;
MaskList{126,1}='NetherlandsMask.mat';
MaskList{126,2}='Merra2NetherlandsMask';
MaskList{126,3}='Netherlands';
MaskList{126,4}=41850;
MaskList{126,5}=126;
MaskList{127,1}='NewGuineaMask.mat';
MaskList{127,2}='Merra2NewGuineaMask';
MaskList{127,3}='NewGuinea';
MaskList{127,4}=462839;
MaskList{127,5}=127;
MaskList{128,1}='NewZealandMask.mat';
MaskList{128,2}='Merra2NewZealandMask';
MaskList{128,3}='NewZealand';
MaskList{128,4}=268020;
MaskList{128,5}=128;
MaskList{129,1}='NicaraguaMask.mat';
MaskList{129,2}='Merra2NicaraguaMask';
MaskList{129,3}='Nicaragua';
MaskList{129,4}=130370;
MaskList{129,5}=129;
MaskList{130,1}='NigerMask.mat';
MaskList{130,2}='Merra2NigerMask';
MaskList{130,3}='Niger';
MaskList{130,4}=1267000;
MaskList{130,5}=130;
MaskList{131,1}='NigeriaMask.mat';
MaskList{131,2}='Merra2NigeriaMask';
MaskList{131,3}='Nigeria';
MaskList{131,4}=923768;
MaskList{131,5}=131;
MaskList{132,1}='NorthKoreaMask.mat';
MaskList{132,2}='Merra2NorthKoreaMask';
MaskList{132,3}='NorthKorea';
MaskList{132,4}=120540;
MaskList{132,5}=132;
MaskList{133,1}='NorwayMask.mat';
MaskList{133,2}='Merra2NorwayMask';
MaskList{133,3}='Norway';
MaskList{133,4}=385206;
MaskList{133,5}=133;
MaskList{134,1}='OmanMask.mat';
MaskList{134,2}='Merra2OmanMask';
MaskList{134,3}='Oman';
MaskList{134,4}=309501;
MaskList{134,5}=134;
MaskList{135,1}='PakistanMask.mat';
MaskList{135,2}='Merra2PakistanMask';
MaskList{135,3}='Pakistan';
MaskList{135,4}=796095;
MaskList{135,5}=135;
MaskList{136,1}='PanamaMask.mat';
MaskList{136,2}='Merra2PanamaMask';
MaskList{136,3}='Panama';
MaskList{136,4}=75517;
MaskList{136,5}=136;
MaskList{137,1}='ParaguayMask.mat';
MaskList{137,2}='Merra2ParaguayMask';
MaskList{137,3}='Paraguay';
MaskList{137,4}=406752;
MaskList{137,5}=137;
MaskList{138,1}='PeruMask.mat';
MaskList{138,2}='Merra2PeruMask';
MaskList{138,3}='Peru';
MaskList{138,4}=1280000;
MaskList{138,5}=138;
MaskList{139,1}='PhilippinesMask.mat';
MaskList{139,2}='Merra2PhilippinesMask';
MaskList{139,3}='Philippines';
MaskList{139,4}=300001;
MaskList{139,5}=139;
MaskList{140,1}='PolandMask.mat';
MaskList{140,2}='Merra2PolandMask';
MaskList{140,3}='Poland';
MaskList{140,4}=322575;
MaskList{140,5}=140;
MaskList{141,1}='PolynesiaMask.mat';
MaskList{141,2}='Merra2PolynesiaMask';
MaskList{141,3}='Polynesia';
MaskList{141,4}=300000;
MaskList{141,5}=141;
MaskList{142,1}='PortugalMask.mat';
MaskList{142,2}='Merra2PortugalMask';
MaskList{142,3}='Portugal';
MaskList{142,4}=92152;
MaskList{142,5}=142;
MaskList{143,1}='PuertoRicoMask.mat';
MaskList{143,2}='Merra2PuertoRicoMask';
MaskList{143,3}='PuertoRico';
MaskList{143,4}=1.379E+04;
MaskList{143,5}=143;
MaskList{144,1}='QatarMask.mat';
MaskList{144,2}='Merra2QatarMask';
MaskList{144,3}='Qatar';
MaskList{144,4}=11570;
MaskList{144,5}=144;
MaskList{145,1}='RepGeorgiaMask.mat';
MaskList{145,2}='Merra2RepGeorgiaMask';
MaskList{145,3}='RepGeorgia';
MaskList{145,4}=69681;
MaskList{145,5}=145;
MaskList{146,1}='RomaniaMask.mat';
MaskList{146,2}='Merra2RomaniaMask';
MaskList{146,3}='Romania';
MaskList{146,4}=238400;
MaskList{146,5}=146;
MaskList{147,1}='RussiaMask.mat';
MaskList{147,2}='Merra2RussiaMask';
MaskList{147,3}='Russia';
MaskList{147,4}=17100000;
MaskList{147,5}=147;
MaskList{148,1}='RwandaMask.mat';
MaskList{148,2}='Merra2RwandaMask';
MaskList{148,3}='Rwanda';
MaskList{148,4}=26338;
MaskList{148,5}=148;
MaskList{149,1}='SamoaMask.mat';
MaskList{149,2}='Merra2SamoaMask';
MaskList{149,3}='Samoa';
MaskList{149,4}=30303;
MaskList{149,5}=149;
MaskList{150,1}='SaudiMask.mat';
MaskList{150,2}='Merra2SaudiMask';
MaskList{150,3}='Saudi';
MaskList{150,4}=2150000;
MaskList{150,5}=150;
MaskList{151,1}='SenegalMask.mat';
MaskList{151,2}='Merra2SenegalMask';
MaskList{151,3}='Senegal';
MaskList{151,4}=196840;
MaskList{151,5}=151;
MaskList{152,1}='SerbiaMask.mat';
MaskList{152,2}='Merra2SerbiaMask';
MaskList{152,3}='Serbia';
MaskList{152,4}=88499;
MaskList{152,5}=152;
MaskList{153,1}='SeychellesMask.mat';
MaskList{153,2}='Merra2SeychellesMask';
MaskList{153,3}='Seychelles';
MaskList{153,4}=455;
MaskList{153,5}=153;
MaskList{154,1}='SierraLeoneMask.mat';
MaskList{154,2}='Merra2SierraLeoneMask';
MaskList{154,3}='SierraLeone';
MaskList{154,4}=71740;
MaskList{154,5}=154;
MaskList{155,1}='SlovakiaMask.mat';
MaskList{155,2}='Merra2SlovakiaMask';
MaskList{155,3}='Slovakia';
MaskList{155,4}=49035;
MaskList{155,5}=155;
MaskList{156,1}='SloveniaMask.mat';
MaskList{156,2}='Merra2SloveniaMask';
MaskList{156,3}='Slovenia';
MaskList{156,4}=49035;
MaskList{156,5}=156;
MaskList{157,1}='SolomonIslandsMask.mat';
MaskList{157,2}='Merra2SolomonIslandsMask';
MaskList{157,3}='SolomonIslands';
MaskList{157,4}=28896;
MaskList{157,5}=157;
MaskList{158,1}='SomaliaMask.mat';
MaskList{158,2}='Merra2SomaliaMask';
MaskList{158,3}='Somalia';
MaskList{158,4}=637655;
MaskList{158,5}=158;
MaskList{159,1}='SouthAfricaMask.mat';
MaskList{159,2}='Merra2SouthAfricaMask';
MaskList{159,3}='SouthAfrica';
MaskList{159,4}=1220000;
MaskList{159,5}=159;
MaskList{160,1}='SouthKoreaMask.mat';
MaskList{160,2}='Merra2SouthKoreaMask';
MaskList{160,3}='SouthKorea';
MaskList{160,4}=100210;
MaskList{160,5}=160;
MaskList{161,1}='SpainMask.mat';
MaskList{161,2}='Merra2SpainMask';
MaskList{161,3}='Spain';
MaskList{161,4}=505990;
MaskList{161,5}=161;
MaskList{162,1}='SriLankaMask.mat';
MaskList{162,2}='Merra2SriLankaMask';
MaskList{162,3}='SriLanka';
MaskList{162,4}=65610;
MaskList{162,5}=162;
MaskList{163,1}='SudanMask.mat';
MaskList{163,2}='Merra2SudanMask';
MaskList{163,3}='Sudan';
MaskList{163,4}=1886000;
MaskList{163,5}=163;
MaskList{164,1}='SurinameMask.mat';
MaskList{164,2}='Merra2SurinameMask';
MaskList{164,3}='Suriname';
MaskList{164,4}=163820;
MaskList{164,5}=164;
MaskList{165,1}='SwazilandMask.mat';
MaskList{165,2}='Merra2SwazilandMask';
MaskList{165,3}='Swaziland';
MaskList{165,4}=17360;
MaskList{165,5}=165;
MaskList{166,1}='SwedenMask.mat';
MaskList{166,2}='Merra2SwedenMask';
MaskList{166,3}='Sweden';
MaskList{166,4}=528448;
MaskList{166,5}=166;
MaskList{167,1}='SwitzerlandMask.mat';
MaskList{167,2}='Merra2SwitzerlandMask';
MaskList{167,3}='Switzerland';
MaskList{167,4}=41285;
MaskList{167,5}=167;
MaskList{168,1}='SyriaMask.mat';
MaskList{168,2}='Merra2SyriaMask';
MaskList{168,3}='Syria';
MaskList{168,4}=185180;
MaskList{168,5}=168;
MaskList{169,1}='TaiwanMask.mat';
MaskList{169,2}='Merra2TaiwanMask';
MaskList{169,3}='Taiwan';
MaskList{169,4}=36197;
MaskList{169,5}=169;
MaskList{170,1}='TajikistanMask.mat';
MaskList{170,2}='Merra2TajikistanMask';
MaskList{170,3}='Tajikstan';
MaskList{170,4}=143100;
MaskList{170,5}=170;
MaskList{171,1}='TanzaniaMask.mat';
MaskList{171,2}='Merra2TanzaniaMask';
MaskList{171,3}='Tanzania';
MaskList{171,4}=945087;
MaskList{171,5}=171;
MaskList{172,1}='ThailandMask.mat';
MaskList{172,2}='Merra2ThailandMask';
MaskList{172,3}='Thailand';
MaskList{172,4}=513121;
MaskList{172,5}=172;
MaskList{173,1}='TimorMask.mat';
MaskList{173,2}='Merra2TimorMask';
MaskList{173,3}='Timor';
MaskList{173,4}=15010;
MaskList{173,5}=173;
MaskList{174,1}='TogoMask.mat';
MaskList{174,2}='Merra2TogoMask';
MaskList{174,3}='Togo';
MaskList{174,4}=56785;
MaskList{174,5}=174;
MaskList{175,1}='TunisiaMask.mat';
MaskList{175,2}='Merra2TunisiaMask';
MaskList{175,3}='Tunisia';
MaskList{175,4}=1.636E+05;
MaskList{175,5}=175;
MaskList{176,1}='TurkeyMask.mat';
MaskList{176,2}='Merra2TurkeyMask';
MaskList{176,3}='Turkey';
MaskList{176,4}=783562;
MaskList{176,5}=176;
MaskList{177,1}='TurkmenistanMask.mat';
MaskList{177,2}='Merra2TurkmenistanMask';
MaskList{177,3}='Turkmenistan';
MaskList{177,4}=491209;
MaskList{177,5}=177;
MaskList{178,1}='TurksMask.mat';
MaskList{178,2}='Merra2TurksMask';
MaskList{178,3}='Turks';
MaskList{178,4}=948;
MaskList{178,5}=178;
MaskList{179,1}='UAEMask.mat';
MaskList{179,2}='Merra2UAEMask';
MaskList{179,3}='UAE';
MaskList{179,4}=83600;
MaskList{179,5}=179;
MaskList{180,1}='UKMask.mat';
MaskList{180,2}='Merra2UKMask';
MaskList{180,3}='UK';
MaskList{180,4}=243610;
MaskList{180,5}=180;
MaskList{181,1}='USAMask.mat';
MaskList{181,2}='Merra2USAMask';
MaskList{181,3}='USA';
MaskList{181,4}=9834000;
MaskList{181,5}=181;
MaskList{182,1}='UgandaMask.mat';
MaskList{182,2}='Merra2UgandaMask';
MaskList{182,3}='Uganda';
MaskList{182,4}=241040;
MaskList{182,5}=182;
MaskList{183,1}='UkraineMask.mat';
MaskList{183,2}='Merra2UkraineMask';
MaskList{183,3}='Ukraine';
MaskList{183,4}=603700;
MaskList{183,5}=183;
MaskList{184,1}='UruguayMask.mat';
MaskList{184,2}='Merra2UruguayMask';
MaskList{184,3}='Uruguay';
MaskList{184,4}=193356;
MaskList{184,5}=184;
MaskList{185,1}='VanuatuMask.mat';
MaskList{185,2}='Merra2VanuatuMask';
MaskList{185,3}='Vanuatu';
MaskList{185,4}=12190;
MaskList{185,5}=185;
MaskList{186,1}='VenezuelaMask.mat';
MaskList{186,2}='Merra2VenezuelaMask';
MaskList{186,3}='Venezuela';
MaskList{186,4}=916444;
MaskList{186,5}=186;
MaskList{187,1}='VietnamMask.mat';
MaskList{187,2}='Merra2VietnamMask';
MaskList{187,3}='Vietnam';
MaskList{187,4}=331689;
MaskList{187,5}=187;
MaskList{188,1}='VirginIslandsMask.mat';
MaskList{188,2}='Merra2VirginIslandsMask';
MaskList{188,3}='VirginIslands';
MaskList{188,4}=346;
MaskList{188,5}=188;
MaskList{189,1}='WestSaharaMask.mat';
MaskList{189,2}='Merra2WestSaharaMask';
MaskList{189,3}='WestSahara';
MaskList{189,4}=266000;
MaskList{189,5}=189;
MaskList{190,1}='YemenMask.mat';
MaskList{190,2}='Merra2YemenMask';
MaskList{190,3}='Yemen';
MaskList{190,4}=555001;
MaskList{190,5}=190;
MaskList{191,1}='ZambiaMask.mat';
MaskList{191,2}='Merra2ZambiaMask';
MaskList{191,3}='Zambia';
MaskList{191,4}=752614;
MaskList{191,5}=191;
MaskList{192,1}='ZimbabweMask.mat';
MaskList{192,2}='Merra2ZimbabweMask';
MaskList{192,3}='Zimbabwe';
MaskList{192,4}=390744;
MaskList{192,5}=192;
MaskList{193,1}='AlabamaMask.mat';
MaskList{193,2}='Merra2AlabamaMask';
MaskList{193,3}='Alabama';
MaskList{193,4}=135770;
MaskList{193,5}=193;
MaskList{194,1}='AlaskaMask.mat';
MaskList{194,2}='Merra2AlaskaMask';
MaskList{194,3}='Alaska';
MaskList{194,4}=1723000;
MaskList{194,5}=194;
MaskList{195,1}='ArizonaMask.mat';
MaskList{195,2}='Merra2ArizonaMask';
MaskList{195,3}='Arizona';
MaskList{195,4}=295253;
MaskList{195,5}=195;
MaskList{196,1}='ArkansasMask.mat';
MaskList{196,2}='Merra2ArkansasMask';
MaskList{196,3}='Arkansas';
MaskList{196,4}=137730;
MaskList{196,5}=196;
MaskList{197,1}='CaliforniaMask.mat';
MaskList{197,2}='Merra2CaliforniaMask';
MaskList{197,3}='California';
MaskList{197,4}=137730;
MaskList{197,5}=197;
MaskList{198,1}='ColoradoMask.mat';
MaskList{198,2}='Merra2ColoradoMask';
MaskList{198,3}='Colorado';
MaskList{198,4}=269838;
MaskList{198,5}=198;
MaskList{199,1}='ConnecticutMask.mat';
MaskList{199,2}='Merra2ConnecticutMask';
MaskList{199,3}='Connecticut';
MaskList{199,4}=13020;
MaskList{199,5}=199;
MaskList{200,1}='DelawareMask.mat';
MaskList{200,2}='Merra2DelawareMask';
MaskList{200,3}='Delaware';
MaskList{200,4}=6446;
MaskList{200,5}=200;
MaskList{201,1}='FloridaMask.mat';
MaskList{201,2}='Merra2FloridaMask';
MaskList{201,3}='Florida';
MaskList{201,4}=170319;
MaskList{201,5}=201;
MaskList{202,1}='GeorgiaMask.mat';
MaskList{202,2}='Merra2GeorgiaMask';
MaskList{202,3}='Georgia';
MaskList{202,4}=69700;
MaskList{202,5}=202;
MaskList{203,1}='HawaiiMask.mat';
MaskList{203,2}='Merra2HawaiiMask';
MaskList{203,3}='Hawaii';
MaskList{203,4}=28311;
MaskList{203,5}=203;
MaskList{204,1}='IdahoMask.mat';
MaskList{204,2}='Merra2IdahoMask';
MaskList{204,3}='Idaho';
MaskList{204,4}=216630;
MaskList{204,5}=204;
MaskList{205,1}='IllinoisMask.mat';
MaskList{205,2}='Merra2IllinoisMask';
MaskList{205,3}='Illinois';
MaskList{205,4}=150000;
MaskList{205,5}=205;
MaskList{206,1}='IndianaMask.mat';
MaskList{206,2}='Merra2IndianaMask';
MaskList{206,3}='Indiana';
MaskList{206,4}=94326;
MaskList{206,5}=206;
MaskList{207,1}='IowaMask.mat';
MaskList{207,2}='Merra2IowaMask';
MaskList{207,3}='Iowa';
MaskList{207,4}=145750;
MaskList{207,5}=207;
MaskList{208,1}='KansasMask.mat';
MaskList{208,2}='Merra2KansasMask';
MaskList{208,3}='Kansas';
MaskList{208,4}=213100;
MaskList{208,5}=208;
MaskList{209,1}='KentuckyMask.mat';
MaskList{209,2}='Merra2KentuckyMask';
MaskList{209,3}='Kentucky';
MaskList{209,4}=102907;
MaskList{209,5}=209;
MaskList{210,1}='LouisianaMask.mat';
MaskList{210,2}='Merra2LouisianaMask';
MaskList{210,3}='Louisiana';
MaskList{210,4}=135660;
MaskList{210,5}=210;
MaskList{211,1}='MaineMask.mat';
MaskList{211,2}='Merra2MaineMask';
MaskList{211,3}='Maine';
MaskList{211,4}=91646;
MaskList{211,5}=211;
MaskList{212,1}='MarylandMask.mat';
MaskList{212,2}='Merra2MarylandMask';
MaskList{212,3}='Maryland';
MaskList{212,4}=32134;
MaskList{212,5}=212;
MaskList{213,1}='MassachusettsMask.mat';
MaskList{213,2}='Merra2MassachusettsMask';
MaskList{213,3}='Massachusetts';
MaskList{213,4}=27363;
MaskList{213,5}=213;
MaskList{214,1}='MichiganMask.mat';
MaskList{214,2}='Merra2MichiganMask';
MaskList{214,3}='Michigan';
MaskList{214,4}=250490;
MaskList{214,5}=214;
MaskList{215,1}='MinnesotaMask.mat';
MaskList{215,2}='Merra2MinnesotaMask';
MaskList{215,3}='Minnesota';
MaskList{215,4}=225180;
MaskList{215,5}=215;
MaskList{216,1}='MississippiMask.mat';
MaskList{216,2}='Merra2MississippiMask';
MaskList{216,3}='Mississippi';
MaskList{216,4}=125430;
MaskList{216,5}=216;
MaskList{217,1}='MissouriMask.mat';
MaskList{217,2}='Merra2MissouriMask';
MaskList{217,3}='Missouri';
MaskList{217,4}=180560;
MaskList{217,5}=217;
MaskList{218,1}='MontanaMask.mat';
MaskList{218,2}='Merra2MontanaMask';
MaskList{218,3}='Montana';
MaskList{218,4}=380832;
MaskList{218,5}=218;
MaskList{219,1}='NebraskaMask.mat';
MaskList{219,2}='Merra2NebraskaMask';
MaskList{219,3}='Nebraska';
MaskList{219,4}=200330;
MaskList{219,5}=219;
MaskList{220,1}='NevadaMask.mat';
MaskList{220,2}='Merra2NevadaMask';
MaskList{220,3}='Nevada';
MaskList{220,4}=286367;
MaskList{220,5}=220;
MaskList{221,1}='NewHampshireMask.mat';
MaskList{221,2}='Merra2NewHampshireMask';
MaskList{221,3}='NewHampshire';
MaskList{221,4}=24210;
MaskList{221,5}=221;
MaskList{222,1}='NewJerseyMask.mat';
MaskList{222,2}='Merra2NewJerseyMask';
MaskList{222,3}='NewJersey';
MaskList{222,4}=22590;
MaskList{222,5}=222;
MaskList{223,1}='NewMexicoMask.mat';
MaskList{223,2}='Merra2NewMexicoMask';
MaskList{223,3}='NewMexico';
MaskList{223,4}=315194;
MaskList{223,5}=223;
MaskList{224,1}='NewYorkMask.mat';
MaskList{224,2}='Merra2NewYorkMask';
MaskList{224,3}='NewYork';
MaskList{224,4}=141300;
MaskList{224,5}=224;
MaskList{225,1}='NorthCarolinaMask.mat';
MaskList{225,2}='Merra2NorthCarolinaMask';
MaskList{225,3}='NorthCarolina';
MaskList{225,4}=139390;
MaskList{225,5}=225;
MaskList{226,1}='NorthDakotaMask.mat';
MaskList{226,2}='Merra2NorthDakotaMask';
MaskList{226,3}='NorthDakota';
MaskList{226,4}=183130;
MaskList{226,5}=226;
MaskList{227,1}='OhioMask.mat';
MaskList{227,2}='Merra2OhioMask';
MaskList{227,3}='Ohio';
MaskList{227,4}=116100;
MaskList{227,5}=227;
MaskList{228,1}='OklahomaMask.mat';
MaskList{228,2}='Merra2OklahomaMask';
MaskList{228,3}='Oklahoma';
MaskList{228,4}=181040;
MaskList{228,5}=228;
MaskList{229,1}='OregonMask.mat';
MaskList{229,2}='Merra2OregonMask';
MaskList{229,3}='Oregon';
MaskList{229,4}=254810;
MaskList{229,5}=229;
MaskList{230,1}='PennsylvaniaMask.mat';
MaskList{230,2}='Merra2PennsylvaniaMask';
MaskList{230,3}='Pennsylvania';
MaskList{230,4}=119280;
MaskList{230,5}=230;
MaskList{231,1}='RhodeIslandMask.mat';
MaskList{231,2}='Merra2RhodeIslandMask';
MaskList{231,3}='RhodeIsland';
MaskList{231,4}=3144;
MaskList{231,5}=231;
MaskList{232,1}='SouthCarolinaMask.mat';
MaskList{232,2}='Merra2SouthCarolinaMask';
MaskList{232,3}='SouthCarolina';
MaskList{232,4}=82932;
MaskList{232,5}=232;
MaskList{233,1}='SouthDakotaMask.mat';
MaskList{233,2}='Merra2SouthDakotaMask';
MaskList{233,3}='SouthDakota';
MaskList{233,4}=199730;
MaskList{233,5}=233;
MaskList{234,1}='TennesseeMask.mat';
MaskList{234,2}='Merra2TennesseeMask';
MaskList{234,3}='Tennessee';
MaskList{234,4}=109150;
MaskList{234,5}=234;
MaskList{235,1}='TexasMask.mat';
MaskList{235,2}='Merra2TexasMask';
MaskList{235,3}='Texas';
MaskList{235,4}=695663;
MaskList{235,5}=235;
MaskList{236,1}='UtahMask.mat';
MaskList{236,2}='Merra2UtahMask';
MaskList{236,3}='Utah';
MaskList{236,4}=219890;
MaskList{236,5}=236;
MaskList{237,1}='VermontMask.mat';
MaskList{237,2}='Merra2VermontMask';
MaskList{237,3}='Vermont';
MaskList{237,4}=24910;
MaskList{237,5}=237;
MaskList{238,1}='VirginiaMask.mat';
MaskList{238,2}='Merra2VirginiaMask';
MaskList{238,3}='Virginia';
MaskList{238,4}=110790;
MaskList{238,5}=238;
MaskList{239,1}='WashingtonMask.mat';
MaskList{239,2}='Merra2WashingtonMask';
MaskList{239,3}='Washington';
MaskList{239,4}=110790;
MaskList{239,5}=239;
MaskList{240,1}='WestVirginiaMask.mat';
MaskList{240,2}='Merra2WestVirginiaMask';
MaskList{240,3}='WestVirginia';
MaskList{240,4}=62756;
MaskList{240,5}=240;
MaskList{241,1}='WisconsinMask.mat';
MaskList{241,2}='Merra2WisconsinMask';
MaskList{241,3}='Wisconsin';
MaskList{241,4}=169640;
MaskList{241,5}=241;
MaskList{242,1}='WyomingMask.mat';
MaskList{242,2}='Merra2WyomingMask';
MaskList{242,3}='Wyoming';
MaskList{242,4}=253600;
MaskList{242,5}=242;



%% Reopen the individual mask files to retrieve the number of points in the mask that fall within the geographic boundaries
ntotgrid=576*361;
for n=1:242
    ival=MaskList{n,5};
    if(ival>0)
        igo=1;
    else
        igo=0;
    end
    if(igo==1)
        maskFile=char(MaskList{n,1});
        maskVar=char(MaskList{n,2});
        try
            load(maskFile,maskVar);
        catch
            ab=1;
        end
        Merra2WorkingMask=eval(maskVar);
        numingrid=sum(sum( Merra2WorkingMask));
        fracgrid=numingrid/ntotgrid;
        MaskList{n,6}=numingrid;
        MaskList{n,7}=fracgrid;
    else
        MaskList{n,6}=0;
        MaskList{n,7}=0;
    end
    ab=1;
    dispstr=strcat('Processed Mask File-',maskFile);
    disp(dispstr)
end
%% Save this mask list for future use
eval(['cd ' maskpath(1:length(maskpath)-1)]);
actionstr='save';
varstr=' MaskList';
MatFileName=MaskListFileName;
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Merra2Consolidated Mask List To File -',MatFileName);
disp(dispstr)
ab=1;










end