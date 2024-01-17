% This script will create the Merra2 data masks for water regions
% Written By: Stephen Forczyk
% Created: Sept 30,2023
% Revised: Oct 1-4 added more bodies of water
% Classification: Unclassified

global SeaBoundaryFiles Merra2DataRasterLon Merra2DataRasterLat;
global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;
global Merra2RioDelLaPlataMask Merra2BassStraitMask Merra2GreatAustralianBightMask;
global Merra2TasmanSeaMask Merra2MozambiqueChannelMask Merra2SavuSeaMask Merra2TimorSeaMask;
global Merra2BaliSeaMask Merra2CoralSeaMask Merra2FloresSeaMask Merra2SolomonSeaMask;
global Merra2ArafuraSeaMask Merra2GulfOfBoniMask Merra2JavaSeaMask Merra2CeramSeaMask;
global Merra2BismarkSeaMask;
global Merra2BandaSeaMask Merra2GulfOfCaliforniaMask Merra2BayOfFundyMask;
global Merra2StraitOfGibraltarMask;
global Merra2AlboranSeaMask Merra2CaribbeanSeaMask Merra2GulfOfAlaskaMask Merra2BeringSeaMask;
global Merra2ChukchiSeaMask Merra2BeaufortSeaMask Merra2LabradorSeaMask Merra2HudsonStraitMask;
global Merra2DavisStraitMask Merra2BaffinBayMask Merra2LincolnSeaMask Merra2BristolChannelMask;
global Merra2IrishSeaMask Merra2InnerSeaMask Merra2GulfOfAdenMask Merra2GulfOfOmanMask;
global Merra2RedSeaMask Merra2GulfOfAqabaMask Merra2PersianGulfMask Merra2IonianSeaMask;
global Merra2TyrrhenianSeaMask Merra2AdriaticSeaMask Merra2GulfOfSuezMask Merra2MeadSeaEastMask; 
global Merra2AegeanSeaMask Merra2SeaOfMarmaraMask Merra2SingaporeStraitMask Merra2CelebesSeaMask;
global Merra2MalaccaStraitMask Merra2SuluSeaMask Merra2GulfOfThailandMask Merra2EasternChinaSeaMask;
global Merra2InlandSeaMask Merra2PhilippineSeaMask Merra2YellowSeaMask Merra2GulfOfRigaMask;
global Merra2BalticSeaMask Merra2GulfOfFinlandMask Merra2GulfOfBothniaMask Merra2WhiteSeaMask;
global Merra2EastSiberianSeaMask Merra2SouthAtlanticOceanMask Merra2SouthernOceanMask Merra2SouthPacificOceanMask;
global Merra2GulfOfTominiMask Merra2MakassarStraitMask Merra2HalmaheraSeaMask Merra2MolukkaSeaMask;
global Merra2IndianOceanMask Merra2BayOfBengalMask Merra2SouthChinaSeaMask Merra2ArabianSeaMask;
global Merra2NorthPacificOceanMask  Merra2AlaskaCoastalWatersMask Merra2GulfOfMexicoMask Merra2NorthAtlanticOceanMask;
global Merra2GulfOfStLawrenceMask Merra2IberianSeaMask Merra2BayOfBiscayMask Merra2CelticSeaMask;
global Merra2MedSeaWestMask Merra2HudsonBayMask Merra2NorthWestPassageMask Merra2ArcticOceanMask;
global Merra2EnglishChannelMask Merra2BarentsSeaMask Merra2GreenlandSeaMask Merra2NorthSeaMask;
global Merra2AndamanSeaMask Merra2BlackSeaMask Merra2SeaOfAzovMask Merra2JapanSeaMask;
global Merra2SeaOfOkhotskMask Merra2KaraSeaMask Merra2LaptevSeaMask Merra2KattegatMask;
global Merra2LaccadiveSeaMask Merra2SkagerrackMask Merra2NorwegianSeaMask Merra2LigurianSeaMask;
global Merra2GulfOfGuineaMask;
global shapefilepath ;
global maskpath boundarypath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global mappath matlabpath ;
%% Set Up Fixed Paths
shapefilepath='D:\Forczyk\Map_Data\Downloaded_Shapefiles\World_Seas_IHO_v3\';% original data source
matlabpath='D:\Forczyk\Map_Data\Matlab_Maps_Oceans\';
mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
maskpath='K:\Merra-2\Water_Masks\';
boundarypath='D:\Forczyk\Map_Data\Matlab_Maps_Oceans\';
%% Set Up Fixed Variables/Flags
flags=zeros(101,1);
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
SeaBoundaryFiles{3,3}='BassStraitBoundaries.mat';
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
%% Create Georeference object Rpix
latlim=[-90 90];
lonlim=[-180 180];
numlon=576;
numlat=361;
rasterSize=[numlat numlon];
Rpix = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','south','RowsStartFrom','west');
westEdge=-180;
eastEdge=180;
southEdge=-90;
northEdge=90;
Merra2DataRasterLon=zeros(numlon,1);
Merra2DataRasterLat=zeros(numlat,1);
deltaLon=0.625;
deltaLat=0.500;
for i=1:numlon
    nowlon=westEdge+(i-1)*deltaLon;
    for j=1:numlat
        nowlat=southEdge+(j-1)*deltaLat;
        Merra2DataRasterLon(i,1)=nowlon;
        Merra2DataRasterLat(j,1)=nowlat;
    end
end
% flags(1,1)=1;
% flags(2,1)=1;
% flags(3,1)=1;
% flags(4,1)=1;
% flags(5,1)=1;
% flags(6,1)=1;
% flags(7,1)=1;
% flags(8,1)=1;
% flags(9,1)=1;
% flags(10,1)=1;
% flags(11,1)=1;
% flags(12,1)=1;
% flags(13,1)=1;
% flags(14,1)=1;
% flags(15,1)=1;
% flags(16,1)=1;
% flags(17,1)=1;
% flags(18,1)=1;
% flags(19,1)=1;
% flags(20,1)=1;
% flags(21,1)=1;
% flags(22,1)=1;
% flags(23,1)=1;
% flags(24,1)=1;
% flags(25,1)=1;
% flags(26,1)=1;
% flags(27,1)=1;
% flags(28,1)=1;
% flags(29,1)=1;
% flags(30,1)=1;
% flags(31,1)=1;
% flags(32,1)=1;
% flags(33,1)=1;
% flags(34,1)=1;
% flags(35,1)=1;
% flags(36,1)=1;
% flags(37,1)=1;
  flags(38,1)=1;
% flags(39,1)=1;
% flags(40,1)=1;
% flags(41,1)=1;
% flags(42,1)=1;
% flags(43,1)=1;
% flags(44,1)=1;
% flags(45,1)=1;
% flags(46,1)=1;
% flags(47,1)=1;
% flags(48,1)=1;
% flags(49,1)=1;
% flags(50,1)=1;
% flags(51,1)=1;
% flags(52,1)=1;
% flags(53,1)=1;
% flags(54,1)=1;
% flags(55,1)=1;
% flags(56,1)=1;
% flags(57,1)=1;
% flags(58,1)=1;
% flags(59,1)=1;
% flags(60,1)=1;
% flags(61,1)=1;
% flags(62,1)=1;
% flags(63,1)=1;
% flags(64,1)=1;
% flags(65,1)=1;
% flags(66,1)=1;
% flags(67,1)=1;
% flags(68,1)=1;
%flags(69,1)=1;
% flags(70,1)=1;
% flags(71,1)=1;
% flags(72,1)=1;
% flags(73,1)=1;
% flags(74,1)=1;
% flags(75,1)=1;
% flags(76,1)=1;
% flags(77,1)=1;
% flags(78,1)=1;
% flags(79,1)=1;
% flags(80,1)=1;
% flags(81,1)=1;
% flags(82,1)=1;
% flags(83,1)=1;
% flags(84,1)=1;
% flags(85,1)=1;
% flags(86,1)=1;
% flags(87,1)=1;
% flags(88,1)=1;
% flags(89,1)=1;
% flags(90,1)=1;
% flags(91,1)=1;
% flags(92,1)=1;
% flags(93,1)=1;
% flags(94,1)=1;
% flags(95,1)=1;
% flags(96,1)=1;
% flags(97,1)=1;
% flags(98,1)=1;
% flags(99,1)=1;
% flags(100,1)=1;
% flags(101,1)=1;


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
%% Water Area #1 RioDelLaPlata
if(flags(1,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{2,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2RioDelLaPlataMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2RioDelLaPlataMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2RioDelLaPlataMask seaArea ';
    MatFileName='RioDelLaPlataMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote RioDelLaPlataMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area #2 BassStrait
if(flags(2,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{3,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BassStraitMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BassStraitMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BassStraitMask seaArea ';
    MatFileName='BassStraitMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BassStraitMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area #3 GreatAustralianBight
if(flags(3,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{4,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GreatAustralianBightMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GreatAustralianBightMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2GreatAustralianBightMask seaArea ';
    MatFileName='GreatAustralianBightMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote GreatAustralianBightMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area #4 Tasman Sea
if(flags(4,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{5,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2TasmanSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2TasmanSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2TasmanSeaMask seaArea ';
    MatFileName='TasmanSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote TasmanSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 5 Mozambique Channel
if(flags(5,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{6,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2MozambiqueChannelMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2MozambiqueChannelMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2MozambiqueChannelMask seaArea ';
    MatFileName='MozambiqueChannelMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote MozambiqueChannelMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 6 Savu Sea
if(flags(6,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{7,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SavuSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SavuSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2SavuSeaMask seaArea ';
    MatFileName='SavuSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote SavuSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 7 Timor Sea
if(flags(7,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{8,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2TimorSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2TimorSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2TimorSeaMask seaArea ';
    MatFileName='TimorSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote TimorSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 8 Bali Sea
if(flags(8,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{9,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BaliSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BaliSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BaliSeaMask seaArea ';
    MatFileName='BaliSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BaliSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 9 Coral Sea
if(flags(9,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{10,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2CoralSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2CoralSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2CoralSeaMask seaArea ';
    MatFileName='CoralSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote CoralSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 10 Floral Sea
if(flags(10,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{11,3});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2FloresSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2FloresSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i));
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2FloresSeaMask seaArea ';
    MatFileName='FloresSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote FloresSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 11 Solomon Sea
if(flags(11,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{12,3});
    waterName=char(SeaBoundaryFiles{12,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SolomonSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SolomonSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2SolomonSeaMask seaArea ';
    MatFileName='SolomonSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote SolomonSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 12 Arafura Sea
if(flags(12,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{13,3});
    waterName=char(SeaBoundaryFiles{13,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2ArafuraSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;

            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2ArafuraSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2ArafuraSeaMask seaArea ';
    MatFileName='ArafuraSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote ArafuraSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 13 GulfOfBoni
if(flags(13,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{14,3});
    waterName=char(SeaBoundaryFiles{14,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfBoniMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfBoniMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2GulfOfBoniMask seaArea ';
    MatFileName='GulfOfBoniaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote GulfOfBoniMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 14 Java Sea
if(flags(14,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{15,3});
    waterName=char(SeaBoundaryFiles{15,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2JavaSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2JavaSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2JavaSeaMask seaArea ';
    MatFileName='JavaSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote JavaSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 15 Ceram Sea
if(flags(15,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{16,3});
    waterName=char(SeaBoundaryFiles{16,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2CeramSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2CeramSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2CeramSeaMask seaArea ';
    MatFileName='CeramSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote CeramSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 16 Bismark Sea
if(flags(16,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{17,3});
    waterName=char(SeaBoundaryFiles{17,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BismarkSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BismarkSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BismarkSeaMask seaArea ';
    MatFileName='BismarkSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BismarkSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 17 Banda Sea
if(flags(17,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{18,3});
    waterName=char(SeaBoundaryFiles{18,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BandaSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BandaSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BandaSeaMask seaArea ';
    MatFileName='BandaSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BandaSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 18 Gulf Of California
if(flags(18,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{19,3});
    waterName=char(SeaBoundaryFiles{19,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfCaliforniaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfCaliforniaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2GulfOfCaliforniaMask seaArea ';
    MatFileName='GulfOfCaliforniaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote GulfOfCaliforniaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 19 Bay Of Fundy
if(flags(19,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{20,3});
    waterName=char(SeaBoundaryFiles{20,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BayOfFundyMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BayOfFundyMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BayOfFundyMask seaArea ';
    MatFileName='BayOfFundyMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BayOfFundyMask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 20 Strait Of Gibraltar
if(flags(20,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{21,3});
    waterName=char(SeaBoundaryFiles{21,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2StraitOfGibraltarMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2StraitOfGibraltarMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2StraitOfGibraltarMask seaArea ';
    MatFileName='StraitOfGibraltarMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote StraitOfGibraltarMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 21 Alboran Sea
if(flags(21,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{22,3});
    waterName=char(SeaBoundaryFiles{22,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2AlboranSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2AlboranSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2AlboranSeaMask seaArea ';
    MatFileName='AlboranSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote AlboranSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 22 Caribbean Sea
if(flags(22,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{23,3});
    waterName=char(SeaBoundaryFiles{23,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2CaribbeanSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2CaribbeanSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2CaribbeanSeaMask seaArea ';
    MatFileName='CaribbeanSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote CaribbeanSeaMask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 23 Caribbean Sea
if(flags(23,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{24,3});
    waterName=char(SeaBoundaryFiles{24,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfAlaskaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfAlaskaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2GulfOfAlaskaMask seaArea ';
    MatFileName='GulfOfAlaskaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote GulfOfAlaskaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 24 Caribbean Sea
if(flags(24,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{25,3});
    waterName=char(SeaBoundaryFiles{25,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BeringSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BeringSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BeringSeaMask seaArea ';
    MatFileName='BeringSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BeringSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 25 Chukchi Sea
if(flags(25,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{26,3});
    waterName=char(SeaBoundaryFiles{26,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2ChukchiSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2ChukchiSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2ChukchiSeaMask seaArea ';
    MatFileName='ChukchiSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote ChukchiSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 26 Beaufort Sea
if(flags(26,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{27,3});
    waterName=char(SeaBoundaryFiles{27,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BeaufortSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BeaufortSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BeaufortSeaMask seaArea ';
    MatFileName='BeaufortSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BeaufortSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 27 Labrador Sea
if(flags(27,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{28,3});
    waterName=char(SeaBoundaryFiles{28,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2LabradorSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2LabradorSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2LabradorSeaMask seaArea ';
    MatFileName='LabradorSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote LabradorSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 28 Hudson Strait
if(flags(28,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{29,3});
    waterName=char(SeaBoundaryFiles{29,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2HudsonStraitMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2HudsonStraitMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2HudsonStraitMask seaArea ';
    MatFileName='HudsonStraitMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote HudsonStraitMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 29 Davis Strait
if(flags(29,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{30,3});
    waterName=char(SeaBoundaryFiles{30,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2DavisStraitMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2DavisStraitMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2DavisStraitMask seaArea ';
    MatFileName='DavisStraitMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote DavisStraitMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 30 Baffin Bay
if(flags(30,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{31,3});
    waterName=char(SeaBoundaryFiles{31,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BaffinBayMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BaffinBayMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BaffinBayMask seaArea ';
    MatFileName='BaffinBayMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote BaffinBayMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 31 Lincoln Sea
if(flags(31,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{32,3});
    waterName=char(SeaBoundaryFiles{32,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2LincolnSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2LincolnSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2LincolnSeaMask seaArea ';
    MatFileName='LincolnSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote LincolnSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 32 Bristol Channel
if(flags(32,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{33,3});
    waterName=char(SeaBoundaryFiles{33,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BristolChannelMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2LincolnSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr='Merra2BristolChannelMask seaArea ';
    MatFileName='BristolChannelMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Bristol ChannelMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 33 Irish Sea
if(flags(33,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{34,3});
    waterName=char(SeaBoundaryFiles{34,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2IrishSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2IrishSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2IrishSeaMask seaArea ';
    MatFileName='IrishSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote IrishSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 34 Inner Sea
if(flags(34,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{35,3});
    waterName=char(SeaBoundaryFiles{35,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2InnerSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2InnerSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2InnerSeaMask seaArea ';
    MatFileName='InnerSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote InnerSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 35 Gulf Of Aden
if(flags(35,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{36,3});
    waterName=char(SeaBoundaryFiles{36,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfAdenMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfAdenMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfAdenMask seaArea ';
    MatFileName='GulfOfAdenMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote GulfOfAdenMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 36 Gulf Of Oman
if(flags(36,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{37,3});
    waterName=char(SeaBoundaryFiles{37,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfOmanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfOmanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfOmanMask seaArea ';
    MatFileName='GulfOfOmanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote GulfOfOmanMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 37 Red Sea
if(flags(37,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{38,3});
    waterName=char(SeaBoundaryFiles{38,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2RedSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2RedSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2RedSeaMask seaArea ';
    MatFileName='RedSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Red Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 38 Gulf Of Aqaba
if(flags(38,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{39,3});
    waterName=char(SeaBoundaryFiles{39,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfAqabaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfAqabaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    masksum=sum(sum( Merra2GulfOfAqabaMask));
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfAqabaMask seaArea masksum';
    MatFileName='GulfOfAqabaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Gulf Ok Aqaba Mask File-',MatFileName);
    disp(dispstr)
    ab=1;
end
%% Water Area 39 Persian Gulf
if(flags(39,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{40,3});
    waterName=char(SeaBoundaryFiles{40,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2PersianGulfMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;
            
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2PersianGulfMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2PersianGulfMask seaArea ';
    MatFileName='PersianGulfMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Persian Gulf Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 40 Ionian Sea
if(flags(40,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{41,3});
    waterName=char(SeaBoundaryFiles{41,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2IonianSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2IonianSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2IonianSeaMask seaArea ';
    MatFileName='IonianSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Ionian Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 41 Tyrrhenian Sea
if(flags(41,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{42,3});
    waterName=char(SeaBoundaryFiles{42,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2TyrrhenianSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2TyrrhenianSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2TyrrhenianSeaMask seaArea ';
    MatFileName='TyrrhenianSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Tyrrhenian Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 42 Adriatic Sea
if(flags(42,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{43,3});
    waterName=char(SeaBoundaryFiles{43,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2AdriaticSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2AdriaticSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2AdriaticSeaMask seaArea ';
    MatFileName='AdriaticSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Adriatic Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 43 Gulf Of Suez
if(flags(43,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{44,3});
    waterName=char(SeaBoundaryFiles{44,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfSuezMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfSuezMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfSuezMask seaArea ';
    MatFileName='GulfOfSuezMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Gulf Of Suez Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 44 Gulf Of Suez
if(flags(44,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{45,3});
    waterName=char(SeaBoundaryFiles{45,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2MeadSeaEastMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2MeadSeaEastMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2MeadSeaEastMask seaArea ';
    MatFileName='MeadSeaEastMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote MeadSeaEastMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 45 Aegean Sea
if(flags(45,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{46,3});
    waterName=char(SeaBoundaryFiles{46,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2AegeanSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2AegeanSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2AegeanSeaMask seaArea ';
    MatFileName='AegeanSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Aegean Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 46 Aegean Sea
if(flags(46,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{47,3});
    waterName=char(SeaBoundaryFiles{47,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SeaOfMarmaraMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SeaOfMarmaraMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SeaOfMarmaraMask seaArea ';
    MatFileName='SeaOfMarmaraMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Sea Of Marmara Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 47 Singapore Strait
if(flags(47,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{48,3});
    waterName=char(SeaBoundaryFiles{48,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SingaporeStraitMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SingaporeStraitMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SingaporeStraitMask seaArea ';
    MatFileName='SingaporeStraitMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Singapore Strait Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 48 Celebes Sea
if(flags(48,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{49,3});
    waterName=char(SeaBoundaryFiles{49,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2CelebesSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2CelebesSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2CelebesSeaMask seaArea ';
    MatFileName='CelebesSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Celebes Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 49 Malacca Strait
if(flags(49,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{50,3});
    waterName=char(SeaBoundaryFiles{50,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2MalaccaStraitMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2MalaccaStraitMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2MalaccaStraitMask seaArea ';
    MatFileName='MalaccaStraitMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote MalaccaStraitMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 50 Sulu Sea
if(flags(50,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{51,3});
    waterName=char(SeaBoundaryFiles{51,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SuluSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
           Merra2SuluSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SuluSeaMask seaArea ';
    MatFileName='SuluSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Sulu Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 51 Gulf Of Thailand
if(flags(51,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{52,3});
    waterName=char(SeaBoundaryFiles{52,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfThailandMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
           Merra2GulfOfThailandMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfThailandMask seaArea ';
    MatFileName='GulfOfThailandMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Gulf Of Thailand Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 52 Eastern China Sea
if(flags(52,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{53,3});
    waterName=char(SeaBoundaryFiles{53,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2EasternChinaSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
           Merra2EasternChinaSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2EasternChinaSeaMask seaArea ';
    MatFileName='EasternChinaSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Eastern China Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 53 Inland Sea
if(flags(53,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{54,3});
    waterName=char(SeaBoundaryFiles{54,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2InlandSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
           Merra2InlandSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2InlandSeaMask seaArea ';
    MatFileName='InlandSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Inland Sea Mask File-',MatFileName);
    disp(dispstr)
end
global Merra2YellowSeaMask Merra2GulfOfRigaMask;
%% Water Area 54 Inland Sea
if(flags(54,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{55,3});
    waterName=char(SeaBoundaryFiles{55,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2PhilippineSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2PhilippineSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2PhilippineSeaMask seaArea ';
    MatFileName='PhilippineSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Philippine Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 55 Inland Sea
if(flags(55,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{56,3});
    waterName=char(SeaBoundaryFiles{56,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2YellowSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2YellowSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2YellowSeaMask seaArea ';
    MatFileName='YellowSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Yellow Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 56 Gulf Of Riga
if(flags(56,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{57,3});
    waterName=char(SeaBoundaryFiles{57,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfRigaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfRigaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfRigaMask seaArea ';
    MatFileName='GulfOfRigaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Gulf Of Riga Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 57 Baltic Sea
if(flags(57,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{58,3});
    waterName=char(SeaBoundaryFiles{58,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BalticSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BalticSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2BalticSeaMask seaArea ';
    MatFileName='BalticSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Baltic Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 58 Gulf Of Finland
if(flags(58,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{59,3});
    waterName=char(SeaBoundaryFiles{59,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfFinlandMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfFinlandMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfFinlandMask seaArea ';
    MatFileName='GulfOfFinlandMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Gulf Of Finland Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 59 Gulf Of Bothnia
if(flags(59,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{60,3});
    waterName=char(SeaBoundaryFiles{60,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfBothniaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfBothniaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfBothniaMask seaArea ';
    MatFileName='GulfOfBothniaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Gulf Of Bothnia Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 60 White Sea
if(flags(60,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{61,3});
    waterName=char(SeaBoundaryFiles{61,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2WhiteSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2WhiteSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end

    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2WhiteSeaMask seaArea ';
    MatFileName='WhiteSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote White Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 61 East Siberian Sea Mask
if(flags(61,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{62,3});
    waterName=char(SeaBoundaryFiles{62,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2EastSiberianSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2EastSiberianSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end

    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2EastSiberianSeaMask seaArea ';
    MatFileName='EastSiberianSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote East Siberian Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 62 Suth Atlantic Ocean Mask
if(flags(62,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{63,3});
    waterName=char(SeaBoundaryFiles{63,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SouthAtlanticOceanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SouthAtlanticOceanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SouthAtlanticOceanMask seaArea ';
    MatFileName='SouthAtlanticOceanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote South Atlantic Ocean Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 63 Southern Ocean Mask
if(flags(63,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{64,3});
    waterName=char(SeaBoundaryFiles{64,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SouthernOceanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SouthernOceanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SouthernOceanMask seaArea ';
    MatFileName='SouthernOceanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Southern Ocean Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 64 South Pacific Ocean Mask
if(flags(64,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{65,3});
    waterName=char(SeaBoundaryFiles{65,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SouthPacificOceanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SouthPacificOceanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SouthPacificOceanMask seaArea ';
    MatFileName='SouthPacificOceanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote South Pacific Ocean Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 65 Gulf Of Tomini 
if(flags(65,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{66,3});
    waterName=char(SeaBoundaryFiles{66,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfTominiMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfTominiMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfTominiMask seaArea ';
    MatFileName='GulfOfTominiMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote GulfOfTominiMask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 66 Makassar Strait 
if(flags(66,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{67,3});
    waterName=char(SeaBoundaryFiles{67,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2MakassarStraitMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2MakassarStraitMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2MakassarStraitMask seaArea ';
    MatFileName='MakassarStraitMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Makassar Strait Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 67 Halmahera Sea
if(flags(67,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{68,3});
    waterName=char(SeaBoundaryFiles{68,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2HalmaheraSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2HalmaheraSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2HalmaheraSeaMask seaArea ';
    MatFileName='HalmaheraSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Halmahera Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 68 Molukka Sea
if(flags(68,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{69,3});
    waterName=char(SeaBoundaryFiles{69,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2MolukkaSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2MolukkaSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2MolukkaSeaMask seaArea ';
    MatFileName='MolukkaSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Molukka Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 69 Indian Ocean
if(flags(69,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{70,3});
    waterName=char(SeaBoundaryFiles{70,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2IndianOceanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2IndianOceanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2IndianOceanMask seaArea ';
    MatFileName='IndianOceanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Indian Ocean  Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 70 Bay Of Bengal;
if(flags(70,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{71,3});
    waterName=char(SeaBoundaryFiles{71,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BayOfBengalMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BayOfBengalMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2BayOfBengalMask seaArea ';
    MatFileName='BayOfBengalMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Bay Of Bengal Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 71 South China Sea;
if(flags(71,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{72,3});
    waterName=char(SeaBoundaryFiles{72,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SouthChinaSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SouthChinaSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SouthChinaSeaMask seaArea ';
    MatFileName='SouthChinaSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote South China Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 72 Arabian Sea;
if(flags(72,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{73,3});
    waterName=char(SeaBoundaryFiles{73,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2ArabianSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2ArabianSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2ArabianSeaMask seaArea ';
    MatFileName='ArabianSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Arabian Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 73 NorthPacific Ocean
if(flags(73,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{74,3});
    waterName=char(SeaBoundaryFiles{74,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2NorthPacificOceanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2NorthPacificOceanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2NorthPacificOceanMask seaArea ';
    MatFileName='NorthPacificOceanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote North Pacific Ocean Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 74 Alaska Coastal Waters
if(flags(74,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{75,3});
    waterName=char(SeaBoundaryFiles{75,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2AlaskaCoastalWatersMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2AlaskaCoastalWatersMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2AlaskaCoastalWatersMask seaArea ';
    MatFileName='AlaskaCoastalWatersMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Alaska Coastal Waters Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 75 Gulf Of Mexico
if(flags(75,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{76,3});
    waterName=char(SeaBoundaryFiles{76,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfMexicoMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfMexicoMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfMexicoMask seaArea ';
    MatFileName='GulfOfMexicoMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Wrote Gulf Of Mexico Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 76 North Atlantic Ocean
if(flags(76,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{77,3});
    waterName=char(SeaBoundaryFiles{77,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2NorthAtlanticOceanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2NorthAtlanticOceanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2NorthAtlanticOceanMask seaArea ';
    MatFileName='NorthAtlanticOceanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('NorthAtlanticOceanMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 77 Gulf Of St Lawrence
if(flags(77,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{78,3});
    waterName=char(SeaBoundaryFiles{78,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfStLawrenceMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfStLawrenceMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfStLawrenceMask seaArea ';
    MatFileName='GulfOfStLawrenceMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('GulfOfStLawrenceMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 78 Iberian Sea
if(flags(78,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{79,3});
    waterName=char(SeaBoundaryFiles{79,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2IberianSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2IberianSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2IberianSeaMask seaArea ';
    MatFileName='IberianSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Iberian Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 79 Bay Of Biscay
if(flags(79,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{80,3});
    waterName=char(SeaBoundaryFiles{80,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BayOfBiscayMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BayOfBiscayMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2BayOfBiscayMask seaArea ';
    MatFileName='BayOfBiscayMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('BayOfBiscayMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 80 Celtic Sea
if(flags(80,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{81,3});
    waterName=char(SeaBoundaryFiles{81,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2CelticSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2CelticSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2CelticSeaMask seaArea ';
    MatFileName='Merra2CelticSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Merra2CelticSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 81 Med Sea West
if(flags(81,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{82,3});
    waterName=char(SeaBoundaryFiles{82,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2MedSeaWestMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2MedSeaWestMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2MedSeaWestMask seaArea ';
    MatFileName='MedSeaWestMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Med Sea West Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 82 Hudson Bay
if(flags(82,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{83,3});
    waterName=char(SeaBoundaryFiles{83,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2HudsonBayMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2HudsonBayMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2HudsonBayMask seaArea ';
    MatFileName='HudsonBayMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Hudson Bay Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 83 North West Passage
if(flags(83,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{84,3});
    waterName=char(SeaBoundaryFiles{84,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2NorthWestPassageMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2NorthWestPassageMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2NorthWestPassageMask seaArea ';
    MatFileName='NorthWestPassageMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('North West Passage Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 84 Arctic Ocean
if(flags(84,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{85,3});
    waterName=char(SeaBoundaryFiles{85,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2ArcticOceanMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2ArcticOceanMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2ArcticOceanMask seaArea ';
    MatFileName='ArcticOceanMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Arctic Ocean Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 85 Arctic Ocean
if(flags(85,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{86,3});
    waterName=char(SeaBoundaryFiles{86,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2EnglishChannelMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2EnglishChannelMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2EnglishChannelMask seaArea ';
    MatFileName='EnglishChannelMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('English Channel Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 86 Barents Sea
if(flags(86,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{87,3});
    waterName=char(SeaBoundaryFiles{87,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BarentsSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BarentsSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2BarentsSeaMask seaArea ';
    MatFileName='BarentsSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Barents Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 87 Greenland Sea
if(flags(87,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{88,3});
    waterName=char(SeaBoundaryFiles{88,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GreenlandSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GreenlandSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GreenlandSeaMask seaArea ';
    MatFileName='GreenlandSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Greenland Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 88 North Sea
if(flags(88,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{89,3});
    waterName=char(SeaBoundaryFiles{89,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2NorthSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2NorthSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2NorthSeaMask seaArea ';
    MatFileName='NorthSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('North Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 89 Andaman Sea
if(flags(89,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{90,3});
    waterName=char(SeaBoundaryFiles{90,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2AndamanSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2AndamanSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2AndamanSeaMask seaArea ';
    MatFileName='AndamanSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('AndamanSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 90 Black Sea
if(flags(90,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{91,3});
    waterName=char(SeaBoundaryFiles{91,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2BlackSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2BlackSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2BlackSeaMask seaArea ';
    MatFileName='BlackSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Black Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 91 Sea Of Azov
if(flags(91,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{92,3});
    waterName=char(SeaBoundaryFiles{92,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SeaOfAzovMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SeaOfAzovMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SeaOfAzovMask seaArea ';
    MatFileName='SeaOfAzovMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Sea Of Azov Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 92 Japan Sea
if(flags(92,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{93,3});
    waterName=char(SeaBoundaryFiles{93,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2JapanSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2JapanSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2JapanSeaMask seaArea ';
    MatFileName='JapanSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Merra2JapanSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 93 Sea Of Okhotsk
if(flags(93,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{94,3});
    waterName=char(SeaBoundaryFiles{94,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SeaOfOkhotskMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SeaOfOkhotskMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SeaOfOkhotskMask seaArea ';
    MatFileName='SeaOfOkhotskMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('SeaOfOkhotskMask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 94 Kara Sea
if(flags(94,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{95,3});
    waterName=char(SeaBoundaryFiles{95,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2KaraSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2KaraSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2KaraSeaMask seaArea ';
    MatFileName='KaraSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Kara Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 95 Laptev Sea
if(flags(95,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{96,3});
    waterName=char(SeaBoundaryFiles{96,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2LaptevSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2LaptevSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2LaptevSeaMask seaArea ';
    MatFileName='LaptevSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Laptev Sea Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 96 Kattegat
if(flags(96,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{97,3});
    waterName=char(SeaBoundaryFiles{97,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2KattegatMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2KattegatMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2KattegatMask seaArea ';
    MatFileName='KattegatMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Kattegat Mask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 97 Laccadive Sea
if(flags(97,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{98,3});
    waterName=char(SeaBoundaryFiles{98,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2LaccadiveSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2LaccadiveSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2LaccadiveSeaMask seaArea ';
    MatFileName='LaccadiveSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Laccadive Sea Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 98 Skagerrack
if(flags(98,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{99,3});
    waterName=char(SeaBoundaryFiles{99,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2SkagerrackMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2SkagerrackMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2SkagerrackMask seaArea ';
    MatFileName='SkagerrackMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Skagerrack Mask File-',MatFileName);
    disp(dispstr)
end

%% Water Area 99 Norwegian Sea
if(flags(99,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{100,3});
    waterName=char(SeaBoundaryFiles{100,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2NorwegianSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2NorwegianSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2NorwegianSeaMask seaArea ';
    MatFileName='NorwegianSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('Norwegian Sea Mask File-',MatFileName);
    disp(dispstr)
end
global Merra2GulfOfGuineaMask;
%% Water Area 100 Ligurian Sea
if(flags(100,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{101,3});
    waterName=char(SeaBoundaryFiles{101,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2LigurianSeaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2LigurianSeaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2LigurianSeaMask seaArea ';
    MatFileName='LigurianSeaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('LigurianSeaMask File-',MatFileName);
    disp(dispstr)
end
%% Water Area 101 Gulf Of Guinea
if(flags(101,1)>0)
    eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
    borderfile=char(SeaBoundaryFiles{102,3});
    waterName=char(SeaBoundaryFiles{102,2});
    load(borderfile,'seaLat','seaLon','seaArea');
    Merra2GulfOfGuineaMask=zeros(numlon,numlat);
    for i=1:numlon
        xq(1,1)=Merra2DataRasterLon(i,1)-.312;
        xq(2,1)=Merra2DataRasterLon(i,1)+.312;
        xq(3,1)=Merra2DataRasterLon(i,1)+.312;
        xq(4,1)=Merra2DataRasterLon(i,1)-.312;
        xq(5,1)=Merra2DataRasterLon(i,1)-.312;
        xqq=Merra2DataRasterLon(i,1);
        for j=1:numlat
            yq(1,1)=Merra2DataRasterLat(j,1)-.25;
            yq(2,1)=Merra2DataRasterLat(j,1)-.25;
            yq(3,1)=Merra2DataRasterLat(j,1)+.25;
            yq(4,1)=Merra2DataRasterLat(j,1)+.25;           
            yq(5,1)=Merra2DataRasterLat(j,1)-.25;
            yqq=Merra2DataRasterLat(j,1);
            [in,on]=inpolygon(xqq,yqq,seaLon,seaLat);
            Merra2GulfOfGuineaMask(i,j)=in;
        end
        dispstr=strcat('finished with lon#',num2str(i),'-for-',waterName);
        disp(dispstr)
    end
    eval(['cd ' maskpath(1:length(maskpath)-1)]);
    actionstr='save';
    varstr=' Merra2GulfOfGuineaMask seaArea ';
    MatFileName='GulfOfGuineaMask';
    qualstr='-v7.3';
    [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
    eval(cmdString)
    dispstr=strcat('GulfOfGuineaMask File-',MatFileName);
    disp(dispstr)
end