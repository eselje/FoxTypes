**********************************************************************
DEFINE CLASS DateTimeClassTests as FxuTestCase OF FxuTestCase.prg
**********************************************************************

	#IF .f.
	LOCAL THIS AS DateTimeClassTests OF DateTimeClassTests.PRG
	#ENDIF
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
	SET PROCEDURE TO DateTime.prg ADDITIVE

	THIS.ioObjectToBeTested = CREATEOBJECT("DateTime")
	ADDPROPERTY(_vfp, "DateTime", THIS.ioObjectToBeTested)
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
	REMOVEPROPERTY(_Vfp, "DateTime")

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
	THIS.AssertNotNull(THIS.ioObjectToBeTested, ;
		"Object was not instantiated during Setup()")
	*********************************************************************
	ENDFUNC
	*********************************************************************

	
PROCEDURE testDT_Now
cActual =  DATETIME()
This.AssertNotImplemented()
  RETURN This.AssertNotImplemented()

FUNCTION testDT_Add
* LPARAMETERS cTimeSpan
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_AddDays
* LPARAMETERS iDays
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_AddHours
* LPARAMETERS nHours
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_AddMilliseconds
* LPARAMETERS iMilliseconds
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_AddMinutes
*LPARAMETERS iMonths
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_AddSeconds
*LPARAMETERS iSeconds
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_AddTicks
*LPARAMETERS iTicks
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_AddYears
*LPARAMETERS iYears
cActual =  { :} 
  RETURN This.AssertNotImplemented()

FUNCTION testDT_Compare
LPARAMETERS dt1, dt2
cActual =  0
  RETURN This.AssertNotImplemented()

FUNCTION testDT_DaysInMonth
*LPARAMETERS iMonth
cActual =  0
  RETURN This.AssertNotImplemented()

FUNCTION testDT_Equals
*LPARAMETERS dtValue
cActual =  .f.
  RETURN This.AssertNotImplemented()

FUNCTION testDT_GetDateTimeFormats
*LPARAMETERS cFormat
cActual =  ""
  RETURN This.AssertNotImplemented()

FUNCTION testDT_GetType
cActual =  "T"
  RETURN This.AssertNotImplemented()

FUNCTION testDT_IsDaylightSavingTime()
cActual =  .F.
  RETURN This.AssertNotImplemented()


FUNCTION testDT_IsLeapYear
*LPARAMETERS iYear
cActual =  .F.
  RETURN This.AssertNotImplemented()

FUNCTION testDT_Parse
*LPARAMETERS cDateTime
cActual =  { :}
  RETURN This.AssertNotImplemented()

FUNCTION testDT_Subtract
*LPARAMETERS xTime && Either timespan or datetime
  RETURN This.AssertNotImplemented()

FUNCTION testDT_ToLocalTime
cActual =  { :}
  RETURN This.AssertNotImplemented()

FUNCTION testDT_ToLongDateString
cActual =  ""
  RETURN This.AssertNotImplemented()

FUNCTION testDT_ToLongTimeString
cActual =  ""
  RETURN This.AssertNotImplemented()

FUNCTION testDT_ToShortDateString
cActual =  ""
  RETURN This.AssertNotImplemented()

FUNCTION testDT_ToShortTimeString
cActual =  ""
  RETURN This.AssertNotImplemented()

FUNCTION testDT_ToString
LPARAMETERS cFormat, cString
cActual =  ""
  RETURN This.AssertNotImplemented()

FUNCTION testDT_ToUniversalTime
cActual =  { :}
  RETURN This.AssertNotImplemented()

FUNCTION testDT_TryParse
LPARAMETERS cString
cActual =  .f.
  RETURN This.AssertNotImplemented()


FUNCTION testDT_TryParseExact
* LPARAMETERS cString
cActual =  .f.

  RETURN This.AssertNotImplemented()



**********************************************************************
ENDDEFINE
**********************************************************************
