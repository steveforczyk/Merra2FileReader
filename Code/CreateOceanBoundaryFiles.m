% This script will read a specific file contain ocean and sea boundaries
% and save these to a set of files
%
% Written By: Stephen Forczyk
% Created: Sept 23,2023
% Revised: Oct 10,2023 add step to save SeaMaskList
% Classification: Unclassified/Public Domain
global ShapeFileName SeaMaskList;
global SeaBoundaryFiles;

global matpath matlabpath maskpath shapefilepath;
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath;
global ipowerpoint PowerPointFile scaling stretching padding;

%% Set Up Fixed Paths
shapefilepath='D:\Forczyk\Map_Data\Downloaded_Shapefiles\World_Seas_IHO_v3\';
matlabpath='D:\Forczyk\Map_Data\Matlab_Maps_Oceans\';
maskpath='K:\Merra-2\Water_Masks\';
%% Set Up Fixed Variables/Flags
ShapeFileName='World_Seas_IHO_v3.shp';
%% Set Up any cell variables
SeaBoundaryFiles=cell(102,6);
SeaBoundaryFiles{1,1}='ShapeFileSeaName';
SeaBoundaryFiles{1,2}='ShortSeaName';
SeaBoundaryFiles{1,3}='BoundaryFileName';
SeaBoundaryFiles{1,4}='Longitude Variable Name';
SeaBoundaryFiles{1,5}='Latitude Variable Name';
SeaBoundaryFiles{1,6}='Area-km^2';
SeaBoundaryFiles{2,1}='Rio del la Plata';
SeaBoundaryFiles{2,2}='RioDelLaPlata';
SeaBoundaryFiles{2,3}='RioDelLaPlataBoundaries.mat';
SeaBoundaryFiles{2,4}='RioDelLaPlataLon';
SeaBoundaryFiles{2,5}='RioDelLaPlataLat';
SeaBoundaryFiles{2,6}=31797;
SeaBoundaryFiles{3,1}='Bass Strait';
SeaBoundaryFiles{3,2}='BassStrait';
SeaBoundaryFiles{3,3}='BassStraightBoundaries.mat';
SeaBoundaryFiles{3,4}='BassStraitLon';
SeaBoundaryFiles{3,5}='BassStraitLat';
SeaBoundaryFiles{3,6}=112699;
SeaBoundaryFiles{4,1}='Great Australian Bight';
SeaBoundaryFiles{4,2}='GreatAustralianBight';
SeaBoundaryFiles{4,3}='GreatAustralianBightBoundaries.mat';
SeaBoundaryFiles{4,4}='GreatAustralianBightLon';
SeaBoundaryFiles{4,5}='GreatAustralianBightLat';
SeaBoundaryFiles{4,6}=1326209;
SeaBoundaryFiles{5,1}='Tasman Sea';
SeaBoundaryFiles{5,2}='TasmanSea';
SeaBoundaryFiles{5,3}='TasmanSeaBoundaries.mat';
SeaBoundaryFiles{5,4}='TasmanSeaLon';
SeaBoundaryFiles{5,5}='TasmanSeaLat';
SeaBoundaryFiles{5,6}=3344624;
SeaBoundaryFiles{6,1}='Mozambique Channel';
SeaBoundaryFiles{6,2}='MozambiqueChannel';
SeaBoundaryFiles{6,3}='MozambiqueChannelBoundaries.mat';
SeaBoundaryFiles{6,4}='MozambiqueChannelLon';
SeaBoundaryFiles{6,5}='MozambiqueChannelLat';
SeaBoundaryFiles{6,6}=1394283;
SeaBoundaryFiles{7,1}='Savu Sea';
SeaBoundaryFiles{7,2}='SavuSea';
SeaBoundaryFiles{7,3}='SavuSeaBoundaries.mat';
SeaBoundaryFiles{7,4}='SavuSeaLon';
SeaBoundaryFiles{7,5}='SavuSeaLat';
SeaBoundaryFiles{7,6}=106234;
SeaBoundaryFiles{8,1}='Timor Sea';
SeaBoundaryFiles{8,2}='TimorSea';
SeaBoundaryFiles{8,3}='TimorSeaBoundaries.mat';
SeaBoundaryFiles{8,4}='TimorSeaLon';
SeaBoundaryFiles{8,5}='TimorSeaLat';
SeaBoundaryFiles{8,6}=434186;
SeaBoundaryFiles{9,1}='Bali Sea';
SeaBoundaryFiles{9,2}='BaliSea';
SeaBoundaryFiles{9,3}='BaliSeaBoundaries.mat';
SeaBoundaryFiles{9,4}='BaliSeaLon';
SeaBoundaryFiles{9,5}='BaliSeaLat';
SeaBoundaryFiles{9,6}=39916;
SeaBoundaryFiles{10,1}='Coral Sea';
SeaBoundaryFiles{10,2}='CoralSea';
SeaBoundaryFiles{10,3}='CoralSeaBoundaries.mat';
SeaBoundaryFiles{10,4}='CoralSeaLon';
SeaBoundaryFiles{10,5}='CoralSeaLat';
SeaBoundaryFiles{10,6}=4125541;
SeaBoundaryFiles{11,1}='Flores Sea';
SeaBoundaryFiles{11,2}='FloresSea';
SeaBoundaryFiles{11,3}='FloresSeaBoundaries.mat';
SeaBoundaryFiles{11,4}='FloresSeaLon';
SeaBoundaryFiles{11,5}='FloresSeaLat';
SeaBoundaryFiles{11,6}=102816;
SeaBoundaryFiles{12,1}='Solomon Sea';
SeaBoundaryFiles{12,2}='SolomonSea';
SeaBoundaryFiles{12,3}='SolomonSeaBoundaries.mat';
SeaBoundaryFiles{12,4}='SolomonSeaLon';
SeaBoundaryFiles{12,5}='SolomonSeaLat';
SeaBoundaryFiles{12,6}=744334;
SeaBoundaryFiles{13,1}='Arafura Sea';
SeaBoundaryFiles{13,2}='ArafuraSea';
SeaBoundaryFiles{13,3}='ArafuraSeaBoundaries.mat';
SeaBoundaryFiles{13,4}='ArafuraSeaLon';
SeaBoundaryFiles{13,5}='ArafuraSeaLat';
SeaBoundaryFiles{13,6}=1025736;
SeaBoundaryFiles{14,1}='GulfOfBoni';
SeaBoundaryFiles{14,2}='GulfOfBoni';
SeaBoundaryFiles{14,3}='GulfOfBoniBoundaries.mat';
SeaBoundaryFiles{14,4}='GulfOfBoniLon';
SeaBoundaryFiles{14,5}='GulfOfBoniLat';
SeaBoundaryFiles{14,6}=33227;
SeaBoundaryFiles{15,1}='Java Sea';
SeaBoundaryFiles{15,2}='JavaSea';
SeaBoundaryFiles{15,3}='JavaSeaBoundaries.mat';
SeaBoundaryFiles{15,4}='JavaSeaLon';
SeaBoundaryFiles{15,5}='JavaSeaLat';
SeaBoundaryFiles{15,6}=566693;
SeaBoundaryFiles{16,1}='Ceram Sea';
SeaBoundaryFiles{16,2}='CeramSea';
SeaBoundaryFiles{16,3}='CeramSeaBoundaries.mat';
SeaBoundaryFiles{16,4}='CeramSeaLon';
SeaBoundaryFiles{16,5}='CeramSeaLat';
SeaBoundaryFiles{16,6}=161489;
SeaBoundaryFiles{17,1}='Bismark Sea';
SeaBoundaryFiles{17,2}='BismarkSea';
SeaBoundaryFiles{17,3}='BismarkSeaBoundaries.mat';
SeaBoundaryFiles{17,4}='BismarkSeaLon';
SeaBoundaryFiles{17,5}='BismarkSeaLat';
SeaBoundaryFiles{17,6}=345053;
SeaBoundaryFiles{18,1}='Banda Sea';
SeaBoundaryFiles{18,2}='BandaSea';
SeaBoundaryFiles{18,3}='BandaSeaBoundaries.mat';
SeaBoundaryFiles{18,4}='BandaSeaLon';
SeaBoundaryFiles{18,5}='BandaSeaLat';
SeaBoundaryFiles{18,6}=693842;
SeaBoundaryFiles{19,1}='Gulf Of California';
SeaBoundaryFiles{19,2}='GulfOfCalifornia';
SeaBoundaryFiles{19,3}='GulfOfCaliforniaBoundaries.mat';
SeaBoundaryFiles{19,4}='GulfOfCaliforniaLon';
SeaBoundaryFiles{19,5}='GulfOfCaliforniaLat';
SeaBoundaryFiles{19,6}=180703;
SeaBoundaryFiles{20,1}='Bay Of Fundy';
SeaBoundaryFiles{20,2}='BayOfFundy';
SeaBoundaryFiles{20,3}='BayOfFundyBoundaries.mat';
SeaBoundaryFiles{20,4}='BayOfFundyLon';
SeaBoundaryFiles{20,5}='BayOfFundyLat';
SeaBoundaryFiles{20,6}=16034;
SeaBoundaryFiles{21,1}='Strait Of Gibraltar';
SeaBoundaryFiles{21,2}='StraitOfGibraltar';
SeaBoundaryFiles{21,3}='StraitofGibraltarBoundaries.mat';
SeaBoundaryFiles{21,4}='StraitofGibraltarLon';
SeaBoundaryFiles{21,5}='StraitofGibraltarLat';
SeaBoundaryFiles{21,6}=1664;
SeaBoundaryFiles{22,1}='Alboran Sea';
SeaBoundaryFiles{22,2}='AlboranSea';
SeaBoundaryFiles{22,3}='AlboranSeaBoundaries.mat';
SeaBoundaryFiles{22,4}='AlboranSeaLon';
SeaBoundaryFiles{22,5}='AlboranSeaLat';
SeaBoundaryFiles{22,6}=54711;
SeaBoundaryFiles{23,1}='Caribbean Sea';
SeaBoundaryFiles{23,2}='CaribbeanSea';
SeaBoundaryFiles{23,3}='CaribbeanSeaBoundaries.mat';
SeaBoundaryFiles{23,4}='CaribbeanSeaLon';
SeaBoundaryFiles{23,5}='CaribbeanSeaLat';
SeaBoundaryFiles{23,6}=2852792;
SeaBoundaryFiles{24,1}='Gulf Of Alaska';
SeaBoundaryFiles{24,2}='GulfOfAlaska';
SeaBoundaryFiles{24,3}='GulfOfAlaskaBoundaries.mat';
SeaBoundaryFiles{24,4}='GufOfAlaskaLon';
SeaBoundaryFiles{24,5}='GulfOfAlaskaLat';
SeaBoundaryFiles{24,6}=415503;
SeaBoundaryFiles{25,1}='Bering Sea';
SeaBoundaryFiles{25,2}='BeringSea';
SeaBoundaryFiles{25,3}='BeringSeaBoundaries.mat';
SeaBoundaryFiles{25,4}='BeringSeaLon';
SeaBoundaryFiles{25,5}='BeringSeaLat';
SeaBoundaryFiles{25,6}=2336912;
SeaBoundaryFiles{26,1}='Chukchi Sea';
SeaBoundaryFiles{26,2}='ChukchiSea';
SeaBoundaryFiles{26,3}='ChukchiSeaBoundaries.mat';
SeaBoundaryFiles{26,4}='ChukchiSeaLon';
SeaBoundaryFiles{26,5}='ChukchiSeaLat';
SeaBoundaryFiles{26,6}=346259;
SeaBoundaryFiles{27,1}='Beaufort Sea';
SeaBoundaryFiles{27,2}='BeaufortSea';
SeaBoundaryFiles{27,3}='BeaufortSeaBoundaries.mat';
SeaBoundaryFiles{27,4}='BeaufortSeaLon';
SeaBoundaryFiles{27,5}='BeaufortSeaLat';
SeaBoundaryFiles{27,6}=431132;
SeaBoundaryFiles{28,1}='Labrador Sea';
SeaBoundaryFiles{28,2}='LabradorSea';
SeaBoundaryFiles{28,3}='LabradorSeaBoundaries.mat';
SeaBoundaryFiles{28,4}='LabradorSeaLon';
SeaBoundaryFiles{28,5}='LabradorSeaLat';
SeaBoundaryFiles{28,6}=866470;
SeaBoundaryFiles{29,1}='Hudson Strait';
SeaBoundaryFiles{29,2}='HudsonStrait';
SeaBoundaryFiles{29,3}='HudsonStraitBoundaries.mat';
SeaBoundaryFiles{29,4}='HudsonStraitLon';
SeaBoundaryFiles{29,5}='HudsonStraitLat';
SeaBoundaryFiles{29,6}=200039;
SeaBoundaryFiles{30,1}='Davis Strait';
SeaBoundaryFiles{30,2}='DavisStrait';
SeaBoundaryFiles{30,3}='DavisStraitBoundaries.mat';
SeaBoundaryFiles{30,4}='DavisStraitLon';
SeaBoundaryFiles{30,5}='DavisStraitLat';
SeaBoundaryFiles{30,6}=749737;
SeaBoundaryFiles{31,1}='Baffin Bay';
SeaBoundaryFiles{31,2}='BaffinBay';
SeaBoundaryFiles{31,3}='BaffinBayBoundaries.mat';
SeaBoundaryFiles{31,4}='BaffinBayLon';
SeaBoundaryFiles{31,5}='BaffinBayLat';
SeaBoundaryFiles{31,6}=529960;
SeaBoundaryFiles{32,1}='Lincoln Sea';
SeaBoundaryFiles{32,2}='LincolnSea';
SeaBoundaryFiles{32,3}='LincolnSeaBoundaries.mat';
SeaBoundaryFiles{32,4}='LincolnSeaLon';
SeaBoundaryFiles{32,5}='LincolnSeaLat';
SeaBoundaryFiles{32,6}=35262;
SeaBoundaryFiles{33,1}='Bristol Channel';
SeaBoundaryFiles{33,2}='BristolChannel';
SeaBoundaryFiles{33,3}='BristolChannelBoundaries.mat';
SeaBoundaryFiles{33,4}='BristolChannelLon';
SeaBoundaryFiles{33,5}='BristolChannelLat';
SeaBoundaryFiles{33,6}=5748;
SeaBoundaryFiles{34,1}='Irish Sea';
SeaBoundaryFiles{34,2}='IrishSea';
SeaBoundaryFiles{34,3}='IrishSeaBoundaries.mat';
SeaBoundaryFiles{34,4}='IrishSeaLon';
SeaBoundaryFiles{34,5}='IrishSeaLat';
SeaBoundaryFiles{34,6}=45922;
SeaBoundaryFiles{35,1}='Inner Sea';
SeaBoundaryFiles{35,2}='InnerSea';
SeaBoundaryFiles{35,3}='InnerSeaBoundaries.mat';
SeaBoundaryFiles{35,4}='InnerSeaLon';
SeaBoundaryFiles{35,5}='InnerSeaLat';
SeaBoundaryFiles{35,6}=44260;
SeaBoundaryFiles{36,1}='Gulf Of Aden';
SeaBoundaryFiles{36,2}='GulfOfAden';
SeaBoundaryFiles{36,3}='GulfOfAdenBoundaries.mat';
SeaBoundaryFiles{36,4}='GulfOfAdenLon';
SeaBoundaryFiles{36,5}='GulfOfAdenLat';
SeaBoundaryFiles{36,6}=263754;
SeaBoundaryFiles{37,1}='Gulf Of Oman';
SeaBoundaryFiles{37,2}='GulfOfOman';
SeaBoundaryFiles{37,3}='GulfOfOmanBoundaries.mat';
SeaBoundaryFiles{37,4}='GulfOfOmanLon';
SeaBoundaryFiles{37,5}='GulfOfOmanLat';
SeaBoundaryFiles{37,6}=111892;
SeaBoundaryFiles{38,1}='Red Sea';
SeaBoundaryFiles{38,2}='RedSea';
SeaBoundaryFiles{38,3}='RedSeaBoundaries.mat';
SeaBoundaryFiles{38,4}='RedSeaLon';
SeaBoundaryFiles{38,5}='RedSeaLat';
SeaBoundaryFiles{38,6}=449811;
SeaBoundaryFiles{39,1}='Gulf Of Aqaba';
SeaBoundaryFiles{39,2}='GulfOfAqaba';
SeaBoundaryFiles{39,3}='GulfOfAqabaBoundaries.mat';
SeaBoundaryFiles{39,4}='GulfOfAqabaLon';
SeaBoundaryFiles{39,5}='GulfOfAqabaLat';
SeaBoundaryFiles{39,6}=3555;
SeaBoundaryFiles{40,1}='Persian Gulf';
SeaBoundaryFiles{40,2}='PersianGulf';
SeaBoundaryFiles{40,3}='PersianGulfBoundaries.mat';
SeaBoundaryFiles{40,4}='PersianGulfLon';
SeaBoundaryFiles{40,5}='PersianGulfLat';
SeaBoundaryFiles{40,6}=244657;
SeaBoundaryFiles{41,1}='Ionian Sea';
SeaBoundaryFiles{41,2}='IonianSea';
SeaBoundaryFiles{41,3}='IonianSeaBoundaries.mat';
SeaBoundaryFiles{41,4}='IonianSeaLon';
SeaBoundaryFiles{41,5}='IonianSeaLat';
SeaBoundaryFiles{41,6}=171778;
SeaBoundaryFiles{42,1}='Tyrrhenian Sea';
SeaBoundaryFiles{42,2}='TyrrhenianSea';
SeaBoundaryFiles{42,3}='TyrrhenianSeaBoundaries.mat';
SeaBoundaryFiles{42,4}='TyrrhenianSeaLon';
SeaBoundaryFiles{42,5}='TyrrhenianSeaLat';
SeaBoundaryFiles{42,6}=217465;
SeaBoundaryFiles{43,1}='Adriatic Sea';
SeaBoundaryFiles{43,2}='AdriaticSea';
SeaBoundaryFiles{43,3}='AdriaticSeaBoundaries.mat';
SeaBoundaryFiles{43,4}='AdriaticSeaLon';
SeaBoundaryFiles{43,5}='AdriaticSeaLat';
SeaBoundaryFiles{43,6}=139454;
SeaBoundaryFiles{44,1}='Gulf Of Suez';
SeaBoundaryFiles{44,2}='GulfOfSuez';
SeaBoundaryFiles{44,3}='GulfOfSuezBoundaries.mat';
SeaBoundaryFiles{44,4}='GulfOfSuezLon';
SeaBoundaryFiles{44,5}='GulfOfSuezLat';
SeaBoundaryFiles{44,6}=10438;
SeaBoundaryFiles{45,1}='Mead Sea East';
SeaBoundaryFiles{45,2}='MeadSeaEast';
SeaBoundaryFiles{45,3}='MeadSeaEastBoundaries.mat';
SeaBoundaryFiles{45,4}='MeadSeaEastLon';
SeaBoundaryFiles{45,5}='MeadSeaEastLat';
SeaBoundaryFiles{45,6}=1173640;
SeaBoundaryFiles{46,1}='Aegean Sea';
SeaBoundaryFiles{46,2}='AegeanSea';
SeaBoundaryFiles{46,3}='AegeanSeaBoundaries.mat';
SeaBoundaryFiles{46,4}='AegeanSeaLon';
SeaBoundaryFiles{46,5}='AegeanSeaLat';
SeaBoundaryFiles{46,6}=191305;
SeaBoundaryFiles{47,1}='Sea Of Marmara';
SeaBoundaryFiles{47,2}='SeaOfMarmara';
SeaBoundaryFiles{47,3}='SeaOfMarmaraBoundaries.mat';
SeaBoundaryFiles{47,4}='SeaOfMarmaraLon';
SeaBoundaryFiles{47,5}='SeaOfMarmaraLat';
SeaBoundaryFiles{47,6}=11675;
SeaBoundaryFiles{48,1}='Singapore Strait';
SeaBoundaryFiles{48,2}='SingaporeStrait';
SeaBoundaryFiles{48,3}='SingaporeStraitBoundaries.mat';
SeaBoundaryFiles{48,4}='SingaporeStraitLon';
SeaBoundaryFiles{48,5}='SingaporeStraitLat';
SeaBoundaryFiles{48,6}=2684;
SeaBoundaryFiles{49,1}='Celebes Sea';
SeaBoundaryFiles{49,2}='CelebesSea';
SeaBoundaryFiles{49,3}='CelebesSeaBoundaries.mat';
SeaBoundaryFiles{49,4}='CelebesSeaLon';
SeaBoundaryFiles{49,5}='CelebesSeaLat';
SeaBoundaryFiles{49,6}=457342;
SeaBoundaryFiles{50,1}='Malacca Strait';
SeaBoundaryFiles{50,2}='MalaccaStrait';
SeaBoundaryFiles{50,3}='MalaccaStraitBoundaries.mat';
SeaBoundaryFiles{50,4}='MalaccaStraitLon';
SeaBoundaryFiles{50,5}='MalaccaStraitLat';
SeaBoundaryFiles{50,6}=195534;
SeaBoundaryFiles{51,1}='Sulu Sea';
SeaBoundaryFiles{51,2}='SuluSea';
SeaBoundaryFiles{51,3}='SuluSeaBoundaries.mat';
SeaBoundaryFiles{51,4}='SuluSeaLon';
SeaBoundaryFiles{51,5}='SuluSeaLat';
SeaBoundaryFiles{51,6}=337029;
SeaBoundaryFiles{52,1}='Gulf Of Thailand';
SeaBoundaryFiles{52,2}='GulfOfThailand';
SeaBoundaryFiles{52,3}='GulfOfThailandBoundaries.mat';
SeaBoundaryFiles{52,4}='GulfOfThailandLon';
SeaBoundaryFiles{52,5}='GulfOfThailandLat';
SeaBoundaryFiles{52,6}=297927;
SeaBoundaryFiles{53,1}='Eastern China Sea';
SeaBoundaryFiles{53,2}='EasternChinaSea';
SeaBoundaryFiles{53,3}='EasternChinaSeaBoundaries.mat';
SeaBoundaryFiles{53,4}='EasternChinaSeaLon';
SeaBoundaryFiles{53,5}='EasternChinaSeaLat';
SeaBoundaryFiles{53,6}=761356;
SeaBoundaryFiles{54,1}='Inland Sea';
SeaBoundaryFiles{54,2}='InlandSea';
SeaBoundaryFiles{54,3}='InlandSeaBoundaries.mat';
SeaBoundaryFiles{54,4}='InlandSeaLon';
SeaBoundaryFiles{54,5}='InlandSeaLat';
SeaBoundaryFiles{54,6}=18131;
SeaBoundaryFiles{55,1}='Philippine Sea';
SeaBoundaryFiles{55,2}='PhilippineSea';
SeaBoundaryFiles{55,3}='PhilippineSeaBoundaries.mat';
SeaBoundaryFiles{55,4}='PhilippineSeaLon';
SeaBoundaryFiles{55,5}='PhilippineSeaLat';
SeaBoundaryFiles{55,6}=5641996;
SeaBoundaryFiles{56,1}='Yellow Sea';
SeaBoundaryFiles{56,2}='YellowSea';
SeaBoundaryFiles{56,3}='YellowSeaBoundaries.mat';
SeaBoundaryFiles{56,4}='YellowSeaLon';
SeaBoundaryFiles{56,5}='YellowSeaLat';
SeaBoundaryFiles{56,6}=408198;
SeaBoundaryFiles{57,1}='Gulf Of Riga';
SeaBoundaryFiles{57,2}='GulfOfRiga';
SeaBoundaryFiles{57,3}='GulfofRigaBoundaries.mat';
SeaBoundaryFiles{57,4}='GulfOfRigaLon';
SeaBoundaryFiles{57,5}='GulfOfRigaLat';
SeaBoundaryFiles{57,6}=18692;
SeaBoundaryFiles{58,1}='Baltic Sea';
SeaBoundaryFiles{58,2}='BalticSea';
SeaBoundaryFiles{58,3}='BalticSeaBoundaries.mat';
SeaBoundaryFiles{58,4}='BalticSeaLon';
SeaBoundaryFiles{58,5}='BalticSeaLat';
SeaBoundaryFiles{58,6}=215863;
SeaBoundaryFiles{59,1}='Gulf Of Finland';
SeaBoundaryFiles{59,2}='GulfOfFinland';
SeaBoundaryFiles{59,3}='GulfOfFinlandBoundaries.mat';
SeaBoundaryFiles{59,4}='GulfOfFinlandLon';
SeaBoundaryFiles{59,5}='GulfOfFinlandLat';
SeaBoundaryFiles{59,6}=57077;
SeaBoundaryFiles{60,1}='Gulf Of Bothnia';
SeaBoundaryFiles{60,2}='GulfOfBothnia';
SeaBoundaryFiles{60,3}='GulfOfBothniaBoundaries.mat';
SeaBoundaryFiles{60,4}='GulfOfBothniaLon';
SeaBoundaryFiles{60,5}='GulfOfBothniaLat';
SeaBoundaryFiles{60,6}=113419;
SeaBoundaryFiles{61,1}='White Sea';
SeaBoundaryFiles{61,2}='WhiteSea';
SeaBoundaryFiles{61,3}='WhiteSeaBoundaries.mat';
SeaBoundaryFiles{61,4}='WhiteSeaLon';
SeaBoundaryFiles{61,5}='WhiteSeaLat';
SeaBoundaryFiles{61,6}=90531;
SeaBoundaryFiles{62,1}='East Siberian Sea';
SeaBoundaryFiles{62,2}='EastSiberianSea';
SeaBoundaryFiles{62,3}='EastSiberianSeaBoundaries.mat';
SeaBoundaryFiles{62,4}='EastSiberianSeaLon';
SeaBoundaryFiles{62,5}='EastSiberianSeaLat';
SeaBoundaryFiles{62,6}=633057;
SeaBoundaryFiles{63,1}='South Atlantic Ocean';
SeaBoundaryFiles{63,2}='SouthAtlanticOcean';
SeaBoundaryFiles{63,3}='SouthAtlanticOceanBoundaries.mat';
SeaBoundaryFiles{63,4}='SouthAtlanticOceanLon';
SeaBoundaryFiles{63,5}='SouthAtlanticOceanLat';
SeaBoundaryFiles{63,6}=40501812;
SeaBoundaryFiles{64,1}='Southern Ocean';
SeaBoundaryFiles{64,2}='SouthernOcean';
SeaBoundaryFiles{64,3}='SouthernOceanBoundaries.mat';
SeaBoundaryFiles{64,4}='SouthernOceanLon';
SeaBoundaryFiles{64,5}='SouthernOceanLat';
SeaBoundaryFiles{64,6}=21695157;
SeaBoundaryFiles{65,1}='South Pacific Ocean';
SeaBoundaryFiles{65,2}='SouthPacificOcean';
SeaBoundaryFiles{65,3}='SouthPacificOceanBoundaries.mat';
SeaBoundaryFiles{65,4}='SouthPacificOceanLon';
SeaBoundaryFiles{65,5}='SouthPacificOceanLat';
SeaBoundaryFiles{65,6}=76681173;
SeaBoundaryFiles{66,1}='Gulf Of Tomini';
SeaBoundaryFiles{66,2}='GulfOfTomini';
SeaBoundaryFiles{66,3}='GulfOfTominiBoundaries.mat';
SeaBoundaryFiles{66,4}='GulfOfTominiLon';
SeaBoundaryFiles{66,5}='GulfOfTominiLat';
SeaBoundaryFiles{66,6}=56739;
SeaBoundaryFiles{67,1}='Makassar Strait';
SeaBoundaryFiles{67,2}='MakassarStrait';
SeaBoundaryFiles{67,3}='MakassarStraitBoundaries.mat';
SeaBoundaryFiles{67,4}='MakassarStraitLon';
SeaBoundaryFiles{67,5}='MakassarStraitLat';
SeaBoundaryFiles{67,6}=198117;
SeaBoundaryFiles{68,1}='Halmahera Sea';
SeaBoundaryFiles{68,2}='HalmaheraSea';
SeaBoundaryFiles{68,3}='HalmaheraSeaBoundaries.mat';
SeaBoundaryFiles{68,4}='HalmaheraSeaLon';
SeaBoundaryFiles{68,5}='HalmaheraSeaLat';
SeaBoundaryFiles{68,6}=75295;
SeaBoundaryFiles{69,1}='Molukka Sea';
SeaBoundaryFiles{69,2}='MolukkaSea';
SeaBoundaryFiles{69,3}='MolukkaSeaBoundaries.mat';
SeaBoundaryFiles{69,4}='MolukkaSeaLon';
SeaBoundaryFiles{69,5}='MolukkaSeaLat';
SeaBoundaryFiles{69,6}=221671;
SeaBoundaryFiles{70,1}='Indian Ocean';
SeaBoundaryFiles{70,2}='IndianOcean';
SeaBoundaryFiles{70,3}='IndianOceanBoundaries.mat';
SeaBoundaryFiles{70,4}='IndianOceanLon';
SeaBoundaryFiles{70,5}='IndianOceanLat';
SeaBoundaryFiles{70,6}=58230954;
SeaBoundaryFiles{71,1}='Bay Of Bengal';
SeaBoundaryFiles{71,2}='BayOfBengal';
SeaBoundaryFiles{71,3}='BayOfBengalBoundaries.mat';
SeaBoundaryFiles{71,4}='BayOfBengalLon';
SeaBoundaryFiles{71,5}='BayOfBengalLat';
SeaBoundaryFiles{71,6}=2207565;
SeaBoundaryFiles{72,1}='South China Sea';
SeaBoundaryFiles{72,2}='SouthChinaSea';
SeaBoundaryFiles{72,3}='SouthChinaSeaBoundaries.mat';
SeaBoundaryFiles{72,4}='SouthChinaSeaLon';
SeaBoundaryFiles{72,5}='SouthChinaSeaLat';
SeaBoundaryFiles{72,6}=3362904;
SeaBoundaryFiles{73,1}='Arabian Sea';
SeaBoundaryFiles{73,2}='ArabianSea';
SeaBoundaryFiles{73,3}='ArabianSeaBoundaries.mat';
SeaBoundaryFiles{73,4}='ArabianSeaLon';
SeaBoundaryFiles{73,5}='ArabianSeaLat';
SeaBoundaryFiles{73,6}=4241184;
SeaBoundaryFiles{74,1}='North Pacific Ocean';
SeaBoundaryFiles{74,2}='NorthPacificOcean';
SeaBoundaryFiles{74,3}='NorthPacificOceanBoundaries.mat';
SeaBoundaryFiles{74,4}='NorthPacificOceanLon';
SeaBoundaryFiles{74,5}='NorthPacificOceanLat';
SeaBoundaryFiles{74,6}=65154681;
SeaBoundaryFiles{75,1}='Alaska Coastal Waters';
SeaBoundaryFiles{75,2}='AlaskaCoastalWaters';
SeaBoundaryFiles{75,3}='AlaskaCoastalWatersBoundaries.mat';
SeaBoundaryFiles{75,4}='AlaskaCoastalWatersLon';
SeaBoundaryFiles{75,5}='AlaskaCoastalWatersLat';
SeaBoundaryFiles{75,6}=124532;
SeaBoundaryFiles{76,1}='Gulf Of Mexico';
SeaBoundaryFiles{76,2}='GulfOfMexico';
SeaBoundaryFiles{76,3}='GulfOfMexicoBoundaries.mat';
SeaBoundaryFiles{76,4}='GulfOfMexicoLon';
SeaBoundaryFiles{76,5}='GulfOfMexicoLat';
SeaBoundaryFiles{76,6}=1566759;
SeaBoundaryFiles{77,1}='North Atlantic Ocean';
SeaBoundaryFiles{77,2}='NorthAtlanticOcean';
SeaBoundaryFiles{77,3}='NorthAtlanticOceanBoundaries.mat';
SeaBoundaryFiles{77,4}='NorthAtlanticOceanLon';
SeaBoundaryFiles{77,5}='NorthAtlanticOceanLat';
SeaBoundaryFiles{77,6}=34507128;
SeaBoundaryFiles{78,1}='Gulf Of StLawrence';
SeaBoundaryFiles{78,2}='GulfOfStLawrence';
SeaBoundaryFiles{78,3}='GulfOfStLawrenceBoundaries.mat';
SeaBoundaryFiles{78,4}='GulfOfStLawrenceLon';
SeaBoundaryFiles{78,5}='GulfOfStLawrenceLat';
SeaBoundaryFiles{78,6}=290874;
SeaBoundaryFiles{79,1}='Iberian Sea';
SeaBoundaryFiles{79,2}='IberianSea';
SeaBoundaryFiles{79,3}='IberianSeaBoundaries.mat';
SeaBoundaryFiles{79,4}='IberianSeaLon';
SeaBoundaryFiles{79,5}='IberianSeaLat';
SeaBoundaryFiles{79,6}=80078;
SeaBoundaryFiles{80,1}='Bay Of Biscay';
SeaBoundaryFiles{80,2}='BayOfBiscay';
SeaBoundaryFiles{80,3}='BayOfBiscayBoundaries.mat';
SeaBoundaryFiles{80,4}='BayOfBiscayLon';
SeaBoundaryFiles{80,5}='BayOfBiscayLat';
SeaBoundaryFiles{80,6}=174437;
SeaBoundaryFiles{81,1}='Celtic Sea';
SeaBoundaryFiles{81,2}='CelticSea';
SeaBoundaryFiles{81,3}='CelticSeaBoundaries.mat';
SeaBoundaryFiles{81,4}='CelticSeaLon';
SeaBoundaryFiles{81,5}='CelticSeaLat';
SeaBoundaryFiles{81,6}=215080;
SeaBoundaryFiles{82,1}='Med Sea West';
SeaBoundaryFiles{82,2}='MedSeaWest';
SeaBoundaryFiles{82,3}='MedSeaWestBoundaries.mat';
SeaBoundaryFiles{82,4}='MedSeaWestLon';
SeaBoundaryFiles{82,5}='MedSeaWestLat';
SeaBoundaryFiles{82,6}=476707;
SeaBoundaryFiles{83,1}='Hudson Bay';
SeaBoundaryFiles{83,2}='HudsonBay';
SeaBoundaryFiles{83,3}='HudsonBayBoundaries.mat';
SeaBoundaryFiles{83,4}='HudsonBayLon';
SeaBoundaryFiles{83,5}='HudsonBayLat';
SeaBoundaryFiles{83,6}=832649;
SeaBoundaryFiles{84,1}='NorthWest Passage';
SeaBoundaryFiles{84,2}='NorthWestPassage';
SeaBoundaryFiles{84,3}='NorthWestPassageBoundaries.mat';
SeaBoundaryFiles{84,4}='NorthWestPassageLon';
SeaBoundaryFiles{84,5}='NorthWestPassageLat';
SeaBoundaryFiles{84,6}=1062173;
SeaBoundaryFiles{85,1}='Arctic Ocean';
SeaBoundaryFiles{85,2}='ArcticOcean';
SeaBoundaryFiles{85,3}='ArcticOceanBoundaries.mat';
SeaBoundaryFiles{85,4}='ArcticOceanLon';
SeaBoundaryFiles{85,5}='ArcticOceanLat';
SeaBoundaryFiles{85,6}=5120993;
SeaBoundaryFiles{86,1}='English Channel';
SeaBoundaryFiles{86,2}='EnglishChannel';
SeaBoundaryFiles{86,3}='EnglishChannelBoundaries.mat';
SeaBoundaryFiles{86,4}='EnglishChannelLon';
SeaBoundaryFiles{86,5}='EnglishChannelLat';
SeaBoundaryFiles{86,6}=81419;
SeaBoundaryFiles{87,1}='Barents Sea';
SeaBoundaryFiles{87,2}='BarentsSea';
SeaBoundaryFiles{87,3}='BarentsSeaBoundaries.mat';
SeaBoundaryFiles{87,4}='BarentsSeaLon';
SeaBoundaryFiles{87,5}='BarentsSeaLat';
SeaBoundaryFiles{87,6}=1408430;
SeaBoundaryFiles{88,1}='Greenland Sea';
SeaBoundaryFiles{88,2}='GreenlandSea';
SeaBoundaryFiles{88,3}='GreenlandSeaBoundaries.mat';
SeaBoundaryFiles{88,4}='GreenlandSeaLon';
SeaBoundaryFiles{88,5}='GreenlandSeaLat';
SeaBoundaryFiles{88,6}=1186456;
SeaBoundaryFiles{89,1}='North Sea';
SeaBoundaryFiles{89,2}='NorthSea';
SeaBoundaryFiles{89,3}='NorthSeaBoundaries.mat';
SeaBoundaryFiles{89,4}='NorthSeaLon';
SeaBoundaryFiles{89,5}='NorthSeaLat';
SeaBoundaryFiles{89,6}=524493;
SeaBoundaryFiles{90,1}='Andaman Sea';
SeaBoundaryFiles{90,2}='AndamanSea';
SeaBoundaryFiles{90,3}='AndamanSeaBoundaries.mat';
SeaBoundaryFiles{90,4}='AndamanSeaLon';
SeaBoundaryFiles{90,5}='AndamanSeaLat';
SeaBoundaryFiles{90,6}=613099;
SeaBoundaryFiles{91,1}='Black Sea';
SeaBoundaryFiles{91,2}='BlackSea';
SeaBoundaryFiles{91,3}='BlackSeaBoundaries.mat';
SeaBoundaryFiles{91,4}='BlackSeaLon';
SeaBoundaryFiles{91,5}='BlackSeaLat';
SeaBoundaryFiles{91,6}=423026;
SeaBoundaryFiles{92,1}='Sea Of Azov';
SeaBoundaryFiles{92,2}='SeaOfAzov';
SeaBoundaryFiles{92,3}='SeaOfAzovBoundaries.mat';
SeaBoundaryFiles{92,4}='SeaOfAzovLon';
SeaBoundaryFiles{92,5}='SeaOfAzovLat';
SeaBoundaryFiles{92,6}=39547;
SeaBoundaryFiles{93,1}='Japan Sea';
SeaBoundaryFiles{93,2}='JapanSea';
SeaBoundaryFiles{93,3}='JapanSeaBoundaries.mat';
SeaBoundaryFiles{93,4}='JapanSeaLon';
SeaBoundaryFiles{93,5}='JapanSeaLat';
SeaBoundaryFiles{93,6}=1066307;
SeaBoundaryFiles{94,1}='Sea Of Okhotsk';
SeaBoundaryFiles{94,2}='SeaOfOkhotsk';
SeaBoundaryFiles{94,3}='SeaOfOkhotskBoundaries.mat';
SeaBoundaryFiles{94,4}='SeaOfOkhotskSeaLon';
SeaBoundaryFiles{94,5}='SeaOfOkhotskLat';
SeaBoundaryFiles{94,6}=1613208;
SeaBoundaryFiles{95,1}='Kara Sea';
SeaBoundaryFiles{95,2}='KaraSea';
SeaBoundaryFiles{95,3}='KaraSeaBoundaries.mat';
SeaBoundaryFiles{95,4}='KaraSeaLon';
SeaBoundaryFiles{95,5}='KaraSeaLat';
SeaBoundaryFiles{95,6}=896938;
SeaBoundaryFiles{96,1}='Laptev Sea';
SeaBoundaryFiles{96,2}='LaptevSea';
SeaBoundaryFiles{96,3}='LaptevSeaBoundaries.mat';
SeaBoundaryFiles{96,4}='KaraSeaLon';
SeaBoundaryFiles{96,5}='KaraSeaLat';
SeaBoundaryFiles{96,6}=513667;
SeaBoundaryFiles{97,1}='Kattegat';
SeaBoundaryFiles{97,2}='Kattegat';
SeaBoundaryFiles{97,3}='KattegatBoundaries.mat';
SeaBoundaryFiles{97,4}='KattegatSeaLon';
SeaBoundaryFiles{97,5}='KattegatLat';
SeaBoundaryFiles{97,6}=35447;
SeaBoundaryFiles{98,1}='Laccadive Sea';
SeaBoundaryFiles{98,2}='LaccadiveSea';
SeaBoundaryFiles{98,3}='LaccadiveSeaBoundaries.mat';
SeaBoundaryFiles{98,4}='LaccadiveSeaLon';
SeaBoundaryFiles{98,5}='LaccadiveSeaLat';
SeaBoundaryFiles{98,6}=846351;
SeaBoundaryFiles{99,1}='Skagerrack';
SeaBoundaryFiles{99,2}='Skagerrack';
SeaBoundaryFiles{99,3}='SkagerrackBoundaries.mat';
SeaBoundaryFiles{99,4}='SkagerrackLon';
SeaBoundaryFiles{99,5}='SkagerrackLat';
SeaBoundaryFiles{99,6}=32040;
SeaBoundaryFiles{100,1}='Norwegian Sea';
SeaBoundaryFiles{100,2}='NorwegianSea';
SeaBoundaryFiles{100,3}='NorwegianSeaBoundaries.mat';
SeaBoundaryFiles{100,4}='NorwegianSeaLon';
SeaBoundaryFiles{100,5}='NorwegianSeaLat';
SeaBoundaryFiles{100,6}=1437096;
SeaBoundaryFiles{101,1}='Ligurian Sea';
SeaBoundaryFiles{101,2}='LigurianSea';
SeaBoundaryFiles{101,3}='LigurianSeaBoundaries.mat';
SeaBoundaryFiles{101,4}='LigurianSeaLon';
SeaBoundaryFiles{101,5}='LigurianSeaLat';
SeaBoundaryFiles{101,6}=16949;
SeaBoundaryFiles{102,1}='Gulf Of Guinea';
SeaBoundaryFiles{102,2}='GulfOfGuinea';
SeaBoundaryFiles{102,3}='GulfOfGuineaBoundaries.mat';
SeaBoundaryFiles{102,4}='GulfOfGuineaLon';
SeaBoundaryFiles{102,5}='GulfOfGuineaLat';
SeaBoundaryFiles{102,6}=754844;
SeaMaskList=SeaBoundaryFiles;
% Save this list for a future dialog box
eval(['cd ' maskpath(1:length(maskpath)-1)]);
save Merra2ConsolidatedWaterMasks  SeaBoundaryFiles
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
%% Navigate to the location of the World Seas ShapeFile
eval(['cd ' shapefilepath(1:length(shapefilepath)-1)]);
S0 = shaperead(ShapeFileName,'UseGeoCoords',true);
numrows=length(S0);
ab=1;
eval(['cd ' matlabpath(1:length(matlabpath)-1)]);
for i=1:101
    nowName=S0(i).NAME;
    seaLat=S0(i).Lat';
    seaLon=S0(i).Lon';
    seaArea=S0(i).area;
    if(i==17)
        ab=2;
    end
    newName=SeaBoundaryFiles{i+1,2};
    MatFileName=strcat(newName,'Boundaries.mat');
    actionstr='save';
    varstr='seaLat seaLon seaArea nowName';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)

    dispstr=strcat('Wrote Ocean Boundary File -',MatFileName,'-File-',num2str(i),'-of-',...
        num2str(numrows));
    disp(dispstr)
end
ab=1;
