function SetUpDataset3RegionalMasks()
% This function will set up the regional masks used in the evaluation
% of weather data for dataset 3
% Created: Jan 20,2024
% Written By: Stephen Forczyk
% Revised: ----
% Classification: Unclassified/Public Domain

global maskpath;
global Merra2WorkingMask1 Merra2WorkingMask2 Merra2WorkingMask3;
global Merra2WorkingMask4 Merra2WorkingMask5;
global Merra2WorkingMask6 Merra2WorkingMask7;
global Merra2WorkingMask8 Merra2WorkingMask9 Merra2WorkingMask10;
%% Set Up the masks that are needed
            eval(['cd ' maskpath(1:length(maskpath)-1)]);
% Load the Mask for ROIName1-Gemany
            maskVar1='Merra2GermanyMask';
            load('GermanyMask.mat',maskVar1);
            Merra2WorkingMask1=eval(maskVar1);
            Merra2WorkingMask1size=sum(sum(Merra2WorkingMask1));
% Load the Mask for ROIName2-Finland
            maskVar2='Merra2FinlandMask';
            load('FinlandMask.mat',maskVar2);
            Merra2WorkingMask2=eval(maskVar2);
            Merra2WorkingMask2size=sum(sum(Merra2WorkingMask2));
% Load the Mask for ROIName3-UK
            maskVar3='Merra2UKMask';
            load('UKMask.mat',maskVar3);
            Merra2WorkingMask3=eval(maskVar3);
            Merra2WorkingMask3size=sum(sum(Merra2WorkingMask3));
% Load the Mask for ROIName4-Sudan
            maskVar4='Merra2SudanMask';
            load('SudanMask.mat',maskVar4);
            Merra2WorkingMask4=eval(maskVar4);
            Merra2WorkingMask4size=sum(sum(Merra2WorkingMask4));
% Load the Mask for ROIName5-SouthAfrica
            maskVar5='Merra2SouthAfricaMask';
            load('SouthAfricaMask.mat',maskVar5);
            Merra2WorkingMask5=eval(maskVar5);
            Merra2WorkingMask5size=sum(sum(Merra2WorkingMask5));
% Load the Mask for ROIName6-India
            maskVar6='Merra2IndiaMask';
            load('IndiaMask.mat',maskVar6);
            Merra2WorkingMask6=eval(maskVar6);
            Merra2WorkingMask6size=sum(sum(Merra2WorkingMask6));
% Load the Mask for ROIName7-Australia
            maskVar7='Merra2AustraliaMask';
            load('AustraliaMask.mat',maskVar7);
            Merra2WorkingMask7=eval(maskVar7);
            Merra2WorkingMask7size=sum(sum(Merra2WorkingMask7));
% Load the Mask for ROIName8-California
            maskVar8='Merra2CaliforniaMask';
            load('CaliforniaMask.mat',maskVar8);
            Merra2WorkingMask8=eval(maskVar8);
            Merra2WorkingMask8size=sum(sum(Merra2WorkingMask8));
% Load the Mask for ROIName9-Texas
            maskVar9='Merra2TexasMask';
            load('TexasMask.mat',maskVar9);
            Merra2WorkingMask9=eval(maskVar9);
            Merra2WorkingMask9size=sum(sum(Merra2WorkingMask9));
% Load the Mask for ROIName10-Peru
            maskVar10='Merra2PeruMask';
            load('PeruMask.mat',maskVar10);
            Merra2WorkingMask10=eval(maskVar10);
            Merra2WorkingMask10size=sum(sum(Merra2WorkingMask10));
end