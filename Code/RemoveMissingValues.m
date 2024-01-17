function [MeasuredTimes,MeasuredTemps] = RemoveMissingValues(inputTimes,inputTemps)
% For some years data may be missing. Remove the missing values
% Written By: Stephen Forczyk
% Created: Dec 19,2023
% Revised: -----
% Classification: Unclassified/Publuc Domain
[nrows1,~]=size(inputTimes);
nrows2=0;
for n=1:nrows1
    nowVal=inputTimes(n,1);
    if(nowVal>.001)
        nrows2=nrows2+1;
    end
end
if(nrows2==nrows1)
    MeasuredTimes=inputTimes;
    MeasuredTemps=inputTemps;
elseif(nrows2<nrows1)
    MeasuredTimes=zeros(nrows2,1);
    MeasuredTemps=zeros(nrows2,1);
    for ik=1:nrows2
        MeasuredTimes(ik,1)=inputTimes(ik,1);
        MeasuredTemps(ik,1)=inputTemps(ik,1);
    end
end