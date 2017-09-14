**********************************************************************
DEFINE CLASS StringTest2 as FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .f.
	*
	*  this LOCAL declaration enabled IntelliSense for
	*  the THIS object anywhere in this class
	*
	LOCAL THIS AS StringTest2 OF StringTest2.PRG
	#ENDIF
	
	*  
	*  declare properties here that are used by one or
	*  more individual test methods of this class
	*
	*  for example, if you create an object to a custom
	*  THIS.Property in THIS.Setup(), estabish the property
	*  here, where it will be available (to IntelliSense)
	*  throughout:
	*
	ioObjectToBeTested = .NULL.
	icSetClassLib = SPACE(0)


	* the icTestPrefix property in the base FxuTestCase class defaults
	* to "TEST" (not case sensitive). There is a setting on the interface
	* tab of the options form (accessible via right-clicking on the
	* main FoxUnit form and choosing the options item) labeld as
	* "Load and run only tests with the specified icTestPrefix value in test classes"
	*
	* If this is checked, then only tests in any test class that start with the
	* prefix specified with the icTestPrefix property value will be loaded
	* into FoxUnit and run. You can override this prefix on a per-class basis.
	*
	* This makes it possible to create ancillary methods in your test classes
	* that can be shared amongst other test methods without being run as
	* tests themselves. Additionally, this means you can quickly and easily 
	* disable a test by modifying it and changing it's test prefix from
	* that specified by the icTestPrefix property
	
	* Additionally, you could set this in the INIT() method of your derived class
	* but make sure you dodefault() first. When the option to run only
	* tests with the icTestPrefix specified is checked in the options form,
	* the test classes are actually all instantiated individually to pull
	* the icTestPrefix value.

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

	*
	*  test methods can use any method name not already used by
	*  the parent FXUTestCase class
	*    MODIFY COMMAND FXUTestCase
	*  DO NOT override any test methods except for the abstract 
	*  test methods Setup() and TearDown(), as described above
	*
	*  the three important inherited methods that you call
	*  from your test methods are:
	*    THIS.AssertTrue(<Expression>, "Failure message")
	*    THIS.AssertEquals(<ExpectedValue>, <Expression>, "Failure message")
	*    THIS.AssertNotNull(<Expression>, "Failure message")
	*  all test methods either pass or fail -- the assertions
	*  either succeed or fail
    
	*
	*  here's a simple AssertNotNull example test method
	*
	*********************************************************************
	FUNCTION TestObjectWasCreated
	*********************************************************************
	THIS.AssertNotNull(THIS.ioObjectToBeTested, ;
		"Object was not instantiated during Setup()")
	*********************************************************************
	ENDFUNC
	*********************************************************************

	*
	*  here's one for AssertTrue
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod 
*!*		*********************************************************************
*!*		THIS.AssertTrue(THIS.ioObjectToBeTested.CustomMethod()), ;
			"Object.CustomMethod() failed")
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	*
	*  and one for AssertEquals
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod100ReturnValue 
*!*		*********************************************************************
*!*
*!*		* Please note that string Comparisons with AssertEquals are
*!*		* case sensitive. 
*!*
*!*		THIS.AssertEquals("John Smith", ;
*!*			            THIS.ioObjectToBeTested.Object.CustomMethod100(), ;
*!*			            "Object.CustomMethod100() did not return 'John Smith'",
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************



  FUNCTION testForOneParameter
   cResult = _vfp.String.FORMAT("Welcome to Southwest Fox {0}.", 2016)
   cExpected = "Welcome to Southwest Fox 2016."
  RETURN This.AssertEquals(cExpected, cResult, "This strings did not match")
  ENDFUNC
  
  

 FUNCTION testConvertUpperCase
 cExpected = 'HELLO PHOENIX'
 cResult = _vfp.string.ToUpper("Hello Phoenix")
  RETURN This.AssertEquals(cExpected, cResult, "This strings did not match")
 


  FUNCTION testCustomDateFormat
	cResult = _vfp.String.FORMAT("It is currently {0:MMM dd, yy hh:mm:ss tt}.", DATETIME(2016,9,23,16,36,12))
	cExpected = "It is currently Sep 23, 16 16:36:12 PM."
  RETURN This.AssertEquals(cExpected, cResult, "This strings did not match")
  
  ENDFUNC


  FUNCTION test0toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "Zero"
	cResult = _vfp.String.Format("{0:W}", 0)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")
  

  FUNCTION test1toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "One"
	cResult = _vfp.String.Format("{0:W}",1)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")


  FUNCTION test21toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "Twenty One"
	cResult = _vfp.String.Format("{0:W}", 21)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")


  FUNCTION test101toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "One Hundred One"
	cResult = _vfp.String.Format("{0:W}", 101)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")

  FUNCTION test1050toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "One Thousand Fifty"
	cResult = _vfp.String.Format("{0:W}", 1050)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")


  FUNCTION test100020toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "One Hundred Thousand Twenty"
	cResult = _vfp.String.Format("{0:W}", 100020)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")


  FUNCTION test1041232toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "One Million Forty One Thousand Two Hundred Thirty Two"
	cResult = _vfp.String.Format("{0:W}", 1041232)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")


  FUNCTION testPoint42toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "Zero and 42/100"
	cResult = _vfp.String.Format("{0:W}", .42)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")

  FUNCTION test1Point42toWord
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
	cExpected = "One and 42/100"
	cResult = _vfp.String.Format("{0:W}", 1.42)
  RETURN This.AssertEquals(cExpected, cResult, "Num2Word did not return the expected result")

  ENDFUNC

**********************************************************************
ENDDEFINE
**********************************************************************
