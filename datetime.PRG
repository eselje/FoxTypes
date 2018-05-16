DEFINE CLASS DateTime AS StaticVariable OF Static.prg

Value = { :}
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
LPARAMETERS cFormat
RETURN ""

FUNCTION GetType
RETURN "T"

FUNCTION IsDaylightSavingTime()
RETURN .F.


FUNCTION IsLeapYear
LPARAMETERS iYear
* Thanks, wOOdy
iYear = EVL(iYear, YEAR(This.Date)
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
