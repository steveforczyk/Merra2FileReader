function PlotDataset04Table(titlestr,ikind,iAddToReport,iNewChapter,iCloseChapter)
% This function plots some timetables created by Dataset03

% Written By: Stephen Forczyk
% Created: Feb 7,2024
% Revised: Feb 8,added ikind 5/6/7 plots
% Classification: Public Domain
global YearMonthStr YearStr MonthStr framecounter numSelectedFiles;

global idebug iScale;
global LonS LatS TimeS iTimeSlice ;
global EFLUXICES EFLUXWTRS FRSEAICES HFLUXICES HFLUXWTRS;
global LWGNTICES LWGNTWTRS SWGNTICES SWGNTWTRS;
global PRECSNOOCNS QV10MS RAINOCNS  integrateRate;
global T10MS TAUXICES TAUXWTRS TAUYICES TAUYWTRS;
global TSKINICES TSKINWTRS U10MS V10MS;
global EFLUXICETable EFLUXICETT SILF01 SILF25 SILF50 SILF75 SILF90 SILF100 SILFNaN;
global EFLUXWTRTable EFLUXWTRTT OWLF01 OWLF25 OWLF50 OWLF75 OWLF90 OWLF100 OWLFNaN;
global SEAICETable SEAICETT SEAF01 SEAF25 SEAF50 SEAF75 SEAF90  SEAF100 SEAFNaN;
global HFLUXICETable HFLUXICETT HFICEF01 HFICEF25 HFICEF50 HFICEF75 HFICEF90 HFICEF100 HFICEFNaN;
global HFLUXWTRTable HFLUXWTRTT HFWTRF01 HFWTRF25 HFWTRF50 HFWTRF75 HFWTRF90 HFWTRF100 HFWTRFNaN;
global LWGNICESTable LWGNICESTT LWGNICE01 LWGNICE25 LWGNICE50 LWGNICE75 LWGNICE90 LWGNICE100 LWGNICENaN;
global LWGNWTRSTable LWGNWTRSTT LWGNWTR01 LWGNWTR25 LWGNWTR50 LWGNWTR75 LWGNWTR90 LWGNWTR100 LWGNWTRNaN;
global TSKINICETable TSKINICETT TSKINICE01 TSKINICE25 TSKINICE50 TSKINICE75 TSKINICE90 TSKINICE100 TSKINICENaN;
global TSKINWTRTable TSKINWTRTT TSKINWTR01 TSKINWTR25 TSKINWTR50 TSKINWTR75 TSKINWTR90 TSKINWTR100 TSKINWTRNaN;
global SWGNTICETable SWGNTICETT SWGNTICE01 SWGNTICE25 SWGNTICE50 SWGNTICE75 SWGNTICE90 SWGNTICE100 SWGNTICENaN;
global SWGNTWTRTable SWGNTWTRTT SWGNTWTR01 SWGNTWTR25 SWGNTWTR50 SWGNTWTR75 SWGNTWTR90 SWGNTWTR100 SWGNTWTRNaN;
global TAUXICETable TAUXICETT TAUXICE01 TAUXICE25 TAUXICE50 TAUXICE75 TAUXICE90 TAUXICE100 TAUXICENaN;
global TAUXWTRTable TAUXWTRTT TAUXWTR01 TAUXWTR25 TAUXWTR50 TAUXWTR75 TAUXWTR90 TAUXWTR100 TAUXWTRNaN;
global TAUYICETable TAUYICETT TAUYICE01 TAUYICE25 TAUYICE50 TAUYICE75 TAUYICE90 TAUYICE100 TAUYICENaN;
global TAUYWTRTable TAUYWTRTT TAUYWTR01 TAUYWTR25 TAUYWTR50 TAUYWTR75 TAUYWTR90 TAUYWTR100 TAUYWTRNaN;
global SeaIceAreaTable SeaIceAreaTT SeaIceAreaKmWorld SeaIceAreaKmNP SeaIceAreaKmSP;
global RFRateTable RFRateTT RFRate01 RFRate25 RFRate50 RFRate75 RFRate90 RFRate100 RFRateNaN;
global SFRateTable SFRateTT SFRate01 SFRate25 SFRate50 SFRate75 SFRate90 SFRate100 SFRateNaN;
global RFTotalTable RFTotalTT RFTot01 RFTot25 RFTot50 RFTot75 RFTot90 RFTot100 RFTotNaN;
global SFTotalTable SFTotalTT SFTot01 SFTot25 SFTot50 SFTot75 SFTot90 SFTot100 SFTotNaN;
global U10MTable U10MTT U10M01 U10M25 U10M50 U10M75 U10M90 U10M100 U10MNaN;
global V10MTable V10MTT V10M01 V10M25 V10M50 V10M75 V10M90 V10M100 V10MNaN;
global T10MTable T10MTT T10M01 T10M25 T10M50 T10M75 T10M90 T10M100 T10MNaN;
global QV10MTable QV10MTT QV10M01 QV10M25 QV10M50 QV10M75 QV10M90 QV10M100 QV10MNaN;



global RasterLats RasterLons Rpix;
global framecounter numSelectedFiles;
global westEdge eastEdge northEdge southEdge;
global yd md dd;

global Merra2ShortFileName;
global numtimeslice TimeSlices;
global Years Months Days;
global iTimeSlice iPress42;

global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global vTemp TempMovieName iMovie;
global iLogo LogoFileName1 LogoFileName2;
global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc lof lot;

global matpath datapath;
global jpegpath tiffpath moviepath savepath;
global excelpath ascpath citypath tablepath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath USshapefilepath;
global northamericalakespath logpath pdfpath govjpegpath;

global shapefilepath Countryshapepath figpath pressurepath averaged1Daypath;
global mappath gridpath countyshapepath nationalshapepath summarypath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;

global pwd;
if((iCreatePDFReport==1) && (RptGenPresent==1))
    import mlreportgen.dom.*;
    import mlreportgen.report.*;
end
% Set Up the Time string for the time slice selected
if(iTimeSlice==1)
    TimeStr='-00-Hrs-GMT';
elseif(iTimeSlice==2)
    TimeStr='-01-Hrs-GMT';
elseif(iTimeSlice==3)
    TimeStr='-02-Hrs-GMT';
elseif(iTimeSlice==4)
    TimeStr='-03-Hrs-GMT';
elseif(iTimeSlice==5)
    TimeStr='-04-Hrs-GMT';
elseif(iTimeSlice==6)
    TimeStr='-05-Hrs-GMT';
elseif(iTimeSlice==7)
    TimeStr='-06-Hrs-GMT';
elseif(iTimeSlice==8)
    TimeStr='-07-Hrs-GMT';
elseif(iTimeSlice==9)
    TimeStr='-08-Hrs-GMT';
elseif(iTimeSlice==10)
    TimeStr='-09-Hrs-GMT';
elseif(iTimeSlice==11)
    TimeStr='-10-Hrs-GMT';
elseif(iTimeSlice==12)
    TimeStr='-11-Hrs-GMT';   
elseif(iTimeSlice==13)
    TimeStr='-12-Hrs-GMT';
elseif(iTimeSlice==14)
    TimeStr='-13-Hrs-GMT';
elseif(iTimeSlice==15)
    TimeStr='-14-Hrs-GMT';
elseif(iTimeSlice==16)
    TimeStr='-15-Hrs-GMT';
elseif(iTimeSlice==17)
    TimeStr='-16-Hrs-GMT';
elseif(iTimeSlice==18)
    TimeStr='-17-Hrs-GMT'; 
elseif(iTimeSlice==19)
    TimeStr='-18-Hrs-GMT';
elseif(iTimeSlice==20)
    TimeStr='-19-Hrs-GMT';
elseif(iTimeSlice==21)
    TimeStr='-20-Hrs-GMT';
elseif(iTimeSlice==22)
    TimeStr='-21-Hrs-GMT';
elseif(iTimeSlice==23)
    TimeStr='-22-Hrs-GMT';
elseif(iTimeSlice==24)
    TimeStr='-23-Hrs-GMT';      
end
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
movie_figure1=figure('position',[hor1 vert1 widd lend]);
set(gcf,'MenuBar','none');
if(ikind==1)
    plot(EFLUXICETT.Time,EFLUXICETT.SILF01,'b',EFLUXICETT.Time,EFLUXICETT.SILF25,'g',...
        EFLUXICETT.Time,EFLUXICETT.SILF50,'k',EFLUXICETT.Time,EFLUXICETT.SILF75,'c',...
        EFLUXICETT.Time,EFLUXICETT.SILF90,'r',EFLUXICETT.Time,EFLUXICETT.SILF100,'r--o'); 
elseif(ikind==2)
    plot(EFLUXWTRTT.Time,EFLUXWTRTT.OWLF01,'b',EFLUXWTRTT.Time,EFLUXWTRTT.OWLF25,'g',...
        EFLUXWTRTT.Time,EFLUXWTRTT.OWLF50,'k',EFLUXWTRTT.Time,EFLUXWTRTT.OWLF75,'c',...
        EFLUXWTRTT.Time,EFLUXWTRTT.OWLF90,'r',EFLUXWTRTT.Time,EFLUXWTRTT.OWLF100,'r--o'); 
elseif(ikind==3)
    plot(SEAICETT.Time,SEAICETT.SEAF01,'b',SEAICETT.Time,SEAICETT.SEAF25,'g',...
        SEAICETT.Time,SEAICETT.SEAF50,'k',SEAICETT.Time,SEAICETT.SEAF75,'c',...
        SEAICETT.Time,SEAICETT.SEAF90,'r',SEAICETT.Time,SEAICETT.SEAF100,'r--o');
elseif(ikind==4)
    plot(SeaIceAreaTT.Time,SeaIceAreaTT.SeaIceAreaKmWorld,'r',SeaIceAreaTT.Time,SeaIceAreaTT.SeaIceAreaKmNP,'g',...
        SeaIceAreaTT.Time,SeaIceAreaTT.SeaIceAreaKmSP,'b');
elseif(ikind==5)
    plot(HFLUXICETT.Time,HFLUXICETT.HFICEF01,'b',HFLUXICETT.Time,HFLUXICETT.HFICEF25,'g',...
        HFLUXICETT.Time,HFLUXICETT.HFICEF50,'k',HFLUXICETT.Time,HFLUXICETT.HFICEF75,'c',...
        HFLUXICETT.Time,HFLUXICETT.HFICEF90,'r',HFLUXICETT.Time,HFLUXICETT.HFICEF100,'r--o'); 
elseif(ikind==6)
    plot(HFLUXWTRTT.Time,HFLUXWTRTT.HFWTRF01,'b',HFLUXWTRTT.Time,HFLUXWTRTT.HFWTRF25,'g',...
        HFLUXWTRTT.Time,HFLUXWTRTT.HFWTRF50,'k',HFLUXWTRTT.Time,HFLUXWTRTT.HFWTRF75,'c',...
        HFLUXWTRTT.Time,HFLUXWTRTT.HFWTRF90,'r',HFLUXWTRTT.Time,HFLUXWTRTT.HFWTRF100,'r--o'); 
elseif(ikind==7)
    plot(LWGNICESTT.Time,LWGNICESTT.LWGNICE01,'b',LWGNICESTT.Time,LWGNICESTT.LWGNICE25,'g',...
        LWGNICESTT.Time,LWGNICESTT.LWGNICE50,'k',LWGNICESTT.Time,LWGNICESTT.LWGNICE75,'c',...
        LWGNICESTT.Time,LWGNICESTT.LWGNICE90,'r',LWGNICESTT.Time,LWGNICESTT.LWGNICE100,'r--o'); 
elseif(ikind==8)
    plot(LWGNWTRSTT.Time,LWGNWTRSTT.LWGNWTR01,'b',LWGNWTRSTT.Time,LWGNWTRSTT.LWGNWTR25,'g',...
        LWGNWTRSTT.Time,LWGNWTRSTT.LWGNWTR50,'k',LWGNWTRSTT.Time,LWGNWTRSTT.LWGNWTR75,'c',...
        LWGNWTRSTT.Time,LWGNWTRSTT.LWGNWTR90,'r',LWGNWTRSTT.Time,LWGNWTRSTT.LWGNWTR100,'r--o'); 
elseif(ikind==9)
    plot(T10MTT.Time,T10MTT.T10M01,'b',T10MTT.Time,T10MTT.T10M25,'g',...
        T10MTT.Time,T10MTT.T10M50,'k',T10MTT.Time,T10MTT.T10M75,'c',...
        T10MTT.Time,T10MTT.T10M90,'r',T10MTT.Time,T10MTT.T10M100,'r--o'); 
elseif(ikind==11)
    plot(TSKINICETT.Time,TSKINICETT.TSKINICE01,'b',TSKINICETT.Time,TSKINICETT.TSKINICE25,'g',...
        TSKINICETT.Time,TSKINICETT.TSKINICE50,'k',TSKINICETT.Time,TSKINICETT.TSKINICE75,'c',...
        TSKINICETT.Time,TSKINICETT.TSKINICE90,'r',TSKINICETT.Time,TSKINICETT.TSKINICE100,'r--o');
elseif(ikind==12)
    plot(TSKINWTRTT.Time,TSKINWTRTT.TSKINWTR01,'b',TSKINWTRTT.Time,TSKINWTRTT.TSKINWTR25,'g',...
        TSKINWTRTT.Time,TSKINWTRTT.TSKINWTR50,'k',TSKINWTRTT.Time,TSKINWTRTT.TSKINWTR75,'c',...
        TSKINWTRTT.Time,TSKINWTRTT.TSKINWTR90,'r',TSKINWTRTT.Time,TSKINWTRTT.TSKINWTR100,'r--o'); 
elseif(ikind==13)
    plot(SWGNTICETT.Time,SWGNTICETT.SWGNTICE01,'b',SWGNTICETT.Time,SWGNTICETT.SWGNTICE25,'g',...
        SWGNTICETT.Time,SWGNTICETT.SWGNTICE50,'k',SWGNTICETT.Time,SWGNTICETT.SWGNTICE75,'c',...
        SWGNTICETT.Time,SWGNTICETT.SWGNTICE90,'r',SWGNTICETT.Time,SWGNTICETT.SWGNTICE100,'r--o'); 
elseif(ikind==14)
    plot(SWGNTWTRTT.Time,SWGNTWTRTT.SWGNTWTR01,'b',SWGNTWTRTT.Time,SWGNTWTRTT.SWGNTWTR25,'g',...
        SWGNTWTRTT.Time,SWGNTWTRTT.SWGNTWTR50,'k',SWGNTWTRTT.Time,SWGNTWTRTT.SWGNTWTR75,'c',...
        SWGNTWTRTT.Time,SWGNTWTRTT.SWGNTWTR90,'r',SWGNTWTRTT.Time,SWGNTWTRTT.SWGNTWTR100,'r--o'); 
elseif(ikind==15)
    plot(TAUXICETT.Time,TAUXICETT.TAUXICE01,'b',TAUXICETT.Time,TAUXICETT.TAUXICE25,'g',...
        TAUXICETT.Time,TAUXICETT.TAUXICE50,'k',TAUXICETT.Time,TAUXICETT.TAUXICE75,'c',...
        TAUXICETT.Time,TAUXICETT.TAUXICE90,'r',TAUXICETT.Time,TAUXICETT.TAUXICE100,'r--o'); 
elseif(ikind==16)
    plot(TAUXWTRTT.Time,TAUXWTRTT.TAUXWTR01,'b',TAUXWTRTT.Time,TAUXWTRTT.TAUXWTR25,'g',...
        TAUXWTRTT.Time,TAUXWTRTT.TAUXWTR50,'k',TAUXWTRTT.Time,TAUXWTRTT.TAUXWTR75,'c',...
        TAUXWTRTT.Time,TAUXWTRTT.TAUXWTR90,'r',TAUXWTRTT.Time,TAUXWTRTT.TAUXWTR100,'r--o'); 
elseif(ikind==17)
    plot(TAUYICETT.Time,TAUYICETT.TAUYICE01,'b',TAUYICETT.Time,TAUYICETT.TAUYICE25,'g',...
        TAUYICETT.Time,TAUYICETT.TAUYICE50,'k',TAUYICETT.Time,TAUYICETT.TAUYICE75,'c',...
        TAUYICETT.Time,TAUYICETT.TAUYICE90,'r',TAUYICETT.Time,TAUYICETT.TAUYICE100,'r--o'); 
elseif(ikind==18)
    plot(TAUYWTRTT.Time,TAUYWTRTT.TAUYWTR01,'b',TAUYWTRTT.Time,TAUYWTRTT.TAUYWTR25,'g',...
        TAUYWTRTT.Time,TAUYWTRTT.TAUYWTR50,'k',TAUYWTRTT.Time,TAUYWTRTT.TAUYWTR75,'c',...
        TAUYWTRTT.Time,TAUYWTRTT.TAUYWTR90,'r',TAUYWTRTT.Time,TAUYWTRTT.TAUYWTR100,'r--o');
elseif(ikind==20)
    plot(RFRateTT.Time,RFRateTT.RFRate01,'b',RFRateTT.Time,RFRateTT.RFRate25,'g',...
        RFRateTT.Time,RFRateTT.RFRate50,'k',RFRateTT.Time,RFRateTT.RFRate75,'c',...
        RFRateTT.Time,RFRateTT.RFRate90,'r',RFRateTT.Time,RFRateTT.RFRate100,'r--o');
elseif(ikind==21)
    plot(SFRateTT.Time,SFRateTT.SFRate01,'b',SFRateTT.Time,SFRateTT.SFRate25,'g',...
        SFRateTT.Time,SFRateTT.SFRate50,'k',SFRateTT.Time,SFRateTT.SFRate75,'c',...
        SFRateTT.Time,SFRateTT.SFRate90,'r',SFRateTT.Time,SFRateTT.SFRate100,'r--o'); 
elseif(ikind==22)
    plot(RFTotalTT.Time,RFTotalTT.RFTot01,'b',RFTotalTT.Time,RFTotalTT.RFTot25,'g',...
        RFTotalTT.Time,RFTotalTT.RFTot50,'k',RFTotalTT.Time,RFTotalTT.RFTot75,'c',...
        RFTotalTT.Time,RFTotalTT.RFTot90,'r',RFTotalTT.Time,RFTotalTT.RFTot100,'r--o');
elseif(ikind==23)
    plot(SFTotalTT.Time,SFTotalTT.SFTot01,'b',SFTotalTT.Time,SFTotalTT.SFTot25,'g',...
        SFTotalTT.Time,SFTotalTT.SFTot50,'k',SFTotalTT.Time,SFTotalTT.SFTot75,'c',...
        SFTotalTT.Time,SFTotalTT.SFTot90,'r',SFTotalTT.Time,SFTotalTT.SFTot100,'r--o');
elseif(ikind==25)
    plot(U10MTT.Time,U10MTT.U10M01,'b',U10MTT.Time,U10MTT.U10M25,'g',...
        U10MTT.Time,U10MTT.U10M50,'k',U10MTT.Time,U10MTT.U10M75,'c',...
        U10MTT.Time,U10MTT.U10M90,'r',U10MTT.Time,U10MTT.U10M100,'r--o');
elseif(ikind==26)
    plot(V10MTT.Time,V10MTT.V10M01,'b',V10MTT.Time,V10MTT.V10M25,'g',...
        V10MTT.Time,V10MTT.V10M50,'k',V10MTT.Time,V10MTT.V10M75,'c',...
        V10MTT.Time,V10MTT.V10M90,'r',V10MTT.Time,V10MTT.V10M100,'r--o');
elseif(ikind==27)
    plot(QV10MTT.Time,QV10MTT.QV10M01,'b',QV10MTT.Time,QV10MTT.QV10M25,'g',...
        QV10MTT.Time,QV10MTT.QV10M50,'k',QV10MTT.Time,QV10MTT.QV10M75,'c',...
        QV10MTT.Time,QV10MTT.QV10M90,'r',QV10MTT.Time,QV10MTT.QV10M100,'r--o');
end
set(gcf,'Position',[hor1 vert1 widd lend])
set(gca,'FontWeight','bold');
set(gca,'XGrid','on','YGrid','on');
if(ikind==1)
    hl=legend('Global Sea Ice Flux 1 PTile','Global Sea Ice Flux 25 PTile','Global Sea Ice Flux 50 PTile','Global Sea Ice Flux75 PTile',...
        'Global Sea Ice Flux 90 PTile','Global Sea Ice Flux 100 PTile','Location','best');
elseif(ikind==2)
        hl=legend('Global Open Water Flux 1 PTile','Global Open Water Flux 25 Ptile','Global Open Water Flux 50 Ptile','Global Open Water Flux 75 Ptile',...
        'Global Open Water Flux 90 Ptile','Global Open Water Flux 100 Ptile','Location','best');
elseif(ikind==3)
        hl=legend('Sea Ice Fraction 1 Ptile','Sea Ice Fraction 25 Ptile','Sea Ice Fraction 50 Ptile',...
        'Sea Ice Fraction Press 75 Ptile','Sea Ice Fraction 90 Ptile','Sea Ice Fraction 100 Ptile','Location','best');
elseif(ikind==4)
        hl=legend('SeaIceArea-Whole World','Sea Ice Area North Pole','Sea Ice Area South Pole','Location','best');
elseif(ikind==5)
        hl=legend('Sea Ice Heat Upwards Flux 1 Ptile','Global  Sea Ice Heat Upwards Flux Ptile','Sea Ice Heat Upwards Flux 50 Ptile',...
            'Sea Ice Heat Upwards Flux 75 Ptile',...
        'Sea Ice Heat Upwards Flux 90 Ptile','Sea Ice Heat Upwards Flux 100 Ptile','Location','best');
elseif(ikind==6)
        hl=legend('Open Heat Upwards Flux 1 Ptile','Open Heat Upwards Flux 25 Ptile','Open Heat Upwards Flux 50 Ptile','Open Heat Upwards Flux 75 Ptile',...
        'Open Heat Upwards Flux 90 Ptile','Open Heat Upwards Flux 100 PTile','Location','best');
elseif(ikind==7)
        hl=legend('Sea Ice Downward Flux 1 Ptile','Sea Ice Downward Flux 25 Ptile','Sea Ice Downward Flux 50 Ptile','Sea Ice Downward Flux 75 Ptile',...
        'Sea Ice Downward Flux 90 Ptile','Sea Ice Downward Flux 100 PTile','Location','best');
elseif(ikind==8)
        hl=legend('Open Water Downward Flux 1 Ptile','Open Water Downward Flux 25 Ptile','Open Water Downward Flux 50 Ptile','Open Water Downward Flux 75 Ptile',...
        'Open Water Downward Flux 90 Ptile','Open Water Downward Flux 100 PTile','Location','best');
elseif(ikind==9)
        hl=legend('Ten Meter Air Temp 1 Ptile','Ten Meter Air Temp 25 Ptile','Ten Meter Air Temp 50 Ptile','Ten Meter Air Temp 75 Ptile',...
        'Ten Meter Air Temp 90 Ptile','Ten Meter Air Temp 100 PTile','Location','best');
elseif(ikind==11)
        hl=legend('Sea Ice Skin Temp 1 Ptile','Sea Ice Skin Temp 25 Ptile','Sea Ice Skin Temp 50 Ptile','Sea Ice Skin Temp 75 Ptile',...
        'Sea Ice Skin Temp 90 Ptile','Sea Ice Skin Temp 100 PTile','Location','best');
elseif(ikind==12)
        hl=legend('Open Water Skin Temp 1 Ptile','Open Water Skin Temp 25 Ptile','Open Water Skin Temp 50 Ptile','Open Water Skin Temp 75 Ptile',...
        'Open Water Skin Temp 90 Ptile','Open Water Skin Temp 100 PTile','Location','best');
elseif(ikind==13)
        hl=legend('Sea Ice SW Down Flux 1 Ptile','Sea Ice SW Down Flux 25 Ptile','Sea Ice SW Down Flux 50 Ptile','Sea Ice SW Down Flux 75 Ptile',...
        'Sea Ice SW Down Flux 90 Ptile','Sea Ice SW Down Flux 100 Ptile','Location','best');
elseif(ikind==14)
        hl=legend('Open Water SW Down Flux 1 Ptile','Open Water SW Down Flux 25 Ptile','Open Water SW Down Flux 50 Ptile','Open WaterSW Down Flux 75 Ptile',...
        'Open Water SW Down Flux 90 Ptile','Open Water SW Down Flux 100 Ptile','Location','best');
elseif(ikind==15)
        hl=legend('Sea Ice EastWind Stress 1 Ptile','Sea Ice EastWind Stress 25 Ptile','Sea Ice EastWind Stress 50 Ptile','Sea Ice EastWind Stress 75 Ptile',...
        'Sea Ice EastWind Stress 90 Ptile','Sea Ice EastWind Stress 100 Ptile','Location','best');
elseif(ikind==16)
        hl=legend('Open Water EastWind Stress 1 Ptile','Open Water EastWind Stress 25 Ptile','Open Water EastWind Stress 50 Ptile','OPen Water EastWind Stress 75 Ptile',...
        'Open Water EastWind Stress 90 Ptile','OPen Water EastWind Stress 100 Ptile','Location','best');
elseif(ikind==17)
        hl=legend('Sea Ice NorthWind Stress 1 Ptile','Sea Ice NorthWind Stress 25 Ptile','Sea Ice NorthWind Stress 50 Ptile','Sea Ice NorthWind Stress 75 Ptile',...
        'Sea Ice NorthWind Stress 90 Ptile','Sea Ice NorthWind Stress 100 Ptile','Location','best');
elseif(ikind==18)
        hl=legend('Open Water NorthWind Stress 1 Ptile','Open Water NorthWind Stress 25 Ptile','Open Water NorthWind Stress 50 Ptile','Open Water NorthWind Stress 75 Ptile',...
        'Open Water NorthWind Stress 90 Ptile','Open Water NorthWind Stress 100 Ptile','Location','best');
elseif(ikind==20)
        hl=legend('Ocean RainFall Rate 1 Ptile','Ocean RainFall Rate 25 Ptile','Ocean RainFall Rate 50 Ptile','Ocean RainFall Rate 75 Ptile',...
        'Ocean RainFall Rate 90 Ptile','Ocean RainFall Rate 100 Ptile','Location','best');
elseif(ikind==21)
        hl=legend('Ocean SnowFall Rate 1 Ptile','Ocean SnowFall Rate 25 Ptile','Ocean SnowFall Rate 50 Ptile','Ocean SnowFall Rate 75 Ptile',...
        'Ocean SnowFall Rate 90 Ptile','Ocean SnowFall Rate 100 Ptile','Location','best');
elseif(ikind==22)
        hl=legend('Ocean RainFall Total 1 Ptile','Ocean RainFall Total 25 Ptile','Ocean RainFall Total 50 Ptile','Ocean RainFall Total 75 Ptile',...
        'Ocean RainFall Total 90 Ptile','Ocean RainFall Total 100 Ptile','Location','best');
elseif(ikind==23)
        hl=legend('Ocean SnowFall Total 1 Ptile','Ocean SnowFall Total 25 Ptile','Ocean SnowFall Total 50 Ptile','Ocean SnowFall Total 75 Ptile',...
        'Ocean SnowFall Total 90 Ptile','Ocean SnowFall Total 100 Ptile','Location','best');
elseif(ikind==25)
        hl=legend('East Wind 1 Ptile','East Wind 25 Ptile','East Wind 50 Ptile','East Wind 75 Ptile',...
        'East Wind 90 Ptile','East Wind 100 Ptile','Location','best');
elseif(ikind==26)
        hl=legend('North Wind 1 Ptile','North Wind 25 Ptile','North Wind 50 Ptile','North Wind 75 Ptile',...
        'North Wind 90 Ptile','North Wind 100 Ptile','Location','best');
elseif(ikind==27)
        hl=legend('QV10M 1 Ptile','QV10M 25 Ptile','QV10M 50 Ptile','QV10M 75 Ptile',...
        'QV10M 90 Ptile','QV10M 100 Ptile','Location','best');
end

ht=title(titlestr);
xlabel('Date','FontWeight','bold','FontSize',12);
if(ikind==1)
    ylabel('Sea Ice Latent Flux-W/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==2)
    ylabel('Open Water Latent Flux-W/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==3)
    ylabel('Sea Ice Fraction','FontWeight','bold','FontSize',12); 
elseif(ikind==4)
    ylabel('Sea Ice Area km^2','FontWeight','bold','FontSize',12); 
elseif(ikind==5)
    ylabel('Sea Ice Upwards Heat Flux W/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==6)
    ylabel('Open Water Upwards Heat Flux W/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==7)
    ylabel('Sea Ice Downward Flux w/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==8)
    ylabel('Open Downward Flux w/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==9)
    ylabel('Ten Meter Air Temp-Deg C','FontWeight','bold','FontSize',12); 
elseif(ikind==11)
    ylabel('Sea Ice Skin Temp Deg-C','FontWeight','bold','FontSize',12); 
elseif(ikind==12)
    ylabel('Open Water Temp Deg-C','FontWeight','bold','FontSize',12);
elseif(ikind==13)
    ylabel('Sea Ice Down Flux w/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==14)
    ylabel('Open Water Down Flux w/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==15)
    ylabel('Sea Ice Eastwind Stress N/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==16)
    ylabel('Open Water Eastwind Stress N/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==17)
    ylabel('Sea Ice Northwind Stress N/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==18)
    ylabel('Open Water Northwind Stress N/m^2','FontWeight','bold','FontSize',12); 
elseif(ikind==20)
    ylabel('Ocean Rainfall Rate  Kg/m^2/hr','FontWeight','bold','FontSize',12); 
elseif(ikind==21)
    ylabel('Ocean Snowfall Rate  Kg/m^2/hr','FontWeight','bold','FontSize',12);
elseif(ikind==22)
    ylabel('Ocean Rainfall Total  Kg/m^2/','FontWeight','bold','FontSize',12); 
elseif(ikind==23)
    ylabel('Ocean Snowfall Total  Kg/m^2/','FontWeight','bold','FontSize',12); 
elseif(ikind==25)
    ylabel('East Wind m/s','FontWeight','bold','FontSize',12); 
elseif(ikind==26)
    ylabel('North Wind m/s','FontWeight','bold','FontSize',12); 
elseif(ikind==27)
    ylabel('QV10M kg/kg','FontWeight','bold','FontSize',12); 
end

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
figstr=strcat(titlestr,'.jpg');
eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
actionstr='print';
typestr='-djpeg';
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
%% Add data to PDF Report
if((iCreatePDFReport==1) && (RptGenPresent==1)  && (iAddToReport==1))
    if(iNewChapter)
        headingstr1='Tabular Analysis Global Results Dataset03';
        chapter = Chapter("Title",headingstr1);
    end
    if(ikind==1)
        sectionstr=strcat('Geopotential Height','-Whole World','-Map');
    elseif(ikind==2)
        sectionstr=strcat('Ozone Ratio','-Whole World','-Map');
    elseif(ikind==3)
        sectionstr=strcat('Surface Pressure','-Whole World','-Map');
    elseif(ikind==4)
        sectionstr=strcat('Specific Humidity','-Whole World','-Map');
    elseif(ikind==5)
        sectionstr=strcat('Sea Level Pressure','-Whole World','-Map');
    elseif(ikind==6)
        sectionstr=strcat('Air Temperature','-Whole World','-Map');
    elseif(ikind==7)
        sectionstr=strcat('East Wind','-Whole World','-Map');
    elseif(ikind==8)
        sectionstr=strcat('North Wind','-Whole World','-Map');
    end    
    add(chapter,Section(sectionstr));
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
    imdata = imread(figstr);
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which(figstr);
    pdftxtstr=strcat(' Dateset03 Variables-',Merra2ShortFileName);
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
    parastr1=strcat('The data for this chart was taken from file-',Merra2ShortFileName,'.');
    if(ikind==1)
        parastr2='This is the monthly averaged Geopotential Height over the globe.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==2)
        parastr2='This is the montly average ozone mixing ratio over the globe.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==3)
        parastr2='This is the montly average surface pressure over the globe.';
        parastr3=' Data displayed if for a local surface height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=' Variations in the local surface height are the big driver.';
    elseif(ikind==4)
        parastr2='This is the monthly averaged specific humidity over the study period.';
        parastr3=' Data displayed if for one pressure level over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=' Moisture content drives atmospheric dynamics.';
    elseif(ikind==5)
        parastr2='This is the monthly averaged sea level pressure over the study period.';
        parastr3=' Data displayed if for sea levelpressure over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=' This compares the pressure at a consistent level but has gaps where the ground is higher than sea level.';
    elseif(ikind==6)
        parastr2='This is monthly averaged air temp over the earth for the study period.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==7)
        parastr2='This is monthly averaged east wind over the earth for the study period.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    elseif(ikind==8)
        parastr2='This is monthly averaged north wind over the earth for the study period.';
        parastr3=' Data displayed if for a single pressure height over one of 4 canonical times.';
        parastr4=strcat('Data displayed is for time-',TimeStr);
        parastr5=strcat('The selected pressure level was-',num2str(iPress42,2));
    end
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p1);
    if(ikind==1)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(HSTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,9);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='HS01';
        Hdrs{1,5}='HS25';
        Hdrs{1,6}='HS50';
        Hdrs{1,7}='HS75';
        Hdrs{1,8}='HS90';
        Hdrs{1,9}='HS100';
        Col1=HSTable.HS01;
        Col2=HSTable.HS25;
        Col3=HSTable.HS50;
        Col4=HSTable.HS75;
        Col5=HSTable.HS90;
        Col6=HSTable.HS100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);               
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%5.2f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global Geopotential Height';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Geopotential Height over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Height Units are in meters.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==2)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(O3STT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='O3S01';
        Hdrs{1,5}='O3S25';
        Hdrs{1,6}='O3S50';
        Hdrs{1,7}='O3S75';
        Hdrs{1,8}='O3S90';
        Hdrs{1,9}='O3S100';
        Col1=O3STable.O3S01;
        Col2=O3STable.O3S25;
        Col3=O3STable.O3S50;
        Col4=O3STable.O3S75;
        Col5=O3STable.O3S90;
        Col6=O3STable.O3S100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%8.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Average Ozone Ratio';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Ozone Ratio over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' The Mixing Ratio is in units of kg/kg.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==3)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(PSSTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='PSS01';
        Hdrs{1,5}='PSS25';
        Hdrs{1,6}='PSS50';
        Hdrs{1,7}='PSS75';
        Hdrs{1,8}='PSS90';
        Hdrs{1,9}='PSS100';
        Col1=PSSTable.PSS01;
        Col2=PSSTable.PSS25;
        Col3=PSSTable.PSS50;
        Col4=PSSTable.PSS75;
        Col5=PSSTable.PSS90;
        Col6=PSSTable.PSS100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%8.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Average Surface Pressure';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged surface pressure over the globe.';
        parastr602=' The values shown are for a single time and the local surface height not a pressure level ';
        parastr603=' The the surface pressure is in units of Pa.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
      elseif(ikind==4)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(QVSTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='QVS01';
        Hdrs{1,5}='QVS25';
        Hdrs{1,6}='QVS50';
        Hdrs{1,7}='QVS75';
        Hdrs{1,8}='QVS90';
        Hdrs{1,9}='QVS100';
        Col1=QVSTable.QVS01;
        Col2=QVSTable.QVS25;
        Col3=QVSTable.QVS50;
        Col4=QVSTable.QVS75;
        Col5=QVSTable.QVS90;
        Col6=QVSTable.QVS100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);              
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%4.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Specific Humidity';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows monthly averaged specific humidity values over the world.';
        parastr602=' The values shown are for a single time and the local surface height not a pressure level ';
        parastr603=' The the surface pressure is in units of Pa.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609); 
     elseif(ikind==5)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(SLPSTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='SLPS01';
        Hdrs{1,5}='SLPS25';
        Hdrs{1,6}='SLPS50';
        Hdrs{1,7}='SLPS75';
        Hdrs{1,8}='SLPS90';
        Hdrs{1,9}='SLPS100';
        Col1=SLPSTable.SLPS01;
        Col2=SLPSTable.SLPS25;
        Col3=SLPSTable.SLPS50;
        Col4=SLPSTable.SLPS75;
        Col5=SLPSTable.SLPS90;
        Col6=SLPSTable.SLPS100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);              
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%4.3e")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Sea Level Pressure';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows monthly averaged sea level pressure  over the world.';
        parastr602=' The values shown are for a single time at sea level not a pressure level ';
        parastr603=' The the sea level pressure is in units of Pa.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609); 
     elseif(ikind==6)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(TSTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='TS01';
        Hdrs{1,5}='TS25';
        Hdrs{1,6}='TS50';
        Hdrs{1,7}='TS75';
        Hdrs{1,8}='TS90';
        Hdrs{1,9}='TS100';
        Col1=TSTable.TS01;
        Col2=TSTable.TS25;
        Col3=TSTable.TS50;
        Col4=TSTable.TS75;
        Col5=TSTable.TS90;
        Col6=TSTable.TS100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%4.1f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global Temp';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged Temperature over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Temperature units are in Deg-C.';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==7)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(USTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='US01';
        Hdrs{1,5}='US25';
        Hdrs{1,6}='US50';
        Hdrs{1,7}='US75';
        Hdrs{1,8}='US90';
        Hdrs{1,9}='US100';
        Col1=USTable.US01;
        Col2=USTable.US25;
        Col3=USTable.US50;
        Col4=USTable.US75;
        Col5=USTable.US90;
        Col6=USTable.US100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%4.1f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global East Wind';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged East Wind over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Wind Magnitude is units are m/sec';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);
     elseif(ikind==8)
        br = PageBreak(); 
        add(chapter,br);
        LeftCol= char(VSTT.Properties.RowTimes);
% Now convert the Left Column to a cell
        [nrows,ncols]=size(LeftCol);
% Now convert this to Year Month Day format in 3 columns
        Years=zeros(nrows,1);
        Months=zeros(nrows,1);
        Days=zeros(nrows,1);
        for n=1:nrows
            nowStr=LeftCol(n,1:ncols);
            daystr=nowStr(1:2);
            monthstr=nowStr(4:6);
            yearstr=nowStr(8:11);
            daynum=str2double(daystr);
            [monthnum] = ConvertMonthStrToNumber(monthstr);
            yearnum=str2double(yearstr);
            Years(n,1)=yearnum;
            Months(n,1)=monthnum;
            Days(n,1)=daynum;
        end
        Hdrs=cell(1,8);
        Hdrs{1,1}='Years';
        Hdrs{1,2}='Months';
        Hdrs{1,3}='Days';
        Hdrs{1,4}='VS01';
        Hdrs{1,5}='VS25';
        Hdrs{1,6}='VS50';
        Hdrs{1,7}='VS75';
        Hdrs{1,8}='VS90';
        Hdrs{1,9}='VS100';
        Col1=VSTable.VS01;
        Col2=VSTable.VS25;
        Col3=VSTable.VS50;
        Col4=VSTable.VS75;
        Col5=VSTable.VS90;
        Col6=VSTable.VS100;
        myCellArray=cell(nrows,6);
        myArray=[Years,Months,Days,Col1,Col2,Col3,Col4,Col5,Col6];
        for i=1:nrows
            myCellArray{i,1}=Years(i,1);
            myCellArray{i,2}=Months(i,1);
            myCellArray{i,3}=Days(i,1);
            for j=1:6
                myCellArray{i,j+3}=myArray(i,j+3);                
            end
        end
        T1=[Hdrs;myCellArray];
        tbl1=Table(T1);
        tbl1.Style = [tbl1.Style {Border('solid','black','3px'),...
            NumberFormat("%4.1f")}];
        tbl1.TableEntriesHAlign = 'center';
        tbl1.HAlign='center';
        tbl1.ColSep = 'single';
        tbl1.RowSep = 'single';
        r = row(tbl1,1);
        r.Style = [r.Style {Color('red'),Bold(true)}];
        bt1 = BaseTable(tbl1);
        tabletitlestr='Merra2 Monthly Averaged Global North Wind';
        tabletitle = Text(tabletitlestr);
        tabletitle.Bold = false;
        bt1.Title = tabletitle;
        bt1.TableWidth="7in";
        add(chapter,bt1);
        parastr601='The table above shows the distribution of the Monthly averaged North Wind over the globe.';
        parastr602=' The values shown are for a single time and a single pressure level ';
        parastr603=' Wind Magnitude is units are m/sec';
%         parastr604=' A diurnal cycle is generally observed for these emissions.';
%         parastr605=' The current table shows the summation for each day using the 24 - 1 hour time slices.';
%         parastr606=' Last column of the table displays the sum of all emissions in all 5 bins.';
        parastr609=strcat(parastr601,parastr602,parastr603);
        p609= Paragraph(parastr609);
        p609.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
        add(chapter,p609);


     end




    if(iCloseChapter==1)
        add(rpt,chapter);
    end
end
    close('all')
end