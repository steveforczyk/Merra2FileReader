function [outArray,numNan] = RemoveNaNValues(inArray,nanval)
% This function will remove Nan values
% Written By Stephen Forczyk
% Created: Jan 27,2024
% Revised:------
% Classification: Public Domain/Unclassified
%   Detailed explanation goes here
[nrows,ncols]=size(inArray);
outArray=inArray;
numNan=0;
for i=1:nrows
    for j=1:ncols
        nowVal=inArray(i,j);
        a1=isnan(nowVal);
        if(a1==1)
            numNan=numNan+1;
            outArray(i,j)=NaN;
        elseif(nowVal==nanval)
            numNan=numNan+1;
            outArray(i,j)=NaN; 
        end
    end
end
ab=1;
end