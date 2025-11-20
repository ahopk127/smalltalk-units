"
A unit where zero of the base is not equal to zero of this unit, like Celsius or Fahrenheit.
"
Class {
	#name : 'AffineUnit',
	#superclass : 'Object',
	#instVars : [
		'magnitude',
		'dimension',
		'zero'
	],
	#category : 'Units-Units',
	#package : 'Units',
	#tag : 'Units'
}

{ #category : 'converting' }
AffineUnit >> asLinearUnit [
	"Returns the LinearUnit that corresponds to this unit with no zero."
	"e.g. Celsius asLinearUnit = Kelvin."

	| linear |
	linear := LinearUnit new.
	linear dimension: dimension;
	       magnitude: magnitude.
	^ linear.
]

{ #category : 'converting' }
AffineUnit >> convertFromBase: value [
	"Returns what value of this unit's base would be equal to in this unit."

	^ value / magnitude - zero.
]

{ #category : 'converting' }
AffineUnit >> convertToBase: value [
	"Returns value of this unit expressed in its base."

	^ (value + zero) * magnitude.
]

{ #category : 'accessing' }
AffineUnit >> dimension [
	"Returns this unit's dimension."

	^ dimension.
]

{ #category : 'setting' }
AffineUnit >> dimension: newValue [
	"Sets this unit's dimension."

	dimension := newValue.
]

{ #category : 'accessing' }
AffineUnit >> magnitude [
	"Returns this unit's magnitude."

	^ magnitude.
]

{ #category : 'setting' }
AffineUnit >> magnitude: newValue [
	"Sets this unit's magnitude."

	magnitude := newValue.
]

{ #category : 'accessing' }
AffineUnit >> zero [
	"Returns the value of zero of this unit in its linear variant."
	"(e.g. the zero of Celsius is 273.15)"

	^ zero
]

{ #category : 'setting' }
AffineUnit >> zero: newValue [
	"Sets this unit's zero."

	zero := newValue.
]
