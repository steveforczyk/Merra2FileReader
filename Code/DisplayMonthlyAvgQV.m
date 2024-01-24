function DisplayMonthlyAvgQV(titlestr,ifittype,iAddToReport,iNewChapter,iCloseChapter)
% This function will plot the monthly average specific humidity changes
% Currently the plot expect data for 12 months and 10 Regions
%
% Written By: Stephen Forczyk
% Created: Jan 11,2024
% Revised: Jan 22,2024 add logic to calculate changes in the QV in the same
% way this was done for the Average Temperature
% Classification: Public Domain/Unclassified

global GofStats3 GofStats4;
global PredQVStart PredQVEnd PredQVChng;
global MonthLabels RegionLabels;
global pslice heightkm DataCollectionTime;
global Dataset3TempChanges Dataset3QVChanges Dataset3Masks;
global Merra2AvgQVChngTable Merra2AvgQVTempChngHdrs;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global jpegpath govjpegpath;
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;
global iLogo LogoFileName1 LogoFileName2;

if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
end

jpegpath='K:\Merra-2\netCDF\Dataset03\Jpeg_Test2\';
% Set up the Table to hold the Avg QV Change Data
Merra2AvgQVTempChngHdrs=cell(1,3);
Merra2AvgQVTempChngHdrs{1,1}='ROI Number';
Merra2AvgQVTempChngHdrs{1,2}='ROI Avg Monthly Change';
Merra2AvgQVTempChngHdrs{1,3}='ROI Sorted Rank';
Merra2AvgQVChngTable=cell(10,3);
igrid=1;
iLogo=1;
LogoFileName1='Merra2-LogoB.jpg';
% Set up parameters for graphs that will center them on the screen
[hor1,vert1,Fz1,Fz2,machine]=SetScreenCoordinates(widd,lend);
[hor2,vert2,Fz1,Fz2,machine]=SetScreenCoordinates(widd2,lend2);
chart_time=5;

eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
set(gca,'Position',[.16 .18  .70 .70]);
imagesc(1000*PredQVChng);
chnglimithigh=1E-5;
chnglimitlow=-1E-5;
% Find how many of the QV changes were greater / less a set limit
[nnrows,nncols]=size(PredQVChng);
PredQVHigh=zeros(nnrows,nncols);
PredQVLow=zeros(nnrows,nncols);
ihigh=0;
ilow=0;
for i=1:nnrows
    for j=1:nncols
        nowVal=PredQVChng(i,j);
        if(nowVal>chnglimithigh)
            ihigh=ihigh+1;
            PredQVHigh(i,j)=1;
        elseif(nowVal<chnglimitlow)
            ilow=ilow+1;
            PredQVLow(i,j)=1;
        end
    end
end
sumhigh=sum(sum(PredQVHigh));
sumlow=sum(sum(PredQVLow));
% Sum up the changes by region to show which region had the most chnage in
% QV
SumByRegion=zeros(10,1);
for j=1:nncols
    sumcol=0;
    for i=1:nnrows
        sumcol=sumcol+PredQVChng(i,j);
    end
    SumByRegion(j,1)=sumcol;
end
[SortedSumArray,index]=sort(SumByRegion,'descend');
ix=index(1);
LargestQVROI=char(Dataset3Masks{ix,1});
LargestQVValue=SumByRegion(ix,1)/12;
ix2=index(10);
SmallestQVROI=char(Dataset3Masks{ix2,1});
SmallestQVValue=SumByRegion(ix2,1)/12;
fprintf(fid,'\n');
fprintf(fid,'%s\n','***** Data On Avg QV Change Data *****');
parastr7=strcat(' The region with the largest avg monthly QV increase was found to be-',LargestQVROI,...
    '-with a avg value of-',num2str(LargestQVValue),'-Deg C');
parastr8=strcat(' The region with the smallest avg monthly QV decrease was found to be-',SmallestQVROI,...
    '-with a avg value of--- ',num2str(SmallestQVValue),'-Deg C');
fprintf(fid,'%s\n',parastr7);
fprintf(fid,'%s\n',parastr8);
fprintf(fid,'\n');
fprintf(fid,'%s\n','Finish Processing Specific Humidty Curvefits');
fprintf(fid,'\n');
% Add in the Data to the Table Results dont agree betwen diagram and
% table-fix this
Merra2AvgQVChngTable{1,1}='Germany';
Merra2AvgQVChngTable{1,2}=num2str(SumByRegion(1,1));
Merra2AvgQVChngTable{1,3}=num2str(index(1));
Merra2AvgQVChngTable{2,1}='Finland';
Merra2AvgQVChngTable{2,2}=num2str(SumByRegion(2,1));
Merra2AvgQVChngTable{2,3}=num2str(index(2));
Merra2AvgQVChngTable{3,1}='UK';
Merra2AvgQVChngTable{3,2}=num2str(SumByRegion(3,1));
Merra2AvgQVChngTable{3,3}=num2str(index(3));
Merra2AvgQVChngTable{4,1}='Sudan';
Merra2AvgQVChngTable{4,2}=num2str(SumByRegion(4,1));
Merra2AvgQVChngTable{4,3}=num2str(index(4));
Merra2AvgQVChngTable{5,1}='SouthAfica';
Merra2AvgQVChngTable{5,2}=num2str(SumByRegion(5,1));
Merra2AvgQVChngTable{5,3}=num2str(index(5));
Merra2AvgQVChngTable{6,1}='India';
Merra2AvgQVChngTable{6,2}=num2str(SumByRegion(6,1));
Merra2AvgQVChngTable{6,3}=num2str(index(6));
Merra2AvgQVChngTable{7,1}='Australia';
Merra2AvgQVChngTable{7,2}=num2str(SumByRegion(7,1));
Merra2AvgQVChngTable{7,3}=num2str(index(7));
Merra2AvgQVChngTable{8,1}='California';
Merra2AvgQVChngTable{8,2}=num2str(SumByRegion(8,1));
Merra2AvgQVChngTable{8,3}=num2str(index(8));
Merra2AvgQVChngTable{9,1}='Texas';
Merra2AvgQVChngTable{9,2}=num2str(SumByRegion(9,1));
Merra2AvgQVChngTable{9,3}=num2str(index(9));
Merra2AvgQVChngTable{10,1}='Peru';
Merra2AvgQVChngTable{10,2}=num2str(SumByRegion(10,1));
Merra2AvgQVChngTable{10,3}=num2str(index(10));

% Determine string for fit type
if(ifittype==1)
    fitstr='Polyfit Order 1';
elseif(ifittype==2)
    fitstr='Polyfit Order 2';
end

set(gca,'YTick',[1 2 3 4 5 6 7 8 9 10 11 12]);
set(gca,'YTickLabels',MonthLabels);
set(gca,'XTickLabels',RegionLabels);
set(gca,'XTickLabelRotation',90);
hc=colorbar;
hc.Label.String='QV Change g/g';
ht=title(titlestr);
ab=1;
%% Add a logo
if(iLogo==1)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    ha =gca;
    uistack(ha,'bottom');
    haPos = get(ha,'position');
    %ha2=axes('position',[haPos(1:2), .1,.04,]);
    ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .1,.04,]);
    [x, ~]=imread(LogoFileName1);
    imshow(x);
    set(ha2,'handlevisibility','off','visible','off')
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.05;
txtstr1=strcat('-Data Collection Time-',DataCollectionTime,'-preslevel-',num2str(pslice),...
    '-height/km-',num2str(heightkm),'-fittype-',fitstr);
txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);

set(newaxesh,'Visible','Off');
%% Save the chart
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
close('all');
%% Add data to PDF Report
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
    if(iNewChapter)
        headingstr1='Specific Humidity Changes By Regio';
        chapter = Chapter("Title",headingstr1);
    end
    sectionstr='QV Changes From 1980-2023';

    add(chapter,Section(sectionstr));
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr='Dateset03-QV Changes By Month and Region';
    pdftext = Text(pdftxtstr);
    pdftext.Color = 'red';
    image.Caption = pdftext;
    nhighs=floor(nhigh/2.5);
    nwids=floor(nwid/2.5);
    heightstr=strcat(num2str(nhighs),'px');
    widthstr=strcat(num2str(nwids),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
% Now add some text -start by decribing the with a basic description of the
% variable being plotted
    parastr1='This chart shows the change in Specific Humidty (QV) by month and region.';
    parastr2='Basically the curve fit data is used to generate a smooth estimate of the 50 percentile QV values in each estimate.';
    parastr3=' A difference in the estimate for 2020 and 1980 is called the change.';
    parastr4=strcat('Data displayed is for time-',DataCollectionTime);
    parastr5=strcat('The selected pressure level was-',num2str(heightkm,2),'-in km.');
    parastr6='Typically a low altitude was used but in mountainous regions many NaN values can be returned.';
    parastr7=strcat(' The region with the largest avg monthly QV change was found to be-',LargestQVROI,...
        '-with a avg value of-',num2str(LargestQVValue),'-kg/kg');
    parastr8=strcat(' The region with the smallest avg monthly QV change was found to be-',SmallestQVROI,...
        '-with a avg value of--- ',num2str(SmallestQVValue),'-kg/kg');
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5,parastr6,parastr7,parastr8);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
  %% Add Table Ranking of Avg QV changes
    br = PageBreak();
    add(chapter,br);
    T2=[Merra2AvgQVTempChngHdrs;Merra2AvgQVChngTable];
    tbl2=Table(T2);
    tbl2.Style = [tbl2.Style {Border('solid','black','3px')}];
    tbl2.TableEntriesHAlign = 'center';
    tbl2.HAlign='center';
    tbl2.ColSep = 'single';
    tbl2.RowSep = 'single';
    r = row(tbl2,1);
    r.Style = [r.Style {Color('red'),Bold(true)}];
    bt2 = BaseTable(tbl2);
    tabletitle = Text('QV Change Values By Region');
    tabletitle.Bold = false;
    bt2.Title = tabletitle;
    bt2.TableWidth="7in";
    add(chapter,bt2);
    parastr201='The table above shows the change in the 50 % Specific Humidity of the 1980 - 2023 period divided by 12.';
    parastr202=' This final division is to account for the summing of the monthly values into a single composite number.';
    parastr203=' For purposes of this analysis a value of +/- 1E-5 kg/kg is consider significant change.';
    parastr209=strcat(parastr201,parastr202,parastr203);
    p21= Paragraph(parastr209);
    p21.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
    add(chapter,p21);
    if(iCloseChapter==1)
        add(rpt,chapter);
    end
    close('all')
end