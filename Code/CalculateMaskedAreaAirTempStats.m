function [val25,val50,val75,val99] = CalculateMaskedAreaAirTempStats(AirTempAdj,UserMask,iMaskSlct)
% This function will apply a geographic area mask  to air temps
% Written By: Stephen Forczyk
% Created: Feb 27,2024
% Revised: Feb 28,2024 added iMaskSlct variable to difrect data to proper
% array
% Classification: Unclassified/Public Domain
global MaskList Dataset4Masks AfricaTemps AlgeriaTemps;
global ChadTemps LibyaTemps EgyptTemps AngolaTemps NigeriaTemps;
global KenyaTemps MozambiqueTemps
global framecounter;
val25=0;
val50=0;
val75=0;
val99=0;
[nnrows,nncols]=size(AirTempAdj);
numvals=nnrows*nncols;
Result=AirTempAdj.*UserMask;
Result1D=reshape(Result,[numvals,1]);
Result1DS=sort(Result1D,'ascend');
[ix]=find(Result1DS>0);
is=ix(1);
ie=numvals;
numvals2=ie-is+1;
Result1DSNz=zeros(numvals2,1);
ncounter=0;
for jj=is:ie
    ncounter=ncounter+1;
    Result1DSNz(ncounter,1)=Result1DS(jj,1);
end
Result1DSNz=Result1DSNz-273.15;
num25=floor(.25*numvals2);
num50=floor(.50*numvals2);
num75=floor(.75*numvals2);
num99=floor(.99*numvals2);
val25=Result1DSNz(num25,1);
val50=Result1DSNz(num50,1);
val75=Result1DSNz(num75,1);
val99=Result1DSNz(num99,1);
if(iMaskSlct==1)
    AfricaTemps(framecounter,1)=framecounter;
    AfricaTemps(framecounter,2)=val25;
    AfricaTemps(framecounter,3)=val50;
    AfricaTemps(framecounter,4)=val75;
    AfricaTemps(framecounter,5)=val99;
elseif(iMaskSlct==10)
    AlgeriaTemps(framecounter,1)=framecounter;
    AlgeriaTemps(framecounter,2)=val25;
    AlgeriaTemps(framecounter,3)=val50;
    AlgeriaTemps(framecounter,4)=val75;
    AlgeriaTemps(framecounter,5)=val99;
elseif(iMaskSlct==11)
    AngolaTemps(framecounter,1)=framecounter;
    AngolaTemps(framecounter,2)=val25;
    AngolaTemps(framecounter,3)=val50;
    AngolaTemps(framecounter,4)=val75;
    AngolaTemps(framecounter,5)=val99;
elseif(iMaskSlct==42)
    ChadTemps(framecounter,1)=framecounter;
    ChadTemps(framecounter,2)=val25;
    ChadTemps(framecounter,3)=val50;
    ChadTemps(framecounter,4)=val75;
    ChadTemps(framecounter,5)=val99;
elseif(iMaskSlct==56)
    EgyptTemps(framecounter,1)=framecounter;
    EgyptTemps(framecounter,2)=val25;
    EgyptTemps(framecounter,3)=val50;
    EgyptTemps(framecounter,4)=val75;
    EgyptTemps(framecounter,5)=val99;
elseif(iMaskSlct==95)
    KenyaTemps(framecounter,1)=framecounter;
    KenyaTemps(framecounter,2)=val25;
    KenyaTemps(framecounter,3)=val50;
    KenyaTemps(framecounter,4)=val75;
    KenyaTemps(framecounter,5)=val99;
elseif(iMaskSlct==104)
    LibyaTemps(framecounter,1)=framecounter;
    LibyaTemps(framecounter,2)=val25;
    LibyaTemps(framecounter,3)=val50;
    LibyaTemps(framecounter,4)=val75;
    LibyaTemps(framecounter,5)=val99;
elseif(iMaskSlct==123)
    MozambiqueTemps(framecounter,1)=framecounter;
    MozambiqueTemps(framecounter,2)=val25;
    MozambiqueTemps(framecounter,3)=val50;
    MozambiqueTemps(framecounter,4)=val75;
    MozambiqueTemps(framecounter,5)=val99;
elseif(iMaskSlct==131)
    NigeriaTemps(framecounter,1)=framecounter;
    NigeriaTemps(framecounter,2)=val25;
    NigeriaTemps(framecounter,3)=val50;
    NigeriaTemps(framecounter,4)=val75;
    NigeriaTemps(framecounter,5)=val99;

end
end