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
	
	UIManager default message: from,' = ',result asInteger asString,' ',to.
]
