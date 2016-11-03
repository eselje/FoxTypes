**********************************************************************
DEFINE CLASS StringTests AS FxuTestCase OF FxuTestCase.prg
**********************************************************************

	#IF .F.
		*
		*  this LOCAL declaration enabled IntelliSense for
		*  the THIS object anywhere in this class
		*
		LOCAL THIS AS StringTests OF StringTests.prg
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
	ADDPROPERTY(_vfp, "STRING", THIS.ioObjectToBeTested)
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
	REMOVEPROPERTY(_Vfp, "STRING")

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
	*    THIS.AssertTrue("Failure message",<Expression>)
	*    THIS.AssertEquals("Failure message",<ExpectedValue>,<Expression>)
	*    THIS.AssertNotNull("Failure message",<Expression>)
	*  all test methods either pass or fail -- the assertions
	*  either succeed or fail

	*
	*  here's a simple AssertNotNull example test method
	*
	*********************************************************************
	FUNCTION TestObjectWasCreated
	*********************************************************************
	
	THIS.AssertNotNull(THIS.ioObjectToBeTested, "Object was not instantiated during Setup()")
	*********************************************************************
	ENDFUNC
	*********************************************************************


	FUNCTION TestStringOneParameter
	cResult = _vfp.String.FORMAT("Welcome to Southwest Fox {0}.", 2016)
	* Ideally we'd test these against C#'s results
	cExpected = "Welcome to Southwest Fox 2016."
	RETURN THIS.AssertEquals(cExpected, cResult, "The strings do not match")

	ENDFUNC


	FUNCTION TestStringOneParameterReused
	cResult = _vfp.String.FORMAT("We have nothing to {0} but {0} itself.", "fear")
	cExpected = "We have nothing to fear but fear itself."
	RETURN THIS.AssertEquals(cExpected, cResult, "The strings do not match")

	ENDFUNC


	FUNCTION TestStringMultipleStringParameters
	cResult = _vfp.String.FORMAT("The {0} in {1} falls {2} on the {3}.", "rain", "Spain", "mainly", "plain")
	cExpected = "The rain in Spain falls mainly on the plain."
	RETURN THIS.AssertEquals(cExpected, cResult, "The strings do not match")

	ENDFUNC

	FUNCTION TestNullParameters
	cResult = _vfp.String.FORMAT("What does {0} equal?", .null.)
	RETURN THIS.AssertHasError("String.Format handled null beautifully.")

	ENDFUNC


	FUNCTION TestUnusedParameters
	cResult = _vfp.String.FORMAT("My favorite Stones album is {1}.", "Exile on Main St.", "Let it Bleed")
	cExpected = "My favorite Stones album is Let it Bleed."
	RETURN THIS.AssertEquals(cExpected, cResult, "The strings do not match")

	ENDFUNC


	FUNCTION TestShortDateFormat
	&& 'd'	Short date 	10/12/2002
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestLongDateFormat
	&& 'D'	Long date 	December 10, 2002.  Can't use @YL
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestFullDateAndTime
	&& 'f'	Full date & time 	December 10, 2002 10:11 PM
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestLongFullDateAndTime
	&& 'F'	Full date & time (long) 	December 10, 2002 10:11:29 PM
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestDefaultDateAndTime
	&& 'g'	Default date & time 	10/12/2002 10:11 PM
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestLongDefaultDateAndTime
	&& 'G'	Default date & time (long) 	10/12/2002 10:11:29 PM
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestMonthDay
	&& 'M'	Month day pattern 	December 10
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestRFC1123
	&& 'r'	RFC1123 date string 	Tue, 10 Dec 2002 22:11:29 GMT
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestSortableDateString
	&& 's'	Sortable date string 	2002-12-10T22:11:29
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestShortTime
	&& 't'	Short time 	10:11 PM
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestLongTime
	&& 'T'	Long time 	10:11:29 PM
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestUniversalSortableLocalTime
	&& 'u'	Universal sortable, local time 	2002-12-10 22:13:50Z
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestUniversaleSortableGMT
	&& 'U'	Universal sortable, GMT 	December 11, 2002 3:13:50 AM
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestYearMonth
	&& 'Y'	&& 	Year month pattern 	December, 2002
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestDecimal
	&& 'D'
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestExponential
	&& 'E'	&& Exponential
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestCurrency
	&& 'C'	&& Currency
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestPercentage
	&& 'P'	&& Pctg
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestFixedDecimals
	&& 'F'
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestGeneral
	&& 'G'
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestNumeric
	&& 'N'
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestRound
	&& 'R'
	RETURN THIS.AssertNotImplemented()

	FUNCTION TestHex
	&& 'X' Hex 
	RETURN THIS.AssertNotImplemented()


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()






  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC


  FUNCTION testNewTest
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
  RETURN This.AssertNotImplemented()

  ENDFUNC

	**********************************************************************
ENDDEFINE
**********************************************************************
