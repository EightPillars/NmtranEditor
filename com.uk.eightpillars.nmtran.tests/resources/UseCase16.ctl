; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase16
; Dated 	: Wed Aug 05 14:51:49 BST 2015

$PROBLEM "UseCase16.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID CYCL=DROP TIME FLAG DVX=DROP DV DOS PLA=DROP CL EVID
$DATA "BIOMARKER_simDATA.csv" IGNORE=#
$SUBS ADVAN13 TOL=9

$MODEL 
COMP (COMP1) 	;VEGF
COMP (COMP2) 	;SVEGFR2
COMP (COMP3) 	;SVEGFR3
COMP (COMP4) 	;SKIT

$PK 

IF(DOS.GT.0) THEN
	DOSE  = DOS
ENDIF
POP_IC50 = THETA(1)
POP_BM0 = THETA(2)
POP_MRT = THETA(3)
POP_HILL = THETA(4)
POP_TVSLP = THETA(5)
POP_BM02 = THETA(6)
POP_MRT2 = THETA(7)
POP_HILL2 = THETA(8)
POP_BM03 = THETA(9)
POP_MRT3 = THETA(10)
POP_BM0S = THETA(11)
POP_MRTS = THETA(12)
POP_RES_VEGF_PROP = THETA(13)
POP_RES_SVEGFR2_PROP = THETA(14)
POP_RES_SVEGFR2_ADD = THETA(15)
POP_RES_SVEGFR3_PROP = THETA(16)
POP_RES_SKIT_PROP = THETA(17)
POP_IMAX = THETA(18)

ETA_BM0 = ETA(1)
ETA_BM02 = ETA(2)
ETA_BM03 = ETA(3)
ETA_BM0S = ETA(4)
ETA_IC50 = ETA(5)
ETA_IC502 = ETA(6)
ETA_IC503 = ETA(7)
ETA_IC50S = ETA(8)
ETA_MRT_VEGFS = ETA(9)
ETA_MRT_SKIT = ETA(10)
ETA_TVSLP = ETA(11)
ETA_TVSLPS = ETA(12)


MU_1 = LOG(POP_BM0);
BM0 = EXP(MU_1 + ETA(1));

MU_2 = LOG(POP_BM02);
BM02 = EXP(MU_2 + ETA(2));

MU_3 = LOG(POP_BM03);
BM03 = EXP(MU_3 + ETA(3));

MU_4 = LOG(POP_BM0S);
BM0S = EXP(MU_4 + ETA(4));

IMAX1 = POP_IMAX ;
IMAX2 = POP_IMAX ;
IMAX3 = POP_IMAX ;
IMAXS = POP_IMAX ;
MU_5 = LOG(POP_IC50);
IC50 = EXP(MU_5 + ETA(5));

IC502 = EXP(MU_5 + ETA(6));

IC503 = EXP(MU_5 + ETA(7));

IC50S = EXP(MU_5 + ETA(8));

HILL = POP_HILL ;
HILL2 = POP_HILL2 ;
MU_6 = LOG(POP_MRT);
MRT1 = EXP(MU_6 + ETA(9));

MU_7 = LOG(POP_MRT2);
MRT2 = EXP(MU_7 + ETA(9));

MU_8 = LOG(POP_MRT3);
MRT3 = EXP(MU_8 + ETA(9));

MU_9 = LOG(POP_MRTS);
MRTS = EXP(MU_9 + ETA(10));

TVSLP = POP_TVSLP/1000 ;
MU_10 = LOG(TVSLP);
DPSLP = EXP(MU_10 + ETA(11));

TVSLPS = POP_TVSLP/1000 ;
MU_11 = LOG(TVSLPS);
DPSLPS = EXP(MU_11 + ETA(12));

KOUT = 1/MRT1 ;
KOUT2 = 1/MRT2 ;
KOUT3 = 1/MRT3 ;
KOUTS = 1/MRTS ;
KIN2 = BM02*KOUT2 ;
KIN3 = BM03*KOUT3 ;
A_0(1) = BM0
A_0(2) = BM02
A_0(3) = BM03
A_0(4) = BM0S

$DES 
VEGF = A(1)
SVEGFR2 = A(2)
SVEGFR3 = A(3)
SKIT = A(4)

AUC = DOSE/CL
DP1 = BM0*(1+DPSLP*T)
DPS = BM0S*(1+DPSLPS*T)
KIN = DP1*KOUT
KINS = DPS*KOUTS
EFF = IMAX1*AUC**HILL/(IC50**HILL+AUC**HILL)
EFF2 = IMAX2*AUC**HILL2/(IC502**HILL2+AUC**HILL2)
EFF3 = IMAX3*AUC/(IC503+AUC)
EFFS = IMAXS*AUC/(IC50S+AUC)
LNVEGF = LOG(VEGF)
DADT(1) = (KIN-KOUT*(1-EFF)*VEGF)
DADT(2) = (KIN2*(1-EFF2)-KOUT2*SVEGFR2)
DADT(3) = (KIN3*(1-EFF3)-KOUT3*SVEGFR3)
DADT(4) = (KINS*(1-EFFS)-KOUTS*SKIT)

$ERROR 

IF(FLAG.EQ.5) THEN
	IPRED = LOG(A(1))
W = SQRT(POP_RES_VEGF_PROP**2 + (0.0/A(1))**2)
Y = IPRED+W*EPS(1)
IRES = DV - IPRED
IWRES = IRES/W

ENDIF

IF(FLAG.EQ.6) THEN
	IPRED = LOG(A(2))
W = SQRT(POP_RES_SVEGFR2_PROP**2 + (POP_RES_SVEGFR2_ADD/A(2))**2)
Y = IPRED+W*EPS(1)
IRES = DV - IPRED
IWRES = IRES/W

ENDIF

IF(FLAG.EQ.7) THEN
	IPRED = LOG(A(3))
W = SQRT(POP_RES_SVEGFR3_PROP**2 + (0.0/A(3))**2)
Y = IPRED+W*EPS(1)
IRES = DV - IPRED
IWRES = IRES/W

ENDIF

IF(FLAG.EQ.8) THEN
	IPRED = LOG(A(4))
W = SQRT(POP_RES_SKIT_PROP**2 + (0.0/A(4))**2)
Y = IPRED+W*EPS(1)
IRES = DV - IPRED
IWRES = IRES/W

ENDIF

$THETA 
( 0.0 , 1.0 )	;POP_IC50
( 0.0 , 59.7 )	;POP_BM0
( 0.0 , 91.0 )	;POP_MRT
( 0.0 , 3.31 )	;POP_HILL
( -0.06 , 0.035 )	;POP_TVSLP
( 0.0 , 8670.0 )	;POP_BM02
( 0.0 , 554.0 )	;POP_MRT2
( 0.0 , 1.54 )	;POP_HILL2
( 0.0 , 63900.0 )	;POP_BM03
( 0.0 , 401.0 )	;POP_MRT3
( 0.0 , 39200.0 )	;POP_BM0S
( 0.0 , 2430.0 )	;POP_MRTS
( 0.0 , 0.445 )	;POP_RES_VEGF_PROP
( 0.0 , 0.12 )	;POP_RES_SVEGFR2_PROP
( 0.0 , 583.0 )	;POP_RES_SVEGFR2_ADD
( 0.0 , 0.22 )	;POP_RES_SVEGFR3_PROP
( 0.0 , 0.224 )	;POP_RES_SKIT_PROP
(1.0  FIX )	;POP_IMAX

$OMEGA 
(0.252 )	;OMEGA_BM0
(0.0369 )	;OMEGA_BM02
(0.186 )	;OMEGA_BM03
(0.254 )	;OMEGA_BM0S
(0.06 )	;OMEGA_MRT_VEGFS
(0.0753 )	;OMEGA_MRT_SKIT
(0.253 )	;OMEGA_IC50
(0.189 )	;OMEGA_IC502
(0.398 )	;OMEGA_IC503
(5.77 )	;OMEGA_IC50S
(2.95 )	;OMEGA_TVSLP
(3.01 )	;OMEGA_TVSLPS

$SIGMA 
1.0 FIX	;SIGMA_RES_W


$EST METHOD=COND MAXEVALS=9999 PRINT=10 NOABORT
$COV 

$TABLE  ID TIME FLAG DOS CL EVID PRED IPRED RES IRES WRES IWRES Y DV NOAPPEND NOPRINT FILE=sdtab

$TABLE  ID BM0 BM02 BM03 BM0S IMAX1 IMAX2 IMAX3 IMAXS IC50 IC502 IC503 IC50S HILL HILL2 MRT1 MRT2 MRT3 MRTS TVSLP DPSLP TVSLPS DPSLPS KOUT KOUT2 KOUT3 KOUTS KIN2 KIN3 ETA_BM0 ETA_BM02 ETA_BM03 ETA_BM0S ETA_IC50 ETA_IC502 ETA_IC503 ETA_IC50S ETA_MRT_VEGFS ETA_MRT_SKIT ETA_TVSLP ETA_TVSLPS NOAPPEND NOPRINT FILE=patab

$TABLE  ID CL NOAPPEND NOPRINT FILE=cotab


