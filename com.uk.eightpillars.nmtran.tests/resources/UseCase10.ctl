; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase10
; Dated 	: Wed Aug 05 14:51:22 BST 2015

$PROBLEM "UseCase10.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME WT AMT CMT DVID DV MDV LOGTWT
$DATA "warfarin_conc_cmt.csv" IGNORE=@
$SUBS ADVAN13 TOL=9

$MODEL 
COMP (COMP1) 	;CENTRAL
COMP (COMP2) 	;PERIPHERAL1
COMP (COMP3) 	;AD4

$PK 
POP_CL = THETA(1)
POP_VC = THETA(2)
POP_Q = THETA(3)
POP_VP = THETA(4)
POP_KA = THETA(5)
POP_TLAG = THETA(6)
RUV_PROP = THETA(7)
RUV_ADD = THETA(8)
POP_BETA_CL_WT = THETA(9)
POP_BETA_V_WT = THETA(10)

ETA_PPV_CL = ETA(1)
ETA_PPV_VC = ETA(2)
ETA_PPV_Q = ETA(3)
ETA_PPV_VP = ETA(4)
ETA_PPV_KA = ETA(5)
ETA_PPV_TLAG = ETA(6)


MU_1 = LOG(POP_CL)+POP_BETA_CL_WT * LOGTWT;
CL = EXP(MU_1 + ETA(1));

MU_2 = LOG(POP_VC)+POP_BETA_V_WT * LOGTWT;
VC = EXP(MU_2 + ETA(2));

MU_3 = LOG(POP_Q)+POP_BETA_CL_WT * LOGTWT;
Q = EXP(MU_3 + ETA(3));

MU_4 = LOG(POP_VP)+POP_BETA_V_WT * LOGTWT;
VP = EXP(MU_4 + ETA(4));

MU_5 = LOG(POP_KA);
KA = EXP(MU_5 + ETA(5));

MU_6 = LOG(POP_TLAG);
TLAG = EXP(MU_6 + ETA(6));

ALAG1 = TLAG ;
V2 = VC ;
V3 = VP ;
S2 = VC ;
A_0(1) = 0.0
A_0(2) = 0.0
A_0(3) = 0.0

$DES 
CENTRAL = A(1)
PERIPHERAL1 = A(2)
AD4 = A(3)

F = CENTRAL/S2
CC_DES =  F
DADT(1) = (((-(Q/V2*PERIPHERAL1)+Q/V3*PERIPHERAL1)+KA*AD4)-CL/V2*CENTRAL)
DADT(2) = (Q/V2*CENTRAL-Q/V3*CENTRAL)
DADT(3) = -(KA*AD4)

$ERROR 
CC =  F

IPRED = CC
W = RUV_ADD+RUV_PROP*IPRED
Y = IPRED+W*EPS(1)
IRES = DV - IPRED
IWRES = IRES/W

$THETA 
( 0.001 , 0.1 )	;POP_CL
( 0.001 , 8.0 )	;POP_VC
( 0.001 , 0.2 )	;POP_Q
( 0.001 , 20.0 )	;POP_VP
( 0.001 , 0.362 )	;POP_KA
( 0.001 , 1.0 )	;POP_TLAG
( 0.0 , 0.1 )	;RUV_PROP
( 0.0 , 0.1 )	;RUV_ADD
(0.75  FIX )	;POP_BETA_CL_WT
(1.0  FIX )	;POP_BETA_V_WT

$OMEGA BLOCK(2) CORRELATION SD
(0.1 )	;PPV_CL
(0.01 )	;PPV_CL_PPV_VC
(0.1 )	;PPV_VC

$OMEGA 
(0.1 SD )	;PPV_Q
(0.1 SD )	;PPV_VP
(0.1 SD )	;PPV_KA
(0.1 SD )	;PPV_TLAG

$SIGMA 
1.0 FIX SD	;RUV_EPS1


$EST METHOD=SAEM AUTO=1 PRINT=100


$TABLE  ID TIME WT AMT CMT DVID MDV LOGTWT PRED IPRED RES IRES WRES IWRES Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID CL VC Q VP KA TLAG ALAG1 V2 V3 S2 ETA_PPV_CL ETA_PPV_VC ETA_PPV_Q ETA_PPV_VP ETA_PPV_KA ETA_PPV_TLAG NOAPPEND NOPRINT FILE=patab

$TABLE  ID WT LOGTWT NOAPPEND NOPRINT FILE=cotab


