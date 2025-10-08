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

{ #category : 'converting' }
LinearUnit >> convertTo: to value: aValue [
	"Convert a value to another unit"

	| |
	dimension = to dimension ifFalse: [IncompatibleDimensionsError new signal].
	^ aValue * magnitude / to magnitude.
]

{ #category : 'accessing' }
LinearUnit >> dimension [
	"Get the unit's dimension"
	^ dimension
]

{ #category : 'accessing' }
LinearUnit >> dimension: d [
	"Set the unit's dimension."

	dimension := d.
]

{ #category : 'accessing' }
LinearUnit >> magnitude [
	"Get the unit's magnitude."
	^ magnitude
]

{ #category : 'accessing' }
LinearUnit >> magnitude: mag [
	"Set the unit's magnitude."

	magnitude := mag.
]
