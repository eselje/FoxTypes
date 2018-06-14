#DEFINE STARTOFTIME {^1970-1-1 00:00:00}

DEFINE CLASS DateTime AS StaticVariable OF Static.prg

PROTECTED oString 
Value = { :}
Date = { }
Day = 0
DayOfWeek = 0
DayOfYear = 0
Hour = 0
Kind = ""
Millisecond = 0
Minute = 0
Month = 0
Second = 0
Ticks = 0
TimeOfDay = 0
Today = {}
UtcNow = { :}
Year = 0 
cTimeZone = ""
iTimeZoneOffset = .null.
lDaylightSavings = .f.
oString = .null.


PROCEDURE Init
LPARAMETERS nYear, nMonth, nDay, nHour, nMinute, nSecond
* Messing around with allowing you to set a value for this class and then you can manipulate it. 
* Like dtToday = create("DateTime")
* Then you could do stuff like 
*   dtToday.Date = date()
*   ? dtToday.FirstDayOfMonth()
*   ? dtToday.Add(45)
IF PCOUNT() > 0
ENDIF


PROCEDURE Day_Access
RETURN DAY(This.Date)

PROCEDURE DayOfWeek_Access
RETURN DOW(This.Date)

PROCEDURE DayOfYear_Access
PROCEDURE Hour_Access
PROCEDURE Kind_Access
PROCEDURE Millisecond_Access
PROCEDURE Minute_Access
PROCEDURE Month_Access
PROCEDURE Second_Access
PROCEDURE Ticks_Access
PROCEDURE TimeOfDay_Access
PROCEDURE Today_Access

PROCEDURE UtcNow_Access
RETURN this.getUTCTime()

PROCEDURE Year_Access

PROCEDURE Date_Access
RETURN EVL(This.Date, DATE())


PROCEDURE Now
RETURN DATETIME()

FUNCTION Add
LPARAMETERS cTimeSpan
RETURN { :} 

FUNCTION AddDays
LPARAMETERS iDays
RETURN { :} 

FUNCTION AddHours
LPARAMETERS nHours
RETURN { :} 

FUNCTION AddMilliseconds
LPARAMETERS iMilliseconds
RETURN { :} 

FUNCTION AddMinutes
LPARAMETERS iMonths
RETURN { :} 

FUNCTION AddSeconds
LPARAMETERS iSeconds
RETURN { :} 

FUNCTION AddTicks
LPARAMETERS iTicks
RETURN { :} 

FUNCTION AddYears
LPARAMETERS iYears
RETURN { :} 

FUNCTION Compare
LPARAMETERS dt1, dt2
RETURN 0

FUNCTION DaysInMonth
LPARAMETERS iMonth, iYear
LOCAL iYear, iReturn, dDate
dDate = This.Date
iYear = EVL(iYear, YEAR(dDate))
iMonth = EVL(iMonth, MONTH(dDate))

iReturn = This.LastDayOfMonth(iYear, iMonth)-This.FirstDayOfMonth(iYear, iMonth)+1
RETURN iReturn


FUNCTION FirstDayOfMonth(iYear, iMonth)
LOCAL dDate, dReturn
* Thanks Ed Leafe et al
dDate = This.Date
IF PCOUNT()=0
	dReturn = dDate-DAY(dDate)+1
ELSE 
	dReturn = DATE(iYear, iMonth, 1)
ENDIF
RETURN dReturn


FUNCTION LastDayOfMonth(xYear, iMonth)
LOCAL dReturn, dDate
dDate = This.Date
* Thanks Ed Leafe et al
IF PCOUNT()=1
	iMonth = MONTH(dDate)
ENDIF 

DO CASE
	CASE PCOUNT()=0
		dReturn =  GOMONTH(dDate, 1) - day(dDate)
	CASE VARTYPE(xYear)='N'
		dReturn = GOMONTH(DATE(xYear, iMonth,1),+1)-1
	CASE VARTYPE(xYear)$'DT'
		dReturn =  GOMONTH(xYear, 1) - day(xYear)		
ENDCASE
RETURN dReturn


FUNCTION Equals
LPARAMETERS dtValue
RETURN .f.

FUNCTION GetDateTimeFormats
LPARAMETERS aResult, cTypes
cTypes = EVL(cTypes,"dDfFgGmorstTuUy")
DIMENSION aResult[LEN(cTypes),2]
LOCAL i, cType
FOR i = 1 TO LEN(cTypes)
	cType = SUBSTR(cTypes,i,1)
	aResult[i,2]=cType
	aResult[i,1]=This.ToString(cType)
NEXT
RETURN aResult


FUNCTION GetType
RETURN This.Class

FUNCTION IsDaylightSavingTime()
RETURN This.lDaylightSavings


FUNCTION IsLeapYear
LPARAMETERS iYear
* Thanks, wOOdy
iYear = EVL(iYear, YEAR(This.Date))
RETURN NOT EMPTY(DATE(iYear,2,29))


FUNCTION Parse
LPARAMETERS cDateTime
RETURN { :}

FUNCTION Subtract
LPARAMETERS xTime && Either timespan or datetime
LOCAL tResult
tResult = This.Value
DO CASE
	CASE VARTYPE(xTime)='T'
	CASE VARTYPE(xTime)='D'
	CASE VARTYPE(xTime)='I'	&& Minutes? 
		tResult = tResult - xTime
	OTHERWISE && Parse TimeSpan
ENDCASE 
	
RETURN tResult


FUNCTION ToLocalTime
LPARAMETERS iUTCOffset
LOCAL ltTime
iUTCOffset=EVL(iUTCOffset,0)
*  Returns local time from UTC Time
IF iUTCOffset=0
	tReturn = This.FromUtcTime(This.Value)
ELSE
 	tReturn = This.Subtract((This.iTimeZoneOffset-iUTFOffset)*60)
ENDIF 
RETURN tReturn
ENDFUNC


FUNCTION ToLongDateString
RETURN This.ToString('D')

FUNCTION ToLongTimeString
RETURN This.ToString('T')

FUNCTION ToShortDateString
RETURN This.ToString('d')

FUNCTION ToShortTimeString
RETURN This.ToString('t')

FUNCTION ToString
LPARAMETERS cFormat
cFormat=EVL(cFormat,'G')
LOCAL cString
cString = This.oString.Format("{0:"+cFormat+"}", This.Value)
RETURN cString

FUNCTION ToUniversalTime
RETURN { :}

FUNCTION TryParse
LPARAMETERS cString
RETURN .f.


FUNCTION TryParseExact
LPARAMETERS cString
RETURN .f.



************************************************************************
*  GetUtcTime
****************************************
***  Function: Returns UTC time from local time
***    Assume:
***      Pass:
***    Return:
************************************************************************
FUNCTION GetUtcTime(ltTime)
ltTime = EVL(ltTime, EVL(This.Value, DATETIME()))
*** Adjust the timezone offset
RETURN ltTime + (This.iTimeZoneOffset * 60)    
ENDFUNC
*   GetUtcTime

FUNCTION FromUtcTime(ltTime)
*  Returns local time from UTC Time
ltTime = EVL(ltTime, This.Value)
RETURN ltTime - (This.iTimeZoneOffset * 60)
ENDFUNC
 

FUNCTION iTimeZoneOffset_Access
** Returns the TimeZone offset from GMT including daylight savings. Result is returned in minutes.
*** Cache the timezone so this is fast
IF ISNULL(This.iTimeZoneOffset)
	LOCAL lcTZ, lnOffset
	DECLARE integer GetTimeZoneInformation IN Win32API ;
	   STRING @ TimeZoneStruct
	   
	lcTZ = SPACE(256)
	This.lDaylightSavings = (GetTimeZoneInformation(@lcTZ)=2)
	
	lnOffset = This.CharToBin(SUBSTR(lcTZ,1,4),.T.)
	This.cTimeZone = SUBSTR(STRCONV(lcTZ, 6),IIF(This.lDaylightSavings,45,3),33)

	*** Subtract an hour if daylight savings is active
	IF This.lDaylightSavings
	   lnOffset = lnOffset - 60
	
	ENDIF
	This.iTimeZoneOffset = lnOffset  
ENDIF
RETURN This.iTimeZoneOffset 


PROTECTED FUNCTION CharToBin(lcBinString,llSigned)
****************************************
***  Function: Binary Numeric conversion routine. 
***            Converts DWORD or Unsigned Integer string
***            to Fox numeric integer value.
***      Pass: lcBinString -  String that contains the binary data 
***            llSigned    -  if .T. uses signed conversion
***                           otherwise value is unsigned (DWORD)
***    Return: Fox number
************************************************************************
LOCAL m.i, lnWord
lnWord = 0
FOR m.i = 1 TO LEN(lcBinString)
	lnWord = lnWord + (ASC(SUBSTR(lcBinString, m.i, 1)) * (2 ^ (8 * (m.i - 1))))
ENDFOR
IF llSigned AND lnWord > 0x80000000
	lnWord = lnWord - 1 - 0xFFFFFFFF
ENDIF
RETURN lnWord


FUNCTION TimeToUnix
LPARAMETERS tcDateTime
tcDateTime=EVL(tcDateTime, This.Value)
tcDateTime=EVL(tcDateTime, This.Now)
RETURN tcDateTime - STARTOFTIME


FUNCTION UnixToTime
LPARAMETERS tnUnixTime
tnUnixTime = EVL(tnUnixTime,0)
RETURN STARTOFTIME + tnUnixTime

FUNCTION oString_Access
IF ISNULL(This.oString)
	IF ATC("String",SET("PROC"))=0
		SET PROCEDURE TO String ADDITIVE
	ENDIF
	This.oString=CREATEOBJECT("String")
ENDIF 
RETURN this.oString
 
PROTECTED FUNCTION Value_Access
IF EMPTY(This.Value)
	This.Value=DATETIME()
ENDIF
RETURN This.Value

PROTECTED FUNCTION Value_Assign
LPARAMETERS dtValue
LOCAL cType
cType = VARTYPE(dtValue)
IF cType $ 'DT'
	This.Value=dtValue
ENDIF
ENDDEFINE
