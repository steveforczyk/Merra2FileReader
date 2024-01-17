% This script will create a file containg both the original SeaBoundryFile
% and an Alphabetically sorted version of the same file
% This was done to make using the dialog box for selecting Sea areas to
% study
% Written By: Syephen Forczyk
% Created: Oct 14,2023
% Revised:-----
% Classification: Unclassified/Public Domain

global SeaMaskFileName SeaBoundaryFiles SortedSBF;
global SeaMaskChoices indexSBF;
global oceanmappath

SeaMaskChoices=cell(5,1);
SeaMaskFileName='Merra2ConsolidatedWaterMasks.mat';
oceanmappath='K:\Merra-2\Matlab_Maps_Oceans\';

eval(['cd ' oceanmappath(1:length(oceanmappath)-1)])
load(SeaMaskFileName,'SeaBoundaryFiles');
Labels=cell(1,9);
for i=1:9
    Labels{1,i}=SeaBoundaryFiles{1,i};
end
[nrows,ncols]=size(SeaBoundaryFiles);
SBF=cell(nrows-1,ncols);
SortedSBF=SBF;
for i=2:nrows
    for j=1:ncols
        SBF{i-1,j}=SeaBoundaryFiles{i,j};
    end
end
% Now sort alphabetically by the entry in the first row
[SortedSBF,indexSBF]=sortrows(SBF,1);
%% Create Labels for a Dialog box to be used in another routine
[nrowsSF,ncolsSF]=size(SortedSBF);
for i=1:nrowsSF
    SeaMaskChoices{i,1}=char(SortedSBF{i,2});
end
%% Now save the result
actionstr='save';
varstr='SeaBoundaryFiles SortedSBF indexSBF SeaMaskChoices';
qualstr='-v7.3';
[cmdString]=MyStrcatV73(actionstr,SeaMaskFileName,varstr,qualstr);
eval(cmdString)
dispstr=strcat('Wrote Ocean Boundary File -',SeaMaskFileName,'-File-',num2str(i),'-of-',...
    num2str(nrowsSF));
disp(dispstr)


