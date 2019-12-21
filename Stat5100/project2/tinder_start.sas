FILENAME REFFILE '/home/jrstevens/STAT5100/tinder.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.tinder;
	GETNAMES=YES;
RUN;


/* Look at crude initial model */
proc reg data=tinder plots=(CooksD RStudentByLeverage DFFITS DFBETAS);
 model genuine = socprivconc instprivconc narcissism selfesteem loneliness
                 hookup friends partner travel selfvalidation entertainment
                 age impfitness impenergy impattractive / vif collin;
run;

/* Check hard upper bound on genuine */
proc univariate data=tinder;
 var genuine;
 histogram genuine;
run;
proc sort data=tinder; by genuine;
data tinder; set tinder; ID = _n_;
proc sgplot data=tinder; 
  scatter x=ID y=genuine;
run;

/* Try Reg Tree & RF */
proc hpsplit data=tinder maxdepth=15 maxbranch=2 seed=1234;
 model genuine = socprivconc instprivconc narcissism selfesteem loneliness
                 hookup friends partner travel selfvalidation entertainment
                 age impfitness impenergy impattractive;
run;
proc hpforest data=tinder seed=1234 scoreprole=oob;
 input socprivconc instprivconc narcissism selfesteem loneliness
                 hookup friends partner travel selfvalidation entertainment
                 age impfitness impenergy impattractive;
 target genuine;
run;

/* Try robust reg */
proc robustreg data=tinder method=MM(initest=S);
class Education Orientation;
model genuine = InstPrivConc selfEsteem Hookup Friends Partner SelfValidation 
           Entertainment Orientation Education ImpFitness;
title1 'Robust Regression on Data';
run;

