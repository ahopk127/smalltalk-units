"
A UI for the Units package.
"
Class {
	#name : 'UnitsUI',
	#superclass : 'Object',
	#category : 'Units',
	#package : 'Units'
}

{ #category : 'default' }
UnitsUI class >> convertExpressions [
	"Interactively convert one unit expression to another."

	| db from to result |
	db := UnitDatabase new.
	db evaluateUnitfile: 'unitfile'.
	
	from := UIManager default request: 'Enter unit/expression to convert from:'.
	to := UIManager default request: 'Enter unit/expression to convert to:'.
	result := db convert: from to: to.
	
	UIManager default message: from,' = ',result rounded asInteger asString,' ',to.
]

{ #category : 'default' }
UnitsUI class >> convertUnits [
	"Interactively convert one unit to another."

	| db from to value result |
	db := UnitDatabase new.
	db evaluateUnitfile: 'unitfile'.
	
	from := UIManager default request: 'Enter unit to convert from:'.
	to := UIManager default request: 'Enter unit to convert to:'.
	value := (UIManager default request: 'Enter numeric value to convert:') asNumber.
	result := db convert: value of: from to: to.
	
	UIManager default message: value asString,' ',from,' = ',result rounded asInteger asString,' ',to.
]
