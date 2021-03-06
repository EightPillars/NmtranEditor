; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase8_3
; Dated 	: Wed Aug 05 14:52:38 BST 2015

$PROBLEM "UseCase8_3.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME WT AGE=DROP SEX=DROP AMT OCC DV MDV
$DATA "warfarin_conc_bov_P4.csv" IGNORE=@
$SUBS ADVAN13 TOL=9

$MODEL 
COMP (COMP1) 	;GUT
COMP (COMP2) 	;CENTRAL

$PK 

IF(AMT.GT.0) THEN
	GUT  = AMT
ENDIF
POP_CL = THETA(1)
POP_V = THETA(2)
POP_KA = THETA(3)
POP_TLAG = THETA(4)
RUV_PROP = THETA(5)
RUV_ADD = THETA(6)
BETA_CL_WT = THETA(7)
BETA_V_WT = THETA(8)

ETA_CL = ETA(1)
ETA_BSV_V = ETA(2)
ETA_BOV_V = ETA(3)
ETA_BSV_KA = ETA(4)
ETA_BOV_KA = ETA(5)
ETA_BSV_TLAG = ETA(6)
ETA_BOV_TLAG = ETA(7)
ETA_BSV_CL = ETA(8)
ETA_BOV_CL = ETA(9)

LOGTWT = LOG(WT/70)

GRPCL = (LOG(POP_CL)+BETA_CL_WT*LOGTWT) 
GRPV = (LOG(POP_V)+BETA_V_WT*LOGTWT) 
GRPKA = LOG(POP_KA) 
GRPLG = LOG(POP_TLAG) 

ETA_CL = (ETA_BSV_CL+ETA_BOV_CL) ;
MU_1 = GRPCL ;
CL = EXP(MU_1 + ETA(1));

MU_2 = GRPV ;
V = EXP(MU_2 + ETA(2)+ ETA(3));

MU_3 = GRPKA ;
KA = EXP(MU_3 + ETA(4)+ ETA(5));

MU_4 = GRPLG ;
TLAG = EXP(MU_4 + ETA(6)+ ETA(7));

A_0(1) = 0
A_0(2) = 0

$DES 
GUT = A(1)
CENTRAL = A(2)

IF (T.GE.TLAG) THEN
	RATEIN = GUT*KA 
ELSE
	RATEIN = 0 
ENDIF
 
CC_DES =  CENTRAL/V
DADT(1) = -(RATEIN)
DADT(2) = (RATEIN-CL*CENTRAL/V)

$ERROR 
CC =  A(2)/V

IPRED = CC
W = RUV_ADD+RUV_PROP*IPRED
Y = IPRED+W*EPS(1)
IRES = DV - IPRED
IWRES = IRES/W

$THETA 
( 0.001 , 0.1 )	;POP_CL
( 0.001 , 8.0 )	;POP_V
( 0.001 , 2.0 )	;POP_KA
( 0.001 , 1.0 )	;POP_TLAG
( 0.0 , 0.1 )	;RUV_PROP
( 0.0 , 0.224 )	;RUV_ADD
(0.75  FIX )	;BETA_CL_WT
(1.0  FIX )	;BETA_V_WT

$OMEGA 
(0.1 )	;BSV_CL
(0.1 )	;BSV_V
(0.1 )	;BSV_KA
(0.1 )	;BSV_TLAG
(0.1  FIX )	;BOV_CL
(0.1  FIX )	;BOV_V
(0.1 )	;BOV_KA
(0.1 )	;BOV_TLAG

$SIGMA 
1.0 FIX

$EST METHOD=COND INTER MAXEVALS=9999 PRINT=10 NOABORT

$TABLE  ID TIME WT AMT OCC MDV PRED IPRED RES IRES WRES IWRES Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID eta_CL CL V KA TLAG ETA_CL ETA_BSV_V ETA_BOV_V ETA_BSV_KA ETA_BOV_KA ETA_BSV_TLAG ETA_BOV_TLAG ETA_BSV_CL ETA_BOV_CL NOAPPEND NOPRINT FILE=patab

$TABLE  ID WT NOAPPEND NOPRINT FILE=cotab


