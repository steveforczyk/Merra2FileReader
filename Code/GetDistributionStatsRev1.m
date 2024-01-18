function [val10,val25,val50,val75,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStatsRev1(inArray,lowcutoff,highcutoff)
% This function will return some crude statistics of the 2 D array
% distribution and a count of values that are below and above the valid
% ranges. Remove out of range or NaN values from the calculations
%This differes from the iriginal version in that fewer stat values are
% calculated
% Written By: Stephen Forczyk
% Created: May 23,2023
% Revised: Nov 6,2023 made changes to calculate without NaN values
% Classification: Public Domain
[nrows,ncols]=size(inArray);
ntotal=nrows*ncols;
% Find the fraction of low values'
[ilow,~]=find(inArray<lowcutoff);
a1=isempty(ilow);
if(a1==1)
    fraclow=0;
else
    fraclow=length(ilow)/ntotal;
end
% Find the fraction of high values'
[ihigh,~]=find(inArray>highcutoff);
a1=isempty(ihigh);
if(a1==1)
    frachigh=0;
else
    frachigh=length(ihigh)/ntotal;
end
% % find those values that fall within the low or high cutoff ranges and
% that are non NaN
[ibad,jbad]=find(inArray<lowcutoff | inArray>highcutoff);
numbad=length(ibad);
FixedArray=inArray;
for ii=1:numbad
    for jj=1:numbad
        inow=ibad(ii,1);
        jnow=jbad(jj,1);
        nowVal=inArray(inow,jnow);
        if(nowVal<lowcutoff)
            nowVal=lowcutoff;
        elseif(nowVal>highcutoff)
            nowVal=highcutoff;
        end
        FixedArray(inow,jnow)=nowVal;
    end
end
% See if there are any nan values
NaNArray=isnan(FixedArray);
totalNaN=sum(sum(NaNArray));
if(totalNaN==0)
    fracNaN=0;
else
    fracNaN=totalNaN/ntotal;
end
if(fracNaN>0)
    ab=1;
end
% Now collapse this a a 1 D array and sort
Fixed1DArray=reshape(FixedArray,nrows*ncols,1);
if(fracNaN==0)
    Fixed1DSortArray=sort(Fixed1DArray);
else
    validmask = ~isnan(Fixed1DArray);
    [~, nonnanrank] = sort(Fixed1DArray(validmask));
%     rankA = zeros(size(Fixed1DArray));
%     rankA(validmask) = nonnanrank;
%     ransort=sort(rankA);
    numgood=length(nonnanrank);
    Fixed1DTempArray=zeros(numgood,1);
    ipack=0;
    for k=1:nrows*ncols
        if(validmask(k,1)==1)
            ipack=ipack+1;
            Fixed1DTempArray(ipack,1)=Fixed1DArray(k,1);
        end
    end
    Fixed1DSortArray=sort(Fixed1DTempArray);
    ntotal=ipack;
    ab=1;
end
num10=round(.10*ntotal);
num25=round(.25*ntotal);
num50=round(.50*ntotal);
num75=round(.75*ntotal);
num90=round(.90*ntotal);
num100=ntotal;
val10=Fixed1DSortArray(num10,1);
val25=Fixed1DSortArray(num25,1);
val50=Fixed1DSortArray(num50,1);
val75=Fixed1DSortArray(num75,1);
val90=Fixed1DSortArray(num90,1);
val100=Fixed1DSortArray(num100,1);

end