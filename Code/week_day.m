
   function [w,DoW] = week_day(m,d,cy)
   %
   %  Find the day of week for any given date. 
   %   
   %  The trick is to put March 1st as the first day of the year.
   %  Regardless to know if the date is in the leap year or not.
   %
   %  Examples:
   %     w = week_day(01,17,2016)  --->   w = 0 {Sun)
   %     w = week_day(12,31,1999)  --->   w = 5 {Fri)
   %     w = week_day(01,01,2000)  --->   w = 6 {Sat)
   %     w = week_day(02,28,1900)  --->   w = 3 {Wed) not leap year
   %     w = week_day(03,01,1900)  --->   w = 4 {Thu)
   %     w = week_day(02,29,2000)  --->   w = 2 {Tue)   leap year
   %     w = week_day(03,01,2000)  --->   w = 3 {Wed)
   % 

       if m > 2, m = m-2;
       else
           m = m+10;
           cy = cy-1;
       end
        c = fix(cy/100); 
        y = mod(cy,100);        
        w = mod(d+fix(m*2.59)+fix(y*1.25)+fix(c*5.25),7);
        DoW='Sunday';
        if(w==0)
            DoW='Sunday';
        elseif(w==1)
            DoW='Monday';
        elseif(w==2)
            DoW='Tuesday';
        elseif(w==3)
            DoW='Wednesday';
        elseif(w==4)
            DoW='Thursday';
        elseif(w==5)
            DoW='Friday';
        elseif(w==6)
            DoW='Saturday';
        end
