" this file contains extra SpeedDating formats
" for the SpeedDating date increment-decrement addon
" vim:fdm=marker

" Help {{{
" SpeedDatingFormat             List defined formats
" SpeedDatingFormat!            This help
" SpeedDatingFormat %Y-%m-%d    Add a format
" 1SpeedDatingFormat %Y-%m-%d   Add a format before first format
" SpeedDatingFormat! %Y-%m-%d   Remove a format
" 1SpeedDatingFormat!           Remove first format
"  
" Expansions:
" %A     weekday (full name)       Tuesday
" %a     weekday (abbreviation)    Tue
" %B     month (full name)         February
" %b     month (abbreviation)      Feb
" %d     day   (01-31)             05
" %H     hour  (00-23)             18
" %h     month (English abbr)      Feb
" %I     hour  (01-12)             06
" %i     weekday (English abbr)    Tue
" %M     minutes                   32
" %m     month (01-12)             02
" %o     day  (1st-31st)           5th
" %P     am/pm                     pm
" %S     seconds                   03
" %v     year (roman numerals)     mmxiii
" %Y     year                      2013
" %y     year  (00-99)             13
" %Z     timezone (incomplete)     UTC
" %z     timezone offset           +0000
" %0x    %x with mandatory leading zeros
" %_x    %x with spaces rather than leading zeros
" %-x    %x with no leading spaces or zeros
" %^x    %x in uppercase
" %*     at beginning/end, surpress \</\> respectively
" %[..]  any one character         \([..]\)
" %?[..] up to one character       \([..]\=\)
" %1     character from first collection match \1
"  
" Examples:
" SpeedDatingFormat %m%[/-]%d%1%Y    " American 12/25/2007
" SpeedDatingFormat %d%[/-]%m%1%Y    " European 25/12/2007
"
" }}}
" Default Formats {{{
"  1 %i, %d %h %Y %H:%M:%S %z         Tue, 05 Feb 2013 18:17:18 +0000 
"  2 %i, %h %d, %Y at %I:%M:%S%^P %z  Tue, Feb 05, 2013 at 06:17:18PM +0000
"  3 %a %b %_d %H:%M:%S %Z %Y         Tue Feb  5 18:17:18 UTC 2013    
"  4 %a %h %-d %H:%M:%S %Y %z         Tue Feb 5 18:17:18 2013 +0000   
"  5 %h %_d %H:%M:%S                  Feb  5 18:17:18                 
"  6 %Y-%m-%d%[ T_-]%H:%M:%S %z       2013-02-05 18:17:18 +0000       
"  7 %Y-%m-%d%[ T_-]%H:%M:%S%?[Z]     2013-02-05 18:17:18             
"  8 %Y-%m-%d                         2013-02-05                      
"  9 %-I:%M:%S%?[ ]%^P                6:17:18PM                       
" 10 %-I:%M%?[ ]%^P                   6:17PM                          
" 11 %-I%?[ ]%^P                      6PM                             
" 12 %H:%M:%S                         18:17:18                        
" 13 %B %o, %Y                        February 5th, 2013              
" 14 %d%[-/ ]%b%1%y                   05-Feb-13                       
" 15 %d%[-/ ]%b%1%Y                   05-Feb-2013                     
" 16 %Y %b %d                         2013 Feb 05                     
" 17 %b %d, %Y                        Feb 05, 2013                    
" 18 %^v                              MMXIII                          
" 19 %v                               mmxiii                          
"
" }}}

" Delete all default formats
SpeedDatingFormat! %i, %d %h %Y %H:%M:%S %z				" Tue, 05 Feb 2013 18:17:18 +0000 
SpeedDatingFormat! %i, %h %d, %Y at %I:%M:%S%^P %z 		" Tue, Feb 06, 2013 at 06:17:18PM +0000
SpeedDatingFormat! %a %b %_d %H:%M:%S %Z %Y        		" Tue Feb  5 18:17:18 UTC 2013    
SpeedDatingFormat! %a %h %-d %H:%M:%S %Y %z        		" Tue Feb 5 18:17:18 2013 +0000   
SpeedDatingFormat! %h %_d %H:%M:%S                 		" Feb  5 18:17:18                 
SpeedDatingFormat! %Y-%m-%d%[ T_-]%H:%M:%S %z      		" 2013-02-05 18:17:18 +0000       
SpeedDatingFormat! %Y-%m-%d%[ T_-]%H:%M:%S%?[Z]    		" 2013-02-05 18:17:18             
SpeedDatingFormat! %Y-%m-%d                        		" 2013-02-05                      
SpeedDatingFormat! %-I:%M:%S%?[ ]%^P               		" 6:17:18PM                       
SpeedDatingFormat! %-I:%M%?[ ]%^P                  		" 6:17PM                          
SpeedDatingFormat! %-I%?[ ]%^P                     		" 6PM                             
SpeedDatingFormat! %H:%M:%S                        		" 18:17:18                        
SpeedDatingFormat! %B %o, %Y                       		" February 5th, 2013              
SpeedDatingFormat! %d%[-/ ]%b%1%y                  		" 05-Feb-13                       
SpeedDatingFormat! %d%[-/ ]%b%1%Y                  		" 05-Feb-2013                     
SpeedDatingFormat! %Y %b %d                        		" 2013 Feb 05                     
SpeedDatingFormat! %b %d, %Y                       		" Feb 05, 2013                    
SpeedDatingFormat! %^v                             		" MMXIII                          
SpeedDatingFormat! %v                              		" mmxiii                          

"Replace format list
SpeedDatingFormat %a %h %-d %H:%M:%S %Y							" Wed Feb 6 18:17:18 2013
SpeedDatingFormat %A%?[,] %B %o%?[,] %Y							" Wednesday, February 6th, 2013
SpeedDatingFormat %A%?[,] %B %-d%?[,] %Y						" Wednesday, February 6, 2013
SpeedDatingFormat %h %d %-I:%M:%S%?[ ]%^P						" Feb 29 5:17:18 PM
SpeedDatingFormat %h %d %H:%M:%S								" Mar 06 18:17:18
SpeedDatingFormat %Y%[-/]%m%1%d %-I:%M:%S%?[ ]%^P				" 2012-12-05 6:17:20 PM
SpeedDatingFormat %Y%[-/]%m%1%d %H:%M:%S						" 2012-12-04 18:17:20
SpeedDatingFormat %Y%[-/]%m%1%d-%H:%M:%S						" 2012-12-04-18:17:20
SpeedDatingFormat %Y%[-/]%m%1%d									" 2012-12-01
SpeedDatingFormat %-m%[/-]%-d%1%Y								" 10/5/2010
SpeedDatingFormat %-I:%M:%S%?[ ]%^P								" 12:17:18PM
SpeedDatingFormat %-I:%M%?[ ]%^P								" 6:17PM
SpeedDatingFormat %-I%?[ ]%^P									" 12AM
SpeedDatingFormat %H:%M:%S										" 21:17:18
SpeedDatingFormat %B %o, %Y										" September 10th, 2014
SpeedDatingFormat %B %-d, %Y									" February 5, 2013
SpeedDatingFormat %d%[-/ ]%b%1%y								" 05-Jun-12
SpeedDatingFormat %d%[-/ ]%b%1%Y								" 05-Feb-2013
SpeedDatingFormat %Y %b %-d										" 2012 May 8
SpeedDatingFormat %b %-d, %Y									" Feb 5, 2013
SpeedDatingFormat %^v											" MMXIII
SpeedDatingFormat %v											" mmxiii

