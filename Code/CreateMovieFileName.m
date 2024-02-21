function [MovieName] = CreateMovieFileName(prefixString,Merra2FileName)
% This function will create a unique movie name based on prefix string
% and the start date of the dataset
% 
% Written By: Stephen Forczyk
% Created Feb 16,2024
global datestubstr;
MovieName=' ';
datestubstr='19800101';
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
[iper]=strfind(Merra2FileName,'.');
numper=length(iper);
is=1;
ie=iper(numper)-1;
Merra2ShortFileName=Merra2FileName(is:ie);
[iper]=strfind(Merra2ShortFileName,'.');
numper=length(iper);
strlen=length(Merra2ShortFileName);
is=iper(2)+1;
ie=strlen;
currYearMonth=Merra2ShortFileName(is:ie);
YearMonthStr=currYearMonth;
YearStr=YearMonthStr(1:4);
MonthStr1=YearMonthStr(5:6);
monthnum=str2double(MonthStr1);
[MonthName] = ConvertMonthNumToStr(monthnum);
MonthStr=MonthName;
MonthYearStr=strcat(MonthStr,'-',YearStr);
Daystr=YearMonthStr(7:8);
datestubstr=YearMonthStr(1:8);
MovieName=strcat(prefixString,'-',datestubstr);
end