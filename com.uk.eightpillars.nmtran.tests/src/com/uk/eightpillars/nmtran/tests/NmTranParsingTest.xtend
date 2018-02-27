/*
 * generated by Xtext 2.9.2
 */
package com.uk.eightpillars.nmtran.tests

import com.google.inject.Inject
import com.uk.eightpillars.nmtran.nmTran.NmModel
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Test
import org.junit.runner.RunWith
import com.uk.eightpillars.nmtran.tests.NmTranInjectorProvider
import org.junit.Ignore

@RunWith(XtextRunner)
@InjectWith(NmTranInjectorProvider)
class NmTranParsingTest{

	@Inject extension
	ParseHelper<NmModel>
	@Inject extension
	ValidationTestHelper 

	@Test 
	def void headerParseTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase12_1
; Dated 	: Wed Aug 05 14:51:30 BST 2015

$PROBLEM "UseCase12_1.mdl - generated by MDL2PharmML v.6.0"
		'''.parse
		result.assertNoErrors
	}

	@Test
	def void commentLineDataWithoutQuotesTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase12_1
; Dated 	: Wed Aug 05 14:51:30 BST 2015

$PROBLEM "UseCase12_1.mdl - generated by MDL2PharmML v.6.0" ; test comment 
$INPUT ID TIME WT AMT DVID DV MDV LOGTWT
$DATA ../data/warfarin_conc.csv IGNORE=#
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void commentLineDataWithQuotesTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase12_1
; Dated 	: Wed Aug 05 14:51:30 BST 2015

$PROBLEM "UseCase12_1.mdl - generated by MDL2PharmML v.6.0" ; test comment 
$INPUT  ID TIME WT AGE=DROP SEX=DROP AMT OCC DV MDV
;$DATA "warfarin_conc_bov_P4.csv" IGNORE=@
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void inputParseTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase8
; Dated 	: Wed Aug 05 14:52:35 BST 2015

$PROBLEM "UseCase8.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME WT AGE=DROP SEX=DROP AMT OCC DV MDV
$DATA "warfarin_conc_bov_P4.csv" IGNORE=@
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void modelParseTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase8
; Dated 	: Wed Aug 05 14:52:35 BST 2015

$PROBLEM "UseCase8.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME WT AGE=DROP SEX=DROP AMT OCC DV MDV
$DATA "warfarin_conc_bov_P4.csv" IGNORE=@
$SUBS ADVAN13 TOL=9

$MODEL 
COMP (COMP1) 	;GUT
COMP (COMP2) 	;CENTRAL

$PK 

POP_CL = THETA(1)
POP_V = THETA(2)
POP_KA = THETA(3)
POP_TLAG = THETA(4)
RUV_PROP = THETA(5)
RUV_ADD = THETA(6)
BETA_CL_WT = THETA(7)
BETA_V_WT = THETA(8)

ETA_BSV_CL = ETA(1)
ETA_BOV_CL = ETA(2)
ETA_BSV_V = ETA(3)
ETA_BOV_V = ETA(4)
ETA_BSV_KA = ETA(5)
ETA_BOV_KA = ETA(6)
ETA_BSV_TLAG = ETA(7)
ETA_BOV_TLAG = ETA(8)
LOGTWT = LOG(WT/70)
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void predBlkParseTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase2
; Dated 	: Wed Aug 05 14:52:05 BST 2015

$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
$DATA "warfarin_conc_analytic.csv" IGNORE=@

$PRED 

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

LOGTWT = LOG(WT/70)


MU_1 = LOG(POP_CL)+BETA_CL_WT * LOGTWT;
CL = EXP(MU_1 + ETA(1));

MU_2 = LOG(POP_V)+BETA_V_WT * LOGTWT;
V = EXP(MU_2 + ETA(2));

MU_3 = LOG(POP_KA);
KA = EXP(MU_3 + ETA(3));

MU_4 = LOG(POP_TLAG);
TLAG = EXP(MU_4 + ETA(4));

K = CL/V
		'''.parse
		result.assertNoErrors
	}



	@Test 
	def void expressionUnaryOpParseTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase2
; Dated 	: Wed Aug 05 14:52:05 BST 2015

$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
$DATA "warfarin_conc_analytic.csv" IGNORE=@

$PRED 
Z = -2^8
		'''.parse
		result.assertNoErrors
	}


	@Test 
	def void expressionUnaryOp2ParseTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase2
; Dated 	: Wed Aug 05 14:52:05 BST 2015

$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
$DATA "warfarin_conc_analytic.csv" IGNORE=@

$PRED 
Z = (33.3-2) + -2^-8
		'''.parse
		result.assertNoErrors
	}


	@Test 
	def void expressionConditionTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase2
; Dated 	: Wed Aug 05 14:52:05 BST 2015

$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
$DATA "warfarin_conc_analytic.csv" IGNORE=@

$PRED 

IF(AMT.GT.0) THEN
	D  = AMT
ENDIF
	Z = (33.3-2) + -2^-8
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void expressionConditionalStmtComplexConditionTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase2
; Dated 	: Wed Aug 05 14:52:05 BST 2015

$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
$DATA "warfarin_conc_analytic.csv" IGNORE=@

$PRED 

IF(AMT.EQ.1.AND.AMT.GT.0) THEN
	D  = AMT
ENDIF
Z = (33.3-2) + -2^-8
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void expressionConditionElseTest() {
		val result = '''
; Script generated by the pharmML2Nmtran Converter v.0.1.0
; Source	: PharmML 0.6.0
; Target	: NMTRAN 7.3.0
; Model 	: UseCase2
; Dated 	: Wed Aug 05 14:52:05 BST 2015

$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"

$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
$DATA "warfarin_conc_analytic.csv" IGNORE=@

$PRED 
TLAG = 0
DT = 0
KA = 0
K = 0
V = 0
D = 0
IF ((TIME-DT).LT.TLAG) THEN
	CC = 0 
ELSE
	CC = D/V*KA/(KA-K)*(EXP(-(K)*((TIME-DT)-TLAG))-EXP(-(KA)*((TIME-DT)-TLAG))) 
ENDIF
Z = (33.3-2) + -2^-8
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void OdeInitCondTest() {
		val result = '''
		; Script generated by the pharmML2Nmtran Converter v.0.1.0
		; Source	: PharmML 0.6.0
		; Target	: NMTRAN 7.3.0
		; Model 	: UseCase2
		; Dated 	: Wed Aug 05 14:52:05 BST 2015
		
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
		$DATA "warfarin_conc_analytic.csv" IGNORE=@
		
		$PK 
		A_0(1) = 0
		A_0(2) = 0
		
		$DES 
		GUT = A(1)
		CENTRAL = A(2)
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void OdeDefnCondTest() {
		val result = '''
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
		$DATA "warfarin_conc_analytic.csv" IGNORE=@
		
		$PK 
		V = 1
		CL = 3
		RATEIN = 2
		A_0(1) = 0
		A_0(2) = 0
		
		$DES 
		GUT = A(1)
		CENTRAL = A(2)
		 
		CC_DES =  CENTRAL/V
		DADT(1) = -(RATEIN)
		DADT(2) = (RATEIN-CL*CENTRAL/V)
'''.parse
		result.assertNoErrors
	}


	@Test 
	def void RangeTest() {
		val result = '''
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
		$DATA "warfarin_conc_analytic.csv" IGNORE=@
		
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
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void RangeNoParenTest() {
		val result = '''
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
		$DATA "warfarin_conc_analytic.csv" IGNORE=@
				
		$SIGMA 
		1.0 FIX
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void OmegaDefnTestTest() {
		val result = '''
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
		$DATA "warfarin_conc_analytic.csv" IGNORE=@
				
		$OMEGA BLOCK(2) CORRELATION SD
		(0.1 )	;PPV_CL
		(0.01 )	;PPV_CL_PPV_V
		(0.1 )	;PPV_V
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void EstBlockTest() {
		val result = '''
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME DT WT AMT DVID DV MDV LOGTWT=DROP
		$DATA "warfarin_conc_analytic.csv" IGNORE=@
				

		$EST METHOD=SAEM AUTO=1 PRINT=100
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void SingleTableBlockTest() {
		val result = '''
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME RATE CMT DT WT AMT DVID DV MDV LOGTWT=DROP
		;$DATA "warfarin_conc_analytic.csv" IGNORE=@
				

		$TABLE  ID TIME AMT RATE CMT DV NOAPPEND NOPRINT ;FILE=sdtab
		'''.parse
		result.assertNoErrors
	}

	@Test 
	def void MultiTableBlockTest() {
		val result = '''
		$PROBLEM "UseCase2.mdl - generated by MDL2PharmML v.6.0"
		
		$INPUT  ID TIME DT WT AMT CMT RATE DVID DV MDV LOGTWT=DROP
		$DATA "warfarin_conc_analytic.csv" IGNORE=@
				

		$TABLE  ID TIME AMT RATE CMT LOGTWT DV NOAPPEND NOPRINT ;FILE=sdtab

		$TABLE  ID NOAPPEND NOPRINT ;FILE=patab
		
		$TABLE  ID LOGTWT NOAPPEND NOPRINT ;FILE=cotab
		'''.parse
		result.assertNoErrors
	}

}
