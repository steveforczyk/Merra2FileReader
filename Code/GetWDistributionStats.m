function [val01,val25,val50,val75,val90,val100,fraclow,frachigh,fracgood,fracNaN] = GetWDistributionStats(inArray,sumMaskArea,lowcutoff,highcutoff)
% This function will return some crude statistics of the 2 D array
% distribution and a count of values that are below and above the valid
% ranges. Remove out of range or NaN values from the calculations
% Note that the values will be weighted by the reporting pixel areas
% Written By: Stephen Forczyk
% Created: Dec 6,2023
% Revised: -----
% Classification: Public Domain
global RasterAreaGrid;
global sumMaskArea1 sumMaskArea2 sumMaskArea3 sumMaskArea4 sumMaskArea5;
global iSubtract iSubval;
[nrows,ncols]=size(inArray);
ntotal=nrows*ncols;
numlow=0;
numhigh=0;
numNaN=0;
% Find the fraction of low values'
[ilow,~]=find(inArray<lowcutoff);
a1=isempty(ilow);
if(a1==1)
    fraclow=0;
else
    numlow=length(ilow);
    fraclow=length(ilow)/ntotal;
end
% Find the fraction of high values'
[ihigh,~]=find(inArray>highcutoff);
a1=isempty(ihigh);
if(a1==1)
    frachigh=0;
else
    numhigh=length(ihigh);
    frachigh=length(ihigh)/ntotal;
end
% Find the number of NaN values
NaNArray=isnan(inArray);
numNaN=sum(sum(NaNArray));
fracNaN=numNaN/ntotal;
numgood=ntotal-numlow-numhigh-numNaN;
fracgood=numgood/ntotal;
ab=1;
% Set up three 1D arrays to hold just the values that fall within the
% defined high/low limits and are not NaNs
Fixed1DArray=zeros(numgood,1);
Fixed1DPixelAreas=zeros(numgood,1);
Fixed1DSortPixelArea=zeros(numgood,1);
Fixed1DCumilAreas=zeros(numgood,1);
HoldIndices=zeros(numgood,2);
cumilArea=0;
igood=0;
% Now pull out the acceptable values and put them in a holding array prior
% to sorting by the inArray value
for i=1:nrows
    for j=1:ncols
        nowVal=inArray(i,j);
        nowArea=RasterAreaGrid(i,j);
        nowNaN=isnan(nowVal);
        if((nowVal>=lowcutoff) && (nowVal<=highcutoff) && (nowNaN==0))
            igood=igood+1;
            Fixed1DArray(igood,1)=nowVal;
            Fixed1DPixelAreas(igood,1)=nowArea;
            HoldIndices(igood,1)=i;
            HoldIndices(igood,2)=j;
            ab=1;
        end
    end
end
minVal=min(Fixed1DArray);
maxVal=max(Fixed1DArray);
% Now create a new array that is sorted by the in Array value

[Fixed1DSortArray,ind]=sort(Fixed1DArray);
cumilArea=0;
for m=1:numgood
    ix=ind(m,1);
    cumilArea=cumilArea+Fixed1DPixelAreas(ix,1);
    Fixed1DSortPixelArea(m,1)=Fixed1DPixelAreas(ix,1);
    Fixed1DCumilAreas(m,1)=cumilArea;
end
Fixed1DCumilAreas=Fixed1DCumilAreas/sumMaskArea;
maxVal=max(Fixed1DCumilAreas);% Not all the mask pixels are counted-so use this to scale up the cumilArea
Fixed1DCumilAreasF=Fixed1DCumilAreas/maxVal;
ab=2;
num01=round(.01*numgood);
num25=round(.25*numgood);
num50=round(.50*numgood);
num75=round(.75*numgood);
num90=round(.90*numgood);
num100=numgood;
% Now find the CumilArea that matches the desired per centile
[ihigh01]=find(Fixed1DCumilAreasF>=.01);
num01=ihigh01(1);
val01=Fixed1DSortArray(num01,1);
[ihigh25]=find(Fixed1DCumilAreasF>=.25);
num25=ihigh25(1);
val25=Fixed1DSortArray(num25,1);
[ihigh50]=find(Fixed1DCumilAreasF>=.50);
num50=ihigh50(1);
val50=Fixed1DSortArray(num50,1);
[ihigh75]=find(Fixed1DCumilAreasF>=.75);
num75=ihigh75(1);
val75=Fixed1DSortArray(num75,1);
[ihigh90]=find(Fixed1DCumilAreasF>=.90);
num90=ihigh90(1);
val90=Fixed1DCumilAreasF(num90,1);
num100=numgood;
val100=Fixed1DCumilAreasF(numgood,1);
ab=3;
if(iSubtract==1)
    val01=val01-iSubval;
    val25=val25-iSubval;
    val50=val50-iSubval;
    val75=val75-iSubval;
    val90=val90-iSubval;
    val100=val100-iSubval;
else

end
ab=3;
end