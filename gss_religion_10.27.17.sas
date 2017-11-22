libname religion "\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\";
data gss; set religion.GSSNDI2014; run;
proc freq; table race; run;
proc freq; table relig*race fund*race attend*race reliten*race postlife*race memchurh*race; run;
proc freq data = gss; 
table relig*year/out=relig outpct;
table fund*year/out=fund outpct; 
table attend*year/ out=attend outpct;
table reliten*year/ out=reliten outpct; 
table postlife*year/ out=postlife outpct; 
table memchurh*year/out = memchurh outpct ; run;
proc freq data= gss; where race ="black";
table relig*year/out=relig_b outpct;
table fund*year/out=fund_b outpct; 
table attend*year/ out=attend_b outpct;
table reliten*year/ out=reliten_b outpct; 
table postlife*year/ out=postlife_b outpct; 
table memchurh*year/out = memchurh_b outpct ; run;
proc freq data= gss; where race ="white";
table relig*year/out=relig_w outpct;
table fund*year/out=fund_w outpct; 
table attend*year/ out=attend_w outpct;
table reliten*year/ out=reliten_w outpct; 
table postlife*year/ out=postlife_w outpct; 
table memchurh*year/out = memchurh_w outpct ; run;
proc export data=attend 
outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\attend" dmbs=xls replace; run;
proc export data=relig outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\relig" dmbs=xls replace; run;
proc export data=fund outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\fund" dmbs=xls replace; run;
proc export data=reliten outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\reliten" dmbs=xls replace; run;
proc export data=postlife outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\postlife" dmbs=xls replace; run;
proc export data=memchurh outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\memchurh" dmbs=xls replace; run;

proc export data=attend_b 
outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\attend_b" dmbs=xls replace; run;
proc export data=relig_b outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\relig_b" dmbs=xls replace; run;
proc export data=fund_b outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\fund_b" dmbs=xls replace; run;
proc export data=reliten_b outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\reliten_b" dmbs=xls replace; run;
proc export data=postlife_b outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\postlife_b" dmbs=xls replace; run;
proc export data=memchurh_b outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\memchurh_b" dmbs=xls replace; run;

proc export data=attend_w 
outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\attend_w" dmbs=xls replace; run;
proc export data=relig_w outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\relig_w" dmbs=xls replace; run;
proc export data=fund_w outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\fund_w" dmbs=xls replace; run;
proc export data=reliten_w outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\reliten_w" dmbs=xls replace; run;
proc export data=postlife_w outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\postlife_w" dmbs=xls replace; run;
proc export data=memchurh_w outfile="\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\memchurh_w" dmbs=xls replace; run;


proc import  OUT= relig_total DATAFILE= "\\psf\Home\Documents\School\COLUMBIA\Research\Religion and mortality\tables by year\relig var totals" 
            DBMS=xls REPLACE;
     SHEET="SAS"; 
     GETNAMES=YES;
RUN;
data relig_totals; set relig_total;
afterlife1=input(afterlife, 8.);
drop afterlife; rename afterlife1=afterlife;
churchmember1=input(churchmember, 8.);
drop churchmember; rename churchmember1=churchmember;
churchmember1=input(churchmember, 8.);
week_ish = ltweekly + weekly + gtweekly;
month_ish = gtmonthly + monthly;
year_ish = ltyearly + yearly + gtyearly; run;


proc sgplot data = relig_totals; where group = "all"; 
series x= year y = gtweekly ;
series x = year y = weekly;
series x = year y =ltweekly;
series x = year y =gtmonthly;
series x = year y = monthly;
series x = year y = monthly;
series x = year y = gtyearly;
series x = year y = yearly;
series x = year y = ltyearly; 
title  "How often do you attend services? Full sample"; run;

proc sgplot data = relig_totals; where group = "all"; 

series x = year y = year_ish;
series x = year y = week_ish;
series x = year y = month_ish; 
title  "How often do you attend services (collapsed)? Full sample"; run;
proc sgplot data = relig_totals; where group="black"; 

series x = year y = year_ish;
series x = year y = week_ish;
series x = year y = month_ish;
title  "How often do you attend services (collapsed)? Black sample"; run;
proc sgplot data = relig_totals; where group = "black" or group="white"; 

series x = year y = week_ish/group = group;
title  "Proportion endorsing near-weekly attendance: Black vs white"; run;

proc sgplot data = relig_totals; where group = "black" or group="white"; 

series x = year y = year_ish/group = group;
title  "Proportion endorsing near-yearly attendance: Black vs white"; run;
proc sgplot data = relig_totals; where group = "all"; 
series x= year y = fundamentalist ;
series x = year y = moderate;
series x = year y = liberal;

title  "How fundamentalist is your religion? Full sample"; run;

proc sgplot data = relig_totals; where group = "black" or group="white"; 
series x= year y = liberal/ group=group ;


title  "How fundamentalist is your religion? Black vs. white"; run;
proc sgplot data = relig_totals; 
series   x = year y = churchmember/group=group; 
title  "Are you a member of a church? Full sample vs. black vs. white"; run;

proc sgplot data = relig_totals; 
series   x = year y = afterlife/group = group; 
title  "Do you believe in an afterlife? Full sample vs. black vs. white"; run;

proc sgplot data = relig_totals; where group = "all";
series x= year y = none ;
series x = year y = notstrong;
series x = year y = somewhat;
series x = year y = strong;
title  "What is the strength of your religious belief? Full sample"; run;
proc sgplot data = relig_totals; where group = "white";
series x= year y = none ;
series x = year y = notstrong;
series x = year y = somewhat;
series x = year y = strong;
title  "What is the strength of your religious belief? White sample"; run;
proc sgplot data = relig_totals; where group = "black";
series x= year y = none ;
series x = year y = notstrong;
series x = year y = somewhat;
series x = year y = strong;
title  "What is the strength of your religious belief? Black sample"; run;


data relig_totals; set relig_totals;
week = ltweekly + weekly + gtweekly;
month = gtmonthly + monthly;
year = ltyearly + yearly + gtyearly; run;
