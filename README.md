# FoxTypes
Recreating C# static types (String, DateTime, Array) in Visual FoxPro Code classes

### Why?
Visual FoxPro originated from dBase, and retained its procedural roots for backward compatibility even while the rest of the world moved to object-oriented syntax. This project aims to collect the myriad procedural functional under static classes. This will give us:
* Consistency (because all commands start with the type, e.g. STRING.IndexOf() rather than AT() )
* Intellisense (because who can remember the name of that function that joins elements of an array into a string?)
* Compatibility (lowering the learning curve for other languages)

### Usage
Instantiate the class once and you're ready to use it. For maximum efficiency, add the instance into the _VFP object, which will make it available anywhere in your app and don't have to worry about it going away with any CLEAR statement.

```foxpro
SET PROCEDURE TO STRING.prg ADDITIVE
ADDPROPERTY(_vfp, "STRING", CREATEOBJECT("String"))
? _VFP.STRING.Format("Hello {0}!", "World")
```

## The FoxTypes
* [STRING](FT_STRING.md)
* [DATETIME](FT_DATETIME.md)
* [ARRAY](FT_ARRAY.md) 

### Tests

There are many unit tests in the \tests folder for examples of usage

