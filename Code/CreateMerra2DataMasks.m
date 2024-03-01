% This routine will be used to Create Masks for the Merra2 Grids for
% Selected Countries
% Written By: Stephen Forczyk
% Created: Jul 27,2023
% Revised: July 29-Aug 12,2023 added code for more countries
% Revised: Dec 5,2023 found error in code that created Germany mask
%          it save the result too the Ukraine Mask. Both files corrected
% Classification: Unclassified
global Merra2DataRasterLon Merra2DataRasterLat;
global Merra2AfricaMask Merra2EuropeMask Merra2NorthAmericaMask;
global Merra2USAMask Merra2SouthAmericaMask Merra2AustraliaMask;
global Merra2AsiaMask Merra2ChinaMask Merra2IndiaMask Merra2AlgeriaMask;
global Merra2MoroccoMask Merra2NigeriaMask Merra2MauritaniaMask;
global Merra2SudanMask Merra2ChadMask Merra2NigerMask Merra2CameroonMask;
global Merra2EgyptMask Merra2LibyaMask Merra2SouthAfricaMask;
global Merra2NamibiaMask Merra2AngolaMask Merra2GabonMask Merra2MozambiqueMask;
global Merra2TanzaniaMask Merra2KenyaMask Merra2SomaliaMask;
global Merra2EthiopiaMask Merra2MadagascarMask;
global Merra2SaudiMask Merra2YemenMask Merra2OmanMask Merra2UAEMask;
global Merra2JordanMask Merra2SyriaMask Merra2IraqMask Merra2IranMask;
global Merra2AfganistanMask Merra2PakistanMask Merra2TurkeyMask;
global Merra2ItalyMask Merra2FranceMask Merra2UKMask Merra2SpainMask;
global Merra2PortugalMask Merra2IrelandMask Merra2IcelandMask;
global Merra2PolandMask Merra2BelarusMask Merra2UkraineMask;
global Merra2NorwayMask Merra2SwedenMask Merra2FinlandMask;
global Merra2GermanyMask Merra2RussiaMask Merra2JapanMask;
global Merra2PhilippinesMask Merra2TaiwanMask Merra2VietnamMask Merra2LaosMask;
global Merra2CambodiaMask Merra2ThailandMask Merra2IndonesiaMask;
global Merra2NorthKoreaMask Merra2SouthKoreaMask;
global Merra2BangladeshMask Merra2NepalMask Merra2BurmaMask;
global Merra2MalaysiaMask Merra2BrazilMask Merra2ArgentinaMask;
global Merra2VenezuelaMask Merra2ColumbiaMask Merra2EcuadorMask Merra2PeruMask;
global Merra2BoliviaMask Merra2ChileMask Merra2ParaguayMask Merra2UruguayMask;
global Merra2MexicoMask Merra2GautemalaMask Merra2HondurasMask Merra2CubaMask;
global Merra2GreenlandMask Merra2CanadaMask Merra2BouvetIslandMask;
global Merra2ZambiaMask Merra2ZimbabweMask Merra2WestSaharaMask;
global Merra2AustriaMask Merra2AzerbaijanMask Merra2CODMask ;
global Merra2ArmeniaMask Merra2BelgiumMask Merra2BhutanMask Merra2BosniaMask;
global Merra2BotswanaMask Merra2BulgariaMask Merra2CyprusMask Merra2CzechMask;
global Merra2DenmarkMask Merra2DominicanRepublicMask Merra2ElSalvadorMask;
global Merra2EritreaMask Merra2EstoniaMask Merra2GambiaMask Merra2GhanaMask;
global Merra2AntarcticMask Merra2GuineaMask Merra2HaitiMask Merra2HungaryMask;
global Merra2KuwaitMask Merra2KyrgyzstanMask Merra2AlbaniaMask;
global Merra2JamaicaMask Merra2KazakhstanMask Merra2LatviaMask Merra2LebanonMask;
global Merra2LesothoMask Merra2LiberiaMask Merra2LithuaniaMask Merra2MacedoniaMask;
global Merra2MalawiMask Merra2MaliMask Merra2EquatorialGuineaMask Merra2EquatorialGuianaMask;
global Merra2GuyanaMask Merra2MongoliaMask Merra2GuianaMask;
global Merra2NetherlandsMask Merra2NewGuineaMask Merra2NewZealandMask;
global Merra2PanamaMask Merra2PuertoRicoMask Merra2QatarMask Merra2RomaniaMask;
global Merra2RwandaMask Merra2SenegalMask Merra2SerbiaMask Merra2SierraLeoneMask;
global Merra2SlovakiaMask Merra2SloveniaMask Merra2SriLankaMask Merra2SurinameMask;
global Merra2SwazilandMask Merra2SwitzerlandMask Merra2TajikistanMask;
global Merra2TunisiaMask Merra2TurkmenistanMask Merra2UgandaMask;
global Merra2AlabamaMask Merra2AlaskaMask Merra2ArizonaMask;
global Merra2ArkansasMask Merra2CaliforniaMask Merra2ColoradoMask Merra2ConnecticutMask;
global Merra2DelawareMask Merra2FloridaMask Merra2GeorgiaMask Merra2HawaiiMask;
global Merra2IdahoMask Merra2IllinoisMask;
global Merra2IndianaMask Merra2IowaMask Merra2KansasMask Merra2KentuckyMask;
global Merra2LouisianaMask Merra2MaineMask Merra2MarylandMask Merra2MassachusettsMask;
global Merra2MichiganMask Merra2MinnesotaMask Merra2MississippiMask Merra2MissouriMask;
global Merra2MontanaMask Merra2NevadaMask Merra2NebraskaMask Merra2NewHampshireMask;
global Merra2NewJerseyMask Merra2NewYorkMask Merra2NewMexicoMask Merra2NorthCarolinaMask;
global Merra2NorthDakotaMask Merra2OhioMask Merra2OklahomaMask Merra2OregonMask;
global Merra2PennsylvaniaMask Merra2RhodeIslandMask Merra2SouthCarolinaMask Merra2SouthDakotaMask;
global Merra2TennesseeMask Merra2TexasMask Merra2UtahMask Merra2VermontMask;
global Merra2VirginiaMask Merra2WashingtonMask Merra2WestVirginiaMask Merra2WisconsinMask;
global Merra2WyomingMask Merra2AntiguaMask Merra2ArubaMask Merra2BahrainMask Merra2BahamasMask;
global Merra2BelizeMask Merra2BeninMask Merra2DjiboutiMask Merra2DominicaMask;
global Merra2CostaRicaMask Merra2CroatiaMask Merra2FrenchGuianaMask;
global Merra2GrenadaMask Merra2GuadeloupeMask Merra2IsraelMask Merra2KosovoMask;
global Merra2RepGeorgiaMask Merra2SeychellesMask Merra2SolomonIslandsMask;
global Merra2TogoMask Merra2CORMask Merra2BurkinaFasoMask Merra2CaymanMask;
global Merra2GuineaBissauMask Merra2LuxembourgMask Merra2MaldivesMask Merra2MaltaMask;
global Merra2MarshalIslandsMask Merra2MartiniqueMask Merra2MicronesiaMask Merra2MoldovaMask;
global Merra2PolynesiaMask Merra2SamoaMask Merra2TimorMask Merra2TurksMask;
global Merra2MontenegroMask Merra2VanuatuMask Merra2VirginIslandsMask;
global Merra2CentralAfricanRepublicMask Merra2BritishVirginIslandsMask;
global Merra2FTSMask;
global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;

global matpath datapath;
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath maskpath boundarypath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;



mappath='D:\Forczyk\Map_Data\Matlab_Maps\';
maskpath='K:\Merra-2\Masks\';
boundarypath='D:\Forczyk\Map_Data\Matlab_Maps_New\';

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
Merra2AfricaMask=zeros(numlon,numlat);
Merra2EuropeMask=zeros(numlon,numlat);
Merra2NorthAmericaMask=zeros(numlon,numlat);
Merra2SouthAmericaMask=zeros(numlon,numlat);
Merra2USAMask=zeros(numlon,numlat);
Merra2AustraliaMask=zeros(numlon,numlat);
Merra2AsiaMask=zeros(numlon,numlat);
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
ab=1;
%% load the country borders and plot them-start with Africa
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AfricaLowResBoundaries','AfricaLat','AfricaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AfricaLon,AfricaLat);
%         ab=4;
%         Merra2AfricaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
%% load the country borders and plot them-continue with Europe
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('EuropeLowResBoundaries','EuropeLat','EuropeLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,EuropeLon,EuropeLat);
%         ab=4;
%         Merra2EuropeMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2EuropeMask';
% MatFileName='EuropeMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
warning('off');
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NorthAmericaLowResBoundaries','NorthAmericaLat','NorthAmericaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NorthAmericaLon,NorthAmericaLat);
%         ab=4;
%         Merra2NorthAmericaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NorthAmericaMask';
% MatFileName='NorthAmericaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The USA Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('USALowResBoundaries','USALat','USALon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,USALon,USALat);
%         ab=4;
%         Merra2USAMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2USAMask';
% MatFileName='USAMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The South America Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SouthAmericaLowResBoundaries','SouthAmericaLat','SouthAmericaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SouthAmericaLon,SouthAmericaLat);
%         ab=4;
%         Merra2SouthAmericaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SouthAmericaMask';
% MatFileName='SouthAmericaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Australia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AustraliaBoundaries','AustraliaLat','AustraliaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AustraliaLon,AustraliaLat);
%         ab=4;
%         Merra2AustraliaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AustraliaMask';
% MatFileName='AustraliaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Asia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AsiaLowResBoundaries','AsiaLat','AsiaLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AsiaLon,AsiaLat);
%         ab=4;
%         Merra2AsiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AsiaMask';
% MatFileName='AsiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The China Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ChinaBoundaries','ChinaLat','ChinaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ChinaLon,ChinaLat);
%         ab=4;
%         Merra2ChinaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ChinaMask';
% MatFileName='ChinaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The India Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IndiaBoundaries','IndiaLat','IndiaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IndiaLon,IndiaLat);
%         ab=4;
%         Merra2IndiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IndiaMask';
% MatFileName='IndiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Algeria Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AlgeriaBoundaries','AlgeriaLat','AlgeriaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AlgeriaLon,AlgeriaLat);
%         ab=4;
%         Merra2AlgeriaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AlgeriaMask';
% MatFileName='AlgeriaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Morocco Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MoroccoBoundaries','MoroccoLat','MoroccoLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MoroccoLon,MoroccoLat);
%         ab=4;
%         Merra2MoroccoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MoroccoMask';
% MatFileName='MoroccoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Nigeria Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NigeriaBoundaries','NigeriaLat','NigeriaLon');
% ab=2;
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NigeriaLon,NigeriaLat);
%         ab=4;
%         Merra2NigeriaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NigeriaMask';
% MatFileName='NigeriaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Mauritania Mask Item 14
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MauritaniaBoundaries','MauritaniaLat','MauritaniaLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MauritaniaLon,MauritaniaLat);
%         ab=4;
%         Merra2MauritaniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MauritaniaMask';
% MatFileName='MauritaniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% %% Make The Sudan Mask Item 15
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SudanBoundaries','SudanLat','SudanLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SudanLon,SudanLat);
%         ab=4;
%         Merra2SudanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SudanMask';
% MatFileName='SudanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% %% Make The Chad Mask Item 16
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ChadBoundaries','ChadLat','ChadLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ChadLon,ChadLat);
%         ab=4;
%         Merra2ChadMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ChadMask';
% MatFileName='ChadMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Niger Mask Item 17
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NigerBoundaries','NigerLat','NigerLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NigerLon,NigerLat);
%         ab=4;
%         Merra2NigerMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NigerMask';
% MatFileName='NigerMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Cameroon Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CameroonBoundaries','CameroonLat','CameroonLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CameroonLon,CameroonLat);
%         ab=4;
%         Merra2CameroonMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CameroonMask';
% MatFileName='CameroonMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% %% Make The Egypt Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('EgyptBoundaries','EgyptLat','EgyptLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,EgyptLon,EgyptLat);
%         ab=4;
%         Merra2EgyptMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2EgyptMask';
% MatFileName='EgyptMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% %% Make The Libya Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LibyaBoundaries','LibyaLat','LibyaLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LibyaLon,LibyaLat);
%         Merra2LibyaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i));
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LibyaMask';
% MatFileName='LibyaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The SouthAfrica Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SouthAfricaBoundaries','SouthAfricaLat','SouthAfricaLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SouthAfricaLon,SouthAfricaLat);
%         Merra2SouthAfricaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for South Africa');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SouthAfricaMask';
% MatFileName='SouthAfricaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Namibia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NamibiaBoundaries','NAMLat','NAMLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NAMLon,NAMLat);
%         Merra2NamibiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Namibia');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NamibiaMask';
% MatFileName='NamibiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Angola Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AngolaBoundaries','AngolaLat','AngolaLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AngolaLon,AngolaLat);
%         Merra2AngolaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Angola');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AngolaMask';
% MatFileName='AngolaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Gabon Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GabonBoundaries','GabonLat','GabonLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GabonLon,GabonLat);
%         Merra2GabonMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Gabon');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GabonMask';
% MatFileName='GabonMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Mozambique Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MozambiqueBoundaries','MOZLat','MOZLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MOZLon,MOZLat);
%         Merra2MozambiqueMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Mozambique');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MozambiqueMask';
% MatFileName='MozambiqueMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Tanzania Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TanzaniaBoundaries','TanzaniaLat','TanzaniaLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TanzaniaLon,TanzaniaLat);
%         Merra2TanzaniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Tanzania');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TanzaniaMask';
% MatFileName='TanzaniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Kenya Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('KenyaBoundaries','KenyaLat','KenyaLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,KenyaLon,KenyaLat);
%         Merra2KenyaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Kenya');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2KenyaMask';
% MatFileName='KenyaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
% %% Make The Somalia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SomaliaBoundaries','SOMLat','SOMLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SOMLon,SOMLat);
%         Merra2SomaliaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Somalia');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SomaliaMask';
% MatFileName='SomaliaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Ethiopia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('EthiopiaBoundaries','ETHLat','ETHLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ETHLon,ETHLat);
%         Merra2EthiopiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Ethiopia');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2EthiopiaMask';
% MatFileName='EthiopiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Madagascar Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MadagascarBoundaries','MADLat','MADLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MADLon,MADLat);
%         Merra2MadagascarMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Madagascar');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MadagascarMask';
% MatFileName='MadagascarMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Saudi Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SaudiBoundaries','SaudiLat','SaudiLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SaudiLon,SaudiLat);
%         Merra2SaudiMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Saudi');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SaudiMask';
% MatFileName='SaudiMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Yemen Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('YemenBoundaries','YemenLat','YemenLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,YemenLon,YemenLat);
%         Merra2YemenMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Yemen');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2YemenMask';
% MatFileName='YemenMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Oman Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('OmanBoundaries','OmanLat','OmanLon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,OmanLon,OmanLat);
%         Merra2OmanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Oman');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2OmanMask';
% MatFileName='OmanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The UAE Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('UAEBoundaries','UAELat','UAELon');
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,UAELon,UAELat);
%         Merra2UAEMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for UAE');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2UAEMask';
% MatFileName='UAEMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Jordan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('JordanBoundaries','JordanLat','JordanLon');
% Merra2JordanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,JordanLon,JordanLat);
%         Merra2JordanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Jordan');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2JordanMask';
% MatFileName='JordanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Syria Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SyriaBoundaries','SyriaLat','SyriaLon');
% Merra2SyriaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SyriaLon,SyriaLat);
%         Merra2SyriaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Syria');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SyriaMask';
% MatFileName='SyriaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Iraq Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IraqBoundaries','IraqLat','IraqLon');
% Merra2IraqMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IraqLon,IraqLat);
%         Merra2IraqMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Iraq');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IraqMask';
% MatFileName='IraqMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Iran Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IranBoundaries','IranLat','IranLon');
% Merra2IranMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IranLon,IranLat);
%         Merra2IranMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Iran');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IranMask';
% MatFileName='IranMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Afganistan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AfganistanBoundaries.mat','AfganistanLat','AfganistanLon');
% Merra2AfganistanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AfganistanLon,AfganistanLat);
%         Merra2AfganistanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Afganistan');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AfganistanMask';
% MatFileName='AfganistanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr);
%% Make The Pakistan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PakistanBoundaries.mat','PakistanLat','PakistanLon');
% Merra2PakistanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PakistanLon,PakistanLat);
%         Merra2PakistanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Pakistan');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PakistanMask';
% MatFileName='PakistanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Turkey Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TurkeyBoundaries.mat','TurkeyLat','TurkeyLon');
% Merra2TurkeyMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TurkeyLon,TurkeyLat);
%         Merra2TurkeyMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Turkey');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TurkeyMask';
% MatFileName='TurkeyMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Greece Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GreeceBoundaries.mat','GreeceLat','GreeceLon');
% Merra2GreeceMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GreeceLon,GreeceLat);
%         Merra2GreeceMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Greece');
%     disp(dispstr)
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GreeceMask';
% MatFileName='GreeceMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Italy Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ItalyBoundaries.mat','ItalyLat','ItalyLon');
% Merra2ItalyMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ItalyLon,ItalyLat);
%         Merra2ItalyMask(i,j)=in;
%     end
% dispstr=strcat('finished with lon#',num2str(i),'-for Italy');
% disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ItalyMask';
% MatFileName='ItalyMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)

%% Make The France Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('FranceBoundaries.mat','FranceLat','FranceLon');
% Merra2FranceMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,FranceLon,FranceLat);
%         Merra2FranceMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for France');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2FranceMask';
% MatFileName='FranceMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Spain Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SpainBoundaries.mat','SpainLat','SpainLon');
% Merra2SpainMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SpainLon,SpainLat);
%         Merra2SpainMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Spain');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SpainMask';
% MatFileName='SpainMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Portugal Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PortugalBoundaries.mat','PortugalLat','PortugalLon');
% Merra2PortugalMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PortugalLon,PortugalLat);
%         Merra2PortugalMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Portugal');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PortugalMask';
% MatFileName='PortugalMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The UK Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('UKBoundariesRed.mat','UKLat','UKLon');
% Merra2UKMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,UKLon,UKLat);
%         Merra2UKMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for UK');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2UKMask';
% MatFileName='UKMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Ireland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IrelandBoundaries.mat','IrelandLat','IrelandLon');
% Merra2IrelandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IrelandLon,IrelandLat);
%         Merra2IrelandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Ireland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IrelandMask';
% MatFileName='IrelandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Iceland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IcelandBoundaries.mat','IcelandLat','IcelandLon');
% Merra2IcelandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IcelandLon,IcelandLat);
%         Merra2IcelandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Iceland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IcelandMask';
% MatFileName='IcelandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Norway Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NorwayBoundaries.mat','NorwayLat','NorwayLon');
% Merra2NorwayMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NorwayLon,NorwayLat);
%         Merra2NorwayMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Norway');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NorwayMask';
% MatFileName='NorwayMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Sweden Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SwedenBoundaries.mat','SwedenLat','SwedenLon');
% Merra2SwedenMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SwedenLon,SwedenLat);
%         Merra2SwedenMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Sweden');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SwedenMask';
% MatFileName='SwedenMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Finland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('FinlandBoundaries.mat','FinlandLat','FinlandLon');
% Merra2FinlandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,FinlandLon,FinlandLat);
%         Merra2FinlandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Finland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2FinlandMask';
% MatFileName='FinlandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Poland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PolandBoundaries.mat','PolandLat','PolandLon');
% Merra2PolandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PolandLon,PolandLat);
%         Merra2PolandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Poland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PolandMask';
% MatFileName='PolandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Belarus Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BelarusBoundaries.mat','BelarusLat','BelarusLon');
% Merra2BelarusMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BelarusLon,BelarusLat);
%         Merra2BelarusMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Belarus');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BelarusMask';
% MatFileName='BelarusMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)

%% Make The Ukraine Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('UkraineBoundaries.mat','UkraineLat','UkraineLon');
% Merra2UkraineMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq, UkraineLon, UkraineLat);
%         Merra2UkraineMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for  Ukraine');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2UkraineMask';
% MatFileName='UkraineMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
% %% Make The Germany Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GermanyBoundaries.mat','GermanyLat','GermanyLon');
% Merra2GermanyMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GermanyLon,GermanyLat);
%         Merra2GermanyMask(i,j)=in;
%         ab=1;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for  Germany');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GermanyMask';
% MatFileName='GermanyMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Russia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('RussiaBoundariesRed4.mat','RussiaLat','RussiaLon');
% Merra2RussiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,RussiaLon,RussiaLat);
%         Merra2RussiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for  Russia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2RussiaMask';
% MatFileName='RussiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Japan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('JapanBoundaries.mat','JapanLat','JapanLon');
% Merra2JapanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,JapanLon,JapanLat);
%         Merra2JapanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Japan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2JapanMask';
% MatFileName='JapanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The NorthKorea Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NorthKoreaBoundaries.mat','NorthKoreaLat','NorthKoreaLon');
% Merra2NorthKoreaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NorthKoreaLon,NorthKoreaLat);
%         Merra2NorthKoreaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for NorthKorea');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NorthKoreaMask';
% MatFileName='NorthKoreaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The SouthKorea Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SouthKoreaBoundaries.mat','SouthKoreaLat','SouthKoreaLon');
% Merra2SouthKoreaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SouthKoreaLon,SouthKoreaLat);
%         Merra2SouthKoreaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for SouthKorea');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SouthKoreaMask';
% MatFileName='SouthKoreaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Philippines Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PhilippinesBoundaries.mat','PhilLat','PhilLon');
% Merra2PhilippinesMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PhilLon,PhilLat);
%         Merra2PhilippinesMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Philippines');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PhilippinesMask';
% MatFileName='PhilippinesMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Taiwan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TaiwanBoundaries.mat','TaiwanLat','TaiwanLon');
% Merra2TaiwanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TaiwanLon,TaiwanLat);
%         Merra2TaiwanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Taiwan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TaiwanMask';
% MatFileName='TaiwanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Vietnam Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('VietnamBoundaries.mat','VietnamLat','VietnamLon');
% Merra2VietnamMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,VietnamLon,VietnamLat);
%         Merra2VietnamMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Vietnam');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2VietnamMask';
% MatFileName='VietnamMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Laos Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LaosBoundaries.mat','LaosLat','LaosLon');
% Merra2LaosMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LaosLon,LaosLat);
%         Merra2LaosMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Laos');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LaosMask';
% MatFileName='LaosMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Laos Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LaosBoundaries.mat','LaosLat','LaosLon');
% Merra2LaosMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LaosLon,LaosLat);
%         Merra2LaosMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Laos');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LaosMask';
% MatFileName='LaosMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Cambodia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CambodiaBoundaries.mat','CambodiaLat','CambodiaLon');
% Merra2CambodiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CambodiaLon,CambodiaLat);
%         Merra2CambodiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Cambodia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CambodiaMask';
% MatFileName='CambodiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Thailand Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ThailandBoundaries.mat','ThailandLat','ThailandLon');
% Merra2ThailandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ThailandLon,ThailandLat);
%         Merra2ThailandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Thailand');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ThailandMask';
% MatFileName='ThailandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Indonesia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IndonesiaBoundaries.mat','IndLat','IndLon');
% Merra2IndonesiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IndLon,IndLat);
%         Merra2IndonesiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Indonesia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IndonesiaMask';
% MatFileName='IndonesiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Bangladesh Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BangladeshBoundaries.mat','BangladeshLat','BangladeshLon');
% Merra2BangladeshMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BangladeshLon,BangladeshLat);
%         Merra2BangladeshMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Bangladesh');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BangladeshMask';
% MatFileName='BangladeshMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Nepal Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NepalBoundaries.mat','NepalLat','NepalLon');
% Merra2NepalMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NepalLon,NepalLat);
%         Merra2NepalMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Nepal');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NepalMask';
% MatFileName='NepalMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Burma Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BurmaBoundaries.mat','BurmaLat','BurmaLon');
% Merra2BurmaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BurmaLon,BurmaLat);
%         Merra2BurmaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Burma');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BurmaMask';
% MatFileName='BurmaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Malaysia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MalaysiaBoundaries.mat','MalaysiaLat','MalaysiaLon');
% Merra2MalaysiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MalaysiaLon,MalaysiaLat);
%         Merra2MalaysiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Malaysia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MalaysiaMask';
% MatFileName='MalaysiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Brazil Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BrazilBoundaries.mat','BrazilLat','BrazilLon');
% Merra2BrazilMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BrazilLon,BrazilLat);
%         Merra2BrazilMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Brazil');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BrazilMask';
% MatFileName='BrazilMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Argentina Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ArgentinaBoundaries.mat','ArgentinaLat','ArgentinaLon');
% Merra2ArgentinaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ArgentinaLon,ArgentinaLat);
%         Merra2ArgentinaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Argentina');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ArgentinaMask';
% MatFileName='ArgentinaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
% %% Make The Venezuela Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('VenezuelaBoundaries.mat','VenezuelaLat','VenezuelaLon');
% Merra2VenezuelaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,VenezuelaLon,VenezuelaLat);
%         Merra2VenezuelaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Venezuela');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2VenezuelaMask';
% MatFileName='VenezuelaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Columbia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ColumbiaBoundaries.mat','ColumbiaLat','ColumbiaLon');
% Merra2ColumbiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ColumbiaLon,ColumbiaLat);
%         Merra2ColumbiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Columbia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ColumbiaMask';
% MatFileName='ColumbiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Ecuador Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('EcuadorBoundaries.mat','EcuadorLat','EcuadorLon');
% Merra2EcuadorMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,EcuadorLon,EcuadorLat);
%         Merra2EcuadorMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Ecuador');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2EcuadorMask';
% MatFileName='EcuadorMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Peru Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PeruBoundaries.mat','PeruLat','PeruLon');
% Merra2PeruMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PeruLon,PeruLat);
%         Merra2PeruMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Peru');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PeruMask';
% MatFileName='PeruMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Bolivia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BoliviaBoundaries.mat','BoliviaLat','BoliviaLon');
% Merra2BoliviaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BoliviaLon,BoliviaLat);
%         Merra2BoliviaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Bolivia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BoliviaMask';
% MatFileName='BoliviaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Chile Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ChileBoundaries.mat','ChileLat','ChileLon');
% Merra2ChileMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ChileLon,ChileLat);
%         Merra2ChileMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Chile');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ChileMask';
% MatFileName='ChileMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Paraguay Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ParaguayBoundaries.mat','ParaguayLat','ParaguayLon');
% Merra2ParaguayMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ParaguayLon,ParaguayLat);
%         Merra2ParaguayMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Paraguay');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ParaguayMask';
% MatFileName='ParaguayMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Uruguay Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('UruguayBoundaries.mat','UruguayLat','UruguayLon');
% Merra2UruguayMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,UruguayLon,UruguayLat);
%         Merra2UruguayMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Uruguay');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2UruguayMask';
% MatFileName='UruguayMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Mexico Mask-Failed problem with dataset
% eval(['cd ' boundarypath(1:length(boundarypath)-1)]);
% load('MexicoNewBoundaries.mat','MexicoLat','MexicoLon');
% Merra2MexicoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MexicoLon,MexicoLat);
%         Merra2MexicoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Mexico');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MexicoMask';
% MatFileName='MexicoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Gautemala Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GautemalaBoundaries.mat','GautemalaLat','GautemalaLon');
% Merra2GautemalaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GautemalaLon,GautemalaLat);
%         Merra2GautemalaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Gautemala');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GautemalaMask';
% MatFileName='GautemalaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Honduras Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('HondurasBoundaries.mat','HondurasLat','HondurasLon');
% Merra2HondurasMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,HondurasLon,HondurasLat);
%         Merra2HondurasMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Honduras');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2HondurasMask';
% MatFileName='HondurasMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Cuba Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CubaBoundaries.mat','CubaLat','CubaLon');
% Merra2CubaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CubaLon,CubaLat);
%         Merra2CubaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Cuba');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CubaMask';
% MatFileName='CubaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Greenland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GreenlandBoundaries.mat','GreenlandLat','GreenlandLon');
% Merra2GreenlandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GreenlandLon,GreenlandLat);
%         Merra2GreenlandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Greenland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GreenlandMask';
% MatFileName='GreenlandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Canada Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CanadaBoundariesRed4.mat','CanadaLat','CanadaLon');
% Merra2CanadaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CanadaLon,CanadaLat);
%         Merra2CanadaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Canada');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CanadaMask';
% MatFileName='CanadaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Zambia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ZambiaBoundaries.mat','ZambiaLat','ZambiaLon');
% Merra2ZambiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ZambiaLon,ZambiaLat);
%         Merra2ZambiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Zambia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ZambiaMask';
% MatFileName='ZambiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Zimbabwe Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ZimbabweBoundaries.mat','ZimbabweLat','ZimbabweLon');
% Merra2ZimbabweMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ZimbabweLon,ZimbabweLat);
%         Merra2ZimbabweMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Zimbabwe');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ZimbabweMask';
% MatFileName='ZimbabweMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The WestSahara Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('WestSaharaBoundaries.mat','WestSaharaLat','WestSaharaLon');
% Merra2WestSaharaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,WestSaharaLon,WestSaharaLat);
%         Merra2WestSaharaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for WestSahara');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2WestSaharaMask';
% MatFileName='WestSaharaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Austria Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AustriaBoundaries.mat','AustriaLat','AustriaLon');
% Merra2AustriaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AustriaLon,AustriaLat);
%         Merra2AustriaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Austria');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AustriaMask';
% MatFileName='AustriaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Azerbaijan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AzerbaijanBoundaries.mat','AzerbaijanLat','AzerbaijanLon');
% Merra2AzerbaijanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AzerbaijanLon,AzerbaijanLat);
%         Merra2AzerbaijanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),['-for Azerbaijan' ...
%         '']);
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AzerbaijanMask';
% MatFileName='AzerbaijanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The COD Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CODBoundaries.mat','CODLat','CODLon');
% Merra2CODMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CODLon,CODLat);
%         Merra2CODMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for COD');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CODMask';
% MatFileName='CODMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Armenia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ArmeniaBoundaries.mat','ArmeniaLat','ArmeniaLon');
% Merra2ArmeniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ArmeniaLon,ArmeniaLat);
%         Merra2ArmeniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Armenia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ArmeniaMask';
% MatFileName='ArmeniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Belgium Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BelgiumBoundaries.mat','BelgiumLat','BelgiumLon');
% Merra2BelgiumMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BelgiumLon,BelgiumLat);
%         Merra2BelgiumMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Belgium');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BelgiumMask';
% MatFileName='BelgiumMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Bosnia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BosniaBoundaries.mat','BosniaLat','BosniaLon');
% Merra2BosniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BosniaLon,BosniaLat);
%         Merra2BosniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Bosnia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BosniaMask';
% MatFileName='BosniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Bhutan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BhutanBoundaries.mat','BhutanLat','BhutanLon');
% Merra2BhutanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BhutanLon,BhutanLat);
%         Merra2BhutanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Bhutan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BhutanMask';
% MatFileName='BhutanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Botswana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BotswanaBoundaries.mat','BotLat','BotLon');
% Merra2BotswanaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BotLon,BotLat);
%         Merra2BotswanaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Botswana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BotswanaMask';
% MatFileName='BotswanaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Bulgaria Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BulgariaBoundaries.mat','BulgariaLat','BulgariaLon');
% Merra2BulgariaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BulgariaLon,BulgariaLat);
%         Merra2BulgariaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Bulgaria');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BulgariaMask';
% MatFileName='BulgariaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Cyprus Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CyprusBoundaries.mat','CyprusLat','CyprusLon');
% Merra2CyprusMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CyprusLon,CyprusLat);
%         Merra2CyprusMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Cyprus');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CyprusMask';
% MatFileName='CyprusMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Czech Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CzechBoundaries.mat','CzechLat','CzechLon');
% Merra2CzechMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CzechLon,CzechLat);
%         Merra2CzechMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Cyprus');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CzechMask';
% MatFileName='CzechMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Denmark Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('DenmarkBoundaries.mat','DenmarkLat','DenmarkLon');
% Merra2DenmarkMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,DenmarkLon,DenmarkLat);
%         Merra2DenmarkMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Denmark');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2DenmarkMask';
% MatFileName='DenmarkMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Dominica Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('DominicaBoundaries.mat','DominicaLat','DominicaLon');
% Merra2DominicaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         try
%             [in,on]=inpolygon(xqq,yqq,DominicaLon,DominicaLat);
%             Merra2DominicaMask(i,j)=in;
%         catch
%             Merra2DominicaMask(i,j)=0;
%         end
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for Dominica');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2DominicaMask';
% MatFileName='DominicaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
% ab=1;
%% Make The DomincanRepublic Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('DominicanRepublicBoundaries','DRLat','DRLon');
% Merra2DominicanRepublicMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,DRLon,DRLat);
%         Merra2DominicanRepublicMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for DomincanRepublic');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2DominicanRepublicMask';
% MatFileName='DominicanRepublicMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The ElSalvador Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ElSalvadorBoundaries.mat','ElSalvadorLat','ElSalvadorLon');
% Merra2ElSalvadorMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ElSalvadorLon,ElSalvadorLat);
%         Merra2ElSalvadorMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-for ElSalvador');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ElSalvadorMask';
% MatFileName='ElSalvadorMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Eritrea Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('EritreaBoundaries.mat','ERILat','ERILon');
% Merra2EritreaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ERILon,ERILat);
%         Merra2EritreaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Eritrea');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2EritreaMask';
% MatFileName='EritreaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Estonia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('EstoniaBoundaries.mat','EstoniaLat','EstoniaLon');
% Merra2EstoniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,EstoniaLon,EstoniaLat);
%         Merra2EstoniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Estonia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2EstoniaMask';
% MatFileName='EstoniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Gambia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GambiaBoundaries.mat','GambiaLat','GambiaLon');
% Merra2GambiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GambiaLon,GambiaLat);
%         Merra2GambiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Gambia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GambiaMask';
% MatFileName='GambiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Ghana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GhanaBoundaries.mat','GhanaLat','GhanaLon');
% Merra2GhanaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GhanaLon,GhanaLat);
%         Merra2GhanaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Ghana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GhanaMask';
% MatFileName='GhanaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Antarctic Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AntarcticBoundaries.mat','AntarcticLat','AntarcticLon');
% Merra2AntarcticMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AntarcticLon,AntarcticLat);
%         Merra2AntarcticMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Antarctic');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AntarcticMask';
% MatFileName='AntarcticMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)

%% Make The Guinea Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GuineaBoundaries.mat','GuineaLat','GuineaLon');
% Merra2GuineaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GuineaLon,GuineaLat);
%         Merra2GuineaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Guinea');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GuineaMask';
% MatFileName='GuineaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Haiti Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('HaitiBoundaries.mat','HaitiLat','HaitiLon');
% Merra2HaitiMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,HaitiLon,HaitiLat);
%         Merra2HaitiMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Haiti');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2HaitiMask';
% MatFileName='HaitiMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Hungary Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('HungaryBoundaries.mat','HungaryLat','HungaryLon');
% Merra2HaitiMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,HungaryLon,HungaryLat);
%         Merra2HaitiMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Hungary');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2HungaryMask';
% MatFileName='HungaryMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The IvoryCoast Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IvoryCoastBoundaries.mat','CIVLat','CIVLon');
% Merra2IvoryCoastMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CIVLon,CIVLat);
%         Merra2IvoryCoastMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Ivory Coast');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IvoryCoastMask';
% MatFileName='IvoryCoastMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Jamaica Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('JamaicaBoundaries.mat','JamaicaLat','JamaicaLon');
% Merra2JamaicaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,JamaicaLon,JamaicaLat);
%         Merra2JamaicaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Jamaica');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2JamaicaMask';
% MatFileName='JamaicaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The KazakhstanMask Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('KazakhstanBoundaries.mat','KazakhstanLat','KazakhstanLon');
% Merra2KazakhstanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,KazakhstanLon,KazakhstanLat);
%         Merra2KazakhstanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Kazakhstan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2KazakhstanMask';
% MatFileName='KazakhstanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The KuwaitMask Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('KuwaitBoundaries.mat','KuwaitLat','KuwaitLon');
% Merra2KuwaitMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,KuwaitLon,KuwaitLat);
%         Merra2KuwaitMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Kuwait');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2KuwaitMask';
% MatFileName='KuwaitMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The KyrgyzstanMask Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('KyrgyzstanBoundaries.mat','KyrgyzstanLat','KyrgyzstanLon');
% Merra2KyrgyzstanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,KyrgyzstanLon,KyrgyzstanLat);
%         Merra2KyrgyzstanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Kyrgyzstan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2KyrgyzstanMask';
% MatFileName='KyrgyzstanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Latvia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LatviaBoundaries.mat','LatviaLat','LatviaLon');
% Merra2LatviaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LatviaLon,LatviaLat);
%         Merra2LatviaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Latvia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LatviaMask';
% MatFileName='LatviaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)

%% Make The Lebanon Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LebanonBoundaries.mat','LebanonLat','LebanonLon');
% Merra2LebanonMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LebanonLon,LebanonLat);
%         Merra2LebanonMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Lebanon');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LebanonMask';
% MatFileName='LebanonMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Lesotho Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LesothoBoundaries.mat','LSOLat','LSOLon');
% Merra2LesothoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LSOLon,LSOLat);
%         Merra2LesothoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Lesotho');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LesothoMask';
% MatFileName='LesothoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Liberia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LiberiaBoundaries.mat','LiberiaLat','LiberiaLon');
% Merra2LiberiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LiberiaLon,LiberiaLat);
%         Merra2LiberiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Liberia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LiberiaMask';
% MatFileName='LiberiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Lithuania Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LithuaniaBoundaries.mat','LithuaniaLat','LithuaniaLon');
% Merra2LithuaniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LithuaniaLon,LithuaniaLat);
%         Merra2LithuaniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Lithuania');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LithuaniaMask';
% MatFileName='LithuaniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Macedonia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MacedoniaBoundaries.mat','MacedoniaLat','MacedoniaLon');
% Merra2MacedoniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MacedoniaLon,MacedoniaLat);
%         Merra2MacedoniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Macedonia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MacedoniaMask';
% MatFileName='MacedoniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Malawi Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MalawiBoundaries.mat','MalawiLat','MalawiLon');
% Merra2MalawiMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MalawiLon,MalawiLat);
%         Merra2MalawiMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Malawi');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MalawiMask';
% MatFileName='MalawiMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Mali Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MaliBoundaries.mat','MaliLat','MaliLon');
% Merra2MaliMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MaliLon,MaliLat);
%         Merra2MaliMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Mali');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MaliMask';
% MatFileName='MaliMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The EquatorialGuinea Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('EquatorialGuineaBoundaries.mat','GNQLat','GNQLon');
% Merra2EquatorialGuineaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GNQLon,GNQLat);
%         Merra2EquatorialGuineaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-EquatorialGuinea');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2EquatorialGuineaMask';
% MatFileName='EquatorialGuineaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)

%% Make The Guiana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GuianaBoundaries.mat','GuianaLat','GuianaLon');
% Merra2GuianaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GuianaLon,GuianaLat);
%         Merra2GuianaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Guiana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GuianaMask';
% MatFileName='GuianaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)

%% Make The Guyana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GuyanaBoundaries.mat','GuyanaLat','GuyanaLon');
% Merra2GuyanaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GuyanaLon,GuyanaLat);
%         Merra2GuyanaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Guyana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GuyanaMask';
% MatFileName='GuyanaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Mongolia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MongoliaBoundaries.mat','MongoliaLat','MongoliaLon');
% Merra2MongoliaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MongoliaLon,MongoliaLat);
%         Merra2MongoliaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Mongolia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MongoliaMask';
% MatFileName='MongoliaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Netherlands Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NetherlandsBoundaries.mat','NetherlandsLat','NetherlandsLon');
% Merra2NetherlandsMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NetherlandsLon,NetherlandsLat);
%         Merra2NetherlandsMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Netherlands');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NetherlandsMask';
% MatFileName='NetherlandsMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The NewGuinea Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewGuineaBoundaries.mat','NGLat','NGLon');
% Merra2NewGuineaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NGLon,NGLat);
%         Merra2NewGuineaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-NewGuinea');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewGuineaMask';
% MatFileName='NewGuineaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The NewZealand Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewZealandBoundaries.mat','NZLat','NZLon');
% Merra2NewZealandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NZLon,NZLat);
%         Merra2NewZealandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-NewZealand');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewZealandMask';
% MatFileName='NewZealandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Nicaragua Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NicaraguaBoundaries.mat','NicaraguaLat','NicaraguaLon');
% Merra2NicaraguaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NicaraguaLon,NicaraguaLat);
%         Merra2NicaraguaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Nicaragua');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NicaraguaMask';
% MatFileName='NicaraguaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Matlab File-',MatFileName);
% disp(dispstr)
%% Make The Panama Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PanamaBoundaries.mat','PanamaLat','PanamaLon');
% Merra2PanamaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PanamaLon,PanamaLat);
%         Merra2PanamaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Panama');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PanamaMask';
% MatFileName='PanamaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Panama File-',MatFileName);
% disp(dispstr)
%% Make The PuertoRico Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PuertoRicoBoundaries.mat','PRLat','PRLon');
% Merra2PuertoRicoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PRLon,PRLat);
%         Merra2PuertoRicoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-PuertoRico');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PuertoRicoMask';
% MatFileName='PuertoRicoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote PuertoRico File-',MatFileName);
% disp(dispstr)
% %% Make The Qatar Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('QatarBoundaries.mat','QatarLat','QatarLon');
% Merra2QatarMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,QatarLon,QatarLat);
%         Merra2QatarMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Qatar');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2QatarMask';
% MatFileName='QatarMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Qartar File-',MatFileName);
% disp(dispstr)
%% Make The Romania Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('RomaniaBoundaries.mat','RomaniaLat','RomaniaLon');
% Merra2RomaniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,RomaniaLon,RomaniaLat);
%         Merra2RomaniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Romania');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2RomaniaMask';
% MatFileName='RomaniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Romania File-',MatFileName);
% disp(dispstr)

%% Make The Rwanda Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('RwandaBoundaries.mat','RwandaLat','RwandaLon');
% Merra2RwandaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,RwandaLon,RwandaLat);
%         Merra2RwandaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Rwanda');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2RwandaMask';
% MatFileName='RwandaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Rwanda File-',MatFileName);
% disp(dispstr)
%% Make The Senegal Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SenegalBoundaries.mat','SenegalLat','SenegalLon');
% Merra2SenegalMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SenegalLon,SenegalLat);
%         Merra2SenegalMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Senegal');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SenegalMask';
% MatFileName='SenegalMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Senegal File-',MatFileName);
% disp(dispstr)
%% Make The Serbia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SerbiaBoundaries.mat','SerbiaLat','SerbiaLon');
% Merra2SerbiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SerbiaLon,SerbiaLat);
%         Merra2SerbiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Serbia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SerbiaMask';
% MatFileName='SerbiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Serbia File-',MatFileName);
% disp(dispstr)
%% Make The SierraLeone Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SierraLeoneBoundaries.mat','SLALat','SLALon');
% Merra2SierraLeoneMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SLALon,SLALat);
%         Merra2SierraLeoneMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-SierraLeone');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SierraLeoneMask';
% MatFileName='SierraLeoneMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote SierraLeone File-',MatFileName);
% disp(dispstr)
%% Make The Rwanda Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('RwandaBoundaries.mat','RwandaLat','RwandaLon');
% Merra2RwandaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,RwandaLon,RwandaLat);
%         Merra2RwandaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Rwanda');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2RwandaMask';
% MatFileName='RwandaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Rwanda File-',MatFileName);
% disp(dispstr)
%% Make The Senegal Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SenegalBoundaries.mat','SenegalLat','SenegalLon');
% Merra2SenegalMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SenegalLon,SenegalLat);
%         Merra2SenegalMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Senegal');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SenegalMask';
% MatFileName='SenegalMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Senegal File-',MatFileName);
% disp(dispstr)
%% Make The Serbia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SerbiaBoundaries.mat','SerbiaLat','SerbiaLon');
% Merra2SerbiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SerbiaLon,SerbiaLat);
%         Merra2SerbiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Serbia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SerbiaMask';
% MatFileName='SerbiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Serbia File-',MatFileName);
% disp(dispstr)
%% Make The Slovakia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SlovakiaBoundaries.mat','SlovakiaLat','SlovakiaLon');
% Merra2SlovakiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SlovakiaLon,SlovakiaLat);
%         Merra2SlovakiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Slovakia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SlovakiaMask';
% MatFileName='SlovakiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Slovakia File-',MatFileName);
% disp(dispstr)
%% Make The Slovenia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SloveniaBoundaries.mat','SloveniaLat','SloveniaLon');
% Merra2SloveniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq, SloveniaLon, SloveniaLat);
%         Merra2SloveniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Slovakia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SloveniaMask';
% MatFileName=' SloveniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote  Slovenia File-',MatFileName);
% disp(dispstr)
%% Make The SriLanka Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SriLankaBoundaries.mat','SriLankaLat','SriLankaLon');
% Merra2SriLankaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq, SriLankaLon, SriLankaLat);
%         Merra2SriLankaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-SriLanka');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SriLankaMask';
% MatFileName=' SriLankaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote  SriLanka File-',MatFileName);
% disp(dispstr)
%% Make The Suriname Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SurinameBoundaries.mat','SurinameLat','SurinameLon');
% Merra2SurinameMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SurinameLon,SurinameLat);
%         Merra2SurinameMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Suriname');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SurinameMask';
% MatFileName='SurinameMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote  Suriname File-',MatFileName);
% disp(dispstr)
%% Make The Swaziland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SwazilandBoundaries.mat','SWZLat','SWZLon');
% Merra2SwazilandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SWZLon,SWZLat);
%         Merra2SwazilandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Swaziland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SwazilandMask';
% MatFileName='SwazilandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Swaziland File-',MatFileName);
% disp(dispstr)
%% Make The Switzerland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SwitzerLandBoundaries.mat','SwitzerLandLat','SwitzerLandLon');
% Merra2SwitzerlandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SwitzerLandLon,SwitzerLandLat);
%         Merra2SwitzerlandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Switzerland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SwitzerlandMask';
% MatFileName='SwitzerlandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Switzerland File-',MatFileName);
% disp(dispstr)
%% Make The Tajikistan Mask   
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TajikistanBoundaries.mat','TajikistanLat','TajikistanLon');
% Merra2TajikistanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TajikistanLon,TajikistanLat);
%         Merra2TajikistanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Tajikistan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TajikistanMask';
% MatFileName='TajikistanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Tajikistan File-',MatFileName);
% disp(dispstr)
%% Make The Tunisia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TunisiaBoundaries.mat','TunisiaLat','TunisiaLon');
% Merra2TunisiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TunisiaLon,TunisiaLat);
%         Merra2TunisiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Tunisia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TunisiaMask';
% MatFileName='TunisiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Tunisia File-',MatFileName);
% disp(dispstr)
%% Make The Turkmenistan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TurkmenistanBoundaries.mat','TurkmenistanLat','TurkmenistanLon');
% Merra2TurkmenistanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TurkmenistanLon,TurkmenistanLat);
%         Merra2TurkmenistanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Turkmenistan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TurkmenistanMask';
% MatFileName='TurkmenistanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Turkmenistan File-',MatFileName);
% disp(dispstr)
%% Make The Uganda Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('UgandaBoundaries.mat','UGALat','UGALon');
% Merra2UgandaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,UGALon,UGALat);
%         Merra2UgandaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Uganda');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2UgandaMask';
% MatFileName='UgandaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Uganda File-',MatFileName);
% disp(dispstr)
%% Make The Albania Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AlbaniaBoundaries.mat','AlbaniaLat','AlbaniaLon');
% Merra2AlbaniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AlbaniaLon,AlbaniaLat);
%         Merra2AlbaniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'Albania');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AlbaniaMask';
% MatFileName='AlbaniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Albania File-',MatFileName);
% disp(dispstr)
%% Make The Alabama Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AlabamaBoundaries.mat','AlabamaLat','AlabamaLon');
% Merra2AlabamaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AlabamaLon,AlabamaLat);
%         Merra2AlabamaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Alabama');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AlabamaMask';
% MatFileName='AlabamaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Alabama File-',MatFileName);
% disp(dispstr)
%% Make The Alaska Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AlaskaBoundariesRed.mat','AlaskaLat','AlaskaLon');
% Merra2AlaskaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AlaskaLon,AlaskaLat);
%         Merra2AlaskaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Alaska');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AlaskaMask';
% MatFileName='AlaskaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Alaska File-',MatFileName);
% disp(dispstr)
%% Make The Arizona Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ArizonaBoundaries.mat','ArizonaLat','ArizonaLon');
% Merra2ArizonaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ArizonaLon,ArizonaLat);
%         Merra2ArizonaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Arizona');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ArizonaMask';
% MatFileName='ArizonaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Arizona File-',MatFileName);
% disp(dispstr)
%% Make The Arkansas Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ArkansasBoundaries.mat','ArkansasLat','ArkansasLon');
% Merra2ArkansasMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ArkansasLon,ArkansasLat);
%         Merra2ArkansasMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Arkansas');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ArkansasMask';
% MatFileName='ArkansasMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Arkansas File-',MatFileName);
% disp(dispstr)
%% Make The California Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CaliforniaBoundaries.mat','CaliforniaLat','CaliforniaLon');
% Merra2CaliforniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CaliforniaLon,CaliforniaLat);
%         Merra2CaliforniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-California');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CaliforniaMask';
% MatFileName='CaliforniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote California File-',MatFileName);
% disp(dispstr)
%% Make The Colorado Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ColoradoBoundaries.mat','ColoradoLat','ColoradoLon');
% Merra2ColoradoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ColoradoLon,ColoradoLat);
%         Merra2ColoradoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Colorado');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ColoradoMask';
% MatFileName='ColoradoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Colorado File-',MatFileName);
% disp(dispstr)

%% Make The Connecticut Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ConnecticutBoundaries.mat','ConnLat','ConnLon');
% Merra2ConnecticutMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ConnLon,ConnLat);
%         Merra2ConnecticutMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Connecticut');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ConnecticutMask';
% MatFileName='ConnecticutMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Connecticut File-',MatFileName);
% disp(dispstr)
%% Make The Delaware Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('DelawareBoundaries.mat','DelawareLat','DelawareLon');
% Merra2ColoradoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,DelawareLon,DelawareLat);
%         Merra2DelawareMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Delaware');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2DelawareMask';
% MatFileName='DelawareMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Delaware File-',MatFileName);
% disp(dispstr)

%% Make The Florida Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('FloridaBoundaries.mat','FloridaLat','FloridaLon');
% Merra2FloridaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,FloridaLon,FloridaLat);
%         Merra2FloridaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Florida');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2FloridaMask';
% MatFileName='FloridaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Florida File-',MatFileName);
% disp(dispstr)
%% Make The Georgia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GeorgiaBoundaries.mat','GeorgiaLat','GeorgiaLon');
% Merra2GeorgiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GeorgiaLon,GeorgiaLat);
%         Merra2GeorgiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Georgia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GeorgiaMask';
% MatFileName='GeorgiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Georgia File-',MatFileName);
% disp(dispstr)

%% Make The Hawaii Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('HawaiiBoundaries.mat','HawaiiLat','HawaiiLon');
% Merra2HawaiiMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,HawaiiLon,HawaiiLat);
%         Merra2HawaiiMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Hawaii');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2HawaiiMask';
% MatFileName='HawaiiMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Hawaii File-',MatFileName);
% disp(dispstr)
%% Make The Idaho Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IdahoBoundaries.mat','IdahoLat','IdahoLon');
% Merra2IdahoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IdahoLon,IdahoLat);
%         Merra2IdahoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Idaho');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IdahoMask';
% MatFileName='IdahoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Idaho File-',MatFileName);
% disp(dispstr)

%% Make The Illinois Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IllinoisBoundaries.mat','IllinoisLat','IllinoisLon');
% Merra2IllinoisMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IllinoisLon,IllinoisLat);
%         Merra2IllinoisMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Illinois');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IllinoisMask';
% MatFileName='IllinoisMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Illinois File-',MatFileName);
% disp(dispstr)
%% Make The Indiana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IndianaBoundaries.mat','IndianaLat','IndianaLon');
% Merra2IndianaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IndianaLon,IndianaLat);
%         Merra2IndianaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Indiana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IndianaMask';
% MatFileName='IndianaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Indiana File-',MatFileName);
% disp(dispstr)

%% Make The Iowa Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IowaBoundaries.mat','IowaLat','IowaLon');
% Merra2IowaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IowaLon,IowaLat);
%         Merra2IowaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Iowa');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IowaMask';
% MatFileName='IowaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Iowa File-',MatFileName);
% disp(dispstr)
%% Make The Kansas Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('KansasBoundaries.mat','KansasLat','KansasLon');
% Merra2KansasMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,KansasLon,KansasLat);
%         Merra2KansasMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Kansas');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2KansasMask';
% MatFileName='KansasMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Kansas File-',MatFileName);
% disp(dispstr)

%% Make The Kentucky Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('KentuckyBoundaries.mat','KentuckyLat','KentuckyLon');
% Merra2KentuckyMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,KentuckyLon,KentuckyLat);
%         Merra2KentuckyMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Kentucky');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2KentuckyMask';
% MatFileName='KentuckyMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat(['Wrote Kentucky' ...
%     ' File-'],MatFileName);
% disp(dispstr)
%% Make The Louisiana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LouisianaBoundaries.mat','LouisianaLat','LouisianaLon');
% Merra2LouisianaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LouisianaLon,LouisianaLat);
%         Merra2LouisianaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Louisiana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LouisianaMask';
% MatFileName='LouisianaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Louisiana File-',MatFileName);
% disp(dispstr)

%% Make The Maine Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MaineBoundaries.mat','MaineLat','MaineLon');
% Merra2MaineMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MaineLon,MaineLat);
%         Merra2MaineMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Maine');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MaineMask';
% MatFileName='MaineMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Maine File-',MatFileName);
% disp(dispstr)
%% Make The Maryland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MarylandBoundaries.mat','MarylandLat','MarylandLon');
% Merra2MarylandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MarylandLon,MarylandLat);
%         Merra2MarylandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Maryland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MarylandMask';
% MatFileName='MarylandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Maryland File-',MatFileName);
% disp(dispstr)

%% Make The Massachusetts Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MassachusettsBoundaries.mat','MassLat','MassLon');
% Merra2MassachusettsMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MassLon,MassLat);
%         Merra2MassachusettsMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Mass');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MassachusettsMask';
% MatFileName='MassachusettsMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Massachusetts File-',MatFileName);
% disp(dispstr)
%% Make The Michigan Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MichiganBoundaries.mat','MichiganLat','MichiganLon');
% Merra2MichiganMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MichiganLon,MichiganLat);
%         Merra2MichiganMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Michigan');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MichiganMask';
% MatFileName='MichiganMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Michigan File-',MatFileName);
% disp(dispstr)

%% Make The Minnesota Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MinnesotaBoundaries.mat','MinnesotaLat','MinnesotaLon');
% Merra2MinnesotaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MinnesotaLon,MinnesotaLat);
%         Merra2MinnesotaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Minnesota');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MinnesotaMask';
% MatFileName='MinnesotaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Minnesota File-',MatFileName);
% disp(dispstr)
%% Make The Mississippi Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MississippiBoundaries.mat','MississippiLat','MississippiLon');
% Merra2MississippiMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MississippiLon,MississippiLat);
%         Merra2MississippiMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Mississippi');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MississippiMask';
% MatFileName='MississippiMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Mississippi File-',MatFileName);
% disp(dispstr)

%% Make The Missouri Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MissouriBoundaries.mat','MissouriLat','MissouriLon');
% Merra2MissouriMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MissouriLon,MissouriLat);
%         Merra2MissouriMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Missouri');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MissouriMask';
% MatFileName='MissouriMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Missouri File-',MatFileName);
% disp(dispstr)
%% Make The Montana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('Montana_Boundaries.mat','MontanaLat','MontanaLon');
% Merra2MontanaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MontanaLon,MontanaLat);
%         Merra2MontanaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Montana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MontanaMask';
% MatFileName='MontanaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Montana File-',MatFileName);
% disp(dispstr)

%% Make The Nebraska Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('Nebraska_Boundaries.mat','NebraskaLat','NebraskaLon');
% Merra2NebraskaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NebraskaLon,NebraskaLat);
%         Merra2NebraskaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Nebraska');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NebraskaMask';
% MatFileName='NebraskaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Nebraska File-',MatFileName);
% disp(dispstr)
%% Make The Nevada Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('Nevada_Boundaries.mat','NevadaLat','NevadaLon');
% Merra2NevadaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NevadaLon,NevadaLat);
%         Merra2NevadaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Nevada');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NevadaMask';
% MatFileName='NevadaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Nevada File-',MatFileName);
% disp(dispstr)

%% Make The NewHampshire Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewHampshire_Boundaries.mat','NHLat','NHLon');
% Merra2NewHampshireMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NHLon,NHLat);
%         Merra2NewHampshireMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NewHampshire');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewHampshireMask';
% MatFileName='NewHampshireMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NewHampshire File-',MatFileName);
% disp(dispstr)
%% Make The NewJersey Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewJerseyBoundaries.mat','NewJerseyLat','NewJerseyLon');
% Merra2NewJerseyMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NewJerseyLon,NewJerseyLat);
%         Merra2NewJerseyMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NewJersey');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewJerseyMask';
% MatFileName='NewJerseyMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NewJersey File-',MatFileName);
% disp(dispstr)

%% Make The NewMexico Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewMexicoBoundaries.mat','NewMexicoLat','NewMexicoLon');
% Merra2NewMexicoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NewMexicoLon,NewMexicoLat);
%         Merra2NewMexicoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NewMexico');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewMexicoMask';
% MatFileName='NewMexicoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NewMexico File-',MatFileName);
% disp(dispstr)
%% Make The NewYork Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewYorkBoundaries.mat','NewYorkLat','NewYorkLon');
% Merra2NewYorkMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NewYorkLon,NewYorkLat);
%         Merra2NewYorkMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NewYork');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewYorkMask';
% MatFileName='NewYorkMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NewYork File-',MatFileName);
% disp(dispstr)

%% Make The NorthCarolina Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NorthCarolinaBoundaries.mat','NorthCarolinaLat','NorthCarolinaLon');
% Merra2NorthCarolinaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NorthCarolinaLon,NorthCarolinaLat);
%         Merra2NorthCarolinaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NorthCarolina');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NorthCarolinaMask';
% MatFileName='NorthCarolinaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NorthCarolina File-',MatFileName);
% disp(dispstr)
%% Make The NewJersey Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewJerseyBoundaries.mat','NewJerseyLat','NewJerseyLon');
% Merra2NewJerseyMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NewJerseyLon,NewJerseyLat);
%         Merra2NewJerseyMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NewJersey');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewJerseyMask';
% MatFileName='NewJerseyMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NewJersey File-',MatFileName);
% disp(dispstr)

%% Make The NewMexico Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewMexicoBoundaries.mat','NewMexicoLat','NewMexicoLon');
% Merra2NewMexicoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NewMexicoLon,NewMexicoLat);
%         Merra2NewMexicoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NewMexico');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewMexicoMask';
% MatFileName='NewMexicoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NewMexico File-',MatFileName);
% disp(dispstr)
%% Make The NewYork Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NewYorkBoundaries.mat','NewYorkLat','NewYorkLon');
% Merra2NewYorkMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NewYorkLon,NewYorkLat);
%         Merra2NewYorkMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NewYork');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NewYorkMask';
% MatFileName='NewYorkMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NewYork File-',MatFileName);
% disp(dispstr)

%% Make The NorthCarolina Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NorthCarolinaBoundaries.mat','NorthCarolinaLat','NorthCarolinaLon');
% Merra2NorthCarolinaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NorthCarolinaLon,NorthCarolinaLat);
%         Merra2NorthCarolinaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NorthCarolina');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NorthCarolinaMask';
% MatFileName='NorthCarolinaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NorthCarolina File-',MatFileName);
% disp(dispstr)
%% Make The NorthDakota Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('NorthDakotaBoundaries.mat','NorthDakotaLat','NorthDakotaLon');
% Merra2NorthDakotaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,NorthDakotaLon,NorthDakotaLat);
%         Merra2NorthDakotaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-NorthDakota');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2NorthDakotaMask';
% MatFileName='NorthDakotaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote NorthDakota File-',MatFileName);
% disp(dispstr)


%% Make The Ohio Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('OhioBoundaries.mat','OhioLat','OhioLon');
% Merra2OhioMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,OhioLon,OhioLat);
%         Merra2OhioMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Ohio');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2OhioMask';
% MatFileName='OhioMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Ohio File-',MatFileName);
% disp(dispstr)

%% Make The Oklahoma Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('OklahomaBoundaries.mat','OklahomaLat','OklahomaLon');
% Merra2OklahomaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,OklahomaLon,OklahomaLat);
%         Merra2OklahomaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Oklahoma');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2OklahomaMask';
% MatFileName='OklahomaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Oklahoma File-',MatFileName);
% disp(dispstr)
%% Make The Oregon Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('OregonBoundaries.mat','OregonLat','OregonLon');
% Merra2OregonMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,OregonLon,OregonLat);
%         Merra2OregonMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Oregon');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2OregonMask';
% MatFileName='OregonMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Oregon File-',MatFileName);
% disp(dispstr)

%% Make The Pennsylvania Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PennsylvaniaBoundaries.mat','PennLat','PennLon');
% Merra2PennsylvaniaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PennLon,PennLat);
%         Merra2PennsylvaniaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Pennsylvania');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PennsylvaniaMask';
% MatFileName='PennsylvaniaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Pennsylvania File-',MatFileName);
% disp(dispstr)


%% Make The RhodeIsland Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('RhodeIslandBoundaries.mat','RhodeIslandLat','RhodeIslandLon');
% Merra2RhodeIslandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,RhodeIslandLon,RhodeIslandLat);
%         Merra2RhodeIslandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-RhodeIsland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2RhodeIslandMask';
% MatFileName='RhodeIslandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote RhodeIsland File-',MatFileName);
% disp(dispstr)

%% Make The SouthCarolina Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SouthCarolinaBoundaries.mat','SouthCarolinaLat','SouthCarolinaLon');
% Merra2SouthCarolinaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SouthCarolinaLon,SouthCarolinaLat);
%         Merra2SouthCarolinaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-SouthCarolina');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SouthCarolinaMask';
% MatFileName='SouthCarolinaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote SouthCarolina File-',MatFileName);
% disp(dispstr)
%% Make The SouthDakota Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SouthDakotaBoundaries.mat','SouthDakotaLat','SouthDakotaLon');
% Merra2SouthDakotaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SouthDakotaLon,SouthDakotaLat);
%         Merra2SouthDakotaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-SouthDakota');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SouthDakotaMask';
% MatFileName='SouthDakotaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote SouthDakota File-',MatFileName);
% disp(dispstr)
%% Make The Tennessee Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TennesseeBoundaries.mat','TennesseeLat','TennesseeLon');
% Merra2TennesseeMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TennesseeLon,TennesseeLat);
%         Merra2TennesseeMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Tennessee');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TennesseeMask';
% MatFileName='TennesseeMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Tennessee File-',MatFileName);
% disp(dispstr)


%% Make The Texas Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TexasBoundaries.mat','TexasLat','TexasLon');
% Merra2TexasMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TexasLon,TexasLat);
%         Merra2TexasMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Texas');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TexasMask';
% MatFileName='TexasMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Texas File-',MatFileName);
% disp(dispstr)

%% Make The Utah Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('UtahBoundaries.mat','UtahLat','UtahLon');
% Merra2UtahMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,UtahLon,UtahLat);
%         Merra2UtahMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Utah');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2UtahMask';
% MatFileName='UtahMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Utah File-',MatFileName);
% disp(dispstr)
%% Make The Vermont Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('VermontBoundaries.mat','VermontLat','VermontLon');
% Merra2VermontMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,VermontLon,VermontLat);
%         Merra2VermontMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Vermont');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2VermontMask';
% MatFileName='VermontMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Vermont File-',MatFileName);
% disp(dispstr)


%% Make The Virginia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('VirginiaBoundaries.mat','VirginiaLat','VirginiaLon');
% Merra2VirginiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,VirginiaLon,VirginiaLat);
%         Merra2VirginiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Virginia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2VirginiaMask';
% MatFileName='VirginiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Virginia File-',MatFileName);
% disp(dispstr)


%% Make The Washington Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('WashingtonBoundaries.mat','WashingtonLat','WashingtonLon');
% Merra2WashingtonMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,WashingtonLon,WashingtonLat);
%         Merra2WashingtonMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Washington');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2WashingtonMask';
% MatFileName='WashingtonMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Washington File-',MatFileName);
% disp(dispstr)

%% Make The WestVirginia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('WestVirginiaBoundaries.mat','WestVirginiaLat','WestVirginiaLon');
% Merra2WestVirginiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,WestVirginiaLon,WestVirginiaLat);
%         Merra2WestVirginiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-WestVirginia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2WestVirginiaMask';
% MatFileName='WestVirginiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote WestVirginia File-',MatFileName);
% disp(dispstr)
%% Make The Wisconsin Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('WisconsinBoundaries.mat','WisconsinLat','WisconsinLon');
% Merra2WisconsinMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,WisconsinLon,WisconsinLat);
%         Merra2WisconsinMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Wisconsin');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2WisconsinMask';
% MatFileName='WisconsinMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Wisconsin File-',MatFileName);
% disp(dispstr)
%% Make The Wyoming Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('WyomingBoundaries.mat','WyomingLat','WyomingLon');
% Merra2WyomingMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,WyomingLon,WyomingLat);
%         Merra2WyomingMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-USA-Wyoming');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2WyomingMask';
% MatFileName='WyomingMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Wyoming File-',MatFileName);
% disp(dispstr)
%% Make The Antigua Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('AntiguaBoundaries.mat','AntiguaLat','AntiguaLon');
% Merra2AntiguaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,AntiguaLon,AntiguaLat);
%         Merra2AntiguaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Antigua');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2AntiguaMask';
% MatFileName='AntiguaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Antigua File-',MatFileName);
% disp(dispstr)
%% Make The Aruba Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('ArubaBoundaries.mat','ArubaLat','ArubaLon');
% Merra2ArubaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,ArubaLon,ArubaLat);
%         Merra2ArubaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Aruba');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2ArubaMask';
% MatFileName='ArubaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Aruba File-',MatFileName);
% disp(dispstr)
%% Make The Bahamas Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BahamasBoundaries.mat','BahamasLat','BahamasLon');
% Merra2BahamasMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BahamasLon,BahamasLat);
%         Merra2BahamasMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Bahamas');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BahamasMask';
% MatFileName='BahamasMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Bahamas File-',MatFileName);
% disp(dispstr)
%% Make The Bahrain Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BahrainBoundaries.mat','BahrainLat','BahrainLon');
% Merra2BahrainMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BahrainLon,BahrainLat);
%         Merra2BahrainMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Bahrain');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BahrainMask';
% MatFileName='BahrainMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Bahrain File-',MatFileName);
% disp(dispstr)
%% Make The Belize Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BelizeBoundaries.mat','BelizeLat','BelizeLon');
% Merra2BelizeMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BelizeLon,BelizeLat);
%         Merra2BelizeMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Belize');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BelizeMask';
% MatFileName='BelizeMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Belize File-',MatFileName);
% disp(dispstr)
%% Make The Benin Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BeninBoundaries.mat','BENLat','BENLon');
% Merra2BeninMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BENLon,BENLat);
%         Merra2BeninMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Benin');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BeninMask';
% MatFileName='BeninMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Benin File-',MatFileName);
% disp(dispstr)
%% Make The Djibouti Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('DjiboutiBoundaries.mat','DJILat','DJILon');
% Merra2DjiboutiMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,DJILon,DJILat);
%         Merra2DjiboutiMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Djibouti');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2DjiboutiMask';
% MatFileName='DjiboutiMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Djibouti File-',MatFileName);
% disp(dispstr)
%% Make The Dominica Mask-Failed Problem with data
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('DominicaBoundaries.mat','DominicaLat','DominicaLon');
% Merra2DominicaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,DominicaLon,DominicaLat);
%         Merra2DominicaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Dominica');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2DominicaMask';
% MatFileName='DominicaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Dominica File-',MatFileName);
% disp(dispstr)




%% Make The CostaRica Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CostaRicaBoundaries.mat','CostaRicaLat','CostaRicaLon');
% Merra2CostaRicaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CostaRicaLon,CostaRicaLat);
%         Merra2CostaRicaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-CostaRica');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CostaRicaMask';
% MatFileName='CostaRicaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote CostaRica File-',MatFileName);
% disp(dispstr)
%% Make The Croatia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CroatiaBoundaries.mat','CroatiaLat','CroatiaLon');
% Merra2CroatiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CroatiaLon,CroatiaLat);
%         Merra2CroatiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Croatia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CroatiaMask';
% MatFileName='CroatiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Croatia File-',MatFileName);
% disp(dispstr)
%% Make The FrenchGuiana Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('FrenchGuianaBoundaries.mat','FrenchGuianaLat','FrenchGuianaLon');
% Merra2FrenchGuianaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,FrenchGuianaLon,FrenchGuianaLat);
%         Merra2FrenchGuianaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-FrenchGuiana');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2FrenchGuianaMask';
% MatFileName='FrenchGuianaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote FrenchGuiana File-',MatFileName);
% disp(dispstr)
% %% Make The Grenada Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GrenadaBoundaries.mat','GrenadaLat','GrenadaLon');
% Merra2GrenadaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GrenadaLon,GrenadaLat);
%         Merra2GrenadaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Grenada');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GrenadaMask';
% MatFileName='GrenadaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Grenada File-',MatFileName);
% disp(dispstr)

%% Make The Guadeloupe Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GuadeloupeBoundaries.mat','GuadeloupeLat','GuadeloupeLon');
% Merra2GuadeloupeMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GuadeloupeLon,GuadeloupeLat);
%         Merra2GuadeloupeMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Guadeloupe');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GuadeloupeMask';
% MatFileName='GuadeloupeMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Guadeloupe File-',MatFileName);
% disp(dispstr)
%% Make The Israel Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('IsraelBoundaries.mat','IsraelLat','IsraelLon');
% Merra2IsraelMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,IsraelLon,IsraelLat);
%         Merra2IsraelMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Israel');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2IsraelMask';
% MatFileName='IsraelMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Israel File-',MatFileName);
% disp(dispstr)
%% Make The Kosovo Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('KosovoBoundaries.mat','KosovoLat','KosovoLon');
% Merra2KosovoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,KosovoLon,KosovoLat);
%         Merra2KosovoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Kosovo');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2KosovoMask';
% MatFileName='KosovoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Kosovo File-',MatFileName);
% disp(dispstr)
%% Make The RepGeorgia Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('RepGeorgiaBoundaries.mat','RepGeorgiaLat','RepGeorgiaLon');
% Merra2RepGeorgiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,RepGeorgiaLon,RepGeorgiaLat);
%         Merra2RepGeorgiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-RepGeorgia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2RepGeorgiaMask';
% MatFileName='RepGeorgiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote RepGeorgia File-',MatFileName);
% disp(dispstr)
%% Make The Seychelles Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SeychellesBoundaries.mat','SEYLat','SEYLon');
% Merra2SeychellesMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SEYLon,SEYLat);
%         Merra2SeychellesMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Seychelles');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SeychellesMask';
% MatFileName='SeychellesMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Seychelles File-',MatFileName);
% disp(dispstr)
%% Make The SolomonIslands Mask
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SolomonIslandsBoundaries.mat','SILat','SILon');
% Merra2SolomonIslandsMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SILon,SILat);
%         Merra2SolomonIslandsMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-SolomonIslands');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SolomonIslandsMask';
% MatFileName='SolomonIslandsMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote SolomonIslands File-',MatFileName);
% disp(dispstr)
%% Make The Togo Mask
% 

%% Make The COR Mask (Republic Of the Congo)
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CORBoundaries.mat','CORLat','CORLon');
% Merra2CORMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CORLon,CORLat);
%         Merra2CORMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Republic Of The Congo');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CORMask';
% MatFileName='CORMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Republic Of The Congo File-',MatFileName);
% disp(dispstr)
%% Make The BurkinaFaso Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BurkinaFasoBoundaries.mat','BFLat','BFLon');
% Merra2BurkinaFasoMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BFLon,BFLat);
%         Merra2BurkinaFasoMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-BurkinaFaso');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BurkinaFasoMask';
% MatFileName='BurkinaFasoMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote BurkinaFaso File-',MatFileName);
% disp(dispstr)
%% Make The Cayman Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CaymanBoundaries.mat','CaymanLat','CaymanLon');
% Merra2CaymanMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CaymanLon,CaymanLat);
%         Merra2CaymanMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Cayman');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CaymanMask';
% MatFileName='CaymanMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Cayman File-',MatFileName);
% disp(dispstr)
%% Make The GuineaBissau Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('GBBoundaries.mat','GBLat','GBLon');
% Merra2GuineaBissauMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,GBLon,GBLat);
%         Merra2GuineaBissauMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-GuineaBissau');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2GuineaBissauMask';
% MatFileName='GuineaBissauMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote GuineaBissau File-',MatFileName);
% disp(dispstr)
%% Make The Luxembourg Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('LuxembourgBoundaries.mat','LuxembourgLat','LuxembourgLon');
% Merra2LuxembourgMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,LuxembourgLon,LuxembourgLat);
%         Merra2LuxembourgMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Luxembourg');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2LuxembourgMask';
% MatFileName='LuxembourgMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Luxembourg File-',MatFileName);
% disp(dispstr)
%% Make The Maldives Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MaldivesBoundaries.mat','MaldivesLat','MaldivesLon');
% Merra2MaldivesMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MaldivesLon,MaldivesLat);
%         Merra2MaldivesMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Maldives');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MaldivesMask';
% MatFileName='MaldivesMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Maldives File-',MatFileName);
% disp(dispstr)
%% Make The Malta Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MaltaBoundaries.mat','MaltaLat','MaltaLon');
% Merra2MaltaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MaltaLon,MaltaLat);
%         Merra2MaltaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Malta');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MaltaMask';
% MatFileName='MaltaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Malta File-',MatFileName);
% disp(dispstr)
%% Make The MarshalIslands Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MarshalIslandsBoundaries.mat','MHLLat','MHLLon');
% Merra2MarshalIslandsMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MHLLon,MHLLat);
%         Merra2MarshalIslandsMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-MarshalIslands');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MarshalIslandsMask';
% MatFileName='MarshalIslandsMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote MarshalIslands File-',MatFileName);
% disp(dispstr)
%% Make The Martinique Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MartiniqueBoundaries.mat','MartiniqueLat','MartiniqueLon');
% Merra2MartiniqueMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MartiniqueLon,MartiniqueLat);
%         Merra2MartiniqueMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Martinique');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MartiniqueMask';
% MatFileName='MartiniqueMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Martinique File-',MatFileName);
% disp(dispstr)

%% Make The Micronesia Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MicronesiaBoundaries.mat','MicronesiaLat','MicronesiaLon');
% Merra2MicronesiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MicronesiaLon,MicronesiaLat);
%         Merra2MicronesiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Micronesia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MicronesiaMask';
% MatFileName='MicronesiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Micronesia File-',MatFileName);
% disp(dispstr)
%% Make The Moldova Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MoldovaBoundaries.mat','MoldovaLat','MoldovaLon');
% Merra2MoldovaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MoldovaLon,MoldovaLat);
%         Merra2MoldovaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Moldova');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MoldovaMask';
% MatFileName='MoldovaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Moldova File-',MatFileName);
% disp(dispstr)
%% Make The Montenegro Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('MontenegroBoundaries.mat','MontenegroLat','MontenegroLon');
% Merra2MontenegroMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,MontenegroLon,MontenegroLat);
%         Merra2MontenegroMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Montenegro');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2MontenegroMask';
% MatFileName='MontenegroMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Montenegro File-',MatFileName);
% disp(dispstr)
%% Make The Polynesia Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('PolynesiaBoundaries.mat','PolynesiaLat','PolynesiaLon');
% Merra2PolynesiaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,PolynesiaLon,PolynesiaLat);
%         Merra2PolynesiaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Polynesia');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2PolynesiaMask';
% MatFileName='PolynesiaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Polynesia File-',MatFileName);
% disp(dispstr)
%% Make The Samoa Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('SamoaBoundaries.mat','SamoaLat','SamoaLon');
% Merra2SamoaMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,SamoaLon,SamoaLat);
%         Merra2SamoaMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Samoa');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2SamoaMask';
% MatFileName='SamoaMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Samoa File-',MatFileName);
% disp(dispstr)
%% Make The Timor Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TimorBoundaries.mat','TimorLat','TimorLon');
% Merra2TimorMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TimorLon,TimorLat);
%         Merra2TimorMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Timor');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TimorMask';
% MatFileName='TimorMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Timor File-',MatFileName);
% disp(dispstr)
%% Make The Turks Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('TurksBoundaries.mat','TurksLat','TurksLon');
% Merra2TurksMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,TurksLon,TurksLat);
%         Merra2TurksMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Turks');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2TurksMask';
% MatFileName='TurksMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Turks File-',MatFileName);
% disp(dispstr)
%% Make The Vanuatu Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('VanuatuBoundaries.mat','VanuatuLat','VanuatuLon');
% Merra2VanuatuMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,VanuatuLon,VanuatuLat);
%         Merra2VanuatuMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Vanuatu');
%     disp(dispstr);

% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2VanuatuMask';
% MatFileName='VanuatuMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Vanuatu File-',MatFileName);
% disp(dispstr)
%% Make The VirginIslands Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('VirginIslandsBoundaries.mat','VirginIslandsLat','VirginIslandsLon');
% Merra2VirginIslandsMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,VirginIslandsLon,VirginIslandsLat);
%         Merra2VanuatuMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-VirginIslands');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2VirginIslandsMask';
% MatFileName='VirginIslandsMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote VirginIslands File-',MatFileName);
% disp(dispstr)
%% Make The BouvetIsland Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BouvetIslandBoundaries.mat','BouLat','BouLon');
% Merra2BouvetIslandMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BouLon,BouLat);
%         Merra2BouvetIslandMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-BouvetIsland');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BouvetIslandMask';
% MatFileName='BouvetIslandMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote BouvetIsland File-',MatFileName);
% disp(dispstr)
%% Make The CentralAfricanRepublic Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('CentralAfricanRepublicBoundaries.mat','CARLat','CARLon');
% Merra2CentralAfricanRepublicMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,CARLon,CARLat);
%         Merra2CentralAfricanRepublicMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-CentralAfricanRepublic');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2CentralAfricanRepublicMask';
% MatFileName='CentralAfricanRepublicMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote CentralAfricanRepublic File-',MatFileName);
% disp(dispstr)
%% Make The Denmark Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('DenmarkBoundaries.mat','DenmarkLat','DenmarkLon');
% Merra2DenmarkMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,DenmarkLon,DenmarkLat);
%         Merra2DenmarkMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-Denmark');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2DenmarkMask';
% MatFileName='DenmarkMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote Denmark File-',MatFileName);
% disp(dispstr)
%% Make The British Virgin Islands Mask 
% eval(['cd ' mappath(1:length(mappath)-1)]);
% load('BritishVirginIslandsBoundaries.mat','BVALat','BVALon');
% Merra2BritishVirginIslandsMask=zeros(576,361);
% for i=1:numlon
%     xq(1,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(2,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(3,1)=Merra2DataRasterLon(i,1)+.312;
%     xq(4,1)=Merra2DataRasterLon(i,1)-.312;
%     xq(5,1)=Merra2DataRasterLon(i,1)-.312;
%     xqq=Merra2DataRasterLon(i,1);
%     for j=1:numlat
%         yq(1,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(2,1)=Merra2DataRasterLat(j,1)-.25;
%         yq(3,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(4,1)=Merra2DataRasterLat(j,1)+.25;
%         yq(5,1)=Merra2DataRasterLat(j,1)-.25;
%         yqq=Merra2DataRasterLat(j,1);
%         [in,on]=inpolygon(xqq,yqq,BVALon,BVALat);
%         Merra2BritishVirginIslandsMask(i,j)=in;
%     end
%     dispstr=strcat('finished with lon#',num2str(i),'-BristishVirginIslands');
%     disp(dispstr);
% end
% eval(['cd ' maskpath(1:length(maskpath)-1)]);
% actionstr='save';
% varstr='Merra2BritishVirginIslandsMask';
% MatFileName='BritishVirginIslandsMask';
% qualstr='-v7.3';
% [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
% eval(cmdString)
% dispstr=strcat('Wrote BritishVirginIslands File-',MatFileName);
% disp(dispstr)
%% Make The FTS Mask 
eval(['cd ' mappath(1:length(mappath)-1)]);
load('FTSBoundaries.mat','FTSLat','FTSLon');
Merra2FTSMask=zeros(576,361);
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
        [in,on]=inpolygon(xqq,yqq,FTSLon,FTSLat);
        Merra2FTSMask(i,j)=in;
    end
    dispstr=strcat('finished with lon#',num2str(i),'-FTS');
    disp(dispstr);
end
eval(['cd ' maskpath(1:length(maskpath)-1)]);
actionstr='save';
varstr='Merra2FTSMask';
MatFileName='FTSMask';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote FTS File-',MatFileName);
disp(dispstr)
warning('on')
ab=3;