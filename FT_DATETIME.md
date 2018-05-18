# DATETIME (in progress)

Replicates the functionality of C#'s DATETIME Static Class

### Properties
* Date
* Day
* DayOfWeek
* DayOfYear
* Hour
* Kind
* Millisecond
* Minute
* Month
* Second
* Ticks
* TimeOfDay
* Today
* Year

### Local Time Properties
* cTimeZone         *(String of Daylight / Standard Time Zone)*
* iTimeZoneOffset   *(Number of minutes from GMT)*
* lDaylightSavings  *(Currently in daylight savings time mode)*
* UtcNow            *(Current time in UTC)*
* Now               *(Current time in local time)*

*_Access methods exist to return individual properties of the DateTime:*

## Functions on the stored Date value

*  Add(cTimeSpan)
*  AddDays(iDays)
*  AddHours(nHours)
*  AddMilliseconds(iMilliseconds)
*  AddMinutes( iMonths)
*  AddSeconds( iSeconds)
*  AddTicks( iTicks)
*  AddYears( iYears)
*  Compare( dt1, dt2 )
*  Equals( dtValue)
*  Subtract( xTime) && Either timespan or datetime


*  DaysInMonth( iMonth)

*  FromUTCTime(dt) *Returns UTC time from local time*
*  GetUTCTime(dt)  *Returns local time from UTC time*
*  GetDateTimeFormats( cFormat)
*  GetType()

*  IsDaylightSavingTime()   *(Same as lDaylightSavings value)*

*  IsLeapYear( iYear)

*  Parse( cDateTime)
*  TimeToUnix(dt)
*Converts a datetime to # of seconds since 1/1/1970*

*  UnixToTime(unixtime)  
*Converts # of seconds since 1/1/1970 to a FoxPro datetime*



### These will use the FoxTypes STRING class to convert
*  ToLocalTime()
*  ToLongDateString()
*  ToLongTimeString()
*  ToShortDateString()
*  ToShortTimeString()
*  ToString( cFormat, cString)
*  ToUniversalTime()
*  TryParse( cString)
*  TryParseExact( cString)



