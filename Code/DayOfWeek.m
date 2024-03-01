    %% Day of the week predictor
    clear; clc; close

    %% Use instructions:

    % Introduce input (DMY - day month year) the desired date as an 8 (eight) digit number - no spaces.
    % Use two digits for days and months no matter what:
    % E.g.: For 2 May 2014, DMY=02052014
    % Please keep the year over 1600 so it sticks to the Gregorian calendar

    DMY=19112014;
    
    %% Define variables Y(year), M(month) and D(day)
    
    Y=mod(DMY,10000);
    M=mod(floor(DMY/10000),100);
    D=floor(DMY/1000000);
           
    %% Determine if the year is a regular (non-leap) year or a leap year
    
    LEAP=0;
       
    if mod(Y,4)==0 
        LEAP=1;
        if mod(Y,100)==0 
            if mod(floor(Y/100),4)~=0 
                LEAP=0;
            end
        end
    end
    
    %% Restrictions due to calendar format
    
    % I.e.: Total number of days in a particular month
    %       Total number of month in a year
    %       No year less than 1600 as specified in the Use instructions
    
    % Note: The last 'if' remains open because the calculations are
    %       performed only if a pertinent (real) date was introduced.
   
    OK=1;
    
    if (D>31) || (M>12) || (Y<1600)
        disp('!Such of day doesn''t exist, smarty! Please pay attention to how you define DMY')
        OK=0;
    else if (M==4) || (M==6) || (M==9) || (M==11)
            if (D>30), disp('!Such of day doesn''t exist, smarty! Please pay attention to how you define DMY')
                       OK=0;
            end
         else if (M==2)
                if ((LEAP==1) && (D>29)) || ((LEAP==0) && (D>28)), disp('!Such of day doesn''t exist, smarty! Please pay attention to how you define DMY')
                                                                   OK=0;
                end
             end
        end
    end
   
    if OK==1
        
    %% Display the day, month and year in the command window
    
    MonArray=['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    Show=[num2str(D),' ', MonArray(1+3*(M-1):3+3*(M-1)),' ', num2str(Y)];
    disp(Show)   
        
    %% Set CenCod (century code) and MonCod (month code)
    
    CenCod=[5 3 1];
    MonCod=[6 2 2 5 0 3 5 1 4 6 2 4];
    
    
    %% Apply possible corrections to MonCod (month code)
        
    if LEAP==1 && (M==1 || M==2)
        MonCod(1)=MonCod(1)-1;
        MonCod(2)=MonCod(2)-1;
    end
    
    %% Add the year component give by century's division by 4
     
    var=0;
     
    for i=1:length(CenCod)
        if mod(floor(Y/100),4)==i
            var=var+CenCod(i); end
    end
    
    %% Add the year component given by the prior number of leap years within the century
       
    var=mod(var+mod(floor(mod(Y,100)/4),7),7);
    
    %% Add the year component given by multiples of seven subtraction within the century
      
    var=mod(var+mod(mod(Y,100),7),7);
    
    %% Add the month component
      
    var=mod((var+MonCod(M)),7);
    
    %% Add the day component
      
    var=mod(var+mod(D,7),7);
    
    %% Display if the year is regular (nonleap) or leap
       
    if LEAP==0, disp('This day belongs to a regular (non-leap) year and it is a:')
        else disp('This day belongs to a leap year and it is a:')
    end
    
    %% Display the day of the week for the chosen date
    
  	if var==0
    disp('Sunday') 
        else if var==1, disp('Monday') 
            else if var==2, disp('Tuesday') 
                else if var==3, disp('Wednesday')
                    else if var==4, disp('Thursday') 
                        else if var==5, disp('Friday')
                            else disp('Saturday')
                            end
                        end
                    end
                end
             end
    end
    
    end
    
    clear 
   
    % Code created by Vlad Inculet %
    % 19.11.2014 (Wednsesday), Hannover, Lower Saxony, Germany %
 
   
   % Special thanks to http://gmmentalgym.blogspot.de/, which is
   % recommended to be used as refference for understanding the code.




    
    

