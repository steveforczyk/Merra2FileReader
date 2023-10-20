function ReadDataset02(nowFile,nowpath)
% Modified: This function will read in the the Merra-2 data set 02
% This dataset is of the item M2IUNXASM_5.12.4
% Written By: Stephen Forczyk
% Created: Jun 4,2023
% Revised: Jun 5,2023 continue adding variables to decode list
% Revised: Jun 6,2023 continue adding variables to decode list
% Revised: Jun 7,2023 continue adding variables to decode list
% Revised: Jun 8,2023 continue adding variables to decode list
% Revised: Jun 9,2023 continue adding variables to decode list
% Revised: Jun 10,2023 completed adding all variables to decode list
% Revised: Jun 11,2023 end to end processing for a single variable BCDP001S
% Revised: Jun 12,2023 add some more plots and tables (ikind=2 thru 5)
% Revised: Jun 13-15,2023 added tables of (ikind=6 thru 9)
% Revised: June 16,2023 added tables thru ikind=25
% Revised: Jun 17-thru 21 adding table data
% Revised: Jun 22-26 adding more code for dust data variables
% Revised: June 27-28 adding organic carbon data
% Revised: Jun 29-Jul 4 Sea Salt variables added
% Revised: Jul 5 added additional Sea Salt  variables
% Revised: Jul 10,2023 added SUPSO4WT and other variables
% Revised: Jul 15,2023 added remaining variables
% Revised: Jul 27,2023 added Raster Arrays to establish  land borders of
% selected continents/countries-these are called masks
% Revised: Jul 29,2023 added logic to sum up Dust Emissions in 1 selected
% Revised: Jul 31,2023 created a Dust Emissions table and relocated the 
% Revised: Sept 15-20,2023 added logic to collect dust deposition total
% from the entire world and 5 countries into one table
% iSkipReportFrames flag to only plot some frames of data based in the
% interval set in the flag . eg if this flag is 4 only every 4th frame will
% be plotted
% Revised: Changed area asssigned to latitude band 89.5 to 90 deg
% Revised: Sept 22,2023 new flags to reduce output to PDF document
% Revised: Oct 17,2023 added logic to calculate SeaSalt
% Classification: Unclassified

global BandDataS MetaDataS;

global Merra2FileName Merra2Dat Merra2ShortFileName numSelectedFiles;
global Merra2DataRaster Merra2DataRasterLon Merra2DataRasterLat;
global Merra2WorkingMask MaskList  DustROICountry;
global SelectedMaskData numSelectedMasks;
global idebug iDustCalc iSeaSaltCalc;
global LatSpacing LonSpacing RasterAreas RadiusCalc;
global RasterLats RasterLons RasterAreaGrid COThighlimit;
global LatitudesS LongitudesS timeS;
global Merra2FileName Merra2FileNames MapFormFactor;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global DUEMSum DUEMSum1 DUEMSum2 DUEMSum3 DUEMSum4 DUEMSum5;
global DustEmisTT DustEmisTable;
global DUDPSum DUDPSum1 DUDPSum2 DUDPSum3 DUDPSum4 DUDPSum5;
global DustDepoTT DustDepoTable;
global BCDP001S BCDP002S BCEM001S BCEM002S;
global BCDP00110 BCDP00125 BCDP00150 BCDP00175 BCDP00190 BCDP00195 BCDP00198 BCDP001100;
global BCDP001Low BCDP001High BCDP001NaN BCDP001Values;
global BCDP001Table BCDP001TT;
global BCDP00210 BCDP00225 BCDP00250 BCDP00275 BCDP00290 BCDP00295 BCDP00298 BCDP002100;
global BCDP002Low BCDP002High BCDP002NaN BCDP002Values;
global BCDP002Table BCDP002TT;
global BCEM00110 BCEM00125 BCEM00150 BCEM00175 BCEM00190 BCEM001100;
global BCEM001Low BCEM001High BCEM001NaN BCEM001Values;
global BCEM001Table BCEM001TT;
global BCEM00210 BCEM00225 BCEM00250 BCEM00275 BCEM00290 BCEM002100;
global BCEM002Low BCEM002High BCEM002NaN BCEM002Values;
global BCEM002Table BCEM002TT;
global BCEMANS BCEMBBS BCEMBFS BCHYPHILS;
global BCEMAN10 BCEMAN25 BCEMAN50 BCEMAN75 BCEMAN90 BCEMAN100;
global BCEMANLow  BCEMANHigh BCEMANNaN BCEMANValues;
global BCEMANTable BCEMANTT;
global BCEMBB10 BCEMBB25 BCEMBB50 BCEMBB75 BCEMBB90 BCEMBB95 BCEMBB98 BCEMBB100;
global BCEMBBLow  BCEMBBHigh BCEMBBNaN BCEMBBValues;
global BCEMBBTable BCEMBBTT;
global BCEMBF10 BCEMBF25 BCEMBF50 BCEMBF75 BCEMBF90 BCEMBF100;
global BCEMBFLow  BCEMBFHigh BCEMBFNaN BCEMBFValues;
global BCEMBFTable BCEMBFTT;
global BCHYPHIL10 BCHYPHIL25 BCHYPHIL50 BCHYPHIL75 BCHYPHIL90 BCHYPHIL100;
global BCHYPHILFLow  BCHYPHILHigh BCHYPHILNaN BCHYPHILValues;
global BCHYPHILFTable BCHYPHILFTT;
global BCSD001S BCSD002S BCSV001S BCSV002S;
global BCSD00110 BCSD00125 BCSD00150 BCSD00175 BCSD00190 BCSD001100;
global BCSD001Low BCSD001High BCSD001NaN BCSD001Values;
global BCSD001Table BCSD001TT;
global BCSD00210 BCSD00225 BCSD00250 BCSD00275 BCSD00290 BCSD002100;
global BCSD002Low BCSD002High BCSD002NaN BCSD002Values;
global BCSD002Table BCSD002TT;
global BCSV00110 BCSV00125 BCSV00150 BCSV00175 BCSV00190 BCSV00195 BCSV00198 BCSV001100;
global BCSV001Table BCSV001TT;
global BCSV001Low BCSV001High BCSV001NaN BCSV001Values;
global BCSV00210 BCSV00225 BCSV00250 BCSV00275 BCSV00290 BCSV00295 BCSV00298 BCSV002100;
global BCSV002Low BCSV002High BCSV002NaN BCSV002Values;
global BCSV002Table BCSV002TT;
global BCWT001S BCWT002S DUAERIDXS;
global BCWT00110 BCWT00125 BCWT00150 BCWT00175 BCWT00190 BCWT00195 BCWT00198 BCWT001100;
global BCWT001Low BCWT001High BCWT001NaN BCWT001Values;
global BCWT001Table BCWT001TT;
global BCWT00210 BCWT00225 BCWT00250 BCWT00275 BCWT00290 BCWT00295 BCWT00298 BCWT002100;
global BCWT002Low BCWT002High BCWT002NaN BCWT002Values;
global BCWT002Table BCWT002TT DUAERIDXS;
global DUAERIDX10 DUAERIDX25 DUAERIDX50 DUAERIDX75  DUAERIDX90  DUAERIDX95 DUAERIDX98 DUAERIDX100;
global DUAERIDXLow DUAERIDXHigh DUAERIDXNaN DUAERIDXValues;
global DUAERIDXTable DUAERIDXTT; 
global DUDP001S DUDP002S DUDP003S DUDP004S DUDP005S;
global DUDP00110 DUDP00125 DUDP00150 DUDP00175 DUDP00190 DUDP001100;
global DUDP001Low DUDP001High DUDP001NaN DUDP001Values;
global DUDP001Table DUDP001TT;
global DUDP00210 DUDP00225 DUDP00250 DUDP00275 DUDP00290 DUDP002100;
global DUDP002Low DUDP002High DUDP002NaN DUDP002Values;
global DUDP002Table DUDP002TT;
global DUDP00310 DUDP00325 DUDP00350 DUDP00375 DUDP00390 DUDP003100;
global DUDP003Low DUDP003High DUDP003NaN DUDP003Values;
global DUDP003Table DUDP003TT;
global DUDP00410 DUDP00425 DUDP00450 DUDP00475 DUDP00490 DUDP004100;
global DUDP004Low DUDP004High DUDP004NaN DUDP004Values;
global DUDP004Table DUDP004TT;
global DUDP00510 DUDP00525 DUDP00550 DUDP00575 DUDP00590 DUDP005100;
global DUDP005Low DUDP005High DUDP005NaN DUDP005Values;
global DUDP005Table DUDP005TT;
global DUEM001S DUEM002S DUEM003S DUEM004S DUEM005S;
global DUEM00110 DUEM00125 DUEM00150 DUEM00175 DUEM00190 DUEM00195 DUEM00198 DUEM001100;
global DUEM001Low DUEM001High DUEM001NaN DUEM001Values;
global DUEM001Table DUEM001TT;
global DUEM00210 DUEM00225 DUEM00250 DUEM00275 DUEM00290 DUEM00295 DUEM00298 DUEM002100;
global DUEM002Low DUEM002High DUEM002NaN DUEM002Values;
global DUEM002Table DUEM002TT;
global DUEM00310 DUEM00325 DUEM00350 DUEM00375 DUEM00390 DUEM00395 DUEM00398 DUEM003100;
global DUEM003Low DUEM003High DUEM003NaN DUEM003Values;
global DUEM003Table DUEM003TT;
global DUEM00410 DUEM00425 DUEM00450 DUEM00475 DUEM00490 DUEM00495 DUEM00498 DUEM004100;
global DUEM004Low DUEM004High DUEM004NaN DUEM004Values;
global DUEM004Table DUEM004TT;
global DUEM00510 DUEM00525 DUEM00550 DUEM00575 DUEM00590 DUEM00595 DUEM00598 DUEM005100;
global DUEM005Low DUEM005High DUEM005NaN DUEM005Values;
global DUEM005Table DUEM005TT;
global DUEXTTFMS DUSCATFMS;
global DUEXT10 DUEXT25 DUEXT50 DUEXT75 DUEXT90 DUEXT100;
global DUEXTLow DUEXTHigh DUEXTNaN DUEXTValues;
global DUEXTable DUEXTT;
global DUSCAT10 DUSCAT25 DUSCAT50 DUSCAT75 DUSCAT90 DUSCAT100;
global DUSCATLow DUSCATHigh DUSCATNaN DUSCATValues;
global DUSCATTable DUSCATTT;
global DUSD001S DUSD002S DUSD003S DUSD004S DUSD005S;
global DUSD00110 DUSD00125 DUSD00150 DUSD00175 DUSD00190 DUSD00195 DUSD00198 DUSD001100;
global DUSD001Low DUSD001High DUSD001NaN DUSD001Values;
global DUSD001Table DUSD001TT;
global DUSD00210 DUSD00225 DUSD00250 DUSD00275 DUSD00290 DUSD00295 DUSD00298 DUSD002100;
global DUSD002Low DUSD002High DUSD002NaN DUSD002Values;
global DUSD002Table DUSD002TT;
global DUSD00310 DUSD00325 DUSD00350 DUSD00375 DUSD00390 DUSD00395 DUSD00398 DUSD003100;
global DUSD003Low DUSD003High DUSD003NaN DUSD003Values;
global DUSD003Table DUSD003TT;
global DUSD00410 DUSD00425 DUSD00450 DUSD00475 DUSD00490 DUSD00495 DUSD00498 DUSD004100;
global DUSD004Low DUSD004High DUSD004NaN DUSD004Values;
global DUSD004Table DUSD004TT;
global DUSD00510 DUSD00525 DUSD00550 DUSD00575 DUSD00590 DUSD00595 DUSD00598 DUSD005100;
global DUSD005Low DUSD005High DUSD005NaN DUSD005Values;
global DUSD005Table DUSD005TT;
global DUSV001S DUSV002S DUSV003S DUSV004S DUSV005S;
global DUSV00110 DUSV00125 DUSV00150 DUSV00175 DUSV00190 DUSV00195 DUSV00198 DUSV001100;
global DUSV001Low DUSV001High DUSV001NaN DUSV001Values;
global DUSV001Table DUSV001TT;
global DUSV00210 DUSV00225 DUSV00250 DUSV00275 DUSV00290 DUSV00295 DUSV00298 DUSV002100;
global DUSV002Low DUSV002High DUSV002NaN DUSV002Values;
global DUSV002Table DUSV002TT;
global DUSV00310 DUSV00325 DUSV00350 DUSV00375 DUSV00390 DUSV00395 DUSV00398 DUSV003100;
global DUSV003Low DUSV003High DUSV003NaN DUSV003Values;
global DUSV003Table DUSV003TT;
global DUSV00410 DUSV00425 DUSV00450 DUSV00475 DUSV00490 DUSV00495 DUSV00498 DUSV004100;
global DUSV004Low DUSV004High DUSV004NaN DUSV004Values;
global DUSV004Table DUSV004TT;
global DUSV00510 DUSV00525 DUSV00550 DUSV00575 DUSV00590 DUSV00595 DUSV00598 DUSV005100;
global DUSV005Low DUSV005High DUSV005NaN DUSV005Values;
global DUSV005Table DUSV005TT;
global DUWT001S DUWT002S DUWT003S DUWT004S DUWT005S;
global DUWT00110 DUWT00125 DUWT00150 DUWT00175 DUWT00190 DUWT00195 DUWT00198 DUWT001100;
global DUWT001Low DUWT001High DUWT001NaN DUWT001Values;
global DUWT001Table DUWT001TT;
global DUWT00210 DUWT00225 DUWT00250 DUWT00275 DUWT00290 DUWT00295 DUWT00298 DUWT002100;
global DUWT002Low DUWT002High DUWT002NaN DUWT002Values;
global DUWT002Table DUWT002TT;
global DUWT00310 DUWT00325 DUWT00350 DUWT00375 DUWT00390 DUWT00395 DUWT00398 DUWT003100;
global DUWT003Low DUWT003High DUWT003NaN DUWT003Values;
global DUWT003Table DUWT003TT;
global DUWT00410 DUWT00425 DUWT00450 DUWT00475 DUWT00490 DUWT00495 DUWT00498 DUWT004100;
global DUWT004Low DUWT004High DUWT004NaN DUWT004Values;
global DUWT004Table DUWT004TT;
global DUWT00510 DUWT00525 DUWT00550 DUWT00575 DUWT00590 DUWT00595 DUWT00598 DUWT005100;
global DUWT005Low DUWT005High DUWT005NaN DUWT005Values;
global DUWT005Table DUWT005TT;

global OCDP001S OCDP002S OCEM001S OCEM002S;
global OCDP00110 OCDP00125 OCDP00150 OCDP00175 OCDP00190 OCDP00195 OCDP00198 OCDP001100;
global OCDP001Low OCDP001High OCDP001NaN OCDP001Values;
global OCDP001Table OCDP001TT OCDP002Table OCDP002TT;
global OCDP00210 OCDP00225 OCDP00250 OCDP00275 OCDP00290 OCDP00295 OCDP00298 OCDP002100;
global OCDP002Low OCDP002High OCDP002NaN OCDP002Values;
global OCEM00110 OCEM00125 OCEM00150 OCEM00175 OCEM00190 OCEM00195 OCEM00198 OCEM001100;
global OCEM001Low OCEM001High OCEM001NaN OCEM001Values;
global OCEM001Table OCEM001TT;
global OCEM00210 OCEM00225 OCEM00250 OCEM00275 OCEM00290 OCEM00295 OCEM00298 OCEM002100;
global OCEM002Low OCEM002High OCEM002NaN OCEM002Values;
global OCEM002Table OCEM002TT;
global OCEMANS OCEMBBS OCEMBFS OCEMBGS OCHYPHILS;
global OCEMAN10 OCEMAN25 OCEMAN50 OCEMAN75 OCEMAN90 OCEMAN95 OCEMAN98 OCEMAN100;
global OCEMANLow OCEMANHigh OCEMANNaN OCEMANValues;
global OCEMANTable OCEMANTT;
global OCEMBB10 OCEMBB25 OCEMBB50 OCEMBB75 OCEMBB90 OCEMBB95 OCEMBB98 OCEMBB100;
global OCEMBBLow OCEMBBHigh OCEMBBNaN OCEMBBValues;
global OCEMBBTable OCEMBBTT;
global OCEMBF10 OCEMBF25 OCEMBF50 OCEMBF75 OCEMBF90 OCEMBF95 OCEMBF98 OCEMBF100;
global OCEMBFLow OCEMBFHigh OCEMBFNaN OCEMBFValues;
global OCEMBFTable OCEMBFTT;
global OCEMBG10 OCEMBG25 OCEMBG50 OCEMBG75 OCEMBG90 OCEMBG95 OCEMBG98 OCEMBG100;
global OCEMBGLow OCEMBGHigh OCEMBGNaN OCEMBGValues;
global OCEMBGTable OCEMBGTT;
global OCHYPHIL10 OCHYPHIL25 OCHYPHIL50 OCHYPHIL75 OCHYPHIL90 OCHYPHIL95 OCHYPHIL98 OCHYPHIL100;
global OCHYPHILLow OCHYPHILHigh OCHYPHILNaN OCHYPHILValues;
global OCHYPHILTable OCHYPHILTT;
global OCSD001S OCSD002S OCSV001S OCSV002S;
global OCSD00110 OCSD00125 OCSD00150 OCSD00175 OCSD00190 OCSD00195 OCSD00198 OCSD001100;
global OCSD001Low OCSD001High OCSD001NaN OCSD001Values;
global OCSD001Table OCSD001TT;
global OCSD00210 OCSD00225 OCSD00250 OCSD00275 OCSD00290 OCSD00295 OCSD00298 OCSD002100;
global OCSD002Low OCSD002High OCSD002NaN OCSD002Values;
global OCSD002Table OCSD002TT;
global OCSV00110 OCSV00125 OCSV00150 OCSV00175 OCSV00190 OCSV00195 OCSV00198 OCSV001100;
global OCSV001Low OCSV001High OCSV001NaN OCSV001Values;
global OCSV001Table OCSV001TT;
global OCSV00210 OCSV00225 OCSV00250 OCSV00275 OCSV00290 OCSV00295 OCSV00298 OCSV002100;
global OCSV002Low OCSV002High OCSV002NaN OCSV002Values;
global OCSV002Table OCSV002TT;
global OCWT001S OCWT002S;
global OCWT00110 OCWT00125 OCWT00150 OCWT00175 OCWT00190 OCWT00195 OCWT00198 OCWT001100;
global OCWT001Low OCWT001High OCWT001NaN OCWT001Values;
global OCWT001Table OCWT001TT;
global OCWT00210 OCWT00225 OCWT00250 OCWT00275 OCWT00290 OCWT00295 OCWT00298 OCWT002100;
global OCWT002Low OCWT002High OCWT002NaN OCWT002Values;
global OCWT002Table OCWT002TT;

global SO2EMANS SO2EMBBS;
global SO2MAN10 SO2MAN25 SO2MAN50 SO2MAN75 SO2MAN90 SO2MAN95 SO2MAN98 SO2MAN100;
global SO2MANLow SO2MANHigh SO2MANNaN SO2MANValues;
global SO2MANTable SO2MANTT;
global SO2MBB10 SO2MBB25 SO2MBB50 SO2MBB75 SO2MBB90 SO2MBB95 SO2MBB98 SO2MBB100;
global SO2MBBLow SO2MBBHigh SO2MBBNaN SO2MBBValues;
global SO2MBBTable SO2MBBTT;
global SO2EMVES SO2EMVNS SO4EMANS SSAERIDXS;
global SO2EMVE10 SO2EMVE25 SO2EMVE50 SO2EMVE75 SO2EMVE90 SO2EMVE95 SO2EMVE98 SO2EMVE100;
global SO2EMVELow SO2EMVEHigh SO2EMVENaN SO2EMVEValues;
global SO2EMVETable SO2EMVETT;
global SO2EMVN10 SO2EMVN25 SO2EMVN50 SO2EMVN75 SO2EMVN90 SO2EMVN95 SO2EMVN98 SO2EMVN100;
global SO2EMVNLow SO2EMVNHigh SO2EMVNNaN SO2EMVNValues;
global SO2EMVNTable SO2EMVNTT;
global SO4EMAN10 SO4EMAN25 SO4EMAN50 SO4EMAN75 SO4EMAN90 SO4EMAN95 SO4EMAN98 SO4EMAN100;
global SO4EMANLow SO4EMANHigh SO4EMANNaN SO4EMANValues;
global SO4EMANTable SO4EMANTT;
global SSAERIDX10 SSAERIDX25 SSAERIDX50 SSAERIDX75 SSAERIDX90 SSAERIDX95 SSAERIDX98 SSAERIDX100;
global SSAERIDXLow SSAERIDXHigh SSAERIDXNaN SSAERIDXValues;
global SSAERIDXTable SSAERIDXTT;

global SSDP001S SSDP002S SSDP003S SSDP004S SSDP005S;
global SSDP00110 SSDP00125 SSDP00150 SSDP00175 SSDP00190 SSDP00195 SSDP00198 SSDP001100;
global SSDP001Low SSDP001High SSDP001NaN SSDP001Values;
global SSDP001Table SSDP001TT;
global SSDP00210 SSDP00225 SSDP00250 SSDP00275 SSDP00290 SSDP00295 SSDP00298 SSDP002100;
global SSDP002Low SSDP002High SSDP002NaN SSDP002Values;
global SSDP002Table SSDP002TT;
global SSDP00310 SSDP00325 SSDP00350 SSDP00375 SSDP00390 SSDP00395 SSDP00398 SSDP003100;
global SSDP003Low SSDP003High SSDP003NaN SSDP003Values;
global SSDP003Table SSDP003TT;
global SSDP00410 SSDP00425 SSDP00450 SSDP00475 SSDP00490 SSDP00495 SSDP00498 SSDP004100;
global SSDP004Low SSDP004High SSDP004NaN SSDP004Values;
global SSDP004Table SSDP004TT;
global SSDP00510 SSDP00525 SSDP00550 SSDP00575 SSDP00590 SSDP00595 SSDP00598 SSDP005100;
global SSDP005Low SSDP005High SSDP005NaN SSDP005Values;
global SSDP005Table SSDP005TT;
global SSEM001S SSEM002S SSEM003S SSEM004S SSEM005S;
global SSEM00110 SSEM00125 SSEM00150 SSEM00175 SSEM00190 SSEM00195 SSEM00198 SSEM001100;
global SSEM001Low SSEM001High SSEM001NaN SSEM001Values;
global SSEM001Table SSEM001TT;
global SSEM00210 SSEM00225 SSEM00250 SSEM00275 SSEM00290 SSEM00295 SSEM00298 SSEM002100;
global SSEM002Low SSEM002High SSEM002NaN SSEM002Values;
global SSEM002Table SSEM002TT;
global SSEM00310 SSEM00325 SSEM00350 SSEM00375 SSEM00390 SSEM00395 SSEM00398 SSEM003100;
global SSEM003Low SSEM003High SSEM003NaN SSEM003Values;
global SSEM003Table SSEM003TT;
global SSEM00410 SSEM00425 SSEM00450 SSEM00475 SSEM00490 SSEM00495 SSEM00498 SSEM004100;
global SSEM004Low SSEM004High SSEM004NaN SSEM004Values;
global SSEM004Table SSEM004TT;
global SSEM00510 SSEM00525 SSEM00550 SSEM00575 SSEM00590 SSEM00595 SSEM00598 SSEM005100;
global SSEM005Low SSEM005High SSEM005NaN SSEM005Values;
global SSEM005Table SSEM005TT;
global SSEXTTFMS SSSCATFMS;
global SSEXTTFM10 SSEXTTFM25 SSEXTTFM50 SSEXTTFM75 SSEXTTFM90 SSEXTTFM95 SSEXTTFM98 SSEXTTFM100;
global SSEXTTFMLow SSEXTTFMHigh SSEXTTFMNaN SSEXTTFMValues;
global SSEXTTFMTable SSEXTTFMTT;
global SSSCATFM10 SSSCATFM25 SSSCATFM50 SSSCATFM75 SSSCATFM90 SSSCATFM95 SSSCATFM98 SSSCATFM100;
global SSSCATFMLow SSSCATFMHigh SSSCATFMNaN SSSCATFMValues;
global SSSCATFMTable SSSCATFMTT;

global SSSD001S SSSD002S SSSD003S SSSD004S SSSD005S;
global SSSD00110 SSSD00125 SSSD00150 SSSD00175 SSSD00190 SSSD00195 SSSD00198 SSSD001100;
global SSSD001Low SSSD001High SSSD001NaN SSSD001Values;
global SSSD001Table SSSD001TT;
global SSSD00210 SSSD00225 SSSD00250 SSSD00275 SSSD00290 SSSD00295 SSSD00298 SSSD002100;
global SSSD002Low SSSD002High SSSD002NaN SSSD002Values;
global SSSD002Table SSSD002TT;
global SSSD00310 SSSD00325 SSSD00350 SSSD00375 SSSD00390 SSSD00395 SSSD00398 SSSD003100;
global SSSD003Low SSSD003High SSSD003NaN SSSD003Values;
global SSSD003Table SSSD003TT;
global SSSD00410 SSSD00425 SSSD00450 SSSD00475 SSSD00490 SSSD00495 SSSD00498 SSSD004100;
global SSSD004Low SSSD004High SSSD004NaN SSSD004Values;
global SSSD004Table SSSD004TT;
global SSSD00510 SSSD00525 SSSD00550 SSSD00575 SSSD00590 SSSD00595 SSSD00598 SSSD005100;
global SSSD005Low SSSD005High SSSD005NaN SSSD005Values;
global SSSD005Table SSSD005TT;
global SSSV001S SSSV002S SSSV003S SSSV004S SSSV005S;
global SSSV00110 SSSV00125 SSSV00150 SSSV00175 SSSV00190 SSSV00195 SSSV00198 SSSV001100;
global SSSV001Low SSSV001High SSSV001NaN SSSV001Values;
global SSSV001Table SSSV001TT;
global SSSV00210 SSSV00225 SSSV00250 SSSV00275 SSSV00290 SSSV00295 SSSV00298 SSSV002100;
global SSSV002Low SSSV002High SSSV002NaN SSSV002Values;
global SSSV002Table SSSV002TT;
global SSSV00310 SSSV00325 SSSV00350 SSSV00375 SSSV00390 SSSV00395 SSSV00398 SSSV003100;
global SSSV003Low SSSV003High SSSV003NaN SSSV003Values;
global SSSV003Table SSSV003TT;
global SSSV00410 SSSV00425 SSSV00450 SSSV00475 SSSV00490 SSSV00495 SSSV00498 SSSV004100;
global SSSV004Low SSSV004High SSSV004NaN SSSV004Values;
global SSSV004Table SSSV004TT;
global SSSV00510 SSSV00525 SSSV00550 SSSV00575 SSSV00590 SSSV00595 SSSV00598 SSSV005100;
global SSSV005Low SSSV005High SSSV005NaN SSSV005Values;
global SSSV005Table SSSV005TT;
global SSWT001S SSWT002S SSWT003S SSWT004S SSWT005S;
global SSWT00110 SSWT00125 SSWT00150 SSWT00175 SSWT00190 SSWT00195 SSWT00198 SSWT001100;
global SSWT001Low SSWT001High SSWT001NaN SSWT001Values;
global SSWT001Table SSWT001TT;
global SSWT00210 SSWT00225 SSWT00250 SSWT00275 SSWT00290 SSWT00295 SSWT00298 SSWT002100;
global SSWT002Low SSWT002High SSWT002NaN SSWT002Values;
global SSWT002Table SSWT002TT;
global SSWT00310 SSWT00325 SSWT00350 SSWT00375 SSWT00390 SSWT00395 SSWT00398 SSWT003100;
global SSWT003Low SSWT003High SSWT003NaN SSWT003Values;
global SSWT003Table SSWT003TT;
global SSWT00410 SSWT00425 SSWT00450 SSWT00475 SSWT00490 SSWT00495 SSWT00498 SSWT004100;
global SSWT004Low SSWT004High SSWT004NaN SSWT004Values;
global SSWT004Table SSWT004TT;
global SSWT00510 SSWT00525 SSWT00550 SSWT00575 SSWT00590 SSWT00595 SSWT00598 SSWT005100;
global SSWT005Low SSWT005High SSWT005NaN SSWT005Values;
global SSWT005Table SSWT005TT
global SUDP001S SUDP002S SUDP003S SUDP004S;
global SUDP00110 SUDP00125 SUDP00150 SUDP00175 SUDP00190 SUDP00195 SUDP00198 SUDP001100;
global SUDP001Low SUDP001High SUDP001NaN SUDP001Values;
global SUDP001Table SUDP001TT;
global SUDP00210 SUDP00225 SUDP00250 SUDP00275 SUDP00290 SUDP00295 SUDP00298 SUDP002100;
global SUDP002Low SUDP002High SUDP002NaN SUDP002Values;
global SUDP002Table SUDP002TT;
global SUDP00310 SUDP00325 SUDP00350 SUDP00375 SUDP00390 SUDP00395 SUDP00398 SUDP003100;
global SUDP003Low SUDP003High SUDP003NaN SUDP003Values;
global SUDP003Table SUDP003TT;
global SUDP00410 SUDP00425 SUDP00450 SUDP00475 SUDP00490 SUDP00495 SUDP00498 SUDP004100;
global SUDP004Low SUDP004High SUDP004NaN SUDP004Values;
global SUDP004Table SUDP004TT;
global SUEM001S SUEM002S SUEM003S SUEM004S;
global SUEM00110 SUEM00125 SUEM00150 SUEM00175 SUEM00190 SUEM00195 SUEM00198 SUEM001100;
global SUEM001Low SUEM001High SUEM001NaN SUEM001Values;
global SUEM001Table SUEM001TT;
global SUEM00210 SUEM00225 SUEM00250 SUEM00275 SUEM00290 SUEM00295 SUEM00298 SUEM002100;
global SUEM002Low SUEM002High SUEM002NaN SUEM002Values;
global SUEM002Table SUEM002TT;
global SUEM00310 SUEM00325 SUEM00350 SUEM00375 SUEM00390 SUEM00395 SUEM00398 SUEM003100;
global SUEM003Low SUEM003High SUEM003NaN SUEM003Values;
global SUEM003Table SUEM003TT;
global SUEM00410 SUEM00425 SUEM00450 SUEM00475 SUEM00490 SUEM00495 SUEM00498 SUEM004100;
global SUEM004Low SUEM004High SUEM004NaN SUEM004Values;
global SUEM004Table SUEM004TT;
global SUPMSAS SUPSO2S SUPSO4AQS SUPSO4GS SUPSO4WTS;
global SUPMSA10 SUPMSA25 SUPMSA50 SUPMSA75 SUPMSA90 SUPMSA95 SUPMSA98 SUPMSA100;
global SUPMSALow SUPMSAHigh SUPMSANaN SUPMSAValues;
global SUPMSATable SUPMSATT;
global SUPSO210 SUPSO225 SUPSO250 SUPSO275 SUPSO290 SUPSO295 SUPSO298 SUPSO2100;
global SUPSO2Low SUPSO2High SUPSO2NaN SUPSO2Values;
global SUPSO2Table SUPSO2TT;
global SUPSO4AQ10 SUPSO4AQ25 SUPSO4AQ50 SUPSO4AQ75 SUPSO4AQ90 SUPSO4AQ95 SUPSO4AQ98 SUPSO4AQ100;
global SUPSO4AQLow SUPSO4AQHigh SUPSO4AQNaN SUPSO4AQValues;
global SUPSO4AQTable SUPSO4AQTT;
global SUPSO4G10 SUPSO4G25 SUPSO4G50 SUPSO4G75 SUPSO4G90 SUPSO4G95 SUPSO4G98 SUPSO4G100;
global SUPSO4GLow SUPSO4GHigh SUPSO4GNaN SUPSO4GValues;
global SUPSO4GTable SUPSO4GTT;
global SUPSO4WT10 SUPSO4WT25 SUPSO4WT50 SUPSO4WT75 SUPSO4WT90 SUPSO4WT95 SUPSO4WT98 SUPSO4WT100;
global SUPSO4WTLow SUPSO4WTHigh SUPSO4WTNaN SUPSO4WTValues;
global SUPSO4WTTable SUPSO4WTTT;
global SUSD001S SUSD002S SUSD003S SUSD004S;
global SUSV001S SUSV002S SUSV003S SUSV004S;
global SUWT001S SUWT002S SUWT003S SUWT004S;
global SUSD00110 SUSD00125 SUSD00150 SUSD00175 SUSD00190 SUSD00195 SUSD00198 SUSD001100;
global SUSD001Low SUSD001High SUSD001NaN SUSD001Values;
global SUSD001Table SUSD001TT;
global SUSD00210 SUSD00225 SUSD00250 SUSD00275 SUSD00290 SUSD00295 SUSD00298 SUSD002100;
global SUSD002Low SUSD002High SUSD002NaN SUSD002Values;
global SUSD002Table SUSD002TT;
global SUSD00310 SUSD00325 SUSD00350 SUSD00375 SUSD00390 SUSD00395 SUSD00398 SUSD003100;
global SUSD003Low SUSD003High SUSD003NaN SUSD003Values;
global SUSD003Table SUSD003TT;
global SUSD00410 SUSD00425 SUSD00450 SUSD00475 SUSD00490 SUSD00495 SUSD00498 SUSD004100;
global SUSD004Low SUSD004High SUSD004NaN SUSD004Values;
global SUSD004Table SUSD004TT;
global SUSD00510 SUSD00525 SUSD00550 SUSD00575 SUSD00590 SUSD00595 SUSD00598 SUSD005100;
global SUSD005Low SUSD005High SUSD005NaN SUSD005Values;
global SUSD005Table SUSD005TT;
global SUSV00110 SUSV00125 SUSV00150 SUSV00175 SUSV00190 SUSV00195 SUSV00198 SUSV001100;
global SUSV001Low SUSV001High SUSV001NaN SUSV001Values;
global SUSV001Table SUSV001TT;
global SUSV00210 SUSV00225 SUSV00250 SUSV00275 SUSV00290 SUSV00295 SUSV00298 SUSV002100;
global SUSV002Low SUSV002High SUSV002NaN SUSV002Values;
global SUSV002Table SUSV002TT;
global SUSV00310 SUSV00325 SUSV00350 SUSV00375 SUSV00390 SUSV00395 SUSV00398 SUSV003100;
global SUSV003Low SUSV003High SUSV003NaN SUSV003Values;
global SUSV003Table SUSV003TT;
global SUSV00410 SUSV00425 SUSV00450 SUSV00475 SUSV00490 SUSV00495 SUSV00498 SUSV004100;
global SUSV004Low SUSV004High SUSV004NaN SUSV004Values;
global SUSV004Table SUSV004TT;
global SUSV00510 SUSV00525 SUSV00550 SUSV00575 SUSV00590 SUSV00595 SUSV00598 SUSV005100;
global SUSV005Low SUSV005High SUSV005NaN SUSV005Values;
global SUSV005Table SUSV005TT;

global SUWT00110 SUWT00125 SUWT00150 SUWT00175 SUWT00190 SUWT00195 SUWT00198 SUWT001100;
global SUWT001Low SUWT001High SUWT001NaN SUWT001Values;
global SUWT001Table SUWT001TT;
global SUWT00210 SUWT00225 SUWT00250 SUWT00275 SUWT00290 SUWT00295 SUWT00298 SUWT002100;
global SUWT002Low SUWT002High SUWT002NaN SUWT002Values;
global SUWT002Table SUWT002TT;
global SUWT00310 SUWT00325 SUWT00350 SUWT00375 SUWT00390 SUWT00395 SUWT00398 SUWT003100;
global SUWT003Low SUWT003High SUWT003NaN SUWT003Values;
global SUWT003Table SUWT003TT;
global SUWT00410 SUWT00425 SUWT00450 SUWT00475 SUWT00490 SUWT00495 SUWT00498 SUWT004100;
global SUWT004Low SUWT004High SUWT004NaN SUWT004Values;
global SUWT004Table SUWT004TT;
global DustEmissionAllBins DustEmissionAllTable DustEmissionAllTT DustROICountry;
global WDustEmissionAllBins WDustEmissionAllTable WDustEmissionAllTT;
global SumDEmiss SumWEmiss;
global DustDepositionAllBins DustDepositionAllTable DustDepositionAllTT;
global WDustDepositionAllBins WDustDepositionAllTable WDustDepositionAllTT;
global SumDDepo SumWDepo;
global DustSedimentationAllBins WDustSedimentationAllBins SumDSed SumWSed;
global DustSedimentationAllTT DustSedimentationAllTable;
global WDustSedimentationAllTT WDustSedimentationAllTable;
global ROIArea ROIPts ROIFracPts numgridpts;
global SelectedSeaMaskData;
global Merra2WorkingSeaMask1 Merra2WorkingSeaMask2 Merra2WorkingSeaMask3;
global Merra2WorkingSeaMask4 Merra2WorkingSeaMask5;
global SeaSaltDryDepAllBins WSeaSaltDryDepAllBins;
global SeaSaltSumDepROI6 WSeaSaltSumDepROI6;
global SeaSaltSumDepROI7 WSeaSaltSumDepROI7;
global SeaSaltSumDepROI8 WSeaSaltSumDepROI8;
global SeaSaltSumDepROI9 WSeaSaltSumDepROI9;
global SeaSaltSumDepROI10 WSeaSaltSumDepROI10;
global SSDPSumTable SSDPSumTT;



global numtimeslice framecounter;
global YearMonthDayStr1 YearMonthDayStr2;
global ChoiceList;
global PascalsToMilliBars PascalsToPsi;


global numlat numlon Rpix latlim lonlim rasterSize;
global westEdge eastEdge southEdge northEdge;
global yd md dd hd mind secd;
global iCityPlot iSkipReportFrames;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

% additional paths needed for mapping
global matpath1 mappath maskpath;
global savepath jpegpath pdfpath logpath moviepath tablepath;
global YearMonthStr;
global fid isavefiles;
% Aerosol Use Flags
global iBlackCarbon iDust iOrganicCarbon iSeaSalt iSulfate iAllAerosols;
MerraDataCollectionTimes=cell(24,1);
fprintf(fid,'\n');
fprintf(fid,'%s\n','**************Start reading dataset 02***************');
nc_filenamesuf=nowFile;
Merra2FileName=RemoveUnderScores(nowFile);
nc_filename=strcat(nowpath,nc_filenamesuf);
ncid=netcdf.open(nc_filename,'nowrite');
openfilestr=strcat('Opening file-',Merra2FileName,'-for reading');
fprintf(fid,'%s\n',openfilestr);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
latS=struct('values',[],'long_name',[],'units',[],...
    'vmax',[],'vmin',[],'valid_range',[]);
lonS=latS;
DISPHS=struct('values',[],'standard_name',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'vmax',[],'vmin',[],...
    'valid_range',[]);
BCDP001S=struct('values',[],'long_name',[],'units',[],'FillValue',[],...
    'missing_value',[],'fmissing_value',[],'vmax',[],'vmin',[],'valid_range',[],...
    'scale_factor',[],'add_offset',[]);
BCDP002S=BCDP001S;
BCEM001S=BCDP001S;
BCEM002S=BCDP001S;
BCEMANS=BCDP001S;
BCEMBBS=BCDP001S;
BCEMBFS=BCDP001S;
BCHYPHILS=BCDP001S;
BCSD001S=BCDP001S;
BCSD002S=BCDP001S;
BCSV001S=BCDP001S;
BCSV002S=BCDP001S;
BCWT001S=BCDP001S;
BCWT002S=BCDP001S;
DUAERIDXS=BCDP001S;
DUDP001S=BCDP001S;
DUDP002S=BCDP001S;
DUDP003S=BCDP001S;
DUDP004S=BCDP001S;
DUDP005S=BCDP001S;
DUEM001S=BCDP001S;
DUEM002S=BCDP001S;
DUEM003S=BCDP001S;
DUEM004S=BCDP001S;
DUEM005S=BCDP001S;
DUEXTTFMS=BCDP001S;
DUSCATFMS=BCDP001S;
DUSD001S=BCDP001S;
DUSD002S=BCDP001S;
DUSD003S=BCDP001S;
DUSD004S=BCDP001S;
DUSD005S=BCDP001S;
DUSV001S=BCDP001S;
DUSV002S=BCDP001S;
DUSV003S=BCDP001S;
DUSV004S=BCDP001S;
DUSV005S=BCDP001S;
DUWT001S=BCDP001S;
DUWT002S=BCDP001S;
DUWT003S=BCDP001S;
DUWT004S=BCDP001S;
DUWT005S=BCDP001S;
OCDP001S=BCDP001S;
OCDP002S=BCDP001S;
OCEM001S=BCDP001S;
OCEM002S=BCDP001S;
OCEMANS=BCDP001S;
OCEMBBS=BCDP001S;
OCEMBFS=BCDP001S;
OCEMBGS=BCDP001S;
OCHYPHILS=BCDP001S;
OCSD001S=BCDP001S;
OCSD002S=BCDP001S;
OCSV001S=BCDP001S;
OCSV002S=BCDP001S;
OCWT001S=BCDP001S;
OCWT002S=BCDP001S;
SO2EMANS=BCDP001S;
SO2EMBBS=BCDP001S;
SO2EMVES=BCDP001S;
SO2EMVNS=BCDP001S;
SO4EMANS=BCDP001S;
SSAERIDXS=BCDP001S;
SSDP001S=BCDP001S;
SSDP002S=BCDP001S;
SSDP003S=BCDP001S;
SSDP004S=BCDP001S;
SSDP005S=BCDP001S;
SSEM001S=BCDP001S;
SSEM002S=BCDP001S;
SSEM003S=BCDP001S;
SSEM004S=BCDP001S;
SSEM005S=BCDP001S;
SSEXTTFMS=BCDP001S;
SSSCATFMS=BCDP001S;
SSSD001S=BCDP001S;
SSSD002S=BCDP001S;
SSSD003S=BCDP001S;
SSSD004S=BCDP001S;
SSSD005S=BCDP001S;
SSSV001S=BCDP001S;
SSSV002S=BCDP001S;
SSSV003S=BCDP001S;
SSSV004S=BCDP001S;
SSSV005S=BCDP001S;
SSWT001S=BCDP001S;
SSWT002S=BCDP001S;
SSWT003S=BCDP001S;
SSWT004S=BCDP001S;
SSWT005S=BCDP001S;
SUDP001S=BCDP001S;
SUDP002S=BCDP001S;
SUDP003S=BCDP001S;
SUDP004S=BCDP001S;
SUEM001S=BCDP001S;
SUEM002S=BCDP001S;
SUEM003S=BCDP001S;
SUEM004S=BCDP001S;
SUPMSAS=BCDP001S;
SUPSO2S=BCDP001S;
SUPSO4AQS=BCDP001S;
SUPSO4GS=BCDP001S;
SUPSO4WTS=BCDP001S;
SUSD001S=BCDP001S;
SUSD002S=BCDP001S;
SUSD003S=BCDP001S;
SUSD004S=BCDP001S;
SUSV001S=BCDP001S;
SUSV002S=BCDP001S;
SUSV003S=BCDP001S;
SUSV004S=BCDP001S;
SUWT001S=BCDP001S;
SUWT002S=BCDP001S;
SUWT003S=BCDP001S;
SUWT004S=BCDP001S;
timeS=struct('values',[],'long_name',[],'units',[],'time_increment',[],...
    'begin_date',[],'begin_time',[],'vmax',[],'vmin',[],'valid_range',[]);
% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
numvarstr=strcat('The number of variables read from the Datset1 file=',num2str(numvars));
fprintf(fid,'%s\n',numvarstr);
if(idebug==1)
    disp(' '),disp(' '),disp(' ')
    disp('________________________________________________________')
    disp('^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~')
    disp(['VARIABLES CONTAINED IN THE netCDF FILE: ' nc_filename ])
    dispstr=strcat('VARIABLES CONTAINED IN THE netCDF FILE:',Merra2FileName);
    disp(' ')
    fprintf(fid,'%s\n','________________________________________________________');
    fprintf(fid,'%s\n','^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~');
    fprintf(fid,'%s\n',dispstr);
    variablestr=strcat('Number of variables in file=',num2str(numvars));
    disp(variablestr);
    fprintf(fid,'%s\n',variablestr);
    fprintf(fid,'\n');
end
for i = 0:numvars-1
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,i);
    if(idebug==1)
        disp(['--------------------< ' varname ' >---------------------'])
        dispstr=strcat('--------------',varname,'--------------');
        fprintf(fid,'\n');
        fprintf(fid,'%s\n',dispstr);
    end
    flag = 0;
    for j = 0:numatts - 1
       a10=strcmp(varname,'BCDP001');
       a20=strcmp(varname,'BCDP002');
       a30=strcmp(varname,'BCEM001');
       a40=strcmp(varname,'BCEM002');
       a50=strcmp(varname,'BCEMAN');
       a60=strcmp(varname,'BCEMBB');
       a70=strcmp(varname,'BCEMBF');
       a80=strcmp(varname,'BCHYPHIL');
       a90=strcmp(varname,'BCSD001');
       a100=strcmp(varname,'BCSD002');
       a110=strcmp(varname,'BCSV001');
       a120=strcmp(varname,'BCSV002');
       a130=strcmp(varname,'BCWT001');
       a140=strcmp(varname,'BCWT002');
       a150=strcmp(varname,'DUAERIDX');
       a160=strcmp(varname,'DUDP001');
       a170=strcmp(varname,'DUDP002');
       a180=strcmp(varname,'DUDP003');
       a190=strcmp(varname,'DUDP004');
       a200=strcmp(varname,'DUDP005');
       a210=strcmp(varname,'DUEM001');
       a220=strcmp(varname,'DUEM002');
       a230=strcmp(varname,'DUEM003');
       a240=strcmp(varname,'DUEM004');
       a250=strcmp(varname,'DUEM005');
       a260=strcmp(varname,'DUEXTTFM');
       a270=strcmp(varname,'DUSCATFM');
       a280=strcmp(varname,'DUSD001');
       a290=strcmp(varname,'DUSD002');
       a300=strcmp(varname,'DUSD003');
       a310=strcmp(varname,'DUSD004');
       a320=strcmp(varname,'DUSD005');
       a330=strcmp(varname,'DUSV001');
       a340=strcmp(varname,'DUSV002');
       a350=strcmp(varname,'DUSV003');
       a360=strcmp(varname,'DUSV004');
       a370=strcmp(varname,'DUSV005');
       a380=strcmp(varname,'DUWT001');
       a390=strcmp(varname,'DUWT002');
       a400=strcmp(varname,'DUWT003');
       a410=strcmp(varname,'DUWT004');
       a420=strcmp(varname,'DUWT005');
       a430=strcmp(varname,'lat');
       a440=strcmp(varname,'lon');
       a450=strcmp(varname,'OCDP001');
       a460=strcmp(varname,'OCDP002');
       a470=strcmp(varname,'OCEM001');
       a480=strcmp(varname,'OCEM002');
       a490=strcmp(varname,'OCEMAN');
       a500=strcmp(varname,'OCEMBB');
       a510=strcmp(varname,'OCEMBF');
       a520=strcmp(varname,'OCEMBG');
       a530=strcmp(varname,'OCHYPHIL');
       a540=strcmp(varname,'OCSD001');
       a550=strcmp(varname,'OCSD002');
       a560=strcmp(varname,'OCSV001');
       a570=strcmp(varname,'OCSV002');
       a580=strcmp(varname,'OCWT001');
       a590=strcmp(varname,'OCWT002');
       a600=strcmp(varname,'SO2EMAN');
       a610=strcmp(varname,'SO2EMBB');
       a620=strcmp(varname,'SO2EMVE');
       a630=strcmp(varname,'SO2EMVN');
       a640=strcmp(varname,'SO4EMAN');
       a650=strcmp(varname,'SSAERIDX');
       a660=strcmp(varname,'SSDP001');
       a670=strcmp(varname,'SSDP002');
       a680=strcmp(varname,'SSDP003');
       a690=strcmp(varname,'SSDP004');
       a700=strcmp(varname,'SSDP005');
       a710=strcmp(varname,'SSEM001');
       a720=strcmp(varname,'SSEM002');
       a730=strcmp(varname,'SSEM003');
       a740=strcmp(varname,'SSEM004');
       a750=strcmp(varname,'SSEM005');
       a760=strcmp(varname,'SSEXTTFM');
       a770=strcmp(varname,'SSSCATFM');
       a810=strcmp(varname,'SSSD001');
       a820=strcmp(varname,'SSSD002');
       a830=strcmp(varname,'SSSD003');
       a840=strcmp(varname,'SSSD004');
       a850=strcmp(varname,'SSSD005');
       a860=strcmp(varname,'SSSV001');
       a870=strcmp(varname,'SSSV002');
       a880=strcmp(varname,'SSSV003');
       a890=strcmp(varname,'SSSV004');
       a900=strcmp(varname,'SSSV005');
       a910=strcmp(varname,'SSWT001');
       a920=strcmp(varname,'SSWT002');
       a930=strcmp(varname,'SSWT003');
       a940=strcmp(varname,'SSWT004');
       a950=strcmp(varname,'SSWT005');
       a960=strcmp(varname,'SUDP001');
       a970=strcmp(varname,'SUDP002');
       a980=strcmp(varname,'SUDP003');
       a990=strcmp(varname,'SUDP004');
       a1010=strcmp(varname,'SUEM001');
       a1020=strcmp(varname,'SUEM002');
       a1030=strcmp(varname,'SUEM003');
       a1040=strcmp(varname,'SUEM004');
       a1050=strcmp(varname,'SUPMSA');
       a1060=strcmp(varname,'SUPSO2');
       a1070=strcmp(varname,'SUPSO4AQ');
       a1080=strcmp(varname,'SUPSO4G');
       a1090=strcmp(varname,'SUPSO4WT');
       a1110=strcmp(varname,'SUSD001');
       a1120=strcmp(varname,'SUSD002');
       a1130=strcmp(varname,'SUSD003');
       a1140=strcmp(varname,'SUSD004');
       a1160=strcmp(varname,'SUSV001');
       a1170=strcmp(varname,'SUSV002');
       a1180=strcmp(varname,'SUSV003');
       a1190=strcmp(varname,'SUSV004');
       a1210=strcmp(varname,'SUWT001');
       a1220=strcmp(varname,'SUWT002');
       a1230=strcmp(varname,'SUWT003');
       a1240=strcmp(varname,'SUWT004');
       a1250=strcmp(varname,'time');
       a1260=strcmp(varname,'lat');
       a1270=strcmp(varname,'lon');
      
       if (a10==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCDP001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCDP001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCDP001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCDP001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCDP001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCDP001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCDP001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCDP001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCDP001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCDP001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCDP001S.valid_range=attname2;
            end

            if(framecounter==1)
                BCDP00110=zeros(numSelectedFiles,1);
                BCDP00125=zeros(numSelectedFiles,1);
                BCDP00150=zeros(numSelectedFiles,1);
                BCDP00175=zeros(numSelectedFiles,1);
                BCDP00190=zeros(numSelectedFiles,1);
                BCDP00195=zeros(numSelectedFiles,1);
                BCDP00198=zeros(numSelectedFiles,1);
                BCDP001100=zeros(numSelectedFiles,1);
                BCDP001Low=zeros(numSelectedFiles,1);
                BCDP001High=zeros(numSelectedFiles,1);
                BCDP001NaN=zeros(numSelectedFiles,1);
            end

        elseif (a20==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCDP002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCDP002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCDP002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCDP002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCDP002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCDP002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCDP002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCDP002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCDP002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCDP002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCDP002S.valid_range=attname2;
            end
            if(framecounter==1)
                BCDP00210=zeros(numSelectedFiles,1);
                BCDP00225=zeros(numSelectedFiles,1);
                BCDP00250=zeros(numSelectedFiles,1);
                BCDP00275=zeros(numSelectedFiles,1);
                BCDP00290=zeros(numSelectedFiles,1);
                BCDP00295=zeros(numSelectedFiles,1);
                BCDP00298=zeros(numSelectedFiles,1);
                BCDP002100=zeros(numSelectedFiles,1);
                BCDP002Low=zeros(numSelectedFiles,1);
                BCDP001High=zeros(numSelectedFiles,1);
                BCDP001NaN=zeros(numSelectedFiles,1);
            end


        elseif (a30==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCEM001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCEM001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCEM001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCEM001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCEM001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCEM001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCEM001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCEM001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCEM001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCEM001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCEM001S.valid_range=attname2;
            end

            if(framecounter==1)
                BCEM00110=zeros(numSelectedFiles,1);
                BCEM00125=zeros(numSelectedFiles,1);
                BCEM00150=zeros(numSelectedFiles,1);
                BCEM00175=zeros(numSelectedFiles,1);
                BCEM00190=zeros(numSelectedFiles,1);
                BCEM001100=zeros(numSelectedFiles,1);
                BCEM001Low=zeros(numSelectedFiles,1);
                BCEM001High=zeros(numSelectedFiles,1);
                BCEM001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a40==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCEM002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCEM002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCEM002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCEM002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCEM002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCEM002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCEM002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCEM002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCEM002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCEM002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCEM002S.valid_range=attname2;
            end




         elseif (a50==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCEMANS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCEMANS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCEMANS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCEMANS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCEMANS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCEMANS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCEMANS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCEMANS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCEMANS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCEMANS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCEMANS.valid_range=attname2;
            end
            if(framecounter==1)
                BCEMAN10=zeros(numSelectedFiles,1);
                BCEMAN25=zeros(numSelectedFiles,1);
                BCEMAN50=zeros(numSelectedFiles,1);
                BCEMAN75=zeros(numSelectedFiles,1);
                BCEMAN90=zeros(numSelectedFiles,1);
                BCEMAN100=zeros(numSelectedFiles,1);
                BCEMANLow=zeros(numSelectedFiles,1);
                BCEMANHigh=zeros(numSelectedFiles,1);
                BCEMANNaN=zeros(numSelectedFiles,1);
            end

          elseif (a60==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCEMBBS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCEMBBS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCEMBBS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCEMBBS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCEMBBS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCEMBBS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCEMBBS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCEMBBS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCEMBBS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCEMBBS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCEMBBS.valid_range=attname2;
            end
            if(framecounter==1)
                BCEMBB10=zeros(numSelectedFiles,1);
                BCEMBB25=zeros(numSelectedFiles,1);
                BCEMBB50=zeros(numSelectedFiles,1);
                BCEMBB75=zeros(numSelectedFiles,1);
                BCEMBB90=zeros(numSelectedFiles,1);
                BCEMBB95=zeros(numSelectedFiles,1);
                BCEMBB98=zeros(numSelectedFiles,1);
                BCEMBB100=zeros(numSelectedFiles,1);
                BCEMBBLow=zeros(numSelectedFiles,1);
                BCEMBBHigh=zeros(numSelectedFiles,1);
                BCEMBBNaN=zeros(numSelectedFiles,1);
            end

         elseif (a70==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCEMBFS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCEMBFS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCEMBFS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCEMBFS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCEMBFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCEMBFS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCEMBFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCEMBFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCEMBFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCEMBFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCEMBFS.valid_range=attname2;
            end
            if(framecounter==1)
                BCEMBF10=zeros(numSelectedFiles,1);
                BCEMBF25=zeros(numSelectedFiles,1);
                BCEMBF50=zeros(numSelectedFiles,1);
                BCEMBF75=zeros(numSelectedFiles,1);
                BCEMBF90=zeros(numSelectedFiles,1);
                BCEMBF100=zeros(numSelectedFiles,1);
                BCEMBFLow=zeros(numSelectedFiles,1);
                BCEMBFHigh=zeros(numSelectedFiles,1);
                BCEMBFNaN=zeros(numSelectedFiles,1);
            end

          elseif (a80==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCHYPHILS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCHYPHILS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCHYPHILS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCHYPHILS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCHYPHILS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCHYPHILS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCHYPHILS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCHYPHILS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCHYPHILS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCHYPHILS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCHYPHILS.valid_range=attname2;
            end
            if(framecounter==1)
                BCHYPHIL10=zeros(numSelectedFiles,1);
                BCHYPHIL25=zeros(numSelectedFiles,1);
                BCHYPHIL50=zeros(numSelectedFiles,1);
                BCHYPHIL75=zeros(numSelectedFiles,1);
                BCHYPHIL90=zeros(numSelectedFiles,1);
                BCHYPHIL100=zeros(numSelectedFiles,1);
                BCHYPHILFLow=zeros(numSelectedFiles,1);
                BCHYPHILHigh=zeros(numSelectedFiles,1);
                BCHYPHILNaN=zeros(numSelectedFiles,1);
            end

         elseif (a90==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCSD001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCSD001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCSD001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCSD001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCSD001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCSD001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCSD001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCSD001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCSD001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCSD001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCSD001S.valid_range=attname2;
            end
            if(framecounter==1)
                BCSD00110=zeros(numSelectedFiles,1);
                BCSD00125=zeros(numSelectedFiles,1);
                BCSD00150=zeros(numSelectedFiles,1);
                BCSD00175=zeros(numSelectedFiles,1);
                BCSD00190=zeros(numSelectedFiles,1);
                BCSD001100=zeros(numSelectedFiles,1);
                BCSD001Low=zeros(numSelectedFiles,1);
                BCSD001High=zeros(numSelectedFiles,1);
                BCSD001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a100==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCSD002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCSD002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCSD002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCSD002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCSD002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCSD002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCSD002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCSD002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCSD002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCSD002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCSD002S.valid_range=attname2;
            end
            if(framecounter==1)
                BCSD00210=zeros(numSelectedFiles,1);
                BCSD00225=zeros(numSelectedFiles,1);
                BCSD00250=zeros(numSelectedFiles,1);
                BCSD00275=zeros(numSelectedFiles,1);
                BCSD00290=zeros(numSelectedFiles,1);
                BCSD002100=zeros(numSelectedFiles,1);
                BCSD002Low=zeros(numSelectedFiles,1);
                BCSD002High=zeros(numSelectedFiles,1);
                BCSD002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a110==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCSV001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCSV001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCSV001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCSV001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCSV001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCSV001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCSV001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCSV001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCSV001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCSV001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCSV001S.valid_range=attname2;
            end
            if(framecounter==1)
                BCSV00110=zeros(numSelectedFiles,1);
                BCSV00125=zeros(numSelectedFiles,1);
                BCSV00150=zeros(numSelectedFiles,1);
                BCSV00175=zeros(numSelectedFiles,1);
                BCSV00190=zeros(numSelectedFiles,1);
                BCSV00195=zeros(numSelectedFiles,1);
                BCSV00198=zeros(numSelectedFiles,1);
                BCSV001100=zeros(numSelectedFiles,1);
                BCSV001Low=zeros(numSelectedFiles,1);
                BCSV001High=zeros(numSelectedFiles,1);
                BCSV001NaN=zeros(numSelectedFiles,1);
            end

          elseif (a120==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCSV002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCSV002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCSV002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCSV002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCSV002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCSV002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCSV002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCSV002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCSV002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCSV002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCSV002S.valid_range=attname2;
            end
            if(framecounter==1)
                BCSV00210=zeros(numSelectedFiles,1);
                BCSV00225=zeros(numSelectedFiles,1);
                BCSV00250=zeros(numSelectedFiles,1);
                BCSV00275=zeros(numSelectedFiles,1);
                BCSV00290=zeros(numSelectedFiles,1);
                BCSV00295=zeros(numSelectedFiles,1);
                BCSV00298=zeros(numSelectedFiles,1);
                BCSV002100=zeros(numSelectedFiles,1);
                BCSV002Low=zeros(numSelectedFiles,1);
                BCSV002High=zeros(numSelectedFiles,1);
                BCSV002NaN=zeros(numSelectedFiles,1);
            end

          elseif (a130==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCWT001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCWT001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCWT001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCWT001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCWT001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCWT001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCWT001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCWT001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCWT001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCWT001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCWT001S.valid_range=attname2;
            end
            if(framecounter==1)
                BCWT00110=zeros(numSelectedFiles,1);
                BCWT00125=zeros(numSelectedFiles,1);
                BCWT00150=zeros(numSelectedFiles,1);
                BCWT00175=zeros(numSelectedFiles,1);
                BCWT00190=zeros(numSelectedFiles,1);
                BCWT00195=zeros(numSelectedFiles,1);
                BCWT00198=zeros(numSelectedFiles,1);
                BCWT001100=zeros(numSelectedFiles,1);
                BCWT001Low=zeros(numSelectedFiles,1);
                BCWT001High=zeros(numSelectedFiles,1);
                BCWT001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a140==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                BCWT002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                BCWT002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                BCWT002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                BCWT002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                BCWT002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                BCWT002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                BCWT002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                BCWT002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                BCWT002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                BCWT002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                BCWT002S.valid_range=attname2;
            end
            if(framecounter==1)
                BCWT00210=zeros(numSelectedFiles,1);
                BCWT00225=zeros(numSelectedFiles,1);
                BCWT00250=zeros(numSelectedFiles,1);
                BCWT00275=zeros(numSelectedFiles,1);
                BCWT00290=zeros(numSelectedFiles,1);
                BCWT00295=zeros(numSelectedFiles,1);
                BCWT00298=zeros(numSelectedFiles,1);
                BCWT002100=zeros(numSelectedFiles,1);
                BCWT002Low=zeros(numSelectedFiles,1);
                BCWT002High=zeros(numSelectedFiles,1);
                BCWT002NaN=zeros(numSelectedFiles,1);
            end
           
          elseif (a150==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUAERIDXS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUAERIDXS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUAERIDXS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUAERIDXS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUAERIDXS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUAERIDXS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUAERIDXS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUAERIDXS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUAERIDXS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUAERIDXS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUAERIDXS.valid_range=attname2;
            end
            if(framecounter==1)
                DUAERIDX10=zeros(numSelectedFiles,1);
                DUAERIDX25=zeros(numSelectedFiles,1);
                DUAERIDX50=zeros(numSelectedFiles,1);
                DUAERIDX75=zeros(numSelectedFiles,1);
                DUAERIDX90=zeros(numSelectedFiles,1);
                DUAERIDX95=zeros(numSelectedFiles,1);
                DUAERIDX98=zeros(numSelectedFiles,1);
                DUAERIDX100=zeros(numSelectedFiles,1);
                DUAERIDXLow=zeros(numSelectedFiles,1);
                DUAERIDXHigh=zeros(numSelectedFiles,1);
                DUAERIDXNaN=zeros(numSelectedFiles,1);
            end

         elseif (a160==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUDP001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUDP001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUDP001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUDP001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUDP001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUDP001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUDP001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUDP001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUDP001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUDP001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUDP001S.valid_range=attname2;
            end
            if(framecounter==1)
                DUDP00110=zeros(numSelectedFiles,1);
                DUDP00125=zeros(numSelectedFiles,1);
                DUDP00150=zeros(numSelectedFiles,1);
                DUDP00175=zeros(numSelectedFiles,1);
                DUDP00190=zeros(numSelectedFiles,1);
                DUDP001100=zeros(numSelectedFiles,1);
                DUDP001Low=zeros(numSelectedFiles,1);
                DUDP001High=zeros(numSelectedFiles,1);
                DUDP001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a170==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUDP002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUDP002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUDP002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUDP002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUDP002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUDP002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUDP002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUDP002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUDP002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUDP002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUDP002S.valid_range=attname2;
            end
            if(framecounter==1)
                DUDP00210=zeros(numSelectedFiles,1);
                DUDP00225=zeros(numSelectedFiles,1);
                DUDP00250=zeros(numSelectedFiles,1);
                DUDP00275=zeros(numSelectedFiles,1);
                DUDP00290=zeros(numSelectedFiles,1);
                DUDP002100=zeros(numSelectedFiles,1);
                DUDP002Low=zeros(numSelectedFiles,1);
                DUDP002High=zeros(numSelectedFiles,1);
                DUDP002NaN=zeros(numSelectedFiles,1);
            end


          elseif (a180==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUDP003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUDP003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUDP003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUDP003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUDP003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUDP003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUDP003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUDP003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUDP003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUDP003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUDP003S.valid_range=attname2;
            end
            if(framecounter==1)
                DUDP00310=zeros(numSelectedFiles,1);
                DUDP00325=zeros(numSelectedFiles,1);
                DUDP00350=zeros(numSelectedFiles,1);
                DUDP00375=zeros(numSelectedFiles,1);
                DUDP00390=zeros(numSelectedFiles,1);
                DUDP003100=zeros(numSelectedFiles,1);
                DUDP003Low=zeros(numSelectedFiles,1);
                DUDP003High=zeros(numSelectedFiles,1);
                DUDP003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a190==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUDP004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUDP004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUDP004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUDP004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUDP004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUDP004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUDP004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUDP004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUDP004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUDP004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUDP004S.valid_range=attname2;
            end
            if(framecounter==1)
                DUDP00410=zeros(numSelectedFiles,1);
                DUDP00425=zeros(numSelectedFiles,1);
                DUDP00450=zeros(numSelectedFiles,1);
                DUDP00475=zeros(numSelectedFiles,1);
                DUDP00490=zeros(numSelectedFiles,1);
                DUDP004100=zeros(numSelectedFiles,1);
                DUDP004Low=zeros(numSelectedFiles,1);
                DUDP004High=zeros(numSelectedFiles,1);
                DUDP004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a200==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUDP005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                 DUDP005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                 DUDP005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                 DUDP005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                 DUDP005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                 DUDP005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                 DUDP005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                 DUDP005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                 DUDP005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                 DUDP005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                 DUDP005S.valid_range=attname2;
            end
            if(framecounter==1)
                DUDP00510=zeros(numSelectedFiles,1);
                DUDP00525=zeros(numSelectedFiles,1);
                DUDP00550=zeros(numSelectedFiles,1);
                DUDP00575=zeros(numSelectedFiles,1);
                DUDP00590=zeros(numSelectedFiles,1);
                DUDP005100=zeros(numSelectedFiles,1);
                DUDP005Low=zeros(numSelectedFiles,1);
                DUDP005High=zeros(numSelectedFiles,1);
                DUDP005NaN=zeros(numSelectedFiles,1);
            end

          elseif (a210==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUEM001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUEM001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUEM001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUEM001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUEM001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUEM001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUEM001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUEM001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUEM001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUEM001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUEM001S.valid_range=attname2;
            end
            if(framecounter==1)
                DUEM00110=zeros(numSelectedFiles,1);
                DUEM00125=zeros(numSelectedFiles,1);
                DUEM00150=zeros(numSelectedFiles,1);
                DUEM00175=zeros(numSelectedFiles,1);
                DUEM00190=zeros(numSelectedFiles,1);
                DUEM00195=zeros(numSelectedFiles,1);
                DUEM00198=zeros(numSelectedFiles,1);
                DUEM001100=zeros(numSelectedFiles,1);
                DUEM001Low=zeros(numSelectedFiles,1);
                DUEM001High=zeros(numSelectedFiles,1);
                DUEM001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a220==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUEM002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUEM002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUEM002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUEM002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUEM002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUEM002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUEM002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUEM002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUEM002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUEM002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUEM002S.valid_range=attname2;
            end
            if(framecounter==1)
                DUEM00210=zeros(numSelectedFiles,1);
                DUEM00225=zeros(numSelectedFiles,1);
                DUEM00250=zeros(numSelectedFiles,1);
                DUEM00275=zeros(numSelectedFiles,1);
                DUEM00290=zeros(numSelectedFiles,1);
                DUEM00295=zeros(numSelectedFiles,1);
                DUEM00298=zeros(numSelectedFiles,1);
                DUEM002100=zeros(numSelectedFiles,1);
                DUEM002Low=zeros(numSelectedFiles,1);
                DUEM002High=zeros(numSelectedFiles,1);
                DUEM002NaN=zeros(numSelectedFiles,1);
            end

          elseif (a230==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUEM003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUEM003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUEM003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUEM003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUEM003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUEM003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUEM003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUEM003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUEM003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUEM003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUEM003S.valid_range=attname2;
            end
            if(framecounter==1)
                DUEM00310=zeros(numSelectedFiles,1);
                DUEM00325=zeros(numSelectedFiles,1);
                DUEM00350=zeros(numSelectedFiles,1);
                DUEM00375=zeros(numSelectedFiles,1);
                DUEM00390=zeros(numSelectedFiles,1);
                DUEM00395=zeros(numSelectedFiles,1);
                DUEM00398=zeros(numSelectedFiles,1);
                DUEM003100=zeros(numSelectedFiles,1);
                DUEM003Low=zeros(numSelectedFiles,1);
                DUEM003High=zeros(numSelectedFiles,1);
                DUEM003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a240==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUEM004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUEM004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUEM004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUEM004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUEM004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUEM004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUEM004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUEM004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUEM004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUEM004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUEM004S.valid_range=attname2;
            end
            if(framecounter==1)
                DUEM00410=zeros(numSelectedFiles,1);
                DUEM00425=zeros(numSelectedFiles,1);
                DUEM00450=zeros(numSelectedFiles,1);
                DUEM00475=zeros(numSelectedFiles,1);
                DUEM00490=zeros(numSelectedFiles,1);
                DUEM00495=zeros(numSelectedFiles,1);
                DUEM00498=zeros(numSelectedFiles,1);
                DUEM004100=zeros(numSelectedFiles,1);
                DUEM004Low=zeros(numSelectedFiles,1);
                DUEM004High=zeros(numSelectedFiles,1);
                DUEM004NaN=zeros(numSelectedFiles,1);
            end


         elseif (a250==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUEM005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUEM005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUEM005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUEM005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUEM005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUEM005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUEM005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUEM005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUEM005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUEM005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUEM005S.valid_range=attname2;
            end
            if(framecounter==1)
                DUEM00510=zeros(numSelectedFiles,1);
                DUEM00525=zeros(numSelectedFiles,1);
                DUEM00550=zeros(numSelectedFiles,1);
                DUEM00575=zeros(numSelectedFiles,1);
                DUEM00590=zeros(numSelectedFiles,1);
                DUEM00595=zeros(numSelectedFiles,1);
                DUEM00598=zeros(numSelectedFiles,1);
                DUEM005100=zeros(numSelectedFiles,1);
                DUEM005Low=zeros(numSelectedFiles,1);
                DUEM005High=zeros(numSelectedFiles,1);
                DUEM005NaN=zeros(numSelectedFiles,1);
            end

         elseif (a260==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUEXTTFMS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUEXTTFMS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUEXTTFMS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUEXTTFMS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUEXTTFMS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUEXTTFMS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUEXTTFMS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUEXTTFMS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUEXTTFMS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUEXTTFMS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUEXTTFMS.valid_range=attname2;
            end
            if(framecounter==1)
                DUEXT10=zeros(numSelectedFiles,1);
                DUEXT25=zeros(numSelectedFiles,1);
                DUEXT50=zeros(numSelectedFiles,1);
                DUEXT75=zeros(numSelectedFiles,1);
                DUEXT90=zeros(numSelectedFiles,1);
                DUEXT100=zeros(numSelectedFiles,1);
                DUEXTLow=zeros(numSelectedFiles,1);
                DUEXTHigh=zeros(numSelectedFiles,1);
                DUEXTNaN=zeros(numSelectedFiles,1);
            end

          elseif (a270==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSCATFMS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSCATFMS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSCATFMS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSCATFMS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSCATFMS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSCATFMS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSCATFMS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSCATFMS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSCATFMS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSCATFMS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSCATFMS.valid_range=attname2;
            end
            if(framecounter==1)
                DUSCAT10=zeros(numSelectedFiles,1);
                DUSCAT25=zeros(numSelectedFiles,1);
                DUSCAT50=zeros(numSelectedFiles,1);
                DUSCAT75=zeros(numSelectedFiles,1);
                DUSCAT90=zeros(numSelectedFiles,1);
                DUSCAT100=zeros(numSelectedFiles,1);
                DUSCATLow=zeros(numSelectedFiles,1);
                DUSCATHigh=zeros(numSelectedFiles,1);
                DUSCATNaN=zeros(numSelectedFiles,1);
            end

         elseif (a280==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSD001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSD001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSD001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSD001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSD001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSD001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSD001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSD001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSD001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSD001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSD001S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSD00110=zeros(numSelectedFiles,1);
                DUSD00125=zeros(numSelectedFiles,1);
                DUSD00150=zeros(numSelectedFiles,1);
                DUSD00175=zeros(numSelectedFiles,1);
                DUSD00190=zeros(numSelectedFiles,1);
                DUSD00195=zeros(numSelectedFiles,1);
                DUSD00198=zeros(numSelectedFiles,1);
                DUSD001100=zeros(numSelectedFiles,1);
                DUSD001Low=zeros(numSelectedFiles,1);
                DUSD001High=zeros(numSelectedFiles,1);
                DUSD001NaN=zeros(numSelectedFiles,1);
            end

          elseif (a290==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSD002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSD002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSD002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSD002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSD002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSD002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSD002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSD002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSD002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSD002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSD002S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSD00210=zeros(numSelectedFiles,1);
                DUSD00225=zeros(numSelectedFiles,1);
                DUSD00250=zeros(numSelectedFiles,1);
                DUSD00275=zeros(numSelectedFiles,1);
                DUSD00290=zeros(numSelectedFiles,1);
                DUSD00295=zeros(numSelectedFiles,1);
                DUSD00298=zeros(numSelectedFiles,1);
                DUSD002100=zeros(numSelectedFiles,1);
                DUSD002Low=zeros(numSelectedFiles,1);
                DUSD002High=zeros(numSelectedFiles,1);
                DUSD002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a300==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSD003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSD003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSD003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSD003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSD003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSD003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSD003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSD003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSD003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSD003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSD003S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSD00310=zeros(numSelectedFiles,1);
                DUSD00325=zeros(numSelectedFiles,1);
                DUSD00350=zeros(numSelectedFiles,1);
                DUSD00375=zeros(numSelectedFiles,1);
                DUSD00390=zeros(numSelectedFiles,1);
                DUSD00395=zeros(numSelectedFiles,1);
                DUSD00398=zeros(numSelectedFiles,1);
                DUSD003100=zeros(numSelectedFiles,1);
                DUSD003Low=zeros(numSelectedFiles,1);
                DUSD003High=zeros(numSelectedFiles,1);
                DUSD003NaN=zeros(numSelectedFiles,1);
            end

          elseif (a310==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSD004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSD004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSD004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSD004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSD004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSD004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSD004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSD004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSD004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSD004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSD004S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSD00410=zeros(numSelectedFiles,1);
                DUSD00425=zeros(numSelectedFiles,1);
                DUSD00450=zeros(numSelectedFiles,1);
                DUSD00475=zeros(numSelectedFiles,1);
                DUSD00490=zeros(numSelectedFiles,1);
                DUSD00495=zeros(numSelectedFiles,1);
                DUSD00498=zeros(numSelectedFiles,1);
                DUSD004100=zeros(numSelectedFiles,1);
                DUSD004Low=zeros(numSelectedFiles,1);
                DUSD004High=zeros(numSelectedFiles,1);
                DUSD004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a320==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSD005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSD005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSD005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSD005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSD005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSD005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSD005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSD005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSD005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSD005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSD005S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSD00510=zeros(numSelectedFiles,1);
                DUSD00525=zeros(numSelectedFiles,1);
                DUSD00550=zeros(numSelectedFiles,1);
                DUSD00575=zeros(numSelectedFiles,1);
                DUSD00590=zeros(numSelectedFiles,1);
                DUSD00595=zeros(numSelectedFiles,1);
                DUSD00598=zeros(numSelectedFiles,1);
                DUSD005100=zeros(numSelectedFiles,1);
                DUSD005Low=zeros(numSelectedFiles,1);
                DUSD005High=zeros(numSelectedFiles,1);
                DUSD005NaN=zeros(numSelectedFiles,1);
            end

          elseif (a330==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSV001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSV001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSV001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSV001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSV001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSV001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSV001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSV001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSV001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSV001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSV001S.valid_range=attname2;
            end
           if(framecounter==1)
                DUSV00110=zeros(numSelectedFiles,1);
                DUSV00125=zeros(numSelectedFiles,1);
                DUSV00150=zeros(numSelectedFiles,1);
                DUSV00175=zeros(numSelectedFiles,1);
                DUSV00190=zeros(numSelectedFiles,1);
                DUSV00195=zeros(numSelectedFiles,1);
                DUSV00198=zeros(numSelectedFiles,1);
                DUSV001100=zeros(numSelectedFiles,1);
                DUSV001Low=zeros(numSelectedFiles,1);
                DUSV001High=zeros(numSelectedFiles,1);
                DUSV001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a340==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSV002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSV002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSV002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSV002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSV002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSV002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSV002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSV002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSV002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSV002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSV002S.valid_range=attname2;
            end
           if(framecounter==1)
                DUSV00210=zeros(numSelectedFiles,1);
                DUSV00225=zeros(numSelectedFiles,1);
                DUSV00250=zeros(numSelectedFiles,1);
                DUSV00275=zeros(numSelectedFiles,1);
                DUSV00290=zeros(numSelectedFiles,1);
                DUSV00295=zeros(numSelectedFiles,1);
                DUSV00298=zeros(numSelectedFiles,1);
                DUSV002100=zeros(numSelectedFiles,1);
                DUSV002Low=zeros(numSelectedFiles,1);
                DUSV002High=zeros(numSelectedFiles,1);
                DUSV002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a350==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSV003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSV003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSV003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSV003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSV003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSV003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSV003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSV003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSV003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSV003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSV003S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSV00310=zeros(numSelectedFiles,1);
                DUSV00325=zeros(numSelectedFiles,1);
                DUSV00350=zeros(numSelectedFiles,1);
                DUSV00375=zeros(numSelectedFiles,1);
                DUSV00390=zeros(numSelectedFiles,1);
                DUSV00395=zeros(numSelectedFiles,1);
                DUSV00398=zeros(numSelectedFiles,1);
                DUSV003100=zeros(numSelectedFiles,1);
                DUSV003Low=zeros(numSelectedFiles,1);
                DUSV003High=zeros(numSelectedFiles,1);
                DUSV003NaN=zeros(numSelectedFiles,1);
            end

          elseif (a360==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSV004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSV004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSV004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSV004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSV004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSV004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSV004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSV004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSV004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSV004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSV004S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSV00410=zeros(numSelectedFiles,1);
                DUSV00425=zeros(numSelectedFiles,1);
                DUSV00450=zeros(numSelectedFiles,1);
                DUSV00475=zeros(numSelectedFiles,1);
                DUSV00490=zeros(numSelectedFiles,1);
                DUSV00495=zeros(numSelectedFiles,1);
                DUSV00498=zeros(numSelectedFiles,1);
                DUSV004100=zeros(numSelectedFiles,1);
                DUSV004Low=zeros(numSelectedFiles,1);
                DUSV004High=zeros(numSelectedFiles,1);
                DUSV004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a370==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUSV005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUSV005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUSV005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUSV005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUSV005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUSV005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUSV005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUSV005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUSV005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUSV005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUSV005S.valid_range=attname2;
            end
            if(framecounter==1)
                DUSV00510=zeros(numSelectedFiles,1);
                DUSV00525=zeros(numSelectedFiles,1);
                DUSV00550=zeros(numSelectedFiles,1);
                DUSV00575=zeros(numSelectedFiles,1);
                DUSV00590=zeros(numSelectedFiles,1);
                DUSV00595=zeros(numSelectedFiles,1);
                DUSV00598=zeros(numSelectedFiles,1);
                DUSV005100=zeros(numSelectedFiles,1);
                DUSV005Low=zeros(numSelectedFiles,1);
                DUSV005High=zeros(numSelectedFiles,1);
                DUSV005NaN=zeros(numSelectedFiles,1);
            end

         elseif (a380==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUWT001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUWT001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUWT001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUWT001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUWT001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUWT001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUWT001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUWT001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUWT001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUWT001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUWT001S.valid_range=attname2;
            end
            if(framecounter==1)
                DUWT00110=zeros(numSelectedFiles,1);
                DUWT00125=zeros(numSelectedFiles,1);
                DUWT00150=zeros(numSelectedFiles,1);
                DUWT00175=zeros(numSelectedFiles,1);
                DUWT00190=zeros(numSelectedFiles,1);
                DUWT00195=zeros(numSelectedFiles,1);
                DUWT00198=zeros(numSelectedFiles,1);
                DUWT001100=zeros(numSelectedFiles,1);
                DUWT001Low=zeros(numSelectedFiles,1);
                DUWT001High=zeros(numSelectedFiles,1);
                DUWT001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a390==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUWT002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUWT002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUWT002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUWT002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUWT002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUWT002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUWT002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUWT002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUWT002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUWT002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUWT002S.valid_range=attname2;
            end
            if(framecounter==1)
                DUWT00210=zeros(numSelectedFiles,1);
                DUWT00225=zeros(numSelectedFiles,1);
                DUWT00250=zeros(numSelectedFiles,1);
                DUWT00275=zeros(numSelectedFiles,1);
                DUWT00290=zeros(numSelectedFiles,1);
                DUWT00295=zeros(numSelectedFiles,1);
                DUWT00298=zeros(numSelectedFiles,1);
                DUWT002100=zeros(numSelectedFiles,1);
                DUWT002Low=zeros(numSelectedFiles,1);
                DUWT002High=zeros(numSelectedFiles,1);
                DUWT002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a400==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUWT003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUWT003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUWT003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUWT003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUWT003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUWT003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUWT003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUWT003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUWT003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUWT003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUWT003S.valid_range=attname2;
            end
            if(framecounter==1)
                DUWT00310=zeros(numSelectedFiles,1);
                DUWT00325=zeros(numSelectedFiles,1);
                DUWT00350=zeros(numSelectedFiles,1);
                DUWT00375=zeros(numSelectedFiles,1);
                DUWT00390=zeros(numSelectedFiles,1);
                DUWT00395=zeros(numSelectedFiles,1);
                DUWT00398=zeros(numSelectedFiles,1);
                DUWT003100=zeros(numSelectedFiles,1);
                DUWT003Low=zeros(numSelectedFiles,1);
                DUWT003High=zeros(numSelectedFiles,1);
                DUWT003NaN=zeros(numSelectedFiles,1);
            end

          elseif (a410==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUWT004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUWT004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUWT004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUWT004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUWT004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUWT004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUWT004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUWT004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUWT004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUWT004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUWT004S.valid_range=attname2;
            end
            if(framecounter==1)
                DUWT00410=zeros(numSelectedFiles,1);
                DUWT00425=zeros(numSelectedFiles,1);
                DUWT00450=zeros(numSelectedFiles,1);
                DUWT00475=zeros(numSelectedFiles,1);
                DUWT00490=zeros(numSelectedFiles,1);
                DUWT00495=zeros(numSelectedFiles,1);
                DUWT00498=zeros(numSelectedFiles,1);
                DUWT004100=zeros(numSelectedFiles,1);
                DUWT004Low=zeros(numSelectedFiles,1);
                DUWT004High=zeros(numSelectedFiles,1);
                DUWT004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a420==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                DUWT005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                DUWT005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                DUWT005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                DUWT005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                DUWT005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                DUWT005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                DUWT005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                DUWT005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                DUWT005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                DUWT005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                DUWT005S.valid_range=attname2;
            end
            if(framecounter==1)
                DUWT00510=zeros(numSelectedFiles,1);
                DUWT00525=zeros(numSelectedFiles,1);
                DUWT00550=zeros(numSelectedFiles,1);
                DUWT00575=zeros(numSelectedFiles,1);
                DUWT00590=zeros(numSelectedFiles,1);
                DUWT00595=zeros(numSelectedFiles,1);
                DUWT00598=zeros(numSelectedFiles,1);
                DUWT005100=zeros(numSelectedFiles,1);
                DUWT005Low=zeros(numSelectedFiles,1);
                DUWT005High=zeros(numSelectedFiles,1);
                DUWT005NaN=zeros(numSelectedFiles,1);
            end

         elseif (a430==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                latS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                latS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                latS.long_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                latS.units=attname2;
            end

            a1=strcmp(attname1,'vmax');
            if(a1==1)
                latS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                latS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                latS.valid_range=attname2;
            end

          elseif (a440==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                lonS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                lonS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                lonS.long_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                lonS.units=attname2;
            end

            a1=strcmp(attname1,'vmax');
            if(a1==1)
                lonS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                lonS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                lonS.valid_range=attname2;
            end

         elseif (a450==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCDP001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCDP001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCDP001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCDP001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCDP001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCDP001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCDP001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCDP001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCDP001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCDP001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCDP001S.valid_range=attname2;
            end
            if(framecounter==1)
                OCDP00110=zeros(numSelectedFiles,1);
                OCDP00125=zeros(numSelectedFiles,1);
                OCDP00150=zeros(numSelectedFiles,1);
                OCDP00175=zeros(numSelectedFiles,1);
                OCDP00190=zeros(numSelectedFiles,1);
                OCDP00195=zeros(numSelectedFiles,1);
                OCDP00198=zeros(numSelectedFiles,1);
                OCDP001100=zeros(numSelectedFiles,1);
                OCDP001Low=zeros(numSelectedFiles,1);
                OCDP001High=zeros(numSelectedFiles,1);
                OCDP001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a460==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCDP002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCDP002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCDP002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCDP002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCDP002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCDP002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCDP002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCDP002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCDP002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCDP002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCDP002S.valid_range=attname2;
            end
            if(framecounter==1)
                OCDP00210=zeros(numSelectedFiles,1);
                OCDP00225=zeros(numSelectedFiles,1);
                OCDP00250=zeros(numSelectedFiles,1);
                OCDP00275=zeros(numSelectedFiles,1);
                OCDP00290=zeros(numSelectedFiles,1);
                OCDP00295=zeros(numSelectedFiles,1);
                OCDP00298=zeros(numSelectedFiles,1);
                OCDP002100=zeros(numSelectedFiles,1);
                OCDP002Low=zeros(numSelectedFiles,1);
                OCDP002High=zeros(numSelectedFiles,1);
                OCDP002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a470==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCEM001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCEM001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCEM001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCEM001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCEM001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCEM001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCEM001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCEM001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCEM001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCEM001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCEM001S.valid_range=attname2;
            end
            if(framecounter==1)
                OCEM00110=zeros(numSelectedFiles,1);
                OCEM00125=zeros(numSelectedFiles,1);
                OCEM00150=zeros(numSelectedFiles,1);
                OCEM00175=zeros(numSelectedFiles,1);
                OCEM00190=zeros(numSelectedFiles,1);
                OCEM001100=zeros(numSelectedFiles,1);
                OCEM001Low=zeros(numSelectedFiles,1);
                OCEM001High=zeros(numSelectedFiles,1);
                OCEM001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a480==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCEM002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCEM002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCEM002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCEM002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCEM002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCEM002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCEM002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCEM002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCEM002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCEM002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCEM002S.valid_range=attname2;
            end
            if(framecounter==1)
                OCEM00210=zeros(numSelectedFiles,1);
                OCEM00225=zeros(numSelectedFiles,1);
                OCEM00250=zeros(numSelectedFiles,1);
                OCEM00275=zeros(numSelectedFiles,1);
                OCEM00290=zeros(numSelectedFiles,1);
                OCEM002100=zeros(numSelectedFiles,1);
                OCEM002Low=zeros(numSelectedFiles,1);
                OCEM002High=zeros(numSelectedFiles,1);
                OCEM002NaN=zeros(numSelectedFiles,1);
            end

          elseif (a490==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCEMANS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCEMANS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCEMANS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCEMANS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCEMANS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCEMANS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCEMANS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCEMANS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCEMANS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCEMANS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCEMANS.valid_range=attname2;
            end
            if(framecounter==1)
                OCEMAN10=zeros(numSelectedFiles,1);
                OCEMAN25=zeros(numSelectedFiles,1);
                OCEMAN50=zeros(numSelectedFiles,1);
                OCEMAN75=zeros(numSelectedFiles,1);
                OCEMAN90=zeros(numSelectedFiles,1);
                OCEMAN100=zeros(numSelectedFiles,1);
                OCEMANLow=zeros(numSelectedFiles,1);
                OCEMANHigh=zeros(numSelectedFiles,1);
                OCEMANNaN=zeros(numSelectedFiles,1);
            end

         elseif (a500==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCEMBBS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCEMBBS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCEMBBS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCEMBBS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCEMBBS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCEMBBS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCEMBBS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCEMBBS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCEMBBS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCEMBBS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCEMBBS.valid_range=attname2;
            end
            if(framecounter==1)
                OCEMBB10=zeros(numSelectedFiles,1);
                OCEMBB25=zeros(numSelectedFiles,1);
                OCEMBB50=zeros(numSelectedFiles,1);
                OCEMBB75=zeros(numSelectedFiles,1);
                OCEMBB90=zeros(numSelectedFiles,1);
                OCEMBB100=zeros(numSelectedFiles,1);
                OCEMBBLow=zeros(numSelectedFiles,1);
                OCEMBBHigh=zeros(numSelectedFiles,1);
                OCEMBBNaN=zeros(numSelectedFiles,1);
            end


          elseif (a510==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCEMBFS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCEMBFS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCEMBFS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCEMBFS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCEMBFS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCEMBFS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCEMBFS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCEMBFS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCEMBFS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCEMBFS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCEMBFS.valid_range=attname2;
            end
            if(framecounter==1)
                OCEMBF10=zeros(numSelectedFiles,1);
                OCEMBF25=zeros(numSelectedFiles,1);
                OCEMBF50=zeros(numSelectedFiles,1);
                OCEMBF75=zeros(numSelectedFiles,1);
                OCEMBF90=zeros(numSelectedFiles,1);
                OCEMBF95=zeros(numSelectedFiles,1);
                OCEMBF98=zeros(numSelectedFiles,1);
                OCEMBF100=zeros(numSelectedFiles,1);
                OCEMBFLow=zeros(numSelectedFiles,1);
                OCEMBFHigh=zeros(numSelectedFiles,1);
                OCEMBFNaN=zeros(numSelectedFiles,1);
            end

         elseif (a520==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCEMBGS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCEMBGS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCEMBGS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCEMBGS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCEMBGS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCEMBGS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCEMBGS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCEMBGS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCEMBGS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCEMBGS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCEMBGS.valid_range=attname2;
            end
            if(framecounter==1)
                OCEMBG10=zeros(numSelectedFiles,1);
                OCEMBG25=zeros(numSelectedFiles,1);
                OCEMBG50=zeros(numSelectedFiles,1);
                OCEMBG75=zeros(numSelectedFiles,1);
                OCEMBG90=zeros(numSelectedFiles,1);
                OCEMBG100=zeros(numSelectedFiles,1);
                OCEMBGLow=zeros(numSelectedFiles,1);
                OCEMBGHigh=zeros(numSelectedFiles,1);
                OCEMBGNaN=zeros(numSelectedFiles,1);
            end

          elseif (a530==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCHYPHILS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCHYPHILS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCHYPHILS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCHYPHILS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCHYPHILS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCHYPHILS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCHYPHILS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCHYPHILS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCHYPHILS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCHYPHILS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCHYPHILS.valid_range=attname2;
            end

            if(framecounter==1)
                OCHYPHIL10=zeros(numSelectedFiles,1);
                OCHYPHIL25=zeros(numSelectedFiles,1);
                OCHYPHIL50=zeros(numSelectedFiles,1);
                OCHYPHIL75=zeros(numSelectedFiles,1);
                OCHYPHIL90=zeros(numSelectedFiles,1);
                OCHYPHIL95=zeros(numSelectedFiles,1);
                OCHYPHIL98=zeros(numSelectedFiles,1);
                OCHYPHIL100=zeros(numSelectedFiles,1);
                OCHYPHILLow=zeros(numSelectedFiles,1);
                OCHYPHILHigh=zeros(numSelectedFiles,1);
                OCHYPHILNaN=zeros(numSelectedFiles,1);
            end

         elseif (a540==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCSD001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCSD001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCSD001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCSD001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCSD001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCSD001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCSD001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCSD001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCSD001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCSD001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCSD001S.valid_range=attname2;
            end
            if(framecounter==1)
                OCSD00110=zeros(numSelectedFiles,1);
                OCSD00125=zeros(numSelectedFiles,1);
                OCSD00150=zeros(numSelectedFiles,1);
                OCSD00175=zeros(numSelectedFiles,1);
                OCSD00190=zeros(numSelectedFiles,1);
                OCSD00195=zeros(numSelectedFiles,1);
                OCSD00198=zeros(numSelectedFiles,1);
                OCSD001100=zeros(numSelectedFiles,1);
                OCSD001Low=zeros(numSelectedFiles,1);
                OCSD001High=zeros(numSelectedFiles,1);
                OCSD001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a550==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCSD002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCSD002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCSD002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCSD002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCSD002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCSD002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCSD002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCSD002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCSD002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCSD002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCSD002S.valid_range=attname2;
            end
            if(framecounter==1)
                OCSD00210=zeros(numSelectedFiles,1);
                OCSD00225=zeros(numSelectedFiles,1);
                OCSD00250=zeros(numSelectedFiles,1);
                OCSD00275=zeros(numSelectedFiles,1);
                OCSD00290=zeros(numSelectedFiles,1);
                OCSD00295=zeros(numSelectedFiles,1);
                OCSD00298=zeros(numSelectedFiles,1);
                OCSD002100=zeros(numSelectedFiles,1);
                OCSD002Low=zeros(numSelectedFiles,1);
                OCSD002High=zeros(numSelectedFiles,1);
                OCSD002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a560==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCSV001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCSV001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCSV001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCSV001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCSV001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCSV001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCSV001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCSV001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCSV001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCSV001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCSV001S.valid_range=attname2;
            end

         elseif (a570==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCSV002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCSV002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCSV002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCSV002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCSV002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCSV002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCSV002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCSV002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCSV002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCSV002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCSV002S.valid_range=attname2;
            end

          elseif (a580==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCWT001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCWT001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCWT001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCWT001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCWT001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCWT001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCWT001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCWT001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCWT001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCWT001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCWT001S.valid_range=attname2;
            end
            if(framecounter==1)
                OCWT00110=zeros(numSelectedFiles,1);
                OCWT00125=zeros(numSelectedFiles,1);
                OCWT00150=zeros(numSelectedFiles,1);
                OCWT00175=zeros(numSelectedFiles,1);
                OCWT00190=zeros(numSelectedFiles,1);
                OCWT00195=zeros(numSelectedFiles,1);
                OCWT00198=zeros(numSelectedFiles,1);
                OCWT001100=zeros(numSelectedFiles,1);
                OCWT001Low=zeros(numSelectedFiles,1);
                OCWT001High=zeros(numSelectedFiles,1);
                OCWT001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a590==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                OCWT002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                OCWT002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                OCWT002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                OCWT002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                OCWT002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                OCWT002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                OCWT002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                OCWT002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                OCWT002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                OCWT002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                OCWT002S.valid_range=attname2;
            end
            if(framecounter==1)
                OCWT00210=zeros(numSelectedFiles,1);
                OCWT00225=zeros(numSelectedFiles,1);
                OCWT00250=zeros(numSelectedFiles,1);
                OCWT00275=zeros(numSelectedFiles,1);
                OCWT00290=zeros(numSelectedFiles,1);
                OCWT00295=zeros(numSelectedFiles,1);
                OCWT00298=zeros(numSelectedFiles,1);
                OCWT002100=zeros(numSelectedFiles,1);
                OCWT002Low=zeros(numSelectedFiles,1);
                OCWT002High=zeros(numSelectedFiles,1);
                OCWT002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a600==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SO2EMANS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SO2EMANS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SO2EMANS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SO2EMANS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SO2EMANS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SO2EMANS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SO2EMANS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SO2EMANS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SO2EMANS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SO2EMANS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SO2EMANS.valid_range=attname2;
            end
            if(framecounter==1)
                SO2MAN10=zeros(numSelectedFiles,1);
                SO2MAN25=zeros(numSelectedFiles,1);
                SO2MAN50=zeros(numSelectedFiles,1);
                SO2MAN75=zeros(numSelectedFiles,1);
                SO2MAN90=zeros(numSelectedFiles,1);
                SO2MAN95=zeros(numSelectedFiles,1);
                SO2MAN98=zeros(numSelectedFiles,1);
                SO2MAN100=zeros(numSelectedFiles,1);
                SO2MANLow=zeros(numSelectedFiles,1);
                SO2MANHigh=zeros(numSelectedFiles,1);
                SO2MANNaN=zeros(numSelectedFiles,1);
            end

         elseif (a610==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SO2EMBBS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SO2EMBBS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SO2EMBBS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SO2EMBBS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SO2EMBBS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SO2EMBBS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SO2EMBBS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SO2EMBBS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SO2EMBBS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SO2EMBBS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SO2EMBBS.valid_range=attname2;
            end
            if(framecounter==1)
                SO2MBB10=zeros(numSelectedFiles,1);
                SO2MBB25=zeros(numSelectedFiles,1);
                SO2MBB50=zeros(numSelectedFiles,1);
                SO2MBB75=zeros(numSelectedFiles,1);
                SO2MBB90=zeros(numSelectedFiles,1);
                SO2MBB95=zeros(numSelectedFiles,1);
                SO2MBB98=zeros(numSelectedFiles,1);
                SO2MBB100=zeros(numSelectedFiles,1);
                SO2MBBLow=zeros(numSelectedFiles,1);
                SO2MBBHigh=zeros(numSelectedFiles,1);
                SO2MBBNaN=zeros(numSelectedFiles,1);
            end

         elseif (a620==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SO2EMVES.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SO2EMVES.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SO2EMVES.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SO2EMVES.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SO2EMVES.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SO2EMVES.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SO2EMVES.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SO2EMVES.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SO2EMVES.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SO2EMVES.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SO2EMVES.valid_range=attname2;
            end
            if(framecounter==1)
                SO2EMVE10=zeros(numSelectedFiles,1);
                SO2EMVE25=zeros(numSelectedFiles,1);
                SO2EMVE50=zeros(numSelectedFiles,1);
                SO2EMVE75=zeros(numSelectedFiles,1);
                SO2EMVE90=zeros(numSelectedFiles,1);
                SO2EMVE95=zeros(numSelectedFiles,1);
                SO2EMVE98=zeros(numSelectedFiles,1);
                SO2EMVE100=zeros(numSelectedFiles,1);
                SO2EMVELow=zeros(numSelectedFiles,1);
                SO2EMVEHigh=zeros(numSelectedFiles,1);
                SO2EMVENaN=zeros(numSelectedFiles,1);
            end

         elseif (a630==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SO2EMVNS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SO2EMVNS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SO2EMVNS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SO2EMVNS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SO2EMVNS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SO2EMVNS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SO2EMVNS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SO2EMVNS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SO2EMVNS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SO2EMVNS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SO2EMVNS.valid_range=attname2;
            end
            if(framecounter==1)
                SO2EMVN10=zeros(numSelectedFiles,1);
                SO2EMVN25=zeros(numSelectedFiles,1);
                SO2EMVN50=zeros(numSelectedFiles,1);
                SO2EMVN75=zeros(numSelectedFiles,1);
                SO2EMVN90=zeros(numSelectedFiles,1);
                SO2EMVN95=zeros(numSelectedFiles,1);
                SO2EMVN98=zeros(numSelectedFiles,1);
                SO2EMVN100=zeros(numSelectedFiles,1);
                SO2EMVNLow=zeros(numSelectedFiles,1);
                SO2EMVNHigh=zeros(numSelectedFiles,1);
                SO2EMVNNaN=zeros(numSelectedFiles,1);
            end

         elseif (a640==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SO4EMANS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SO4EMANS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SO4EMANS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SO4EMANS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SO4EMANS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SO4EMANS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SO4EMANS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SO4EMANS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SO4EMANS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SO4EMANS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SO4EMANS.valid_range=attname2;
            end
            if(framecounter==1)
                SO4EMAN10=zeros(numSelectedFiles,1);
                SO4EMAN25=zeros(numSelectedFiles,1);
                SO4EMAN50=zeros(numSelectedFiles,1);
                SO4EMAN75=zeros(numSelectedFiles,1);
                SO4EMAN90=zeros(numSelectedFiles,1);
                SO4EMAN95=zeros(numSelectedFiles,1);
                SO4EMAN98=zeros(numSelectedFiles,1);
                SO4EMAN100=zeros(numSelectedFiles,1);
                SO4EMANLow=zeros(numSelectedFiles,1);
                SO4EMANHigh=zeros(numSelectedFiles,1);
                SO4EMANNaN=zeros(numSelectedFiles,1);
            end

         elseif (a650==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSAERIDXS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSAERIDXS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSAERIDXS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSAERIDXS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSAERIDXS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSAERIDXS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSAERIDXS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSAERIDXS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSAERIDXS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSAERIDXS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSAERIDXS.valid_range=attname2;
            end
            if(framecounter==1)
                SSAERIDX10=zeros(numSelectedFiles,1);
                SSAERIDX25=zeros(numSelectedFiles,1);
                SSAERIDX50=zeros(numSelectedFiles,1);
                SSAERIDX75=zeros(numSelectedFiles,1);
                SSAERIDX90=zeros(numSelectedFiles,1);
                SSAERIDX95=zeros(numSelectedFiles,1);
                SSAERIDX98=zeros(numSelectedFiles,1);
                SSAERIDX100=zeros(numSelectedFiles,1);
                SSAERIDXLow=zeros(numSelectedFiles,1);
                SSAERIDXHigh=zeros(numSelectedFiles,1);
                SSAERIDXNaN=zeros(numSelectedFiles,1);
            end

          elseif (a660==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSDP001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSDP001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSDP001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSDP001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSDP001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSDP001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSDP001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSDP001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSDP001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSDP001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSDP001S.valid_range=attname2;
            end
            if(framecounter==1)
                SSDP00110=zeros(numSelectedFiles,1);
                SSDP00125=zeros(numSelectedFiles,1);
                SSDP00150=zeros(numSelectedFiles,1);
                SSDP00175=zeros(numSelectedFiles,1);
                SSDP00190=zeros(numSelectedFiles,1);
                SSDP00195=zeros(numSelectedFiles,1);
                SSDP00198=zeros(numSelectedFiles,1);
                SSDP001100=zeros(numSelectedFiles,1);
                SSDP001Low=zeros(numSelectedFiles,1);
                SSDP001High=zeros(numSelectedFiles,1);
                SSDP001NaN=zeros(numSelectedFiles,1);
            end

          elseif (a670==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSDP002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSDP002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSDP002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSDP002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSDP002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSDP002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSDP002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSDP002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSDP002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSDP002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSDP002S.valid_range=attname2;
            end
            if(framecounter==1)
                SSDP00210=zeros(numSelectedFiles,1);
                SSDP00225=zeros(numSelectedFiles,1);
                SSDP00250=zeros(numSelectedFiles,1);
                SSDP00275=zeros(numSelectedFiles,1);
                SSDP00290=zeros(numSelectedFiles,1);
                SSDP00295=zeros(numSelectedFiles,1);
                SSDP00298=zeros(numSelectedFiles,1);
                SSDP002100=zeros(numSelectedFiles,1);
                SSDP002Low=zeros(numSelectedFiles,1);
                SSDP002High=zeros(numSelectedFiles,1);
                SSDP002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a680==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSDP003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSDP003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSDP003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSDP003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSDP003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSDP003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSDP003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSDP003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSDP003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSDP003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSDP003S.valid_range=attname2;
            end
            if(framecounter==1)
                SSDP00310=zeros(numSelectedFiles,1);
                SSDP00325=zeros(numSelectedFiles,1);
                SSDP00350=zeros(numSelectedFiles,1);
                SSDP00375=zeros(numSelectedFiles,1);
                SSDP00390=zeros(numSelectedFiles,1);
                SSDP00395=zeros(numSelectedFiles,1);
                SSDP00398=zeros(numSelectedFiles,1);
                SSDP003100=zeros(numSelectedFiles,1);
                SSDP003Low=zeros(numSelectedFiles,1);
                SSDP003High=zeros(numSelectedFiles,1);
                SSDP003NaN=zeros(numSelectedFiles,1);
            end

          elseif (a690==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSDP004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSDP004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSDP004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSDP004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSDP004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSDP004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSDP004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSDP004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSDP004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSDP004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSDP004S.valid_range=attname2;
            end
            if(framecounter==1)
                SSDP00410=zeros(numSelectedFiles,1);
                SSDP00425=zeros(numSelectedFiles,1);
                SSDP00450=zeros(numSelectedFiles,1);
                SSDP00475=zeros(numSelectedFiles,1);
                SSDP00490=zeros(numSelectedFiles,1);
                SSDP00495=zeros(numSelectedFiles,1);
                SSDP00498=zeros(numSelectedFiles,1);
                SSDP004100=zeros(numSelectedFiles,1);
                SSDP004Low=zeros(numSelectedFiles,1);
                SSDP004High=zeros(numSelectedFiles,1);
                SSDP004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a700==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSDP005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSDP005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSDP005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSDP005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSDP005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSDP005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSDP005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSDP005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSDP005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSDP005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSDP005S.valid_range=attname2;
            end
            if(framecounter==1)
                SSDP00510=zeros(numSelectedFiles,1);
                SSDP00525=zeros(numSelectedFiles,1);
                SSDP00550=zeros(numSelectedFiles,1);
                SSDP00575=zeros(numSelectedFiles,1);
                SSDP00590=zeros(numSelectedFiles,1);
                SSDP00595=zeros(numSelectedFiles,1);
                SSDP00598=zeros(numSelectedFiles,1);
                SSDP005100=zeros(numSelectedFiles,1);
                SSDP005Low=zeros(numSelectedFiles,1);
                SSDP005High=zeros(numSelectedFiles,1);
                SSDP005NaN=zeros(numSelectedFiles,1);
            end

         elseif (a710==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSEM001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSEM001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSEM001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSEM001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSEM001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSEM001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSEM001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSEM001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSEM001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSEM001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSEM001S.valid_range=attname2;
            end
            if(framecounter==1)
                SSEM00110=zeros(numSelectedFiles,1);
                SSEM00125=zeros(numSelectedFiles,1);
                SSEM00150=zeros(numSelectedFiles,1);
                SSEM00175=zeros(numSelectedFiles,1);
                SSEM00190=zeros(numSelectedFiles,1);
                SSEM00195=zeros(numSelectedFiles,1);
                SSEM00198=zeros(numSelectedFiles,1);
                SSEM001100=zeros(numSelectedFiles,1);
                SSEM001Low=zeros(numSelectedFiles,1);
                SSEM001High=zeros(numSelectedFiles,1);
                SSEM001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a720==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSEM002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSEM002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSEM002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSEM002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSEM002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSEM002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSEM002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSEM002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSEM002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSEM002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSEM002S.valid_range=attname2;
            end
            if(framecounter==1)
                SSEM00210=zeros(numSelectedFiles,1);
                SSEM00225=zeros(numSelectedFiles,1);
                SSEM00250=zeros(numSelectedFiles,1);
                SSEM00275=zeros(numSelectedFiles,1);
                SSEM00290=zeros(numSelectedFiles,1);
                SSEM00295=zeros(numSelectedFiles,1);
                SSEM00298=zeros(numSelectedFiles,1);
                SSEM002100=zeros(numSelectedFiles,1);
                SSEM002Low=zeros(numSelectedFiles,1);
                SSEM002High=zeros(numSelectedFiles,1);
                SSEM002NaN=zeros(numSelectedFiles,1);
            end

          elseif (a730==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSEM003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSEM003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSEM003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSEM003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSEM003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSEM003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSEM003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSEM003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSEM003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSEM003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSEM003S.valid_range=attname2;
            end
            if(framecounter==1)
                SSEM00310=zeros(numSelectedFiles,1);
                SSEM00325=zeros(numSelectedFiles,1);
                SSEM00350=zeros(numSelectedFiles,1);
                SSEM00375=zeros(numSelectedFiles,1);
                SSEM00390=zeros(numSelectedFiles,1);
                SSEM00395=zeros(numSelectedFiles,1);
                SSEM00398=zeros(numSelectedFiles,1);
                SSEM003100=zeros(numSelectedFiles,1);
                SSEM003Low=zeros(numSelectedFiles,1);
                SSEM003High=zeros(numSelectedFiles,1);
                SSEM003NaN=zeros(numSelectedFiles,1);
            end

          elseif (a740==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSEM004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSEM004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSEM004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSEM004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSEM004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSEM004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSEM004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSEM004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSEM004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSEM004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSEM004S.valid_range=attname2;
            end
            if(framecounter==1)
                SSEM00410=zeros(numSelectedFiles,1);
                SSEM00425=zeros(numSelectedFiles,1);
                SSEM00450=zeros(numSelectedFiles,1);
                SSEM00475=zeros(numSelectedFiles,1);
                SSEM00490=zeros(numSelectedFiles,1);
                SSEM00495=zeros(numSelectedFiles,1);
                SSEM00498=zeros(numSelectedFiles,1);
                SSEM004100=zeros(numSelectedFiles,1);
                SSEM004Low=zeros(numSelectedFiles,1);
                SSEM004High=zeros(numSelectedFiles,1);
                SSEM004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a750==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSEM005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSEM005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSEM005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSEM005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSEM005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSEM005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSEM005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSEM005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSEM005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSEM005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSEM005S.valid_range=attname2;
            end
            if(framecounter==1)
                SSEM00510=zeros(numSelectedFiles,1);
                SSEM00525=zeros(numSelectedFiles,1);
                SSEM00550=zeros(numSelectedFiles,1);
                SSEM00575=zeros(numSelectedFiles,1);
                SSEM00590=zeros(numSelectedFiles,1);
                SSEM00595=zeros(numSelectedFiles,1);
                SSEM00598=zeros(numSelectedFiles,1);
                SSEM005100=zeros(numSelectedFiles,1);
                SSEM005Low=zeros(numSelectedFiles,1);
                SSEM005High=zeros(numSelectedFiles,1);
                SSEM005NaN=zeros(numSelectedFiles,1);
            end

         elseif (a760==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSEXTTFMS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSEXTTFMS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSEXTTFMS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSEXTTFMS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSEXTTFMS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSEXTTFMS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSEXTTFMS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSEXTTFMS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSEXTTFMS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSEXTTFMS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSEXTTFMS.valid_range=attname2;
            end
           if(framecounter==1)
                SSEXTTFM10=zeros(numSelectedFiles,1);
                SSEXTTFM25=zeros(numSelectedFiles,1);
                SSEXTTFM50=zeros(numSelectedFiles,1);
                SSEXTTFM75=zeros(numSelectedFiles,1);
                SSEXTTFM90=zeros(numSelectedFiles,1);
                SSEXTTFM95=zeros(numSelectedFiles,1);
                SSEXTTFM98=zeros(numSelectedFiles,1);
                SSEXTTFM100=zeros(numSelectedFiles,1);
                SSEXTTFMLow=zeros(numSelectedFiles,1);
                SSEXTTFMHigh=zeros(numSelectedFiles,1);
                SSEXTTFMNaN=zeros(numSelectedFiles,1);
            end

          elseif (a770==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSCATFMS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSCATFMS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSCATFMS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSCATFMS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSCATFMS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSCATFMS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSCATFMS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSCATFMS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSCATFMS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSCATFMS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSCATFMS.valid_range=attname2;
            end
            if(framecounter==1)
                SSSCATFM10=zeros(numSelectedFiles,1);
                SSSCATFM25=zeros(numSelectedFiles,1);
                SSSCATFM50=zeros(numSelectedFiles,1);
                SSSCATFM75=zeros(numSelectedFiles,1);
                SSSCATFM90=zeros(numSelectedFiles,1);
                SSSCATFM95=zeros(numSelectedFiles,1);
                SSSCATFM98=zeros(numSelectedFiles,1);
                SSSCATFM100=zeros(numSelectedFiles,1);
                SSSCATFMLow=zeros(numSelectedFiles,1);
                SSSCATFMHigh=zeros(numSelectedFiles,1);
                SSSCATFMNaN=zeros(numSelectedFiles,1);
            end

          elseif (a810==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSD001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSD001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSD001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSD001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSD001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSD001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSD001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSD001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSD001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSD001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSD001S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSD00110=zeros(numSelectedFiles,1);
                SSSD00125=zeros(numSelectedFiles,1);
                SSSD00150=zeros(numSelectedFiles,1);
                SSSD00175=zeros(numSelectedFiles,1);
                SSSD00190=zeros(numSelectedFiles,1);
                SSSD00195=zeros(numSelectedFiles,1);
                SSSD00198=zeros(numSelectedFiles,1);
                SSSD001100=zeros(numSelectedFiles,1);
                SSSD001Low=zeros(numSelectedFiles,1);
                SSSD001High=zeros(numSelectedFiles,1);
                SSSD001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a820==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSD002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSD002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSD002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSD002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSD002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSD002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSD002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSD002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSD002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSD002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSD002S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSD00210=zeros(numSelectedFiles,1);
                SSSD00225=zeros(numSelectedFiles,1);
                SSSD00250=zeros(numSelectedFiles,1);
                SSSD00275=zeros(numSelectedFiles,1);
                SSSD00290=zeros(numSelectedFiles,1);
                SSSD00295=zeros(numSelectedFiles,1);
                SSSD00298=zeros(numSelectedFiles,1);
                SSSD002100=zeros(numSelectedFiles,1);
                SSSD002Low=zeros(numSelectedFiles,1);
                SSSD002High=zeros(numSelectedFiles,1);
                SSSD002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a830==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSD003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSD003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSD003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSD003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSD003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSD003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSD003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSD003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSD003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSD003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSD003S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSD00310=zeros(numSelectedFiles,1);
                SSSD00325=zeros(numSelectedFiles,1);
                SSSD00350=zeros(numSelectedFiles,1);
                SSSD00375=zeros(numSelectedFiles,1);
                SSSD00390=zeros(numSelectedFiles,1);
                SSSD00395=zeros(numSelectedFiles,1);
                SSSD00398=zeros(numSelectedFiles,1);
                SSSD003100=zeros(numSelectedFiles,1);
                SSSD003Low=zeros(numSelectedFiles,1);
                SSSD003High=zeros(numSelectedFiles,1);
                SSSD003NaN=zeros(numSelectedFiles,1);
            end

          elseif (a840==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSD004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSD004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSD004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSD004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSD004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSD004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSD004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSD004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSD004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSD004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSD004S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSD00410=zeros(numSelectedFiles,1);
                SSSD00425=zeros(numSelectedFiles,1);
                SSSD00450=zeros(numSelectedFiles,1);
                SSSD00475=zeros(numSelectedFiles,1);
                SSSD00490=zeros(numSelectedFiles,1);
                SSSD00495=zeros(numSelectedFiles,1);
                SSSD00498=zeros(numSelectedFiles,1);
                SSSD004100=zeros(numSelectedFiles,1);
                SSSD004Low=zeros(numSelectedFiles,1);
                SSSD004High=zeros(numSelectedFiles,1);
                SSSD004NaN=zeros(numSelectedFiles,1);
            end

         elseif (a850==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSD005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSD005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSD005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSD005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSD005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSD005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSD005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSD005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSD005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSD005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSD005S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSD00510=zeros(numSelectedFiles,1);
                SSSD00525=zeros(numSelectedFiles,1);
                SSSD00550=zeros(numSelectedFiles,1);
                SSSD00575=zeros(numSelectedFiles,1);
                SSSD00590=zeros(numSelectedFiles,1);
                SSSD00595=zeros(numSelectedFiles,1);
                SSSD00598=zeros(numSelectedFiles,1);
                SSSD005100=zeros(numSelectedFiles,1);
                SSSD005Low=zeros(numSelectedFiles,1);
                SSSD005High=zeros(numSelectedFiles,1);
                SSSD005NaN=zeros(numSelectedFiles,1);
            end

          elseif (a860==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSV001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSV001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSV001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSV001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSV001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSV001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSV001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSV001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSV001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSV001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSV001S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSV00110=zeros(numSelectedFiles,1);
                SSSV00125=zeros(numSelectedFiles,1);
                SSSV00150=zeros(numSelectedFiles,1);
                SSSV00175=zeros(numSelectedFiles,1);
                SSSV00190=zeros(numSelectedFiles,1);
                SSSV00195=zeros(numSelectedFiles,1);
                SSSV00198=zeros(numSelectedFiles,1);
                SSSV001100=zeros(numSelectedFiles,1);
                SSSV001Low=zeros(numSelectedFiles,1);
                SSSV001High=zeros(numSelectedFiles,1);
                SSSV001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a870==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSV002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSV002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSV002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSV002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSV002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSV002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSV002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSV002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSV002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSV002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSV002S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSV00210=zeros(numSelectedFiles,1);
                SSSV00225=zeros(numSelectedFiles,1);
                SSSV00250=zeros(numSelectedFiles,1);
                SSSV00275=zeros(numSelectedFiles,1);
                SSSV00290=zeros(numSelectedFiles,1);
                SSSV00295=zeros(numSelectedFiles,1);
                SSSV00298=zeros(numSelectedFiles,1);
                SSSV002100=zeros(numSelectedFiles,1);
                SSSV002Low=zeros(numSelectedFiles,1);
                SSSV002High=zeros(numSelectedFiles,1);
                SSSV002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a880==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSV003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSV003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSV003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSV003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSV003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSV003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSV003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSV003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSV003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSV003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSV003S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSV00310=zeros(numSelectedFiles,1);
                SSSV00325=zeros(numSelectedFiles,1);
                SSSV00350=zeros(numSelectedFiles,1);
                SSSV00375=zeros(numSelectedFiles,1);
                SSSV00390=zeros(numSelectedFiles,1);
                SSSV00395=zeros(numSelectedFiles,1);
                SSSV00398=zeros(numSelectedFiles,1);
                SSSV003100=zeros(numSelectedFiles,1);
                SSSV003Low=zeros(numSelectedFiles,1);
                SSSV003High=zeros(numSelectedFiles,1);
                SSSV003NaN=zeros(numSelectedFiles,1);
            end

          elseif (a890==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSV004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSV004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSV004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSV004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSV004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSV004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSV004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSV004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSV004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSV004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSV004S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSV00410=zeros(numSelectedFiles,1);
                SSSV00425=zeros(numSelectedFiles,1);
                SSSV00450=zeros(numSelectedFiles,1);
                SSSV00475=zeros(numSelectedFiles,1);
                SSSV00490=zeros(numSelectedFiles,1);
                SSSV00495=zeros(numSelectedFiles,1);
                SSSV00498=zeros(numSelectedFiles,1);
                SSSV004100=zeros(numSelectedFiles,1);
                SSSV004Low=zeros(numSelectedFiles,1);
                SSSV004High=zeros(numSelectedFiles,1);
                SSSV004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a900==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSSV005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSSV005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSSV005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSSV005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSSV005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSSV005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSSV005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSSV005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSSV005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSSV005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSSV005S.valid_range=attname2;
            end
            if(framecounter==1)
                SSSV00510=zeros(numSelectedFiles,1);
                SSSV00525=zeros(numSelectedFiles,1);
                SSSV00550=zeros(numSelectedFiles,1);
                SSSV00575=zeros(numSelectedFiles,1);
                SSSV00590=zeros(numSelectedFiles,1);
                SSSV00595=zeros(numSelectedFiles,1);
                SSSV00598=zeros(numSelectedFiles,1);
                SSSV005100=zeros(numSelectedFiles,1);
                SSSV005Low=zeros(numSelectedFiles,1);
                SSSV005High=zeros(numSelectedFiles,1);
                SSSV005NaN=zeros(numSelectedFiles,1);
            end

         elseif (a910==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSWT001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSWT001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSWT001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSWT001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSWT001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSWT001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSWT001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSWT001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSWT001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSWT001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSWT001S.valid_range=attname2;
            end
            if(framecounter==1)
                SSWT00110=zeros(numSelectedFiles,1);
                SSWT00125=zeros(numSelectedFiles,1);
                SSWT00150=zeros(numSelectedFiles,1);
                SSWT00175=zeros(numSelectedFiles,1);
                SSWT00190=zeros(numSelectedFiles,1);
                SSWT00195=zeros(numSelectedFiles,1);
                SSWT00198=zeros(numSelectedFiles,1);
                SSWT001100=zeros(numSelectedFiles,1);
                SSWT001Low=zeros(numSelectedFiles,1);
                SSWT001High=zeros(numSelectedFiles,1);
                SSWT001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a920==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSWT002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSWT002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSWT002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSWT002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSWT002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSWT002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSWT002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSWT002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSWT002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSWT002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSWT002S.valid_range=attname2;
            end
            if(framecounter==1)
                SSWT00210=zeros(numSelectedFiles,1);
                SSWT00225=zeros(numSelectedFiles,1);
                SSWT00250=zeros(numSelectedFiles,1);
                SSWT00275=zeros(numSelectedFiles,1);
                SSWT00290=zeros(numSelectedFiles,1);
                SSWT00295=zeros(numSelectedFiles,1);
                SSWT00298=zeros(numSelectedFiles,1);
                SSWT002100=zeros(numSelectedFiles,1);
                SSWT002Low=zeros(numSelectedFiles,1);
                SSWT002High=zeros(numSelectedFiles,1);
                SSWT002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a930==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSWT003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSWT003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSWT003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSWT003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSWT003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSWT003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSWT003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSWT003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSWT003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSWT003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSWT003S.valid_range=attname2;
            end
            if(framecounter==1)
                SSWT00310=zeros(numSelectedFiles,1);
                SSWT00325=zeros(numSelectedFiles,1);
                SSWT00350=zeros(numSelectedFiles,1);
                SSWT00375=zeros(numSelectedFiles,1);
                SSWT00390=zeros(numSelectedFiles,1);
                SSWT00395=zeros(numSelectedFiles,1);
                SSWT00398=zeros(numSelectedFiles,1);
                SSWT003100=zeros(numSelectedFiles,1);
                SSWT003Low=zeros(numSelectedFiles,1);
                SSWT003High=zeros(numSelectedFiles,1);
                SSWT003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a940==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSWT004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSWT004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSWT004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSWT004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSWT004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSWT004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSWT004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSWT004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSWT004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSWT004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSWT004S.valid_range=attname2;
            end
            if(framecounter==1)
                SSWT00410=zeros(numSelectedFiles,1);
                SSWT00425=zeros(numSelectedFiles,1);
                SSWT00450=zeros(numSelectedFiles,1);
                SSWT00475=zeros(numSelectedFiles,1);
                SSWT00490=zeros(numSelectedFiles,1);
                SSWT00495=zeros(numSelectedFiles,1);
                SSWT00498=zeros(numSelectedFiles,1);
                SSWT004100=zeros(numSelectedFiles,1);
                SSWT004Low=zeros(numSelectedFiles,1);
                SSWT004High=zeros(numSelectedFiles,1);
                SSWT004NaN=zeros(numSelectedFiles,1);
            end

         elseif (a950==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SSWT005S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SSWT005S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SSWT005S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SSWT005S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SSWT005S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SSWT005S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SSWT005S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SSWT005S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SSWT005S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SSWT005S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SSWT005S.valid_range=attname2;
            end
            if(framecounter==1)
                SSWT00510=zeros(numSelectedFiles,1);
                SSWT00525=zeros(numSelectedFiles,1);
                SSWT00550=zeros(numSelectedFiles,1);
                SSWT00575=zeros(numSelectedFiles,1);
                SSWT00590=zeros(numSelectedFiles,1);
                SSWT00595=zeros(numSelectedFiles,1);
                SSWT00598=zeros(numSelectedFiles,1);
                SSWT005100=zeros(numSelectedFiles,1);
                SSWT005Low=zeros(numSelectedFiles,1);
                SSWT005High=zeros(numSelectedFiles,1);
                SSWT005NaN=zeros(numSelectedFiles,1);
            end

         elseif (a960==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUDP001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUDP001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUDP001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUDP001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUDP001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUDP001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUDP001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUDP001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUDP001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUDP001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUDP001S.valid_range=attname2;
            end
            if(framecounter==1)
                SUDP00110=zeros(numSelectedFiles,1);
                SUDP00125=zeros(numSelectedFiles,1);
                SUDP00150=zeros(numSelectedFiles,1);
                SUDP00175=zeros(numSelectedFiles,1);
                SUDP00190=zeros(numSelectedFiles,1);
                SUDP00195=zeros(numSelectedFiles,1);
                SUDP00198=zeros(numSelectedFiles,1);
                SUDP001100=zeros(numSelectedFiles,1);
                SUDP001Low=zeros(numSelectedFiles,1);
                SUDP001High=zeros(numSelectedFiles,1);
                SUDP001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a970==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUDP002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUDP002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUDP002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUDP002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUDP002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUDP002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUDP002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUDP002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUDP002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUDP002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUDP002S.valid_range=attname2;
            end
            if(framecounter==1)
                SUDP00210=zeros(numSelectedFiles,1);
                SUDP00225=zeros(numSelectedFiles,1);
                SUDP00250=zeros(numSelectedFiles,1);
                SUDP00275=zeros(numSelectedFiles,1);
                SUDP00290=zeros(numSelectedFiles,1);
                SUDP00295=zeros(numSelectedFiles,1);
                SUDP00298=zeros(numSelectedFiles,1);
                SUDP002100=zeros(numSelectedFiles,1);
                SUDP002Low=zeros(numSelectedFiles,1);
                SUDP002High=zeros(numSelectedFiles,1);
                SUDP002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a980==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUDP003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUDP003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUDP003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUDP003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUDP003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUDP003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUDP003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUDP003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUDP003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUDP003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUDP003S.valid_range=attname2;
            end
            if(framecounter==1)
                SUDP00310=zeros(numSelectedFiles,1);
                SUDP00325=zeros(numSelectedFiles,1);
                SUDP00350=zeros(numSelectedFiles,1);
                SUDP00375=zeros(numSelectedFiles,1);
                SUDP00390=zeros(numSelectedFiles,1);
                SUDP00395=zeros(numSelectedFiles,1);
                SUDP00398=zeros(numSelectedFiles,1);
                SUDP003100=zeros(numSelectedFiles,1);
                SUDP003Low=zeros(numSelectedFiles,1);
                SUDP003High=zeros(numSelectedFiles,1);
                SUDP003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a990==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUDP004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUDP004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUDP004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUDP004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUDP004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUDP004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUDP004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUDP004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUDP004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUDP004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUDP004S.valid_range=attname2;
            end
            if(framecounter==1)
                SUDP00410=zeros(numSelectedFiles,1);
                SUDP00425=zeros(numSelectedFiles,1);
                SUDP00450=zeros(numSelectedFiles,1);
                SUDP00475=zeros(numSelectedFiles,1);
                SUDP00490=zeros(numSelectedFiles,1);
                SUDP00495=zeros(numSelectedFiles,1);
                SUDP00498=zeros(numSelectedFiles,1);
                SUDP004100=zeros(numSelectedFiles,1);
                SUDP004Low=zeros(numSelectedFiles,1);
                SUDP004High=zeros(numSelectedFiles,1);
                SUDP004NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1010==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUEM001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUEM001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUEM001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUEM001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUEM001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUEM001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUEM001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUEM001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUEM001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUEM001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUEM001S.valid_range=attname2;
            end
            if(framecounter==1)
                SUEM00110=zeros(numSelectedFiles,1);
                SUEM00125=zeros(numSelectedFiles,1);
                SUEM00150=zeros(numSelectedFiles,1);
                SUEM00175=zeros(numSelectedFiles,1);
                SUEM00190=zeros(numSelectedFiles,1);
                SUEM00195=zeros(numSelectedFiles,1);
                SUEM00198=zeros(numSelectedFiles,1);
                SUEM001100=zeros(numSelectedFiles,1);
                SUEM001Low=zeros(numSelectedFiles,1);
                SUEM001High=zeros(numSelectedFiles,1);
                SUEM001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1020==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUEM002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUEM002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUEM002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUEM002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUEM002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUEM002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUEM002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUEM002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUEM002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUEM002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUEM002S.valid_range=attname2;
            end
            if(framecounter==1)
                SUEM00210=zeros(numSelectedFiles,1);
                SUEM00225=zeros(numSelectedFiles,1);
                SUEM00250=zeros(numSelectedFiles,1);
                SUEM00275=zeros(numSelectedFiles,1);
                SUEM00290=zeros(numSelectedFiles,1);
                SUEM00295=zeros(numSelectedFiles,1);
                SUEM00298=zeros(numSelectedFiles,1);
                SUEM002100=zeros(numSelectedFiles,1);
                SUEM002Low=zeros(numSelectedFiles,1);
                SUEM002High=zeros(numSelectedFiles,1);
                SUEM002NaN=zeros(numSelectedFiles,1);
            end

          elseif (a1030==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUEM003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUEM003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUEM003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUEM003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUEM003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUEM003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUEM003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUEM003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUEM003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUEM003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUEM003S.valid_range=attname2;
            end
            if(framecounter==1)
                SUEM00310=zeros(numSelectedFiles,1);
                SUEM00325=zeros(numSelectedFiles,1);
                SUEM00350=zeros(numSelectedFiles,1);
                SUEM00375=zeros(numSelectedFiles,1);
                SUEM00390=zeros(numSelectedFiles,1);
                SUEM00395=zeros(numSelectedFiles,1);
                SUEM00398=zeros(numSelectedFiles,1);
                SUEM003100=zeros(numSelectedFiles,1);
                SUEM003Low=zeros(numSelectedFiles,1);
                SUEM003High=zeros(numSelectedFiles,1);
                SUEM003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1040==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUEM004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUEM004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUEM004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUEM004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUEM004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUEM004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUEM004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUEM004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUEM004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUEM004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUEM004S.valid_range=attname2;
            end
            if(framecounter==1)
                SUEM00410=zeros(numSelectedFiles,1);
                SUEM00425=zeros(numSelectedFiles,1);
                SUEM00450=zeros(numSelectedFiles,1);
                SUEM00475=zeros(numSelectedFiles,1);
                SUEM00490=zeros(numSelectedFiles,1);
                SUEM00495=zeros(numSelectedFiles,1);
                SUEM00498=zeros(numSelectedFiles,1);
                SUEM004100=zeros(numSelectedFiles,1);
                SUEM004Low=zeros(numSelectedFiles,1);
                SUEM004High=zeros(numSelectedFiles,1);
                SUEM004NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1050==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUPMSAS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUPMSAS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUPMSAS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUPMSAS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUPMSAS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUPMSAS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUPMSAS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUPMSAS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUPMSAS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUPMSAS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUPMSAS.valid_range=attname2;
            end
            if(framecounter==1)
                SUPMSA10=zeros(numSelectedFiles,1);
                SUPMSA25=zeros(numSelectedFiles,1);
                SUPMSA50=zeros(numSelectedFiles,1);
                SUPMSA75=zeros(numSelectedFiles,1);
                SUPMSA90=zeros(numSelectedFiles,1);
                SUPMSA95=zeros(numSelectedFiles,1);
                SUPMSA98=zeros(numSelectedFiles,1);
                SUPMSA100=zeros(numSelectedFiles,1);
                SUPMSALow=zeros(numSelectedFiles,1);
                SUPMSAHigh=zeros(numSelectedFiles,1);
                SUPMSANaN=zeros(numSelectedFiles,1);
            end

          elseif (a1060==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUPSO2S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUPSO2S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUPSO2S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUPSO2S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUPSO2S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUPSO2S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUPSO2S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUPSO2S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUPSO2S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUPSO2S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUPSO2S.valid_range=attname2;
            end
            if(framecounter==1)
                SUPSO210=zeros(numSelectedFiles,1);
                SUPSO225=zeros(numSelectedFiles,1);
                SUPSO250=zeros(numSelectedFiles,1);
                SUPSO275=zeros(numSelectedFiles,1);
                SUPSO290=zeros(numSelectedFiles,1);
                SUPSO295=zeros(numSelectedFiles,1);
                SUPSO298=zeros(numSelectedFiles,1);
                SUPSO2100=zeros(numSelectedFiles,1);
                SUPSO2Low=zeros(numSelectedFiles,1);
                SUPSO2High=zeros(numSelectedFiles,1);
                SUPSO2NaN=zeros(numSelectedFiles,1);
            end

          elseif (a1070==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUPSO4AQS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUPSO4AQS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUPSO4AQS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUPSO4AQS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUPSO4AQS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUPSO4AQS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUPSO4AQS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUPSO4AQS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUPSO4AQS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUPSO4AQS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUPSO4AQS.valid_range=attname2;
            end
            if(framecounter==1)
                SUPSO4AQ10=zeros(numSelectedFiles,1);
                SUPSO4AQ25=zeros(numSelectedFiles,1);
                SUPSO4AQ50=zeros(numSelectedFiles,1);
                SUPSO4AQ75=zeros(numSelectedFiles,1);
                SUPSO4AQ90=zeros(numSelectedFiles,1);
                SUPSO4AQ95=zeros(numSelectedFiles,1);
                SUPSO4AQ98=zeros(numSelectedFiles,1);
                SUPSO4AQ100=zeros(numSelectedFiles,1);
                SUPSO4AQLow=zeros(numSelectedFiles,1);
                SUPSO4AQHigh=zeros(numSelectedFiles,1);
                SUPSO4AQNaN=zeros(numSelectedFiles,1);
            end

          elseif (a1080==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUPSO4GS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUPSO4GS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUPSO4GS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUPSO4GS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUPSO4GS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUPSO4GS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUPSO4GS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUPSO4GS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUPSO4GS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUPSO4GS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUPSO4GS.valid_range=attname2;
            end
            if(framecounter==1)
                SUPSO4G10=zeros(numSelectedFiles,1);
                SUPSO4G25=zeros(numSelectedFiles,1);
                SUPSO4G50=zeros(numSelectedFiles,1);
                SUPSO4G75=zeros(numSelectedFiles,1);
                SUPSO4G90=zeros(numSelectedFiles,1);
                SUPSO4G95=zeros(numSelectedFiles,1);
                SUPSO4G98=zeros(numSelectedFiles,1);
                SUPSO4G100=zeros(numSelectedFiles,1);
                SUPSO4GLow=zeros(numSelectedFiles,1);
                SUPSO4GHigh=zeros(numSelectedFiles,1);
                SUPSO4GNaN=zeros(numSelectedFiles,1);
            end

         elseif (a1090==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUPSO4WTS.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUPSO4WTS.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUPSO4WTS.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUPSO4WTS.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUPSO4WTS.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUPSO4WTS.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUPSO4WTS.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUPSO4WTS.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUPSO4WTS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUPSO4WTS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUPSO4WTS.valid_range=attname2;
            end
            if(framecounter==1)
                SUPSO4WT10=zeros(numSelectedFiles,1);
                SUPSO4WT25=zeros(numSelectedFiles,1);
                SUPSO4WT50=zeros(numSelectedFiles,1);
                SUPSO4WT75=zeros(numSelectedFiles,1);
                SUPSO4WT90=zeros(numSelectedFiles,1);
                SUPSO4WT95=zeros(numSelectedFiles,1);
                SUPSO4WT98=zeros(numSelectedFiles,1);
                SUPSO4WT100=zeros(numSelectedFiles,1);
                SUPSO4WTLow=zeros(numSelectedFiles,1);
                SUPSO4WTHigh=zeros(numSelectedFiles,1);
                SUPSO4WTNaN=zeros(numSelectedFiles,1);
            end

          elseif (a1110==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSD001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSD001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSD001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSD001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSD001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSD001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSD001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSD001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSD001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSD001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSD001S.valid_range=attname2;
            end
            if(framecounter==1)
                SUSD00110=zeros(numSelectedFiles,1);
                SUSD00125=zeros(numSelectedFiles,1);
                SUSD00150=zeros(numSelectedFiles,1);
                SUSD00175=zeros(numSelectedFiles,1);
                SUSD00190=zeros(numSelectedFiles,1);
                SUSD00195=zeros(numSelectedFiles,1);
                SUSD00198=zeros(numSelectedFiles,1);
                SUSD001100=zeros(numSelectedFiles,1);
                SUSD001Low=zeros(numSelectedFiles,1);
                SUSD001High=zeros(numSelectedFiles,1);
                SUSD001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1120==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSD002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSD002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSD002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSD002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSD002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSD002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSD002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSD002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSD002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSD002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSD002S.valid_range=attname2;
            end
            if(framecounter==1)
                SUSD00210=zeros(numSelectedFiles,1);
                SUSD00225=zeros(numSelectedFiles,1);
                SUSD00250=zeros(numSelectedFiles,1);
                SUSD00275=zeros(numSelectedFiles,1);
                SUSD00290=zeros(numSelectedFiles,1);
                SUSD00295=zeros(numSelectedFiles,1);
                SUSD00298=zeros(numSelectedFiles,1);
                SUSD002100=zeros(numSelectedFiles,1);
                SUSD002Low=zeros(numSelectedFiles,1);
                SUSD002High=zeros(numSelectedFiles,1);
                SUSD002NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1130==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSD003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSD003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSD003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSD003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSD003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSD003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSD003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSD003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSD003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSD003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSD003S.valid_range=attname2;
            end
            if(framecounter==1)
                SUSD00310=zeros(numSelectedFiles,1);
                SUSD00325=zeros(numSelectedFiles,1);
                SUSD00350=zeros(numSelectedFiles,1);
                SUSD00375=zeros(numSelectedFiles,1);
                SUSD00390=zeros(numSelectedFiles,1);
                SUSD00395=zeros(numSelectedFiles,1);
                SUSD00398=zeros(numSelectedFiles,1);
                SUSD003100=zeros(numSelectedFiles,1);
                SUSD003Low=zeros(numSelectedFiles,1);
                SUSD003High=zeros(numSelectedFiles,1);
                SUSD003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1140==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSD004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSD004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSD004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSD004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSD004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSD004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSD004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSD004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSD004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSD004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSD004S.valid_range=attname2;
            end
            if(framecounter==1)
                SUSD00410=zeros(numSelectedFiles,1);
                SUSD00425=zeros(numSelectedFiles,1);
                SUSD00450=zeros(numSelectedFiles,1);
                SUSD00475=zeros(numSelectedFiles,1);
                SUSD00490=zeros(numSelectedFiles,1);
                SUSD00495=zeros(numSelectedFiles,1);
                SUSD00498=zeros(numSelectedFiles,1);
                SUSD004100=zeros(numSelectedFiles,1);
                SUSD004Low=zeros(numSelectedFiles,1);
                SUSD004High=zeros(numSelectedFiles,1);
                SUSD004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a1160==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSV001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSV001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSV001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSV001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSV001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSV001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSV001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSV001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSV001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSV001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSV001S.valid_range=attname2;
            end

         elseif (a1170==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSV002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSV002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSV002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSV002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSV002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSV002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSV002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSV002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSV002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSV002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSV002S.valid_range=attname2;
            end

         elseif (a1180==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSV003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSV003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSV003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSV003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSV003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSV003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSV003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSV003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSV003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSV003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSV003S.valid_range=attname2;
            end
            if(framecounter==1)
                SUSV00310=zeros(numSelectedFiles,1);
                SUSV00325=zeros(numSelectedFiles,1);
                SUSV00350=zeros(numSelectedFiles,1);
                SUSV00375=zeros(numSelectedFiles,1);
                SUSV00390=zeros(numSelectedFiles,1);
                SUSV00395=zeros(numSelectedFiles,1);
                SUSV00398=zeros(numSelectedFiles,1);
                SUSV003100=zeros(numSelectedFiles,1);
                SUSV003Low=zeros(numSelectedFiles,1);
                SUSV003High=zeros(numSelectedFiles,1);
                SUSV003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1190==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUSV004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUSV004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUSV004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUSV004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUSV004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUSV004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUSV004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUSV004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUSV004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUSV004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUSV004S.valid_range=attname2;
            end
            if(framecounter==1)
                SUSV00410=zeros(numSelectedFiles,1);
                SUSV00425=zeros(numSelectedFiles,1);
                SUSV00450=zeros(numSelectedFiles,1);
                SUSV00475=zeros(numSelectedFiles,1);
                SUSV00490=zeros(numSelectedFiles,1);
                SUSV00495=zeros(numSelectedFiles,1);
                SUSV00498=zeros(numSelectedFiles,1);
                SUSV004100=zeros(numSelectedFiles,1);
                SUSV004Low=zeros(numSelectedFiles,1);
                SUSV004High=zeros(numSelectedFiles,1);
                SUSV004NaN=zeros(numSelectedFiles,1);
            end

          elseif (a1210==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUWT001S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUWT001S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUWT001S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUWT001S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUWT001S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUWT001S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUWT001S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUWT001S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUWT001S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUWT001S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUWT001S.valid_range=attname2;
            end
            if(framecounter==1)
                SUWT00110=zeros(numSelectedFiles,1);
                SUWT00125=zeros(numSelectedFiles,1);
                SUWT00150=zeros(numSelectedFiles,1);
                SUWT00175=zeros(numSelectedFiles,1);
                SUWT00190=zeros(numSelectedFiles,1);
                SUWT00195=zeros(numSelectedFiles,1);
                SUWT00198=zeros(numSelectedFiles,1);
                SUWT001100=zeros(numSelectedFiles,1);
                SUWT001Low=zeros(numSelectedFiles,1);
                SUWT001High=zeros(numSelectedFiles,1);
                SUWT001NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1220==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUWT002S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUWT002S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUWT002S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUWT002S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUWT002S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUWT002S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUWT002S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUWT002S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUWT002S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUWT002S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUWT002S.valid_range=attname2;
            end
            if(framecounter==1)
                SUWT00210=zeros(numSelectedFiles,1);
                SUWT00225=zeros(numSelectedFiles,1);
                SUWT00250=zeros(numSelectedFiles,1);
                SUWT00275=zeros(numSelectedFiles,1);
                SUWT00290=zeros(numSelectedFiles,1);
                SUWT00295=zeros(numSelectedFiles,1);
                SUWT00298=zeros(numSelectedFiles,1);
                SUWT002100=zeros(numSelectedFiles,1);
                SUWT002Low=zeros(numSelectedFiles,1);
                SUWT002High=zeros(numSelectedFiles,1);
                SUWT002NaN=zeros(numSelectedFiles,1);
            end

          elseif (a1230==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUWT003S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUWT003S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUWT003S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUWT003S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUWT003S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUWT003S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUWT003S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUWT003S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUWT003S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUWT003S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUWT003S.valid_range=attname2;
            end
            if(framecounter==1)
                SUWT00310=zeros(numSelectedFiles,1);
                SUWT00325=zeros(numSelectedFiles,1);
                SUWT00350=zeros(numSelectedFiles,1);
                SUWT00375=zeros(numSelectedFiles,1);
                SUWT00390=zeros(numSelectedFiles,1);
                SUWT00395=zeros(numSelectedFiles,1);
                SUWT00398=zeros(numSelectedFiles,1);
                SUWT003100=zeros(numSelectedFiles,1);
                SUWT003Low=zeros(numSelectedFiles,1);
                SUWT003High=zeros(numSelectedFiles,1);
                SUWT003NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1240==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strcmp('add_offset',attname1)
                offset = attname2;
                SUWT004S.add_offset=attname2;
            end
            if strcmp('scale_factor',attname1)
                scale = attname2;
                SUWT004S.scale_factor=attname2;
                if(scale~=1)
                    flag = 1;
                else
                    flag=0;
                end
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                SUWT004S.long_name=attname2;
            end
            a1=strcmp(attname1,'standard_name');
            if(a1==1)
                SUWT004S.standard_name_name=attname2;
            end
            a1=strcmp(attname1,'_FillValue');
            if(a1==1)
                SUWT004S.FillValue=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                SUWT004S.units=attname2;
            end
            a1=strcmp(attname1,'missing_value');
            if(a1==1)
                SUWT004S.missing_value=attname2;
            end
            a1=strcmp(attname1,'fmissing_value');
            if(a1==1)
                SUWT004S.fmissing_value=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                SUWT004S.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                SUWT004S.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                SUWT004S.valid_range=attname2;
            end
            if(framecounter==1)
                SUWT00410=zeros(numSelectedFiles,1);
                SUWT00425=zeros(numSelectedFiles,1);
                SUWT00450=zeros(numSelectedFiles,1);
                SUWT00475=zeros(numSelectedFiles,1);
                SUWT00490=zeros(numSelectedFiles,1);
                SUWT00495=zeros(numSelectedFiles,1);
                SUWT00498=zeros(numSelectedFiles,1);
                SUWT004100=zeros(numSelectedFiles,1);
                SUWT004Low=zeros(numSelectedFiles,1);
                SUWT004High=zeros(numSelectedFiles,1);
                SUWT004NaN=zeros(numSelectedFiles,1);
            end

         elseif (a1250==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            if strmatch('add_offset',attname1)
                offset = attname2;
            end
            if strmatch('scale_factor',attname1)
                scale = attname2;
                flag = 1;
            end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                timeS.long_name=attname2;
            end

            a1=strcmp(attname1,'units');
            if(a1==1)
                timeS.units=attname2;
            end
            a1=strcmp(attname1,'time_increment');
            if(a1==1)
                timeS.time_increment=attname2;
            end
            a1=strcmp(attname1,'begin_date');
            if(a1==1)
                timeS.begin_date=attname2;
            end
            a1=strcmp(attname1,'begin_time');
            if(a1==1)
                timeS.begin_time=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                timeS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                timeS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                timeS.valid_range=attname2;
            end

        elseif (a1260==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LatitudesS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LatitudesS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LatitudesS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LatitudesS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LatitudesS.valid_range=attname2;
            end

        elseif (a1270==1)
            attname1 = netcdf.inqAttName(ncid,i,j);
            attname2 = netcdf.getAtt(ncid,i,attname1);
            if(idebug==1)
                disp([attname1 ':  ' num2str(attname2)])
                dispstr=strcat(attname1,': ',num2str(attname2));
                fprintf(fid,'%s\n',dispstr);
            end
%             if strmatch('add_offset',attname1)
%                 offset = attname2;
%             end
%             if strmatch('scale_factor',attname1)
%                 scale = attname2;
%                 flag = 1;
%             end 
            a1=strcmp(attname1,'long_name');
            if(a1==1)
                LongitudesS.long_name=attname2;
            end
            a1=strcmp(attname1,'units');
            if(a1==1)
                LongitudesS.units=attname2;
            end
            a1=strcmp(attname1,'vmax');
            if(a1==1)
                LongitudesS.vmax=attname2;
            end
            a1=strcmp(attname1,'vmin');
            if(a1==1)
                LongitudesS.vmin=attname2;
            end
            a1=strcmp(attname1,'valid_range');
            if(a1==1)
                LongitudesS.valid_range=attname2;
            end










       end % Loop over variable
    end % loop over attributes
    if(idebug==1)
        disp(' ')
    end
    
    if flag


    else
        eval([varname '= double(netcdf.getVar(ncid,i));'])   
        if(a10==1)
            BCDP001S.values=BCDP001;
        end

        if(a20==1)
            BCDP002S.values=BCDP002;
        end

        if(a30==1)
            BCEM001S.values=BCEM001;
        end

        if(a40==1)
            BCEM002S.values=BCEM002;
        end

        if(a50==1)
            BCEMANS.values=BCEMAN;
        end

        if(a60==1)
            BCEMBBS.values=BCEMBB;
        end

        if(a70==1)
            BCEMBFS.values=BCEMBF;
        end

        if(a80==1)
            BCHYPHILS.values=BCHYPHIL;
        end

        if(a90==1)
            BCSD001S.values=BCSD001;
        end

        if(a100==1)
            BCSD002S.values=BCSD002;    
        end

        if(a110==1)
          BCSV001S.values=BCSV001;
        end

        if(a120==1)
          BCSV002S.values=BCSV002;
        end

        if(a130==1)
          BCWT001S.values=BCWT001;
        end

        if(a140==1)
          BCWT002S.values=BCWT002;
        end

        if(a150==1)
          DUAERIDXS.values=DUAERIDX;
        end

        if(a160==1)
          DUDP001S.values=DUDP001;
        end

        if(a170==1)
          DUDP002S.values=DUDP002;
        end

        if(a180==1)
          DUDP003S.values=DUDP003;
        end

        if(a190==1)
          DUDP004S.values=DUDP004;
        end

       if(a200==1)
          DUDP005S.values=DUDP005;
       end

       if(a210==1)
          DUEM001S.values=DUEM001;
       end

       if(a220==1)
           DUEM002S.values=DUEM002;
       end

       if(a230==1)
           DUEM003S.values=DUEM003;
       end

       if(a240==1)
           DUEM004S.values=DUEM004;
       end

       if(a250==1)
          DUEM005S.values=DUEM005;
       end

       if(a260==1)
          DUEXTTFMS.values=DUEXTTFM;
       end

       if(a270==1)
          DUSCATFMS.values=DUSCATFM;
       end

       if(a280==1)
          DUSD001S.values=DUSD001;
       end

       if(a290==1)
          DUSD002S.values=DUSD002;
       end

       if(a300==1)
          DUSD003S.values=DUSD003;
       end

       if(a310==1)
          DUSD004S.values=DUSD004;
       end

       if(a320==1)
          DUSD005S.values=DUSD005;
       end

       if(a330==1)
          DUSV001S.values=DUSV001;
       end

       if(a340==1)
          DUSV002S.values=DUSV002;
       end

       if(a350==1)
          DUSV003S.values=DUSV003;
       end

       if(a360==1)
          DUSV004S.values=DUSV004;
       end

       if(a370==1)
          DUSV005S.values=DUSV005;
       end

       if(a380==1)
          DUWT001S.values=DUWT001;
       end

       if(a390==1)
          DUWT002S.values=DUWT002;
       end

       if(a400==1)
          DUWT003S.values=DUWT003;
       end

       if(a410==1)
          DUWT004S.values=DUWT004;
       end

       if(a420==1)
          DUWT005S.values=DUWT005;
       end

       if(a430==1)
          latS.values=lat;
       end

       if(a440==1)
          lonS.values=lon;
       end

       if(a450==1)
          OCDP001S.values=OCDP001;
       end

       if(a460==1)
          OCDP002S.values=OCDP002;
       end

       if(a470==1)
          OCEM001S.values=OCEM001;
       end

       if(a480==1)
          OCEM002S.values=OCEM002;
       end

       if(a490==1)
          OCEMANS.values=OCEMAN;
       end

       if(a500==1)
          OCEMBBS.values=OCEMBB;
       end

       if(a510==1)
          OCEMBFS.values=OCEMBF;
       end

       if(a520==1)
          OCEMBGS.values=OCEMBG;
       end

       if(a530==1)
          OCHYPHILS.values= OCHYPHIL;
       end

       if(a540==1)
          OCSD001S.values= OCSD001;
       end

       if(a550==1)
          OCSD002S.values= OCSD002;
       end

       if(a560==1)
          OCSV001S.values= OCSV001;
       end

       if(a570==1)
          OCSV002S.values= OCSV002;
       end

       if(a580==1)
          OCWT001S.values= OCWT001;
       end

       if(a590==1)
          OCWT002S.values= OCWT002;
       end

       if(a600==1)
          SO2EMANS.values= SO2EMAN;
       end

       if(a610==1)
          SO2EMBBS.values= SO2EMBB;
       end

       if(a620==1)
          SO2EMVES.values= SO2EMVE;
       end

       if(a630==1)
          SO2EMVNS.values= SO2EMVN;
       end

       if(a640==1)
          SO4EMANS.values= SO4EMAN;
       end

       if(a650==1)
          SSAERIDXS.values= SSAERIDX;
       end

       if(a660==1)
          SSDP001S.values= SSDP001;
       end

       if(a670==1)
          SSDP002S.values= SSDP002;
       end

       if(a680==1)
          SSDP003S.values= SSDP003;
       end

       if(a690==1)
          SSDP004S.values= SSDP004;
       end

       if(a700==1)
          SSDP005S.values= SSDP005;
       end

       if(a710==1)
          SSEM001S.values= SSEM001;
       end

       if(a720==1)
          SSEM002S.values= SSEM002;
       end

       if(a730==1)
          SSEM003S.values= SSEM003;
       end

       if(a740==1)
          SSEM004S.values= SSEM004;
       end

       if(a750==1)
          SSEM005S.values= SSEM005;
       end

       if(a760==1)
          SSEXTTFMS.values= SSEXTTFM;
       end

       if(a770==1)
          SSSCATFMS.values= SSSCATFM;
       end

       if(a810==1)
          SSSD001S.values= SSSD001;
       end

       if(a820==1)
          SSSD002S.values= SSSD002;
       end

       if(a830==1)
          SSSD003S.values= SSSD003;
       end

       if(a840==1)
          SSSD004S.values= SSSD004;
       end

       if(a850==1)
          SSSD005S.values= SSSD005;
       end

       if(a860==1)
          SSSV001S.values= SSSV001;
       end

       if(a870==1)
          SSSV002S.values= SSSV002;
       end

       if(a880==1)
          SSSV003S.values= SSSV003;
       end

       if(a890==1)
          SSSV004S.values= SSSV004;
       end

       if(a900==1)
          SSSV005S.values= SSSV005;
       end

       if(a910==1)
          SSWT001S.values= SSWT001;
       end

       if(a920==1)
          SSWT002S.values= SSWT002;
       end

       if(a930==1)
          SSWT003S.values= SSWT003;
       end

       if(a940==1)
          SSWT004S.values= SSWT004;
       end

       if(a950==1)
          SSWT005S.values= SSWT005;
       end

       if(a960==1)
          SUDP001S.values= SUDP001;
       end

       if(a970==1)
          SUDP002S.values= SUDP002;
       end

       if(a980==1)
          SUDP003S.values= SUDP003;
       end

       if(a990==1)
          SUDP004S.values= SUDP004;
       end

       if(a1010==1)
          SUEM001S.values= SUEM001;
       end

       if(a1020==1)
          SUEM002S.values= SUEM002;
       end

       if(a1030==1)
          SUEM003S.values= SUEM003;
       end

       if(a1040==1)
          SUEM004S.values= SUEM004;
       end

       if(a1050==1)
          SUPMSAS.values= SUPMSA;
       end

       if(a1060==1)
          SUPSO2S.values= SUPSO2;
       end
      
       if(a1070==1)
          SUPSO4AQS.values= SUPSO4AQ;
       end

       if(a1080==1)
          SUPSO4GS.values= SUPSO4G;
       end
     
       if(a1090==1)
          SUPSO4WTS.values= SUPSO4WT;
       end

       if(a1110==1)
          SUSD001S.values= SUSD001;
       end

       if(a1120==1)
          SUSD002S.values= SUSD002;
       end

       if(a1130==1)
          SUSD003S.values= SUSD003;
       end

       if(a1140==1)
          SUSD004S.values= SUSD004;
       end

       if(a1160==1)
          SUSV001S.values= SUSV001;
       end

       if(a1170==1)
          SUSV002S.values= SUSV002;
       end

       if(a1180==1)
          SUSV003S.values= SUSV003;
       end

       if(a1190==1)
          SUSV004S.values= SUSV004;
       end

       if(a1210==1)
          SUWT001S.values= SUWT001;
       end

       if(a1220==1)
          SUWT002S.values= SUWT002;
       end

       if(a1230==1)
          SUWT003S.values= SUWT003;
       end

       if(a1240==1)
          SUWT004S.values= SUWT004;
       end

       if(a1250==1)
          timeS.values=time;
       end

        if(a1260==1)
            LatitudesS.values=lat;
        end

        if(a1270==1)
            LongitudesS.values=lon;
        end

    end
end

if(idebug==1)
    disp('^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~')
    disp('________________________________________________________')
    disp(' '),disp(' ')
end
netcdf.close(ncid);
fprintf(fid,'%s\n','Finished reading Dataset 02 data');

%% Create Georeference object Rpix
latlim=[-90 90];
lonlim=[-180 180];
numlon=length(lon);
numlat=length(lat);
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
RasterLats=Merra2DataRasterLat;
RasterLons=Merra2DataRasterLon;
%% Now calculate the area of each Raster point. This on varies by latitude
% Get the area of each cell based on the latitude
nlats=length(RasterLats);
nlons=length(RasterLons);
RadiusCalc=zeros(nlats,1);
LatSpacing=abs(RasterLats(2,1)-RasterLats(1,1));
LonSpacing=abs(RasterLons(2,1)-RasterLons(1,1));
lon1=10;
lon2=lon1+LonSpacing;
deg2rad=pi/180;
areakmlast=0;
for k=1:nlats
    lat1=RasterLats(k,1);
    lat2=RasterLats(k,1)+LatSpacing;
    [arclen1,~]=distance(lat1,lon1,lat2,lon1);
    radius = geocradius(lat1);
    distlat=radius*arclen1*deg2rad;
    [arclen2,~]=distance(lat1,lon1,lat1,lon2);
    distlon=radius*arclen2*deg2rad;
    areakm=distlat*distlon/1E6;
    if(areakm<1)
        areaused=16;
    else
        areaused=areakm;
    end
    RasterAreas(k,1)=areaused;
    RadiusCalc(k,1)=radius;
end
[nr,~]=size(RasterLats);
[nc,~]=size(RasterLons);
RasterAreaGrid=zeros(nc,nr);
% Now make an area grid that will have the same values of Area for each
% latitude point regardless 
    for ii=1:nr
        nowArea=RasterAreas(ii,1);
        for jj=1:nc
            RasterAreaGrid(jj,ii)=nowArea;
        end
    end
    ab=1;
%% Display the selected data  on a map of the earth
% This dataset has 24 timeslices-only data from a single pre selected
% time slice will be plotted.
% The user does not have to print plots from each frame but frame 1 wil
% always be plotted
rem=mod(framecounter-1,iSkipReportFrames);
%% Plot the Selected Aerosol Quantities Based on Grouping
% Start with the Black Carbon Dry Deposition Bin 01
if((iBlackCarbon==1) || (iAllAerosols==1) && (rem==0))
    ikind=1;
    itype=3;
    iCityPlot=0;
    varname='BCDP001';
    iAddToReport=1;
    iNewChapter=1;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % with the Black Carbon Dry Deposition Bin 02
    ikind=2;
    itype=3;
    iCityPlot=0;
    varname='BCDP002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot Black Carbon Emission Bin 001
    ikind=3;
    itype=3;
    iCityPlot=0;
    varname='BCEM01';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot Black Carbon Emission Bin 002
    ikind=4;
    itype=3;
    iCityPlot=0;
    varname='BCEM02';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Anthropogenic Emissions
    ikind=5;
    itype=3;
    iCityPlot=0;
    varname='BCEMAM';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Biomass Burning Emissions
    ikind=6;
    itype=3;
    iCityPlot=0;
    varname='BCEMBB';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Biofuel Emissions- this dataset appears to be
    % uncollected so it will be skipped
    % ikind=7;
    % itype=3;
    % iCityPlot=0;
    % varname='BCEMBF';
    % iAddToReport=1;
    % iNewChapter=0;
    % iCloseChapter=0;
    % DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Hydrophobic To Hydrophilic
    ikind=8;
    itype=3;
    iCityPlot=0;
    varname='BCHYPIL';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Sedimentation Bin001 
    ikind=9;
    itype=3;
    iCityPlot=0;
    varname='BCSD001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Sedimentation Bin002 
    ikind=10;
    itype=3;
    iCityPlot=0;
    varname='BCSD002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Convective Scavenging Bin001 
    ikind=11;
    itype=3;
    iCityPlot=0;
    varname='BCSV001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Convective Scavenging Bin002 
    ikind=12;
    itype=3;
    iCityPlot=0;
    varname='BCSV002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Now plot the Black Carbon Deposition Bin001 
    ikind=13;
    itype=3;
    iCityPlot=0;
    varname='BCWT001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Now plot the Black Carbon Deposition Bin002 
    ikind=14;
    itype=3;
    iCityPlot=0;
    varname='BCWT002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=1;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
end
%% Next Move On to the Dust Aerosols
if((iDust==1) || iDust==2|| (iAllAerosols==1) && (rem==0))
    % DUST TOMS UV Index 
    ikind=15;
    itype=3;
    iCityPlot=0;
    varname='DUAERIDX';
    iAddToReport=1;
    iNewChapter=1;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Deposition Bin 01
    ikind=16;
    itype=3;
    iCityPlot=0;
    varname='DUDP001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Deposition Bin 02
    ikind=17;
    itype=3;
    iCityPlot=0;
    varname='DUDP002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Deposition Bin 03
    ikind=18;
    itype=3;
    iCityPlot=0;
    varname='DUDP003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Deposition Bin 04
    ikind=19;
    itype=3;
    iCityPlot=0;
    varname='DUDP004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Deposition Bin 05
    ikind=20;
    itype=3;
    iCityPlot=0;
    varname='DUDP005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Emission Bin 01
    ikind=21;
    itype=3;
    iCityPlot=0;
    varname='DUEM001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Emission Bin 02
    ikind=22;
    itype=3;
    iCityPlot=0;
    varname='DUEM002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Emission Bin 03
    ikind=23;
    itype=3;
    iCityPlot=0;
    varname='DUEM003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Emission Bin 04
    ikind=24;
    itype=3;
    iCityPlot=0;
    varname='DUEM004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dry Dust Emission Bin 05
    ikind=25;
    itype=3;
    iCityPlot=0;
    varname='DUEM005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Extinction AOT
    ikind=26;
    itype=3;
    iCityPlot=0;
    varname='DUEXT';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Scattering at .55 microns 
    ikind=27;
    itype=3;
    iCityPlot=0;
    varname='DUSCAT';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Sedimentation Bin 001 
    ikind=28;
    itype=3;
    iCityPlot=0;
    varname='DUSD01';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Sedimentation Bin 002 
    ikind=29;
    itype=3;
    iCityPlot=0;
    varname='DUSD02';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Sedimentation Bin 003 
    ikind=30;
    itype=3;
    iCityPlot=0;
    varname='DUSD03';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Sedimentation Bin 004 
    ikind=31;
    itype=3;
    iCityPlot=0;
    varname='DUSD04';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Sedimentation Bin 005 
    ikind=32;
    itype=3;
    iCityPlot=0;
    varname='DUSD05';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Dust Convective Scavenging Bin 01 
    ikind=33;
    itype=3;
    iCityPlot=0;
    varname='DUSV01';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Dust Convective Scavenging Bin 02 
    ikind=34;
    itype=3;
    iCityPlot=0;
    varname='DUSV02';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Dust Convective Scavenging Bin 03 
    ikind=35;
    itype=3;
    iCityPlot=0;
    varname='DUSV03';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Dust Convective Scavenging Bin 04 
    ikind=36;
    itype=3;
    iCityPlot=0;
    varname='DUSV04';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Dust Convective Scavenging Bin 05 
    ikind=37;
    itype=3;
    iCityPlot=0;
    varname='DUSV05';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Wet Deposition Bin 001 
    ikind=38;
    itype=3;
    iCityPlot=0;
    varname='DUWT001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Wet Deposition Bin 002 
    ikind=39;
    itype=3;
    iCityPlot=0;
    varname='DUWT002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Wet Deposition Bin 003 
    ikind=40;
    itype=3;
    iCityPlot=0;
    varname='DUWT003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Wet Deposition Bin 004 
    ikind=41;
    itype=3;
    iCityPlot=0;
    varname='DUWT004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Dust Wet Deposition Bin 005 
    ikind=42;
    itype=3;
    iCityPlot=0;
    varname='DUWT005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=1;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
end
%% Next Process Organic Carbon
if((iOrganicCarbon==1) || (iAllAerosols==1) && (rem==0))
% Organic Carbon Dry Deposition Bin 001 
    ikind=45;
    itype=3;
    iCityPlot=0;
    varname='OCDP001';
    iAddToReport=1;
    iNewChapter=1;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Dry Deposition Bin 002 
    ikind=46;
    itype=3;
    iCityPlot=0;
    varname='OCDP002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Emission Bin 001 
    ikind=47;
    itype=3;
    iCityPlot=0;
    varname='OCEM001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Emission Bin 002 
    ikind=48;
    itype=3;
    iCityPlot=0;
    varname='OCEM002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Antropogenic Emission 
    ikind=49;
    itype=3;
    iCityPlot=0;
    varname='OCEMAN';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Burning Emission 
    ikind=50;
    itype=3;
    iCityPlot=0;
    varname='OCEMBB';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Organic Carbon Biofuel Emission 
    ikind=51;
    itype=3;
    iCityPlot=0;
    varname='OCEMBF';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Biogenic Emission 
    ikind=52;
    itype=3;
    iCityPlot=0;
    varname='OCEMBG';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Hydrophobic to Hydrophiic 
    ikind=53;
    itype=3;
    iCityPlot=0;
    varname='OCHYPHIL';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Sedimentation Bin 001 
    ikind=54;
    itype=3;
    iCityPlot=0;
    varname='OCSD001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Sedimentation Bin 002 
    ikind=55;
    itype=3;
    iCityPlot=0;
    varname='OCSD002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Organic Carbon Convective Scavenging Bin 001 
    ikind=56;
    itype=3;
    iCityPlot=0;
    varname='OCSV001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Organic Carbon Convective Scavenging Bin 002 
    ikind=57;
    itype=3;
    iCityPlot=0;
    varname='OCSV002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Organic Carbon Wet Deposition Bin 001 
    ikind=58;
    itype=3;
    iCityPlot=0;
    varname='OCWT001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Organic Carbon Wet Deposition Bin 002 
    ikind=59;
    itype=3;
    iCityPlot=0;
    varname='OCWT002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=1;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
end
%% Next Process the Sulfates
if((iSulfate==1) || (iAllAerosols==1) && (rem==0))
% SO2 Anthropogenic Emissions 
    ikind=60;
    itype=3;
    iCityPlot=0;
    varname='SO2EMAN';
    iAddToReport=1;
    iNewChapter=1;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % SO2 Biomass Burning Emissions 
    ikind=61;
    itype=3;
    iCityPlot=0;
    varname='SO2EMBB';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % SO2 Volcanic Explosive Emissions 
    ikind=62;
    itype=3;
    iCityPlot=0;
    varname='SO2EMVE';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % SO2 Volcanic Non Explosive Emissions 
    ikind=63;
    itype=3;
    iCityPlot=0;
    varname='SO2EMVN';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % SO4 Antropogenic Emissions 
    ikind=64;
    itype=3;
    iCityPlot=0;
    varname='SO4EMAN';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sulfate Dry Deposition Bin 01 
    ikind=93;
    itype=3;
    iCityPlot=0;
    varname='SUDP001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sulfate Dry Deposition Bin 02 
    ikind=94;
    itype=3;
    iCityPlot=0;
    varname='SUDP002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Dry Deposition Bin 03 
    ikind=95;
    itype=3;
    iCityPlot=0;
    varname='SUDP003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Dry Deposition Bin 04 
    ikind=96;
    itype=3;
    iCityPlot=0;
    varname='SUDP004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Emission Bin 01 
    ikind=97;
    itype=3;
    iCityPlot=0;
    varname='SUEM001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Emission Bin 02 
    ikind=98;
    itype=3;
    iCityPlot=0;
    varname='SUEM002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Emission Bin 03 
    ikind=99;
    itype=3;
    iCityPlot=0;
    varname='SUEM003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Emission Bin 04 
    ikind=100;
    itype=3;
    iCityPlot=0;
    varname='SUEM004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % MSA Prod from DMS Oxidation
    ikind=101;
    itype=3;
    iCityPlot=0;
    varname='SUPMSA';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % SO2 Prod from DMS Oxidation
    ikind=102;
    itype=3;
    iCityPlot=0;
    varname='SUPSO2';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % SO4 Prod from Aqueous Oxidation
    ikind=103;
    itype=3;
    iCityPlot=0;
    varname='SUPSO4AQ';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % SO4 Prod from Gaseous SO2 Oxidation
    ikind=104;
    itype=3;
    iCityPlot=0;
    varname='SUPSO4G';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % SO4 Prod from Aqueous SO2 Oxidation
    ikind=105;
    itype=3;
    iCityPlot=0;
    varname='SUPSO4WT';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Settling Bin 001
    ikind=106;
    itype=3;
    iCityPlot=0;
    varname='SUSD001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Settling Bin 002
    ikind=107;
    itype=3;
    iCityPlot=0;
    varname='SUSD002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Settling Bin 003
    ikind=108;
    itype=3;
    iCityPlot=0;
    varname='SUSD003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Settling Bin 004
    ikind=109;
    itype=3;
    iCityPlot=0;
    varname='SUSD004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Convective Scavenging Bin 001
    ikind=110;
    itype=3;
    iCityPlot=0;
    varname='SUSV001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Convective Scavenging Bin 002
    ikind=111;
    itype=3;
    iCityPlot=0;
    varname='SUSV002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Convective Scavenging Bin 003
    ikind=112;
    itype=3;
    iCityPlot=0;
    varname='SUSV003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Convective Scavenging Bin 004
    ikind=113;
    itype=3;
    iCityPlot=0;
    varname='SUSV004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Wet Deposition Bin 001
    ikind=114;
    itype=3;
    iCityPlot=0;
    varname='SUWT001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Wet Deposition Bin 002
    ikind=115;
    itype=3;
    iCityPlot=0;
    varname='SUWT002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Wet Deposition Bin 003
    ikind=116;
    itype=3;
    iCityPlot=0;
    varname='SUWT003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sulfate Wet Deposition Bin 004
    ikind=117;
    itype=3;
    iCityPlot=0;
    varname='SUWT004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=1;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
end
%% Next Plot the SeaSalts
if((iSeaSalt==1) || (iAllAerosols==1) && (rem==0))
% Sea Salt TOMS UV Index
%     ikind=65;
%     itype=3;
%     iCityPlot=0;
%     varname='SSAERIDX';
%     iAddToReport=1;
%     iNewChapter=1;
%     iCloseChapter=0;
%     DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% Sea Salt Dry Deposition Bin 001
    ikind=66;
    itype=3;
    iCityPlot=0;
    varname='SSDP001';
    iAddToReport=1;
    iNewChapter=1;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Dry Deposition Bin 002
    ikind=67;
    itype=3;
    iCityPlot=0;
    varname='SSDP002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Dry Deposition Bin 003
    ikind=68;
    itype=3;
    iCityPlot=0;
    varname='SSDP003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Dry Deposition Bin 004
    ikind=69;
    itype=3;
    iCityPlot=0;
    varname='SSDP004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Dry Deposition Bin 005
    ikind=70;
    itype=3;
    iCityPlot=0;
    varname='SSDP005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Emission Bin 001
    ikind=71;
    itype=3;
    iCityPlot=0;
    varname='SSEM001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Emission Bin 002
    ikind=72;
    itype=3;
    iCityPlot=0;
    varname='SSEM002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Emission Bin 003
    ikind=73;
    itype=3;
    iCityPlot=0;
    varname='SSEM003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Emission Bin 004
    ikind=74;
    itype=3;
    iCityPlot=0;
    varname='SSEM004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Emission Bin 005
    ikind=75;
    itype=3;
    iCityPlot=0;
    varname='SSEM005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
    % Sea Salt Extinction .55 microns 
    ikind=76;
    itype=3;
    iCityPlot=0;
    varname='SSEXTTFM';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Extinction .55 microns 
    ikind=77;
    itype=3;
    iCityPlot=0;
    varname='SSSCATFM';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Sedimentation Bin 01
    ikind=78;
    itype=3;
    iCityPlot=0;
    varname='SSSD001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Sedimentation Bin 02
    ikind=79;
    itype=3;
    iCityPlot=0;
    varname='SSSD002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Sedimentation Bin 03
    ikind=80;
    itype=3;
    iCityPlot=0;
    varname='SSSD003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Sedimentation Bin 04
    ikind=81;
    itype=3;
    iCityPlot=0;
    varname='SSSD004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Sedimentation Bin 05
    ikind=82;
    itype=3;
    iCityPlot=0;
    varname='SSSD005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sea Salt Convective Scavenging Bin 01
    ikind=83;
    itype=3;
    iCityPlot=0;
    varname='SSSV001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Convective Scavenging Bin 02
    ikind=84;
    itype=3;
    iCityPlot=0;
    varname='SSSV002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sea Salt Convective Scavenging Bin 03
    ikind=85;
    itype=3;
    iCityPlot=0;
    varname='SSSV003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sea Salt Convective Scavenging Bin 04
    ikind=86;
    itype=3;
    iCityPlot=0;
    varname='SSSV004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sea Salt Convective Scavenging Bin 05
    ikind=87;
    itype=3;
    iCityPlot=0;
    varname='SSSV005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sea Salt Wet Deposition Bin 01
    ikind=88;
    itype=3;
    iCityPlot=0;
    varname='SSWT001';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
  % Sea Salt Wet Deposition Bin 02
    ikind=89;
    itype=3;
    iCityPlot=0;
    varname='SSWT002';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Wet Deposition Bin 03
    ikind=90;
    itype=3;
    iCityPlot=0;
    varname='SSWT003';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Wet Deposition Bin 04
    ikind=91;
    itype=3;
    iCityPlot=0;
    varname='SSWT004';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=0;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
   % Sea Salt Wet Deposition Bin 05
    ikind=92;
    itype=3;
    iCityPlot=0;
    varname='SSWT005';
    iAddToReport=1;
    iNewChapter=0;
    iCloseChapter=1;
    DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
end
%% Capture Selected Statistics to Holding Arrays
if(framecounter<=numSelectedFiles)
% Start  Black Carbon Dry Deposition Bin 001  ikind=1
    data=BCDP001S.values(:,:,numtimeslice);
    BCDP001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(BCDP001Values,lowcutoff,highcutoff);
    BCDP00110(framecounter,1)=val10;
    BCDP00125(framecounter,1)=val25;
    BCDP00150(framecounter,1)=val50;
    BCDP00175(framecounter,1)=val75;
    BCDP00190(framecounter,1)=val90;
    BCDP00195(framecounter,1)=val95;
    BCDP00198(framecounter,1)=val98;
    BCDP001100(framecounter,1)=val100;
    BCDP001Low(framecounter,1)=fraclow;
    BCDP001High(framecounter,1)=frachigh;
    BCDP001NaN(framecounter,1)=fracNaN;
% continue with Black Carbon Dry Deposition for Bin 002
    data=BCDP002S.values(:,:,numtimeslice);
    BCDP002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(BCDP002Values,lowcutoff,highcutoff);
    BCDP00210(framecounter,1)=val10;
    BCDP00225(framecounter,1)=val25;
    BCDP00250(framecounter,1)=val50;
    BCDP00275(framecounter,1)=val75;
    BCDP00290(framecounter,1)=val90;
    BCDP002100(framecounter,1)=val100;
    BCDP002Low(framecounter,1)=fraclow;
    BCDP002High(framecounter,1)=frachigh;
    BCDP002NaN(framecounter,1)=fracNaN;
% Black Carbon Emission at Bin 001 ikind=3
    data=BCEM001S.values(:,:,numtimeslice);
    fillvalue=BCEM001S.FillValue;
    %data(data==fillvalue)=NaN;
    BCEM001Values=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(BCEM001Values,lowcutoff,highcutoff);
    BCEM00110(framecounter,1)=val10;
    BCEM00125(framecounter,1)=val25;
    BCEM00150(framecounter,1)=val50;
    BCEM00175(framecounter,1)=val75;
    BCEM00190(framecounter,1)=val90;
    BCEM001100(framecounter,1)=val100;
    BCEM001Low(framecounter,1)=fraclow;
    BCEM001High(framecounter,1)=frachigh;
    BCEM001NaN(framecounter,1)=fracNaN;
 % Black Carbon Emission at Bin 002 ikind=4
    data=BCEM002S.values(:,:,numtimeslice);
    fillvalue=BCEM002S.FillValue;
    %data(data==fillvalue)=NaN;
    BCEM002Values=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(BCEM002Values,lowcutoff,highcutoff);
    BCEM00210(framecounter,1)=val10;
    BCEM00225(framecounter,1)=val25;
    BCEM00250(framecounter,1)=val50;
    BCEM00275(framecounter,1)=val75;
    BCEM00290(framecounter,1)=val90;
    BCEM002100(framecounter,1)=val100;
    BCEM002Low(framecounter,1)=fraclow;
    BCEM002High(framecounter,1)=frachigh;
    BCEM002NaN(framecounter,1)=fracNaN;
 % Black Carbon Anthropogenic Emissions ikind=5
    data=BCEMANS.values(:,:,numtimeslice);
    fillvalue=BCEMANS.FillValue;
    %data(data==fillvalue)=NaN;
    BCEMANValues=data/1E-15;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(BCEMANValues,lowcutoff,highcutoff);
    BCEMAN10(framecounter,1)=val10;
    BCEMAN25(framecounter,1)=val25;
    BCEMAN50(framecounter,1)=val50;
    BCEMAN75(framecounter,1)=val75;
    BCEMAN90(framecounter,1)=val90;
    BCEMAN100(framecounter,1)=val100;
    BCEMANLow(framecounter,1)=fraclow;
    BCEMANHigh(framecounter,1)=frachigh;
    BCEMANNaN(framecounter,1)=fracNaN;
  % Black Carbon Burning Biomass Emissions ikind=6
    data=BCEMBBS.values(:,:,numtimeslice);
    fillvalue=BCEMBBS.FillValue;
    %data(data==fillvalue)=NaN;
    BCEMBBValues=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(BCEMBBValues,lowcutoff,highcutoff);
    BCEMBB10(framecounter,1)=val10;
    BCEMBB25(framecounter,1)=val25;
    BCEMBB50(framecounter,1)=val50;
    BCEMBB75(framecounter,1)=val75;
    BCEMBB90(framecounter,1)=val90;
    BCEMBB95(framecounter,1)=val95;
    BCEMBB98(framecounter,1)=val98;
    BCEMBB100(framecounter,1)=val100;
    BCEMBBLow(framecounter,1)=fraclow;
    BCEMBBHigh(framecounter,1)=frachigh;
    BCEMBBNaN(framecounter,1)=fracNaN;
  % Black Carbon Burning Biofuel Emissions ikind=7
    data=BCEMBFS.values(:,:,numtimeslice);
    fillvalue=BCEMBFS.FillValue;
    %data(data==fillvalue)=NaN;
    BCEMBFValues=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(BCEMBFValues,lowcutoff,highcutoff);
    BCEMBF10(framecounter,1)=val10;
    BCEMBF25(framecounter,1)=val25;
    BCEMBF50(framecounter,1)=val50;
    BCEMBF75(framecounter,1)=val75;
    BCEMBF90(framecounter,1)=val90;
    BCEMBF100(framecounter,1)=val100;
    BCEMBFLow(framecounter,1)=fraclow;
    BCEMBFHigh(framecounter,1)=frachigh;
    BCEMBFNaN(framecounter,1)=fracNaN;
   % Black Carbon Hydrophobic ikind=8
    data=BCHYPHILS.values(:,:,numtimeslice);
    fillvalue=BCHYPHILS.FillValue;
    %data(data==fillvalue)=NaN;
    BCHYPHILValues=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(BCHYPHILValues,lowcutoff,highcutoff);
    BCHYPHIL10(framecounter,1)=val10;
    BCHYPHIL25(framecounter,1)=val25;
    BCHYPHIL50(framecounter,1)=val50;
    BCHYPHIL75(framecounter,1)=val75;
    BCHYPHIL90(framecounter,1)=val90;
    BCHYPHIL100(framecounter,1)=val100;
    BCHYPHILFLow(framecounter,1)=fraclow;
    BCHYPHILHigh(framecounter,1)=frachigh;
    BCHYPHILNaN(framecounter,1)=fracNaN;
  % Black Carbon Sedimentation ikind=9
    data=BCSD001S.values(:,:,numtimeslice);
    fillvalue=BCSD001S.FillValue;
    %data(data==fillvalue)=NaN;
    BCSD001Values=data/1E-18;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(BCSD001Values,lowcutoff,highcutoff);
    BCSD00110(framecounter,1)=val10;
    BCSD00125(framecounter,1)=val25;
    BCSD00150(framecounter,1)=val50;
    BCSD00175(framecounter,1)=val75;
    BCSD00190(framecounter,1)=val90;
    BCSD001100(framecounter,1)=val100;
    BCSD001Low(framecounter,1)=fraclow;
    BCSD001High(framecounter,1)=frachigh;
    BCSD001NaN(framecounter,1)=fracNaN;
  % Black Carbon Sedimentation ikind=10
    data=BCSD002S.values(:,:,numtimeslice);
    fillvalue=BCSD002S.FillValue;
    %data(data==fillvalue)=NaN;
    BCSD002Values=data/1E-18;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(BCSD002Values,lowcutoff,highcutoff);
    BCSD00210(framecounter,1)=val10;
    BCSD00225(framecounter,1)=val25;
    BCSD00250(framecounter,1)=val50;
    BCSD00275(framecounter,1)=val75;
    BCSD00290(framecounter,1)=val90;
    BCSD002100(framecounter,1)=val100;
    BCSD002Low(framecounter,1)=fraclow;
    BCSD002High(framecounter,1)=frachigh;
    BCSD002NaN(framecounter,1)=fracNaN;
  % Black Carbon Convective Scavenging ikind=11 
    data=BCSV001S.values(:,:,numtimeslice);
    fillvalue=BCSV001S.FillValue;
    %data(data==fillvalue)=NaN;
    BCSV001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(BCSV001Values,lowcutoff,highcutoff);
    BCSV00110(framecounter,1)=val10;
    BCSV00125(framecounter,1)=val25;
    BCSV00150(framecounter,1)=val50;
    BCSV00175(framecounter,1)=val75;
    BCSV00190(framecounter,1)=val90;
    BCSV00195(framecounter,1)=val95;
    BCSV00198(framecounter,1)=val98;
    BCSV001100(framecounter,1)=val100;
    BCSV001Low(framecounter,1)=fraclow;
    BCSV001High(framecounter,1)=frachigh;
    BCSV001NaN(framecounter,1)=fracNaN;
  % Black Carbon Convective Scavenging ikind=12 
    data=BCSV002S.values(:,:,numtimeslice);
    fillvalue=BCSV002S.FillValue;
    %data(data==fillvalue)=NaN;
    BCSV002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(BCSV002Values,lowcutoff,highcutoff);
    BCSV00210(framecounter,1)=val10;
    BCSV00225(framecounter,1)=val25;
    BCSV00250(framecounter,1)=val50;
    BCSV00275(framecounter,1)=val75;
    BCSV00290(framecounter,1)=val90;
    BCSV00295(framecounter,1)=val95;
    BCSV00298(framecounter,1)=val98;
    BCSV002100(framecounter,1)=val100;
    BCSV002Low(framecounter,1)=fraclow;
    BCSV002High(framecounter,1)=frachigh;
    BCSV002NaN(framecounter,1)=fracNaN;
  % Black Carbon Wet Deposition ikind=13 
    data=BCWT001S.values(:,:,numtimeslice);
    fillvalue=BCWT001S.FillValue;
    %data(data==fillvalue)=NaN;
    BCWT001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=3000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(BCWT001Values,lowcutoff,highcutoff);
    BCWT00110(framecounter,1)=val10;
    BCWT00125(framecounter,1)=val25;
    BCWT00150(framecounter,1)=val50;
    BCWT00175(framecounter,1)=val75;
    BCWT00190(framecounter,1)=val90;
    BCWT00195(framecounter,1)=val95;
    BCWT00198(framecounter,1)=val98;
    BCWT001100(framecounter,1)=val100;
    BCWT001Low(framecounter,1)=fraclow;
    BCWT001High(framecounter,1)=frachigh;
    BCWT001NaN(framecounter,1)=fracNaN;
  % Black Carbon Wet Deposition ikind=14 
    data=BCWT002S.values(:,:,numtimeslice);
    fillvalue=BCWT002S.FillValue;
    %data(data==fillvalue)=NaN;
    BCWT002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=3000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(BCWT002Values,lowcutoff,highcutoff);
    BCWT00210(framecounter,1)=val10;
    BCWT00225(framecounter,1)=val25;
    BCWT00250(framecounter,1)=val50;
    BCWT00275(framecounter,1)=val75;
    BCWT00290(framecounter,1)=val90;
    BCWT00295(framecounter,1)=val95;
    BCWT00298(framecounter,1)=val98;
    BCWT002100(framecounter,1)=val100;
    BCWT002Low(framecounter,1)=fraclow;
    BCWT002High(framecounter,1)=frachigh;
    BCWT002NaN(framecounter,1)=fracNaN;
  % Dust TOMS UV Index ikind=15
    data=DUAERIDXS.values(:,:,numtimeslice);
    fillvalue=DUAERIDXS.FillValue;
    %data(data==fillvalue)=NaN;
    DUAERIDXValues=data;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUAERIDXValues,lowcutoff,highcutoff);
    DUAERIDX10(framecounter,1)=val10;
    DUAERIDX25(framecounter,1)=val25;
    DUAERIDX50(framecounter,1)=val50;
    DUAERIDX75(framecounter,1)=val75;
    DUAERIDX90(framecounter,1)=val90;
    DUAERIDX95(framecounter,1)=val95;
    DUAERIDX98(framecounter,1)=val98;
    DUAERIDX100(framecounter,1)=val100;
    DUAERIDXLow(framecounter,1)=fraclow;
    DUAERIDXHigh(framecounter,1)=frachigh;
    DUAERIDXNaN(framecounter,1)=fracNaN;
  % Dry Dust Deposition Bin 01 ikind=16
    data=DUDP001S.values(:,:,numtimeslice);
    fillvalue=DUDP001S.FillValue;
    %data(data==fillvalue)=NaN;
    DUDP001Values=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(DUDP001Values,lowcutoff,highcutoff);
    DUDP00110(framecounter,1)=val10;
    DUDP00125(framecounter,1)=val25;
    DUDP00150(framecounter,1)=val50;
    DUDP00175(framecounter,1)=val75;
    DUDP00190(framecounter,1)=val90;
    DUDP001100(framecounter,1)=val100;
    DUDP001Low(framecounter,1)=fraclow;
    DUDP001High(framecounter,1)=frachigh;
    DUDP001NaN(framecounter,1)=fracNaN;
  % Dry Dust Deposition Bin 02 ikind=17
    data=DUDP002S.values(:,:,numtimeslice);
    fillvalue=DUDP002S.FillValue;
    %data(data==fillvalue)=NaN;
    DUDP002Values=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(DUDP002Values,lowcutoff,highcutoff);
    DUDP00210(framecounter,1)=val10;
    DUDP00225(framecounter,1)=val25;
    DUDP00250(framecounter,1)=val50;
    DUDP00275(framecounter,1)=val75;
    DUDP00290(framecounter,1)=val90;
    DUDP002100(framecounter,1)=val100;
    DUDP002Low(framecounter,1)=fraclow;
    DUDP002High(framecounter,1)=frachigh;
    DUDP002NaN(framecounter,1)=fracNaN;
  % Dry Dust Deposition Bin 03 ikind=18
    data=DUDP003S.values(:,:,numtimeslice);
    fillvalue=DUDP003S.FillValue;
    %data(data==fillvalue)=NaN;
    DUDP003Values=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(DUDP003Values,lowcutoff,highcutoff);
    DUDP00310(framecounter,1)=val10;
    DUDP00325(framecounter,1)=val25;
    DUDP00350(framecounter,1)=val50;
    DUDP00375(framecounter,1)=val75;
    DUDP00390(framecounter,1)=val90;
    DUDP003100(framecounter,1)=val100;
    DUDP003Low(framecounter,1)=fraclow;
    DUDP003High(framecounter,1)=frachigh;
    DUDP003NaN(framecounter,1)=fracNaN;
  % Dry Dust Deposition Bin 04 ikind=19
    data=DUDP004S.values(:,:,numtimeslice);
    fillvalue=DUDP004S.FillValue;
    %data(data==fillvalue)=NaN;
    DUDP004Values=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(DUDP004Values,lowcutoff,highcutoff);
    DUDP00410(framecounter,1)=val10;
    DUDP00425(framecounter,1)=val25;
    DUDP00450(framecounter,1)=val50;
    DUDP00475(framecounter,1)=val75;
    DUDP00490(framecounter,1)=val90;
    DUDP004100(framecounter,1)=val100;
    DUDP004Low(framecounter,1)=fraclow;
    DUDP004High(framecounter,1)=frachigh;
    DUDP004NaN(framecounter,1)=fracNaN;
  % Dry Dust Deposition Bin 05 ikind=20
    data=DUDP005S.values(:,:,numtimeslice);
    fillvalue=DUDP005S.FillValue;
    %data(data==fillvalue)=NaN;
    DUDP005Values=data/1E-12;
    lowcutoff=0;
    highcutoff=100000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(DUDP005Values,lowcutoff,highcutoff);
    DUDP00510(framecounter,1)=val10;
    DUDP00525(framecounter,1)=val25;
    DUDP00550(framecounter,1)=val50;
    DUDP00575(framecounter,1)=val75;
    DUDP00590(framecounter,1)=val90;
    DUDP005100(framecounter,1)=val100;
    DUDP005Low(framecounter,1)=fraclow;
    DUDP005High(framecounter,1)=frachigh;
    DUDP005NaN(framecounter,1)=fracNaN;
  % Dry Dust Emission Bin 01 ikind=21
    data=DUEM001S.values(:,:,numtimeslice);
    fillvalue=DUEM001S.FillValue;
    %data(data==fillvalue)=NaN;
    DUEM001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUEM001Values,lowcutoff,highcutoff);
    DUEM00110(framecounter,1)=val10;
    DUEM00125(framecounter,1)=val25;
    DUEM00150(framecounter,1)=val50;
    DUEM00175(framecounter,1)=val75;
    DUEM00190(framecounter,1)=val90;
    DUEM00195(framecounter,1)=val95;
    DUEM00198(framecounter,1)=val98;
    DUEM001100(framecounter,1)=val100;
    DUEM001Low(framecounter,1)=fraclow;
    DUEM001High(framecounter,1)=frachigh;
    DUEM001NaN(framecounter,1)=fracNaN;
  % Dry Dust Emission Bin 02 ikind=22
    data=DUEM002S.values(:,:,numtimeslice);
    fillvalue=DUEM002S.FillValue;
    %data(data==fillvalue)=NaN;
    DUEM002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUEM002Values,lowcutoff,highcutoff);
    DUEM00210(framecounter,1)=val10;
    DUEM00225(framecounter,1)=val25;
    DUEM00250(framecounter,1)=val50;
    DUEM00275(framecounter,1)=val75;
    DUEM00290(framecounter,1)=val90;
    DUEM00295(framecounter,1)=val95;
    DUEM00298(framecounter,1)=val98;
    DUEM002100(framecounter,1)=val100;
    DUEM002Low(framecounter,1)=fraclow;
    DUEM002High(framecounter,1)=frachigh;
    DUEM002NaN(framecounter,1)=fracNaN;
  % Dry Dust Emission Bin 03 ikind=23
    data=DUEM003S.values(:,:,numtimeslice);
    fillvalue=DUEM003S.FillValue;
    %data(data==fillvalue)=NaN;
    DUEM003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUEM003Values,lowcutoff,highcutoff);
    DUEM00310(framecounter,1)=val10;
    DUEM00325(framecounter,1)=val25;
    DUEM00350(framecounter,1)=val50;
    DUEM00375(framecounter,1)=val75;
    DUEM00390(framecounter,1)=val90;
    DUEM00395(framecounter,1)=val95;
    DUEM00398(framecounter,1)=val98;
    DUEM003100(framecounter,1)=val100;
    DUEM003Low(framecounter,1)=fraclow;
    DUEM003High(framecounter,1)=frachigh;
    DUEM003NaN(framecounter,1)=fracNaN;
  % Dry Dust Emission Bin 04 ikind=24
    data=DUEM004S.values(:,:,numtimeslice);
    fillvalue=DUEM004S.FillValue;
    %data(data==fillvalue)=NaN;
    DUEM004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUEM004Values,lowcutoff,highcutoff);
    DUEM00410(framecounter,1)=val10;
    DUEM00425(framecounter,1)=val25;
    DUEM00450(framecounter,1)=val50;
    DUEM00475(framecounter,1)=val75;
    DUEM00490(framecounter,1)=val90;
    DUEM00495(framecounter,1)=val95;
    DUEM00498(framecounter,1)=val98;
    DUEM004100(framecounter,1)=val100;
    DUEM004Low(framecounter,1)=fraclow;
    DUEM004High(framecounter,1)=frachigh;
    DUEM004NaN(framecounter,1)=fracNaN;
  % Dry Dust Emission Bin 05 ikind=25
    data=DUEM005S.values(:,:,numtimeslice);
    fillvalue=DUEM005S.FillValue;
    %data(data==fillvalue)=NaN;
    DUEM005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUEM005Values,lowcutoff,highcutoff);
    DUEM00510(framecounter,1)=val10;
    DUEM00525(framecounter,1)=val25;
    DUEM00550(framecounter,1)=val50;
    DUEM00575(framecounter,1)=val75;
    DUEM00590(framecounter,1)=val90;
    DUEM00595(framecounter,1)=val95;
    DUEM00598(framecounter,1)=val98;
    DUEM005100(framecounter,1)=val100;
    DUEM005Low(framecounter,1)=fraclow;
    DUEM005High(framecounter,1)=frachigh;
    DUEM005NaN(framecounter,1)=fracNaN;

  % Dust Extinction Coefficient ikind=26
    data=DUEXTTFMS.values(:,:,numtimeslice);
    fillvalue=DUEXTTFMS.FillValue;
    %data(data==fillvalue)=NaN;
    DUEXTValues=data;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(DUEXTValues,lowcutoff,highcutoff);
    DUEXT10(framecounter,1)=val10;
    DUEXT25(framecounter,1)=val25;
    DUEXT50(framecounter,1)=val50;
    DUEXT75(framecounter,1)=val75;
    DUEXT90(framecounter,1)=val90;
    DUEXT100(framecounter,1)=val100;
    DUEXTLow(framecounter,1)=fraclow;
    DUEXTHigh(framecounter,1)=frachigh;
    DUEXTNaN(framecounter,1)=fracNaN;
  % Dust Scattering Coefficient ikind=27
    data=DUSCATFMS.values(:,:,numtimeslice);
    fillvalue=DUSCATFMS.FillValue;
    %data(data==fillvalue)=NaN;
    DUSCATValues=data;
    lowcutoff=0;
    highcutoff=10;
    [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(DUSCATValues,lowcutoff,highcutoff);
    DUSCAT10(framecounter,1)=val10;
    DUSCAT25(framecounter,1)=val25;
    DUSCAT50(framecounter,1)=val50;
    DUSCAT75(framecounter,1)=val75;
    DUSCAT90(framecounter,1)=val90;
    DUSCAT100(framecounter,1)=val100;
    DUSCATLow(framecounter,1)=fraclow;
    DUSCATHigh(framecounter,1)=frachigh;
    DUSCATNaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 01 ikind=28
    data=DUSD001S.values(:,:,numtimeslice);
    fillvalue=DUSD001S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSD001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSD001Values,lowcutoff,highcutoff);
    DUSD00110(framecounter,1)=val10;
    DUSD00125(framecounter,1)=val25;
    DUSD00150(framecounter,1)=val50;
    DUSD00175(framecounter,1)=val75;
    DUSD00190(framecounter,1)=val90;
    DUSD00195(framecounter,1)=val95;
    DUSD00198(framecounter,1)=val98;
    DUSD001100(framecounter,1)=val100;
    DUSD001Low(framecounter,1)=fraclow;
    DUSD001High(framecounter,1)=frachigh;
    DUSD001NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 02 ikind=29
    data=DUSD002S.values(:,:,numtimeslice);
    fillvalue=DUSD002S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSD002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSD002Values,lowcutoff,highcutoff);
    DUSD00210(framecounter,1)=val10;
    DUSD00225(framecounter,1)=val25;
    DUSD00250(framecounter,1)=val50;
    DUSD00275(framecounter,1)=val75;
    DUSD00290(framecounter,1)=val90;
    DUSD00295(framecounter,1)=val95;
    DUSD00298(framecounter,1)=val98;
    DUSD002100(framecounter,1)=val100;
    DUSD002Low(framecounter,1)=fraclow;
    DUSD002High(framecounter,1)=frachigh;
    DUSD002NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 03 ikind=30
    data=DUSD003S.values(:,:,numtimeslice);
    fillvalue=DUSD003S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSD003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSD003Values,lowcutoff,highcutoff);
    DUSD00310(framecounter,1)=val10;
    DUSD00325(framecounter,1)=val25;
    DUSD00350(framecounter,1)=val50;
    DUSD00375(framecounter,1)=val75;
    DUSD00390(framecounter,1)=val90;
    DUSD00395(framecounter,1)=val95;
    DUSD00398(framecounter,1)=val98;
    DUSD003100(framecounter,1)=val100;
    DUSD003Low(framecounter,1)=fraclow;
    DUSD003High(framecounter,1)=frachigh;
    DUSD003NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 04 ikind=31
    data=DUSD004S.values(:,:,numtimeslice);
    fillvalue=DUSD004S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSD004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSD004Values,lowcutoff,highcutoff);
    DUSD00410(framecounter,1)=val10;
    DUSD00425(framecounter,1)=val25;
    DUSD00450(framecounter,1)=val50;
    DUSD00475(framecounter,1)=val75;
    DUSD00490(framecounter,1)=val90;
    DUSD00495(framecounter,1)=val95;
    DUSD00498(framecounter,1)=val98;
    DUSD004100(framecounter,1)=val100;
    DUSD004Low(framecounter,1)=fraclow;
    DUSD004High(framecounter,1)=frachigh;
    DUSD004NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 05 ikind=32
    data=DUSD005S.values(:,:,numtimeslice);
    fillvalue=DUSD005S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSD005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSD005Values,lowcutoff,highcutoff);
    DUSD00510(framecounter,1)=val10;
    DUSD00525(framecounter,1)=val25;
    DUSD00550(framecounter,1)=val50;
    DUSD00575(framecounter,1)=val75;
    DUSD00590(framecounter,1)=val90;
    DUSD00595(framecounter,1)=val95;
    DUSD00598(framecounter,1)=val98;
    DUSD005100(framecounter,1)=val100;
    DUSD005Low(framecounter,1)=fraclow;
    DUSD005High(framecounter,1)=frachigh;
    DUSD005NaN(framecounter,1)=fracNaN;
  % Dust Scavenging Bin 01 ikind=33
    data=DUSV001S.values(:,:,numtimeslice);
    fillvalue=DUSV001S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSV001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSV001Values,lowcutoff,highcutoff);
    DUSV00110(framecounter,1)=val10;
    DUSV00125(framecounter,1)=val25;
    DUSV00150(framecounter,1)=val50;
    DUSV00175(framecounter,1)=val75;
    DUSV00190(framecounter,1)=val90;
    DUSV00195(framecounter,1)=val95;
    DUSV00198(framecounter,1)=val98;
    DUSV001100(framecounter,1)=val100;
    DUSV001Low(framecounter,1)=fraclow;
    DUSV001High(framecounter,1)=frachigh;
    DUSV001NaN(framecounter,1)=fracNaN;
  % Dust Scavenging Bin 02 ikind=34
    data=DUSV002S.values(:,:,numtimeslice);
    fillvalue=DUSV002S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSV002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSV002Values,lowcutoff,highcutoff);
    DUSV00210(framecounter,1)=val10;
    DUSV00225(framecounter,1)=val25;
    DUSV00250(framecounter,1)=val50;
    DUSV00275(framecounter,1)=val75;
    DUSV00290(framecounter,1)=val90;
    DUSV00295(framecounter,1)=val95;
    DUSV00298(framecounter,1)=val98;
    DUSV002100(framecounter,1)=val100;
    DUSV002Low(framecounter,1)=fraclow;
    DUSV002High(framecounter,1)=frachigh;
    DUSV002NaN(framecounter,1)=fracNaN;
  % Dust Scavenging Bin 03 ikind=35
    data=DUSV003S.values(:,:,numtimeslice);
    fillvalue=DUSV003S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSV003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSV003Values,lowcutoff,highcutoff);
    DUSV00310(framecounter,1)=val10;
    DUSV00325(framecounter,1)=val25;
    DUSV00350(framecounter,1)=val50;
    DUSV00375(framecounter,1)=val75;
    DUSV00390(framecounter,1)=val90;
    DUSV00395(framecounter,1)=val95;
    DUSV00398(framecounter,1)=val98;
    DUSV003100(framecounter,1)=val100;
    DUSV003Low(framecounter,1)=fraclow;
    DUSV003High(framecounter,1)=frachigh;
    DUSV003NaN(framecounter,1)=fracNaN;
  % Dust Scavenging Bin 04 ikind=36
    data=DUSV004S.values(:,:,numtimeslice);
    fillvalue=DUSV004S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSV004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSV004Values,lowcutoff,highcutoff);
    DUSV00410(framecounter,1)=val10;
    DUSV00425(framecounter,1)=val25;
    DUSV00450(framecounter,1)=val50;
    DUSV00475(framecounter,1)=val75;
    DUSV00490(framecounter,1)=val90;
    DUSV00495(framecounter,1)=val95;
    DUSV00498(framecounter,1)=val98;
    DUSV004100(framecounter,1)=val100;
    DUSV004Low(framecounter,1)=fraclow;
    DUSV004High(framecounter,1)=frachigh;
    DUSV004NaN(framecounter,1)=fracNaN;
  % Dust Scavenging Bin 05 ikind=37
    data=DUSV005S.values(:,:,numtimeslice);
    fillvalue=DUSV005S.FillValue;
    %data(data==fillvalue)=NaN;
    DUSV005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUSV005Values,lowcutoff,highcutoff);
    DUSV00510(framecounter,1)=val10;
    DUSV00525(framecounter,1)=val25;
    DUSV00550(framecounter,1)=val50;
    DUSV00575(framecounter,1)=val75;
    DUSV00590(framecounter,1)=val90;
    DUSV00595(framecounter,1)=val95;
    DUSV00598(framecounter,1)=val98;
    DUSV005100(framecounter,1)=val100;
    DUSV005Low(framecounter,1)=fraclow;
    DUSV005High(framecounter,1)=frachigh;
    DUSV005NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 01 ikind=38
    data=DUWT001S.values(:,:,numtimeslice);
    fillvalue=DUWT001S.FillValue;
    %data(data==fillvalue)=NaN;
    DUWT001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUWT001Values,lowcutoff,highcutoff);
    DUWT00110(framecounter,1)=val10;
    DUWT00125(framecounter,1)=val25;
    DUWT00150(framecounter,1)=val50;
    DUWT00175(framecounter,1)=val75;
    DUWT00190(framecounter,1)=val90;
    DUWT00195(framecounter,1)=val95;
    DUWT00198(framecounter,1)=val98;
    DUWT001100(framecounter,1)=val100;
    DUWT001Low(framecounter,1)=fraclow;
    DUWT001High(framecounter,1)=frachigh;
    DUWT001NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 02 ikind=39
    data=DUWT002S.values(:,:,numtimeslice);
    fillvalue=DUWT002S.FillValue;
    %data(data==fillvalue)=NaN;
    DUWT002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUWT002Values,lowcutoff,highcutoff);
    DUWT00210(framecounter,1)=val10;
    DUWT00225(framecounter,1)=val25;
    DUWT00250(framecounter,1)=val50;
    DUWT00275(framecounter,1)=val75;
    DUWT00290(framecounter,1)=val90;
    DUWT00295(framecounter,1)=val95;
    DUWT00298(framecounter,1)=val98;
    DUWT002100(framecounter,1)=val100;
    DUWT002Low(framecounter,1)=fraclow;
    DUWT002High(framecounter,1)=frachigh;
    DUWT002NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 03 ikind=40
    data=DUWT003S.values(:,:,numtimeslice);
    fillvalue=DUWT003S.FillValue;
    %data(data==fillvalue)=NaN;
    DUWT003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUWT003Values,lowcutoff,highcutoff);
    DUWT00310(framecounter,1)=val10;
    DUWT00325(framecounter,1)=val25;
    DUWT00350(framecounter,1)=val50;
    DUWT00375(framecounter,1)=val75;
    DUWT00390(framecounter,1)=val90;
    DUWT00395(framecounter,1)=val95;
    DUWT00398(framecounter,1)=val98;
    DUWT003100(framecounter,1)=val100;
    DUWT003Low(framecounter,1)=fraclow;
    DUWT003High(framecounter,1)=frachigh;
    DUWT003NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 04 ikind=41
    data=DUWT004S.values(:,:,numtimeslice);
    fillvalue=DUWT004S.FillValue;
    %data(data==fillvalue)=NaN;
    DUWT004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUWT004Values,lowcutoff,highcutoff);
    DUWT00410(framecounter,1)=val10;
    DUWT00425(framecounter,1)=val25;
    DUWT00450(framecounter,1)=val50;
    DUWT00475(framecounter,1)=val75;
    DUWT00490(framecounter,1)=val90;
    DUWT00495(framecounter,1)=val95;
    DUWT00498(framecounter,1)=val98;
    DUWT004100(framecounter,1)=val100;
    DUWT004Low(framecounter,1)=fraclow;
    DUWT004High(framecounter,1)=frachigh;
    DUWT004NaN(framecounter,1)=fracNaN;
  % Dust Sedimentation Bin 05 ikind=42
    data=DUWT005S.values(:,:,numtimeslice);
    fillvalue=DUWT005S.FillValue;
    %data(data==fillvalue)=NaN;
    DUWT005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(DUWT005Values,lowcutoff,highcutoff);
    DUWT00510(framecounter,1)=val10;
    DUWT00525(framecounter,1)=val25;
    DUWT00550(framecounter,1)=val50;
    DUWT00575(framecounter,1)=val75;
    DUWT00590(framecounter,1)=val90;
    DUWT00595(framecounter,1)=val95;
    DUWT00598(framecounter,1)=val98;
    DUWT005100(framecounter,1)=val100;
    DUWT005Low(framecounter,1)=fraclow;
    DUWT005High(framecounter,1)=frachigh;
    DUWT005NaN(framecounter,1)=fracNaN;
  % Dry Organic Carbon Deposition Bin 01 ikind=45
    data=OCDP001S.values(:,:,numtimeslice);
    fillvalue=OCDP001S.FillValue;
    %data(data==fillvalue)=NaN;
    OCDP001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCDP001Values,lowcutoff,highcutoff);
    OCDP00110(framecounter,1)=val10;
    OCDP00125(framecounter,1)=val25;
    OCDP00150(framecounter,1)=val50;
    OCDP00175(framecounter,1)=val75;
    OCDP00190(framecounter,1)=val90;
    OCDP00195(framecounter,1)=val95;
    OCDP00198(framecounter,1)=val98;
    OCDP001100(framecounter,1)=val100;
    OCDP001Low(framecounter,1)=fraclow;
    OCDP001High(framecounter,1)=frachigh;
    OCDP001NaN(framecounter,1)=fracNaN;
  % Dry Organic Carbon Deposition Bin 02 ikind=46
    data=OCDP002S.values(:,:,numtimeslice);
    fillvalue=OCDP002S.FillValue;
    %data(data==fillvalue)=NaN;
    OCDP002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCDP002Values,lowcutoff,highcutoff);
    OCDP00210(framecounter,1)=val10;
    OCDP00225(framecounter,1)=val25;
    OCDP00250(framecounter,1)=val50;
    OCDP00275(framecounter,1)=val75;
    OCDP00290(framecounter,1)=val90;
    OCDP00295(framecounter,1)=val95;
    OCDP00298(framecounter,1)=val98;
    OCDP002100(framecounter,1)=val100;
    OCDP002Low(framecounter,1)=fraclow;
    OCDP002High(framecounter,1)=frachigh;
    OCDP002NaN(framecounter,1)=fracNaN;
  % Organic Carbon Emission Bin 01 ikind=47
    data=OCEM001S.values(:,:,numtimeslice);
    fillvalue=OCEM001S.FillValue;
    %data(data==fillvalue)=NaN;
    OCEM001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCEM001Values,lowcutoff,highcutoff);
    OCEM00110(framecounter,1)=val10;
    OCEM00125(framecounter,1)=val25;
    OCEM00150(framecounter,1)=val50;
    OCEM00175(framecounter,1)=val75;
    OCEM00190(framecounter,1)=val90;
    OCEM00195(framecounter,1)=val95;
    OCEM00198(framecounter,1)=val98;
    OCEM001100(framecounter,1)=val100;
    OCEM001Low(framecounter,1)=fraclow;
    OCEM001High(framecounter,1)=frachigh;
    OCEM001NaN(framecounter,1)=fracNaN;
  % Organic Carbon Emission Bin 02 ikind=48
    data=OCEM002S.values(:,:,numtimeslice);
    fillvalue=OCEM002S.FillValue;
    %data(data==fillvalue)=NaN;
    OCEM002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCEM002Values,lowcutoff,highcutoff);
    OCEM00210(framecounter,1)=val10;
    OCEM00225(framecounter,1)=val25;
    OCEM00250(framecounter,1)=val50;
    OCEM00275(framecounter,1)=val75;
    OCEM00290(framecounter,1)=val90;
    OCEM00295(framecounter,1)=val95;
    OCEM00298(framecounter,1)=val98;
    OCEM002100(framecounter,1)=val100;
    OCEM002Low(framecounter,1)=fraclow;
    OCEM002High(framecounter,1)=frachigh;
    OCEM002NaN(framecounter,1)=fracNaN;
  % Organic Carbon Antropogenic Emission ikind=49
    data=OCEMANS.values(:,:,numtimeslice);
    fillvalue=OCEMANS.FillValue;
    %data(data==fillvalue)=NaN;
    OCEMANValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCEMANValues,lowcutoff,highcutoff);
    OCEMAN10(framecounter,1)=val10;
    OCEMAN25(framecounter,1)=val25;
    OCEMAN50(framecounter,1)=val50;
    OCEMAN75(framecounter,1)=val75;
    OCEMAN90(framecounter,1)=val90;
    OCEMAN95(framecounter,1)=val95;
    OCEMAN98(framecounter,1)=val98;
    OCEMAN100(framecounter,1)=val100;
    OCEMANLow(framecounter,1)=fraclow;
    OCEMANHigh(framecounter,1)=frachigh;
    OCEMANNaN(framecounter,1)=fracNaN;
  % Organic Carbon Antropogenic Emission ikind=50
    data=OCEMBBS.values(:,:,numtimeslice);
    fillvalue=OCEMBBS.FillValue;
    %data(data==fillvalue)=NaN;
    OCEMBBValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCEMBBValues,lowcutoff,highcutoff);
    OCEMBB10(framecounter,1)=val10;
    OCEMBB25(framecounter,1)=val25;
    OCEMBB50(framecounter,1)=val50;
    OCEMBB75(framecounter,1)=val75;
    OCEMBB90(framecounter,1)=val90;
    OCEMBB95(framecounter,1)=val95;
    OCEMBB98(framecounter,1)=val98;
    OCEMBB100(framecounter,1)=val100;
    OCEMBBLow(framecounter,1)=fraclow;
    OCEMBBHigh(framecounter,1)=frachigh;
    OCEMBBNaN(framecounter,1)=fracNaN;
  % Organic Carbon Biofuel Emissions ikind=51
    data=OCEMBFS.values(:,:,numtimeslice);
    fillvalue=OCEMBFS.FillValue;
    %data(data==fillvalue)=NaN;
    OCEMBFValues=data/1E-15;
    lowcutoff=0;
    highcutoff=1000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCEMBFValues,lowcutoff,highcutoff);
    OCEMBF10(framecounter,1)=val10;
    OCEMBF25(framecounter,1)=val25;
    OCEMBF50(framecounter,1)=val50;
    OCEMBF75(framecounter,1)=val75;
    OCEMBF90(framecounter,1)=val90;
    OCEMBF95(framecounter,1)=val95;
    OCEMBF98(framecounter,1)=val98;
    OCEMBF100(framecounter,1)=val100;
    OCEMBFLow(framecounter,1)=fraclow;
    OCEMBFHigh(framecounter,1)=frachigh;
    OCEMBFNaN(framecounter,1)=fracNaN;
  % Organic Carbon Biogenic Emission ikind=52
    data=OCEMBGS.values(:,:,numtimeslice);
    fillvalue=OCEMBGS.FillValue;
    %data(data==fillvalue)=NaN;
    OCEMBGValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCEMBGValues,lowcutoff,highcutoff);
    OCEMBG10(framecounter,1)=val10;
    OCEMBG25(framecounter,1)=val25;
    OCEMBG50(framecounter,1)=val50;
    OCEMBG75(framecounter,1)=val75;
    OCEMBG90(framecounter,1)=val90;
    OCEMBG95(framecounter,1)=val95;
    OCEMBG98(framecounter,1)=val98;
    OCEMBG100(framecounter,1)=val100;
    OCEMBGLow(framecounter,1)=fraclow;
    OCEMBGHigh(framecounter,1)=frachigh;
    OCEMBGNaN(framecounter,1)=fracNaN;
  % Organic Carbon Hydrophobic to Hydrophilic  ikind=53
    data=OCHYPHILS.values(:,:,numtimeslice);
    fillvalue=OCHYPHILS.FillValue;
    %data(data==fillvalue)=NaN;
    OCHYPHILValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCHYPHILValues,lowcutoff,highcutoff);
    OCHYPHIL10(framecounter,1)=val10;
    OCHYPHIL25(framecounter,1)=val25;
    OCHYPHIL50(framecounter,1)=val50;
    OCHYPHIL75(framecounter,1)=val75;
    OCHYPHIL90(framecounter,1)=val90;
    OCHYPHIL95(framecounter,1)=val95;
    OCHYPHIL98(framecounter,1)=val98;
    OCHYPHIL100(framecounter,1)=val100;
    OCHYPHILLow(framecounter,1)=fraclow;
    OCHYPHILHigh(framecounter,1)=frachigh;
    OCHYPHILNaN(framecounter,1)=fracNaN;
  % Organic Carbon Sedimentation Bin 001  ikind=54
    data=OCSD001S.values(:,:,numtimeslice);
    fillvalue=OCSD001S.FillValue;
    %data(data==fillvalue)=NaN;
    OCSD001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCSD001Values,lowcutoff,highcutoff);
    OCSD00110(framecounter,1)=val10;
    OCSD00125(framecounter,1)=val25;
    OCSD00150(framecounter,1)=val50;
    OCSD00175(framecounter,1)=val75;
    OCSD00190(framecounter,1)=val90;
    OCSD00195(framecounter,1)=val95;
    OCSD00198(framecounter,1)=val98;
    OCSD001100(framecounter,1)=val100;
    OCSD001Low(framecounter,1)=fraclow;
    OCSD001High(framecounter,1)=frachigh;
    OCSD001NaN(framecounter,1)=fracNaN;
  % Organic Carbon Sedimentation Bin 002  ikind=55
    data=OCSD002S.values(:,:,numtimeslice);
    fillvalue=OCSD002S.FillValue;
    %data(data==fillvalue)=NaN;
    OCSD002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCSD002Values,lowcutoff,highcutoff);
    OCSD00210(framecounter,1)=val10;
    OCSD00225(framecounter,1)=val25;
    OCSD00250(framecounter,1)=val50;
    OCSD00275(framecounter,1)=val75;
    OCSD00290(framecounter,1)=val90;
    OCSD00295(framecounter,1)=val95;
    OCSD00298(framecounter,1)=val98;
    OCSD002100(framecounter,1)=val100;
    OCSD002Low(framecounter,1)=fraclow;
    OCSD002High(framecounter,1)=frachigh;
    OCSD002NaN(framecounter,1)=fracNaN;
  % Organic Carbon Convective Scavenging Bin 01 ikind=56
    data=OCSV001S.values(:,:,numtimeslice);
    fillvalue=OCSV001S.FillValue;
    %data(data==fillvalue)=NaN;
    OCSV001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCSV001Values,lowcutoff,highcutoff);
    OCSV00110(framecounter,1)=val10;
    OCSV00125(framecounter,1)=val25;
    OCSV00150(framecounter,1)=val50;
    OCSV00175(framecounter,1)=val75;
    OCSV00190(framecounter,1)=val90;
    OCSV00195(framecounter,1)=val95;
    OCSV00198(framecounter,1)=val98;
    OCSV001100(framecounter,1)=val100;
    OCSV001Low(framecounter,1)=fraclow;
    OCSV001High(framecounter,1)=frachigh;
    OCSV001NaN(framecounter,1)=fracNaN;
  % Organic Carbon Convective Scavenging Bin 02 ikind=57
    data=OCSV002S.values(:,:,numtimeslice);
    fillvalue=OCSV002S.FillValue;
    %data(data==fillvalue)=NaN;
    OCSV002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=5000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCSV002Values,lowcutoff,highcutoff);
    OCSV00210(framecounter,1)=val10;
    OCSV00225(framecounter,1)=val25;
    OCSV00250(framecounter,1)=val50;
    OCSV00275(framecounter,1)=val75;
    OCSV00290(framecounter,1)=val90;
    OCSV00295(framecounter,1)=val95;
    OCSV00298(framecounter,1)=val98;
    OCSV002100(framecounter,1)=val100;
    OCSV002Low(framecounter,1)=fraclow;
    OCSV002High(framecounter,1)=frachigh;
    OCSV002NaN(framecounter,1)=fracNaN;
  % Organic Carbon Wet Deposition Bin 001  ikind=58
    data=OCWT001S.values(:,:,numtimeslice);
    fillvalue=OCWT001S.FillValue;
    %data(data==fillvalue)=NaN;
    OCWT001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCWT001Values,lowcutoff,highcutoff);
    OCWT00110(framecounter,1)=val10;
    OCWT00125(framecounter,1)=val25;
    OCWT00150(framecounter,1)=val50;
    OCWT00175(framecounter,1)=val75;
    OCWT00190(framecounter,1)=val90;
    OCWT00195(framecounter,1)=val95;
    OCWT00198(framecounter,1)=val98;
    OCWT001100(framecounter,1)=val100;
    OCWT001Low(framecounter,1)=fraclow;
    OCWT001High(framecounter,1)=frachigh;
    OCWT001NaN(framecounter,1)=fracNaN;
  % Organic Carbon Wet Deposition Bin 002  ikind=59
    data=OCWT002S.values(:,:,numtimeslice);
    fillvalue=OCWT002S.FillValue;
    %data(data==fillvalue)=NaN;
    OCWT002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(OCWT002Values,lowcutoff,highcutoff);
    OCWT00210(framecounter,1)=val10;
    OCWT00225(framecounter,1)=val25;
    OCWT00250(framecounter,1)=val50;
    OCWT00275(framecounter,1)=val75;
    OCWT00290(framecounter,1)=val90;
    OCWT00295(framecounter,1)=val95;
    OCWT00298(framecounter,1)=val98;
    OCWT002100(framecounter,1)=val100;
    OCWT002Low(framecounter,1)=fraclow;
    OCWT002High(framecounter,1)=frachigh;
    OCWT002NaN(framecounter,1)=fracNaN;
  % SO2 Antropogenic Emissions ikind=60
    data=SO2EMANS.values(:,:,numtimeslice);
    fillvalue=SO2EMANS.FillValue;
    %data(data==fillvalue)=NaN;
    SO2MANValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SO2MANValues,lowcutoff,highcutoff);
    SO2MAN10(framecounter,1)=val10;
    SO2MAN25(framecounter,1)=val25;
    SO2MAN50(framecounter,1)=val50;
    SO2MAN75(framecounter,1)=val75;
    SO2MAN90(framecounter,1)=val90;
    SO2MAN95(framecounter,1)=val95;
    SO2MAN98(framecounter,1)=val98;
    SO2MAN100(framecounter,1)=val100;
    SO2MANLow(framecounter,1)=fraclow;
    SO2MANHigh(framecounter,1)=frachigh;
    SO2MANNaN(framecounter,1)=fracNaN;
  % SO2 Biomass Burning ikind=61
    data=SO2EMBBS.values(:,:,numtimeslice);
    fillvalue=SO2EMBBS.FillValue;
    %data(data==fillvalue)=NaN;
    SO2MBBValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SO2MBBValues,lowcutoff,highcutoff);
    SO2MBB10(framecounter,1)=val10;
    SO2MBB25(framecounter,1)=val25;
    SO2MBB50(framecounter,1)=val50;
    SO2MBB75(framecounter,1)=val75;
    SO2MBB90(framecounter,1)=val90;
    SO2MBB95(framecounter,1)=val95;
    SO2MBB98(framecounter,1)=val98;
    SO2MBB100(framecounter,1)=val100;
    SO2MBBLow(framecounter,1)=fraclow;
    SO2MBBHigh(framecounter,1)=frachigh;
    SO2MBBNaN(framecounter,1)=fracNaN;
  % SO2 Explosive Volcanic Emissions ikind=62
    data=SO2EMVES.values(:,:,numtimeslice);
    fillvalue=SO2EMVES.FillValue;
    %data(data==fillvalue)=NaN;
    SO2EMVEValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SO2EMVEValues,lowcutoff,highcutoff);
    SO2EMVE10(framecounter,1)=val10;
    SO2EMVE25(framecounter,1)=val25;
    SO2EMVE50(framecounter,1)=val50;
    SO2EMVE75(framecounter,1)=val75;
    SO2EMVE90(framecounter,1)=val90;
    SO2EMVE95(framecounter,1)=val95;
    SO2EMVE98(framecounter,1)=val98;
    SO2EMVE100(framecounter,1)=val100;
    SO2EMVELow(framecounter,1)=fraclow;
    SO2EMVEHigh(framecounter,1)=frachigh;
    SO2EMVENaN(framecounter,1)=fracNaN;
  % SO2 Non Explosive Volcanic Emissions ikind=63
    data=SO2EMVNS.values(:,:,numtimeslice);
    fillvalue=SO2EMVNS.FillValue;
    %data(data==fillvalue)=NaN;
    SO2EMVNValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SO2EMVNValues,lowcutoff,highcutoff);
    SO2EMVN10(framecounter,1)=val10;
    SO2EMVN25(framecounter,1)=val25;
    SO2EMVN50(framecounter,1)=val50;
    SO2EMVN75(framecounter,1)=val75;
    SO2EMVN90(framecounter,1)=val90;
    SO2EMVN95(framecounter,1)=val95;
    SO2EMVN98(framecounter,1)=val98;
    SO2EMVN100(framecounter,1)=val100;
    SO2EMVNLow(framecounter,1)=fraclow;
    SO2EMVNHigh(framecounter,1)=frachigh;
    SO2EMVNNaN(framecounter,1)=fracNaN;
  % SO4 AntropogenicEmissions ikind=64
    data=SO4EMANS.values(:,:,numtimeslice);
    fillvalue=SO4EMANS.FillValue;
    %data(data==fillvalue)=NaN;
    SO4EMANValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SO4EMANValues,lowcutoff,highcutoff);
    SO4EMAN10(framecounter,1)=val10;
    SO4EMAN25(framecounter,1)=val25;
    SO4EMAN50(framecounter,1)=val50;
    SO4EMAN75(framecounter,1)=val75;
    SO4EMAN90(framecounter,1)=val90;
    SO4EMAN95(framecounter,1)=val95;
    SO4EMAN98(framecounter,1)=val98;
    SO4EMAN100(framecounter,1)=val100;
    SO4EMANLow(framecounter,1)=fraclow;
    SO4EMANHigh(framecounter,1)=frachigh;
    SO4EMANNaN(framecounter,1)=fracNaN;
  % Sea Salt UV TOMS Index ikind=65
    data=SSAERIDXS.values(:,:,numtimeslice);
    fillvalue=SSAERIDXS.FillValue;
    %data(data==fillvalue)=NaN;
    SSAERIDXValues=data/1E-15;
    lowcutoff=0;
    highcutoff=50;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSAERIDXValues,lowcutoff,highcutoff);
    SSAERIDX10(framecounter,1)=val10;
    SSAERIDX25(framecounter,1)=val25;
    SSAERIDX50(framecounter,1)=val50;
    SSAERIDX75(framecounter,1)=val75;
    SSAERIDX90(framecounter,1)=val90;
    SSAERIDX95(framecounter,1)=val95;
    SSAERIDX98(framecounter,1)=val98;
    SSAERIDX100(framecounter,1)=val100;
    SSAERIDXLow(framecounter,1)=fraclow;
    SSAERIDXHigh(framecounter,1)=frachigh;
    SSAERIDXNaN(framecounter,1)=fracNaN;
  % Sea Salt Dry Deposition ikind=66
    data=SSDP001S.values(:,:,numtimeslice);
    fillvalue=SSDP001S.FillValue;
    %data(data==fillvalue)=NaN;
    SSDP001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSDP001Values,lowcutoff,highcutoff);
    SSDP00110(framecounter,1)=val10;
    SSDP00125(framecounter,1)=val25;
    SSDP00150(framecounter,1)=val50;
    SSDP00175(framecounter,1)=val75;
    SSDP00190(framecounter,1)=val90;
    SSDP00195(framecounter,1)=val95;
    SSDP00198(framecounter,1)=val98;
    SSDP001100(framecounter,1)=val100;
    SSDP001Low(framecounter,1)=fraclow;
    SSDP001High(framecounter,1)=frachigh;
    SSDP001NaN(framecounter,1)=fracNaN;
  % Sea Salt Dry Deposition ikind=67
    data=SSDP002S.values(:,:,numtimeslice);
    fillvalue=SSDP002S.FillValue;
    %data(data==fillvalue)=NaN;
    SSDP002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSDP002Values,lowcutoff,highcutoff);
    SSDP00210(framecounter,1)=val10;
    SSDP00225(framecounter,1)=val25;
    SSDP00250(framecounter,1)=val50;
    SSDP00275(framecounter,1)=val75;
    SSDP00290(framecounter,1)=val90;
    SSDP00295(framecounter,1)=val95;
    SSDP00298(framecounter,1)=val98;
    SSDP002100(framecounter,1)=val100;
    SSDP002Low(framecounter,1)=fraclow;
    SSDP002High(framecounter,1)=frachigh;
    SSDP002NaN(framecounter,1)=fracNaN;
  % Sea Salt Dry Deposition ikind=68
    data=SSDP003S.values(:,:,numtimeslice);
    fillvalue=SSDP003S.FillValue;
    %data(data==fillvalue)=NaN;
    SSDP003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSDP003Values,lowcutoff,highcutoff);
    SSDP00310(framecounter,1)=val10;
    SSDP00325(framecounter,1)=val25;
    SSDP00350(framecounter,1)=val50;
    SSDP00375(framecounter,1)=val75;
    SSDP00390(framecounter,1)=val90;
    SSDP00395(framecounter,1)=val95;
    SSDP00398(framecounter,1)=val98;
    SSDP003100(framecounter,1)=val100;
    SSDP003Low(framecounter,1)=fraclow;
    SSDP003High(framecounter,1)=frachigh;
    SSDP003NaN(framecounter,1)=fracNaN;
  % Sea Salt Dry Deposition ikind=69
    data=SSDP004S.values(:,:,numtimeslice);
    fillvalue=SSDP004S.FillValue;
    %data(data==fillvalue)=NaN;
    SSDP004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSDP004Values,lowcutoff,highcutoff);
    SSDP00410(framecounter,1)=val10;
    SSDP00425(framecounter,1)=val25;
    SSDP00450(framecounter,1)=val50;
    SSDP00475(framecounter,1)=val75;
    SSDP00490(framecounter,1)=val90;
    SSDP00495(framecounter,1)=val95;
    SSDP00498(framecounter,1)=val98;
    SSDP004100(framecounter,1)=val100;
    SSDP004Low(framecounter,1)=fraclow;
    SSDP004High(framecounter,1)=frachigh;
    SSDP004NaN(framecounter,1)=fracNaN;
  % Sea Salt Dry Deposition ikind=70
    data=SSDP005S.values(:,:,numtimeslice);
    fillvalue=SSDP005S.FillValue;
    %data(data==fillvalue)=NaN;
    SSDP005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSDP005Values,lowcutoff,highcutoff);
    SSDP00510(framecounter,1)=val10;
    SSDP00525(framecounter,1)=val25;
    SSDP00550(framecounter,1)=val50;
    SSDP00575(framecounter,1)=val75;
    SSDP00590(framecounter,1)=val90;
    SSDP00595(framecounter,1)=val95;
    SSDP00598(framecounter,1)=val98;
    SSDP005100(framecounter,1)=val100;
    SSDP005Low(framecounter,1)=fraclow;
    SSDP005High(framecounter,1)=frachigh;
    SSDP005NaN(framecounter,1)=fracNaN;
  % Sea Salt Emission Bin 01 ikind=71
    data=SSEM001S.values(:,:,numtimeslice);
    fillvalue=SSEM001S.FillValue;
    %data(data==fillvalue)=NaN;
    SSEM001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSEM001Values,lowcutoff,highcutoff);
    SSEM00110(framecounter,1)=val10;
    SSEM00125(framecounter,1)=val25;
    SSEM00150(framecounter,1)=val50;
    SSEM00175(framecounter,1)=val75;
    SSEM00190(framecounter,1)=val90;
    SSEM00195(framecounter,1)=val95;
    SSEM00198(framecounter,1)=val98;
    SSEM001100(framecounter,1)=val100;
    SSEM001Low(framecounter,1)=fraclow;
    SSEM001High(framecounter,1)=frachigh;
    SSEM001NaN(framecounter,1)=fracNaN;
   % Sea Salt Emission Bin 02 ikind=72
    data=SSEM002S.values(:,:,numtimeslice);
    fillvalue=SSEM002S.FillValue;
    %data(data==fillvalue)=NaN;
    SSEM002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSEM002Values,lowcutoff,highcutoff);
    SSEM00210(framecounter,1)=val10;
    SSEM00225(framecounter,1)=val25;
    SSEM00250(framecounter,1)=val50;
    SSEM00275(framecounter,1)=val75;
    SSEM00290(framecounter,1)=val90;
    SSEM00295(framecounter,1)=val95;
    SSEM00298(framecounter,1)=val98;
    SSEM002100(framecounter,1)=val100;
    SSEM002Low(framecounter,1)=fraclow;
    SSEM002High(framecounter,1)=frachigh;
    SSEM002NaN(framecounter,1)=fracNaN;
   % Sea Salt Emission Bin 03 ikind=73
    data=SSEM003S.values(:,:,numtimeslice);
    fillvalue=SSEM003S.FillValue;
    %data(data==fillvalue)=NaN;
    SSEM003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSEM003Values,lowcutoff,highcutoff);
    SSEM00310(framecounter,1)=val10;
    SSEM00325(framecounter,1)=val25;
    SSEM00350(framecounter,1)=val50;
    SSEM00375(framecounter,1)=val75;
    SSEM00390(framecounter,1)=val90;
    SSEM00395(framecounter,1)=val95;
    SSEM00398(framecounter,1)=val98;
    SSEM003100(framecounter,1)=val100;
    SSEM003Low(framecounter,1)=fraclow;
    SSEM003High(framecounter,1)=frachigh;
    SSEM003NaN(framecounter,1)=fracNaN;
   % Sea Salt Emission Bin 04 ikind=74
    data=SSEM004S.values(:,:,numtimeslice);
    fillvalue=SSEM004S.FillValue;
    %data(data==fillvalue)=NaN;
    SSEM004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSEM004Values,lowcutoff,highcutoff);
    SSEM00410(framecounter,1)=val10;
    SSEM00425(framecounter,1)=val25;
    SSEM00450(framecounter,1)=val50;
    SSEM00475(framecounter,1)=val75;
    SSEM00490(framecounter,1)=val90;
    SSEM00495(framecounter,1)=val95;
    SSEM00498(framecounter,1)=val98;
    SSEM004100(framecounter,1)=val100;
    SSEM004Low(framecounter,1)=fraclow;
    SSEM004High(framecounter,1)=frachigh;
    SSEM004NaN(framecounter,1)=fracNaN;
  % Sea Salt Emission Bin 05 ikind=75
    data=SSEM005S.values(:,:,numtimeslice);
    fillvalue=SSEM005S.FillValue;
    %data(data==fillvalue)=NaN;
    SSEM005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSEM005Values,lowcutoff,highcutoff);
    SSEM00510(framecounter,1)=val10;
    SSEM00525(framecounter,1)=val25;
    SSEM00550(framecounter,1)=val50;
    SSEM00575(framecounter,1)=val75;
    SSEM00590(framecounter,1)=val90;
    SSEM00595(framecounter,1)=val95;
    SSEM00598(framecounter,1)=val98;
    SSEM005100(framecounter,1)=val100;
    SSEM005Low(framecounter,1)=fraclow;
    SSEM005High(framecounter,1)=frachigh;
    SSEM005NaN(framecounter,1)=fracNaN;
  % Sea Salt Extinction ikind=76
    data=SSEXTTFMS.values(:,:,numtimeslice);
    fillvalue=SSEXTTFMS.FillValue;
    %data(data==fillvalue)=NaN;
    SSEXTTFMValues=data;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSEXTTFMValues,lowcutoff,highcutoff);
    SSEXTTFM10(framecounter,1)=val10;
    SSEXTTFM25(framecounter,1)=val25;
    SSEXTTFM50(framecounter,1)=val50;
    SSEXTTFM75(framecounter,1)=val75;
    SSEXTTFM90(framecounter,1)=val90;
    SSEXTTFM95(framecounter,1)=val95;
    SSEXTTFM98(framecounter,1)=val98;
    SSEXTTFM100(framecounter,1)=val100;
    SSEXTTFMLow(framecounter,1)=fraclow;
    SSEXTTFMHigh(framecounter,1)=frachigh;
    SSEXTTFMNaN(framecounter,1)=fracNaN;
   % Sea Salt Scattering ikind=77
    data=SSSCATFMS.values(:,:,numtimeslice);
    fillvalue=SSSCATFMS.FillValue;
    %data(data==fillvalue)=NaN;
    SSSCATFMValues=data;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSCATFMValues,lowcutoff,highcutoff);
    SSSCATFM10(framecounter,1)=val10;
    SSSCATFM25(framecounter,1)=val25;
    SSSCATFM50(framecounter,1)=val50;
    SSSCATFM75(framecounter,1)=val75;
    SSSCATFM90(framecounter,1)=val90;
    SSSCATFM95(framecounter,1)=val95;
    SSSCATFM98(framecounter,1)=val98;
    SSSCATFM100(framecounter,1)=val100;
    SSSCATFMLow(framecounter,1)=fraclow;
    SSSCATFMHigh(framecounter,1)=frachigh;
    SSSCATFMNaN(framecounter,1)=fracNaN;
  % Sea Salt Sedimentation Bin 01 ikind=78
    data=SSSD001S.values(:,:,numtimeslice);
    fillvalue=SSSD001S.FillValue;
    %data(data==fillvalue)=NaN;
    SSSD001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSD001Values,lowcutoff,highcutoff);
    SSSD00110(framecounter,1)=val10;
    SSSD00125(framecounter,1)=val25;
    SSSD00150(framecounter,1)=val50;
    SSSD00175(framecounter,1)=val75;
    SSSD00190(framecounter,1)=val90;
    SSSD00195(framecounter,1)=val95;
    SSSD00198(framecounter,1)=val98;
    SSSD001100(framecounter,1)=val100;
    SSSD001Low(framecounter,1)=fraclow;
    SSSD001High(framecounter,1)=frachigh;
    SSSD001NaN(framecounter,1)=fracNaN;
  % Sea Salt Sedimentation Bin 02 ikind=79
    data=SSSD002S.values(:,:,numtimeslice);
    fillvalue=SSSD002S.FillValue;
    %data(data==fillvalue)=NaN;
    SSSD002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSD002Values,lowcutoff,highcutoff);
    SSSD00210(framecounter,1)=val10;
    SSSD00225(framecounter,1)=val25;
    SSSD00250(framecounter,1)=val50;
    SSSD00275(framecounter,1)=val75;
    SSSD00290(framecounter,1)=val90;
    SSSD00295(framecounter,1)=val95;
    SSSD00298(framecounter,1)=val98;
    SSSD002100(framecounter,1)=val100;
    SSSD002Low(framecounter,1)=fraclow;
    SSSD002High(framecounter,1)=frachigh;
    SSSD002NaN(framecounter,1)=fracNaN;
   % Sea Salt Sedimentation Bin 03 ikind=80
    data=SSSD003S.values(:,:,numtimeslice);
    fillvalue=SSSD003S.FillValue;
    %data(data==fillvalue)=NaN;
    SSSD003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSD003Values,lowcutoff,highcutoff);
    SSSD00310(framecounter,1)=val10;
    SSSD00325(framecounter,1)=val25;
    SSSD00350(framecounter,1)=val50;
    SSSD00375(framecounter,1)=val75;
    SSSD00390(framecounter,1)=val90;
    SSSD00395(framecounter,1)=val95;
    SSSD00398(framecounter,1)=val98;
    SSSD003100(framecounter,1)=val100;
    SSSD003Low(framecounter,1)=fraclow;
    SSSD003High(framecounter,1)=frachigh;
    SSSD003NaN(framecounter,1)=fracNaN;
  % Sea Salt Sedimentation Bin 04 ikind=81
    data=SSSD004S.values(:,:,numtimeslice);
    fillvalue=SSSD004S.FillValue;
    %data(data==fillvalue)=NaN;
    SSSD004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSD004Values,lowcutoff,highcutoff);
    SSSD00410(framecounter,1)=val10;
    SSSD00425(framecounter,1)=val25;
    SSSD00450(framecounter,1)=val50;
    SSSD00475(framecounter,1)=val75;
    SSSD00490(framecounter,1)=val90;
    SSSD00495(framecounter,1)=val95;
    SSSD00498(framecounter,1)=val98;
    SSSD004100(framecounter,1)=val100;
    SSSD004Low(framecounter,1)=fraclow;
    SSSD004High(framecounter,1)=frachigh;
    SSSD004NaN(framecounter,1)=fracNaN;
  % Sea Salt Sedimentation Bin 05 ikind=82
    data=SSSD005S.values(:,:,numtimeslice);
    fillvalue=SSSD005S.FillValue;
    %data(data==fillvalue)=NaN;
    SSSD005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSD005Values,lowcutoff,highcutoff);
    SSSD00510(framecounter,1)=val10;
    SSSD00525(framecounter,1)=val25;
    SSSD00550(framecounter,1)=val50;
    SSSD00575(framecounter,1)=val75;
    SSSD00590(framecounter,1)=val90;
    SSSD00595(framecounter,1)=val95;
    SSSD00598(framecounter,1)=val98;
    SSSD005100(framecounter,1)=val100;
    SSSD005Low(framecounter,1)=fraclow;
    SSSD005High(framecounter,1)=frachigh;
    SSSD005NaN(framecounter,1)=fracNaN;
  % Sea Salt Convective Scavenging Bin 01 ikind=83
    data=SSSV001S.values(:,:,numtimeslice);
    fillvalue=SSSV001S.FillValue;
    SSSV001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSV001Values,lowcutoff,highcutoff);
    SSSV00110(framecounter,1)=val10;
    SSSV00125(framecounter,1)=val25;
    SSSV00150(framecounter,1)=val50;
    SSSV00175(framecounter,1)=val75;
    SSSV00190(framecounter,1)=val90;
    SSSV00195(framecounter,1)=val95;
    SSSV00198(framecounter,1)=val98;
    SSSV001100(framecounter,1)=val100;
    SSSV001Low(framecounter,1)=fraclow;
    SSSV001High(framecounter,1)=frachigh;
    SSSV001NaN(framecounter,1)=fracNaN;
  % Sea Salt Convective Scavenging Bin 02 ikind=84
    data=SSSV002S.values(:,:,numtimeslice);
    fillvalue=SSSV002S.FillValue;
    SSSV002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSV002Values,lowcutoff,highcutoff);
    SSSV00210(framecounter,1)=val10;
    SSSV00225(framecounter,1)=val25;
    SSSV00250(framecounter,1)=val50;
    SSSV00275(framecounter,1)=val75;
    SSSV00290(framecounter,1)=val90;
    SSSV00295(framecounter,1)=val95;
    SSSV00298(framecounter,1)=val98;
    SSSV002100(framecounter,1)=val100;
    SSSV002Low(framecounter,1)=fraclow;
    SSSV002High(framecounter,1)=frachigh;
    SSSV002NaN(framecounter,1)=fracNaN;
  % Sea Salt Convective Scavenging Bin 03 ikind=85
    data=SSSV003S.values(:,:,numtimeslice);
    fillvalue=SSSV003S.FillValue;
    SSSV003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSV003Values,lowcutoff,highcutoff);
    SSSV00310(framecounter,1)=val10;
    SSSV00325(framecounter,1)=val25;
    SSSV00350(framecounter,1)=val50;
    SSSV00375(framecounter,1)=val75;
    SSSV00390(framecounter,1)=val90;
    SSSV00395(framecounter,1)=val95;
    SSSV00398(framecounter,1)=val98;
    SSSV003100(framecounter,1)=val100;
    SSSV003Low(framecounter,1)=fraclow;
    SSSV003High(framecounter,1)=frachigh;
    SSSV003NaN(framecounter,1)=fracNaN;
  % Sea Salt Convective Scavenging Bin 04 ikind=86
    data=SSSV004S.values(:,:,numtimeslice);
    fillvalue=SSSV004S.FillValue;
    SSSV004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSV004Values,lowcutoff,highcutoff);
    SSSV00410(framecounter,1)=val10;
    SSSV00425(framecounter,1)=val25;
    SSSV00450(framecounter,1)=val50;
    SSSV00475(framecounter,1)=val75;
    SSSV00490(framecounter,1)=val90;
    SSSV00495(framecounter,1)=val95;
    SSSV00498(framecounter,1)=val98;
    SSSV004100(framecounter,1)=val100;
    SSSV004Low(framecounter,1)=fraclow;
    SSSV004High(framecounter,1)=frachigh;
    SSSV004NaN(framecounter,1)=fracNaN;
  % Sea Salt Convective Scavenging Bin 05 ikind=87
    data=SSSV005S.values(:,:,numtimeslice);
    fillvalue=SSSV005S.FillValue;
    SSSV005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSSV005Values,lowcutoff,highcutoff);
    SSSV00510(framecounter,1)=val10;
    SSSV00525(framecounter,1)=val25;
    SSSV00550(framecounter,1)=val50;
    SSSV00575(framecounter,1)=val75;
    SSSV00590(framecounter,1)=val90;
    SSSV00595(framecounter,1)=val95;
    SSSV00598(framecounter,1)=val98;
    SSSV005100(framecounter,1)=val100;
    SSSV005Low(framecounter,1)=fraclow;
    SSSV005High(framecounter,1)=frachigh;
    SSSV005NaN(framecounter,1)=fracNaN;
  % Sea Salt Wet Deposition Bin 01 ikind=88
    data=SSWT001S.values(:,:,numtimeslice);
    fillvalue=SSWT001S.FillValue;
    SSWT001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSWT001Values,lowcutoff,highcutoff);
    SSWT00110(framecounter,1)=val10;
    SSWT00125(framecounter,1)=val25;
    SSWT00150(framecounter,1)=val50;
    SSWT00175(framecounter,1)=val75;
    SSWT00190(framecounter,1)=val90;
    SSWT00195(framecounter,1)=val95;
    SSWT00198(framecounter,1)=val98;
    SSWT001100(framecounter,1)=val100;
    SSWT001Low(framecounter,1)=fraclow;
    SSWT001High(framecounter,1)=frachigh;
    SSWT001NaN(framecounter,1)=fracNaN;
  % Sea Salt Wet Deposition Bin 02 ikind=89
    data=SSWT002S.values(:,:,numtimeslice);
    fillvalue=SSWT002S.FillValue;
    SSWT002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSWT002Values,lowcutoff,highcutoff);
    SSWT00210(framecounter,1)=val10;
    SSWT00225(framecounter,1)=val25;
    SSWT00250(framecounter,1)=val50;
    SSWT00275(framecounter,1)=val75;
    SSWT00290(framecounter,1)=val90;
    SSWT00295(framecounter,1)=val95;
    SSWT00298(framecounter,1)=val98;
    SSWT002100(framecounter,1)=val100;
    SSWT002Low(framecounter,1)=fraclow;
    SSWT002High(framecounter,1)=frachigh;
    SSWT002NaN(framecounter,1)=fracNaN;
  % Sea Salt Wet Deposition Bin 03 ikind=90
    data=SSWT003S.values(:,:,numtimeslice);
    fillvalue=SSWT003S.FillValue;
    SSWT003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSWT003Values,lowcutoff,highcutoff);
    SSWT00310(framecounter,1)=val10;
    SSWT00325(framecounter,1)=val25;
    SSWT00350(framecounter,1)=val50;
    SSWT00375(framecounter,1)=val75;
    SSWT00390(framecounter,1)=val90;
    SSWT00395(framecounter,1)=val95;
    SSWT00398(framecounter,1)=val98;
    SSWT003100(framecounter,1)=val100;
    SSWT003Low(framecounter,1)=fraclow;
    SSWT003High(framecounter,1)=frachigh;
    SSWT003NaN(framecounter,1)=fracNaN;
  % Sea Salt Wet Deposition Bin 04 ikind=91
    data=SSWT004S.values(:,:,numtimeslice);
    fillvalue=SSWT004S.FillValue;
    SSWT004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSWT004Values,lowcutoff,highcutoff);
    SSWT00410(framecounter,1)=val10;
    SSWT00425(framecounter,1)=val25;
    SSWT00450(framecounter,1)=val50;
    SSWT00475(framecounter,1)=val75;
    SSWT00490(framecounter,1)=val90;
    SSWT00495(framecounter,1)=val95;
    SSWT00498(framecounter,1)=val98;
    SSWT004100(framecounter,1)=val100;
    SSWT004Low(framecounter,1)=fraclow;
    SSWT004High(framecounter,1)=frachigh;
    SSWT004NaN(framecounter,1)=fracNaN;
  % Sea Salt Wet Deposition Bin 05 ikind=92
    data=SSWT005S.values(:,:,numtimeslice);
    fillvalue=SSWT005S.FillValue;
    SSWT005Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SSWT005Values,lowcutoff,highcutoff);
    SSWT00510(framecounter,1)=val10;
    SSWT00525(framecounter,1)=val25;
    SSWT00550(framecounter,1)=val50;
    SSWT00575(framecounter,1)=val75;
    SSWT00590(framecounter,1)=val90;
    SSWT00595(framecounter,1)=val95;
    SSWT00598(framecounter,1)=val98;
    SSWT005100(framecounter,1)=val100;
    SSWT005Low(framecounter,1)=fraclow;
    SSWT005High(framecounter,1)=frachigh;
    SSWT005NaN(framecounter,1)=fracNaN;
  % Sulfate Dry Deposition Bin 01 ikind=93
    data=SUDP001S.values(:,:,numtimeslice);
    fillvalue=SUDP001S.FillValue;
    SUDP001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUDP001Values,lowcutoff,highcutoff);
    SUDP00110(framecounter,1)=val10;
    SUDP00125(framecounter,1)=val25;
    SUDP00150(framecounter,1)=val50;
    SUDP00175(framecounter,1)=val75;
    SUDP00190(framecounter,1)=val90;
    SUDP00195(framecounter,1)=val95;
    SUDP00198(framecounter,1)=val98;
    SUDP001100(framecounter,1)=val100;
    SUDP001Low(framecounter,1)=fraclow;
    SUDP001High(framecounter,1)=frachigh;
    SUDP001NaN(framecounter,1)=fracNaN;
  % Sulfate Dry Deposition Bin 02 ikind=94
    data=SUDP002S.values(:,:,numtimeslice);
    fillvalue=SUDP002S.FillValue;
    SUDP002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUDP002Values,lowcutoff,highcutoff);
    SUDP00210(framecounter,1)=val10;
    SUDP00225(framecounter,1)=val25;
    SUDP00250(framecounter,1)=val50;
    SUDP00275(framecounter,1)=val75;
    SUDP00290(framecounter,1)=val90;
    SUDP00295(framecounter,1)=val95;
    SUDP00298(framecounter,1)=val98;
    SUDP002100(framecounter,1)=val100;
    SUDP002Low(framecounter,1)=fraclow;
    SUDP002High(framecounter,1)=frachigh;
    SUDP002NaN(framecounter,1)=fracNaN;
  % Sulfate Dry Deposition Bin 03 ikind=95
    data=SUDP003S.values(:,:,numtimeslice);
    fillvalue=SUDP003S.FillValue;
    SUDP003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUDP003Values,lowcutoff,highcutoff);
    SUDP00310(framecounter,1)=val10;
    SUDP00325(framecounter,1)=val25;
    SUDP00350(framecounter,1)=val50;
    SUDP00375(framecounter,1)=val75;
    SUDP00390(framecounter,1)=val90;
    SUDP00395(framecounter,1)=val95;
    SUDP00398(framecounter,1)=val98;
    SUDP003100(framecounter,1)=val100;
    SUDP003Low(framecounter,1)=fraclow;
    SUDP003High(framecounter,1)=frachigh;
    SUDP003NaN(framecounter,1)=fracNaN;
  % Sulfate Dry Deposition Bin 04 ikind=96
    data=SUDP004S.values(:,:,numtimeslice);
    fillvalue=SUDP004S.FillValue;
    SUDP004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUDP004Values,lowcutoff,highcutoff);
    SUDP00410(framecounter,1)=val10;
    SUDP00425(framecounter,1)=val25;
    SUDP00450(framecounter,1)=val50;
    SUDP00475(framecounter,1)=val75;
    SUDP00490(framecounter,1)=val90;
    SUDP00495(framecounter,1)=val95;
    SUDP00498(framecounter,1)=val98;
    SUDP004100(framecounter,1)=val100;
    SUDP004Low(framecounter,1)=fraclow;
    SUDP004High(framecounter,1)=frachigh;
    SUDP004NaN(framecounter,1)=fracNaN;
  % Sulfate Emission Bin 01 ikind=97
    data=SUEM001S.values(:,:,numtimeslice);
    fillvalue=SUEM001S.FillValue;
    SUEM001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUEM001Values,lowcutoff,highcutoff);
    SUEM00110(framecounter,1)=val10;
    SUEM00125(framecounter,1)=val25;
    SUEM00150(framecounter,1)=val50;
    SUEM00175(framecounter,1)=val75;
    SUEM00190(framecounter,1)=val90;
    SUEM00195(framecounter,1)=val95;
    SUEM00198(framecounter,1)=val98;
    SUEM001100(framecounter,1)=val100;
    SUEM001Low(framecounter,1)=fraclow;
    SUEM001High(framecounter,1)=frachigh;
    SUEM001NaN(framecounter,1)=fracNaN;
  % Sulfate Emission Bin 02 ikind=98
    data=SUEM002S.values(:,:,numtimeslice);
    fillvalue=SUEM002S.FillValue;
    SUEM002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUEM002Values,lowcutoff,highcutoff);
    SUEM00210(framecounter,1)=val10;
    SUEM00225(framecounter,1)=val25;
    SUEM00250(framecounter,1)=val50;
    SUEM00275(framecounter,1)=val75;
    SUEM00290(framecounter,1)=val90;
    SUEM00295(framecounter,1)=val95;
    SUEM00298(framecounter,1)=val98;
    SUEM002100(framecounter,1)=val100;
    SUEM002Low(framecounter,1)=fraclow;
    SUEM002High(framecounter,1)=frachigh;
    SUEM002NaN(framecounter,1)=fracNaN;
  % Sulfate Emission Bin 03 ikind=99
    data=SUEM003S.values(:,:,numtimeslice);
    fillvalue=SUEM003S.FillValue;
    SUEM003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUEM003Values,lowcutoff,highcutoff);
    SUEM00310(framecounter,1)=val10;
    SUEM00325(framecounter,1)=val25;
    SUEM00350(framecounter,1)=val50;
    SUEM00375(framecounter,1)=val75;
    SUEM00390(framecounter,1)=val90;
    SUEM00395(framecounter,1)=val95;
    SUEM00398(framecounter,1)=val98;
    SUEM003100(framecounter,1)=val100;
    SUEM003Low(framecounter,1)=fraclow;
    SUEM003High(framecounter,1)=frachigh;
    SUEM003NaN(framecounter,1)=fracNaN;
  % Sulfate Emission Bin 04 ikind=100
    data=SUEM004S.values(:,:,numtimeslice);
    fillvalue=SUEM004S.FillValue;
    SUEM004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUEM004Values,lowcutoff,highcutoff);
    SUEM00410(framecounter,1)=val10;
    SUEM00425(framecounter,1)=val25;
    SUEM00450(framecounter,1)=val50;
    SUEM00475(framecounter,1)=val75;
    SUEM00490(framecounter,1)=val90;
    SUEM00495(framecounter,1)=val95;
    SUEM00498(framecounter,1)=val98;
    SUEM004100(framecounter,1)=val100;
    SUEM004Low(framecounter,1)=fraclow;
    SUEM004High(framecounter,1)=frachigh;
    SUEM004NaN(framecounter,1)=fracNaN;
  % MSA Prod Fromm DMS Oxdation ikind=101
    data=SUPMSAS.values(:,:,numtimeslice);
    fillvalue=SUPMSAS.FillValue;
    SUPMSAValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUPMSAValues,lowcutoff,highcutoff);
    SUPMSA10(framecounter,1)=val10;
    SUPMSA25(framecounter,1)=val25;
    SUPMSA50(framecounter,1)=val50;
    SUPMSA75(framecounter,1)=val75;
    SUPMSA90(framecounter,1)=val90;
    SUPMSA95(framecounter,1)=val95;
    SUPMSA98(framecounter,1)=val98;
    SUPMSA100(framecounter,1)=val100;
    SUPMSALow(framecounter,1)=fraclow;
    SUPMSAHigh(framecounter,1)=frachigh;
    SUPMSANaN(framecounter,1)=fracNaN;
  % SO2 Prod Fromm DMS Oxdation ikind=102
    data=SUPSO2S.values(:,:,numtimeslice);
    fillvalue=SUPSO2S.FillValue;
    SUPSO2Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUPSO2Values,lowcutoff,highcutoff);
    SUPSO210(framecounter,1)=val10;
    SUPSO225(framecounter,1)=val25;
    SUPSO250(framecounter,1)=val50;
    SUPSO275(framecounter,1)=val75;
    SUPSO290(framecounter,1)=val90;
    SUPSO295(framecounter,1)=val95;
    SUPSO298(framecounter,1)=val98;
    SUPSO2100(framecounter,1)=val100;
    SUPSO2Low(framecounter,1)=fraclow;
    SUPSO2High(framecounter,1)=frachigh;
    SUPSO2NaN(framecounter,1)=fracNaN;
  % SO4 Prod Fromm DMS Oxdation ikind=103
    data=SUPSO4AQS.values(:,:,numtimeslice);
    fillvalue=SUPSO4AQS.FillValue;
    SUPSO4AQValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUPSO4AQValues,lowcutoff,highcutoff);
    SUPSO4AQ10(framecounter,1)=val10;
    SUPSO4AQ25(framecounter,1)=val25;
    SUPSO4AQ50(framecounter,1)=val50;
    SUPSO4AQ75(framecounter,1)=val75;
    SUPSO4AQ90(framecounter,1)=val90;
    SUPSO4AQ95(framecounter,1)=val95;
    SUPSO4AQ98(framecounter,1)=val98;
    SUPSO4AQ100(framecounter,1)=val100;
    SUPSO4AQLow(framecounter,1)=fraclow;
    SUPSO4AQHigh(framecounter,1)=frachigh;
    SUPSO4AQNaN(framecounter,1)=fracNaN;
  % SO4 Prod From SO2 Gaseous Oxidation ikind=104
    data=SUPSO4GS.values(:,:,numtimeslice);
    fillvalue=SUPSO4GS.FillValue;
    SUPSO4GValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUPSO4GValues,lowcutoff,highcutoff);
    SUPSO4G10(framecounter,1)=val10;
    SUPSO4G25(framecounter,1)=val25;
    SUPSO4G50(framecounter,1)=val50;
    SUPSO4G75(framecounter,1)=val75;
    SUPSO4G90(framecounter,1)=val90;
    SUPSO4G95(framecounter,1)=val95;
    SUPSO4G98(framecounter,1)=val98;
    SUPSO4G100(framecounter,1)=val100;
    SUPSO4GLow(framecounter,1)=fraclow;
    SUPSO4GHigh(framecounter,1)=frachigh;
    SUPSO4GNaN(framecounter,1)=fracNaN;
  % SO4 Prod From SO2 Aqueous Oxidation ikind=105
    data=SUPSO4WTS.values(:,:,numtimeslice);
    fillvalue=SUPSO4WTS.FillValue;
    SUPSO4WTValues=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUPSO4WTValues,lowcutoff,highcutoff);
    SUPSO4WT10(framecounter,1)=val10;
    SUPSO4WT25(framecounter,1)=val25;
    SUPSO4WT50(framecounter,1)=val50;
    SUPSO4WT75(framecounter,1)=val75;
    SUPSO4WT90(framecounter,1)=val90;
    SUPSO4WT95(framecounter,1)=val95;
    SUPSO4WT98(framecounter,1)=val98;
    SUPSO4WT100(framecounter,1)=val100;
    SUPSO4WTLow(framecounter,1)=fraclow;
    SUPSO4WTHigh(framecounter,1)=frachigh;
    SUPSO4WTNaN(framecounter,1)=fracNaN;
  % Sulfate Settling Bin 001 ikind=106
    data=SUSD001S.values(:,:,numtimeslice);
    fillvalue=SUSD001S.FillValue;
    SUSD001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSD001Values,lowcutoff,highcutoff);
    SUSD00110(framecounter,1)=val10;
    SUSD00125(framecounter,1)=val25;
    SUSD00150(framecounter,1)=val50;
    SUSD00175(framecounter,1)=val75;
    SUSD00190(framecounter,1)=val90;
    SUSD00195(framecounter,1)=val95;
    SUSD00198(framecounter,1)=val98;
    SUSD001100(framecounter,1)=val100;
    SUSD001Low(framecounter,1)=fraclow;
    SUSD001High(framecounter,1)=frachigh;
    SUSD001NaN(framecounter,1)=fracNaN;
  % Sulfate Settling Bin 002 ikind=107
    data=SUSD002S.values(:,:,numtimeslice);
    fillvalue=SUSD002S.FillValue;
    SUSD002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSD002Values,lowcutoff,highcutoff);
    SUSD00210(framecounter,1)=val10;
    SUSD00225(framecounter,1)=val25;
    SUSD00250(framecounter,1)=val50;
    SUSD00275(framecounter,1)=val75;
    SUSD00290(framecounter,1)=val90;
    SUSD00295(framecounter,1)=val95;
    SUSD00298(framecounter,1)=val98;
    SUSD002100(framecounter,1)=val100;
    SUSD002Low(framecounter,1)=fraclow;
    SUSD002High(framecounter,1)=frachigh;
    SUSD002NaN(framecounter,1)=fracNaN;
  % Sulfate Settling Bin 003 ikind=108
    data=SUSD003S.values(:,:,numtimeslice);
    fillvalue=SUSD003S.FillValue;
    SUSD003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSD003Values,lowcutoff,highcutoff);
    SUSD00310(framecounter,1)=val10;
    SUSD00325(framecounter,1)=val25;
    SUSD00350(framecounter,1)=val50;
    SUSD00375(framecounter,1)=val75;
    SUSD00390(framecounter,1)=val90;
    SUSD00395(framecounter,1)=val95;
    SUSD00398(framecounter,1)=val98;
    SUSD003100(framecounter,1)=val100;
    SUSD003Low(framecounter,1)=fraclow;
    SUSD003High(framecounter,1)=frachigh;
    SUSD003NaN(framecounter,1)=fracNaN;
  % Sulfate Settling Bin 004 ikind=109
    data=SUSD004S.values(:,:,numtimeslice);
    fillvalue=SUSD004S.FillValue;
    SUSD004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSD004Values,lowcutoff,highcutoff);
    SUSD00410(framecounter,1)=val10;
    SUSD00425(framecounter,1)=val25;
    SUSD00450(framecounter,1)=val50;
    SUSD00475(framecounter,1)=val75;
    SUSD00490(framecounter,1)=val90;
    SUSD00495(framecounter,1)=val95;
    SUSD00498(framecounter,1)=val98;
    SUSD004100(framecounter,1)=val100;
    SUSD004Low(framecounter,1)=fraclow;
    SUSD004High(framecounter,1)=frachigh;
    SUSD004NaN(framecounter,1)=fracNaN;
  % Sulfate Convective Scavenging Bin 001 ikind=110
    data=SUSV001S.values(:,:,numtimeslice);
    fillvalue=SUSV001S.FillValue;
    SUSV001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSV001Values,lowcutoff,highcutoff);
    SUSV00110(framecounter,1)=val10;
    SUSV00125(framecounter,1)=val25;
    SUSV00150(framecounter,1)=val50;
    SUSV00175(framecounter,1)=val75;
    SUSV00190(framecounter,1)=val90;
    SUSV00195(framecounter,1)=val95;
    SUSV00198(framecounter,1)=val98;
    SUSV001100(framecounter,1)=val100;
    SUSV001Low(framecounter,1)=fraclow;
    SUSV001High(framecounter,1)=frachigh;
    SUSV001NaN(framecounter,1)=fracNaN;
  % Sulfate Convective Scavenging Bin 002 ikind=111
    data=SUSV002S.values(:,:,numtimeslice);
    fillvalue=SUSV002S.FillValue;
    SUSV002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSV002Values,lowcutoff,highcutoff);
    SUSV00210(framecounter,1)=val10;
    SUSV00225(framecounter,1)=val25;
    SUSV00250(framecounter,1)=val50;
    SUSV00275(framecounter,1)=val75;
    SUSV00290(framecounter,1)=val90;
    SUSV00295(framecounter,1)=val95;
    SUSV00298(framecounter,1)=val98;
    SUSV002100(framecounter,1)=val100;
    SUSV002Low(framecounter,1)=fraclow;
    SUSV002High(framecounter,1)=frachigh;
    SUSV002NaN(framecounter,1)=fracNaN;
  % Sulfate Convective Scavenger Bin 003 ikind=112
    data=SUSV003S.values(:,:,numtimeslice);
    fillvalue=SUSV003S.FillValue;
    SUSV003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSV003Values,lowcutoff,highcutoff);
    SUSV00310(framecounter,1)=val10;
    SUSV00325(framecounter,1)=val25;
    SUSV00350(framecounter,1)=val50;
    SUSV00375(framecounter,1)=val75;
    SUSV00390(framecounter,1)=val90;
    SUSV00395(framecounter,1)=val95;
    SUSV00398(framecounter,1)=val98;
    SUSV003100(framecounter,1)=val100;
    SUSV003Low(framecounter,1)=fraclow;
    SUSV003High(framecounter,1)=frachigh;
    SUSV003NaN(framecounter,1)=fracNaN;
  % Sulfate Convective Scavenger Bin 004 ikind=113
    data=SUSV004S.values(:,:,numtimeslice);
    fillvalue=SUSV004S.FillValue;
    SUSV004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUSV004Values,lowcutoff,highcutoff);
    SUSV00410(framecounter,1)=val10;
    SUSV00425(framecounter,1)=val25;
    SUSV00450(framecounter,1)=val50;
    SUSV00475(framecounter,1)=val75;
    SUSV00490(framecounter,1)=val90;
    SUSV00495(framecounter,1)=val95;
    SUSV00498(framecounter,1)=val98;
    SUSV004100(framecounter,1)=val100;
    SUSV004Low(framecounter,1)=fraclow;
    SUSV004High(framecounter,1)=frachigh;
    SUSV004NaN(framecounter,1)=fracNaN;
  % Sulfate Wet Deposition Bin 001 ikind=114
    data=SUWT001S.values(:,:,numtimeslice);
    fillvalue=SUWT001S.FillValue;
    SUWT001Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUWT001Values,lowcutoff,highcutoff);
    SUWT00110(framecounter,1)=val10;
    SUWT00125(framecounter,1)=val25;
    SUWT00150(framecounter,1)=val50;
    SUWT00175(framecounter,1)=val75;
    SUWT00190(framecounter,1)=val90;
    SUWT00195(framecounter,1)=val95;
    SUWT00198(framecounter,1)=val98;
    SUWT001100(framecounter,1)=val100;
    SUWT001Low(framecounter,1)=fraclow;
    SUWT001High(framecounter,1)=frachigh;
    SUWT001NaN(framecounter,1)=fracNaN;
  % Sulfate Wet Deposition Bin 002 ikind=115
    data=SUWT002S.values(:,:,numtimeslice);
    fillvalue=SUWT002S.FillValue;
    SUWT002Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUWT002Values,lowcutoff,highcutoff);
    SUWT00210(framecounter,1)=val10;
    SUWT00225(framecounter,1)=val25;
    SUWT00250(framecounter,1)=val50;
    SUWT00275(framecounter,1)=val75;
    SUWT00290(framecounter,1)=val90;
    SUWT00295(framecounter,1)=val95;
    SUWT00298(framecounter,1)=val98;
    SUWT002100(framecounter,1)=val100;
    SUWT002Low(framecounter,1)=fraclow;
    SUWT002High(framecounter,1)=frachigh;
    SUWT002NaN(framecounter,1)=fracNaN;
  % Sulfate Wet Deposition Bin 003 ikind=116
    data=SUWT003S.values(:,:,numtimeslice);
    fillvalue=SUWT003S.FillValue;
    SUWT003Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUWT003Values,lowcutoff,highcutoff);
    SUWT00310(framecounter,1)=val10;
    SUWT00325(framecounter,1)=val25;
    SUWT00350(framecounter,1)=val50;
    SUWT00375(framecounter,1)=val75;
    SUWT00390(framecounter,1)=val90;
    SUWT00395(framecounter,1)=val95;
    SUWT00398(framecounter,1)=val98;
    SUWT003100(framecounter,1)=val100;
    SUWT003Low(framecounter,1)=fraclow;
    SUWT003High(framecounter,1)=frachigh;
    SUWT003NaN(framecounter,1)=fracNaN;
  % Sulfate Wet Deposition Bin 004 ikind=117
    data=SUWT004S.values(:,:,numtimeslice);
    fillvalue=SUWT004S.FillValue;
    SUWT004Values=data/1E-15;
    lowcutoff=0;
    highcutoff=15000000;
    [val10,val25,val50,val75,val90,val95,val98,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev2(SUWT004Values,lowcutoff,highcutoff);
    SUWT00410(framecounter,1)=val10;
    SUWT00425(framecounter,1)=val25;
    SUWT00450(framecounter,1)=val50;
    SUWT00475(framecounter,1)=val75;
    SUWT00490(framecounter,1)=val90;
    SUWT00495(framecounter,1)=val95;
    SUWT00498(framecounter,1)=val98;
    SUWT004100(framecounter,1)=val100;
    SUWT004Low(framecounter,1)=fraclow;
    SUWT004High(framecounter,1)=frachigh;
    SUWT004NaN(framecounter,1)=fracNaN;

end
if(framecounter==1)
    yd=str2double(YearMonthStr(1:4));
    md=str2double(YearMonthStr(5:6));
    dd=1;
    hd=double(numtimeslice-1);
    mind=30;
    secd=0;
end
%% Set up an Array to hold dust data over all bins 
if(framecounter==1)
%% This first set is for the Dry Dust data
    DustEmissionAllBins=zeros(numSelectedFiles,5);
    WDustEmissionAllBins=zeros(numSelectedFiles,5);
    SumDEmiss=zeros(numSelectedFiles,1);
    SumWEmiss=zeros(numSelectedFiles,1);
    DustDepositionAllBins=zeros(numSelectedFiles,5);
    WDustDepositionAllBins=zeros(numSelectedFiles,5);
    DustSedimentationAllBins=zeros(numSelectedFiles,5);
    WDustSedimentationAllBins=zeros(numSelectedFiles,5);
    SumDDepo=zeros(numSelectedFiles,1);
    SumWDepo=zeros(numSelectedFiles,1);
    SumDSed=zeros(numSelectedFiles,1);
    SumWSed=zeros(numSelectedFiles,1);
    DUEMSum=zeros(numSelectedFiles,1);
    DUEMSum1=zeros(numSelectedFiles,1);
    DUEMSum2=zeros(numSelectedFiles,1);
    DUEMSum3=zeros(numSelectedFiles,1);
    DUEMSum4=zeros(numSelectedFiles,1);
    DUEMSum5=zeros(numSelectedFiles,1);
    DUDPSum=zeros(numSelectedFiles,1);
    DUDPSum1=zeros(numSelectedFiles,1);
    DUDPSum2=zeros(numSelectedFiles,1);
    DUDPSum3=zeros(numSelectedFiles,1);
    DUDPSum4=zeros(numSelectedFiles,1);
    DUDPSum5=zeros(numSelectedFiles,1);
% Now load the desired mask and make it the working mask
    Merra2WorkingMask=Merra2WorkingMask1;
    duststr=strcat('Cumilitive Dust Emission Will Be Calculated For-',DustROICountry);
    fprintf(fid,'\n');
    fprintf(fid,'%s\n',duststr);
    fprintf(fid,'\n');
    ab=1;
%% This next set is for the Sea Salt items-initialize them here
    SeaSaltDryDepAllBins=zeros(numSelectedFiles,5);
    WSeaSaltDryDepAllBins=zeros(numSelectedFiles,1);
    SeaSaltSumDepROI6=zeros(numSelectedFiles,1);
    WSeaSaltSumDepROI6=zeros(numSelectedFiles,1);
    SeaSaltSumDepROI7=zeros(numSelectedFiles,1);
    WSeaSaltSumDepROI7=zeros(numSelectedFiles,1);
    SeaSaltSumDepROI8=zeros(numSelectedFiles,1);
    WSeaSaltSumDepROI8=zeros(numSelectedFiles,1);
    SeaSaltSumDepROI9=zeros(numSelectedFiles,1);
    WSeaSaltSumDepROI9=zeros(numSelectedFiles,1);
    SeaSaltSumDepROI10=zeros(numSelectedFiles,1);
    WSeaSaltSumDepROI10=zeros(numSelectedFiles,1);
end
%% Add in Data for this frame and time for the selected country for each frame of data
if(iDustCalc>0)
        data1sum=zeros(576,361);
        data2sum=zeros(576,361);
        data3sum=zeros(576,361);
        data4sum=zeros(576,361);
        data5sum=zeros(576,361);
        data11sum=zeros(576,361);
        data12sum=zeros(576,361);
        data13sum=zeros(576,361);
        data14sum=zeros(576,361);
        data15sum=zeros(576,361);
    for kk=1:24 % Loop over the hourly data
        data1=DUEM001S.values(:,:,kk);% Dust Emissivity for one grid point at one time
        data2=DUEM002S.values(:,:,kk);
        data3=DUEM003S.values(:,:,kk);
        data4=DUEM004S.values(:,:,kk);
        data5=DUEM005S.values(:,:,kk);
        data1sum=data1sum+data1*3600;
        data2sum=data2sum+data2*3600;
        data3sum=data3sum+data3*3600;
        data4sum=data4sum+data4*3600;
        data5sum=data5sum+data5*3600;
        data11=DUDP001S.values(:,:,kk);% Dry Dust Deposition Bins 1 thru 5
        data12=DUDP002S.values(:,:,kk);
        data13=DUDP003S.values(:,:,kk);
        data14=DUDP004S.values(:,:,kk);
        data15=DUDP005S.values(:,:,kk);
        data11sum=data11sum+data11*3600;
        data12sum=data12sum+data12*3600;
        data13sum=data13sum+data13*3600;
        data14sum=data14sum+data14*3600;
        data15sum=data15sum+data15*3600;
        data21=DUSD001S.values(:,:,kk);% Dry Dust Sedimentation Bins 1 thru 5
        data22=DUSD002S.values(:,:,kk);
        data23=DUSD003S.values(:,:,kk);
        data24=DUSD004S.values(:,:,kk);
        data25=DUSD005S.values(:,:,kk);
        data1a=(1E3/1E12)*data1.*Merra2WorkingMask;% Use the mask to limit it to the target country and convert to Tgm
        data2a=(1E3/1E12)*data2.*Merra2WorkingMask;
        data3a=(1E3/1E12)*data3.*Merra2WorkingMask;
        data4a=(1E3/1E12)*data4.*Merra2WorkingMask;
        data5a=(1E3/1E12)*data5.*Merra2WorkingMask;
        data11a=(1E3/1E12)*data11.*Merra2WorkingMask;% Use the mask to limit it to the target country and convert to Tgm
        data12a=(1E3/1E12)*data12.*Merra2WorkingMask;
        data13a=(1E3/1E12)*data13.*Merra2WorkingMask;
        data14a=(1E3/1E12)*data14.*Merra2WorkingMask;
        data15a=(1E3/1E12)*data15.*Merra2WorkingMask;
        data21a=(1E3/1E12)*data21.*Merra2WorkingMask;% Use the mask to limit it to the target country and convert to Tgm
        data22a=(1E3/1E12)*data22.*Merra2WorkingMask;
        data23a=(1E3/1E12)*data23.*Merra2WorkingMask;
        data24a=(1E3/1E12)*data24.*Merra2WorkingMask;
        data25a=(1E3/1E12)*data25.*Merra2WorkingMask;
        data1aw=(1E3/1E12)*data1;% Convert from Kg to Tgm-terra grams w stand for entire world
        data2aw=(1E3/1E12)*data2;
        data3aw=(1E3/1E12)*data3;
        data4aw=1E3*data4/1E12;
        data5aw=1E3*data5/1E12;
        data11aw=(1E3/1E12)*data11;% Convert from Kg to Tgm-terra grams w stand for entire world
        data12aw=(1E3/1E12)*data12;
        data13aw=(1E3/1E12)*data13;
        data14aw=(1E3/1E12)*data14;
        data15aw=(1E3/1E12)*data15;
        data21aw=(1E3/1E12)*data21;% Convert from Kg to Tgm-terra grams w stand for entire world
        data22aw=(1E3/1E12)*data22;
        data23aw=(1E3/1E12)*data23;
        data24aw=(1E3/1E12)*data24;
        data25aw=(1E3/1E12)*data25;
        data1b=zeros(576,361);
        data2b=zeros(576,361);
        data3b=zeros(576,361);
        data4b=zeros(576,361);
        data5b=zeros(576,361);
        data11b=zeros(576,361);% ROI Country
        data12b=zeros(576,361);
        data13b=zeros(576,361);
        data14b=zeros(576,361);
        data15b=zeros(576,361);
        data21b=zeros(576,361);% ROI Country
        data22b=zeros(576,361);
        data23b=zeros(576,361);
        data24b=zeros(576,361);
        data25b=zeros(576,361);
        data1bw=zeros(576,361);% Whole World
        data2bw=zeros(576,361);
        data3bw=zeros(576,361);
        data4bw=zeros(576,361);
        data5bw=zeros(576,361);
        data11bw=zeros(576,361);% Whole World
        data12bw=zeros(576,361);
        data13bw=zeros(576,361);
        data14bw=zeros(576,361);
        data15bw=zeros(576,361);
        data21bw=zeros(576,361);% Whole World
        data22bw=zeros(576,361);
        data23bw=zeros(576,361);
        data24bw=zeros(576,361);
        data25bw=zeros(576,361);
        sumarea=0;
        ihits=0;
        for jj=1:361
            nowArea=1E6*RasterAreas(jj,1);% convert km^2 to m^2
            for ii=1:576
                if(Merra2WorkingMask(ii,jj)>0)
                    sumarea=sumarea+nowArea;
                    ihits=ihits+1;
                end
                data1b(ii,jj)=data1a(ii,jj)*nowArea;
                data2b(ii,jj)=data2a(ii,jj)*nowArea;
                data3b(ii,jj)=data3a(ii,jj)*nowArea;
                data4b(ii,jj)=data4a(ii,jj)*nowArea;
                data5b(ii,jj)=data5a(ii,jj)*nowArea;
                data1bw(ii,jj)=data1aw(ii,jj)*nowArea;
                data2bw(ii,jj)=data2aw(ii,jj)*nowArea;
                data3bw(ii,jj)=data3aw(ii,jj)*nowArea;
                data4bw(ii,jj)=data4aw(ii,jj)*nowArea;
                data5bw(ii,jj)=data5aw(ii,jj)*nowArea;
                data11b(ii,jj)=data11a(ii,jj)*nowArea;
                data12b(ii,jj)=data12a(ii,jj)*nowArea;
                data13b(ii,jj)=data13a(ii,jj)*nowArea;
                data14b(ii,jj)=data14a(ii,jj)*nowArea;
                data15b(ii,jj)=data15a(ii,jj)*nowArea;
                data11bw(ii,jj)=data11aw(ii,jj)*nowArea;
                data12bw(ii,jj)=data12aw(ii,jj)*nowArea;
                data13bw(ii,jj)=data13aw(ii,jj)*nowArea;
                data14bw(ii,jj)=data14aw(ii,jj)*nowArea;
                data15bw(ii,jj)=data15aw(ii,jj)*nowArea;
                data21b(ii,jj)=data21a(ii,jj)*nowArea;
                data22b(ii,jj)=data22a(ii,jj)*nowArea;
                data23b(ii,jj)=data23a(ii,jj)*nowArea;
                data24b(ii,jj)=data24a(ii,jj)*nowArea;
                data25b(ii,jj)=data25a(ii,jj)*nowArea;
                data21bw(ii,jj)=data21aw(ii,jj)*nowArea;
                data22bw(ii,jj)=data22aw(ii,jj)*nowArea;
                data23bw(ii,jj)=data23aw(ii,jj)*nowArea;
                data24bw(ii,jj)=data24aw(ii,jj)*nowArea;
                data25bw(ii,jj)=data25aw(ii,jj)*nowArea;
            end

        end
        data1c=sum(sum(data1b));
        data2c=sum(sum(data2b));
        data3c=sum(sum(data3b));
        data4c=sum(sum(data4b));
        data5c=sum(sum(data5b));
        data1cw=sum(sum(data1bw));
        data2cw=sum(sum(data2bw));
        data3cw=sum(sum(data3bw));
        data4cw=sum(sum(data4bw));
        data5cw=sum(sum(data5bw));
        data11c=sum(sum(data11b));
        data12c=sum(sum(data12b));
        data13c=sum(sum(data13b));
        data14c=sum(sum(data14b));
        data15c=sum(sum(data15b));
        data11cw=sum(sum(data11bw));
        data12cw=sum(sum(data12bw));
        data13cw=sum(sum(data13bw));
        data14cw=sum(sum(data14bw));
        data15cw=sum(sum(data15bw));
        data21c=sum(sum(data21b));
        data22c=sum(sum(data22b));
        data23c=sum(sum(data23b));
        data24c=sum(sum(data24b));
        data25c=sum(sum(data25b));
        data21cw=sum(sum(data21bw));
        data22cw=sum(sum(data22bw));
        data23cw=sum(sum(data23bw));
        data24cw=sum(sum(data24bw));
        data25cw=sum(sum(data25bw));
        DustEmissionAllBins(framecounter,1)=DustEmissionAllBins(framecounter,1)+3600*data1c;% Sum up the rate for 1 hr for target country
        DustEmissionAllBins(framecounter,2)=DustEmissionAllBins(framecounter,2)+3600*data2c;
        DustEmissionAllBins(framecounter,3)=DustEmissionAllBins(framecounter,3)+3600*data3c;
        DustEmissionAllBins(framecounter,4)=DustEmissionAllBins(framecounter,4)+3600*data4c;
        DustEmissionAllBins(framecounter,5)=DustEmissionAllBins(framecounter,5)+3600*data5c;
        WDustEmissionAllBins(framecounter,1)=WDustEmissionAllBins(framecounter,1)+3600*data1cw;% Sum up the rate for 1 hr for entire world
        WDustEmissionAllBins(framecounter,2)=WDustEmissionAllBins(framecounter,2)+3600*data2cw;
        WDustEmissionAllBins(framecounter,3)=WDustEmissionAllBins(framecounter,3)+3600*data3cw;
        WDustEmissionAllBins(framecounter,4)=WDustEmissionAllBins(framecounter,4)+3600*data4cw;
        WDustEmissionAllBins(framecounter,5)=WDustEmissionAllBins(framecounter,5)+3600*data5cw;
        ROIArea=sumarea;
        ROIPts=ihits;
        SumDEmiss(framecounter,1)=DustEmissionAllBins(framecounter,1)+DustEmissionAllBins(framecounter,2)+DustEmissionAllBins(framecounter,3);
        SumDEmiss(framecounter,1)=SumDEmiss(framecounter,1)+DustEmissionAllBins(framecounter,4)+DustEmissionAllBins(framecounter,5);
        SumWEmiss(framecounter,1)=WDustEmissionAllBins(framecounter,1)+WDustEmissionAllBins(framecounter,2)+WDustEmissionAllBins(framecounter,3);
        SumWEmiss(framecounter,1)=SumWEmiss(framecounter,1)+WDustEmissionAllBins(framecounter,4)+WDustEmissionAllBins(framecounter,5);
        DustDepositionAllBins(framecounter,1)=DustDepositionAllBins(framecounter,1)+3600*data11c; % Sum up the rate for 1 hr for target country
        DustDepositionAllBins(framecounter,2)=DustDepositionAllBins(framecounter,2)+3600*data12c;
        DustDepositionAllBins(framecounter,3)=DustDepositionAllBins(framecounter,3)+3600*data13c;
        DustDepositionAllBins(framecounter,4)=DustDepositionAllBins(framecounter,4)+3600*data14c;
        DustDepositionAllBins(framecounter,5)=DustDepositionAllBins(framecounter,5)+3600*data15c;
        WDustDepositionAllBins(framecounter,1)=WDustDepositionAllBins(framecounter,1)+3600*data11cw; % Sum up the rate for 1 hr for target country
        WDustDepositionAllBins(framecounter,2)=WDustDepositionAllBins(framecounter,2)+3600*data12cw;
        WDustDepositionAllBins(framecounter,3)=WDustDepositionAllBins(framecounter,3)+3600*data13cw;
        WDustDepositionAllBins(framecounter,4)=WDustDepositionAllBins(framecounter,4)+3600*data14cw;
        WDustDepositionAllBins(framecounter,5)=WDustDepositionAllBins(framecounter,5)+3600*data15cw;
        SumDDepo(framecounter,1)=DustDepositionAllBins(framecounter,1)+DustDepositionAllBins(framecounter,2)+DustDepositionAllBins(framecounter,3);
        SumDDepo(framecounter,1)=SumDDepo(framecounter,1)+DustDepositionAllBins(framecounter,4)+DustDepositionAllBins(framecounter,5);
        SumWDepo(framecounter,1)=WDustDepositionAllBins(framecounter,1)+WDustDepositionAllBins(framecounter,2)+WDustDepositionAllBins(framecounter,3);
        SumWDepo(framecounter,1)=SumWDepo(framecounter,1)+WDustDepositionAllBins(framecounter,4)+WDustDepositionAllBins(framecounter,5);
        DustSedimentationAllBins(framecounter,1)=DustSedimentationAllBins(framecounter,1)+3600*data21c; % Sum up the rate for 1 hr for target country
        DustSedimentationAllBins(framecounter,2)=DustSedimentationAllBins(framecounter,2)+3600*data22c;
        DustSedimentationAllBins(framecounter,3)=DustSedimentationAllBins(framecounter,3)+3600*data23c;
        DustSedimentationAllBins(framecounter,4)=DustSedimentationAllBins(framecounter,4)+3600*data24c;
        DustSedimentationAllBins(framecounter,5)=DustSedimentationAllBins(framecounter,5)+3600*data25c;
        WDustSedimentationAllBins(framecounter,1)=WDustSedimentationAllBins(framecounter,1)+3600*data21cw; % Sum up the rate for 1 hr for target country
        WDustSedimentationAllBins(framecounter,2)=WDustSedimentationAllBins(framecounter,2)+3600*data22cw;
        WDustSedimentationAllBins(framecounter,3)=WDustSedimentationAllBins(framecounter,3)+3600*data23cw;
        WDustSedimentationAllBins(framecounter,4)=WDustSedimentationAllBins(framecounter,4)+3600*data24cw;
        WDustSedimentationAllBins(framecounter,5)=WDustSedimentationAllBins(framecounter,5)+3600*data25cw;
        SumDSed(framecounter,1)=DustSedimentationAllBins(framecounter,1)+DustSedimentationAllBins(framecounter,2)+DustSedimentationAllBins(framecounter,3);
        SumDSed(framecounter,1)=SumDSed(framecounter,1)+DustSedimentationAllBins(framecounter,4)+DustSedimentationAllBins(framecounter,5);
        SumWSed(framecounter,1)=WDustSedimentationAllBins(framecounter,1)+WDustSedimentationAllBins(framecounter,2)+WDustSedimentationAllBins(framecounter,3);
        SumWSed(framecounter,1)=SumWSed(framecounter,1)+WDustSedimentationAllBins(framecounter,4)+WDustSedimentationAllBins(framecounter,5);
        ab=1;
    end

end
%% Try the new dust calcuation scheme
    if(iDustCalc>1)
% This section is for the summed Dust Emission
        data1sumArea=data1sum.*RasterAreaGrid*1E6;
        data2sumArea=data2sum.*RasterAreaGrid*1E6;
        data3sumArea=data3sum.*RasterAreaGrid*1E6;
        data4sumArea=data4sum.*RasterAreaGrid*1E6;
        data5sumArea=data5sum.*RasterAreaGrid*1E6;
        data1sumT=sum(sum(data1sumArea));
        data2sumT=sum(sum(data2sumArea));
        data3sumT=sum(sum(data3sumArea));        
        data4sumT=sum(sum(data4sumArea));
        data5sumT=sum(sum(data5sumArea));
        DUEMSum(framecounter,1)=(data1sumT+data2sumT+data3sumT+data4sumT+data5sumT)*(1E3/1E12);
        data1sumArea=data1sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data2sumArea=data2sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data3sumArea=data3sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data4sumArea=data4sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data5sumArea=data5sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data1sumT=sum(sum(data1sumArea));
        data2sumT=sum(sum(data2sumArea));
        data3sumT=sum(sum(data3sumArea));        
        data4sumT=sum(sum(data4sumArea));
        data5sumT=sum(sum(data5sumArea));
        DUEMSum1(framecounter,1)=(data1sumT+data2sumT+data3sumT+data4sumT+data5sumT)*(1E3/1E12);
        data1sumArea=data1sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data2sumArea=data2sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data3sumArea=data3sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data4sumArea=data4sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data5sumArea=data5sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data1sumT=sum(sum(data1sumArea));
        data2sumT=sum(sum(data2sumArea));
        data3sumT=sum(sum(data3sumArea));        
        data4sumT=sum(sum(data4sumArea));
        data5sumT=sum(sum(data5sumArea));
        DUEMSum2(framecounter,1)=(data1sumT+data2sumT+data3sumT+data4sumT+data5sumT)*(1E3/1E12);
        data1sumArea=data1sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data2sumArea=data2sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data3sumArea=data3sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data4sumArea=data4sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data5sumArea=data5sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data1sumT=sum(sum(data1sumArea));
        data2sumT=sum(sum(data2sumArea));
        data3sumT=sum(sum(data3sumArea));        
        data4sumT=sum(sum(data4sumArea));
        data5sumT=sum(sum(data5sumArea));
        DUEMSum3(framecounter,1)=(data1sumT+data2sumT+data3sumT+data4sumT+data5sumT)*(1E3/1E12);
        data1sumArea=data1sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data2sumArea=data2sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data3sumArea=data3sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data4sumArea=data4sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data5sumArea=data5sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data1sumT=sum(sum(data1sumArea));
        data2sumT=sum(sum(data2sumArea));
        data3sumT=sum(sum(data3sumArea));        
        data4sumT=sum(sum(data4sumArea));
        data5sumT=sum(sum(data5sumArea));
        DUEMSum4(framecounter,1)=(data1sumT+data2sumT+data3sumT+data4sumT+data5sumT)*(1E3/1E12);
        data1sumArea=data1sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data2sumArea=data2sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data3sumArea=data3sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data4sumArea=data4sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data5sumArea=data5sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data1sumT=sum(sum(data1sumArea));
        data2sumT=sum(sum(data2sumArea));
        data3sumT=sum(sum(data3sumArea));        
        data4sumT=sum(sum(data4sumArea));
        data5sumT=sum(sum(data5sumArea));
        DUEMSum5(framecounter,1)=(data1sumT+data2sumT+data3sumT+data4sumT+data5sumT)*(1E3/1E12);
% This section is for the summed DustDeposition
        data11sumArea=data11sum.*RasterAreaGrid*1E6;
        data12sumArea=data12sum.*RasterAreaGrid*1E6;
        data13sumArea=data13sum.*RasterAreaGrid*1E6;
        data14sumArea=data14sum.*RasterAreaGrid*1E6;
        data15sumArea=data15sum.*RasterAreaGrid*1E6;
        data11sumT=sum(sum(data11sumArea));
        data12sumT=sum(sum(data12sumArea));
        data13sumT=sum(sum(data13sumArea));        
        data14sumT=sum(sum(data14sumArea));
        data15sumT=sum(sum(data15sumArea));
        DUDPSum(framecounter,1)=(data11sumT+data12sumT+data13sumT+data14sumT+data15sumT)*(1E3/1E12);
        data11sumArea=data11sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data12sumArea=data12sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data13sumArea=data13sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data14sumArea=data14sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data15sumArea=data15sum.*RasterAreaGrid*1E6.*Merra2WorkingMask1;
        data11sumT=sum(sum(data11sumArea));
        data12sumT=sum(sum(data12sumArea));
        data13sumT=sum(sum(data13sumArea));        
        data14sumT=sum(sum(data14sumArea));
        data15sumT=sum(sum(data15sumArea));
        DUDPSum1(framecounter,1)=(data11sumT+data12sumT+data13sumT+data14sumT+data15sumT)*(1E3/1E12);
        data11sumArea=data11sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data12sumArea=data12sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data13sumArea=data13sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data14sumArea=data14sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data15sumArea=data15sum.*RasterAreaGrid*1E6.*Merra2WorkingMask2;
        data11sumT=sum(sum(data11sumArea));
        data12sumT=sum(sum(data12sumArea));
        data13sumT=sum(sum(data13sumArea));        
        data14sumT=sum(sum(data14sumArea));
        data15sumT=sum(sum(data15sumArea));
        DUDPSum2(framecounter,1)=(data11sumT+data12sumT+data13sumT+data14sumT+data15sumT)*(1E3/1E12);
        data11sumArea=data11sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data12sumArea=data12sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data13sumArea=data13sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data14sumArea=data14sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data15sumArea=data15sum.*RasterAreaGrid*1E6.*Merra2WorkingMask3;
        data11sumT=sum(sum(data11sumArea));
        data12sumT=sum(sum(data12sumArea));
        data13sumT=sum(sum(data13sumArea));        
        data14sumT=sum(sum(data14sumArea));
        data15sumT=sum(sum(data15sumArea));
        DUDPSum3(framecounter,1)=(data11sumT+data12sumT+data13sumT+data14sumT+data15sumT)*(1E3/1E12);
        data11sumArea=data11sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data12sumArea=data12sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data13sumArea=data13sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data14sumArea=data14sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data15sumArea=data15sum.*RasterAreaGrid*1E6.*Merra2WorkingMask4;
        data11sumT=sum(sum(data11sumArea));
        data12sumT=sum(sum(data12sumArea));
        data13sumT=sum(sum(data13sumArea));        
        data14sumT=sum(sum(data14sumArea));
        data15sumT=sum(sum(data15sumArea));
        DUDPSum4(framecounter,1)=(data11sumT+data12sumT+data13sumT+data14sumT+data15sumT)*(1E3/1E12);
        data11sumArea=data11sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data12sumArea=data12sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data13sumArea=data13sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data14sumArea=data14sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data15sumArea=data15sum.*RasterAreaGrid*1E6.*Merra2WorkingMask5;
        data11sumT=sum(sum(data11sumArea));
        data12sumT=sum(sum(data12sumArea));
        data13sumT=sum(sum(data13sumArea));        
        data14sumT=sum(sum(data14sumArea));
        data15sumT=sum(sum(data15sumArea));
        DUDPSum5(framecounter,1)=(data11sumT+data12sumT+data13sumT+data14sumT+data15sumT)*(1E3/1E12);
    end
%% Add in Data for this frame and time for the selected country for each frame of data-old way
if(iSeaSaltCalc>100)
        datas1sum=zeros(576,361);
        datas2sum=zeros(576,361);
        datas3sum=zeros(576,361);
        datas4sum=zeros(576,361);
        datas5sum=zeros(576,361);
        datas11sum=zeros(576,361);
        datas12sum=zeros(576,361);
        datas13sum=zeros(576,361);
        datas14sum=zeros(576,361);
        datas15sum=zeros(576,361);
    for kk=1:24 % Loop over the hourly data
        datas1=SSDP001S.values(:,:,kk);% Sea Salt Deposition for one grid point at one time
        datas2=SSDP002S.values(:,:,kk);
        datas3=SSDP003S.values(:,:,kk);
        datas4=SSDP004S.values(:,:,kk);
        datas5=SSDP005S.values(:,:,kk);
        datas1sum=datas1sum+data1*3600;
        datas2sum=datas2sum+data2*3600;
        datas3sum=datas3sum+data3*3600;
        datas4sum=datas4sum+data4*3600;
        datas5sum=datas5sum+data5*3600;
        data1a=(1E3/1E12)*data1.*Merra2WorkingSeaMask1;% Use the mask to limit it to the target country and convert to Tgm
        data2a=(1E3/1E12)*data2.*Merra2WorkingSeaMask2;
        data3a=(1E3/1E12)*data3.*Merra2WorkingSeaMask3;
        data4a=(1E3/1E12)*data4.*Merra2WorkingSeaMask4;
        data5a=(1E3/1E12)*data5.*Merra2WorkingSeaMask5;
        data11a=(1E3/1E12)*data11.*Merra2WorkingMask;% Use the mask to limit it to the target country and convert to Tgm
        data12a=(1E3/1E12)*data12.*Merra2WorkingMask;
        data13a=(1E3/1E12)*data13.*Merra2WorkingMask;
        data14a=(1E3/1E12)*data14.*Merra2WorkingMask;
        data15a=(1E3/1E12)*data15.*Merra2WorkingMask;
        data21a=(1E3/1E12)*data21.*Merra2WorkingMask;% Use the mask to limit it to the target country and convert to Tgm
        data22a=(1E3/1E12)*data22.*Merra2WorkingMask;
        data23a=(1E3/1E12)*data23.*Merra2WorkingMask;
        data24a=(1E3/1E12)*data24.*Merra2WorkingMask;
        data25a=(1E3/1E12)*data25.*Merra2WorkingMask;
        data1aw=(1E3/1E12)*data1;% Convert from Kg to Tgm-terra grams w stand for entire world
        data2aw=(1E3/1E12)*data2;
        data3aw=(1E3/1E12)*data3;
        data4aw=1E3*data4/1E12;
        data5aw=1E3*data5/1E12;
        data11aw=(1E3/1E12)*data11;% Convert from Kg to Tgm-terra grams w stand for entire world
        data12aw=(1E3/1E12)*data12;
        data13aw=(1E3/1E12)*data13;
        data14aw=(1E3/1E12)*data14;
        data15aw=(1E3/1E12)*data15;
        data21aw=(1E3/1E12)*data21;% Convert from Kg to Tgm-terra grams w stand for entire world
        data22aw=(1E3/1E12)*data22;
        data23aw=(1E3/1E12)*data23;
        data24aw=(1E3/1E12)*data24;
        data25aw=(1E3/1E12)*data25;
        data1b=zeros(576,361);
        data2b=zeros(576,361);
        data3b=zeros(576,361);
        data4b=zeros(576,361);
        data5b=zeros(576,361);
        data11b=zeros(576,361);% ROI Country
        data12b=zeros(576,361);
        data13b=zeros(576,361);
        data14b=zeros(576,361);
        data15b=zeros(576,361);
        data21b=zeros(576,361);% ROI Country
        data22b=zeros(576,361);
        data23b=zeros(576,361);
        data24b=zeros(576,361);
        data25b=zeros(576,361);
        data1bw=zeros(576,361);% Whole World
        data2bw=zeros(576,361);
        data3bw=zeros(576,361);
        data4bw=zeros(576,361);
        data5bw=zeros(576,361);
        data11bw=zeros(576,361);% Whole World
        data12bw=zeros(576,361);
        data13bw=zeros(576,361);
        data14bw=zeros(576,361);
        data15bw=zeros(576,361);
        data21bw=zeros(576,361);% Whole World
        data22bw=zeros(576,361);
        data23bw=zeros(576,361);
        data24bw=zeros(576,361);
        data25bw=zeros(576,361);
        sumarea=0;
        ihits=0;
        for jj=1:361
            nowArea=1E6*RasterAreas(jj,1);% convert km^2 to m^2
            for ii=1:576
                if(Merra2WorkingMask(ii,jj)>0)
                    sumarea=sumarea+nowArea;
                    ihits=ihits+1;
                end
                data1b(ii,jj)=data1a(ii,jj)*nowArea;
                data2b(ii,jj)=data2a(ii,jj)*nowArea;
                data3b(ii,jj)=data3a(ii,jj)*nowArea;
                data4b(ii,jj)=data4a(ii,jj)*nowArea;
                data5b(ii,jj)=data5a(ii,jj)*nowArea;
                data1bw(ii,jj)=data1aw(ii,jj)*nowArea;
                data2bw(ii,jj)=data2aw(ii,jj)*nowArea;
                data3bw(ii,jj)=data3aw(ii,jj)*nowArea;
                data4bw(ii,jj)=data4aw(ii,jj)*nowArea;
                data5bw(ii,jj)=data5aw(ii,jj)*nowArea;
                data11b(ii,jj)=data11a(ii,jj)*nowArea;
                data12b(ii,jj)=data12a(ii,jj)*nowArea;
                data13b(ii,jj)=data13a(ii,jj)*nowArea;
                data14b(ii,jj)=data14a(ii,jj)*nowArea;
                data15b(ii,jj)=data15a(ii,jj)*nowArea;
                data11bw(ii,jj)=data11aw(ii,jj)*nowArea;
                data12bw(ii,jj)=data12aw(ii,jj)*nowArea;
                data13bw(ii,jj)=data13aw(ii,jj)*nowArea;
                data14bw(ii,jj)=data14aw(ii,jj)*nowArea;
                data15bw(ii,jj)=data15aw(ii,jj)*nowArea;
                data21b(ii,jj)=data21a(ii,jj)*nowArea;
                data22b(ii,jj)=data22a(ii,jj)*nowArea;
                data23b(ii,jj)=data23a(ii,jj)*nowArea;
                data24b(ii,jj)=data24a(ii,jj)*nowArea;
                data25b(ii,jj)=data25a(ii,jj)*nowArea;
                data21bw(ii,jj)=data21aw(ii,jj)*nowArea;
                data22bw(ii,jj)=data22aw(ii,jj)*nowArea;
                data23bw(ii,jj)=data23aw(ii,jj)*nowArea;
                data24bw(ii,jj)=data24aw(ii,jj)*nowArea;
                data25bw(ii,jj)=data25aw(ii,jj)*nowArea;
            end

        end
        data1c=sum(sum(data1b));
        data2c=sum(sum(data2b));
        data3c=sum(sum(data3b));
        data4c=sum(sum(data4b));
        data5c=sum(sum(data5b));
        data1cw=sum(sum(data1bw));
        data2cw=sum(sum(data2bw));
        data3cw=sum(sum(data3bw));
        data4cw=sum(sum(data4bw));
        data5cw=sum(sum(data5bw));
        data11c=sum(sum(data11b));
        data12c=sum(sum(data12b));
        data13c=sum(sum(data13b));
        data14c=sum(sum(data14b));
        data15c=sum(sum(data15b));
        data11cw=sum(sum(data11bw));
        data12cw=sum(sum(data12bw));
        data13cw=sum(sum(data13bw));
        data14cw=sum(sum(data14bw));
        data15cw=sum(sum(data15bw));
        data21c=sum(sum(data21b));
        data22c=sum(sum(data22b));
        data23c=sum(sum(data23b));
        data24c=sum(sum(data24b));
        data25c=sum(sum(data25b));
        data21cw=sum(sum(data21bw));
        data22cw=sum(sum(data22bw));
        data23cw=sum(sum(data23bw));
        data24cw=sum(sum(data24bw));
        data25cw=sum(sum(data25bw));
        DustEmissionAllBins(framecounter,1)=DustEmissionAllBins(framecounter,1)+3600*data1c;% Sum up the rate for 1 hr for target country
        DustEmissionAllBins(framecounter,2)=DustEmissionAllBins(framecounter,2)+3600*data2c;
        DustEmissionAllBins(framecounter,3)=DustEmissionAllBins(framecounter,3)+3600*data3c;
        DustEmissionAllBins(framecounter,4)=DustEmissionAllBins(framecounter,4)+3600*data4c;
        DustEmissionAllBins(framecounter,5)=DustEmissionAllBins(framecounter,5)+3600*data5c;
        WDustEmissionAllBins(framecounter,1)=WDustEmissionAllBins(framecounter,1)+3600*data1cw;% Sum up the rate for 1 hr for entire world
        WDustEmissionAllBins(framecounter,2)=WDustEmissionAllBins(framecounter,2)+3600*data2cw;
        WDustEmissionAllBins(framecounter,3)=WDustEmissionAllBins(framecounter,3)+3600*data3cw;
        WDustEmissionAllBins(framecounter,4)=WDustEmissionAllBins(framecounter,4)+3600*data4cw;
        WDustEmissionAllBins(framecounter,5)=WDustEmissionAllBins(framecounter,5)+3600*data5cw;
        ROIArea=sumarea;
        ROIPts=ihits;
        SumDEmiss(framecounter,1)=DustEmissionAllBins(framecounter,1)+DustEmissionAllBins(framecounter,2)+DustEmissionAllBins(framecounter,3);
        SumDEmiss(framecounter,1)=SumDEmiss(framecounter,1)+DustEmissionAllBins(framecounter,4)+DustEmissionAllBins(framecounter,5);
        SumWEmiss(framecounter,1)=WDustEmissionAllBins(framecounter,1)+WDustEmissionAllBins(framecounter,2)+WDustEmissionAllBins(framecounter,3);
        SumWEmiss(framecounter,1)=SumWEmiss(framecounter,1)+WDustEmissionAllBins(framecounter,4)+WDustEmissionAllBins(framecounter,5);
        DustDepositionAllBins(framecounter,1)=DustDepositionAllBins(framecounter,1)+3600*data11c; % Sum up the rate for 1 hr for target country
        DustDepositionAllBins(framecounter,2)=DustDepositionAllBins(framecounter,2)+3600*data12c;
        DustDepositionAllBins(framecounter,3)=DustDepositionAllBins(framecounter,3)+3600*data13c;
        DustDepositionAllBins(framecounter,4)=DustDepositionAllBins(framecounter,4)+3600*data14c;
        DustDepositionAllBins(framecounter,5)=DustDepositionAllBins(framecounter,5)+3600*data15c;
        WDustDepositionAllBins(framecounter,1)=WDustDepositionAllBins(framecounter,1)+3600*data11cw; % Sum up the rate for 1 hr for target country
        WDustDepositionAllBins(framecounter,2)=WDustDepositionAllBins(framecounter,2)+3600*data12cw;
        WDustDepositionAllBins(framecounter,3)=WDustDepositionAllBins(framecounter,3)+3600*data13cw;
        WDustDepositionAllBins(framecounter,4)=WDustDepositionAllBins(framecounter,4)+3600*data14cw;
        WDustDepositionAllBins(framecounter,5)=WDustDepositionAllBins(framecounter,5)+3600*data15cw;
        SumDDepo(framecounter,1)=DustDepositionAllBins(framecounter,1)+DustDepositionAllBins(framecounter,2)+DustDepositionAllBins(framecounter,3);
        SumDDepo(framecounter,1)=SumDDepo(framecounter,1)+DustDepositionAllBins(framecounter,4)+DustDepositionAllBins(framecounter,5);
        SumWDepo(framecounter,1)=WDustDepositionAllBins(framecounter,1)+WDustDepositionAllBins(framecounter,2)+WDustDepositionAllBins(framecounter,3);
        SumWDepo(framecounter,1)=SumWDepo(framecounter,1)+WDustDepositionAllBins(framecounter,4)+WDustDepositionAllBins(framecounter,5);
        DustSedimentationAllBins(framecounter,1)=DustSedimentationAllBins(framecounter,1)+3600*data21c; % Sum up the rate for 1 hr for target country
        DustSedimentationAllBins(framecounter,2)=DustSedimentationAllBins(framecounter,2)+3600*data22c;
        DustSedimentationAllBins(framecounter,3)=DustSedimentationAllBins(framecounter,3)+3600*data23c;
        DustSedimentationAllBins(framecounter,4)=DustSedimentationAllBins(framecounter,4)+3600*data24c;
        DustSedimentationAllBins(framecounter,5)=DustSedimentationAllBins(framecounter,5)+3600*data25c;
        WDustSedimentationAllBins(framecounter,1)=WDustSedimentationAllBins(framecounter,1)+3600*data21cw; % Sum up the rate for 1 hr for target country
        WDustSedimentationAllBins(framecounter,2)=WDustSedimentationAllBins(framecounter,2)+3600*data22cw;
        WDustSedimentationAllBins(framecounter,3)=WDustSedimentationAllBins(framecounter,3)+3600*data23cw;
        WDustSedimentationAllBins(framecounter,4)=WDustSedimentationAllBins(framecounter,4)+3600*data24cw;
        WDustSedimentationAllBins(framecounter,5)=WDustSedimentationAllBins(framecounter,5)+3600*data25cw;
        SumDSed(framecounter,1)=DustSedimentationAllBins(framecounter,1)+DustSedimentationAllBins(framecounter,2)+DustSedimentationAllBins(framecounter,3);
        SumDSed(framecounter,1)=SumDSed(framecounter,1)+DustSedimentationAllBins(framecounter,4)+DustSedimentationAllBins(framecounter,5);
        SumWSed(framecounter,1)=WDustSedimentationAllBins(framecounter,1)+WDustSedimentationAllBins(framecounter,2)+WDustSedimentationAllBins(framecounter,3);
        SumWSed(framecounter,1)=SumWSed(framecounter,1)+WDustSedimentationAllBins(framecounter,4)+WDustSedimentationAllBins(framecounter,5);
        ab=1;
    end

end
%% Add in Data for this frame and time for the selected country for each frame of data-new way
if(iSeaSaltCalc>0)
        datas1sum=zeros(576,361);
        datas2sum=zeros(576,361);
        datas3sum=zeros(576,361);
        datas4sum=zeros(576,361);
        datas5sum=zeros(576,361);
        datas11sum=zeros(576,361);
        datas12sum=zeros(576,361);
        datas13sum=zeros(576,361);
        datas14sum=zeros(576,361);
        datas15sum=zeros(576,361);
    for kk=1:24 % Loop over the hourly data in gridded format for each particle bin
        datas1=SSDP001S.values(:,:,kk);% Sea Salt Deposition for one grid point at one time
        datas2=SSDP002S.values(:,:,kk);
        datas3=SSDP003S.values(:,:,kk);
        datas4=SSDP004S.values(:,:,kk);
        datas5=SSDP005S.values(:,:,kk);
        datas1sum=datas1sum+datas1*3600;
        datas2sum=datas2sum+datas2*3600;
        datas3sum=datas3sum+datas3*3600;
        datas4sum=datas4sum+datas4*3600;        
        datas5sum=datas5sum+datas5*3600;

    end
        data0sum=(1E3/1E12)*(data1sum + data2sum + data3sum + data4sum + data5sum).*RasterAreaGrid*1E6;
% Use the mask to limit it to the target country and convert to Tgm        
        data1sum=data0sum.*Merra2WorkingSeaMask1;
        data2sum=data0sum.*Merra2WorkingSeaMask2;
        data3sum=data0sum.*Merra2WorkingSeaMask3;
        data4sum=data0sum.*Merra2WorkingSeaMask4;
        data5sum=data0sum.*Merra2WorkingSeaMask5;
        SeaSaltDryDepAllBins(framecounter,1)=sum(sum(data1sum));
        SeaSaltDryDepAllBins(framecounter,2)=sum(sum(data2sum));
        SeaSaltDryDepAllBins(framecounter,3)=sum(sum(data3sum));
        SeaSaltDryDepAllBins(framecounter,4)=sum(sum(data4sum));
        SeaSaltDryDepAllBins(framecounter,5)=sum(sum(data4sum));
        WSeaSaltDryDepAllBins(framecounter,1)=sum(sum(data0sum))/100;
        summask1=sum(sum(Merra2WorkingSeaMask1));
        summask2=sum(sum(Merra2WorkingSeaMask2));
        summask3=sum(sum(Merra2WorkingSeaMask3));
        summask4=sum(sum(Merra2WorkingSeaMask4));
        summask5=sum(sum(Merra2WorkingSeaMask5));
        fprintf(fid,'\n');
        sumstr1=strcat('Mask 1 Sum=',num2str(summask1));
        sumstr2=strcat('Mask 2 Sum=',num2str(summask2));
        sumstr3=strcat('Mask 3 Sum=',num2str(summask3));
        sumstr4=strcat('Mask 4 Sum=',num2str(summask4));
        sumstr5=strcat('Mask 5 Sum=',num2str(summask5));
        fprintf(fid,'%s\n',sumstr1);
        fprintf(fid,'%s\n',sumstr2);
        fprintf(fid,'%s\n',sumstr3);
        fprintf(fid,'%s\n',sumstr4);
        fprintf(fid,'%s\n',sumstr5);
        fprintf(fid,'\n');



end


    if(framecounter==numSelectedFiles)
        eval(['cd ' savepath(1:length(savepath)-1)]);
        %save CalculatedDustEmissionRev1.mat DustEmissionAllBins WDustEmissionAllBins DustROICountry ROIArea ROIPts DUDPSum DUDPSum1 DUDPSum2
        actionstr='save';
        varstr1='DustEmissionAllBins WDustEmissionAllBins DUDPSum DUDPSum1';
        varstr2=' DUDPSum2 DUDPSum3 DUDPSum4 DUDPSum5 SelectedMaskData';
        varstr3=' DUEMSum DUEMSum1 DUEMSum2 DUEMSum3 DUEMSum4 DUEMSum5';
        varstr=strcat(varstr1,varstr2,varstr3);
        MatFileName='CalculatedDustEmissionRev4.mat';
        qualstr='-v7.3';
        [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
        eval(cmdString)
        dispstr=strcat('Wrote Merra2 Dust Data To File -',MatFileName);
        disp(dispstr)
    end

%% Create a series of timetables
if(framecounter==numSelectedFiles)
   stime=datetime(yd,md,dd);
   hd=(numtimeslice-1);
   timestep=caldays(1);
   fprintf(fid,'%s\n','----Start Creating Tables----');
   if(iDustCalc>0)
       DEmissBin001=zeros(numSelectedFiles,1);
       DEmissBin002=zeros(numSelectedFiles,1);
       DEmissBin003=zeros(numSelectedFiles,1);
       DEmissBin004=zeros(numSelectedFiles,1);
       DEmissBin005=zeros(numSelectedFiles,1);
       WDEmissBin001=zeros(numSelectedFiles,1);
       WDEmissBin002=zeros(numSelectedFiles,1);
       WDEmissBin003=zeros(numSelectedFiles,1);
       WDEmissBin004=zeros(numSelectedFiles,1);
       WDEmissBin005=zeros(numSelectedFiles,1);
       DEmissBin001=DustEmissionAllBins(:,1);
       DEmissBin002=DustEmissionAllBins(:,2);
       DEmissBin003=DustEmissionAllBins(:,3);
       DEmissBin004=DustEmissionAllBins(:,4);
       DEmissBin005=DustEmissionAllBins(:,5);
       WDEmissBin001=WDustEmissionAllBins(:,1);
       WDEmissBin002=WDustEmissionAllBins(:,2);
       WDEmissBin003=WDustEmissionAllBins(:,3);
       WDEmissBin004=WDustEmissionAllBins(:,4);
       WDEmissBin005=WDustEmissionAllBins(:,5);
       DepoBin001=zeros(numSelectedFiles,1);
       DepoBin002=zeros(numSelectedFiles,1);
       DepoBin003=zeros(numSelectedFiles,1);
       DepoBin004=zeros(numSelectedFiles,1);
       DepoBin005=zeros(numSelectedFiles,1);
       WDepoBin001=zeros(numSelectedFiles,1);
       WDepoBin002=zeros(numSelectedFiles,1);
       WDepoBin003=zeros(numSelectedFiles,1);
       WDepoBin004=zeros(numSelectedFiles,1);
       WDepoBin005=zeros(numSelectedFiles,1);
       SedBin001=zeros(numSelectedFiles,1);
       SedBin002=zeros(numSelectedFiles,1);
       SedBin003=zeros(numSelectedFiles,1);
       SedBin004=zeros(numSelectedFiles,1);
       SedBin005=zeros(numSelectedFiles,1);
       WSedBin001=zeros(numSelectedFiles,1);
       WSedBin002=zeros(numSelectedFiles,1);
       WSedBin003=zeros(numSelectedFiles,1);
       WSedBin004=zeros(numSelectedFiles,1);
       WSedBin005=zeros(numSelectedFiles,1);
       DepoBin001=DustDepositionAllBins(:,1);
       DepoBin002=DustDepositionAllBins(:,2);
       DepoBin003=DustDepositionAllBins(:,3);
       DepoBin004=DustDepositionAllBins(:,4);
       DepoBin005=DustDepositionAllBins(:,5);
       WDepoBin001=WDustDepositionAllBins(:,1);
       WDepoBin002=WDustDepositionAllBins(:,2);
       WDepoBin003=WDustDepositionAllBins(:,3);
       WDepoBin004=WDustDepositionAllBins(:,4);
       WDepoBin005=WDustDepositionAllBins(:,5);
       SedBin001=DustSedimentationAllBins(:,1);
       SedBin002=DustSedimentationAllBins(:,2);
       SedBin003=DustSedimentationAllBins(:,3);
       SedBin004=DustSedimentationAllBins(:,4);
       SedBin005=DustSedimentationAllBins(:,5);
       WSedBin001=WDustSedimentationAllBins(:,1);
       WSedBin002=WDustSedimentationAllBins(:,2);
       WSedBin003=WDustSedimentationAllBins(:,3);
       WSedBin004=WDustSedimentationAllBins(:,4);
       WSedBin005=WDustSedimentationAllBins(:,5);

       DustEmissionAllTable=table(DEmissBin001(:,1),DEmissBin002(:,1),...
             DEmissBin003(:,1),DEmissBin004(:,1),DEmissBin005(:,1),SumDEmiss(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       DustEmissionAllTT=table2timetable(DustEmissionAllTable,'TimeStep',timestep,'StartTime',stime);
       WDustEmissionAllTable=table(WDEmissBin001(:,1),WDEmissBin002(:,1),...
             WDEmissBin003(:,1),WDEmissBin004(:,1),WDEmissBin005(:,1),SumWEmiss(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       WDustEmissionAllTT=table2timetable(WDustEmissionAllTable,'TimeStep',timestep,'StartTime',stime);
       DustDepositionAllTable=table(DepoBin001(:,1),DepoBin002(:,1),...
             DepoBin003(:,1),DepoBin004(:,1),DepoBin005(:,1),SumDDepo(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       DustDepositionAllTT=table2timetable(DustDepositionAllTable,'TimeStep',timestep,'StartTime',stime);
              DustDepositionAllTable=table(DepoBin001(:,1),DepoBin002(:,1),...
              DepoBin003(:,1),DepoBin004(:,1),DepoBin005(:,1),SumDDepo(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       WDustDepositionAllTable=table(WDepoBin001(:,1),WDepoBin002(:,1),...
              WDepoBin003(:,1),WDepoBin004(:,1),WDepoBin005(:,1),SumWDepo(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       WDustDepositionAllTT=table2timetable(WDustDepositionAllTable,'TimeStep',timestep,'StartTime',stime);
              DustDepositionAllTable=table(DepoBin001(:,1),DepoBin002(:,1),...
             DepoBin003(:,1),DepoBin004(:,1),DepoBin005(:,1),SumDDepo(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       DustSedimentationAllTable=table(SedBin001(:,1),SedBin002(:,1),...
              SedBin003(:,1),SedBin004(:,1),SedBin005(:,1),SumDSed(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       DustSedimentationAllTT=table2timetable(DustSedimentationAllTable,'TimeStep',timestep,'StartTime',stime);
       WDustSedimentationAllTable=table(WSedBin001(:,1),WSedBin002(:,1),...
              WSedBin003(:,1),WSedBin004(:,1),WSedBin005(:,1),SumWSed(:,1),...
             'VariableNames',{'Bin001','Bin002','Bin003',...
             'Bin004','Bin005','Sum'});
       WDustSedimentationAllTT=table2timetable(WDustSedimentationAllTable,'TimeStep',timestep,'StartTime',stime);
       eval(['cd ' tablepath(1:length(tablepath)-1)]);
       actionstr='save';
       varstr1='DustEmissionAllTable DustEmissionAllBins DustEmissionAllTT YearMonthStr numtimeslice DustROICountry';
       varstr2=' WDustEmissionAllTable WDustEmissionAllBins WDustEmissionAllTT SumDEmiss';
       varstr=strcat(varstr1,varstr2);
       MatFileName=strcat('DustEmissionAllTable',YearMonthStr,'-','FullDay.mat');
       qualstr='-v7.3';
       [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr,qualstr);
       eval(cmdString)
       dustallstr=strcat('DustEmissionAllTT-','Contains Daily Dust Accumilation');
       fprintf(fid,'%s\n',dustallstr);
 % Create a special tables for Dust Deposition and Dust Emission
       if(iDustCalc>1) 
             DustDepoTable=table(DUDPSum(:,1),DUDPSum1(:,1),...
                 DUDPSum2(:,1),DUDPSum3(:,1),DUDPSum4(:,1),DUDPSum5(:,1),...
                 'VariableNames',{'World','ROI1','ROI2',...
                 'ROI3','ROI4','ROI5'});
             DustDepoTT=table2timetable(DustDepoTable,'TimeStep',timestep,'StartTime',stime);
             eval(['cd ' tablepath(1:length(tablepath)-1)]);
             actionstr='save';
             varstr1='DustDepoTable DustDepoTT YearMonthStr numtimeslice';
             MatFileName=strcat('DustDepoTable',YearMonthStr,'-',num2str(numtimeslice),'Rev1.mat');
             qualstr='-v7.3';
             [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
             eval(cmdString)
             dustdepostr=strcat('Created DustDepoTT-','Contains Sum Of DryDustDeposition-',num2str(120));
             fprintf(fid,'%s\n',dustdepostr);
             DustEmisTable=table(DUEMSum(:,1),DUEMSum1(:,1),...
                 DUEMSum2(:,1),DUEMSum3(:,1),DUEMSum4(:,1),DUEMSum5(:,1),...
                 'VariableNames',{'World','ROI1','ROI2',...
                 'ROI3','ROI4','ROI5'});
             DustEmisTT=table2timetable(DustEmisTable,'TimeStep',timestep,'StartTime',stime);
             eval(['cd ' tablepath(1:length(tablepath)-1)]);
             actionstr='save';
             varstr1='DustEmisTable DustEmisTT YearMonthStr numtimeslice';
             MatFileName=strcat('DustEmisTable',YearMonthStr,'-',num2str(numtimeslice),'Rev1.mat');
             qualstr='-v7.3';
             [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
             eval(cmdString)
             dustemisstr=strcat('Created DustEmisTT-','Contains Sum Of DryDustEmission-',num2str(121));
             fprintf(fid,'%s\n',dustemisstr);
       end
   end
if((iSeaSalt>0) && (iSeaSaltCalc>0))
%% Create a Table for the cumilative Daily Deposiion of Sea Salt in All Bins
  
SSDPSumTable=table(WSeaSaltDryDepAllBins(:,1),SeaSaltDryDepAllBins(:,1),...
      SeaSaltDryDepAllBins(:,2),SeaSaltDryDepAllBins(:,3),...
      SeaSaltDryDepAllBins(:,4),SeaSaltDryDepAllBins(:,5),...
      'VariableNames',{'World','ROIName6','ROIName7',...
      'ROIName8','ROIName9','ROIName10'});
SSDPSumTT = table2timetable(SSDPSumTable,'TimeStep',timestep,'StartTime',stime);
eval(['cd ' tablepath(1:length(tablepath)-1)]);
actionstr='save';
varstr1='SSDPSumTable SSDPSumTT YearMonthStr numtimeslice SelectedSeaMaskData';
MatFileName=strcat('SSDPSumTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
eval(cmdString)
blackcar01str=strcat('Created SSDPSumTT-','Contains Sum Of Sea Salt Dry Dep-',num2str(1));
fprintf(fid,'%s\n',blackcar01str);

end
%% Create the Black Carbon Dry Deposition Table For Bin 001 ikind=1
  BCDP001Table=table(BCDP00150(:,1),BCDP00175(:,1),BCDP00190(:,1),BCDP00195(:,1),...
      BCDP00198(:,1),BCDP001100(:,1),...
            'VariableNames',{'BCDP00150','BCDP00175','BCDP00190',...
            'BCDP00195','BCDP00198','BCDP001100'});
  BCDP001TT = table2timetable(BCDP001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCDP001Table BCDP001TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCDP001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  blackcar01str=strcat('Created BCDP001TT-','Contains Black Carbon Dry Deposition-',num2str(1));
  fprintf(fid,'%s\n',blackcar01str);

%% Create the Black Carbon Dry Deposition Table For Bin 002 ikind=2
  BCDP002Table=table(BCDP00250(:,1),BCDP00275(:,1),BCDP00290(:,1),BCDP00295(:,1),...
      BCDP00298(:,1),BCDP002100(:,1),...
            'VariableNames',{'BCDP00250','BCDP00275','BCDP00290',...
            'BCDP00295','BCDP00298','BCDP002100'});
  BCDP002TT = table2timetable(BCDP002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCDP002Table BCDP002TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCDP002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  blackcar02str=strcat('Created BCDP002TT-','Contains Black Carbon Dry Deposition-',num2str(2));
  fprintf(fid,'%s\n',blackcar02str);

%% Create the Black Carbon Emission at Bin 001 ikind=3
  BCEM001Table=table(BCEM00110(:,1),BCEM00125(:,1),BCEM00150(:,1),BCEM00175(:,1),...
      BCEM00190(:,1),BCEM001100(:,1),...
            'VariableNames',{'BCEM00110','BCEM00125','BCEM00150',...
            'BCEM00175','BCEM00190','BCEM001100'});
  BCEM001TT = table2timetable(BCEM001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCEM001Table BCEM001TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCEM001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcem01str=strcat('Created BCEM001TT-','Contains Black Carbon Emission Bin 001-',num2str(3));
  fprintf(fid,'%s\n',bcem01str);

%% Create the Black Carbon Emission at Bin 002 ikind=4
  BCEM002Table=table(BCEM00210(:,1),BCEM00225(:,1),BCEM00250(:,1),BCEM00275(:,1),...
      BCEM00290(:,1),BCEM002100(:,1),...
            'VariableNames',{'BCEM00210','BCEM00225','BCEM00250',...
            'BCEM00275','BCEM00290','BCEM002100'});
  BCEM002TT = table2timetable(BCEM002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCEM002Table BCEM002TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCEM002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcem02str=strcat('Created BCEM002TT-','Contains Black Carbon Emission Bin 002-',num2str(4));
  fprintf(fid,'%s\n',bcem02str);

%% Create the Black Carbon Anthropogenic Emissions ikind=5
  BCEMANTable=table(BCEMAN10(:,1),BCEMAN25(:,1),BCEMAN50(:,1),BCEMAN75(:,1),...
      BCEMAN90(:,1),BCEMAN100(:,1),...
            'VariableNames',{'BCEMAN10','BCEMAN25','BCEMAN50',...
            'BCEMAN75','BCEMAN90','BCEMAN100'});
  BCEMANTT = table2timetable(BCEMANTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCEMANTable BCEMANTT YearMonthStr numtimeslice';
  MatFileName=strcat('BCEMANTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcemanstr=strcat('Created BCEMANTT-','Contains Black Carbon Antropogenic Emissions-',num2str(5));
  fprintf(fid,'%s\n',bcemanstr);

 %% Create the Black Carbon Burning Biomass Emissions ikind=6
  BCEMBBTable=table(BCEMBB50(:,1),BCEMBB75(:,1),BCEMBB90(:,1),BCEMBB95(:,1),...
      BCEMBB98(:,1),BCEMBB100(:,1),...
            'VariableNames',{'BCEMBB50','BCEMBB75','BCEMBB90',...
            'BCEMBB95','BCEMBB98','BCEMBB100'});
  BCEMBBTT = table2timetable(BCEMBBTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCEMBBTable BCEMBBTT YearMonthStr numtimeslice';
  MatFileName=strcat('BCEMBBTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcembbstr=strcat('Created BCEMBBTT-','Contains Black Carbon Biomass Emissions-',num2str(6));
  fprintf(fid,'%s\n',bcembbstr);

%% Create the Black Carbon Biofuel Emissions ikind=7
  BCEMBFTable=table(BCEMBF10(:,1),BCEMBF25(:,1),BCEMBF50(:,1),BCEMBF75(:,1),...
      BCEMBF90(:,1),BCEMBF100(:,1),...
            'VariableNames',{'BCEMBF10','BCEMBF25','BCEMBF50',...
            'BCEMBF75','BCEMBF90','BCEMBF100'});
  BCEMBFTT = table2timetable(BCEMBFTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCEMBFTable BCEMBFTT YearMonthStr numtimeslice';
  MatFileName=strcat('BCEMBFTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcembfstr=strcat('Created BCEMBFTT-','Contains Black Carbon Biofuel Emissions-',num2str(7));
  fprintf(fid,'%s\n',bcembfstr);

 %% Create the Black Carbon Hydrophobic ikind=8
  BCHYPHILFTable=table(BCHYPHIL10(:,1),BCHYPHIL25(:,1),BCHYPHIL50(:,1),BCHYPHIL75(:,1),...
      BCHYPHIL90(:,1),BCHYPHIL100(:,1),...
            'VariableNames',{'BCHYPHIL10','BCHYPHIL25','BCHYPHIL50',...
            'BCHYPHIL75','BCHYPHIL90','BCHYPHIL100'});
  BCHYPHILFTT = table2timetable(BCHYPHILFTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCHYPHILFTable BCHYPHILFTT YearMonthStr numtimeslice';
  MatFileName=strcat('BCEMBFTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bchyphilstr=strcat('Created BCHYPHILFTT-','Contains Black Hydrophobic-',num2str(8));
  fprintf(fid,'%s\n',bchyphilstr);

%% Create the Black Carbon Ssedimentation Bin 001 ikind=9
  BCSD001Table=table( BCSD00110(:,1), BCSD00125(:,1), BCSD00150(:,1), BCSD00175(:,1),...
       BCSD00190(:,1), BCSD001100(:,1),...
            'VariableNames',{'BCSD00110','BCSD00125','BCSD00150',...
            'BCSD00175','BCSD00190','BCSD001100'});
  BCSD001TT = table2timetable(BCSD001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCSD001Table BCSD001TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCSD001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcsd001str=strcat('Created BCSD001Table-','Contains Black Carbon Sedimentation Bin 001-',num2str(9));
  fprintf(fid,'%s\n',bcsd001str);

%% Create the Black Carbon Sedimentation Bin 002 ikind=10
  BCSD002Table=table(BCSD00210(:,1),BCSD00225(:,1),BCSD00250(:,1),BCSD00275(:,1),...
       BCSD00290(:,1),BCSD002100(:,1),...
            'VariableNames',{'BCSD00210','BCSD00225','BCSD00250',...
            'BCSD00275','BCSD00290','BCSD002100'});
  BCSD002TT = table2timetable(BCSD002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCSD002Table BCSD002TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCSD002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcsd002str=strcat('Created BCSD002Table-','Contains Black Carbon Sedimentation Bin 002-',num2str(10));
  fprintf(fid,'%s\n',bcsd002str);

%% Create the Black Carbon Convective Scavenging Table for  Bin 001 ikind=11
  BCSV001Table=table(BCSV00150(:,1),BCSV00175(:,1),BCSV00190(:,1),BCSV00195(:,1),...
       BCSV00198(:,1),BCSV001100(:,1),...
            'VariableNames',{'BCSV00150','BCSV00175','BCSV00190',...
            'BCSV00195','BCSV00198','BCSV001100'});
  BCSV001TT = table2timetable(BCSV001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCSV001Table BCSV001TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCSV001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcsv01str=strcat('Created BCSV001Table-','Contains Black Carbon Scavenging Bin 01-',num2str(11));
  fprintf(fid,'%s\n',bcsv01str);

  %% Create the Black Carbon Convective Scavenging Table for  Bin 002 ikind=12
  BCSV002Table=table(BCSV00250(:,1),BCSV00275(:,1),BCSV00290(:,1),BCSV00295(:,1),...
       BCSV00298(:,1),BCSV002100(:,1),...
            'VariableNames',{'BCSV00250','BCSV00275','BCSV00290',...
            'BCSV00295','BCSV00298','BCSV002100'});
  BCSV002TT = table2timetable(BCSV002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCSV002Table BCSV002TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCSV002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcsv02str=strcat('Created BCSV002Table-','Contains Black Carbon Scavenging Bin 02-',num2str(12));
  fprintf(fid,'%s\n',bcsv02str);

%% Create the Black Carbon Wet Deposition Bin 001 ikind=13
  BCWT001Table=table(BCWT00150(:,1),BCWT00175(:,1),BCWT00190(:,1),BCWT00195(:,1),...
       BCWT00198(:,1),BCWT001100(:,1),...
            'VariableNames',{'BCWT00150','BCWT00175','BCWT00190',...
            'BCWT00195','BCWT00198','BCWT001100'});
  BCWT001TT = table2timetable(BCWT001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCWT001Table BCWT001TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCWT001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcwt001str=strcat('Created BCWT001Table-','Contains Black Carbon Wet Deposition Bin 001-',num2str(13));
  fprintf(fid,'%s\n',bcwt001str);

%% Create the Black Carbon Wet Deposition Bin 002 ikind=14
  BCWT002Table=table(BCWT00250(:,1),BCWT00275(:,1),BCWT00290(:,1),BCWT00295(:,1),...
       BCWT00298(:,1),BCWT002100(:,1),...
            'VariableNames',{'BCWT00250','BCWT00275','BCWT00290',...
            'BCWT00295','BCWT00298','BCWT002100'});
  BCWT002TT = table2timetable(BCWT002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='BCWT002Table BCWT002TT YearMonthStr numtimeslice';
  MatFileName=strcat('BCWT002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  bcwt002str=strcat('Created BCWT002Table-','Contains Black Carbon Wet Deposition Bin 002-',num2str(14));
  fprintf(fid,'%s\n',bcwt002str);

%% Create DUST TOM UV Index ikind=15
  DUAERIDXTable=table(DUAERIDX50(:,1),DUAERIDX75(:,1),DUAERIDX90(:,1),DUAERIDX95(:,1),...
       DUAERIDX98(:,1),DUAERIDX100(:,1),...
            'VariableNames',{'DUAERIDX50','DUAERIDX75','DUAERIDX90',...
            'DUAERIDX95','DUAERIDX98','DUAERIDX100'});
  DUAERIDXTT = table2timetable(DUAERIDXTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUAERIDXTable DUAERIDXTT YearMonthStr numtimeslice';
  MatFileName=strcat('DUAERIDXTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duaerstr=strcat('Created DUAERIDXTable-','Contains DUST TOMS UV Index-',num2str(15));
  fprintf(fid,'%s\n',duaerstr);

%% Create the Dry Dust Deposition Bin 001 ikind=16
  DUDP001Table=table(DUDP00110(:,1),DUDP00125(:,1),DUDP00150(:,1),DUDP00175(:,1),...
       DUDP00190(:,1),DUDP001100(:,1),...
            'VariableNames',{'DUDP00110','DUDP00125','DUDP00150',...
            'DUDP00175','DUDP00190','DUDP001100'});
  DUDP001TT = table2timetable(DUDP001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUDP001Table DUDP001TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUDP001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dudp01str=strcat('Created DUDP001Table-','Contains Dry Dust Deposition Bin 01-',num2str(16));
  fprintf(fid,'%s\n',dudp01str);

%% Create the Dry Dust Deposition Bin 002 ikind=17
  DUDP002Table=table(DUDP00210(:,1),DUDP00225(:,1),DUDP00250(:,1),DUDP00275(:,1),...
       DUDP00290(:,1),DUDP002100(:,1),...
            'VariableNames',{'DUDP00210','DUDP00225','DUDP00250',...
            'DUDP00275','DUDP00290','DUDP002100'});
  DUDP002TT = table2timetable(DUDP002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUDP002Table DUDP002TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUDP002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dudp02str=strcat('Created DUDP002Table-','Contains Dry Dust Deposition Bin 02-',num2str(17));
  fprintf(fid,'%s\n',dudp02str);

%% Create the Dry Dust Deposition Bin 003 ikind=18
  DUDP003Table=table(DUDP00310(:,1),DUDP00325(:,1),DUDP00350(:,1),DUDP00375(:,1),...
       DUDP00390(:,1),DUDP003100(:,1),...
            'VariableNames',{'DUDP00310','DUDP00325','DUDP00350',...
            'DUDP00375','DUDP00390','DUDP003100'});
  DUDP003TT = table2timetable(DUDP003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUDP003Table DUDP003TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUDP003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dudp03str=strcat('Created DUDP003Table-','Contains Dry Dust Deposition Bin 03-',num2str(18));
  fprintf(fid,'%s\n',dudp03str);

%% Create the Dry Dust Deposition Bin 004 ikind=19
  DUDP004Table=table(DUDP00410(:,1),DUDP00425(:,1),DUDP00450(:,1),DUDP00475(:,1),...
       DUDP00490(:,1),DUDP004100(:,1),...
            'VariableNames',{'DUDP00410','DUDP00425','DUDP00450',...
            'DUDP00475','DUDP00490','DUDP004100'});
  DUDP004TT = table2timetable(DUDP004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUDP004Table DUDP004TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUDP004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dudp04str=strcat('Created DUDP004Table-','Contains Dry Dust Deposition Bin 04-',num2str(19));
  fprintf(fid,'%s\n',dudp04str);

%% Create the Dry Dust Deposition Bin 005 ikind=20
  DUDP005Table=table(DUDP00510(:,1),DUDP00525(:,1),DUDP00550(:,1),DUDP00575(:,1),...
       DUDP00590(:,1),DUDP005100(:,1),...
            'VariableNames',{'DUDP00510','DUDP00525','DUDP00550',...
            'DUDP00575','DUDP00590','DUDP005100'});
  DUDP005TT = table2timetable(DUDP005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUDP005Table DUDP005TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUDP005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dudp05str=strcat('Created DUDP005Table-','Contains Dry Dust Deposition Bin 05-',num2str(20));
  fprintf(fid,'%s\n',dudp05str);

%% Create the Dry Dust Emission Bin 001 ikind=21
  DUEM001Table=table(DUEM00150(:,1),DUEM00175(:,1),DUEM00190(:,1),DUEM00195(:,1),...
       DUEM00198(:,1),DUEM001100(:,1),...
            'VariableNames',{'DUEM00150','DUEM00175','DUEM00190',...
            'DUEM00195','DUEM00198','DUEM001100'});
  DUEM001TT = table2timetable(DUEM001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUEM001Table DUEM001TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUEM001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duem01str=strcat('Created DUEM001Table-','Contains Dry Dust Emission Bin 01-',num2str(21));
  fprintf(fid,'%s\n',duem01str);

%% Create the Dry Dust Emission Bin 002 ikind=22
  DUEM002Table=table(DUEM00250(:,1),DUEM00275(:,1),DUEM00290(:,1),DUEM00295(:,1),...
       DUEM00298(:,1),DUEM002100(:,1),...
            'VariableNames',{'DUEM00250','DUEM00275','DUEM00290',...
            'DUEM00295','DUEM00298','DUEM002100'});
  DUEM002TT = table2timetable(DUEM002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUEM002Table DUEM002TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUEM002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duem02str=strcat('Created DUEM002Table-','Contains Dry Dust Emission Bin 02-',num2str(22));
  fprintf(fid,'%s\n',duem02str);

%% Create the Dry Dust Emission Bin 003 ikind=23
  DUEM003Table=table(DUEM00350(:,1),DUEM00375(:,1),DUEM00390(:,1),DUEM00395(:,1),...
       DUEM00398(:,1),DUEM003100(:,1),...
            'VariableNames',{'DUEM00350','DUEM00375','DUEM00390',...
            'DUEM00395','DUEM00398','DUEM003100'});
  DUEM003TT = table2timetable(DUEM003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUEM003Table DUEM003TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUEM003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duem03str=strcat('Created DUEM003Table-','Contains Dry Dust Emission Bin 03-',num2str(23));
  fprintf(fid,'%s\n',duem03str);

%% Create the Dry Dust Emission Bin 004 ikind=24
  DUEM004Table=table(DUEM00450(:,1),DUEM00475(:,1),DUEM00490(:,1),DUEM00495(:,1),...
       DUEM00498(:,1),DUEM004100(:,1),...
            'VariableNames',{'DUEM00450','DUEM00475','DUEM00490',...
            'DUEM00495','DUEM00498','DUEM004100'});
  DUEM004TT = table2timetable(DUEM004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUEM004Table DUEM004TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUEM004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duem04str=strcat('Created DUEM004Table-','Contains Dry Dust Emission Bin 04-',num2str(24));
  fprintf(fid,'%s\n',duem04str);

%% Create the Dry Dust Emission Bin 005 ikind=25
  DUEM005Table=table(DUEM00550(:,1),DUEM00525(:,1),DUEM00575(:,1),DUEM00495(:,1),...
       DUEM00598(:,1),DUEM005100(:,1),...
            'VariableNames',{'DUEM00550','DUEM00575','DUEM00590',...
            'DUEM00595','DUEM00598','DUEM005100'});
  DUEM005TT = table2timetable(DUEM005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUEM005Table DUEM005TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUEM005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duem05str=strcat('Created DUEM005Table-','Contains Dry Dust Emission Bin 05-',num2str(25));
  fprintf(fid,'%s\n',duem05str);

%% Create the Dust Extinction ikind=26
  DUEXTable=table(DUEXT10(:,1),DUEXT25(:,1),DUEXT50(:,1),DUEXT75(:,1),...
       DUEXT90(:,1), DUEXT100(:,1),...
            'VariableNames',{'DUEXT10','DUEXT25','DUEXT50',...
            'DUEXT75','DUEXT90','DUEXT100'});
  DUEXTT = table2timetable(DUEXTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUEXTable DUEXTT YearMonthStr numtimeslice';
  MatFileName=strcat('DUEXTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duextstr=strcat('Created DUEXTable-','Contains Dust Extinction Coeff-',num2str(26));
  fprintf(fid,'%s\n',duextstr);

%% Create the Dust Scattering ikind=27
  DUSCATTable=table(DUSCAT10(:,1),DUSCAT25(:,1),DUSCAT50(:,1),DUSCAT75(:,1),...
       DUSCAT90(:,1), DUSCAT100(:,1),...
            'VariableNames',{'DUSCAT10','DUSCAT25','DUSCAT50',...
            'DUSCAT75','DUSCAT90','DUSCAT100'});
  DUSCATTT = table2timetable(DUSCATTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSCATTable DUSCATTT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSCATTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duscatstr=strcat('Created DUSCATTable-','Contains Dust Scattering Coeff-',num2str(27));
  fprintf(fid,'%s\n',duscatstr);

%% Create the Dust Sedimentation Table for  Bin 001 ikind=28
  DUSD001Table=table(DUSD00150(:,1),DUSD00175(:,1),DUSD00190(:,1),DUSD00195(:,1),...
       DUSD00198(:,1),DUSD001100(:,1),...
            'VariableNames',{'DUSD00150','DUSD00175','DUSD00190',...
            'DUSD00195','DUSD00198','DUSD001100'});
  DUSD001TT = table2timetable(DUSD001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSD001Table DUSD001TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSD001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusd01str=strcat('Created DUSD001Table-','Contains Dust Sedimentation Bin 01-',num2str(28));
  fprintf(fid,'%s\n',dusd01str);

%% Create the Dust Sedimentation Table for  Bin 002 ikind=29
  DUSD002Table=table(DUSD00250(:,1),DUSD00275(:,1),DUSD00290(:,1),DUSD00295(:,1),...
       DUSD00298(:,1),DUSD002100(:,1),...
            'VariableNames',{'DUSD00250','DUSD00275','DUSD00290',...
            'DUSD00295','DUSD00298','DUSD002100'});
  DUSD002TT = table2timetable(DUSD002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSD002Table DUSD002TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSD002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusd02str=strcat('Created DUSD002Table-','Contains Dust Sedimentation Bin 02-',num2str(29));
  fprintf(fid,'%s\n',dusd02str);

%% Create the Dust Sedimentation Table for  Bin 003 ikind=30
  DUSD003Table=table(DUSD00350(:,1),DUSD00375(:,1),DUSD00390(:,1),DUSD00395(:,1),...
       DUSD00398(:,1),DUSD003100(:,1),...
            'VariableNames',{'DUSD00350','DUSD00375','DUSD00390',...
            'DUSD00395','DUSD00398','DUSD003100'});
  DUSD003TT = table2timetable(DUSD003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSD003Table DUSD003TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSD003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusd03str=strcat('Created DUSD003Table-','Contains Dust Sedimentation Bin 03-',num2str(30));
  fprintf(fid,'%s\n',dusd03str);

 %% Create the Dust Sedimentation Table for  Bin 004 ikind=31
  DUSD004Table=table(DUSD00450(:,1),DUSD00475(:,1),DUSD00490(:,1),DUSD00495(:,1),...
       DUSD00498(:,1),DUSD004100(:,1),...
            'VariableNames',{'DUSD00450','DUSD00475','DUSD00490',...
            'DUSD00495','DUSD00498','DUSD004100'});
  DUSD004TT = table2timetable(DUSD004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSD004Table DUSD004TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSD004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusd04str=strcat('Created DUSD004Table-','Contains Dust Sedimentation Bin 04-',num2str(31));
  fprintf(fid,'%s\n',dusd04str);

%% Create the Dust Sedimentation Table for  Bin 005 ikind=32
  DUSD005Table=table(DUSD00550(:,1),DUSD00575(:,1),DUSD00590(:,1),DUSD00595(:,1),...
       DUSD00598(:,1),DUSD005100(:,1),...
            'VariableNames',{'DUSD00550','DUSD00575','DUSD00590',...
            'DUSD00595','DUSD00598','DUSD005100'});
  DUSD005TT = table2timetable(DUSD005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSD005Table DUSD005TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSD005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusd05str=strcat('Created DUSD005Table-','Contains Dust Sedimentation Bin 05-',num2str(32));
  fprintf(fid,'%s\n',dusd05str);

  %% Create the Dust Convective Scavenging Table for  Bin 001 ikind=33
  DUSV001Table=table(DUSV00150(:,1),DUSV00175(:,1),DUSV00190(:,1),DUSV00195(:,1),...
       DUSV00198(:,1),DUSV001100(:,1),...
            'VariableNames',{'DUSV00150','DUSV00175','DUSV00190',...
            'DUSV00195','DUSV00198','DUSV001100'});
  DUSV001TT = table2timetable(DUSV001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSV001Table DUSV001TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSV001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusv01str=strcat('Created DUSV001Table-','Contains Dust Scavenging Bin 01-',num2str(33));
  fprintf(fid,'%s\n',dusv01str);

  %% Create the Dust Convective Scavenging Table for  Bin 002 ikind=34
  DUSV002Table=table(DUSV00250(:,1),DUSV00275(:,1),DUSV00290(:,1),DUSV00295(:,1),...
       DUSV00298(:,1),DUSV002100(:,1),...
            'VariableNames',{'DUSV00250','DUSV00275','DUSV00290',...
            'DUSV00295','DUSV00298','DUSV002100'});
  DUSV002TT = table2timetable(DUSV002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSV002Table DUSV002TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSV002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusv02str=strcat('Created DUSV002Table-','Contains Dust Scavenging Bin 02-',num2str(34));
  fprintf(fid,'%s\n',dusv02str);

  %% Create the Dust Convective Scavenging Table for  Bin 003 ikind=35
  DUSV003Table=table(DUSV00350(:,1),DUSV00375(:,1),DUSV00390(:,1),DUSV00395(:,1),...
       DUSV00398(:,1),DUSV003100(:,1),...
            'VariableNames',{'DUSV00350','DUSV00375','DUSV00390',...
            'DUSV00395','DUSV00398','DUSV003100'});
  DUSV003TT = table2timetable(DUSV003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSV003Table DUSV003TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSV003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusv03str=strcat('Created DUSV003Table-','Contains Dust Scavenging Bin 03-',num2str(35));
  fprintf(fid,'%s\n',dusv03str);

  %% Create the Dust Convective Scavenging Table for  Bin 004 ikind=36
  DUSV004Table=table(DUSV00450(:,1),DUSV00475(:,1),DUSV00490(:,1),DUSV00495(:,1),...
       DUSV00498(:,1),DUSV004100(:,1),...
            'VariableNames',{'DUSV00450','DUSV00475','DUSV00490',...
            'DUSV00495','DUSV00498','DUSV004100'});
  DUSV004TT = table2timetable(DUSV004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSV004Table DUSV004TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSV004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusv04str=strcat('Created DUSV004Table-','Contains Dust Scavenging Bin 04-',num2str(36));
  fprintf(fid,'%s\n',dusv04str);

  %% Create the Dust Convective Scavenging Table for  Bin 005 ikind=37
  DUSV005Table=table(DUSV00550(:,1),DUSV00575(:,1),DUSV00590(:,1),DUSV00595(:,1),...
       DUSV00598(:,1),DUSV005100(:,1),...
            'VariableNames',{'DUSV00550','DUSV00575','DUSV00590',...
            'DUSV00595','DUSV00598','DUSV005100'});
  DUSV005TT = table2timetable(DUSV005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUSV005Table DUSV005TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUSV005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  dusv05str=strcat('Created DUSV005Table-','Contains Dust Scavenging Bin 05-',num2str(37));
  fprintf(fid,'%s\n',dusv05str);

%% Create the Wet Dust Deposition Table for  Bin 001 ikind=38
  DUWT001Table=table(DUWT00150(:,1),DUWT00175(:,1),DUWT00190(:,1),DUWT00195(:,1),...
       DUWT00198(:,1),DUWT001100(:,1),...
            'VariableNames',{'DUWT00150','DUWT00175','DUWT00190',...
            'DUWT00195','DUWT00198','DUWT001100'});
  DUWT001TT = table2timetable(DUWT001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUWT001Table DUWT001TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUWT001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duwt01str=strcat('Created DUWT001Table-','Contains Wet Dust Deposition Bin 01-',num2str(38));
  fprintf(fid,'%s\n',duwt01str);

%% Create the Wet Dust Deposition Table for  Bin 002 ikind=39
  DUWT002Table=table(DUWT00250(:,1),DUWT00275(:,1),DUWT00290(:,1),DUWT00295(:,1),...
       DUWT00298(:,1),DUWT002100(:,1),...
            'VariableNames',{'DUWT00250','DUWT00275','DUWT00290',...
            'DUWT00295','DUWT00298','DUWT002100'});
  DUWT002TT = table2timetable(DUWT002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUWT002Table DUWT002TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUWT001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duwt02str=strcat('Created DUWT002Table-','Contains Wet Dust Deposition Bin 02-',num2str(39));
  fprintf(fid,'%s\n',duwt02str);

%% Create the Wet Dust Deposition Table for  Bin 003 ikind=40
  DUWT003Table=table(DUWT00350(:,1),DUWT00375(:,1),DUWT00390(:,1),DUWT00395(:,1),...
       DUWT00398(:,1),DUWT003100(:,1),...
            'VariableNames',{'DUWT00350','DUWT00375','DUWT00390',...
            'DUWT00395','DUWT00398','DUWT003100'});
  DUWT003TT = table2timetable(DUWT003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUWT003Table DUWT003TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUWT003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duwt03str=strcat('Created DUWT003Table-','Contains Wet Dust Deposition Bin 03-',num2str(40));
  fprintf(fid,'%s\n',duwt03str);

%% Create the Wet Dust Deposition Table for  Bin 004 ikind=41
  DUWT004Table=table(DUWT00450(:,1),DUWT00475(:,1),DUWT00490(:,1),DUWT00495(:,1),...
       DUWT00498(:,1),DUWT004100(:,1),...
            'VariableNames',{'DUWT00450','DUWT00475','DUWT00490',...
            'DUWT00495','DUWT00498','DUWT004100'});
  DUWT004TT = table2timetable(DUWT004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUWT004Table DUWT004TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUWT004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duwt04str=strcat('Created DUWT004Table-','Contains Wet Dust Deposition Bin 04-',num2str(41));
  fprintf(fid,'%s\n',duwt04str);

%% Create the Wet Dust Deposition Table for  Bin 005 ikind=42
  DUWT005Table=table(DUWT00550(:,1),DUWT00575(:,1),DUWT00590(:,1),DUWT00595(:,1),...
       DUWT00598(:,1),DUWT005100(:,1),...
            'VariableNames',{'DUWT00550','DUWT00575','DUWT00590',...
            'DUWT00595','DUWT00598','DUWT005100'});
  DUWT005TT = table2timetable(DUWT005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='DUWT005Table DUWT005TT YearMonthStr numtimeslice';
  MatFileName=strcat('DUWT005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  duwt05str=strcat('Created DUWT005Table-','Contains Wet Dust Deposition Bin 05-',num2str(42));
  fprintf(fid,'%s\n',duwt05str);

 %% Create the Dry Organic Carbon Deposition Table for  Bin 001 ikind=45
  OCDP001Table=table(OCDP00150(:,1),OCDP00175(:,1),OCDP00190(:,1),OCDP00195(:,1),...
       OCDP00198(:,1),OCDP001100(:,1),...
            'VariableNames',{'OCDP00150','OCDP00175','OCDP00190',...
            'OCDP00195','OCDP00198','OCDP001100'});
  OCDP001TT = table2timetable(OCDP001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCDP001Table OCDP001TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCDP001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocdp01str=strcat('Created OCDP001Table-','Contains Dry Organic Carbon Deposition Bin 01-',num2str(45));
  fprintf(fid,'%s\n',ocdp01str);

%% Create the Dry Organic Carbon Deposition Table for  Bin 002 ikind=46
  OCDP002Table=table(OCDP00250(:,1),OCDP00275(:,1),OCDP00290(:,1),OCDP00295(:,1),...
       OCDP00298(:,1),OCDP002100(:,1),...
            'VariableNames',{'OCDP00250','OCDP00275','OCDP00290',...
            'OCDP00295','OCDP00298','OCDP002100'});
  OCDP002TT = table2timetable(OCDP002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCDP002Table OCDP002TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCDP002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocdp02str=strcat('Created OCDP002Table-','Contains Dry Organic Carbon Deposition Bin 02-',num2str(46));
  fprintf(fid,'%s\n',ocdp02str);

 %% Create the Organic Carbon Emissiom Table for  Bin 001 ikind=47
  OCEM001Table=table(OCEM00150(:,1),OCEM00175(:,1),OCEM00190(:,1),OCEM00195(:,1),...
       OCEM00198(:,1),OCEM001100(:,1),...
            'VariableNames',{'OCEM00150','OCEM00175','OCEM00190',...
            'OCEM00195','OCEM00198','OCEM001100'});
  OCEM001TT = table2timetable(OCEM001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCEM001Table OCEM001TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCEM001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocem01str=strcat('Created OCEM001Table-','Contains Organic Carbon Emission Bin 01-',num2str(47));
  fprintf(fid,'%s\n',ocem01str);

%% Create the Organic Carbon Emissiom Table for  Bin 002 ikind=48
  OCEM002Table=table(OCEM00250(:,1),OCEM00275(:,1),OCEM00290(:,1),OCEM00295(:,1),...
       OCEM00298(:,1),OCEM002100(:,1),...
            'VariableNames',{'OCEM00250','OCEM00275','OCEM00290',...
            'OCEM00295','OCEM00298','OCEM002100'});
  OCEM002TT = table2timetable(OCEM002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCEM002Table OCEM002TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCEM002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocem02str=strcat('Created OCEM002Table-','Contains Organic Carbon Emission Bin 02-',num2str(48));
  fprintf(fid,'%s\n',ocem02str);

%% Create the Organic Carbon Antropogenic Emissiom Table for ikind=49
  OCEMANTable=table(OCEMAN50(:,1),OCEMAN75(:,1),OCEMAN90(:,1),OCEMAN95(:,1),...
       OCEMAN98(:,1),OCEMAN100(:,1),...
            'VariableNames',{'OCEMAN50','OCEMAN75','OCEMAN90',...
            'OCEMAN95','OCEMAN98','OCEMAN100'});
  OCEMANTT = table2timetable(OCEMANTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCEMANTable OCEMANTT YearMonthStr numtimeslice';
  MatFileName=strcat('OCEMANTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocmanstr=strcat('Created OCEMANTable-','Contains Organic Carbon Antropogenic Emission-',num2str(49));
  fprintf(fid,'%s\n',ocmanstr);

%% Create the Organic Carbon Biomass Burning Emissiom Table for ikind=50
  OCEMBBTable=table(OCEMBB50(:,1),OCEMBB75(:,1),OCEMBB90(:,1),OCEMBB95(:,1),...
       OCEMBB98(:,1),OCEMBB100(:,1),...
            'VariableNames',{'OCEMBB50','OCEMBB75','OCEMBB90',...
            'OCEMBB95','OCEMBB98','OCEMBB100'});
  OCEMBBTT = table2timetable(OCEMBBTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCEMBBTable OCEMBBTT YearMonthStr numtimeslice';
  MatFileName=strcat('OCEMBBTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocmbbstr=strcat('Created OCEMBBTable-','Contains Organic Carbon Biomass Burning Emission-',num2str(50));
  fprintf(fid,'%s\n',ocmbbstr);

%% Create the Organic Carbon Biofuel Emission Table for ikind=51
  OCEMBFTable=table(OCEMBF50(:,1),OCEMBF75(:,1),OCEMBF90(:,1),OCEMBF95(:,1),...
       OCEMBF98(:,1),OCEMBF100(:,1),...
            'VariableNames',{'OCEMBF50','OCEMBF75','OCEMBF90',...
            'OCEMBF95','OCEMBF98','OCEMBF100'});
  OCEMBFTT = table2timetable(OCEMBFTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCEMBFTable OCEMBFTT YearMonthStr numtimeslice';
  MatFileName=strcat('OCEMBFTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocmbfstr=strcat('Created OCEMBFTable-','Contains Organic Carbon Biofuel Emission-',num2str(51));
  fprintf(fid,'%s\n',ocmbfstr);

%% Create the Organic Carbon Biogenic  Emission Table for ikind=52
  OCEMBGTable=table(OCEMBG50(:,1),OCEMBG75(:,1),OCEMBG90(:,1),OCEMBG95(:,1),...
       OCEMBG98(:,1),OCEMBG100(:,1),...
            'VariableNames',{'OCEMBG50','OCEMBG75','OCEMBG90',...
            'OCEMBG95','OCEMBG98','OCEMBG100'});
  OCEMBGTT = table2timetable(OCEMBGTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCEMBGTable OCEMBGTT YearMonthStr numtimeslice';
  MatFileName=strcat('OCEMBBTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocmbgstr=strcat('Created OCEMBGTable-','Contains Organic Carbon Biogenic Emission-',num2str(52));
  fprintf(fid,'%s\n',ocmbgstr);

%% Create the Organic Carbon Hydrophobic To Hydrophilic Table for ikind=53
  OCHYPHILTable=table(OCHYPHIL50(:,1),OCHYPHIL75(:,1),OCHYPHIL90(:,1),OCHYPHIL95(:,1),...
       OCHYPHIL98(:,1),OCHYPHIL100(:,1),...
            'VariableNames',{'OCHYPHIL50','OCHYPHIL75','OCHYPHIL90',...
            'OCHYPHIL95','OCHYPHIL98','OCHYPHIL100'});
  OCHYPHILTT = table2timetable(OCHYPHILTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCHYPHILTable OCHYPHILTT YearMonthStr numtimeslice';
  MatFileName=strcat('OCHYPHILTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ochyphilgstr=strcat('Created OCHYPHILTable-','Contains Organic Carbon Hydrophobic to Hydrophilic-',num2str(53));
  fprintf(fid,'%s\n',ochyphilgstr);

%% Create the Organic Carbon Sedimentation Bin001 Table for ikind=54
  OCSD001Table=table(OCSD00150(:,1),OCSD00175(:,1),OCSD00190(:,1),OCSD00195(:,1),...
       OCSD00198(:,1),OCSD001100(:,1),...
            'VariableNames',{'OCSD00150','OCSD00175','OCSD00190',...
            'OCSD00195','OCSD00198','OCSD001100'});
  OCSD001TT = table2timetable(OCSD001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCSD001Table OCSD001TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCSD001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocsd01str=strcat('Created OCSD001Table-','Contains Organic Carbon Sedimentation Bin 001-',num2str(54));
  fprintf(fid,'%s\n',ocsd01str);

%% Create the Organic Carbon Sedimentation Bin002 Table for ikind=55
  OCSD002Table=table(OCSD00250(:,1),OCSD00275(:,1),OCSD00290(:,1),OCSD00295(:,1),...
       OCSD00298(:,1),OCSD002100(:,1),...
            'VariableNames',{'OCSD00250','OCSD00275','OCSD00290',...
            'OCSD00295','OCSD00298','OCSD002100'});
  OCSD002TT = table2timetable(OCSD002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCSD002Table OCSD002TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCSD002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocsd02str=strcat('Created OCSD002Table-','Contains Organic Carbon Sedimentation Bin 002-',num2str(55));
  fprintf(fid,'%s\n',ocsd02str);

  %% Create the Organic Carbon Convective Scavenging Bin001 Table for ikind=56
  OCSV001Table=table(OCSV00150(:,1),OCSV00175(:,1),OCSV00190(:,1),OCSV00195(:,1),...
       OCSV00198(:,1),OCSV001100(:,1),...
            'VariableNames',{'OCSV00150','OCSV00175','OCSV00190',...
            'OCSV00195','OCSV00198','OCSV001100'});
  OCSV001TT = table2timetable(OCSV001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCSV001Table OCSV001TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCSV001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocsv01str=strcat('Created OCSV001Table-','Contains Organic Carbon Convective Scavenging Bin 001-',num2str(56));
  fprintf(fid,'%s\n',ocsv01str);

  %% Create the Organic Carbon Convective Scavenging Bin002 Table for ikind=57
  OCSV002Table=table(OCSV00250(:,1),OCSV00275(:,1),OCSV00290(:,1),OCSV00295(:,1),...
       OCSV00298(:,1),OCSV002100(:,1),...
            'VariableNames',{'OCSV00250','OCSV00275','OCSV00290',...
            'OCSV00295','OCSV00298','OCSV002100'});
  OCSV002TT = table2timetable(OCSV002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCSV002Table OCSV002TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCSV002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocsv02str=strcat('Created OCSV002Table-','Contains Organic Carbon Convective Scavenging Bin 002-',num2str(57));
  fprintf(fid,'%s\n',ocsv01str);

 %% Create the Organic Wet Carbon Deposition Bin001 Table for ikind=58
  OCWT001Table=table(OCWT00150(:,1),OCWT00175(:,1),OCWT00190(:,1),OCWT00195(:,1),...
       OCWT00198(:,1),OCWT001100(:,1),...
            'VariableNames',{'OCWT00150','OCWT00175','OCWT00190',...
            'OCWT00195','OCWT00198','OCWT001100'});
  OCWT001TT = table2timetable(OCWT001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCWT001Table OCWT001TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCWT001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocwt01str=strcat('Created OCWT001Table-','Contains Organic Wet Carbon Deposition  Bin 001-',num2str(58));
  fprintf(fid,'%s\n',ocwt01str);

%% Create the Organic Wet Carbon Deposition Bin002 Table for ikind=59
  OCWT002Table=table(OCWT00250(:,1),OCWT00275(:,1),OCWT00290(:,1),OCWT00295(:,1),...
       OCWT00298(:,1),OCWT002100(:,1),...
            'VariableNames',{'OCWT00250','OCWT00275','OCWT00290',...
            'OCWT00295','OCWT00298','OCWT002100'});
  OCWT002TT = table2timetable(OCWT002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='OCWT002Table OCWT002TT YearMonthStr numtimeslice';
  MatFileName=strcat('OCWT002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ocwt02str=strcat('Created OCWT002Table-','Contains Organic Wet Carbon Deposition  Bin 002-',num2str(59));
  fprintf(fid,'%s\n',ocwt02str);

%% Create the SO2 Antropogenic Emissions Table for ikind=60
  SO2MANTable=table(SO2MAN50(:,1),SO2MAN75(:,1),SO2MAN90(:,1),SO2MAN95(:,1),...
       SO2MAN98(:,1),SO2MAN100(:,1),...
            'VariableNames',{'SO2MAN50','SO2MAN75','SO2MAN90',...
            'SO2MAN95','SO2MAN98','SO2MAN100'});
  SO2MANTT = table2timetable(SO2MANTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SO2MANTable SO2MANTT YearMonthStr numtimeslice';
  MatFileName=strcat('SO2MANTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  so2manstr=strcat('Created SO2MANTable-','Contains SO2 Antropogenic Emissions-',num2str(60));
  fprintf(fid,'%s\n',so2manstr);

%% Create the SO2 Biomass Burning Emissions Table for ikind=61
  SO2MBBTable=table(SO2MBB50(:,1),SO2MBB75(:,1),SO2MBB90(:,1),SO2MBB95(:,1),...
       SO2MBB98(:,1),SO2MBB100(:,1),...
            'VariableNames',{'SO2MB50','SO2MB75','SO2MB90',...
            'SO2MB95','SO2MB98','SO2MB100'});
  SO2MBBTT = table2timetable(SO2MBBTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SO2MBBTable SO2MBBTT YearMonthStr numtimeslice';
  MatFileName=strcat('SO2MBBTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  so2mbbstr=strcat('Created SO2MBBTable-','Contains SO2 Biomass Burning Emissions-',num2str(61));
  
  fprintf(fid,'%s\n',so2mbbstr);

 %% Create the SO2 Explosive Volcanic Emissions Table for ikind=62
  SO2EMVETable=table(SO2EMVE50(:,1),SO2EMVE75(:,1),SO2EMVE90(:,1),SO2EMVE95(:,1),...
       SO2EMVE98(:,1),SO2EMVE100(:,1),...
            'VariableNames',{'SO2MVE50','SO2MVE75','SO2MVE90',...
            'SO2MVE95','SO2MVE98','SO2MVE100'});
  SO2EMVETT = table2timetable(SO2EMVETable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SO2EMVETable SO2EMVETT YearMonthStr numtimeslice';
  MatFileName=strcat('SO2EMVETable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  so2emvestr=strcat('Created SO2EMVETable-','Contains Explosive Volcanic Emissions-',num2str(62));
  fprintf(fid,'%s\n',so2emvestr);

 %% Create the SO2 Non Explosive Volcanic Emissions Table for ikind=63
  SO2EMVNTable=table(SO2EMVN50(:,1),SO2EMVN75(:,1),SO2EMVN90(:,1),SO2EMVN95(:,1),...
       SO2EMVN98(:,1),SO2EMVN100(:,1),...
            'VariableNames',{'SO2MVN50','SO2MVN75','SO2MVN90',...
            'SO2MVN95','SO2MVN98','SO2MVN100'});
  SO2EMVNTT = table2timetable(SO2EMVNTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SO2EMVNTable SO2EMVNTT YearMonthStr numtimeslice';
  MatFileName=strcat('SO2EMVNTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  so2emvnstr=strcat('Created SO2EMVNTable-','Contains Non-Explosive Volcanic Emissions-',num2str(63));
  fprintf(fid,'%s\n',so2emvnstr);

 %% Create the SO4 Antropogenic Emissions Table for ikind=64
  SO4EMANTable=table(SO4EMAN50(:,1),SO4EMAN75(:,1),SO4EMAN90(:,1),SO4EMAN95(:,1),...
       SO4EMAN98(:,1),SO4EMAN100(:,1),...
            'VariableNames',{'SO4MAN50','SO4MAN75','SO4MAN90',...
            'SO4MAN95','SO4MAN98','SO4MAN100'});
  SO4EMANTT = table2timetable(SO4EMANTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SO4EMANTable SO4EMANTT YearMonthStr numtimeslice';
  MatFileName=strcat('SO4EMANTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  so4emanstr=strcat('Created SO4EMANTable-','Contains SO4 Antropogenic Emissions-',num2str(64));
  fprintf(fid,'%s\n',so4emanstr);

 %% Create the Sea Salt  UV TOMS Index Table for ikind=65
  SSAERIDXTable=table(SSAERIDX50(:,1),SSAERIDX75(:,1),SSAERIDX90(:,1),SSAERIDX95(:,1),...
       SSAERIDX98(:,1),SSAERIDX100(:,1),...
            'VariableNames',{'SSAERIDX50','SSAERIDX75','SSAERIDX90',...
            'SSAERIDX95','SSAERIDX98','SSAERIDX100'});
  SSAERIDXTT = table2timetable(SSAERIDXTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSAERIDXTable SSAERIDXTT YearMonthStr numtimeslice';
  MatFileName=strcat('SSAERIDXTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssaeridxstr=strcat('Created SSAERIDXTable-','Contains Sea Salt UV TOMS Index-',num2str(65));
  fprintf(fid,'%s\n',ssaeridxstr);

  %% Create the Sea Salt Dry Deposition Bin 001 ikind=66
  SSDP001Table=table(SSDP00150(:,1),SSDP00175(:,1),SSDP00190(:,1),SSDP00195(:,1),...
       SSDP00198(:,1),SSDP001100(:,1),...
            'VariableNames',{'SSDP00150','SSDP00175','SSDP00190',...
            'SSDP00195','SSDP00198','SSDP001100'});
  SSDP001TT = table2timetable(SSDP001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSDP001Table SSDP001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSDP001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdp001str=strcat('Created SSDP001Table-','Contains Sea Salt Dry Deposition Bin 001-',num2str(66));
  fprintf(fid,'%s\n',ssdp001str);

  %% Create the Sea Salt Dry Deposition Bin 002 ikind=67
  SSDP002Table=table(SSDP00250(:,1),SSDP00275(:,1),SSDP00290(:,1),SSDP00295(:,1),...
       SSDP00298(:,1),SSDP002100(:,1),...
            'VariableNames',{'SSDP00250','SSDP00275','SSDP00290',...
            'SSDP00295','SSDP00298','SSDP002100'});
  SSDP002TT = table2timetable(SSDP002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSDP002Table SSDP002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSDP002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdp002str=strcat('Created SSDP002Table-','Contains Sea Salt Dry Deposition Bin 002-',num2str(67));
  fprintf(fid,'%s\n',ssdp002str);

  %% Create the Sea Salt Dry Deposition Bin 003 ikind=68
  SSDP003Table=table(SSDP00350(:,1),SSDP00375(:,1),SSDP00390(:,1),SSDP00395(:,1),...
       SSDP00398(:,1),SSDP003100(:,1),...
            'VariableNames',{'SSDP00350','SSDP00375','SSDP00390',...
            'SSDP00395','SSDP00398','SSDP003100'});
  SSDP003TT = table2timetable(SSDP003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSDP003Table SSDP003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSDP003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdp003str=strcat('Created SSDP003Table-','Contains Sea Salt Dry Deposition Bin 003-',num2str(68));
  fprintf(fid,'%s\n',ssdp003str);

  %% Create the Sea Salt Dry Deposition Bin 004 ikind=69
  SSDP004Table=table(SSDP00450(:,1),SSDP00475(:,1),SSDP00490(:,1),SSDP00495(:,1),...
       SSDP00498(:,1),SSDP004100(:,1),...
            'VariableNames',{'SSDP00450','SSDP00475','SSDP00490',...
            'SSDP00495','SSDP00498','SSDP004100'});
  SSDP004TT = table2timetable(SSDP004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSDP004Table SSDP004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSDP004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdp004str=strcat('Created SSDP004Table-','Contains Sea Salt Dry Deposition Bin 004-',num2str(69));
  fprintf(fid,'%s\n',ssdp004str);

  %% Create the Sea Salt Dry Deposition Bin 005 ikind=70
  SSDP005Table=table(SSDP00550(:,1),SSDP00575(:,1),SSDP00590(:,1),SSDP00595(:,1),...
       SSDP00598(:,1),SSDP005100(:,1),...
            'VariableNames',{'SSDP00550','SSDP00575','SSDP00590',...
            'SSDP00595','SSDP00598','SSDP005100'});
  SSDP005TT = table2timetable(SSDP005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSDP005Table SSDP005TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSDP005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdp005str=strcat('Created SSDP005Table-','Contains Sea Salt Dry Deposition Bin 005-',num2str(70));
  fprintf(fid,'%s\n',ssdp005str);

 %% Create the Sea Salt Emission Bin 001 ikind=71
  SSEM001Table=table(SSEM00150(:,1),SSEM00175(:,1),SSEM00190(:,1),SSEM00195(:,1),...
       SSEM00198(:,1),SSEM001100(:,1),...
            'VariableNames',{'SSEM00150','SSEM00175','SSEM00190',...
            'SSEM00195','SSEM00198','SSEM001100'});
  SSEM001TT = table2timetable(SSEM001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSEM001Table SSEM001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSEM001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdem001str=strcat('Created ssdem001strTable-','Contains Sea Emission Bin 001-',num2str(71));
  fprintf(fid,'%s\n',ssdem001str);

  %% Create the Sea Salt Emission Bin 002 ikind=72
  SSEM002Table=table(SSEM00250(:,1),SSEM00275(:,1),SSEM00290(:,1),SSEM00295(:,1),...
       SSEM00298(:,1),SSEM002100(:,1),...
            'VariableNames',{'SSEM00250','SSEM00275','SSEM00290',...
            'SSEM00295','SSEM00298','SSEM002100'});
  SSEM002TT = table2timetable(SSEM002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSEM002Table SSEM002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSEM002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdem002str=strcat('Created SSEM002Table-','Contains Sea Emission Bin 002-',num2str(72));
  fprintf(fid,'%s\n',ssdem002str);

 %% Create the Sea Salt Emission Bin 003 ikind=73
  SSEM003Table=table(SSEM00350(:,1),SSEM00375(:,1),SSEM00390(:,1),SSEM00395(:,1),...
       SSEM00398(:,1),SSEM003100(:,1),...
            'VariableNames',{'SSEM00350','SSEM00375','SSEM00390',...
            'SSEM00395','SSEM00398','SSEM003100'});
  SSEM003TT = table2timetable(SSEM003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSEM003Table SSEM003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSEM003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdem003str=strcat('Created SSEM003Table-','Contains Sea Emission Bin 003-',num2str(73));
  fprintf(fid,'%s\n',ssdem003str);

 %% Create the Sea Salt Emission Bin 004 ikind=74
  SSEM004Table=table(SSEM00450(:,1),SSEM00475(:,1),SSEM00490(:,1),SSEM00495(:,1),...
       SSEM00498(:,1),SSEM004100(:,1),...
            'VariableNames',{'SSEM00450','SSEM00475','SSEM00490',...
            'SSEM00495','SSEM00498','SSEM004100'});
  SSEM004TT = table2timetable(SSEM004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSEM004Table SSEM004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSEM004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdem004str=strcat('Created SSEM004Table-','Contains Sea Emission Bin 004-',num2str(74));
  fprintf(fid,'%s\n',ssdem004str);

 %% Create the Sea Salt Emission Bin 005 ikind=75
  SSEM005Table=table(SSEM00550(:,1),SSEM00575(:,1),SSEM00590(:,1),SSEM00595(:,1),...
       SSEM00598(:,1),SSEM005100(:,1),...
            'VariableNames',{'SSEM00550','SSEM00575','SSEM00590',...
            'SSEM00595','SSEM00598','SSEM005100'});
  SSEM005TT = table2timetable(SSEM005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSEM005Table SSEM005TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSEM005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssdem005str=strcat('Created SSEM005Table-','Contains Sea Emission Bin 005-',num2str(75));
  fprintf(fid,'%s\n',ssdem005str);

 %% Create the Sea Salt Extinction ikind=76
  SSEXTTFMTable=table(SSEXTTFM50(:,1),SSEXTTFM75(:,1),SSEXTTFM90(:,1),SSEXTTFM95(:,1),...
       SSEXTTFM98(:,1),SSEXTTFM100(:,1),...
            'VariableNames',{'SSEXTTFM50','SSEXTTFM75','SSEXTTFM90',...
            'SSEXTTFM95','SSEXTTFM98','SSEXTTFM100'});
  SSEXTTFMTT = table2timetable(SSEXTTFMTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSEXTTFMTable SSEXTTFMTT YearMonthStr numtimeslice';
  MatFileName=strcat('SSEXTTFMTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssexttfmstr=strcat('Created SSEXTTFMTable-','Contains Sea Salt Extinction-',num2str(76));
  fprintf(fid,'%s\n',ssexttfmstr);

  %% Create the Sea Salt Scattering ikind=77
  SSSCATFMTable=table(SSSCATFM50(:,1),SSSCATFM75(:,1),SSSCATFM90(:,1),SSSCATFM95(:,1),...
       SSSCATFM98(:,1),SSSCATFM100(:,1),...
            'VariableNames',{'SSSCATFM50','SSSCATFM75','SSSCATFM90',...
            'SSSCATFM95','SSSCATFM98','SSSCATFM100'});
  SSSCATFMTT = table2timetable(SSSCATFMTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSCATFMTable SSSCATFMTT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSCATFMTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  ssscatfmstr=strcat('Created SSSCATFMTable-','Contains Sea Salt Scattering-',num2str(77));
  fprintf(fid,'%s\n',ssscatfmstr);

 %% Create the Sea Salt Sedimention Bin 01 ikind=78
  SSSD001Table=table(SSSD00150(:,1),SSSD00175(:,1),SSSD00190(:,1),SSSD00195(:,1),...
       SSSD00198(:,1),SSSD001100(:,1),...
            'VariableNames',{'SSSD00150','SSSD00175','SSSD00190',...
            'SSSD00195','SSSD00198','SSSD001100'});
  SSSD001TT = table2timetable(SSSD001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSD001Table SSSD001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSD001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssd001str=strcat('Created SSSD001Table-','Contains Sea Salt Sedimentation-',num2str(78));
  fprintf(fid,'%s\n',sssd001str);

  %% Create the Sea Salt Sedimention Bin 02 ikind=79
  SSSD002Table=table(SSSD00250(:,1),SSSD00275(:,1),SSSD00290(:,1),SSSD00295(:,1),...
       SSSD00298(:,1),SSSD002100(:,1),...
            'VariableNames',{'SSSD00250','SSSD00275','SSSD00290',...
            'SSSD00295','SSSD00298','SSSD002100'});
  SSSD002TT = table2timetable(SSSD002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSD002Table SSSD002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSD002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssd002str=strcat('Created SSSD002Table-','Contains Sea Salt Sedimentation-',num2str(79));
  fprintf(fid,'%s\n',sssd002str);

  %% Create the Sea Salt Sedimention Bin 03 ikind=80
  SSSD003Table=table(SSSD00350(:,1),SSSD00375(:,1),SSSD00390(:,1),SSSD00395(:,1),...
       SSSD00398(:,1),SSSD003100(:,1),...
            'VariableNames',{'SSSD00350','SSSD00375','SSSD00390',...
            'SSSD00395','SSSD00398','SSSD003100'});
  SSSD003TT = table2timetable(SSSD003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSD003Table SSSD003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSD003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssd003str=strcat('Created SSSD003Table-','Contains Sea Salt Sedimentation-',num2str(80));
  fprintf(fid,'%s\n',sssd003str);

  %% Create the Sea Salt Sedimention Bin 04 ikind=81
  SSSD004Table=table(SSSD00450(:,1),SSSD00475(:,1),SSSD00490(:,1),SSSD00495(:,1),...
       SSSD00498(:,1),SSSD004100(:,1),...
            'VariableNames',{'SSSD00450','SSSD00475','SSSD00490',...
            'SSSD00495','SSSD00498','SSSD004100'});
  SSSD004TT = table2timetable(SSSD004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSD004Table SSSD004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSD004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssd004str=strcat('Created SSSD004Table-','Contains Sea Salt Sedimentation-',num2str(81));
  fprintf(fid,'%s\n',sssd004str);

  %% Create the Sea Salt Sedimention Bin 05 ikind=82
  SSSD005Table=table(SSSD00550(:,1),SSSD00575(:,1),SSSD00590(:,1),SSSD00595(:,1),...
       SSSD00598(:,1),SSSD005100(:,1),...
            'VariableNames',{'SSSD00550','SSSD00575','SSSD00590',...
            'SSSD00595','SSSD00598','SSSD005100'});
  SSSD005TT = table2timetable(SSSD005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSD005Table SSSD005TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSD005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssd005str=strcat('Created SSSD005Table-','Contains Sea Salt Sedimentation-',num2str(82));
  fprintf(fid,'%s\n',sssd005str);

  %% Create the Sea Salt Convective Scavenging Bin 01 ikind=83
  SSSV001Table=table(SSSV00150(:,1),SSSV00175(:,1),SSSV00190(:,1),SSSV00195(:,1),...
       SSSV00198(:,1),SSSV001100(:,1),...
            'VariableNames',{'SSSV00150','SSSV00175','SSSV00190',...
            'SSSV00195','SSSV00198','SSSV001100'});
  SSSV001TT = table2timetable(SSSV001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSV001Table SSSV001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSV001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssv001str=strcat('Created SSSV001Table-','Contains Sea Salt Convective Scavenging-',num2str(83));
  fprintf(fid,'%s\n',sssv001str);

  %% Create the Sea Salt Convective Scavenging Bin 02 ikind=84
  SSSV002Table=table(SSSV00250(:,1),SSSV00275(:,1),SSSV00290(:,1),SSSV00295(:,1),...
       SSSV00298(:,1),SSSV002100(:,1),...
            'VariableNames',{'SSSV00250','SSSV00275','SSSV00290',...
            'SSSV00295','SSSV00298','SSSV002100'});
  SSSV002TT = table2timetable(SSSV002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSV002Table SSSV002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSV002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssv002str=strcat('Created SSSV002Table-','Contains Sea Salt Convective Scavenging-',num2str(84));
  fprintf(fid,'%s\n',sssv002str);

  %% Create the Sea Salt Convective Scavenging Bin 03 ikind=85
  SSSV003Table=table(SSSV00350(:,1),SSSV00375(:,1),SSSV00390(:,1),SSSV00395(:,1),...
       SSSV00398(:,1),SSSV003100(:,1),...
            'VariableNames',{'SSSV00350','SSSV00375','SSSV00390',...
            'SSSV00395','SSSV00398','SSSV003100'});
  SSSV003TT = table2timetable(SSSV003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSV003Table SSSV003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSV003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssv003str=strcat('Created SSSV003Table-','Contains Sea Salt Convective Scavenging-',num2str(85));
  fprintf(fid,'%s\n',sssv003str);

  %% Create the Sea Salt Convective Scavenging Bin 04 ikind=86
  SSSV004Table=table(SSSV00450(:,1),SSSV00475(:,1),SSSV00490(:,1),SSSV00495(:,1),...
       SSSV00498(:,1),SSSV004100(:,1),...
            'VariableNames',{'SSSV00450','SSSV00475','SSSV00490',...
            'SSSV00495','SSSV00498','SSSV004100'});
  SSSV004TT = table2timetable(SSSV004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSV004Table SSSV004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSV004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssv004str=strcat('Created SSSV004Table-','Contains Sea Salt Convective Scavenging-',num2str(86));
  fprintf(fid,'%s\n',sssv004str);

  %% Create the Sea Salt Convective Scavenging Bin 05 ikind=87
  SSSV005Table=table(SSSV00550(:,1),SSSV00575(:,1),SSSV00590(:,1),SSSV00595(:,1),...
       SSSV00598(:,1),SSSV005100(:,1),...
            'VariableNames',{'SSSV00550','SSSV00575','SSSV00590',...
            'SSSV00595','SSSV00598','SSSV005100'});
  SSSV005TT = table2timetable(SSSV005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSSV005Table SSSV005TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSSV005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sssv005str=strcat('Created SSSV005Table-','Contains Sea Salt Convective Scavenging-',num2str(87));
  fprintf(fid,'%s\n',sssv005str);

  %% Create the Sea Salt Wet Deposition Bin 01 ikind=88
  SSWT001Table=table(SSWT00150(:,1),SSWT00175(:,1),SSWT00190(:,1),SSWT00195(:,1),...
       SSWT00198(:,1),SSWT001100(:,1),...
            'VariableNames',{'SSWT00150','SSWT00175','SSWT00190',...
            'SSWT00195','SSWT00198','SSWT001100'});
  SSWT001TT = table2timetable(SSWT001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSWT001Table SSWT001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSWT001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sswt001str=strcat('Created SSWT001Table-','Contains Wet Deposition-',num2str(88));
  fprintf(fid,'%s\n',sswt001str);

  %% Create the Sea Salt Wet Deposition Bin 02 ikind=89
  SSWT002Table=table(SSWT00250(:,1),SSWT00275(:,1),SSWT00290(:,1),SSWT00295(:,1),...
       SSWT00298(:,1),SSWT002100(:,1),...
            'VariableNames',{'SSWT00250','SSWT00275','SSWT00290',...
            'SSWT00295','SSWT00298','SSWT002100'});
  SSWT002TT = table2timetable(SSWT002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSWT002Table SSWT002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSWT002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sswt002str=strcat('Created SSWT002Table-','Contains Wet Deposition-',num2str(89));
  fprintf(fid,'%s\n',sswt002str);

  %% Create the Sea Salt Wet Deposition Bin 03 ikind=90
  SSWT003Table=table(SSWT00350(:,1),SSWT00375(:,1),SSWT00390(:,1),SSWT00395(:,1),...
       SSWT00398(:,1),SSWT003100(:,1),...
            'VariableNames',{'SSWT00350','SSWT00375','SSWT00390',...
            'SSWT00395','SSWT00398','SSWT003100'});
  SSWT003TT = table2timetable(SSWT003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSWT003Table SSWT003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSWT003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sswt003str=strcat('Created SSWT003Table-','Contains Wet Deposition-',num2str(90));
  fprintf(fid,'%s\n',sswt003str);

  %% Create the Sea Salt Wet Deposition Bin 04 ikind=91
  SSWT004Table=table(SSWT00450(:,1),SSWT00475(:,1),SSWT00490(:,1),SSWT00495(:,1),...
       SSWT00498(:,1),SSWT004100(:,1),...
            'VariableNames',{'SSWT00450','SSWT00475','SSWT00490',...
            'SSWT00495','SSWT00498','SSWT004100'});
  SSWT004TT = table2timetable(SSWT004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSWT004Table SSWT004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSWT004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sswt004str=strcat('Created SSWT004Table-','Contains Wet Deposition-',num2str(91));
  fprintf(fid,'%s\n',sswt004str);

  %% Create the Sea Salt Wet Deposition Bin 05 ikind=92
  SSWT005Table=table(SSWT00550(:,1),SSWT00575(:,1),SSWT00590(:,1),SSWT00595(:,1),...
       SSWT00598(:,1),SSWT005100(:,1),...
            'VariableNames',{'SSWT00550','SSWT00575','SSWT00590',...
            'SSWT00595','SSWT00598','SSWT005100'});
  SSWT005TT = table2timetable(SSWT005Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SSWT005Table SSWT005TT YearMonthStr numtimeslice';
  MatFileName=strcat('SSWT005Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sswt005str=strcat('Created SSWT005Table-','Contains Wet Deposition-',num2str(92));
  fprintf(fid,'%s\n',sswt005str);

  %% Create the Sulfate Dry Deposition Bin 01 ikind=93
  SUDP001Table=table(SUDP00150(:,1),SUDP00175(:,1),SUDP00190(:,1),SUDP00195(:,1),...
       SUDP00198(:,1),SUDP001100(:,1),...
            'VariableNames',{'SUDP00150','SUDP00175','SUDP00190',...
            'SUDP00195','SUDP00198','SUDP001100'});
  SUDP001TT = table2timetable(SUDP001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUDP001Table SUDP001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUDP001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sudp001str=strcat('Created SUDP001Table-','Contains Dry Sulfa Deposition-',num2str(93));
  fprintf(fid,'%s\n',sudp001str);

  %% Create the Sulfate Dry Deposition Bin 02 ikind=94
  SUDP002Table=table(SUDP00250(:,1),SUDP00275(:,1),SUDP00290(:,1),SUDP00295(:,1),...
       SUDP00298(:,1),SUDP002100(:,1),...
            'VariableNames',{'SUDP00250','SUDP00275','SUDP00290',...
            'SUDP00295','SUDP00298','SUDP002100'});
  SUDP002TT = table2timetable(SUDP002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUDP002Table SUDP002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUDP002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sudp002str=strcat('Created SUDP002Table-','Contains Dry Sulfa Deposition-',num2str(94));
  fprintf(fid,'%s\n',sudp002str);

  %% Create the Sulfate Dry Deposition Bin 03 ikind=95
  SUDP003Table=table(SUDP00350(:,1),SUDP00375(:,1),SUDP00390(:,1),SUDP00395(:,1),...
       SUDP00398(:,1),SUDP003100(:,1),...
            'VariableNames',{'SUDP00350','SUDP00375','SUDP00390',...
            'SUDP00395','SUDP00398','SUDP003100'});
  SUDP003TT = table2timetable(SUDP003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUDP003Table SUDP003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUDP003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sudp003str=strcat('Created SUDP003Table-','Contains Dry Sulfa Deposition-',num2str(95));
  fprintf(fid,'%s\n',sudp003str);

  %% Create the Sulfate Dry Deposition Bin 04 ikind=96
  SUDP004Table=table(SUDP00450(:,1),SUDP00475(:,1),SUDP00490(:,1),SUDP00495(:,1),...
       SUDP00498(:,1),SUDP004100(:,1),...
            'VariableNames',{'SUDP00450','SUDP00475','SUDP00490',...
            'SUDP00495','SUDP00498','SUDP004100'});
  SUDP004TT = table2timetable(SUDP004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUDP004Table SUDP004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUDP004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sudp004str=strcat('Created SUDP004Table-','Contains Dry Sulfa Deposition-',num2str(96));
  fprintf(fid,'%s\n',sudp004str);

 %% Create the Sulfate Emission Bin 01 ikind=97
  SUEM001Table=table(SUEM00150(:,1),SUEM00175(:,1),SUEM00190(:,1),SUEM00195(:,1),...
       SUEM00198(:,1),SUEM001100(:,1),...
            'VariableNames',{'SUEM00150','SUEM00175','SUEM00190',...
            'SUEM00195','SUEM00198','SUEM001100'});
  SUEM001TT = table2timetable(SUEM001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUEM001Table SUEM001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUEM001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suem001str=strcat('Created SUEM001Table-','Contains Sulfur Emission-',num2str(97));
  fprintf(fid,'%s\n',suem001str);

  %% Create the Sulfate Emission Bin 02 ikind=98
  SUEM002Table=table(SUEM00250(:,1),SUEM00275(:,1),SUEM00290(:,1),SUEM00295(:,1),...
       SUEM00298(:,1),SUEM002100(:,1),...
            'VariableNames',{'SUEM00250','SUEM00275','SUEM00290',...
            'SUEM00295','SUEM00298','SUEM002100'});
  SUEM002TT = table2timetable(SUEM002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUEM002Table SUEM002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUEM002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suem002str=strcat('Created SUEM002Table-','Contains Sulfur Emission-',num2str(98));
  fprintf(fid,'%s\n',suem002str);

  %% Create the Sulfate Emission Bin 03 ikind=99
  SUEM003Table=table(SUEM00350(:,1),SUEM00375(:,1),SUEM00390(:,1),SUEM00395(:,1),...
       SUEM00398(:,1),SUEM003100(:,1),...
            'VariableNames',{'SUEM00350','SUEM00375','SUEM00390',...
            'SUEM00395','SUEM00398','SUEM003100'});
  SUEM003TT = table2timetable(SUEM003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUEM003Table SUEM003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUEM003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suem003str=strcat('Created SUEM003Table-','Contains Sulfur Emission-',num2str(99));
  fprintf(fid,'%s\n',suem003str);

  %% Create the Sulfate Emission Bin 04 ikind=100
  SUEM004Table=table(SUEM00450(:,1),SUEM00475(:,1),SUEM00490(:,1),SUEM00495(:,1),...
       SUEM00498(:,1),SUEM004100(:,1),...
            'VariableNames',{'SUEM00450','SUEM00475','SUEM00490',...
            'SUEM00495','SUEM00498','SUEM004100'});
  SUEM004TT = table2timetable(SUEM004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUEM004Table SUEM004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUEM004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suem004str=strcat('Created SUEM004Table-','Contains Sulfur Emission-',num2str(100));
  fprintf(fid,'%s\n',suem004str);

  %% Create the MSA Prod from DMS Oxidation ikind=101
  SUPMSATable=table(SUPMSA50(:,1),SUPMSA75(:,1),SUPMSA90(:,1),SUPMSA95(:,1),...
       SUPMSA98(:,1),SUPMSA100(:,1),...
            'VariableNames',{'SUPMSA50','SUPMSA75','SUPMSA90',...
            'SUPMSA95','SUPMSA98','SUPMSA100'});
  SUPMSATT = table2timetable(SUPMSATable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUPMSATable SUPMSATT YearMonthStr numtimeslice';
  MatFileName=strcat('SUPMSATable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  sumpsastr=strcat('Created SUPMSATable-','Contains MSA DMS Oxidation',num2str(101));
  fprintf(fid,'%s\n',sumpsastr);

  %% Create the SO2 Prod from DMS Oxidation ikind=102
  SUPSO2Table=table(SUPSO250(:,1),SUPSO275(:,1),SUPSO290(:,1),SUPSO295(:,1),...
       SUPSO298(:,1),SUPSO2100(:,1),...
            'VariableNames',{'SUPSO250','SUPSO275','SUPSO290',...
            'SUPSO295','SUPSO298','SUPSO2100'});
  SUPSO2TT = table2timetable(SUPSO2Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUPSO2Table SUPSO2TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUPSO2Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  supso2str=strcat('Created SUPSO2Table-','Contains SO2 DMS Oxidation',num2str(102));
  fprintf(fid,'%s\n',supso2str);

  %% Create the SO4 Prod from Aqueous SO2 Oxidation ikind=103
  SUPSO4AQTable=table(SUPSO4AQ50(:,1),SUPSO4AQ75(:,1),SUPSO4AQ90(:,1),SUPSO4AQ95(:,1),...
       SUPSO4AQ98(:,1),SUPSO4AQ100(:,1),...
            'VariableNames',{'SUPSO4AQ50','SUPSO4AQ75','SUPSO4AQ90',...
            'SUPSO4AQ95','SUPSO4AQ98','SUPSO4AQ100'});
  SUPSO4AQTT = table2timetable(SUPSO4AQTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUPSO4AQTable SUPSO4AQTT YearMonthStr numtimeslice';
  MatFileName=strcat('SUPSO4AQTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  supso4str=strcat('Created SUPSO4AQTable-','Contains SO4 From SO2 Oxidation',num2str(103));
  fprintf(fid,'%s\n',supso4str);

  %% Create the SO4 Prod from Gaseous SO2 Oxidation ikind=104
  SUPSO4GTable=table(SUPSO4G50(:,1),SUPSO4G75(:,1),SUPSO4G90(:,1),SUPSO4G95(:,1),...
       SUPSO4G98(:,1),SUPSO4G100(:,1),...
            'VariableNames',{'SUPSO4G50','SUPSO4G75','SUPSO4G90',...
            'SUPSO4G95','SUPSO4G98','SUPSO4G100'});
  SUPSO4GTT = table2timetable(SUPSO4GTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUPSO4GTable SUPSO4GTT YearMonthStr numtimeslice';
  MatFileName=strcat('SUPSO4GTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  supso4gstr=strcat('Created SUPSO4GTable-','Contains SO4 From SO2 Gaseous Oxidation',num2str(104));
  fprintf(fid,'%s\n',supso4gstr);

  %% Create the SO4 Prod from Aqueous SO2 Oxidation ikind=105
  SUPSO4WTTable=table(SUPSO4WT50(:,1),SUPSO4WT75(:,1),SUPSO4WT90(:,1),SUPSO4WT95(:,1),...
       SUPSO4WT98(:,1),SUPSO4WT100(:,1),...
            'VariableNames',{'SUPSO4WT50','SUPSO4WT75','SUPSO4WT90',...
            'SUPSO4WT95','SUPSO4WT98','SUPSO4WT100'});
  SUPSO4WTTT = table2timetable(SUPSO4WTTable,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUPSO4WTTable SUPSO4WTTT YearMonthStr numtimeslice';
  MatFileName=strcat('SUPSO4WTTable',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  supso4wtstr=strcat('Created SUPSO4WTTable-','Contains SO4 From SO2 Aqueous Oxidation',num2str(105));
  fprintf(fid,'%s\n',supso4wtstr);

  %% Create the Sulfate Sedimentation Bin 001 ikind=106
  SUSD001Table=table(SUSD00150(:,1),SUSD00175(:,1),SUSD00190(:,1),SUSD00195(:,1),...
       SUSD00198(:,1),SUSD001100(:,1),...
            'VariableNames',{'SUSD00150','SUSD00175','SUSD00190',...
            'SUSD00195','SUSD00198','SUSD001100'});
  SUSD001TT = table2timetable(SUSD001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSD001Table SUSD001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSD001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susd001str=strcat('Created SUSD001Table-','Contains Sulfate Sedimentation in Bin 001',num2str(106));
  fprintf(fid,'%s\n',susd001str);

  %% Create the Sulfate Sedimentation Bin 002 ikind=107
  SUSD002Table=table(SUSD00250(:,1),SUSD00275(:,1),SUSD00290(:,1),SUSD00295(:,1),...
       SUSD00298(:,1),SUSD002100(:,1),...
            'VariableNames',{'SUSD00250','SUSD00275','SUSD00290',...
            'SUSD00295','SUSD00298','SUSD002100'});
  SUSD002TT = table2timetable(SUSD002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSD002Table SUSD002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSD002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susd002str=strcat('Created SUSD002Table-','Contains Sulfate Sedimentation in Bin 001',num2str(107));
  fprintf(fid,'%s\n',susd002str);

  %% Create the Sulfate Sedimentation Bin 003 ikind=108
  SUSD003Table=table(SUSD00350(:,1),SUSD00375(:,1),SUSD00390(:,1),SUSD00395(:,1),...
       SUSD00398(:,1),SUSD003100(:,1),...
            'VariableNames',{'SUSD00350','SUSD00375','SUSD00390',...
            'SUSD00395','SUSD00398','SUSD003100'});
  SUSD003TT = table2timetable(SUSD003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSD003Table SUSD003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSD003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susd003str=strcat('Created SUSD003Table-','Contains Sulfate Sedimentation in Bin 003',num2str(108));
  fprintf(fid,'%s\n',susd003str);

  %% Create the Sulfate Sedimentation Bin 004 ikind=109
  SUSD004Table=table(SUSD00450(:,1),SUSD00475(:,1),SUSD00490(:,1),SUSD00495(:,1),...
       SUSD00498(:,1),SUSD004100(:,1),...
            'VariableNames',{'SUSD00450','SUSD00475','SUSD00490',...
            'SUSD00495','SUSD00498','SUSD004100'});
  SUSD004TT = table2timetable(SUSD004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSD004Table SUSD004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSD004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susd004str=strcat('Created SUSD004Table-','Contains Sulfate Sedimentation in Bin 004',num2str(109));
  fprintf(fid,'%s\n',susd004str);

  %% Create the Sulfate Convective Scavenging Bin 001 ikind=110
  SUSV001Table=table(SUSV00150(:,1),SUSV00175(:,1),SUSV00190(:,1),SUSV00195(:,1),...
       SUSV00198(:,1),SUSV001100(:,1),...
            'VariableNames',{'SUSV00150','SUSV00175','SUSV00190',...
            'SUSV00195','SUSV00198','SUSV001100'});
  SUSV001TT = table2timetable(SUSV001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSV001Table SUSV001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSV001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susv001str=strcat('Created SUSV001Table-','Contains Sulfate Convective Scavenging in Bin 001',num2str(110));
  fprintf(fid,'%s\n',susv001str);

  %% Create the Sulfate Convective Scavenging Bin 002 ikind=111
  SUSV002Table=table(SUSV00250(:,1),SUSV00275(:,1),SUSV00290(:,1),SUSV00295(:,1),...
       SUSV00298(:,1),SUSV002100(:,1),...
            'VariableNames',{'SUSV00250','SUSV00275','SUSV00290',...
            'SUSV00295','SUSV00298','SUSV002100'});
  SUSV002TT = table2timetable(SUSV002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSV002Table SUSV002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSV002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susv002str=strcat('Created SUSV002Table-','Contains Sulfate Convective Scavenging in Bin 002',num2str(111));
  fprintf(fid,'%s\n',susv002str);

  %% Create the Sulfate Convective Scavenging Bin 003 ikind=112
  SUSV003Table=table(SUSV00350(:,1),SUSV00375(:,1),SUSV00390(:,1),SUSV00395(:,1),...
       SUSV00398(:,1),SUSV003100(:,1),...
            'VariableNames',{'SUSV00350','SUSV00375','SUSV00390',...
            'SUSV00395','SUSV00398','SUSV003100'});
  SUSV003TT = table2timetable(SUSV003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSV003Table SUSV003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSV003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susv003str=strcat('Created SUSV003Table-','Contains Sulfate Convective Scavenging in Bin 003',num2str(112));
  fprintf(fid,'%s\n',susv003str);

  %% Create the Sulfate Convective Scavenging Bin 004 ikind=113
  SUSV004Table=table(SUSV00450(:,1),SUSV00475(:,1),SUSV00490(:,1),SUSV00495(:,1),...
       SUSV00498(:,1),SUSV004100(:,1),...
            'VariableNames',{'SUSV00450','SUSV00475','SUSV00490',...
            'SUSV00495','SUSV00498','SUSV004100'});
  SUSV004TT = table2timetable(SUSV004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUSV004Table SUSV004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUSV004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  susv004str=strcat('Created SUSV004Table-','Contains Sulfate Convective Scavenging in Bin 004',num2str(113));
  fprintf(fid,'%s\n',susv004str);

  %% Create the Sulfate Wet Deposition Bin 001 ikind=114
  SUWT001Table=table(SUWT00150(:,1),SUWT00175(:,1),SUWT00190(:,1),SUWT00195(:,1),...
       SUWT00198(:,1),SUWT001100(:,1),...
            'VariableNames',{'SUWT00150','SUWT00175','SUWT00190',...
            'SUWT00195','SUWT00198','SUWT001100'});
  SUWT001TT = table2timetable(SUWT001Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUWT001Table SUWT001TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUWT001Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suwt001str=strcat('Created SUWT001Table-','Contains Sulfate Wet Deposition in Bin 001',num2str(114));
  fprintf(fid,'%s\n',suwt001str);

  %% Create the Sulfate Wet Deposition Bin 002 ikind=115
  SUWT002Table=table(SUWT00250(:,1),SUWT00275(:,1),SUWT00290(:,1),SUWT00295(:,1),...
       SUWT00298(:,1),SUWT002100(:,1),...
            'VariableNames',{'SUWT00250','SUWT00275','SUWT00290',...
            'SUWT00295','SUWT00298','SUWT002100'});
  SUWT002TT = table2timetable(SUWT002Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUWT002Table SUWT002TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUWT002Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suwt002str=strcat('Created SUWT002Table-','Contains Sulfate Wet Deposition in Bin 002',num2str(115));
  fprintf(fid,'%s\n',suwt002str);

  %% Create the Sulfate Wet Deposition Bin 003 ikind=116
  SUWT003Table=table(SUWT00350(:,1),SUWT00375(:,1),SUWT00390(:,1),SUWT00395(:,1),...
       SUWT00398(:,1),SUWT003100(:,1),...
            'VariableNames',{'SUWT00350','SUWT00375','SUWT00390',...
            'SUWT00395','SUWT00398','SUWT003100'});
  SUWT003TT = table2timetable(SUWT003Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUWT003Table SUWT003TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUWT003Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suwt003str=strcat('Created SUWT003Table-','Contains Sulfate Wet Deposition in Bin 003',num2str(116));
  fprintf(fid,'%s\n',suwt003str);

  %% Create the Sulfate Wet Deposition Bin 004 ikind=117
  SUWT004Table=table(SUWT00450(:,1),SUWT00475(:,1),SUWT00490(:,1),SUWT00495(:,1),...
       SUWT00498(:,1),SUWT004100(:,1),...
            'VariableNames',{'SUWT00450','SUWT00475','SUWT00490',...
            'SUWT00495','SUWT00498','SUWT004100'});
  SUWT004TT = table2timetable(SUWT004Table,'TimeStep',timestep,'StartTime',stime);
  eval(['cd ' tablepath(1:length(tablepath)-1)]);
  actionstr='save';
  varstr1='SUWT004Table SUWT004TT YearMonthStr numtimeslice';
  MatFileName=strcat('SUWT004Table',YearMonthStr,'-',num2str(numtimeslice),'.mat');
  qualstr='-v7.3';
  [cmdString]=MyStrcatV73(actionstr,MatFileName,varstr1,qualstr);
  eval(cmdString)
  suwt004str=strcat('Created SUWT004Table-','Contains Sulfate Wet Deposition in Bin 004',num2str(117));
  fprintf(fid,'%s\n',suwt004str);


%% Plot the Cumilitive Dust Emission For a Single Country
 titlestr=strcat('CumilativeDustEmission-',DustROICountry,num2str(yd));
 iDustID=1;
 iAddToReport=1;
 iNewChapter=1;
 iCloseChapter=0;
 PlotDustEmissionTable(titlestr,iDustID,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Cumilitive Dust Emission For a The Whole World
 titlestr=strcat('WorldCumilativeDustEmission-',num2str(yd));
 iDustID=2;
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 PlotDustEmissionTable(titlestr,iDustID,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the Cumilitive Dust Deposition For One Country
 titlestr=strcat('CumilativeDustDeposition-',DustROICountry,num2str(yd));
 iDustID=3;
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 PlotDustEmissionTable(titlestr,iDustID,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Cumilitive Dust Deposition For The Whole World
 titlestr=strcat('WorldCumilativeDustDeposition-',num2str(yd));
 iDustID=4;
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 PlotDustEmissionTable(titlestr,iDustID,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Cumilitive Dust Sedimentation For The One Country
 titlestr=strcat('CumilativeDustSedimentation-',DustROICountry,num2str(yd));
 iDustID=5;
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=0;
 PlotDustEmissionTable(titlestr,iDustID,iAddToReport,iNewChapter,iCloseChapter)
%% Plot the Cumilitive Dust Sedimentation For The World
 titlestr=strcat('WorldCumilativeDustSedimentation-',num2str(yd));
 iDustID=6;
 iAddToReport=1;
 iNewChapter=0;
 iCloseChapter=1;
 PlotDustEmissionTable(titlestr,iDustID,iAddToReport,iNewChapter,iCloseChapter)
 if(iBlackCarbon~=0)
    %% Plot the dry Black Carbon Deposition in Bin 001
       titlestr=strcat('BlackCarbonDryDeposition-BIN001-',num2str(yd));
       ikind=1;
       iAddToReport=1;
       iNewChapter=1;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
    %% Plot the dry Black Carbon Deposition in Bin 002
       titlestr=strcat('BlackCarbonDryDeposition-BIN002-',num2str(yd));
       ikind=2;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the dry Black Carbon Emission in Bin 001
       titlestr=strcat('BlackCarbonEmission-BIN001-',num2str(yd));
       ikind=3;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the dry Black Carbon Emission in Bin 002
       titlestr=strcat('BlackCarbonEmission-BIN002-',num2str(yd),'-',num2str(hd));
       ikind=4;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the dry Black Carbon Antropogenic Emissions
       titlestr=strcat('BlackCarbonAntroEmission-',num2str(yd),'-',num2str(hd));
       ikind=5;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Burning Biomass Emissions
       titlestr=strcat('BlackCarbonBiomassEmission-',num2str(yd),'-',num2str(hd));
       ikind=6;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Biofuel Emissions
    %    titlestr=strcat('BlackCarbonBiofuelEmission-',num2str(yd),'-',num2str(hd));
    %    ikind=7;
    %    iAddToReport=1;
    %    iNewChapter=0;
    %    iCloseChapter=0;
    %    PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Hydrophobic to Hydrophilic 
       titlestr=strcat('BlackCarbonHydrophobic-',num2str(yd),'-',num2str(hd));
       ikind=8;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Sedimentation Bin 001 
       titlestr=strcat('BlackCarbonSedimentaionBin001-',num2str(yd),'-',num2str(hd));
       ikind=9;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Sedimentation Bin 002 
       titlestr=strcat('BlackCarbonSedimentaionBin002-',num2str(yd),'-',num2str(hd));
       ikind=10;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Convective Scavenging Bin 001 
       titlestr=strcat('BlackCarbonScavBin001-',num2str(yd),'-',num2str(hd));
       ikind=11;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Convective Scavenging Bin 002 
       titlestr=strcat('BlackCarbonScavBin002-',num2str(yd),'-',num2str(hd));
       ikind=12;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Sedimentation Bin 001 
       titlestr=strcat('BlackCarbonWetDepositionBin001-',num2str(yd),'-',num2str(hd));
       ikind=13;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Black Carbon Sedimentation Bin 002 
       titlestr=strcat('BlackCarbonWetDepositionBin002-',num2str(yd),'-',num2str(hd));
       ikind=14;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=1;
       PlotBCDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 end
 if(iDust>0)
     %% Plot the Dust TOMS UV Index
     titlestr=strcat('DustTOMSUVIndex-',num2str(yd),'-',num2str(hd));
     ikind=15;
     iAddToReport=1;
     iNewChapter=1;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Deposition Bin 001
     titlestr=strcat('DryDustDepositionBin001-',num2str(yd),'-',num2str(hd));
     ikind=16;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Deposition Bin 002
     titlestr=strcat('DryDustDepositionBin002-',num2str(yd),'-',num2str(hd));
     ikind=17;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Deposition Bin 003
     titlestr=strcat('DryDustDepositionBin003-',num2str(yd),'-',num2str(hd));
     ikind=18;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Deposition Bin 004
     titlestr=strcat('DryDustDepositionBin004-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=19;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Deposition Bin 005
     titlestr=strcat('DryDustDepositionBin005-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=20;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Emission Bin 001
     titlestr=strcat('DryDustEmissionBin001-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=21;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Emission Bin 002
     titlestr=strcat('DryDustEmissionBin002-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=22;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Emission Bin 003
     titlestr=strcat('DryDustEmissionBin003-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=23;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Emission Bin 004
     titlestr=strcat('DryDustEmissionBin004-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=24;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Dust Emission Bin 005
     titlestr=strcat('DryDustEmissionBin005-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=25;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Extinction Coeff
     titlestr=strcat('DustExtinctionCoeff-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=26;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Scattering Coeff
     titlestr=strcat('DustScatteringCoeff-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=27;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin01
     titlestr=strcat('DustSedimentationBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=28;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin02
     titlestr=strcat('DustSedimentationBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=29;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin03
     titlestr=strcat('DustSedimentationBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=30;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin04
     titlestr=strcat('DustSedimentationBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=31;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin05
     titlestr=strcat('DustSedimentationBin05-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=32;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Scavenging Bin01
     titlestr=strcat('DustScavBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=33;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Scavenging Bin02
     titlestr=strcat('DustScavBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=34;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Scavenging Bin03
     titlestr=strcat('DustScavBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=35;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Scavenging Bin04
     titlestr=strcat('DustScavBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=36;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Scavenging Bin04
     titlestr=strcat('DustScavBin05-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=37;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin01
     titlestr=strcat('WetDustDepositionBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=38;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin02
     titlestr=strcat('WetDustDepositionBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=39;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin03
     titlestr=strcat('WetDustDepositionBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=40;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin04
     titlestr=strcat('WetDustDepositionBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=41;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=0;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dust Sedimention Bin05
     titlestr=strcat('WetDustDepositionBin05-',num2str(yd),'-TimeSlice-',num2str(hd));
     ikind=42;
     iAddToReport=1;
     iNewChapter=0;
     iCloseChapter=1;
     PlotDUDPTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 end
   if(iOrganicCarbon>0)
     %% Plot the Organic Carbon Deposition Bin01
       titlestr=strcat('OrgCarbonDepositionBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=45;
       iAddToReport=1;
       iNewChapter=1;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Deposition Bin02
       titlestr=strcat('OrgCarbonDepositionBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=46;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Deposition Bin01
       titlestr=strcat('OrgCarbonEmissionBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=47;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Dry Organic Carbon Deposition Bin02
       titlestr=strcat('OrgCarbonEmissionBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=48;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Antropogenic Emission 
       titlestr=strcat('OrgCarbonAntroEmission-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=49;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Biomass Burning Emission 
       titlestr=strcat('OrgCarbonBiomassBurningEmission-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=50;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Biofuel Emission 
       titlestr=strcat('OrgCarbonBiofuelEmission-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=51;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Biogenic Emission 
       titlestr=strcat('OrgCarbonBiogenicEmission-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=52;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Hydrophobic to Hydrophilic
       titlestr=strcat('OrgCarbonHydroPHIL-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=53;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Sedimentation Bin 001
       titlestr=strcat('OrgCarbonSedBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=54;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Sedimentation Bin 002
       titlestr=strcat('OrgCarbonSedBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=55;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Convective Scavenging Bin 001
       titlestr=strcat('CarbonScavBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=56;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Carbon Convective Scavenging Bin 002
       titlestr=strcat('OrgCarbonScavBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=57;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Wet Carbon Deposition Bin 001
       titlestr=strcat('OrgCarbonWetDepBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=58;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Organic Wet Carbon Deposition Bin 002
       titlestr=strcat('OrgCarbonWetDepBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=59;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=1;
       PlotOrganicCarbonTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
   end
 %% Plot the SO2 Antropogenic Emissions Table
   titlestr=strcat('SO2AntroEmis-',num2str(yd),'-TimeSlice-',num2str(hd));
   ikind=60;
   iAddToReport=1;
   iNewChapter=1;
   iCloseChapter=0;
   PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
 %% Plot the SO2 Burning Biomass Emissions Table
   titlestr=strcat('SO2BurningBioEmis-',num2str(yd),'-TimeSlice-',num2str(hd));
   ikind=61;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  %% Plot the SO2 Explosive Volcanic Emissions Table
   titlestr=strcat('SO2ExpVolcanicEmis-',num2str(yd),'-TimeSlice-',num2str(hd));
   ikind=62;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  %% Plot the SO2 Non Explosive Volcanic Emissions Table
   titlestr=strcat('SO2NonExpVolcanicEmis-',num2str(yd),'-TimeSlice-',num2str(hd));
   ikind=63;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=0;
   PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
  %% Plot the SO4 Antropogenic Emissions Table
   titlestr=strcat('SO4AntroEmis-',num2str(yd),'-TimeSlice-',num2str(hd));
   ikind=64;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=1;
   PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
   if(iSeaSalt>0)
      %% Plot the Sea Salt UV TOMS Index Table
       titlestr=strcat('SeaSaltTOMSIndexBin001-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=65;
       iAddToReport=1;
       iNewChapter=1;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Dry Deposition Bin 001 Table
       titlestr=strcat('SeaSaltDryDepoBin001-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=66;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Dry Deposition Bin 002 Table
       titlestr=strcat('SeaSaltDryDepoBin002-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=67;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Dry Deposition Bin 003 Table
       titlestr=strcat('SeaSaltDryDepoBin003-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=68;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Dry Deposition Bin 004 Table
       titlestr=strcat('SeaSaltDryDepoBin004-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=69;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Dry Deposition Bin 005 Table
       titlestr=strcat('SeaSaltDryDepoBin005-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=70;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Emission Bin 001 Table
       titlestr=strcat('SeaSaltEmissBin001-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=71;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Emission Bin 002 Table
       titlestr=strcat('SeaSaltEmissBin002-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=72;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Emission Bin 003 Table
       titlestr=strcat('SeaSaltEmissBin003-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=73;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Emission Bin 004 Table
       titlestr=strcat('SeaSaltEmissBin004-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=74;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Sea Salt Emission Bin 005 Table
       titlestr=strcat('SeaSaltEmissBin005-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=75;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
     %% Plot the Sea Salt Extinction Table
       titlestr=strcat('SeaSaltExtinction-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=76;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Scattering Table
       titlestr=strcat('SeaSaltScattering-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=77;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
      %% Plot the Sea Salt Sedimentation Bin 01 Table
       titlestr=strcat('SeaSaltSedBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=78;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Sedimentation Bin 02 Table
       titlestr=strcat('SeaSaltSedBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=79;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Sedimentation Bin 03 Table
       titlestr=strcat('SeaSaltSedBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=80;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Sedimentation Bin 04 Table
       titlestr=strcat('SeaSaltSedBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=81;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Sedimentation Bin 05 Table
       titlestr=strcat('SeaSaltSedBin05-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=82;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Convective Scavenging Bin 01 Table
       titlestr=strcat('SeaSaltScavBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=83;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Convective Scavenging Bin 02 Table
       titlestr=strcat('SeaSaltScavBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=84;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Convective Scavenging Bin 03 Table
       titlestr=strcat('SeaSaltScavBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=85;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Convective Scavenging Bin 04 Table
       titlestr=strcat('SeaSaltScavBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=86;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Convective Scavenging Bin 05 Table
       titlestr=strcat('SeaSaltScavBin05-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=87;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Wet Deposition Bin 01 Table
       titlestr=strcat('SeaSaltWetDepBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=88;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Wet Deposition Bin 02 Table
       titlestr=strcat('SeaSaltWetDepBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=89;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Wet Deposition Bin 03 Table
       titlestr=strcat('SeaSaltWetDepBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=90;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Wet Deposition Bin 04 Table
       titlestr=strcat('SeaSaltWetDepBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=91;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sea Salt Wet Deposition Bin 05 Table
       titlestr=strcat('SeaSaltWetDepBin05-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=92;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSeaSaltTable(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
   end
   if(iSulfate>0)
       %% Plot the Sulfur Dry Deposition Bin 01 Table
       titlestr=strcat('SulfurDryDepBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=93;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfur Dry Deposition Bin 02 Table
       titlestr=strcat('SulfurDryDepBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=94;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfur Dry Deposition Bin 03 Table
       titlestr=strcat('SulfurDryDepBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=95;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfur Dry Deposition Bin 04 Table
       titlestr=strcat('SulfurDryDepBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=96;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfur Emission Bin 01 Table
       titlestr=strcat('SulfurEmissBin01-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=97;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfur Emission Bin 02 Table
       titlestr=strcat('SulfurEmissBin02-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=98;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfur Emission Bin 03 Table
       titlestr=strcat('SulfurEmissBin03-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=99;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfur Emission Bin 04 Table
       titlestr=strcat('SulfurEmissBin04-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=100;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the MSA From DMS Table
       titlestr=strcat('SulfurMSAOxidation-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=101;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the SO2 From DMS Table
       titlestr=strcat('SulfurSO2Oxidation-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=102;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the SO4 From DO2 Oxidation Table
       titlestr=strcat('SO4FmSO2Oxidation-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=103;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the SO4 From SO2 Gaseous Oxidation Table
       titlestr=strcat('SO4FmGasSO2Oxidation-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=104;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the SO4 From SO2 Aqueous Oxidation Table
       titlestr=strcat('SO4FmAqueousSO2Oxidation-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=105;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Sedimentation Bin 001 Table
       titlestr=strcat('SulfateSedBin001-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=106;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Sedimentation Bin 002 Table
       titlestr=strcat('SulfateSedBin002-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=107;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Sedimentation Bin 003 Table
       titlestr=strcat('SulfateSedBin003-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=108;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Sedimentation Bin 004 Table
       titlestr=strcat('SulfateSedBin004-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=109;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Convective Scavenging Bin 001 Table
       titlestr=strcat('SulfateCovScaBin00`-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=110;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Convective Scavenging Bin 002 Table
       titlestr=strcat('SulfateCovScaBin002-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=111;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Convective Scavenging Bin 003 Table
       titlestr=strcat('SulfateCovScaBin003-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=112;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Convective Scavenging Bin 004 Table
       titlestr=strcat('SulfateCovScaBin004-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=113;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Wet Deposition Bin 001 Table
       titlestr=strcat('SulfateWetDepBin001-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=114;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Wet Deposition Bin 002 Table
       titlestr=strcat('SulfateWetDepBin002-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=115;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Wet Deposition Bin 003 Table
       titlestr=strcat('SulfateWetDepBin003-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=116;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=0;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
       %% Plot the Sulfate Wet Deposition Bin 004 Table
       titlestr=strcat('SulfateWetDepBin004-',num2str(yd),'-TimeSlice-',num2str(hd));
       ikind=117;
       iAddToReport=1;
       iNewChapter=0;
       iCloseChapter=1;
       PlotSO2Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
   end
   %% Plot the Dry Dust Deposition Sum Table
   titlestr=strcat('DryDustSumDeposition-',num2str(yd),'-TimeSlice-',num2str(hd));
   ikind=120;
   iAddToReport=1;
   iNewChapter=1;
   iCloseChapter=0;
   PlotAccumilatedDustTables(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
   %% Plot the Dry Dust Emission Sum Table
   titlestr=strcat('DryDustSumEmission-',num2str(yd),'-TimeSlice-',num2str(hd));
   ikind=121;
   iAddToReport=1;
   iNewChapter=0;
   iCloseChapter=1;
   PlotAccumilatedDustTables(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
   if((iSeaSalt>0) && (iSeaSaltCalc>0))
   %% Plot the New Sea Salt Cumilative Tables
   titlestr=strcat('SeaSaltCumilDepo-',num2str(yd),'-PerDay');
   ikind2=1066;
   iAddToReport=1;
   iNewChapter=1;
   iCloseChapter=1; 
   PlotSeaSaltCumilativeTable(titlestr,ikind2,iAddToReport,iNewChapter,iCloseChapter)
   end
end

