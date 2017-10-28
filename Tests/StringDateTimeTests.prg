**********************************************************************
DEFINE CLASS StringDateTimeTests AS FxuTestCase OF FxuTestCase.prg
**********************************************************************

	#IF .F.
		*
		*  this LOCAL declaration enabled IntelliSense for
		*  the THIS object anywhere in this class
		*
		LOCAL THIS AS StringDateTimeTests OF StringDateTimeTests.PRG
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


	FUNCTION TestShortDateFormat
	&& 'd'	Short date 	10/12/2002
	cResult = _vfp.String.FORMAT("January 1, 2017, is {0:d}.", {^2017/1/1})
	cExpected = "January 1, 2017, is 01/01/2017."
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestLongDateFormat
	&& 'D'	Long date 	Monday, December 10, 2002.  Can't use @YL
	cResult = _vfp.String.FORMAT("January 1, 2017, is {0:D}.", {^2017/1/1})
	cExpected = "January 1, 2017, is Sunday, January 01, 2017."
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestFullDateAndTime
	&& 'f'	Full date & time 	December 10, 2002 10:11 PM
	cResult = _vfp.String.FORMAT("{0:f}.", DATETIME(2017,1,1,5,30,25))
	cExpected = "January 01, 2017 05:30 AM."
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestLongFullDateAndTime
	&& 'F'	Full date & time (long) 	December 10, 2002 10:11:29 PM
	cResult = _vfp.String.FORMAT("{0:F}.", DATETIME(2017,1,1,5,30,25))
	cExpected = "January 01, 2017 05:30:25 AM."
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestDefaultDateAndTime
	&& 'g'	Default date & time (day, month, year) 	10/12/2002 10:11 PM
	cResult = _vfp.String.FORMAT("{0:g}.", DATETIME(2017,10,12,5,30,25))
	cExpected = "10/12/2017 05:30 AM."
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestLongDefaultDateAndTime
	&& 'G'	Default date & time (long) 	10/12/2002 10:11:29 PM
	cResult = _vfp.String.FORMAT("{0:G}.", DATETIME(2017,10,12,5,30,25))
	cExpected = "10/12/2017 05:30:25 AM."
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestMonthDay
	&& 'M'	Month day pattern 	December 10
	cResult = _vfp.String.FORMAT("{0:M}", DATETIME(2017,10,12,5,30,25))
	cExpected = "October 12"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestRFC1123
	&& 'r'	RFC1123 date string 	Tue, 10 Dec 2002 22:11:29 GMT
	cResult = _vfp.String.FORMAT("{0:r}", DATETIME(2017,10,28,17,30,25))
	cExpected = "Sat, 28 Oct 2017 23:30:25 GMT"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestSortableDateString
	&& 's'	Sortable date string 	2002-12-10T22:11:29
	cResult = _vfp.String.FORMAT("{0:s}", DATETIME(2017,10,28,17,30,25))
	cExpected = "2017-10-28T17:30:25"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestShortTime
	&& 't'	Short time 	10:11 PM
	cResult = _vfp.String.FORMAT("{0:t}", DATETIME(2017,10,28,17,30,25))
	cExpected = "17:30 PM"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestLongTime
	&& 'T'	Long time 	10:11:29 PM
	cResult = _vfp.String.FORMAT("{0:T}", DATETIME(2017,10,28,17,30,25))
	cExpected = "17:30:25 PM"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestUniversalSortableUTC
	&& 'u'	Universal sortable, UTC 	2002-12-10 22:13:50Z
	cResult = _vfp.String.FORMAT("{0:u}", DATETIME(2017,10,28,17,30,10))
	cExpected = "2017-10-28 23:30:10Z"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestUniversalFullFormat
	&& 'U'	Universal full format 	December 11, 2002 3:13:50 AM
	cResult = _vfp.String.FORMAT("{0:U}", DATETIME(2017,10,28,17,30,10))
	cExpected = "Saturday, October 28, 2017 23:30:10 PM"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestYearMonth
	&& 'Y'	&& 	Year month pattern 	December, 2002
	cResult = _vfp.String.FORMAT("{0:Y}", DATETIME(2017,10,28,17,30,10))
	cExpected = "October, 2017"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	FUNCTION TestYearMonthNoComma
	&& 'y'	&& 	Year month pattern 	December 2002
	cResult = _vfp.String.FORMAT("{0:y}", DATETIME(2017,10,28,17,30,10))
	cExpected = "October 2017"
	RETURN THIS.AssertEquals(cExpected, cResult, "The datetimes do not match")

	**********************************************************************
ENDDEFINE
**********************************************************************
