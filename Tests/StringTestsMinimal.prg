**********************************************************************
DEFINE CLASS StringTestsMinimal as FxuTestCase OF FxuTestCase.prg
**********************************************************************

	#IF .f.
	LOCAL THIS AS StringTestsMinimal OF StringTestsMinimal.PRG
	#ENDIF
	
	ioObjectToBeTested = .null.
	icTestPrefix = "test"
	icSetClassLib = ""
********************************************************************
	FUNCTION SETUP
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
	SET PROCEDURE TO STRING.prg ADDITIVE
	THIS.ioObjectToBeTested = CREATEOBJECT("String")
	ADDPROPERTY(_VFP, "String", THIS.ioObjectToBeTested)

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
	REMOVEPROPERTY(_VFP, "string")
	THIS.ioObjectToBeTested = .NULL.
	LOCAL lcSetClassLib
	lcSetClassLib = THIS.icSetClassLib
	SET CLASSLIB TO &lcSetClassLib

********************************************************************
	ENDFUNC
********************************************************************	


	PROCEDURE test_JSONFormatReplace
	cString = "{['JSON' : {0}}"
	cTransformed = _VFP.String.Format(cString, 'true')
	This.MessageOut(cTransformed)
	This.AssertEquals(cTransformed, "{['JSON' : true}", "String did not format properly.")
	
**********************************************************************
ENDDEFINE
**********************************************************************
