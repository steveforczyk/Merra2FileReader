function [Stats,inArrayAdj,fraclow,frachigh,fracNaN] = GetDistributionStatsRev7(inArray,lowcutoff,highcutoff)
% This function will return some crude statistics of the 2 D array
% the format of the array this routine is mean to deal with is 576 x 36 . 
% The actual data is in 4D format but a fixed time is selected which
% reduces the array to 3D and onr of 42 fixed pressure levels is selected
% which then creates a 2D array
% The goals of this rotuine is to return a 2D array suitable for plotting,a
% 1 D Sorted array used for statistical analysis and some statistics at
% selected pointd along with the fraction of non NaN values that fall below
% the accepted data range and the fraction of NaN values
% This function will return some crude statistics of the 2 D array
% distribution and a count of values that are below and above the valid
% ranges. Remove out of range or NaN values from the calculations
% This differs from the original version in that fewer stat values are
% calculated
% Written By: Stephen Forczyk
% Created: Mar 20,2024
% Revised: -------
% Classification: Public Domain/Unclassified

% Definition of Variables
% input variables
% inVar a struct variable which is a copy of the original global variable


global iTimeSlice iScale;


inArray=inArray*iScale;
[nrows,ncols]=size(inArray);
ntotal=nrows*ncols;
numpts=ntotal;
ab=1;
%
FillVal=1E15;
nanval=FillVal;
[inArrayAdj,numNan] = RemoveNaNValues(inArray,nanval);
fracNaN=numNan/ntotal;
% Find the fraction of low values
[ilow,~]=find(inArrayAdj<lowcutoff);
a1=isempty(ilow);
if(a1==1)
    fraclow=0;
else
    fraclow=length(ilow)/ntotal;
end
% Find the fraction of high values
[ihigh,~]=find(inArrayAdj>highcutoff);
a1=isempty(ihigh);
if(a1==1)
    frachigh=0;
else
    frachigh=length(ihigh)/ntotal;
end
% Define a new array where all values less than lowcutoff are set to lowcutoff the
%values above highcutoff are set to highcutoff all others are untouched
[ibad,jbad]=find((inArrayAdj<lowcutoff) | (inArrayAdj>highcutoff));
numbad=length(ibad);
ilow=0;
ihigh=0;
if(numbad>0)
    for jj=1:numbad
        indx=ibad(jj,1);
        indy=jbad(jj,1);
        nowval=inArrayAdj(indx,indy);
        if(nowval<lowcutoff)
            inArrayAdj(indx,indy)=NaN;
            ilow=ilow+1;
        elseif(nowval>highcutoff)
            inArrayAdj(indx,indy)=NaN;
            ihigh=ihigh+1;
        end

    end
end
if(numbad>0)
    numbadfrac=numbad/ntotal;
else
    numbadfrac=0;
end
% Calculate some stats of a 1D array where the Nan values have been removed
inArray1D=reshape(inArrayAdj,nrows*ncols,1);
inArray1DS=sort(inArray1D);
numpts1=length(inArray1D);
numpts2=numpts1-numNan-numbad;
if(numpts>=200)
    num01=round(.01*numpts2);
    num02=round(.02*numpts2);
    num05=round(.02*numpts2);
    num10=round(.10*numpts2);
    num20=round(.20*numpts2);
    num25=round(.25*numpts2);
    num30=round(.30*numpts2);
    num40=round(.40*numpts2);
    num50=round(.50*numpts2);
    num60=round(.60*numpts2);
    num70=round(.70*numpts2);
    num75=round(.75*numpts2);
    num80=round(.80*numpts2);
    num90=round(.90*numpts2);
    num95=round(.95*numpts2);
    num98=round(.98*numpts2);
    num99=round(.99*numpts2);
    num100=numpts2;
else
    num01=1;
    num02=1;
    num05=1;
    num10=1;
    num20=1;
    num25=1;
    num30=1;
    num40=1;
    num50=1;
    num60=1;
    num70=1;
    num75=1;
    num80=1;
    num90=1;
    num95=1;
    num95=1;
    num98=1;
    num99=1;
    num100=1;

end
val01=inArray1DS(num01,1);
val02=inArray1DS(num02,1);
val05=inArray1DS(num05,1);
val10=inArray1DS(num10,1);
val20=inArray1DS(num20,1);
val25=inArray1DS(num25,1);
val30=inArray1DS(num30,1);
val40=inArray1DS(num40,1);
val50=inArray1DS(num50,1);
val60=inArray1DS(num60,1);
val70=inArray1DS(num70,1);
val75=inArray1DS(num75,1);
val80=inArray1DS(num80,1);
val90=inArray1DS(num90,1);
val95=inArray1DS(num95,1);
val98=inArray1DS(num98,1);
val99=inArray1DS(num99,1);
val100=inArray1DS(num100,1);
Stats=zeros(18,3);
Stats(1,1)=1;
Stats(1,2)=num01;
Stats(1,3)=val01;
Stats(2,1)=2;
Stats(2,2)=num02;
Stats(2,3)=val02;
Stats(3,1)=3;
Stats(3,2)=num05;
Stats(3,3)=val05;
Stats(4,1)=4;
Stats(4,2)=num10;
Stats(4,3)=val10;
Stats(5,1)=5;
Stats(5,2)=num20;
Stats(5,3)=val20;
Stats(6,1)=6;
Stats(6,2)=num25;
Stats(6,3)=val25;
Stats(7,1)=7;
Stats(7,2)=num30;
Stats(7,3)=val30;
Stats(8,1)=8;
Stats(8,2)=num40;
Stats(8,3)=val40;
Stats(9,1)=9;
Stats(9,2)=num50;
Stats(9,3)=val50;
Stats(10,1)=10;
Stats(10,2)=num60;
Stats(10,3)=val60;
Stats(11,1)=11;
Stats(11,2)=num70;
Stats(11,3)=val70;
Stats(12,1)=12;
Stats(12,2)=num75;
Stats(12,3)=val75;
Stats(13,1)=13;
Stats(13,2)=num80;
Stats(13,3)=val80;
Stats(14,1)=14;
Stats(14,2)=num90;
Stats(14,3)=val90;
Stats(15,1)=15;
Stats(15,2)=num95;
Stats(15,3)=val95;
Stats(16,1)=16;
Stats(16,2)=num98;
Stats(16,3)=val98;
Stats(17,1)=17;
Stats(17,2)=num99;
Stats(17,3)=val99;
Stats(18,1)=18;
Stats(18,2)=num100;
Stats(18,3)=val100;
ab=2;
end

