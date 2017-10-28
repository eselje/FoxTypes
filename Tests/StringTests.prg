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


  FUNCTION testNewLine
	* 1. Change the name of the test to reflect its purpose. Test one thing only.
	* 2. Implement the test by removing these comments and the default assertion and writing your own test code.
 	cResult = _vfp.String.FORMAT("This is line 1.\nThis is line 2")
	cExpected = "This is line 1."+CHR(10)+CHR(13)+"This is line 2"
	RETURN THIS.AssertEquals(cExpected, cResult, "The strings do not match")

  RETURN This.AssertNotImplemented()


FUNCTION testStringLastIndexOf
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="Fox"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurence=1
	lCaseSensitive=.F.
	cResult = _vfp.String.IndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive)
	cExpected = 17
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched +"]")

  ENDFUNC

FUNCTION testStringLastIndexOf_2ndOccurence
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="e"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurrence=2
	lCaseSensitive=.F.
	cResult = _vfp.String.IndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive)
	cExpected = 25
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched +"]")

  ENDFUNC

FUNCTION testStringLastIndexOf_0thOccurence
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="e"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurrence=0
	lCaseSensitive=.F.
	cResult = _vfp.String.IndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive)
	cExpected = 0
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched +"]")

  ENDFUNC

FUNCTION testStringLastIndexOf_CaseSensitive
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="Fox"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurence=1
	lCaseSensitive=.T.
	cResult = _vfp.String.IndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive)
	cExpected = 0
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched + "] (case sensitive)")

  ENDFUNC

FUNCTION testStringLastIndexOf
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="o"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurence=1
	lCaseSensitive=.F.
	cResult = _vfp.String.LastIndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive)
	cExpected = 43
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched +"]")

  ENDFUNC

FUNCTION testStringLastIndexOf_2ndOccurence
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="e"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurrence=2
	lCaseSensitive=.F.
	cResult = _vfp.String.LastIndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive)
	cExpected = 30
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched +"]")

  ENDFUNC

FUNCTION testStringLastIndexOf_0thOccurence
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="e"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurrence=0
	lCaseSensitive=.F.
	cResult = _vfp.String.LastIndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive)
	cExpected = 0
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched +"]")

  ENDFUNC

FUNCTION testStringLastIndexOf_CaseSensitive
	LOCAL cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive
	cSearchExpression="Fox"
	cExpressionSearched="The quick brown fox jumped over the lazy dog."
	nOccurence=1
	lCaseSensitive=.T.
	cResult = _vfp.String.IndexOf(cSearchExpression, cExpressionSearched, nOccurrence, lCaseSensitive, .t.)
	cExpected = 0
	RETURN THIS.AssertEquals(cExpected, cResult, "Did not find [" +cSearchExpression + "] in [" + cExpressionSearched + "] (case sensitive)")

  ENDFUNC


	**********************************************************************
ENDDEFINE
**********************************************************************
