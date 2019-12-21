/*
   This resid_num_diag.sas file provides 
   a convenient shortcut to obtaining
   numerical checks of residuals from
   a fitted linear regression model.

   The macro takes three arguments, with two additional optionals:
     dataset is the name of the data set
     datavar is the name of the variable in the data set
             for which numerical diagnostics are desired
             (usually a residual)
     label is an optional character string for
           detail in output
     predvar is the (optional) name of the variable
           on which to sort for the Brown-Forsythe test;
           if it is provided, then the Brown-Forsythe test
           is performed, with t-statistic and p-value reported;
           a plot of predvar vs. datavar is also given
     predlabel is the (optional) character string
           for detail in output and plots related to the
           predvar variable

 */


%macro resid_num_diag(dataset,datavar,label='requested variable',predvar=' ',predlabel='predicted variable');

 /* Temporarily suspend output, and create temporary data set,
    with missing values omitted */
title;
*ods select none;
data shortfourplotdataset; set &dataset;
 label &datavar = &label;
 if &datavar ne .;
run;

/* Create necessary global variables: 
     nvalue is sample size of datavar
     meanvalue is mean of datavar
  */
proc means data=shortfourplotdataset noprint;
  var &datavar; output out=shortfourplotoutset N=nval mean=meanval;
data shortfourplotoutset; set shortfourplotoutset; 
	xn=nval; CALL SYMPUT('nval',xn);
	xmean=meanval; CALL SYMPUT('meanval',xmean);
%global nvalue; %let nvalue=&nval;
%global meanvalue; %let meanvalue=&meanval;
run;


/***************************************************************/
/* Do datavar vs. predvar and Brown-Forsythe Test if requested */
/***************************************************************/

%if &predvar ne ' '  %then %do;

    /* datavar vs. predvar plot */
    data shortfourplotdataset; set shortfourplotdataset;
      label &predvar = &predlabel;

    /* Brown-Forsythe */
    *ods listing close; /* suppress output to conserve space */
    proc sort data=shortfourplotdataset out=shortfourplottemp;
       by descending &predvar;
    data shortfourplottemp; set shortfourplottemp;
      shortfourplotorder = _n_;
      shortfourplotgroup = 1-(shortfourplotorder < ceil(&nvalue/2));
    proc means data=shortfourplottemp median noprint;
      by shortfourplotgroup;
      var &datavar;
      output out=shortfourplotouttemp median=medresid;
    run;
    data shortfourplottempnew; merge shortfourplottemp shortfourplotouttemp; by shortfourplotgroup;
      d = abs(&datavar-medresid);
    run;
	run;
    proc ttest data=shortfourplottempnew plots=none;
      class shortfourplotgroup;
      var d;
      *title1 'Two-sample pooled-variance t-test of d is BF';
	  title1 '(Ignore this nuisance output)';
      ods output TTests=shortfourplotBFtemp;
	run;
	run;
    data shortfourplotBFtemp2; set shortfourplotBFtemp;
      if method = 'Pooled';
      t_BF = abs(tValue);
      BF_pvalue = probt;
      keep t_BF BF_pvalue;
    *ods listing; /* undo suppression of output */
    proc print data=shortfourplotBFTemp2;
      title1 'P-value for Brown-Forsythe test of constant variance';
	  title2 'in ' &label ' vs. ' &predlabel;
    run;

%end;


/*********************************/
/* Correlation Test of Normality */
/*********************************/
proc sort data=shortfourplotdataset out=shortfourplottemp;  
  by &datavar;
data shortfourplottemp; set shortfourplottemp;
  n=&nvalue;
  expectNorm = probit((_n_-.375)/(n+.25));
proc corr data=shortfourplottemp;
  var &datavar expectNorm;
  title1 'Output for correlation test of normality of ' &label;
  title2 '(Check text Table B.6 for threshold)';
run;
title;


title;
quit;

%mend resid_num_diag;



