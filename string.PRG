
DEFINE CLASS String AS CUSTOM

	************************************************************
	FUNCTION Format
	************************************************************
	* Mimics the String.Format() Method of NET
	************************************************************
		LPARAMETERS cString, vPara0, vPara1, vPara2, vPara3, vPara4, vPara5, vPara6, vPara7, vPara8, vPara9
		LOCAL nCount, cCount, cReturn, cSearch, cFormat
		cReturn = cString
		FOR nCount = 1 TO OCCURS("{", cString)
			cSearch = STREXTRACT(cString, "{", "}", nCount, 4)
			cFormat = STREXTRACT(cSearch, ":", "}")
			cCount  = CHRTRAN(STRTRAN(cSearch, cFormat,""), "{:}","")
			IF EMPTY(cFormat)
				cReturn = STRTRAN(cReturn, cSearch, TRANSFORM(EVALUATE("vPara"+cCount)) )
			ELSE
				xParam = EVALUATE("vPara"+cCount)
				DO CASE
				CASE INLIST(VARTYPE(xParam),'D','T')
					cReturn = STRTRAN(cReturn, cSearch, This.DateFormat(xParam, cFormat))
				CASE INLIST(VARTYPE(xParam),'N','Y')
					cReturn = STRTRAN(cReturn, cSearch, This.NumericFormat(xParam, cFormat))
				OTHERWISE
					cReturn = STRTRAN(cReturn, cSearch, TRANSFORM(xParam,cFormat) )
				ENDCASE
			ENDIF
		ENDFOR
		cReturn = STRTRAN(cReturn, "\n", CHR(10)+CHR(13))
		RETURN cReturn

	PROTECTED FUNCTION DateFormat
		LPARAMETERS dtConvert, cFormat
		LOCAL cDate, cCentury, dConvert, cResult
		cResult = ""

		*-- [Matt Slay: 2017-01-22]--
		If IsNull(dtConvert)
			Return ""
		Endif

		IF VARTYPE(dtConvert)="D"
			dConvert = dtConvert
			dtConvert = DTOT(dConvert)
		ELSE
			dConvert = TTOD(dtConvert)
		ENDIF
		IF LEN(cFormat)=1
			IF INLIST(cFormat, 'r', 'u', 'U')
			* Adjust time to GMT
				DECLARE INTEGER GetTimeZoneInformation IN kernel32 STRING @lpTimeZoneInformation
				LOCAL cTimeZone, iBiasSeconds
				cTimeZone = REPL(Chr(0), 172)
				GetTimeZoneInformation(@cTimeZone)
				iBiasSeconds = 60 * INT( ASC(SUBSTR(cTimeZone, 1,1)) + ;
				    BitLShift(ASC(SUBSTR(cTimeZone, 2,1)),  8) +;
				    BitLShift(ASC(SUBSTR(cTimeZone, 3,1)), 16) +;
				    BitLShift(ASC(SUBSTR(cTimeZone, 4,1)), 24))
				dtConvert = dtConvert - iBiasSeconds
				dConvert = TTOD(dtConvert)						    
			ENDIF 
			DO CASE
			CASE cFormat='d'	&& Short date 	10/12/2002
				cResult=TRANSFORM(dConvert, "@YS")
			CASE cFormat='D'	&& 	Long date 	December 10, 2002.  Can't use @YL
				cFormat='MMM dd, yyyy'
			CASE cFormat='f'	&& 	Full date & time 	December 10, 2002 10:11 PM
				cFormat='MMMM dd, yyyy hh:mm tt'
			CASE cFormat='F'	&& 	Full date & time (long) 	December 10, 2002 10:11:29 PM
				cFormat='MMMM dd, yyyy hh:mm:ss tt'
			CASE cFormat='g'	&& 	Default date & time 	10/12/2002 10:11 PM
				cFormat='dd/MM/yyyy hh:mm tt'
			CASE cFormat='G'	&& 	Default date & time (long) 	10/12/2002 10:11:29 PM
				cFormat='dd/MM/yyyy hh:mm tt'
			CASE cFormat='M'	&& 	Month day pattern 	December 10
				cFormat='MMMM dd'
			CASE cFormat='r'	&& 	RFC1123 date string 	Tue, 10 Dec 2002 22:11:29 GMT
				cFormat='ddd, dd MMM yyyy hh:mm:ss GMT'
			CASE cFormat='s'	&& 	Sortable date string 	2002-12-10T22:11:29
				cResult = TTOC(dtConvert,3)
			CASE cFormat='t'	&& 	Short time 	10:11 PM
				cFormat='hh:mm tt'
			CASE cFormat='T'	&& 	Long time 	10:11:29 PM
				cFormat='hh:mm:ss tt'
			CASE cFormat='u'	&& 	Universal sortable, local time 	2002-12-10 22:13:50Z
				cFormat='yyyy-MM-dd hh:mm:ddZ'
			CASE cFormat='U'	&& 	Universal sortable, GMT 	December 11, 2002 3:13:50 AM
				cFormat="MMMM dd, yyyy hh:mm:ss tt"
			CASE cFormat='Y'	&& 	Year month pattern 	December, 2002
				cFormat="MMMM, yyyy"
			ENDCASE
		ENDIF
		IF EMPTY(cResult) AND LEN(cFormat)>1
			cResult=This.ParseDateFormat(cFormat, dtConvert)
		ENDIF
		RETURN cResult


	PROTECTED FUNCTION ParseDateFormat
		LPARAMETERS cFormat, dtVar
		cFormat=STRTRAN(cFormat,"hh", PADL(HOUR(dtVar),2,'0'))
		cFormat=STRTRAN(cFormat,"mm", PADL(MINUTE(dtVar),2,'0'))
		cFormat=STRTRAN(cFormat,"ss", PADL(SEC(dtVar),2,'0'))
		cFormat=STRTRAN(cFormat,"MMMM", CMONTH(dtVar))
		cFormat=STRTRAN(cFormat,"MMM", LEFT(CMONTH(dtVar),3))
		cFormat=STRTRAN(cFormat,"MM", PADL(MONTH(dtVar),2,'0'))
		cFormat=STRTRAN(cFormat,"ddd", LEFT(CDOW(dtVar),3))
		cFormat=STRTRAN(cFormat,"dd", PADL(DAY(dtVar),2,'0'))
		cFormat=STRTRAN(cFormat,"yyyy", TRANSFORM(YEAR(dtVar)))
		cFormat=STRTRAN(cFormat,"yy", RIGHT(TRANSFORM(YEAR(dtVar)),2))
		cFormat=STRTRAN(cFormat,"tt", IIF(HOUR(dtVar)<12,"AM","PM"))
		RETURN cFormat

	PROTECTED FUNCTION NumericFormat
		LPARAMETERS nConvert, cFormatCode
		LOCAL cResult, cFormat
		cResult = ""   
		cFormat = UPPER(LEFT(cFormatCode,1))                           
		iWidth = VAL(SUBSTR(cFormatCode,2))
		DO CASE
			CASE cFormat='D'	AND nConvert=INT(nConvert) 	&& Decimal	
				cResult=TRANSFORM(nConvert)
			CASE cFormat='E'	&& Exponential
				cResult=TRANSFORM(nConvert, "@^")
			CASE INLIST(cFormat,'C','F','P')	&& Fixed # of decimal place (default 0)
				IF cFormat='P'
					nConvert = nConvert * 100
				ENDIF 
				cResult=ALLTRIM(TRANSFORM(nConvert, REPLICATE('9',12)+IIF(iWidth<=0,'','.'+REPLICATE('9',iWidth))))
				IF cFormat='C'
					cResult = '$'+cResult
				ELSE
					IF cFormat='P'
						cResult = cResult + '%'
					ENDIF 
				ENDIF
				
			CASE cFormat='G' && General
				cResult=TRANSFORM(nConvert)
			CASE cFormat='N' && Numeric
				cResult=TRANSFORM(nConvert)
			CASE cFormat='P' && Percent
				iWidth = IIF(LEN(cFormat)=1,2,iWidth)	&& Default to 2 decimal places
				cResult= TRANSFORM(nConvert*100) +'%'
			CASE cFormat='R'	&& Round
				cResult=TRANSFORM(nConvert)
			CASE cFormat='X'	&& Hex
				cResult=TRANSFORM(nConvert, "@0")
				
			* ES Convert number to string
			CASE cFormat = 'W' 	&& Words
				cResult = This.NumberToWords(nConvert)
		ENDCASE
		
		RETURN cResult

	PROTECTED FUNCTION NumberToWords
	*********************************************************
	** Author   : Ramani (Subramanian.G)
	**           áFoxAcc Software / Winners Software
	**            www.winnersoft.coolfreepages.com
	** Type    á: Freeware with reservation to Copyrights
	** Warranty : Nothing implied or explicit
	** Last modified : June, 2003
	*********************************************************
	LPARAMETER amt
	amt = ABS(amt)

	IF amt > 999999999999.99 && => 1000 billion
		=MESSAGEBOX("Amount exceeds word convertion provision. Contact system administrator", ;
			0+16, "CAUTION. Check total amount !")
	ENDIF
	IF amt = 0
		RETURN "Zero"
	ENDIF
	LOCAL lcNumPhrase, lcNumStr
	PRIVATE lcWord1, lcWord2, lcWord3, lcWord4, lcWord5, lcWord6, lcWord7, ;
		lcWord8, lcWord9, lcWord10, lcWord11, lcWord12, lcWord13, lcWord14, ;
		lcWord15, lcWord16, lcWord17, lcWord18, lcWord19, lcWord20, lcWord30, ;
		lcWord40, lcWord50, lcWord60, lcWord70, lcWord80, lcWord90
	lcWord1 = "One "
	lcWord2 = "Two "
	lcWord3 = "Three "
	lcWord4 = "Four "
	lcWord5 = "Five "
	lcWord6 = "Six "
	lcWord7 = "Seven "
	lcWord8 = "Eight "
	lcWord9 = "Nine "
	lcWord10 = "Ten "
	lcWord11 = "Eleven "
	lcWord12 = "Twelve "
	lcWord13 = "Thirteen "
	lcWord14 = "Fourteen "
	lcWord15 = "Fifteen "
	lcWord16 = "Sixteen "
	lcWord17 = "Seventeen "
	lcWord18 = "Eighteen "
	lcWord19 = "Ninteen "
	lcWord20 = "Twenty "
	lcWord30 = "Thirty "
	lcWord40 = "Forty "
	lcWord50 = "Fifty "
	lcWord60 = "Sixty "
	lcWord70 = "Seventy "
	lcWord80 = "Eighty "
	lcWord90 = "Ninety "
	m.lcNumPhrase = ""
	m.lcNumStr = STR(amt,17,4)
	IF VAL(SUBSTR(m.lcNumStr,1,3)) > 0    && Amount in Billions
		m.lcNumPhrase = m.lcNumPhrase + THIS.Numword(SUBSTR(m.lcNumStr,1,3)) + " Billion "
	ENDIF
	IF VAL(SUBSTR(m.lcNumStr,4,3)) > 0     && Amount in millions
		m.lcNumPhrase = m.lcNumPhrase + THIS.Numword(SUBSTR(m.lcNumStr,4,3)) + " Million "
	ENDIF
	IF VAL(SUBSTR(m.lcNumStr,7,3)) > 0    && Amount in thousands
		m.lcNumPhrase = m.lcNumPhrase + THIS.Numword(SUBSTR(m.lcNumStr,7,3)) + " Thousand "
	ENDIF
	IF VAL(SUBSTR(m.lcNumStr,10,3)) > 0    && Amount below thousands
		m.lcNumPhrase = m.lcNumPhrase + THIS.Numword(SUBSTR(m.lcNumStr,10,3))
	ENDIF
	IF VAL(SUBSTR(m.lcNumStr,14,2)) > 0    && Amount in Decimals
	** needs tingering depending on digits - Default is 2 decimals
		IF LEN(ALLTRIM(m.lcNumPhrase)) > 1
			m.lcNumPhrase = ALLTRIM(m.lcNumPhrase) + " and "
		ELSE
			m.lcNumPhrase = "Zero and "
		ENDIF
		m.lcNumPhrase = m.lcNumPhrase + SUBSTR(m.lcNumStr,14,2) + "/100"
	ENDIF
	RETURN m.lcNumPhrase

	*********************************************************
	** Called by: numtoword() (function  in NUMWORD.PRG)
	*********************************************************
	PROTECTED FUNCTION Numword
	LPARAMETERS tStr

	LOCAL lnStr, lcPhrase, lcStr
	lcPhrase = " "
	lnStr = VAL(tStr)

	** Hundredth position
	IF lnStr > 99
		lcStr = LEFT(tStr,1)
		lcPhrase = lcWord&lcStr + "Hundred "
	ENDIF

	** Balance Position
	lnStr = VAL(RIGHT(tStr,2))
	IF BETWEEN(lnStr,1,20)
		lcStr = ALLTRIM(STR(lnStr))
		lcPhrase = lcPhrase + lcWord&lcStr
	ENDIF
	IF BETWEEN(lnStr,21,99)
		IF lnStr > 20
			lcStr = SUBSTR(tStr,2,1)+"0"
			lcPhrase = lcPhrase + lcWord&lcStr
		ENDIF
		IF RIGHT(tStr,1) > '0'
			lcStr = RIGHT(tStr,1)
			lcPhrase = lcPhrase + lcWord&lcStr
		ENDIF
	ENDIF
	RETURN ALLTRIM(lcPhrase)
	*********************************************************
	* EOF: NUM2WORD.PRG
	*********************************************************

	FUNCTION toUpper
	LPARAMETERS cString
	RETURN UPPER(cString)
	
ENDDEFINE