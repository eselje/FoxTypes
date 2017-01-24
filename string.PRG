
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
		ENDCASE
		
		RETURN cResult



ENDDEFINE

