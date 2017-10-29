**********************************************************************
DEFINE CLASS StringTests_NumericFormats AS FxuTestCase OF FxuTestCase.prg
**********************************************************************

	#IF .F.
		*
		*  this LOCAL declaration enabled IntelliSense for
		*  the THIS object anywhere in this class
		*
		LOCAL THIS AS StringTests_NumericFormats OF StringTests_NumericFormats.prg
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


	FUNCTION TestDecimal
	&& 'D'
	LOCAL nValue 
	nValue = 1234
	cExpected = "1234"
	cActual = _VFP.String.Format("{0:D}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The currency value do not match")

	FUNCTION TestDecimalWithWidth
	&& 'D'
	LOCAL nValue 
	nValue = 1234
	cExpected = "000001234"
	cActual = _VFP.String.Format("{0:D9}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The currency value do not match")

	FUNCTION TestExponential
	&& 'E'	&& Exponential, by default 
	LOCAL nValue, cExpected, cValue 
	nValue = 12345.6789
	cExpected = "1.234568E+004"
	cActual = _VFP.String.Format("{0:E}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The exponential values do not match")

	FUNCTION TestExponential_Small
	&& 'E'	&& Exponential, by default 
	LOCAL nValue, cExpected, cValue 
	nValue = .123456789
	cExpected = "1.234568E-001"
	cActual = _VFP.String.Format("{0:E}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The exponential values do not match")

	FUNCTION TestExponential_Negative
	&& 'E'	&& Exponential, by default 
	LOCAL nValue, cExpected, cValue 
	nValue = -12345.6789
	cExpected = "-1.234568E+004"
	cActual = _VFP.String.Format("{0:E}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The exponential values do not match")

	FUNCTION TestExponential_10
*!*	Console.WriteLine(value.ToString("E10", CultureInfo.InvariantCulture));
*!*	// Displays 1.2345678900E+004
	nValue = .123456789
	cExpected = "1.234568E-001"
	cActual = _VFP.String.Format("{0:E}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The exponential values do not match")

	FUNCTION TestExponential_e4
*!*	Console.WriteLine(value.ToString("e4", CultureInfo.InvariantCulture));
*!*	// Displays 1.2346e+004
	nValue = .123456789
	cExpected = "1.234568E-001"
	cActual = _VFP.String.Format("{0:E}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The exponential values do not match")

	FUNCTION TestNumeric_Cultural
*!*	Console.WriteLine(value.ToString("E", 
*!*	                  CultureInfo.CreateSpecificCulture("fr-FR")));
*!*	// Displays 1,234568E+004	nValue = .123456789
	nValue = 123123.456
	_VFP.String.cNumberSeperator='.'
	_VFP.String.cDecimalPoint=','
	cActual = _VFP.String.Format("{0:N3}", nValue)	
	cExpected = "123.123,456"
	RETURN THIS.AssertEquals(cExpected, cActual, "The numerica value with cultural differences do not match")

	FUNCTION TestCurrency
	&& 'C'	&& Currency
	LOCAL nValue 
	nValue = 1234.5678
	cExpected = "$1,234.57"
	cActual = _VFP.String.Format("{0:C}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The currency value do not match")

	FUNCTION TestCurrency3DigitsOfPrecision
	&& 'C'	&& Currency
	LOCAL nValue 
	nValue = 1234.56789
	cExpected = "$1,234.568"
	cActual = _VFP.String.Format("{0:C3}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The currency value do not match")


	FUNCTION TestCurrencyNoDecimals
	&& 'C'	&& Currency
	LOCAL nValue 
	nValue = 1234.56789
	cExpected = "$1,235"
	cActual = _VFP.String.Format("{0:C0}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The currency value do not match")

	FUNCTION TestPercentage
	&& 'P'	&& Pctg
	LOCAL nValue 
	nValue = .3456
	cExpected = "34.56%"
	cActual = _VFP.String.Format("{0:P2}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The pctg value do not match")

	FUNCTION TestFixedDecimals
	&& 'F'
	LOCAL nValue 
	nValue = 123.3456
	cExpected = "123.346"
	cActual = _VFP.String.Format("{0:F3}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The Fixed Decimals value do not match")

	FUNCTION TestGeneral
	&& 'G'
	LOCAL nValue 
	nValue = 123.3456
	cExpected = "123.3456"
	cActual = _VFP.String.Format("{0:G}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The General value do not match")

	FUNCTION TestNumeric
	&& 'N'
	LOCAL nValue 
	nValue = 123.3456
	cExpected = "123.3"
	cActual = _VFP.String.Format("{0:N1}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The Numeric value do not match")


	FUNCTION TestHex
	&& 'X' Hex 
	LOCAL nValue 
	nValue = 64
	cExpected = "0x00000040"
	cActual = _VFP.String.Format("{0:X}", nValue)	
	RETURN THIS.AssertEquals(cExpected, cActual, "The Numeric value do not match")


	**********************************************************************
ENDDEFINE
**********************************************************************
