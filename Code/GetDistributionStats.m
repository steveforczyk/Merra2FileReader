function [val10,val20,val30,val40,val50,val60,val70,val80,val90,val100,fraclow,frachigh,fracNaN] = GetDistributionStats(inArray,lowcutoff,highcutoff)
% This function will return some crude statistics of the 2 D array
% distribution and a count of values that are below and above the valid
% ranges. Remove out of range or NaN values from the calculations
% Written By: Stephen Forczyk
% Created: April 8,2023
% Revised:------
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
% Now collapse this a a 1 D array and sort
Fixed1DArray=reshape(FixedArray,nrows*ncols,1);
Fixed1DSortArray=sort(Fixed1DArray);
num10=round(.10*ntotal);
num20=round(.20*ntotal);
num30=round(.30*ntotal);
num40=round(.40*ntotal);
num50=round(.50*ntotal);
num60=round(.60*ntotal);
num70=round(.70*ntotal);
num80=round(.80*ntotal);
num90=round(.90*ntotal);
num100=ntotal;
val10=Fixed1DSortArray(num10,1);
val20=Fixed1DSortArray(num20,1);
val30=Fixed1DSortArray(num30,1);
val40=Fixed1DSortArray(num40,1);
val50=Fixed1DSortArray(num50,1);
val60=Fixed1DSortArray(num60,1);
val70=Fixed1DSortArray(num70,1);
val80=Fixed1DSortArray(num80,1);
val90=Fixed1DSortArray(num90,1);
val100=Fixed1DSortArray(num100,1);

end