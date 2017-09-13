**********************************************************************
DEFINE CLASS StringTestsForGermany as FxuTestCase OF O:\DEV\FOX\VFPX\FOXUNIT\SOURCE\FXUTESTCASE.PRG
**********************************************************************
	#IF .f.
	*
	*  this LOCAL declaration enabled IntelliSense for
	*  the THIS object anywhere in this class
	*
	LOCAL THIS AS StringTestsForGermany OF StringTestsForGermany.PRG
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

*!*		icTestPrefix = "<Your preferred prefix here>"
	
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
	THIS.icSetClassLib = SET("PROCEDURE")
*	SET CLASSLIB TO MyApplicationClassLib.VCX ADDITIVE
	SET PROCEDURE TO String
	THIS.ioObjectToBeTested = CREATEOBJECT("String")

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
    THIS.ioObjectToBeTested = .NULL.
	LOCAL lcSetClassLib
	lcSetClassLib = THIS.icSetClassLib
	SET PROCEDURE TO &lcSetClassLib        

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



  FUNCTION testOneParameter
  LOCAL cExpected, cActual
  cExpected = "Hello, Oberursel!"
  cActual =  THIS.ioObjectToBeTested.Format("Hello, {0}", "Oberursel!")
  This.assertEquals(cExpected, cActual, "Strings don't match!")
  ENDFUNC

  FUNCTION testNoParameters
  LOCAL cExpected, cActual
  cExpected = "Hello, .F."
  cActual =  THIS.ioObjectToBeTested.Format("Hello, {0}")
  This.assertEquals(cExpected, cActual, "Strings don't match!")
  ENDFUNC

  FUNCTION testTooManyParameters
  LOCAL cExpected, cActual
  cExpected = "Hello, Oberursel!"
  cActual =  THIS.ioObjectToBeTested.Format("Hello, {0}!", "Oberursel", "Germany")
 
  This.assertEquals(cExpected, cActual, "Strings don't match!")
  ENDFUNC
 

  FUNCTION testWrongParameterType
  LOCAL cExpected, cActual
  cExpected = "You owe $100!"
  cActual =  THIS.ioObjectToBeTested.Format("You owe ${0}!", 100)
 
  This.assertEquals(cExpected, cActual, "Strings don't match!")
  ENDFUNC
 
 
 


**********************************************************************
ENDDEFINE
**********************************************************************
