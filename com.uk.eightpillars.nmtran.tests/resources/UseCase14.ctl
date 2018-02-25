; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase14
; Dated 	: Wed Aug 05 14:51:39 BST 2015

$PROBLEM "UseCase14.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME TRT AMT RATE=DROP ADDL II WT=DROP DVID DV MDV REP=DROP CPX=DROP PCAX=DROP INRX=DROP ICL=DROP IV=DROP ITABS=DROP ITLAG=DROP IF1=DROP IPCA0=DROP IEMAX=DROP IC50=DROP ITEQ=DROP NEVT=DROP
$DATA "warfarin_TTE_exact.csv" IGNORE=#

$PRED 
POP_HBASE = THETA(1)
POP_BTATRT = THETA(2)


HAZTRT = POP_HBASE*TRT 

HBASE = POP_HBASE/365 ;
HAZ = HBASE*(1+HAZTRT)


IF (ICALL.EQ.4) THEN
		 ; ADD TTE DETAILS FOR HAZ
ENDIF

$THETA 
( 0.0 , 0.1 )	;POP_HBASE
( 0.0 , 0.4 )	;POP_BTATRT

$EST METHOD=COND MAXEVALS=9999 PRINT=10 NOABORT
;Sim_start
;$SIM (12345) (12345 UNIFORM) ONLYSIM NOPREDICTION
;Sim_end


$TABLE  ID TIME TRT AMT ADDL II DVID MDV Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID HBASE NOAPPEND NOPRINT FILE=patab

$TABLE  ID TRT NOAPPEND NOPRINT FILE=cotab


