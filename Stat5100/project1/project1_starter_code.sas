/* This first line of code will need to be changed */
FILENAME REFFILE '/home/u41171697/data/project1/snowloads.csv';

/* Read in the csv file using proc import. Note that you will need
   to upload the snowloads.csv file to SAS Studio prior to use */ 
PROC IMPORT DATAFILE=REFFILE replace
	DBMS=CSV
	OUT=WORK.snow;
	GETNAMES=YES;
RUN;

/* Initital regression model */
proc reg data = snow;
model snowload = elevation;
run;


