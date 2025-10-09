# Unit Converter in Smalltalk

This is a unit converter program I created in Smalltalk (Pharo).

Currently, this is a work in progress without a UI.  However, you can convert units with the following code:
```
metre := LinearUnit base: 1.
inch := 0.0254 of: metre.
(36 of: inch) to: metre.
```
