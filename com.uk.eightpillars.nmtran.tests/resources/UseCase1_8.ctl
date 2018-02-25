; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase1_8
; Dated 	: Wed Aug 05 14:52:03 BST 2015

$PROBLEM "UseCase1_8.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME WT AMT DVID DV MDV LOGTWT=DROP
$DATA "warfarin_conc.csv" IGNORE=@
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
ETA_V = ETA(2)
ETA_KA = ETA(3)
ETA_TLAG = ETA(4)

GRPCL = POP_CL*WT/70**BETA_CL_WT 
GRPV = POP_V*WT/70**BETA_V_WT 

MU_1 = GRPCL ;
CL = EXP(MU_1 + ETA(1));

MU_2 = GRPV ;
V = EXP(MU_2 + ETA(2));

MU_3 = LOG(POP_KA);
KA = EXP(MU_3 + ETA(3));

MU_4 = LOG(POP_TLAG);
TLAG = EXP(MU_4 + ETA(4));

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
( 0.001 , 0.362 )	;POP_KA
( 0.001 , 1.0 , 10.0 )	;POP_TLAG
( 0.0 , 0.1 )	;RUV_PROP
( 0.0 , 0.1 )	;RUV_ADD
(0.75  FIX )	;BETA_CL_WT
(1.0  FIX )	;BETA_V_WT

$OMEGA BLOCK(2) CORRELATION SD
(0.1 )	;PPV_CL
(0.01 )	;PPV_CL_PPV_V
(0.1 )	;PPV_V

$OMEGA 
(0.1 SD )	;PPV_KA
(0.1 SD )	;PPV_TLAG

$SIGMA 
1.0 FIX

$EST METHOD=SAEM AUTO=1 PRINT=100


$TABLE  ID TIME WT AMT DVID MDV PRED IPRED RES IRES WRES IWRES Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID CL V KA TLAG ETA_CL ETA_V ETA_KA ETA_TLAG NOAPPEND NOPRINT FILE=patab

$TABLE  ID WT NOAPPEND NOPRINT FILE=cotab


