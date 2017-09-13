**********************************************************************
DEFINE CLASS NumberTests as FxuTestCase OF FxuTestCase.prg
**********************************************************************

	#IF .f.
	LOCAL THIS AS NumberTests OF NumberTests.PRG
	#ENDIF
	PROTECTED Number 
	
	********************************************************************
	FUNCTION Setup
	********************************************************************
	This.Number = CREATEOBJECT("Number")
	
	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION TearDown
	********************************************************************
	This.Number = null
	********************************************************************
	ENDFUNC
	********************************************************************	



  FUNCTION testObjectWasCreated
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertIsObject(This.Number, "Number was not created")

  ENDFUNC


  FUNCTION  testNumberToDate
	LOCAL cExpeced, cActual
	cExpected = "Day 100 = March 31"
	cActual = "Day 100 = " + This.Number.toDate(100)
	This.assertEquals(cExpected, cActual, "toDate does not return correct value")
	
	
  ENDFUNC

**********************************************************************
ENDDEFINE
**********************************************************************
