% This script will test print a correlation array
% Written By: Stephen Forczyk
% Created: May 9,2023
% Revised: -----
% Classification: Public domain

global jpegpath logpath moviepath savepath tablepath pdfpath;
global fid;
global RCOEFF RCOEFFHist RCOEFFLabels;

jpegpath='K:\Merra-2\netCDF\Dataset08\Jpeg_Files\';
logpath='K:\Merra-2\netCDF\Dataset08\Log_Files\';
moviepath='K:\Merra-2\netCDF\Dataset08\Movies\';
savepath='K:\Merra-2\netCDF\Dataset08\Matlab_Files\';
tablepath='K:\Merra-2\netCDF\Dataset08\Tables\';
pdfpath='K:\Merra-2\netCDF\Dataset08\PDF_Files\';

logfilename='TestPrintCorrelationMatrix.txt';
MatFileName='Dataset8-Correlations199901-199912.mat';
% Load the data file
eval(['cd ' savepath(1:length(savepath)-1)]);
load(MatFileName);
eval(['cd ' logpath(1:length(logpath)-1)]);
fid=fopen(logfilename,'w');
openstr1=strcat('Opened File-',MatFileName,'-for reading');
fprintf(fid,'%s\n',openstr1);
% Now pick out one frame of data 
RCOEFF(:,:)=RCOEFFHist(:,:,1);
labelstr=strcat(RCOEFFLabels{1,1},'----',RCOEFFLabels{2,1},'----',...
    RCOEFFLabels{3,1},'------',RCOEFFLabels{4,1},'-----',RCOEFFLabels{5,1});
blankstr='*******';
fprintf(fid,'%s %s\n',blankstr,labelstr);
for i=1:5
    fprintf(fid,'%6s',RCOEFFLabels{i,1});
    fprintf(fid,'%+8.4f  %+8.4f  %+8.4f  %+8.4f  %+8.4f\n',RCOEFF(i,1),RCOEFF(i,2),RCOEFF(i,3),RCOEFF(i,4),RCOEFF(i,5));
end
fclose(fid);
disp('all done')
ab=1;
