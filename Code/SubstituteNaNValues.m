function [outArray,numNan] = SubstituteNaNValues(inArray,nanreplacement,FillValue)
% This function will remove Nan values
% Written By Stephen Forczyk
% Created: Mar 29,2024
% Revised:------
% Classification: Public Domain/Unclassified
%   Detailed explanation goes here
[nrows,ncols]=size(inArray);
outArray=inArray;
numNan=0;
for i=1:nrows
    for j=1:ncols
        nowVal=inArray(i,j);
        if(nowVal>=FillValue)
            nowVal=NaN;
        end
        a1=isnan(nowVal);
        if(a1==1)
            numNan=numNan+1;
            outArray(i,j)=nanreplacement;
            ab=1;
        end
    end
end
ab=2;
end