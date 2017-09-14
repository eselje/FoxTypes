# FoxTypes
Recreating C# static types in Visual FoxPro Code classes

# Usage
Create a static object in the _VFP object called String, which will then be available to format strings anywhere in your app

```foxpro
SET PROCEDURE TO STRING.prg ADDITIVE
ADDPROPERTY(_vfp, "STRING", CREATEOBJECT("String"))

? _VFP.String.Format(_vfp.String.FORMAT("The {0} in {1} falls {2} on the {3}.", "rain", "Spain", "mainly", "plain")
```

	
> The rain in Spain falls mainly on the plain.
> 
	
Parameters can be of any type, reused, and also formatted.

```foxpro
? _vfp.String.Format("Today's date is {0:d} and the time is {0:t}")
```

> Today's date is 09/14/2017 and the time is 16:43:13 PM
> 

Newlines can be added with \n

```foxpro
? _vfp.String.FORMAT("This is line 1.\nThis is line 2")
```

> This is line 1.

> This is line 2


Numbers can be converted to works suitable for check printing

```foxpro
? _vfp.String.Format("Please Pay {0:w} dollars", 123.45)
```


> `	Please Pay One Hundred Twenty Three and 45/100 dollars
> 

# Tests

There are many unit tests in the \tests folder for examples of usage

