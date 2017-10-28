#DEFINE StringCompareOptions_CaseInsensitive	1
#DEFINE StringCompareOptions_Exact				2

**********************************************************************
DEFINE CLASS StringTests3 AS FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .F.
*
*  this LOCAL declaration enabled IntelliSense for
*  the THIS object anywhere in this class
*
		LOCAL THIS AS StringTests3 OF StringTests3.prg
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


	FUNCTION test_Replace
	* Returns a new string in which all occurrences of a specified Unicode character in this instance are replaced with another specified Unicode character.
	LOCAL cString, cFind, cReplace
	cString = "We have nothing to fear but fear itself."
	cFind = "fear"
	cReplace = "hate"
	cExpected = "We have nothing to hate but hate itself."
	cActual = _VFP.String.Replace(cString, cFind, cReplace)
	This.AssertEquals(cExpected, cActual, ".Replace() didn't get the results we expected.")
	
	
	FUNCTION test_Extract
	LOCAL cSearchExpression, cBeginDelim, cEndDelim, nOccurrence, nFlag
	cSearchExpression = "<a href='test.html'>This is a test.</a>"
	cBeginDelim = '>'
	cEndDelim = '<'
	nOccurrence = 1
	nFlag = 0
	
	cResult = _VFP.STRING.Extract(cSearchExpression, cBeginDelim, cEndDelim, nOccurrence, nFlag)
	
	cExpected = "This is a test."
	RETURN THIS.AssertEquals(cExpected, cResult, "This strings did not match")
	ENDFUNC


	FUNCTION test_Split
	LOCAL cString 
	LOCAL ARRAY aNames[3]
	cString = "Rick, Tamar, Doug"
	cExpected = "Tamar"
	_VFP.String.Split(@aNames, cString,",")
	cActual = aNames[2]
	RETURN This.AssertEquals(cExpected, cActual, "Split did not return what we expected.")


  FUNCTION testContains
	LOCAL cString 
	cString = "Rick, Tamar, Doug"
	lResult = _VFP.String.Contains(cString, "Rick")
	RETURN This.AssertTrue(lResult, "Contains did not return what we expected.")

  FUNCTION testContains_CaseInsensitive
	LOCAL cString 
	cString = "Rick, Tamar, Doug"
	lResult = _VFP.String.Contains(cString, "RICK", StringCompareOptions_CaseInsensitive)
	RETURN This.AssertTrue(lResult, "Contains did not return what we expected.")

  FUNCTION testContains_Exact
	LOCAL cString 
	cString = "Rick, Tamar, Doug"
	lResult = _VFP.String.Contains(cString, " Tamar ", StringCompareOptions_Exact)
	RETURN This.AssertFalse(lResult, "Contains did not return what we expected.")

  FUNCTION testContains_False
	LOCAL cString 
	cString = "Rick, Tamar, Doug"
	lResult = _VFP.String.Contains(cString, "RICK")
	RETURN This.AssertFalse(lResult, "String is there but we didn't specify case insensitive.")

  ENDFUNC


  FUNCTION testCompare
	LOCAL cString, cString2
	cString = "Visual FoxPro 9"
	cString2 = "Visual FoxPro 9.1"
	iResult = _VFP.String.Compare(cString, cString2)
	RETURN This.AssertEquals(-1, iResult, cString + " is showing as greater than " + cString2)

  ENDFUNC

  FUNCTION testCompareEquals_CaseInsensitive
	LOCAL cString, cString2
	cString = "ABCDEFG"
	cString2 = "abcdefg"
	iResult = _VFP.String.Compare(cString, cString2, StringCompareOptions_CaseInsensitive)
	RETURN This.AssertEquals(0, iResult, cString + " is showing as greater than " + cString2)

  ENDFUNC

  FUNCTION testCompareEquals_CaseSensitive
	LOCAL cString, cString2
	cString = "ABCDEFG"
	cString2 = "abcdefg"
	iResult = _VFP.String.Compare(cString, cString2)
	RETURN This.AssertEquals(-1, iResult, cString + " is showing as greater than " + cString2)

  ENDFUNC

  FUNCTION testCompareBackwards
	LOCAL cString, cString2
	cString = "Visual FoxPro 9.1"
	cString2 = "Visual FoxPro 9"
	iResult = _VFP.String.Compare(cString, cString2)
	RETURN This.AssertEquals(1, iResult, cString + " is showing as less than " + cString2)
  ENDFUNC

  FUNCTION testCompare_Exact
	LOCAL cString, cString2
	cString = "Visual FoxPro 9"
	cString2 = "Visual FoxPro 9.1"
	iResult = _VFP.String.Compare(cString, cString2, StringCompareOptions_Exact)
	RETURN This.AssertEquals(-1, iResult, cString + " is showing as greater than " + cString2)
  ENDFUNC

  FUNCTION testCompareBackwards_Exact
	LOCAL cString, cString2
	cString = "Visual FoxPro 9.1"
	cString2 = "Visual FoxPro 9"
	iResult = _VFP.String.Compare(cString, cString2, StringCompareOptions_Exact)
	RETURN This.AssertEquals(1, iResult, cString + " is showing as less than " + cString2)
  ENDFUNC

  FUNCTION testIsNullOrEmpty
	LOCAL cString 
	cString = "Not an empty string."
	lResult = _VFP.String.IsNullOrEmpty(cString)
	RETURN This.AssertFalse(lResult, "Non-Empty String is showing as empty or null.")

  FUNCTION testIsNullOrEmpty_onNull
	LOCAL cString 
	cString = .null.
	lResult = _VFP.String.IsNullOrEmpty(cString)
	RETURN This.AssertTrue(lResult, "Null String is not showing as empty or null.")

  FUNCTION testIsNullOrEmpty_onEmpty
	LOCAL cString 
	cString = ""
	lResult = _VFP.String.IsNullOrEmpty(cString)
	RETURN This.AssertTrue(lResult, "Empty String is not showing as empty or null.")

  ENDFUNC


ENDDEFINE
