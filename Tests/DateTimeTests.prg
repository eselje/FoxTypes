**********************************************************************
DEFINE CLASS DateTimeTests as FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .f.
	LOCAL THIS AS DateTimeTests OF DateTimeTests.PRG
	#ENDIF
	
	ioObjectToBeTested = .NULL.
	icSetClassLib = SPACE(0)
	
	********************************************************************
	FUNCTION Setup
	THIS.icSetClassLib = SET("CLASSLIB")
	SET CLASSLIB TO vfpDateTime.prg ADDITIVE
	THIS.ioObjectToBeTested = CREATEOBJECT("vfpDateTime")
	ADDPROPERTY(_VFP, "DateTime", THIS.ioObjectToBeTested)
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION TearDown
    THIS.ioObjectToBeTested = .NULL.
	LOCAL lcSetClassLib
	lcSetClassLib = THIS.icSetClassLib
	REMOVEPROPERTY(_vfp, "DateTime")
	SET CLASSLIB TO &lcSetClassLib        
	ENDFUNC
	********************************************************************	

	********************************************************************
	FUNCTION testObjectWasCreated
	This.AssertIsObject(This.iObjectToBeTested)
	ENDFUNC
	********************************************************************	

	********************************************************************
	FUNCTION testAddDays
	LOCAL dtResult, dtExpected
	dtResult = _vfp.DateTime.AddDays({^2016/8/1}, 10)
	dtExpected = {^2016/8/11}
	This.AssertTrue(dtExpected, dtResult, "Days did not add up")
	ENDFUNC
	********************************************************************	

**********************************************************************
ENDDEFINE
**********************************************************************
