; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase11
; Dated 	: Wed Aug 05 14:51:22 BST 2015

$PROBLEM "UseCase11.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME=DROP CP DV MDV
$DATA "count.csv" IGNORE=#

$PRED 
POP_BASECOUNT = THETA(1)
POP_BETA = THETA(2)

ETA_PPV_EVENT = ETA(1)


LOGLAMBDA = ((LOG(POP_BASECOUNT)+POP_BETA*CP)+ETA_PPV_EVENT) ;


IF (ICALL.EQ.4) THEN
	T=0
	 N=0
		 DO WHILE (T.LT.1)              ;LOOP
		 CALL RANDOM (2,R)              ;RANDOM NUMBER IN A UNIFORM DISTRIBUTION
		 T=T-LOG(1-R)/LOGLAMBDA
		 IF (T.LT.1) N=N+1
		 END DO
	 DV=N                            ;INCREMENTATION OF ONE INTEGER TO THE DV
ENDIF
IF (DV.GT.0) THEN
	 LFAC = GAMLN(DV+1)
ELSE
	 LFAC=0
ENDIF

;LOGARITHM OF THE POISSON DISTRIBUTION
LPOI = -LOGLAMBDA+DV*LOG(LOGLAMBDA)-LFAC
;-2 LOG LIKELIHOOD
Y=-2*(LPOI)

$THETA 
( 0.0 , 10.0 )	;POP_BASECOUNT
( 0.0 , 0.5 , 10.0 )	;POP_BETA

$OMEGA 
(0.04 )	;PPV_EVENT

$EST METHOD=COND MAXEVALS=9999 PRINT=10 NOABORT -2LL LAPLACE
;Sim_start
;$SIM (12345) (12345 UNIFORM) ONLYSIM NOPREDICTION
;Sim_end


$TABLE  ID TIME CP MDV Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID logLAMBDA ETA_PPV_EVENT NOAPPEND NOPRINT FILE=patab

