DEFINE CLASS StaticVariable AS Custom 

	FUNCTION toString
	LPARAMETERS xValue
	LOCAL cVarType, cString
	cVarType = VARTYPE(xValue)
	DO CASE
		CASE INLIST(cVarType, 'C', 'M')
			cString = xValue
		CASE INLIST(cVarType, 'I', 'N', 'F')		
			cString = STR(xValue)
		CASE INLIST(cVarType, 'T')
			cString = IIF(EMPTY(xValue), "", TTOC(xValue, 1))
		CASE INLIST(cVarType, 'D')
			cString = IIF(EMPTY(xValue), "", DTOC(xValue))
	ENDCASE
	RETURN cString
		
	
	FUNCTION IsNullOrEmpty
	LPARAMETERS xValue
	LOCAL lReturn
	lReturn = ISNULL(xValue)
	IF ! lReturn
		xValue = This.toString(xValue)
		lReturn = EMPTY(xValue)
	ENDIF
	RETURN lReturn
ENDDEFINE
