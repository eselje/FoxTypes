# STRING

Replicates the functionality of C#'s STRING Static Class

## Functions

### Format()

Format is the most powerful function. It accepts multiple parameters (zero-based).
```foxpro
? _VFP.String.Format(_vfp.String.FORMAT("The {0} in {1} falls {2} on the {3}.", "rain", "Spain", "mainly", "plain")
```
	
> The rain in Spain falls mainly on the plain.
> 
	
Parameters can be of any type, reused, and also formatted using dozens of formatting templates.

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


> Please Pay One Hundred Twenty Three and 45/100 dollars
> 

### Contains

```foxpro
? _vfp.String.Contains("Astros win 2017 World Series!", "World", nComparisonFlags)
```

> .T.

### Compare (Returns which element would go first. -1 for first string, 0 if they're the same, 1 if second string)

```foxpro
? _vfp.String.Compare("Astros", "Dodgers"[, nComparisonFlags])
```

> -1

### Extract (Pull a string from between two delimiters)

```foxpro
? _vfp.String.Extract("<teams><team>Dodgers</team><team>Astros</team></teams>", "<team>", "</team>", 2, nComparisonFlags)
```

> Astros

### IndexOf (Where does a substring appear in a string, if at all?)

```foxpro
? _vfp.String.IndexOf("Now is the time for all good men to come to the aid of their country.", "time"[, nOccurrence, nComparisonFlags])
```

> 8

### LastIndexOf (Where does a substring appear in a string, if at all, starting from the right?)

```foxpro
? _vfp.String.LastIndexOf("Now is the time for all good men to come to the aid of their country.", "time"[, nOccurrence, nComparisonFlags])
```

> 8


### Occurs

```foxpro
? _vfp.String.Occurs("Habush, Habush, and Davis", "Habush"[, nComparisonFlags])
```

> 2

### PadLeft, PadCenter, PadRight


```foxpro
? _vfp.String.PadCenter(" HEADER ", "=", 12)
```

> == HEADER ==

### Replace (Change substring to another string)

```foxpro
? _vfp.String.Replace("Now is the time for all good men to come to the aid of their country.", "men", "people"[, nOccurrence, nNumberOfOccurrences, nFlags])
```

> Now is the time for all good people to come to the aid of their country.


### Split (Divide up a string into an array)

```foxpro
? _vfp.String.Split(aTeams, "Brewers, Cubs, Cardinals, Pirates, Reds"[, ",",  nFlags])
```

> 5
```foxpro
? aTeams[2]
```
> Cubs

### ToUpper, ToLower

```foxpro
? _vfp.String.ToUpper("Visual FoxPro Rocks")
```
>VISUAL FOXPRO ROCKS








