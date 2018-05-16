DEFINE CLASS DateTime AS StaticVariable OF Static.prg

Value = DATETIME() 
Date = {}
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


PROCEDURE Init
LPARAMETERS nYear, nMonth, nDay, nHour, nMinute, nSecond
IF PCOUNT() > 0
ENDIF


PROCEDURE Date_Access
PROCEDURE Day_Access
PROCEDURE DayOfWeek_Access
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
PROCEDURE Year_Access


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
LOCAL iYear, iReturn
iYear = EVL(iYear, YEAR(DATE()))
iMonth = EVL(iMonth, MONTH(DATE()))

iReturn = This.LastDayOfMonth(iYear, iMonth)-This.FirstDayOfMonth(iYear, iMonth)+1
RETURN iReturn


FUNCTION FirstDayOfMonth(iYear, iMonth)
LOCAL dDate 
* Thanks Ed Leafe et al
IF PCOUNT()=0
	dDate = DATE()-DAY(DATE())+1
ELSE 
	dDate = DATE(iYear, iMonth, 1)
ENDIF
RETURN dDate


FUNCTION LastDayOfMonth(xYear, iMonth)
LOCAL dReturn
* Thanks Ed Leafe et al
IF PCOUNT()=1
	iMonth = MONTH(DATE())
ENDIF 

DO CASE
	CASE PCOUNT()=0
		dReturn =  GOMONTH(date(), 1) - day(date())
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
LPARAMETERS cFormat
RETURN ""

FUNCTION GetType
RETURN "T"

FUNCTION IsDaylightSavingTime()
RETURN .F.


FUNCTION IsLeapYear
LPARAMETERS iYear
* Thanks, wOOdy
RETURN NOT EMPTY(DATE(iYear,2,29))


FUNCTION Parse
LPARAMETERS cDateTime
RETURN { :}

FUNCTION Subtract
LPARAMETERS xTime && Either timespan or datetime

FUNCTION ToLocalTime
RETURN { :}

FUNCTION ToLongDateString
RETURN ""

FUNCTION ToLongTimeString
RETURN ""

FUNCTION ToShortDateString
RETURN ""

FUNCTION ToShortTimeString
RETURN ""

FUNCTION ToString
LPARAMETERS cFormat, cString
RETURN ""

FUNCTION ToUniversalTime
RETURN { :}

FUNCTION TryParse
LPARAMETERS cString
RETURN .f.


FUNCTION TryParseExact
LPARAMETERS cString
RETURN .f.

 
ENDDEFINE
