% Create An ImageDataStore for Selected Data

% Written By: Stephen Forczyk
% Created: April 17,2023
% Revised:----
% Classification: Public Domain

global jpegpath;

jpegpath ='K:\Merra-2\netCDF\Dataset08\Jpeg_Files\';

[ FileList ] = getfilelist(jpegpath, '.jpg',1 );
ab=1;
numFiles=length(FileList);
% Now reduce the list to just those file with TAUHGH
TFSum=0;
for n=1:numFiles
    nowFile=FileList{n,1};
    TF = contains(nowFile,'TAUHGH');
    if(TF==1)
        TFSum=TFSum+1;
    end
end
TFSumFinal=TFSum;
FinalFileList=cell(TFSum,1);
TFSum=0;
for n=1:numFiles
    nowFile=FileList{n,1};
    TF = contains(nowFile,'TAUHGH');
    if(TF==1)
        TFSum=TFSum+1;
        FinalFileList{TFSum,1}=nowFile;
    end
end
ab=2;
fs = matlab.io.datastore.FileSet(FinalFileList);
imdsTAUHGH = imageDatastore(fs);
ab=3;
for i=1:4
    img = readimage(imdsTAUHGH,i);
    imshow(img)
    pause(5)
    close('all')


end





