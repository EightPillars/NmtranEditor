; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase4_1
; Dated 	: Wed Aug 05 14:52:18 BST 2015

$PROBLEM "UseCase4_1.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME WT=DROP AMT RATE CMT DV LOGTWT
$DATA "warfarin_infusion_oral.csv" IGNORE=@
$SUBS ADVAN13 TOL=9

$MODEL 
COMP (COMP1) 	;CENTRAL
COMP (COMP2) 	;AD3

$PK 

IF(CMT.EQ.2.AND.AMT.GT.0) THEN
	CENTRAL  = AMT
ENDIF
POP_CL = THETA(1)
POP_V = THETA(2)
POP_KA = THETA(3)
POP_TLAG = THETA(4)
POP_FORAL = THETA(5)
RUV_PROP = THETA(6)
RUV_ADD = THETA(7)
BETA_CL_WT = THETA(8)
BETA_V_WT = THETA(9)

ETA_CL = ETA(1)
ETA_V = ETA(2)
ETA_KA = ETA(3)
ETA_TLAG = ETA(4)
ETA_FORAL = ETA(5)


MU_1 = LOG(POP_CL)+BETA_CL_WT * LOGTWT;
CL = EXP(MU_1 + ETA(1));

MU_2 = LOG(POP_V)+BETA_V_WT * LOGTWT;
V = EXP(MU_2 + ETA(2));

MU_3 = LOG(POP_KA);
KA = EXP(MU_3 + ETA(3));

MU_4 = LOG(POP_TLAG);
ALAG1 = EXP(MU_4 + ETA(4));

F1 = 1 ;
A_0(1) = 0.0
A_0(2) = 0.0

$DES 
CENTRAL = A(1)
AD3 = A(2)

CONC_DES =  CENTRAL/V
DADT(1) = (KA*AD3-CL/V*CENTRAL)
DADT(2) = -(KA*AD3)

$ERROR 
CONC =  A(1)/V

IPRED = CONC
W = RUV_ADD+RUV_PROP*IPRED
Y = IPRED+W*EPS(1)
IRES = DV - IPRED
IWRES = IRES/W

$THETA 
( 0.001 , 0.1 )	;POP_CL
( 0.001 , 8.0 )	;POP_V
( 0.001 , 0.362 )	;POP_KA
( 0.001 , 1.0 , 10.0 )	;POP_TLAG
( 0.001 , 0.7 )	;POP_FORAL
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
(0.1 SD )	;PPV_FORAL

$SIGMA 
1.0 FIX

$EST METHOD=SAEM AUTO=1 PRINT=100


$TABLE  ID TIME AMT RATE CMT LOGTWT PRED IPRED RES IRES WRES IWRES Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID CL V KA ALAG1 F1 ETA_CL ETA_V ETA_KA ETA_TLAG ETA_FORAL NOAPPEND NOPRINT FILE=patab

$TABLE  ID LOGTWT NOAPPEND NOPRINT FILE=cotab


