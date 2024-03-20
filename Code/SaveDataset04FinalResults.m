function SaveDataset04FinalResults()
% This function will save the end of run results for Dataset04
% Written By: Stephen Forczyk
% Created: Feb 28,2024
% Revised: Mar 1-7,2024 added data from more countries
% Classification: Unclassified Public Domain

global Merra2FileName Merra2ShortFileName Merra2Data Merra2FileNames;
global YearMonthDayStr1 YearMonthStr datestubstr;

global idebug iScale iReset;
global iTimeSlice TimeSlices;
global LonS LatS TimeS iTimeSlice framecounter;
global EFLUXICES EFLUXWTRS FRSEAICES HFLUXICES HFLUXWTRS;
global LWGNTICES LWGNTWTRS SWGNTICES SWGNTWTRS;
global PRECSNOOCNS QV10MS RAINOCNS  integrateRate;
global T10MS TAUXICES TAUXWTRS TAUYICES TAUYWTRS;
global TSKINICES TSKINWTRS U10MS V10MS;
global EFLUXICETable EFLUXICETT SILF01 SILF25 SILF50 SILF75 SILF90 SILF100 SILFNaN;
global EFLUXWTRTable EFLUXWTRTT OWLF01 OWLF25 OWLF50 OWLF75 OWLF90 OWLF100 OWLFNaN;
global SEAICETable SEAICETT SEAF01 SEAF25 SEAF50 SEAF75 SEAF90  SEAF100 SEAFNaN;
global HFLUXICETable HFLUXICETT HFICEF01 HFICEF25 HFICEF50 HFICEF75 HFICEF90 HFICEF100 HFICEFNaN;
global HFLUXWTRTable HFLUXWTRTT HFWTRF01 HFWTRF25 HFWTRF50 HFWTRF75 HFWTRF90 HFWTRF100 HFWTRFNaN;
global LWGNICESTable LWGNICESTT LWGNICE01 LWGNICE25 LWGNICE50 LWGNICE75 LWGNICE90 LWGNICE100 LWGNICENaN;
global LWGNWTRSTable LWGNWTRSTT LWGNWTR01 LWGNWTR25 LWGNWTR50 LWGNWTR75 LWGNWTR90 LWGNWTR100 LWGNWTRNaN;
global TSKINICETable TSKINICETT TSKINICE01 TSKINICE25 TSKINICE50 TSKINICE75 TSKINICE90 TSKINICE100 TSKINICENaN;
global TSKINWTRTable TSKINWTRTT TSKINWTR01 TSKINWTR25 TSKINWTR50 TSKINWTR75 TSKINWTR90 TSKINWTR100 TSKINWTRNaN;
global SWGNTICETable SWGNTICETT SWGNTICE01 SWGNTICE25 SWGNTICE50 SWGNTICE75 SWGNTICE90 SWGNTICE100 SWGNTICENaN;
global SWGNTWTRTable SWGNTWTRTT SWGNTWTR01 SWGNTWTR25 SWGNTWTR50 SWGNTWTR75 SWGNTWTR90 SWGNTWTR100 SWGNTWTRNaN;
global T10MTable T10MTT T10M01 T10M25 T10M50 T10M75 T10M90 T10M100 T10MNaN;
global TAUXICETable TAUXICETT TAUXICE01 TAUXICE25 TAUXICE50 TAUXICE75 TAUXICE90 TAUXICE100 TAUXICENaN;
global TAUXWTRTable TAUXWTRTT TAUXWTR01 TAUXWTR25 TAUXWTR50 TAUXWTR75 TAUXWTR90 TAUXWTR100 TAUXWTRNaN;
global TAUYICETable TAUYICETT TAUYICE01 TAUYICE25 TAUYICE50 TAUYICE75 TAUYICE90 TAUYICE100 TAUYICENaN;
global TAUYWTRTable TAUYWTRTT TAUYWTR01 TAUYWTR25 TAUYWTR50 TAUYWTR75 TAUYWTR90 TAUYWTR100 TAUYWTRNaN;
global RFRateTable RFRateTT RFRate01 RFRate25 RFRate50 RFRate75 RFRate90 RFRate100 RFRateNaN;
global SFRateTable SFRateTT SFRate01 SFRate25 SFRate50 SFRate75 SFRate90 SFRate100 SFRateNaN;
global RasterLats RasterLons Rpix RasterAreas RadiusCalc RasterPtLats RasterLatAreas;
global RFTotalTable RFTotalTT RFTot01 RFTot25 RFTot50 RFTot75 RFTot90 RFTot100 RFTotNaN;
global SFTotalTable SFTotalTT SFTot01 SFTot25 SFTot50 SFTot75 SFTot90 SFTot100 SFTotNaN;
global U10MTable U10MTT U10M01 U10M25 U10M50 U10M75 U10M90 U10M100 U10MNaN;
global V10MTable V10MTT V10M01 V10M25 V10M50 V10M75 V10M90 V10M100 V10MNaN;
global QV10MTable QV10MTT QV10M01 QV10M25 QV10M50 QV10M75 QV10M90 QV10M100 QV10MNaN;
global SeaIceAreaTable SeaIceAreaTT SeaIceAreaKmWorld SeaIceAreaKmNP SeaIceAreaKmSP;
global AfricaTempsTT AlgeriaTempsTT ChadTempsTT EgyptTempsTT LibyaTempsTT AngolaTempsTT;
global NigeriaTempsTT KenyaTempsTT MozambiqueTempsTT EthiopiaTempsTT MadagascarTempsTT SouthAfricaTempsTT;
global CDRTempsTT  CARTempsTT  NamibiaTempsTT SomaliaTempsTT SudanTempsTT SaudiTempsTT;
global IranTempsTT IraqTempsTT JordanTempsTT SyriaTempsTT TurkeyTempsTT PakistanTempsTT;
global AfganistanTempsTT IndiaTempsTT;
global MaskList Dataset4Masks AfricaTemps AlgeriaTemps ChadTemps LibyaTemps EgyptTemps;
global AngolaTemps NigeriaTemps EthiopiaTemps MadagascarTemps SouthAfricaTemps;
global KenyaTemps MozambiqueTemps EthiopiaTemps MadagascarTemps SouthAfricaTemps;
global CDRTemps CARTemps NamibiaTemps ;
global SeaIceConc TAirTempC Tau U10 V10 ;
global SelectedMaskData SelectedMaskIndices;
global framecounter numSelectedFiles;
global westEdge eastEdge northEdge southEdge;
global yd md dd StartDateStr;
global YearValue MonthValue DayValue HourValue MinValue SecValue frameDate;
global SubSolarLat SubSolarLon;
global iSkipDisplayFrames;
global iCityPlot maxCities Merra2Cities Merra2WorldCities;

% additional paths needed for mapping
global matpath1 mappath GOES16path;
global jpegpath savepath tablepath;
global maskpath watermaskpath;

global fid isavefiles;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global brightblue;

% Save desired variables from the end of run
%MatFileName=strcat(StartDateStr,'-','FinalResults.mat');
MatFileName=strcat('Merra2Dataset04-FinalRunResults-',StartDateStr,'.mat');
eval(['cd ' savepath(1:length(savepath)-1)]);
actionstr='save';
varstr1=' Merra2FileNames iTimeSlice TimeSlices StartDateStr';
varstr2=' SelectedMaskData SelectedMaskIndices MaskList Dataset4Masks';
varstr3=' EFLUXICETT EFLUXWTRTT SEAICETT HFLUXICETT HFLUXWTRTT';
varstr4=' LWGNICESTT LWGNWTRSTT TSKINICETT TSKINWTRTT SWGNTICETT SWGNTWTRTT';
varstr5=' T10MTT TAUXICETT TAUXWTRTT TAUYICETT TAUYWTRTT';
varstr6=' RFRateTT SFRateTT RFTotalTT SFTotalTT U10MTT V10MTT QV10MTT';
varstr7=' SeaIceAreaTT RasterLats RasterLons Rpix RasterAreas RadiusCalc RasterPtLats RasterLatAreas';
varstr8=' AfricaTemps AlgeriaTemps ChadTemps LibyaTemps EgyptTemps AngolaTemps NigeriaTemps';
varstr9=' KenyaTemps MozambiqueTemps EthiopiaTemps MadagascarTemps SouthAfricaTemps';
varstr10=' CDRTemps CARTemps NamibiaTemps AfricaTempsTT AlgeriaTempsTT ChadTempsTT EgyptTempsTT';
varstr11=' LibyaTempsTT AngolaTempsTT NigeriaTempsTT KenyaTempsTT MozambiqueTempsTT EthiopiaTempsTT';
varstr12=' MadagascarTempsTT SouthAfricaTempsTT CDRTempsTT  CARTempsTT  NamibiaTempsTT';
varstr13=' SomaliaTempsTT SudanTempsTT SaudiTempsTT IranTempsTT IraqTempsTT';
varstr14=' JordanTempsTT SyriaTempsTT TurkeyTempsTT PakistanTempsTT';
varstr15=' AfganistanTempsTT IndiaTempsTT';
varstr=strcat(varstr1,varstr2,varstr3,varstr4);
varstr=strcat(varstr,varstr5,varstr6,varstr7,varstr8,varstr9,varstr10,varstr11,varstr12,varstr13);
varstr=strcat(varstr,varstr14,varstr15);
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Final Matlab Results File-',MatFileName);
disp(dispstr)
end