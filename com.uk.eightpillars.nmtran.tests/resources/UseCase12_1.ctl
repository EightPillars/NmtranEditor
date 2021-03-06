; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase12_1
; Dated 	: Wed Aug 05 14:51:30 BST 2015

$PROBLEM "UseCase12_1.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME=DROP CP DV MDV
$DATA "binary.csv" IGNORE=#

$PRED 
POP_BASEP = THETA(1)
POP_BETA = THETA(2)

ETA_PPV_EVENT = ETA(1)

BASE = LOG(POP_BASEP/(1-POP_BASEP)) 

MU_1 = POP_BASEP+CP;
P1 = 1./(1 + EXP(-MU_1));



$THETA 
( 0.01 , 0.1 , 0.99 )	;POP_BASEP
( 0.0 , 0.5 , 10.0 )	;POP_BETA

$OMEGA 
(0.04 )	;PPV_EVENT

$EST METHOD=COND MAXEVALS=9999 PRINT=10 NOABORT
;Sim_start
;$SIM (12345) (12345 UNIFORM) ONLYSIM NOPREDICTION
;Sim_end


$TABLE  ID TIME CP MDV Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID P1 ETA_PPV_EVENT NOAPPEND NOPRINT FILE=patab


