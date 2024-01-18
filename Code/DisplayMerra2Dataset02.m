function  DisplayMerra2Dataset02(ikind,itype,varname,iAddToReport,iNewChapter,iCloseChapter)
% This routine will display one frame of data for a single variable at one
% time slice. Multiple types of data can be plotted with this one function
% This routine is specific to the Merra 2 Dataset 2 which is aerosol
% diagnostic
% Written By: Stephen Forczyk
% Created: Jun 10,2023
% Revised: Jun 11-13,2023 added addition variables to plot
% Revised: June 22,2023 fixed mistakes in variables BCDP001S and BCDP002S
% Revised: June 23 thru June 29,2023 continued to add additional variable
% to plot queue
% Revised: July 3,2023 added Sea Salt Data
% Revised: July 9,2023 added switch isaveJpeg to allow the user choices in
% how to save figures. isaveJpeg=2 recommended as normal operating mode
% Revised: July 10-14 adding final variables to plot list
% Revised: Oct 16,2023 added land and sea masks. Desired is to plot
% selected sea area boundaries

% Classification: Unclassified
global BCDP001S BCDP002S BCEM001S BCEM002S;
global BCDP00110 BCDP00125 BCDP00150 BCDP00175 BCDP00190 BCDP00195 BCDP00198 BCDP001100;
global BCDP001Low BCDP001High BCDP001NaN BCDP001Values;
global BCDP00210 BCDP00225 BCDP00250 BCDP00275 BCDP00290 BCDP00295 BCDP00298 BCDP002100;
global BCDP002Low BCDP002High BCDP002NaN BCDP002Values;
global BCEM00210 BCEM00225 BCEM00250 BCEM00275 BCEM00290 BCEM002100;
global BCEM002Low BCEM002High BCEM002NaN BCEM002Values;
global BCEM002Table BCEM002TT;
global BCEMANS BCEMBBS BCEMBFS BCHYPHILS;
global BCEMBB10 BCEMBB25 BCEMBB50 BCEMBB75 BCEMBB90 BCEMBB100;
global BCEMBBLow  BCEMBBHigh BCEMBBNaN BCEMBBValues;
global BCEMBBTable BCEMBBTT;
global BCEMBF10 BCEMBF25 BCEMBF50 BCEMBF75 BCEMBF90 BCEMBF100;
global BCEMBFLow  BCEMBFHigh BCEMBFNaN BCEMBFValues;
global BCEMBFTable BCEMBFTT;
global BCHYPHIL10 BCHYPHIL25 BCHYPHIL50 BCHYPHIL75 BCHYPHIL90 BCHYPHIL100;
global BCHYPHILFLow  BCHYPHILHigh BCHYPHILNaN BCHYPHILValues;
global BCHYPHILFTable BCHYPHILFTT;
global BCSD001S BCSD002S BCSV001S BCSV002S;
global BCSV00110 BCSV00125 BCSV00150 BCSV00175 BCSV00190 BCSV00195 BCSV00198 BCSV001100;
global BCSV001Table BCSV001TT;
global BCSV001Low BCSV001High BCSV001NaN BCSV001Values;
global BCSV00210 BCSV00225 BCSV00250 BCSV00275 BCSV00290 BCSV00295 BCSV00298 BCSV002100;
global BCSV002Low BCSV002High BCSV002NaN BCSV002Values;
global BCSV002Table BCSV002TT;
global BCWT001S BCWT002S DUAERIDXS;
global BCWT00210 BCWT00225 BCWT00250 BCWT00275 BCWT00290 BCWT00295 BCWT00298 BCWT002100;
global BCWT002Low BCWT002High BCWT002NaN BCWT002Values;
global BCWT002Table BCWT002TT;
global DUAERIDX10 DUAERIDX25 DUAERIDX50 DUAERIDX75  DUAERIDX90  DUAERIDX95 DUAERIDX98 DUAERIDX100;
global DUAERIDXLow DUAERIDXHigh DUAERIDXNaN DUAERIDXValues;
global DUAERIDXTable DUAERIDXTT; 
global DUDP001S DUDP002S DUDP003S DUDP004S DUDP005S;
global DUEM001S DUEM002S DUEM003S DUEM004S DUEM005S;
global DUEXTTFMS DUSCATFMS;
global DUEXT10 DUEXT25 DUEXT50 DUEXT75 DUEXT90 DUEXT100;
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
global OCDP001S OCDP002S OCEM001S OCEM002S;
global OCDP00110 OCDP00125 OCDP00150 OCDP00175 OCDP00190 OCDP00195 OCDP00198 OCDP001100;
global OCDP001Low OCDP001High OCDP001NaN OCDP001Values;
global OCDP001Table OCDP001TT;
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
global OCWT001S OCWT002S ;
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
global SSAERIDX10 SSAERIDX25 SSAERIDX50 SSAERIDX75 SSAERIDX90 SSAERIDX95 SSAERIDX98 SSAERIDX100;
global SSAERIDXLow SSAERIDXHigh SSAERIDXNaN SSAERIDXValues;
global SSAERIDXTable SSAERIDXTT;
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
global SUSV001S SUSV002S SUSV003S SUSV004S;
global SUWT001S SUWT002S SUWT003S SUWT004S;
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
global LatitudesS LongitudesS timeS ;
global numSelectedFiles;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global Merra2WorkingSeaMask1 Merra2WorkingSeaMask2 Merra2WorkingSeaMask3;
global Merra2WorkingSeaMask4 Merra2WorkingSeaMask5;
global ROIName1 ROIName2 ROIName3 ROIName4 ROIName5;
global ROIName6 ROIName7 ROIName8 ROIName9 ROIName10;
global Merra2WorkingSeaBoundary1Lat Merra2WorkingSeaBoundary1Lon Merra2WorkingSeaBoundary1Area;
global Merra2WorkingSeaBoundary2Lat Merra2WorkingSeaBoundary2Lon Merra2WorkingSeaBoundary2Area;
global Merra2WorkingSeaBoundary3Lat Merra2WorkingSeaBoundary3Lon Merra2WorkingSeaBoundary3Area;
global Merra2WorkingSeaBoundary4Lat Merra2WorkingSeaBoundary4Lon Merra2WorkingSeaBoundary4Area;
global Merra2WorkingSeaBoundary5Lat Merra2WorkingSeaBoundary5Lon Merra2WorkingSeaBoundary5Area;
global SeaMaskFileName SeaBoundaryFiles SeaMaskChoices numSelectedSeaMasks;
global SelectedSeaMaskData SortedSBF indexSBF;
global SelectedMaskData numSelectedMasks numUserSelectedSeaMasks;

global PascalsToMilliBars PascalsToPsi;
global numtimeslice TimeSlices;
global Merra2FileName Merra2ShortFileName Merra2Dat;
global numlat numlon Rpix latlim lonlim rasterSize;
global yd md dd;
global DustSizeGroups SeaSaltSizeGroups;


global westEdge eastEdge southEdge northEdge;
global vTemp TempMovieName iMovie;
global vTemp4 TempMovieName4 MovieFlags;
global vTemp5 TempMovieName5;
global vTemp6 TempMovieName6;
global vTemp7 TempMovieName7;
global vTemp17 TempMovieName17;
global vTemp34 TempmovieName34;
global vTemp4 TempMovieName4 MovieFlags;
global iLogo LogoFileName1 LogoFileName2 isaveJpeg iSkipReportFrames
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global idebug iCityPlot World200TopCities maxCities framecounter;
global YearMonthStr YearStr MonthStr DayStr YearMonthDayStr FullTimeStr;
global NumProcFiles ProcFileList iSeaSalt;

% additional paths needed for mapping
global matpath1 mappath maskpath;
global jpegpath savepath;
global fid isavefiles;



global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2 fid;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath ;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
% additional paths needed for mapping
global gridpath;
global matpath1 mappath;
global canadapath stateshapepath topopath;
global trajpath militarypath;
global figpath screencapturepath;
global shapepath2 countrypath countryshapepath usstateboundariespath;
global govjpegpath;

 
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
    import mlreportgen.utils.*
end
monthnum=str2double(MonthStr);
[MonthName] = ConvertMonthNumToStr(monthnum);

if(ikind==1)
    data=BCDP001S.values(:,:,numtimeslice);
    fillvalue=BCDP001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Black Carbon Deposition-femtogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Dry Deposition Bin 01';
    units='femtogram/m2/sec';
    titlestr=strcat('BCDP001-',Merra2FileName);
    descstr=strcat('Basic hourly stats  follow for-',titlestr);
elseif(ikind==2)
    data=BCDP002S.values(:,:,numtimeslice);
    fillvalue=BCDP002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Black Carbon Deposition-femtogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Dry Deposition Bin 02';
    units='femtogram/m2/sec';
    titlestr=strcat('BCDP002-',Merra2FileName);
    descstr=strcat('Basic hourly stats  follow for-',titlestr);
elseif(ikind==3)
    data=BCEM001S.values(:,:,numtimeslice);
    fillvalue=BCEM001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Black Carbon Emission Bin 1-nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Emission Bin 01';
    units='nanogram/m2/sec';
    titlestr=strcat('BCEM001-',Merra2FileName);
    descstr=strcat('Basic hourly stats  follow for-',titlestr);
elseif(ikind==4)
    data=BCEM002S.values(:,:,numtimeslice);
    fillvalue=BCEM002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Black Carbon Emission Bin 2 -nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Emission Bin 02';
    units='nanogram/m2/sec';
    titlestr=strcat('BCEM002-',Merra2FileName);
    descstr=strcat('Basic hourly stats  follow for-',titlestr);
elseif(ikind==5)
    data=BCEMANS.values(:,:,numtimeslice);
    fillvalue=BCEMANS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Black Carbon Anthro Emissions-femtogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    desc='Black Carbon Anthro Emissions';
    units='femtogram/m2/sec';
    titlestr=strcat('BCEMAN-',Merra2FileName);
    descstr=strcat('Basic hourly stats  follow for-',titlestr);
    FullTimeStr=YearMonthStr;
elseif(ikind==6)
    data=BCEMBBS.values(:,:,numtimeslice);
    fillvalue=BCEMBBS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Black Carbon Burning Biomass Emissions-nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Burning Biomass';
    units='nanogram/m2/sec';  
    titlestr=strcat('Black Carbon Burning Biomass-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
elseif(ikind==7)
    data=BCEMBFS.values(:,:,numtimeslice);
    fillvalue=BCEMBFS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Black Carbon Biofuel Emissions-nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Biofuel Emissions';
    units='nanogram/m2/sec';  
    titlestr=strcat('Black Carbon Biomass Emissions-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
elseif(ikind==8)
    data=BCHYPHILS.values(:,:,numtimeslice);
    fillvalue=BCHYPHILS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Black Carbon Hydrophobic--nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Hydrophobic';
    units='nanogram/m2/sec';  
    titlestr=strcat('Black Carbon Hydrophobic-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==9)
    data=BCSD001S.values(:,:,numtimeslice);
    fillvalue=BCSD001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-18;
    labelstr='Black Carbon Sedimentation Bin 001-nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Sedimentation Bin 001';
    units='attogm/m2/sec';  
    titlestr=strcat('Black Carbon Sedimentation Bin 001-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==10)
    data=BCSD002S.values(:,:,numtimeslice);
    fillvalue=BCSD002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-18;
    labelstr='Black Carbon Sedimentation Bin 002-nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Sedimentation Bin 002';
    units='attogm/m2/sec';  
    titlestr=strcat('Black Carbon Sedimentation Bin 002-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==11)
    data=BCSV001S.values(:,:,numtimeslice);
    fillvalue=BCSV001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Black Carbon Scavenging Bin 001-femtogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Scavenging Bin 001';
    units='femtogm/m2/sec';  
    titlestr=strcat('Black Carbon Scavenging Bin 001-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==12)
    data=BCSV002S.values(:,:,numtimeslice);
    fillvalue=BCSV002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Black Carbon Scavenging Bin 002-femtogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Scavenging Bin 002';
    units='femtogm/m2/sec';  
    titlestr=strcat('Black Carbon Scavenging Bin 002-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==13)
    data=BCWT001S.values(:,:,numtimeslice);
    fillvalue=BCWT001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Black Carbon Wet Deposition femtograms/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Wet Deposition Bin 01 ';
    units='femtograms-/m2^2/sec';  
    titlestr=strcat('Black Carbon Wet Deposition Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==14)
    data=BCWT002S.values(:,:,numtimeslice);
    fillvalue=BCWT002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Black Carbon Wet Deposition femtograms/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Black Carbon Wet Deposition Bin 02 ';
    units='femtograms-/m2^2/sec';  
    titlestr=strcat('Black Carbon Wet Deposition Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==15)
    data=DUAERIDXS.values(:,:,numtimeslice);
    fillvalue=DUAERIDXS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='dimensionless';
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Dust TOMS UV Index ';
    units='-';  
    titlestr=strcat('Dust TOMS UV Index For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==16)
    data=DUDP001S.values(:,:,numtimeslice);
    fillvalue=DUDP001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Dry Dust Deposition Bin 01-nanogram/m^2/sec';
    [nrows,ncols]=size(PlotArray);
    binstr=strcat(num2str(DustSizeGroups(1,1)),'-to-',num2str(DustSizeGroups(1,2)),'-microns');
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Deposition Bin 01';
    units='nanogram/m2^/sec';  
    titlestr=strcat('Dry Dust Deposition Bin01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==17)
    data=DUDP002S.values(:,:,numtimeslice);
    fillvalue=DUDP002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Dry Dust Deposition Bin 02-nanogram/m^2/sec';
    binstr=strcat(num2str(DustSizeGroups(2,1)),'-to-',num2str(DustSizeGroups(2,2)),'-microns');
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Deposition Bin 02';
    units='nanogram/m2^/sec';    
    titlestr=strcat('Dry Dust Deposition Bin02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==18)
    data=DUDP003S.values(:,:,numtimeslice);
    fillvalue=DUDP003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Dry Dust Deposition Bin 03--nanogram/m^2/sec';
    binstr=strcat(num2str(DustSizeGroups(3,1)),'-to-',num2str(DustSizeGroups(3,2)),'-microns');
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Deposition Bin 03';
    units='nanogram/m2^/sec';    
    titlestr=strcat('Dry Dust Deposition Bin03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==19)
    data=DUDP004S.values(:,:,numtimeslice);
    fillvalue=DUDP004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Dry Dust Deposition Bin 04--nanogram/m^2/sec';
    binstr=strcat(num2str(DustSizeGroups(4,1)),'-to-',num2str(DustSizeGroups(4,2)),'-microns');
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Deposition Bin 04';
    units='nanogram/m2^/sec';    
    titlestr=strcat('Dry Dust Deposition Bin04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==20)
    data=DUDP005S.values(:,:,numtimeslice);
    fillvalue=DUDP005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-12;
    labelstr='Dry Dust Deposition Bin 05--nanogram/m^2/sec';
    binstr=strcat(num2str(DustSizeGroups(5,1)),'-to-',num2str(DustSizeGroups(5,2)),'-microns');
    [nrows,ncols]=size(PlotArray);
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Deposition Bin 05';
    units='nanogram/m2^/sec';    
    titlestr=strcat('Dry Dust Deposition Bin05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==21)
    data=DUEM001S.values(:,:,numtimeslice);
    fillvalue=DUEM001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Dry Dust Emission Bin 01--nanogram/m^2/sec';
    binstr=strcat(num2str(DustSizeGroups(1,1)),'-to-',num2str(DustSizeGroups(1,2)),'-microns');
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Emission Bin 01';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dry Dust Emission Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==22)
    data=DUEM002S.values(:,:,numtimeslice);
    fillvalue=DUEM002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(2,1)),'-to-',num2str(DustSizeGroups(2,2)),'-microns');
    labelstr='Dry Dust Emission Bin 02--nanogram/m^2/sec';
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Emission Bin 02';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dry Dust Emission Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==23)
    data=DUEM003S.values(:,:,numtimeslice);
    fillvalue=DUEM003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(3,1)),'-to-',num2str(DustSizeGroups(3,2)),'-microns');
    labelstr='Dry Dust Emission Bin 03--nanogram/m^2/sec';
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Emission Bin 03';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dry Dust Emission Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==24)
    data=DUEM004S.values(:,:,numtimeslice);
    fillvalue=DUEM004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(4,1)),'-to-',num2str(DustSizeGroups(4,2)),'-microns');
    labelstr='Dry Dust Emission Bin 04--nanogram/m^2/sec';
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Emission Bin 04';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dry Dust Emission Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==25)
    data=DUEM005S.values(:,:,numtimeslice);
    fillvalue=DUEM005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(5,1)),'-to-',num2str(DustSizeGroups(5,2)),'-microns');
    labelstr='Dry Dust Emission Bin 05--nanogram/m^2/sec';
    FullTimeStr=YearMonthStr;
    desc='Dry Dust Emission Bin 05';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dry Dust Emission Bin 05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==26)
    data=DUEXTTFMS.values(:,:,numtimeslice);
    fillvalue=DUEXTTFMS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Dust Extinction';
    FullTimeStr=YearMonthStr;
    desc='Dust Extinction';
    units='dimensionless';  
    titlestr=strcat('Dust Extinction For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==27)
    data=DUSCATFMS.values(:,:,numtimeslice);
    fillvalue=DUSCATFMS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Dust Scattering';
    FullTimeStr=YearMonthStr;
    desc='Dust Scattering';
    units='Dust scattering-dimensionless';  
    titlestr=strcat('Dust Scattering For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==28)
    data=DUSD001S.values(:,:,numtimeslice);
    fillvalue=DUSD001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(1,1)),'-to-',num2str(DustSizeGroups(1,2)),'-microns');
    labelstr='Dust Scattering Bin 01';
    FullTimeStr=YearMonthStr;
    desc='Dust Sedimentation Bin 01';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Sedimentation Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==29)
    data=DUSD002S.values(:,:,numtimeslice);
    fillvalue=DUSD002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(2,1)),'-to-',num2str(DustSizeGroups(2,2)),'-microns');
    labelstr='Dust Scattering Bin 02';
    FullTimeStr=YearMonthStr;
    desc='Dust Sedimentation Bin 02';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Sedimentation Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==30)
    data=DUSD003S.values(:,:,numtimeslice);
    fillvalue=DUSD003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(3,1)),'-to-',num2str(DustSizeGroups(3,2)),'-microns');
    labelstr='Dust Scattering Bin 03';
    FullTimeStr=YearMonthStr;
    desc='Dust Sedimentation Bin 03';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Sedimentation Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==31)
    data=DUSD004S.values(:,:,numtimeslice);
    fillvalue=DUSD004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(4,1)),'-to-',num2str(DustSizeGroups(4,2)),'-microns');
    labelstr='Dust Scattering Bin 04';
    FullTimeStr=YearMonthStr;
    desc='Dust Sedimentation Bin 04';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Sedimentation Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==32)
    data=DUSD005S.values(:,:,numtimeslice);
    fillvalue=DUSD005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(5,1)),'-to-',num2str(DustSizeGroups(5,2)),'-microns');
    labelstr='Dust Scattering Bin 05';
    FullTimeStr=YearMonthStr;
    desc='Dust Sedimentation Bin 05';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Sedimentation Bin 05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==33)
    data=DUSV001S.values(:,:,numtimeslice);
    fillvalue=DUSV001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(1,1)),'-to-',num2str(DustSizeGroups(1,2)),'-microns');
    labelstr='Dust Scavenging Bin 01';
    FullTimeStr=YearMonthStr;
    desc='Dust Scavengening Bin 01';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Scavenging Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==34)
    data=DUSV002S.values(:,:,numtimeslice);
    fillvalue=DUSV002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(2,1)),'-to-',num2str(DustSizeGroups(2,2)),'-microns');
    labelstr='Dust Scavenging Bin 02';
    FullTimeStr=YearMonthStr;
    desc='Dust Scavengening Bin 02';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Scavenging Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==35)
    data=DUSV003S.values(:,:,numtimeslice);
    fillvalue=DUSV003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(3,1)),'-to-',num2str(DustSizeGroups(3,2)),'-microns');
    labelstr='Dust Scavenging Bin 03';
    FullTimeStr=YearMonthStr;
    desc='Dust Scavengening Bin 03';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Scavenging Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==36)
    data=DUSV004S.values(:,:,numtimeslice);
    fillvalue=DUSV004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(4,1)),'-to-',num2str(DustSizeGroups(4,2)),'-microns');
    labelstr='Dust Scavenging Bin 04';
    FullTimeStr=YearMonthStr;
    desc='Dust Scavengening Bin 04';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Scavenging Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==37)
    data=DUSV005S.values(:,:,numtimeslice);
    fillvalue=DUSV005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(5,1)),'-to-',num2str(DustSizeGroups(5,2)),'-microns');
    labelstr='Dust Scavenging Bin 05';
    FullTimeStr=YearMonthStr;
    desc='Dust Scavengening Bin 05';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Scavenging Bin 05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==38)
    data=DUWT001S.values(:,:,numtimeslice);
    fillvalue=DUWT001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(1,1)),'-to-',num2str(DustSizeGroups(1,2)),'-microns');
    labelstr='Dust Deposition Bin 01';
    FullTimeStr=YearMonthStr;
    desc='Wet Dust Deposition Bin 01';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Deposition Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
 elseif(ikind==39)
    data=DUWT002S.values(:,:,numtimeslice);
    fillvalue=DUWT002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(2,1)),'-to-',num2str(DustSizeGroups(2,2)),'-microns');
    labelstr='Dust Deposition Bin 02';
    FullTimeStr=YearMonthStr;
    desc='Wet Dust Deposition Bin 02';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Deposition Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==40)
    data=DUWT003S.values(:,:,numtimeslice);
    fillvalue=DUWT003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(3,1)),'-to-',num2str(DustSizeGroups(3,2)),'-microns');
    labelstr='Dust Deposition Bin 03';
    FullTimeStr=YearMonthStr;
    desc='Wet Dust Deposition Bin 03';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Deposition Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==41)
    data=DUWT004S.values(:,:,numtimeslice);
    fillvalue=DUWT004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(4,1)),'-to-',num2str(DustSizeGroups(4,2)),'-microns');
    labelstr='Dust Deposition Bin 04';
    FullTimeStr=YearMonthStr;
    desc='Wet Dust Deposition Bin 04';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Deposition Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==42)
    data=DUWT005S.values(:,:,numtimeslice);
    fillvalue=DUWT005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    binstr=strcat(num2str(DustSizeGroups(5,1)),'-to-',num2str(DustSizeGroups(5,2)),'-microns');
    labelstr='Dust Deposition Bin 05';
    FullTimeStr=YearMonthStr;
    desc='Wet Dust Deposition Bin 05';
    units='femtogram/m2/sec';  
    titlestr=strcat('Dust Deposition Bin 05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==45)
    data=OCDP001S.values(:,:,numtimeslice);
    fillvalue=OCDP001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Dry Deposition Bin 01';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Dry Deposition Bin 01';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Dry Deposition For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==46)
    data=OCDP002S.values(:,:,numtimeslice);
    fillvalue=OCDP002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Dry Deposition Bin 02';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Dry Deposition Bin 02';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Dry Deposition For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==47)
    data=OCEM001S.values(:,:,numtimeslice);
    fillvalue=OCEM001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Emission Bin 01';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Dry Emission Bin 01';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Emission For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==48)
    data=OCEM002S.values(:,:,numtimeslice);
    fillvalue=OCEM002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Emission Bin 02';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Dry Emission Bin 02';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Emission For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==49)
    data=OCEMANS.values(:,:,numtimeslice);
    fillvalue=OCEMANS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Antropogenic Emission ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Antropogenic Emission ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Anthropogenic Emission For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==50)
    data=OCEMBBS.values(:,:,numtimeslice);
    fillvalue=OCEMBBS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Biomass Burning Emission ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Biomass Burning Emission ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Biomass Burning Emission For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==51)
    data=OCEMBFS.values(:,:,numtimeslice);
    fillvalue=OCEMBFS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Biofuel  Emission ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Biofuel Emission ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Biofuel Emission For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==52)
    data=OCEMBGS.values(:,:,numtimeslice);
    fillvalue=OCEMBGS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Biogenic Emission ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Biogenic  Emission ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Biogenic Emission For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==53)
    data=OCHYPHILS.values(:,:,numtimeslice);
    fillvalue=OCHYPHILS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon  ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Hydrophobic to Hydrophilic ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Hydrophobic to Hydrophilic For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==54)
    data=OCSD001S.values(:,:,numtimeslice);
    fillvalue=OCSD001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Sedimentation Bin 001 ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Sedimentation Bin 001 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Sedimentation Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==55)
    data=OCSD002S.values(:,:,numtimeslice);
    fillvalue=OCSD002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Sedimentation Bin 002 ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Sedimentation Bin 002 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Sedimentation Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr); 
  elseif(ikind==56)
    data=OCSV001S.values(:,:,numtimeslice);
    fillvalue=OCSV001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Convective Scavenging Bin 001 ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Convective Scavenging Bin 001 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Convective Scavenging Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr); 
  elseif(ikind==57)
    data=OCSV002S.values(:,:,numtimeslice);
    fillvalue=OCSV002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Convective Scavenging Bin 002 ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Convective Scavenging Bin 002 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Convective Scavenging Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr); 
  elseif(ikind==58)
    data=OCWT001S.values(:,:,numtimeslice);
    fillvalue=OCWT001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Wet Deposition Bin 001 ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Wet Deposition Bin 001 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Wet Deposition Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==59)
    data=OCWT002S.values(:,:,numtimeslice);
    fillvalue=OCWT002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Organic Carbon Wet Deposition Bin 002 ';
    FullTimeStr=YearMonthStr;
    desc='Organic Carbon Wet Deposition Bin 002 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Organic Carbon Wet Deposition Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==60)
    data=SO2EMANS.values(:,:,numtimeslice);
    fillvalue=SO2EMANS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO2 Antropogenic Emissions ';
    FullTimeStr=YearMonthStr;
    desc='SO2 Antropogenic Emissions ';
    units='femtogram/m2/sec';  
    titlestr=strcat('SO2 Antropogenic Emissions For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==61)
    data=SO2EMBBS.values(:,:,numtimeslice);
    fillvalue=SO2EMBBS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO2 Burning Biomass Emissions ';
    FullTimeStr=YearMonthStr;
    desc='SO2 Burning Biomass Emissions ';
    units='femtogram/m2/sec';  
    titlestr=strcat('SO2 Burning Biomass Emissions For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==62)
    data=SO2EMVES.values(:,:,numtimeslice);
    fillvalue=SO2EMVES.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO2 Explosive Volcanic Emissions ';
    FullTimeStr=YearMonthStr;
    desc='SO2 Explosive Volcanic Emissions ';
    units='femtogram/m2/sec';  
    titlestr=strcat('SO2 Explosive Volcanic Emissions For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==63)
    data=SO2EMVNS.values(:,:,numtimeslice);
    fillvalue=SO2EMVNS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO2 Non-Explosive Volcanic Emissions ';
    FullTimeStr=YearMonthStr;
    desc='SO2 Non-Explosive Volcanic Emissions ';
    units='femtogram/m2/sec';  
    titlestr=strcat('SO2 Non Explosive Volcanic Emissions For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==64)
    data=SO4EMANS.values(:,:,numtimeslice);
    fillvalue=SO4EMANS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO4 Antropogenic Emissions ';
    FullTimeStr=YearMonthStr;
    desc='SO4 Antropogenic Emissions ';
    units='femtogram/m2/sec';  
    titlestr=strcat('SO4 Non AntropogenicEmissions For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==65)
    data=SSAERIDXS.values(:,:,numtimeslice);
    fillvalue=SSAERIDXS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Sea Salt UV TOMS Index ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt UV TOMS Index ';
    units='scalar';  
    titlestr=strcat('Sea Salt UV TOMS Index For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==66)
    data=SSDP001S.values(:,:,numtimeslice);
    fillvalue=SSDP001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Dry Deposition Band 01 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Dry Deposition Bin 001 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Dry Deposition Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(1,1)),'-to-',num2str(SeaSaltSizeGroups(1,2)),'-microns');
 elseif(ikind==67)
    data=SSDP002S.values(:,:,numtimeslice);
    fillvalue=SSDP002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Dry Deposition Band 02 ';
    FullTimeStr=YearMonthStr;
    binstr=strcat(num2str(DustSizeGroups(1,1)),'-to-',num2str(DustSizeGroups(1,2)),'-microns');
    desc='Sea Salt Dry Deposition Bin 002 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Dry Deposition Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(2,1)),'-to-',num2str(SeaSaltSizeGroups(2,2)),'-microns');
  elseif(ikind==68)
    data=SSDP003S.values(:,:,numtimeslice);
    fillvalue=SSDP003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Dry Deposition Band 03 ';
    FullTimeStr=YearMonthStr;
    binstr=strcat(num2str(DustSizeGroups(3,1)),'-to-',num2str(DustSizeGroups(3,2)),'-microns');
    desc='Sea Salt Dry Deposition Bin 003 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Dry Deposition Bin 003 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(3,1)),'-to-',num2str(SeaSaltSizeGroups(3,2)),'-microns');
  elseif(ikind==69)
    data=SSDP004S.values(:,:,numtimeslice);
    fillvalue=SSDP004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Dry Deposition Bin 04 ';
    FullTimeStr=YearMonthStr;
    binstr=strcat(num2str(DustSizeGroups(4,1)),'-to-',num2str(DustSizeGroups(4,2)),'-microns');
    desc='Sea Salt Dry Deposition Bin 004 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Dry Deposition Bin 004 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(4,1)),'-to-',num2str(SeaSaltSizeGroups(4,2)),'-microns');
  elseif(ikind==70)
    data=SSDP005S.values(:,:,numtimeslice);
    fillvalue=SSDP005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Dry Deposition Bin 05 ';
    FullTimeStr=YearMonthStr;
    binstr=strcat(num2str(DustSizeGroups(5,1)),'-to-',num2str(DustSizeGroups(5,2)),'-microns');
    desc='Sea Salt Dry Deposition Bin 005 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Dry Deposition Bin 005 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==71)
    data=SSEM001S.values(:,:,numtimeslice);
    fillvalue=SSEM001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Emission Bin 01 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Emission Bin 01 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Emission Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(1,1)),'-to-',num2str(SeaSaltSizeGroups(1,2)),'-microns');
  elseif(ikind==72)
    data=SSEM002S.values(:,:,numtimeslice);
    fillvalue=SSEM002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Emission Bin 02 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Emission Bin 02 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Emission Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(2,1)),'-to-',num2str(SeaSaltSizeGroups(2,2)),'-microns');
  elseif(ikind==73)
    data=SSEM003S.values(:,:,numtimeslice);
    fillvalue=SSEM003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Emission Bin 03 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Emission Bin 03 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Emission Bin 003 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(3,1)),'-to-',num2str(SeaSaltSizeGroups(3,2)),'-microns');
  elseif(ikind==74)
    data=SSEM004S.values(:,:,numtimeslice);
    fillvalue=SSEM004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Emission Bin 04 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Emission Bin 04 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Emission Bin 004 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(4,1)),'-to-',num2str(SeaSaltSizeGroups(4,2)),'-microns');
  elseif(ikind==75)
    data=SSEM005S.values(:,:,numtimeslice);
    fillvalue=SSEM005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Emission Bin 05 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Emission Bin 05 ';
    units='femtogram/m2/sec';  
    titlestr=strcat('Sea Salt Emission Bin 005 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==76)
    data=SSEXTTFMS.values(:,:,numtimeslice);
    fillvalue=SSEXTTFMS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Sea Salt Extinction at .55 microns ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Extinction at .55 microns ';
    units='dimensionless';  
    titlestr=strcat('Sea Salt Extinction For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==77)
    data=SSSCATFMS.values(:,:,numtimeslice);
    fillvalue=SSSCATFMS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data;
    labelstr='Sea Salt Scattering at .55 microns ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Scattering at .55 microns ';
    units='dimensionless';  
    titlestr=strcat('Sea Salt Scattering For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==78)
    data=SSSD001S.values(:,:,numtimeslice);
    fillvalue=SSSD001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Sedimentation Bin 01 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Sedimentation Bin 01 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(1,1)),'-to-',num2str(SeaSaltSizeGroups(1,2)),'-microns');
  elseif(ikind==79)
    data=SSSD002S.values(:,:,numtimeslice);
    fillvalue=SSSD002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Sedimentation Bin 02 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Sedimentation Bin 02 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(2,1)),'-to-',num2str(SeaSaltSizeGroups(2,2)),'-microns');
  elseif(ikind==80)
    data=SSSD003S.values(:,:,numtimeslice);
    fillvalue=SSSD003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Sedimentation Bin 03 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Sedimentation Bin 03 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(3,1)),'-to-',num2str(SeaSaltSizeGroups(3,2)),'-microns');
  elseif(ikind==81)
    data=SSSD004S.values(:,:,numtimeslice);
    fillvalue=SSSD004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Sedimentation Bin 04 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Sedimentation Bin 04 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(4,1)),'-to-',num2str(SeaSaltSizeGroups(4,2)),'-microns');
  elseif(ikind==82)
    data=SSSD005S.values(:,:,numtimeslice);
    fillvalue=SSSD005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Sedimentation Bin 05 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Sedimentation Bin 05 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==83)
    data=SSSV001S.values(:,:,numtimeslice);
    fillvalue=SSSV001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Convective Scavenging Bin 01 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Convective Scavenging Bin 01 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(1,1)),'-to-',num2str(SeaSaltSizeGroups(1,2)),'-microns');
  elseif(ikind==84)
    data=SSSV002S.values(:,:,numtimeslice);
    fillvalue=SSSV002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Convective Scavenging Bin 02 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Convective Scavenging Bin 02 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(2,1)),'-to-',num2str(SeaSaltSizeGroups(2,2)),'-microns');
  elseif(ikind==85)
    data=SSSV003S.values(:,:,numtimeslice);
    fillvalue=SSSV003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Convective Scavenging Bin 03 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Convective Scavenging Bin 03 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(3,1)),'-to-',num2str(SeaSaltSizeGroups(3,2)),'-microns');
  elseif(ikind==86)
    data=SSSV004S.values(:,:,numtimeslice);
    fillvalue=SSSV004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Convective Scavenging Bin 04 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Convective Scavenging Bin 04 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(4,1)),'-to-',num2str(SeaSaltSizeGroups(4,2)),'-microns');
  elseif(ikind==87)
    data=SSSV005S.values(:,:,numtimeslice);
    fillvalue=SSSV005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Convective Scavenging Bin 05 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Convective Scavenging Bin 05 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Sedimentation Bin 05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==88)
    data=SSWT001S.values(:,:,numtimeslice);
    fillvalue=SSWT001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Wet Deposition Bin 01 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Wet Deposition Bin 01 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Wet Deposition Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(1,1)),'-to-',num2str(SeaSaltSizeGroups(1,2)),'-microns');
  elseif(ikind==89)
    data=SSWT002S.values(:,:,numtimeslice);
    fillvalue=SSWT002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Wet Deposition Bin 02 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Wet Deposition Bin 02 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Wet Deposition Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(2,1)),'-to-',num2str(SeaSaltSizeGroups(2,2)),'-microns');
  elseif(ikind==90)
    data=SSWT003S.values(:,:,numtimeslice);
    fillvalue=SSWT003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Wet Deposition Bin 03 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Wet Deposition Bin 03 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Wet Deposition Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(3,1)),'-to-',num2str(SeaSaltSizeGroups(3,2)),'-microns');
  elseif(ikind==91)
    data=SSWT004S.values(:,:,numtimeslice);
    fillvalue=SSWT004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Wet Deposition Bin 04 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Wet Deposition Bin 04 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Wet Deposition Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(4,1)),'-to-',num2str(SeaSaltSizeGroups(4,2)),'-microns');
  elseif(ikind==92)
    data=SSWT005S.values(:,:,numtimeslice);
    fillvalue=SSWT005S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sea Salt Wet Deposition Bin 05 ';
    FullTimeStr=YearMonthStr;
    desc='Sea Salt Wet Deposition Bin 05 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sea Salt Wet Deposition Bin 05 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==93)
    data=SUDP001S.values(:,:,numtimeslice);
    fillvalue=SUDP001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Dry Deposition  Bin 01 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Dry Deposition  Bin 01 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Dry Deposition  Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==94)
    data=SUDP002S.values(:,:,numtimeslice);
    fillvalue=SUDP002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Dry Deposition  Bin 02 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Dry Deposition  Bin 02 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Dry Deposition  Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==95)
    data=SUDP003S.values(:,:,numtimeslice);
    fillvalue=SUDP003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Dry Deposition  Bin 03 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Dry Deposition  Bin 03 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Dry Deposition  Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==96)
    data=SUDP004S.values(:,:,numtimeslice);
    fillvalue=SUDP004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Dry Deposition  Bin 04 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Dry Deposition  Bin 04 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Dry Deposition  Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==97)
    data=SUEM001S.values(:,:,numtimeslice);
    fillvalue=SUEM001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Emission  Bin 01 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Emission  Bin 01 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Emission  Bin 01 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==98)
    data=SUEM002S.values(:,:,numtimeslice);
    fillvalue=SUEM002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Emission  Bin 02 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Emission  Bin 02 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Emission  Bin 02 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==99)
    data=SUEM003S.values(:,:,numtimeslice);
    fillvalue=SUEM003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Emission  Bin 03 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Emission  Bin 03 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Emission  Bin 03 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==100)
    data=SUEM004S.values(:,:,numtimeslice);
    fillvalue=SUEM004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Emission  Bin 04 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Emission  Bin 04 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Emission  Bin 04 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
%    binstr=strcat(num2str(SeaSaltSizeGroups(5,1)),'-to-',num2str(SeaSaltSizeGroups(5,2)),'-microns');
  elseif(ikind==101)
    data=SUPMSAS.values(:,:,numtimeslice);
    fillvalue=SUPMSAS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='MSA Prod From DMS Oxidation ';
    FullTimeStr=YearMonthStr;
    desc='MSA Prod From DMS Oxidation ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('MSA Prod From DMS Oxidation For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==102)
    data=SUPSO2S.values(:,:,numtimeslice);
    fillvalue=SUPSO2S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO2 Prod From DMS Oxidation ';
    FullTimeStr=YearMonthStr;
    desc='SO2 Prod From DMS Oxidation ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('SO2 Prod From DMS Oxidation For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==103)
    data=SUPSO4AQS.values(:,:,numtimeslice);
    fillvalue=SUPSO4AQS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO4 Prod From Aqueous Oxidation ';
    FullTimeStr=YearMonthStr;
    desc='SO4 Prod From Aqueous Oxidation ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('SO4 Prod From Aqueous Oxidation For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
elseif(ikind==104)
    data=SUPSO4GS.values(:,:,numtimeslice);
    fillvalue=SUPSO4GS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO4 Prod From SO2 gaseous Oxidation ';
    FullTimeStr=YearMonthStr;
    desc='SO4 Prod From SO2 gaseous Oxidation ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('SO4 Prod From SO2 gaseous Oxidation For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==105)
    data=SUPSO4WTS.values(:,:,numtimeslice);
    fillvalue=SUPSO4WTS.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='SO4 Prod From SO2 Aqueous Oxidation ';
    FullTimeStr=YearMonthStr;
    desc='SO4 Prod From SO2 Aqueous Oxidation ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('SO4 Prod From SO2 Aqueous Oxidation For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);% Resume Here
  elseif(ikind==106)
    data=SUSD001S.values(:,:,numtimeslice);
    fillvalue=SUSD001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate settling in Bin 001 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate settling in Bin 001 ';
    units='femtogm/m^2/sec';  
    titlestr=strcat('Sulfate settling in Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==107)
    data=SUSD002S.values(:,:,numtimeslice);
    fillvalue=SUSD002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate settling in Bin 002 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate settling in Bin 002 ';
    units='femtogm/m^2/sec';  
    titlestr=strcat('Sulfate settling in Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==108)
    data=SUSD003S.values(:,:,numtimeslice);
    fillvalue=SUSD003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate settlin in Bin 003 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate settlin in Bin 003 ';
    units='femtogm/m^2/sec';  
    titlestr=strcat('Sulfate settlin in Bin 003 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==109)
    data=SUSD004S.values(:,:,numtimeslice);
    fillvalue=SUSD004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate settlin in Bin 004 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate settling in Bin 004 ';
    units='femtogm/m^2/sec';  
    titlestr=strcat('Sulfate settlin in Bin 004 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==110)
    data=SUSV001S.values(:,:,numtimeslice);
    fillvalue=SUSV001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Convective Scavenging Bin 001 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Convective Scavenging Bin 001 ';
    units='femtogm/m^2/sec';  
    titlestr=strcat('Sulfate Convective Scavenging Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==111)
    data=SUSV002S.values(:,:,numtimeslice);
    fillvalue=SUSV002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Convective Scavenging Bin 002 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Convective Scavenging Bin 002 ';
    units='femtogm/m^2/sec';  
    titlestr=strcat('Sulfate Convective Scavenging Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==112)
    data=SUSV003S.values(:,:,numtimeslice);
    fillvalue=SUSV003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Convective Scavenging Bin 003 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Convective Scavenging Bin 003 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Convective Scavenging Bin 003 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==113)
    data=SUSV004S.values(:,:,numtimeslice);
    fillvalue=SUSV004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Convective Scavenging Bin 004 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Convective Scavenging Bin 004 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Convective Scavenging Bin 004 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==114)
    data=SUWT001S.values(:,:,numtimeslice);
    fillvalue=SUWT001S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Wet Deposition Bin 001 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Wet Deposition Bin 001 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Wet Deposition Bin 001 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==115)
    data=SUWT002S.values(:,:,numtimeslice);
    fillvalue=SUWT002S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Wet Deposition Bin 002 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Wet Deposition Bin 002 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Wet Deposition Bin 002 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==116)
    data=SUWT003S.values(:,:,numtimeslice);
    fillvalue=SUWT003S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Wet Deposition Bin 003 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Wet Deposition Bin 003 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Wet Deposition Bin 003 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
  elseif(ikind==117)
    data=SUWT004S.values(:,:,numtimeslice);
    fillvalue=SUWT004S.FillValue;
    data(data==fillvalue)=NaN;
    PlotArray=data/1E-15;
    labelstr='Sulfate Wet Deposition Bin 004 ';
    FullTimeStr=YearMonthStr;
    desc='Sulfate Wet Deposition Bin 004 ';
    units='nanogm/m^2/sec';  
    titlestr=strcat('Sulfate Wet Deposition Bin 004 For-',Merra2FileName);
    descstr=strcat('Basic hourly stats follow for-',titlestr);
end
[nrows,ncols]=size(PlotArray);

%% Set Up titles and units

% Select the variable to be used for the plot based on itype-this is being
% phased out

if(ikind==1)
% done earlier
end


%% Plot the Cloud Optical Thickness 
numpts=nrows*ncols;
PlotArray1D=reshape(PlotArray,nrows*ncols,1);
PlotArray1DS=sort(PlotArray1D);
num01=floor(.01*numpts);
num25=floor(.25*numpts);
num50=floor(.50*numpts);
num75=floor(.75*numpts);
num99=floor(.99*numpts);
val01=PlotArray1DS(num01,1);
val25=PlotArray1DS(num25,1);
val50=PlotArray1DS(num50,1);
val75=PlotArray1DS(num75,1);
val99=PlotArray1DS(num99,1);
% Calculate some stats
if((ikind==1))
    if(framecounter==1)
        descstr=strcat('Basic hourly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,5));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,5));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,5));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,5));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile -',desc,'=',num2str(val99,5));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval2=20;
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
elseif(ikind==2)
    if(framecounter==1)
        descstr=strcat('Basic hourly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile -',desc,'=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval2=20;
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
  elseif(ikind==3)

    if(framecounter==1)
        descstr=strcat('Basic hourly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile -',desc,'=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval2=20;
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
  elseif(ikind==4)

    if(framecounter==1)
        descstr=strcat('Basic hourly stats follow for-',titlestr);
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile-',desc,'=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile-',desc,'=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile-',desc,'=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile-',desc,'=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile -',desc,'=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    maxval=100000;
    maxval2=maxval+1000; 
    [ihigh]=find(PlotArray1DS>10000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
 elseif(ikind==5)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 Daily Data Average ');
        ptc1str= strcat('01 % Ptile BCEMAN=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCEMAN=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCEMAN=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCEMAN=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile V=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for BCEMAN');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
 elseif(ikind==6)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile BCEMBB=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCEMBB=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCEMBB=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCEMBB=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCEMBB=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for BCEMBB');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==7)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile BCEMBF=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCEMBF=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCEMBF=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCEMBF=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCEMBF=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for BCEMBF');
        [ihigh]=find(PlotArray1DS>100000);
    end
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==8)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile BCHYPIL=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCHYPIL=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCHYPIL=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCHYPIL=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCHYPIL=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for BCHYPIL');
    end
    [ihigh]=find(PlotArray1DS>100000);
   
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 

  elseif(ikind==9)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile BCSD001=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCSD001=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCSD001=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCSD001=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCSD001=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for BCSD001');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 

  elseif(ikind==10)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile BCSD002=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCSD002=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCSD002=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCSD002=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCSD002=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for BCSD002');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 

 elseif(ikind==11)

    if(framecounter==1)
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile BCSV01-',desc,num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCSV01-',desc,num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCSV01-',desc,num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCSV01-',desc,num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCSV01-',desc,num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for BCSV01-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    [ihigh]=find(PlotArray1DS>1000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1000;
    maxval2=maxval+10;
 elseif(ikind==12)
    if(framecounter==1)
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile BCSV02-',desc,num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCSV02-',desc,num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCSV02-',desc,num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCSV02-',desc,num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCSV02-',desc,num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for BCSV02-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    [ihigh]=find(PlotArray1DS>1000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1000;
    maxval2=maxval+10;
 elseif(ikind==13)
    if(framecounter==1)
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile BCWT001-',desc,num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCWT001-',desc,num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCWT001-',desc,num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCWT001-',desc,num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCWT001-',desc,num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for BCWT001-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    [ihigh]=find(PlotArray1DS>3000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=3000000;
    maxval2=maxval+1000;
elseif((ikind==14))
    if(framecounter==1)
        fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile BCWT002-',desc,num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile BCWT002-',desc,num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile BCWT002-',desc,num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile BCWT002-',desc,num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile BCWT002-',desc,num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for BCWT002-',desc);
        fprintf(fid,'%s\n',endstr);
    end
    [ihigh]=find(PlotArray1DS>3000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=3000000;
    maxval2=maxval+1000;

elseif(ikind==15)
    if(framecounter==1)
        %fprintf(fid,'%s\n',descstr);
        ptc1str= strcat('01 % Ptile DUAERIDX-',desc,num2str(val01,6));
        %fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUAERIDX-',desc,num2str(val25,6));
        %fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUAERIDX-',desc,num2str(val50,6));
        %fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUAERIDX-',desc,num2str(val75,6));
        %fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUAERIDX-',desc,num2str(val99,6));
        %fprintf(fid,'%s\n',ptc99str);
        endstr=strcat('End stats for-',desc);
        %fprintf(fid,'%s\n',endstr);
    end
    [ihigh]=find(PlotArray1DS>100);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100;
    maxval2=maxval+10;

 elseif((ikind==16))
    if(framecounter==1)
   %     fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUDP001=',num2str(val01,6));
   %     fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUDP001=',num2str(val25,6));
   %     fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUDP001=',num2str(val50,6));
   %     fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUDP001=',num2str(val75,6));
   %     fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUDP001=',num2str(val99,6));
   %     fprintf(fid,'%s\n',ptc99str);
   %     fprintf(fid,'%s\n',' End Stats follow for DUDP001');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 

elseif(ikind==17)

    if(framecounter==1)
%        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUDP002=',num2str(val01,6));
%        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUDP002=',num2str(val25,6));
%        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUDP002=',num2str(val50,6));
%        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUDP002=',num2str(val75,6));
%        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUDP002=',num2str(val99,6));
%        fprintf(fid,'%s\n',ptc99str);
%        fprintf(fid,'%s\n',' End Stats follow for DUDP002');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 

elseif(ikind==18)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUDP003=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUDP003=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUDP003=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUDP003=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUDP003=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUDP003');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 

elseif(ikind==19)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUDP004=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUDP004=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUDP004=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUDP004=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUDP004=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUDP004');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==20)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUDP005=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUDP005=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUDP005=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUDP005=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUDP005=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUDP005');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 

  elseif(ikind==21)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUEM001=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUEM001=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUEM001=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUEM001=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUEM001=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUEM001');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==22)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUEM002=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUEM002=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUEM002=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUEM002=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUEM002=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUEM002');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==23)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUEM003=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUEM003=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUEM003=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUEM003=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUEM003=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUEM003');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==24)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUEM004=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUEM004=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUEM004=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUEM004=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUEM004=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUEM004');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
 elseif(ikind==25)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUEM005=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUEM005=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUEM005=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUEM005=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUEM005=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUEM005');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
 elseif(ikind==26)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUEXT=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUEXT=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUEXT=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUEXT=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUEXT=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUEXT');
    end
    [ihigh]=find(PlotArray1DS>1000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1000;
    maxval2=maxval+1000; 
  elseif(ikind==27)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSCAT=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSCAT=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSCAT=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSCAT=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSCAT=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSCAT');
    end
    [ihigh]=find(PlotArray1DS>1000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=1000;
    maxval2=maxval+1000; 
  elseif(ikind==28)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSD001=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSD001=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSD001=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSD001=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSD001=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSD001');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
 elseif(ikind==29)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSD002=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSD002=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSD002=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSD002=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSD002=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSD002');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
 elseif(ikind==30)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSD003=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSD003=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSD003=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSD003=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSD003=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSD003');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==31)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSD004=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSD004=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSD004=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSD004=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSD004=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSD004');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=100000;
    maxval2=maxval+1000; 
  elseif(ikind==32)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSD005=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSD005=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSD005=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSD005=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSD005=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSD005');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500000;
    maxval2=maxval+1000; 
  elseif(ikind==33)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSV001=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSV001=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSV001=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSV001=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSV001=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSV001');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500000;
    maxval2=maxval+1000; 
  elseif(ikind==34)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSV002=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSV002=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSV002=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSV002=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSV002=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSV002');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500000;
    maxval2=maxval+1000; 
  elseif(ikind==35)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSV003=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSV003=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSV003=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSV003=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSV003=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSV003');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500000;
    maxval2=maxval+1000; 
  elseif(ikind==36)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSV004=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSV004=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSV004=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSV004=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSV004=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSV004');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500000;
    maxval2=maxval+1000; 
  elseif(ikind==37)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUSV005=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUSV005=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUSV005=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUSV005=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUSV005=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUSV005');
    end
    [ihigh]=find(PlotArray1DS>100000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500000;
    maxval2=maxval+1000; 

  elseif(ikind==38)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUWT001=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUWT001=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUWT001=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUWT001=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUWT001=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUWT001');
    end
    [ihigh]=find(PlotArray1DS>5000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=5000000;
    maxval2=maxval+1000; 

  elseif(ikind==39)

    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUWT002=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUWT002=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUWT002=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUWT002=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUWT002=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUWT002');
    end
    [ihigh]=find(PlotArray1DS>5000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=500000;
    maxval2=maxval+1000; 
  elseif(ikind==40)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUWT003=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUWT003=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUWT003=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUWT003=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUWT003=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUWT003');
    end
    [ihigh]=find(PlotArray1DS>5000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=5000000;
    maxval2=maxval+1000; 
  elseif(ikind==41)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUWT004=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUWT004=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUWT004=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUWT004=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUWT004=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUWT004');
    end
    [ihigh]=find(PlotArray1DS>5000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=5000000;
    maxval2=maxval+1000; 
 elseif(ikind==42)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile DUWT005=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile DUWT005=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile DUWT005=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile DUWT005=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile DUWT005=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for DUWT005');
    end
    [ihigh]=find(PlotArray1DS>5000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=5000000;
    maxval2=maxval+1000; 
 elseif(ikind==45)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile OCDP001=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile OCDP001=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile OCDP001=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile OCDP001=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile OCDP001=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for OCDP001');
    end
    [ihigh]=find(PlotArray1DS>5000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=5000000;
    maxval2=maxval+1000; 
  elseif(ikind==46)
    if(framecounter==1)
        fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
        ptc1str= strcat('01 % Ptile OCDP002=',num2str(val01,6));
        fprintf(fid,'%s\n',ptc1str);
        ptc25str=strcat('25 % Ptile OCDP002=',num2str(val25,6));
        fprintf(fid,'%s\n',ptc25str);
        ptc50str=strcat('50 % Ptile OCDP002=',num2str(val50,6));
        fprintf(fid,'%s\n',ptc50str);
        ptc75str=strcat('75 % Ptile OCDP002=',num2str(val75,6));
        fprintf(fid,'%s\n',ptc75str);
        ptc99str=strcat('99 % Ptile OCDP002=',num2str(val99,6));
        fprintf(fid,'%s\n',ptc99str);
        fprintf(fid,'%s\n',' End Stats follow for OCDP002');
    end
    [ihigh]=find(PlotArray1DS>5000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=5000000;
    maxval2=maxval+1000; 
    elseif(ikind==47)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCEM01=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCEM01=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCEM01=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCEM01=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCEM01=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCEM01');
        end
    [ihigh]=find(PlotArray1DS>15000000);
    a1=isempty(ihigh);
    if(a1==1)
        frachigh=0;
    else
        numhigh=length(ihigh);
        frachigh=numhigh/(nrows*ncols);
    end
    maxval=15000000;
    maxval2=maxval+1000; 
    elseif(ikind==48)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCEM02=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCEM02=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCEM02=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCEM02=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCEM02=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCEM02');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
      elseif(ikind==49)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCEMAN=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCEMAN=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCEMAN=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCEMAN=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCEMAN=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCEMAN');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
    elseif(ikind==50)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCEMBB=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCEMBB=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCEMBB=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCEMBB=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCEMBB=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCEMBB');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==51)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCEMBF=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCEMBF=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCEMBF=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCEMBF=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCEMBF=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCEMBF');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==52)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCEMBG=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCEMBG=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCEMBG=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCEMBG=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCEMBG=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCEMBG');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==53)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCHYPHIL=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCHYPHIL=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCHYPHIL=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCHYPHIL=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCHYPHIL=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCHYPHIL');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==54)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCSD001=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCSD001=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCSD001=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCSD001=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCSD001=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCSD001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
     elseif(ikind==55)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCSD002=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCSD002=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCSD002=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCSD002=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCSD002=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCSD002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
      elseif(ikind==56)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCSV001=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCSV001=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCSV001=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCSV001=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCSV001=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCSV001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==57)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCSV002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCSV002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCSV002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCSV002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCSV002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCSV002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==58)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCWT001=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCWT001=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCWT001=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCWT001=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCWT001=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCWT001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 

     elseif(ikind==59)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile OCWT002=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile OCWT002=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile OCWT002=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile OCWT002=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile OCWT002=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for OCWT002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==60)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SO2EMAN=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SO2EMAN=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SO2EMAN=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SO2EMAN=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SO2EMAN=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SO2EMAN');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==61)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SO2EMBB=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SO2EMBB=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SO2EMBB=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SO2EMBB=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SO2EMBB=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SO2EMBB');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==62)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SO2EMVE=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SO2EMVE=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SO2EMVE=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SO2EMVE=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SO2EMVE=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SO2EMVE');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==63)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SO2EMVN=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SO2EMVN=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SO2EMVN=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SO2EMVN=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SO2EMVN=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SO2EMVN');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==64)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SO4EMAN=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SO4EMAN=',num2str(val25,6));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SO4EMAN=',num2str(val50,6));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SO4EMAN=',num2str(val75,6));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SO4EMAN=',num2str(val99,6));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SO4EMAN');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
      elseif(ikind==65)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSAERIDX=',num2str(val01,3));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSAERIDX=',num2str(val25,3));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSAERIDX=',num2str(val50,3));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSAERIDX=',num2str(val75,3));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSAERIDX=',num2str(val99,3));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSAERIDX');
        end
        [ihigh]=find(PlotArray1DS>50);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=50;
        maxval2=maxval+10;
     elseif(ikind==66)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSDP001=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSDP001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSDP001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSDP001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSDP001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSDP001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==67)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSDP002=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSDP002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSDP002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSDP002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSDP002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSDP002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==68)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSDP003=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSDP003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSDP003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSDP003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSDP003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSDP003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==69)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSDP004=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSDP004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSDP004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSDP004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSDP004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSDP004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==70)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSDP005=',num2str(val01,6));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSDP005=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSDP005=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSDP005=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSDP005=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSDP005');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==71)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSEM001=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSEM001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSEM001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSEM001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSEM001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSEM001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
     elseif(ikind==72)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSEM002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSEM002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSEM002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSEM002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSEM002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSEM002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==73)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSEM003=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSEM003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSEM003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSEM003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSEM003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSEM003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==74)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSEM004=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSEM004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSEM004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSEM004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSEM004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSEM004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==75)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSEM005=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSEM005=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSEM005=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSEM005=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSEM005=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSEM005');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
      elseif(ikind==76)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSEXTTFM=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSEXTTFM=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSEXTTFM=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSEXTTFM=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSEXTTFM=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSEXTTFM');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==77)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSCATFM=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSCATFMFM=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSCATFMFM=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSCATFMFM=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSCATFMFM=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSCATFMFM');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==78)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSD001=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSD001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSD001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSD001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSD001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSD001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==79)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSD002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSD002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSD002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSD002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSD002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSD002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==80)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSD003=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSD003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSD003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSD003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSD003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSD003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==81)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSD004=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSD004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSD004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSD004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSD004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSD004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
     elseif(ikind==82)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSD005=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSD005=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSD005=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSD005=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSD005=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSD005');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==83)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSV001=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSV001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSV001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSV001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSV001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSV001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==84)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSV002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSV002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSV002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSV002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSV002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSV002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==85)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSV003=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSV003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSV003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSV003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSV003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSV003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==86)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSV004=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSV004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSV004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSV004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSV004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSV004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==87)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSSV005=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSSV005=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSSV005=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSSV005=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSSV005=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSSV005');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==88)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSWT001=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSWT001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSWT001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSWT001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSWT001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSWT001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==89)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSWT002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSWT002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSWT002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSWT002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSWT002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSWT002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==90)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSWT003=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSWT003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSWT003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSWT003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSWT003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSWT003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
     elseif(ikind==91)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSWT004=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSWT004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSWT004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSWT004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSWT004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSWT004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==92)
        if(framecounter==-1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SSWT005=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SSWT005=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SSWT005=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SSWT005=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SSWT005=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SSWT005');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==93)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUDP001=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUDP001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUDP001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUDP001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUDP001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUDP001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==94)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUDP002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUDP002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUDP002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUDP002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUDP002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUDP002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==95)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUDP003=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUDP003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUDP003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUDP003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUDP003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUDP003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==96)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUDP004=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUDP004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUDP004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUDP004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUDP004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUDP004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==97)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUEM001=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUEM001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUEM001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUEM001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUEM001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUEM001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==98)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUEM002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUEM002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUEM002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUEM002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUEM002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUEM002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==99)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUEM003=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUEM003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUEM003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUEM003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUEM003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUEM003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==100)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUEM004=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUEM004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUEM004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUEM004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUEM004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUEM004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==101)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUPMSA=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUPMSA=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUPMSA=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUPMSA=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUPMSA=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUPMSA');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==102)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUPSO2=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUPSO2=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUPSO2=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUPSO2=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUPSO2=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUPSO2');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==103)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUPSO4AQ=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUPSO4AQ=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUPSO4AQ=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUPSO4AQ=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUPSO4AQ=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUPSO4AQ');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
      elseif(ikind==104)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUPSO4G=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUPSO4G=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUPSO4G=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUPSO4G=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUPSO4G=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUPSO4G');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
     elseif(ikind==105)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUPSO4WT=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUPSO4WT=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUPSO4WT=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUPSO4WT=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUPSO4WT=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUPSO4WT');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==106)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSD001=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSD001=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSD001=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSD001=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSD001=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSD001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==107)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSD002=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSD002=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSD002=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSD002=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSD002=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSD002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==108)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSD003=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSD003=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSD003=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSD003=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSD003=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSD003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==109)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSD004=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSD004=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSD004=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSD004=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSD004=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSD004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==110)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSV001=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSV001=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSV001=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSV001=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSV001=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSV001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==111)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSV002=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSV002=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSV002=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSV002=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSV002=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSV002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==112)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSV003=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSV003=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSV003=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSV003=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSV003=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSV003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==113)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUSV004=',num2str(val01,4));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUSV004=',num2str(val25,4));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUSV004=',num2str(val50,4));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUSV004=',num2str(val75,4));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUSV004=',num2str(val99,4));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUSV004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==114)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUWT001=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUWT001=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUWT001=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUWT001=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUWT001=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUWT001');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==115)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUWT002=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUWT002=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUWT002=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUWT002=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUWT002=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUWT002');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==116)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUWT003=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUWT003=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUWT003=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUWT003=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUWT003=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUWT003');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000; 
      elseif(ikind==117)
        if(framecounter==1)
            fprintf(fid,'%s\n',' Basic Stats follow for 1 daily Data Average ');
            ptc1str= strcat('01 % Ptile SUWT004=',num2str(val01,5));
            fprintf(fid,'%s\n',ptc1str);
            ptc25str=strcat('25 % Ptile SUWT004=',num2str(val25,5));
            fprintf(fid,'%s\n',ptc25str);
            ptc50str=strcat('50 % Ptile SUWT004=',num2str(val50,5));
            fprintf(fid,'%s\n',ptc50str);
            ptc75str=strcat('75 % Ptile SUWT004=',num2str(val75,5));
            fprintf(fid,'%s\n',ptc75str);
            ptc99str=strcat('99 % Ptile SUWT004=',num2str(val99,5));
            fprintf(fid,'%s\n',ptc99str);
            fprintf(fid,'%s\n',' End Stats follow for SUWT004');
        end
        [ihigh]=find(PlotArray1DS>15000000);
        a1=isempty(ihigh);
        if(a1==1)
            frachigh=0;
        else
            numhigh=length(ihigh);
            frachigh=numhigh/(nrows*ncols);
        end
        maxval=15000000;
        maxval2=maxval+1000;
end

%% Fetch the map limits

if(framecounter==-1)
    maplimitstr1='****Map Limits Follow*****';
    fprintf(fid,'%s\n',maplimitstr1);
    maplimitstr2=strcat('WestEdge=',num2str(westEdge,7),'-EastEdge=',num2str(eastEdge));
    fprintf(fid,'%s\n',maplimitstr2);
    maplimitstr3=strcat('SouthEdge=',num2str(southEdge,7),'-NorthEdge=',num2str(northEdge));
    fprintf(fid,'%s\n',maplimitstr3);
    maplimitstr4='****Map Limits End*****';
    fprintf(fid,'%s\n',maplimitstr4);
end
%% Set up the map axis
if(itype==1)
    axesm ('globe','Frame','on','Grid','on','meridianlabel','off','parallellabel','on',...
        'plabellocation',[-60 -50 -40 -30 -20 -10 0 10 20 30 40 50 60],'mlabellocation',[]);
elseif(itype==2)
    axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',20,'mlabellocation',30,...
     'MLabelParallel','south');    
elseif(itype==3)
    axesm ('pcarree','Frame','on','Grid','on','MapLatLimit',[southEdge northEdge],...
     'MapLonLimit',[westEdge eastEdge],'meridianlabel','on','parallellabel','on','plabellocation',15,'mlabellocation',30,...
     'MLabelParallel','south','GColor',[1 1 0],'GLineWidth',1);
end
set(gcf,'MenuBar','none');
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
colormap jet
%% Plot the cloud area fraction on the map
if((ikind>-1) && (ikind<=15))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif((ikind>=16) && (ikind<=50))
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
elseif(ikind>50)
    geoshow(PlotArray',Rpix,'DisplayType','texturemap');
    hc = colorbar;
    hc.Label.String = labelstr;
    ylabel(hc,units,'FontWeight','bold');
    tightmap
    hold on
else

end
% load the country borders and plot them
eval(['cd ' mappath(1:length(mappath)-1)]);
load('USAHiResBoundaries.mat','USALat','USALon');
plot3m(USALat,USALon,maxval2,'r');
try
    load('CanadaBoundaries.mat','CanadaLat','CanadaLon');
catch
    load('CanadaBoundariesRed.mat','CanadaLat','CanadaLon');
    disp('Failed to load Hi Res Canada data use low rest data')
end
plot3m(CanadaLat,CanadaLon,maxval2,'r');
load('MexicoBoundaries.mat','MexicoLat','MexicoLon');
plot3m(MexicoLat,MexicoLon,maxval2,'r');
load('CubaBoundaries.mat','CubaLat','CubaLon');
plot3m(CubaLat,CubaLon,maxval2,'r');
load('DominicanRepublicBoundaries.mat','DRLat','DRLon');
plot3m(DRLat,DRLon,maxval2,'r');
load('HaitiBoundaries.mat','HaitiLat','HaitiLon');
plot3m(HaitiLat,HaitiLon,maxval2,'r');
load('BelizeBoundaries.mat','BelizeLat','BelizeLon');
plot3m(BelizeLat,BelizeLon,maxval2,'r');
load('GautemalaBoundaries.mat','GautemalaLat','GautemalaLon');
plot3m(GautemalaLat,GautemalaLon,maxval2,'r')
load('JamaicaBoundaries.mat','JamaicaLat','JamaicaLon');
plot3m(JamaicaLat,JamaicaLon,maxval2,'r');
load('NicaraguaBoundaries.mat','NicaraguaLat','NicaraguaLon');
plot3m(NicaraguaLat,NicaraguaLon,maxval2,'r')
load('HondurasBoundaries.mat','HondurasLat','HondurasLon');
plot3m(HondurasLat,HondurasLon,maxval2,'r')
load('ElSalvadorBoundaries.mat','ElSalvadorLat','ElSalvadorLon');
plot3m(ElSalvadorLat,ElSalvadorLon,maxval2,'r');
load('PanamaBoundaries.mat','PanamaLat','PanamaLon');
plot3m(PanamaLat,PanamaLon,maxval2,'r');
load('ColumbiaBoundaries.mat','ColumbiaLat','ColumbiaLon');
plot3m(ColumbiaLat,ColumbiaLon,maxval2,'r');
load('VenezuelaBoundaries.mat','VenezuelaLat','VenezuelaLon');
plot3m(VenezuelaLat,VenezuelaLon,maxval2,'r')
load('PeruBoundaries.mat','PeruLat','PeruLon');
plot3m(PeruLat,PeruLon,maxval2,'r');
load('EcuadorBoundaries.mat','EcuadorLat','EcuadorLon');
plot3m(EcuadorLat,EcuadorLon,maxval2,'r')
load('BrazilBoundaries.mat','BrazilLat','BrazilLon');
plot3m(BrazilLat,BrazilLon,maxval2,'r');
load('BoliviaBoundaries.mat','BoliviaLat','BoliviaLon');
plot3m(BoliviaLat,BoliviaLon,maxval2,'r')
load('ChileBoundaries.mat','ChileLat','ChileLon');
plot3m(ChileLat,ChileLon,maxval2,'r');
load('ArgentinaBoundaries.mat','ArgentinaLat','ArgentinaLon');
plot3m(ArgentinaLat,ArgentinaLon,maxval2,'r');
load('UruguayBoundaries.mat','UruguayLat','UruguayLon');
plot3m(UruguayLat,UruguayLon,maxval2,'r');
load('CostaRicaBoundaries.mat','CostaRicaLat','CostaRicaLon');
plot3m(CostaRicaLat,CostaRicaLon,maxval2,'r');
load('FrenchGuianaBoundaries.mat','FrenchGuianaLat','FrenchGuianaLon');
plot3m(FrenchGuianaLat,FrenchGuianaLon,maxval2,'r');
load('GuyanaBoundaries.mat','GuyanaLat','GuyanaLon');
plot3m(GuyanaLat,GuyanaLon,maxval2,'r');
load('SurinameBoundaries.mat','SurinameLat','SurinameLon');
plot3m(SurinameLat,SurinameLon,maxval2,'r');
load('SaudiBoundaries','SaudiLat','SaudiLon');
plot3m(SaudiLat,SaudiLon,maxval2,'r');
load('TurkeyBoundaries','TurkeyLat','TurkeyLon');
plot3m(TurkeyLat,TurkeyLon,maxval2,'r');
load('SyriaBoundaries','SyriaLat','SyriaLon');
plot3m(SyriaLat,SyriaLon,maxval2,'r');
load('LebanonBoundaries','LebanonLat','LebanonLon');
plot3m(LebanonLat,LebanonLon,maxval2,'r');
load('JordanBoundaries','JordanLat','JordanLon');
plot3m(JordanLat,JordanLon,maxval2,'r');
load('IranBoundaries','IranLat','IranLon');
plot3m(IranLat,IranLon,maxval2,'r');
load('IraqBoundaries','IraqLat','IraqLon');
plot3m(IraqLat,IraqLon,maxval2,'r');
load('KuwaitBoundaries','KuwaitLat','KuwaitLon');
plot3m(KuwaitLat,KuwaitLon,maxval2,'r');
load('IsraelBoundaries','IsraelLat','IsraelLon');
plot3m(IsraelLat,IsraelLon,maxval2,'r');
load('AfricaLowResBoundaries','AfricaLat','AfricaLon');
plot3m(AfricaLat,AfricaLon,maxval2,'r');
load('AsiaLowResBoundaries.mat','AsiaLat','AsiaLon');
plot3m(AsiaLat,AsiaLon,maxval2,'r');
try
    load('EuropeHiResBoundaries.mat','EuropeLat','EuropeLon');

catch
    load('EuropeLowResBoundaries.mat','EuropeLat','EuropeLon');
    disp('Failed to load Hi Res Europe data use low resolution data')
end
plot3m(EuropeLat,EuropeLon,maxval2,'r');
load('AustraliaBoundaries.mat','AustraliaLat','AustraliaLon');
plot3m(AustraliaLat,AustraliaLon,maxval2,'r');
% Add selected sea are if the iSeaSalt flag is set
if(iSeaSalt>0)
    if (numUserSelectedSeaMasks>=1)
        plot3m(Merra2WorkingSeaBoundary1Lat,Merra2WorkingSeaBoundary1Lon,maxval2,'w');
    end
    if (numUserSelectedSeaMasks>=2)
        plot3m(Merra2WorkingSeaBoundary2Lat,Merra2WorkingSeaBoundary2Lon,maxval2,'w');
    end
    if (numUserSelectedSeaMasks>=3)
        plot3m(Merra2WorkingSeaBoundary3Lat,Merra2WorkingSeaBoundary3Lon,maxval2,'w');
    end
    if (numUserSelectedSeaMasks>=4)
        plot3m(Merra2WorkingSeaBoundary4Lat,Merra2WorkingSeaBoundary4Lon,maxval2,'w');
    end
    if (numUserSelectedSeaMasks>=5)
        plot3m(Merra2WorkingSeaBoundary5Lat,Merra2WorkingSeaBoundary5Lon,maxval2,'w');
    end
end
%% Add Cities to the plot is desired
if(iCityPlot>0)
    for k=1:maxCities
        nowLat=World200TopCities{1+k,2};
        nowLon=World200TopCities{1+k,3};
        nowName=char(World200TopCities{1+k,1});
        plot3m(nowLat,nowLon,11,'b+');
        textm(nowLat,nowLon+3,11,nowName,'Color','white','FontSize',8);
    end
end
title(titlestr)
hold off
% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.08, .1,.04,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.07;
ty1=.18;
tsliceID=TimeSlices{numtimeslice,1};
if((ikind>=16) && (ikind<26))
    txtstr1=strcat('Date-',FullTimeStr,'-ikind=',num2str(ikind),'-TimePeriod-',tsliceID,'-Size Bin-',binstr);
elseif((ikind>=28) && (ikind<43))
    txtstr1=strcat('Date-',FullTimeStr,'-ikind=',num2str(ikind),'-TimePeriod-',tsliceID,'-Size Bin-',binstr);
elseif((ikind>=66) && (ikind<76))
    txtstr1=strcat('Date-',FullTimeStr,'-ikind=',num2str(ikind),'-TimePeriod-',tsliceID,'-Size Bin-',binstr);
elseif((ikind>=78) && (ikind<93))
    txtstr1=strcat('Date-',FullTimeStr,'-ikind=',num2str(ikind),'-TimePeriod-',tsliceID,'-Size Bin-',binstr);
elseif((ikind>=93) && (ikind<=96))
    txtstr1=strcat('Date-',FullTimeStr,'-ikind=',num2str(ikind),'-TimePeriod-',tsliceID);
else
    txtstr1=strcat('Date-',FullTimeStr,'-ikind=',num2str(ikind),'-TimePeriod-',tsliceID);
end
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
tx2=.07;
ty2=.14;
if(ikind==1)
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
else
    txtstr2=strcat('1 ptile-',desc,'-',num2str(val01,6),'-50 ptile =',num2str(val50,6),...
        '-75 ptile=',num2str(val75,6),'-99 ptile=',num2str(val99,6),'-frac pix over max range=',num2str(frachigh,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',10);
end
set(newaxesh,'Visible','Off');
% Grab a movie frame
 if((ikind==4) && (iMovie>0) && (MovieFlags(4,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp4,frame);
    disp('Grabbed 1 frame of movie data for ikind =4')
elseif((ikind==5) && (iMovie>0) && (MovieFlags(5,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp5,frame);
    disp('Grabbed 1 frame of movie data for ikind =5')
elseif((ikind==6) && (iMovie>0) && (MovieFlags(6,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp6,frame);
    disp('Grabbed 1 frame of movie data for ikind =6')
elseif((ikind==7) && (iMovie>0) && (MovieFlags(7,1)==1))
    frame=getframe(gcf);
    writeVideo(vTemp7,frame);
    disp('Grabbed 1 frame of movie data for ikind =7')
 else

 end

%% Save this graphic a a jpeg file
tic;
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
if((ikind<=130))
    figstr=strcat(varname,'-',FullTimeStr,'-',num2str(numtimeslice),'.jpg');
end
if(isaveJpeg==1)
    actionstr='print';
    typestr='-djpeg';
    [cmdString]=MyStrcat2(actionstr,typestr,figstr);
    eval(cmdString);
    div=2.5;
    endstr=strcat('------- Finished Plotting-',varname);
    fprintf(fid,'%s\n',endstr);
    capture='print';
elseif(isaveJpeg==2)
    screencapture(gcf,[],figstr)
    div=1.6;
    capture='screengrab';
else % Not saved (do not use is PDF report is being created)


end
pause(chart_time/2);
elapsed_time=toc;
close('all');
NumProcFiles=NumProcFiles+1;
ProcFileList{1+NumProcFiles,1}=figstr;
ProcFileList{1+NumProcFiles,2}=jpegpath;
ProcFileList{1+NumProcFiles,3}=elapsed_time;
ProcFileList{1+NumProcFiles,4}=capture;
rem=mod(framecounter-1,iSkipReportFrames);
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1) && (rem==0))
    if(iNewChapter)
        if(ikind==1)
            headingstr1=strcat('Analysis Results For Black Carbon-',Merra2ShortFileName);
        elseif(ikind==15)
            headingstr1=strcat('Analysis Results For Dust-',Merra2ShortFileName);
            ab=1;
        elseif(ikind==45)
             headingstr1=strcat('Analysis Results For Organic Carbon-',Merra2ShortFileName);
        elseif(ikind==60)
             headingstr1=strcat('Analysis Results For Sulfates-',Merra2ShortFileName);
        elseif(ikind==65)
             headingstr1=strcat('Analysis Results For Sea Salts-',Merra2ShortFileName);
        else
             headingstr1=strcat('Analysis Results For Other Aerosols-',Merra2ShortFileName);
             ab=1;
        end
        chapter = Chapter("Title",headingstr1);
    end
    sectionstr=strcat(varname,'-Map');
    add(chapter,Section(sectionstr));
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(varname,' For File-',Merra2ShortFileName);
    pdftext = Text(pdftxtstr);
    pdftext.Color = 'red';
    image.Caption = pdftext;
    nhighs=floor(nhigh/div);
    nwids=floor(nwid/div);
    heightstr=strcat(num2str(nhighs),'px');
    widthstr=strcat(num2str(nwids),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
% Now add some text -start by describing the with a basic description of the
% variable being plotted
    parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
    parastr2=strcat(' This metric is an hourly average for-',varname,'-at time slice-',tsliceID);
    if((ikind>=1) && (ikind<=26))
        parastr3='The expected data range for this dataset is from 0 to <<1 and is in nanograms/m^2/sec .';
    elseif((ikind==76) || (ikind==77) || (ikind==65))
        parastr3='The expected data range for this dataset is from 0 to 1 and is dimensionless .';
    elseif((ikind>=28) && (ikind<76))
        parastr3='The expected data range for this dataset is from 0 to <<1 and is in femtograms/m^2/sec .';
    elseif(ikind>=78)
        parastr3='The expected data range for this dataset is from 0 to <<1 and is in femtograms/m^2/sec .';
    else
        parastr3='unspecified';
    end

    parastr9=strcat(parastr1,parastr2,parastr3);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
end
close('all');
end

