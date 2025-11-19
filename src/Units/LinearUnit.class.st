"
A unit equal to a constant multiple of its base.
"
Class {
	#name : 'LinearUnit',
	#superclass : 'Object',
	#instVars : [
		'magnitude',
		'dimension'
	],
	#category : 'Units',
	#package : 'Units'
}

{ #category : 'generate' }
LinearUnit class >> base: dimension [
	"Creates a base unit."

	| dimarray |
	dimarray := Array new: 9.
	1 to: 9 do: [ :x | dimarray at: x put: 0 ].
	dimarray at: dimension put: 1.
	^ self new dimension: dimarray; magnitude: 1.0.
]

{ #category : 'generate' }
LinearUnit class >> one [
	"Returns the LinearUnit with a value of one."

	| dimarray |
	dimarray := Array new: 9.
	1 to: 9 do: [ :x | dimarray at: x put: 0 ].
	^ self new dimension: dimarray; magnitude: 1.0.
]

{ #category : 'math functions' }
LinearUnit >> * multiplicand [
	"Multiplies this unit by its argument."
	
	| newDimension newMagnitude |
	newDimension := self dimension + multiplicand dimension.
	newMagnitude := self magnitude * multiplicand magnitude.
	^ newDimension = self class one dimension ifTrue: newMagnitude ifFalse: 
	  ((self class new) dimension: newDimension; magnitude: newMagnitude).
]

{ #category : 'math functions' }
LinearUnit >> / dividend [
	"Divides this unit by its argument."
	
	| newDimension newMagnitude |
	newDimension := self dimension - dividend dimension.
	newMagnitude := self magnitude / dividend magnitude.
	^ newDimension = self class one dimension ifTrue: newMagnitude ifFalse: 
	  ((self class new) dimension: newDimension; magnitude: newMagnitude).
]

{ #category : 'arithmetic' }
LinearUnit >> adaptToNumber: num andSend: op [
	"Performs an operation with a number."

	^ num asUnit perform: op with: self.
]

{ #category : 'converting' }
LinearUnit >> asString [
	"Returns a string representation of this unit."

	| dimnames direxps dimstring |
	dimnames := #('s' 'm' 'kg' 'rad' 'K' 'A' 'mol' 'cd' 'b').
	direxps := (1 to: 9) select: [ :i | (self dimension at: i) ~= 0 ].
	dimstring := ' ' join: (direxps collect: [ :i || exponent |
		exponent := self dimension at: i.
		exponent = 1
			ifTrue: (dimnames at: i)
			ifFalse: (dimnames at: i),'^',exponent asString.
	]).
	^ self magnitude asString,' ',dimstring.
]

{ #category : 'converting' }
LinearUnit >> asUnit [
	"Returns this unit as a unit."
	"No-op, but other types support this message, so it's intended to be used on objects of potentially unknown type, to always return a unit."

	^ self.
]

{ #category : 'math functions' }
LinearUnit >> cubed [
	"Returns the cube of this unit."

	^ self raisedTo: 3.
]

{ #category : 'accessing' }
LinearUnit >> dimension [
	"Get the unit's dimension"
	^ dimension
]

{ #category : 'accessing' }
LinearUnit >> dimension: d [
	"Sets the unit's dimension."
	| |
	dimension := d.
]

{ #category : 'accessing' }
LinearUnit >> magnitude [
	"Get the unit's magnitude."
	^ magnitude
]

{ #category : 'accessing' }
LinearUnit >> magnitude: m [
	"Sets the unit's magnitude."
	| |
	magnitude := m.
]

{ #category : 'printing' }
LinearUnit >> printOn: stream [
	"Prints the LinearUnit onto a stream by putting its string representation onto it."

	stream nextPutAll: self asString.
]

{ #category : 'math functions' }
LinearUnit >> raisedTo: n [
	"Raises this unit to the power n (must be a number)."

	^ (self class new) dimension: self dimension * n;
	                   magnitude: (self magnitude raisedTo: n).
	
]

{ #category : 'math functions' }
LinearUnit >> reciprocal [ 
	"Returns this unit's reciprocal."

	^ self raisedTo: -1.
]

{ #category : 'math functions' }
LinearUnit >> squared [
	"Returns the square of this unit."

	^ self raisedTo: 2.
]

{ #category : 'accessing' }
LinearUnit >> to: unit [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	|  |
	dimension = unit dimension ifFalse: [IncompatibleDimensionsError new signal].
	^ magnitude / unit magnitude.
]
