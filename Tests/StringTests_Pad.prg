**********************************************************************
DEFINE CLASS StringTests_Pad as FxuTestCase OF FxuTestCase.prg
**********************************************************************

	#IF .f.
	LOCAL THIS AS StringTests_Pad OF StringTests_Pad.PRG
	#ENDIF
	
	ioObjectToBeTested = .null.
	icSetClassLib = ""
	icTestPrefix = "test"
	
	********************************************************************
	FUNCTION Setup
	********************************************************************
	*
	*  put common setup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can instantiate all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
	THIS.icSetClassLib = SET("CLASSLIB")
	SET PROCEDURE TO String.prg ADDITIVE
	THIS.ioObjectToBeTested = CREATEOBJECT("String")
	ADDPROPERTY(_vfp,"String",this.ioObjectToBeTested)

	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION TearDown
	********************************************************************
	*
	*  put common cleanup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can release  all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
    RemoveProperty(_vfp, "string")
    THIS.ioObjectToBeTested = .NULL.
	LOCAL lcSetClassLib
	lcSetClassLib = THIS.icSetClassLib
	SET CLASSLIB TO &lcSetClassLib        

	********************************************************************
	ENDFUNC
	********************************************************************	


FUNCTION test_PadLeft
	cResult = _vfp.String.PadLeft(" Super Bowl", 14, 'X')
	cExpected = "XXX Super Bowl"
	This.AssertEquals(cExpected, cResult, "PadLeft did not work properly")
ENDFUNC
	

FUNCTION test_PadRight
	cResult = _vfp.String.PadRight("Super Bowl ", 14, 'X')
	cExpected = "Super Bowl XXX"
	This.AssertEquals(cExpected, cResult, "PadRight did not work properly")
ENDFUNC

FUNCTION test_PadCenter
	cResult = _vfp.String.PadCenter("Super Bowl", 20, 'X')
	cExpected = "XXXXXSuper BowlXXXXX"
	This.AssertEquals(cExpected, cResult, "PadCenter did not work properly")
ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC

**********************************************************************
ENDDEFINE
**********************************************************************
