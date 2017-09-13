* Old school unit testing
CLEAR

SET PROCEDURE TO o:\dev\fox\foxtypes\STRING.prg ADDITIVE
ADDPROPERTY(_vfp, "STRING", CREATEOBJECT("String"))

 *? _vfp.String.FORMAT("Welcome to Southwest Fox {0}.", 2016)

 *? _vfp.String.FORMAT("We have nothing to {0} but {0} itself.", "fear")
 *? _vfp.String.FORMAT("The {0} in {1} falls {2} on the {3}.", "rain", "Spain", "mainly", "plain")
 *? _vfp.String.FORMAT("What does {0} equal?", .null.)

* DateTimes
* Pre-formatted
* ? _vfp.String.FORMAT("It is currently {0:s}.", DATETIME())

*'d'	&& Short date 	10/12/2002
*'D'	&& 	Long date 	December 10, 2002.  Can't use @YL
*'f'	&& 	Full date & time 	December 10, 2002 10:11 PM
*'F'	&& 	Full date & time (long) 	December 10, 2002 10:11:29 PM
*'g'	&& 	Default date & time 	10/12/2002 10:11 PM
*'G'	&& 	Default date & time (long) 	10/12/2002 10:11:29 PM
*'M'	&& 	Month day pattern 	December 10
*'r'	&& 	RFC1123 date string 	Tue, 10 Dec 2002 22:11:29 GMT
*'s'	&& 	Sortable date string 	2002-12-10T22:11:29
*'t'	&& 	Short time 	10:11 PM
*'T'	&& 	Long time 	10:11:29 PM
*'u'	&& 	Universal sortable, local time 	2002-12-10 22:13:50Z
*'U'	&& 	Universal sortable, GMT 	December 11, 2002 3:13:50 AM
*'Y'	&& 	Year month pattern 	December, 2002

* Custom
? _vfp.String.FORMAT("It is currently {0:MMMM dd, yy hh:mm:ss tt}.", DATETIME())
