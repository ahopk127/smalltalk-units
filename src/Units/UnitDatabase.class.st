"
A class that stores both prefixes and prefixless units, and can get a unit from a possibly prefixed name.
"
Class {
	#name : 'UnitDatabase',
	#superclass : 'Object',
	#instVars : [
		'units',
		'prefixes'
	],
	#category : 'Units',
	#package : 'Units'
}

{ #category : 'parsing' }
UnitDatabase class >> parseUnitfileLine: line [
	"Accepts a unitfile-formatted line and splits it into an array of three parts: name, type, value."

	| firstTab secondTab result |
	firstTab := line indexOfAnyOf: '	'.
	secondTab := line indexOfAnyOf: '	' startingAt: firstTab + 1.
	
	result := Array new: 3.
	result at: 1 put: (line copyFrom: 1 to: firstTab - 1).
	result at: 2 put: (line copyFrom: firstTab + 1 to: secondTab - 1).
	result at: 3 put: (line copyFrom: secondTab + 1 to: line size).
	^ result.
]

{ #category : 'adding' }
UnitDatabase >> at: name putPrefixExpression: expression [
	"Adds a prefix from its expression."

	| parsed |
	parsed := self parsePrefixExpression: expression.
	self units at: name put: parsed.
]

{ #category : 'adding' }
UnitDatabase >> at: name putUnitExpression: expression [
	"Adds a unit from its expression."

	| parsed |
	parsed := self parseUnitExpression: expression.
	self units at: name put: parsed.
]

{ #category : 'converting' }
UnitDatabase >> convert: count of: from to: to [
	"Converts a value from one unit into another.  Does not support expressions."

	^ count of: (self getUnit: from)
	        to: (self getUnit: to).
]

{ #category : 'converting' }
UnitDatabase >> convert: expression to: name [
	"Converts an expression into another."

	| value |
	value := self parseUnitExpression: expression.
	^ value to: (self parseUnitExpression: name).
]

{ #category : 'adding' }
UnitDatabase >> definePrefix: name as: value [
	"Add a new prefix to this database."

	self prefixes at: name put: value.
]

{ #category : 'adding' }
UnitDatabase >> defineUnit: name as: value [
	"Add a new unit to this database."

	self units at: name put: value.
]

{ #category : 'adding' }
UnitDatabase >> evaluateUnitfileLine: line [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| parts name type value |
	parts := self class parseUnitfileLine: line.
	name := parts at: 1.
	type := parts at: 2.
	value := parts at: 3.
	
	type = 'base' ifTrue: [ self units at: name put: (LinearUnit base: value asInteger) ].
	type = 'alias' ifTrue: [ self units at: name put: (self getUnit: value) ].
	type = 'linear' ifTrue: [ self at: name putUnitExpression: value ].
	type = 'prefix' ifTrue: [ self at: name putPrefixExpression: value ].
]

{ #category : 'accessing' }
UnitDatabase >> getPrefix: name [
	"Get a prefix, or nil if there is none with this name."

	(NumberParser isNumber: name) ifTrue: [ ^ name asNumber ].
	^ prefixes at: name ifAbsent: nil
]

{ #category : 'accessing' }
UnitDatabase >> getUnit: name [
	"Gets a unit from a name, which can contain prefixes."
	
	(NumberParser isNumber: name) ifTrue: [ ^ name asNumber ].

	self units at: name ifPresent: [ :u | ^u ].
	name size - 1 to: 1 by: -1 do: [ :i || prefixName unit |
		prefixName := name copyFrom: 1 to: i.
		unit := self getUnit: (name copyFrom: i+1 to: name size).
		((self prefixes includesKey: prefixName) and: unit isNotNil)
			ifTrue: [ ^ (self prefixes at: prefixName) of: unit ].
	].

	^ nil.
]

{ #category : 'parsing' }
UnitDatabase >> parsePrefixExponent: string [
	"Like getUnit:, but if the expression is of the form a^b, returns (getUnit: a) pow: b."

	| substrings |
	substrings := string findTokens: '^'.
	substrings size = 1
		ifTrue: [ ^ self getPrefix: string ].
	substrings size = 2
		ifTrue: [ ^ (self getPrefix: substrings first) raisedTo: substrings last asInteger ]
		ifFalse: [ ^ nil ].
]

{ #category : 'parsing' }
UnitDatabase >> parsePrefixExpression: string [
	"Parses a prefix expression and returns the prefix."

	| substrings multiplicands |
	substrings := string findTokens: ' *'.
	multiplicands := substrings collect: [ :each | self parsePrefixFraction: each ].
	^ multiplicands reduce: [ :a :b | a * b ].
]

{ #category : 'parsing' }
UnitDatabase >> parsePrefixFraction: string [
	"Like getUnit:, but if the expression is of the form a/b, returns (parseExponent: a) / (parseExponent: b)."

	| substrings |
	substrings := string findTokens: '/'.
	substrings size = 1
		ifTrue: [ ^ self parsePrefixExponent: string ].
	substrings size = 2
		ifTrue: [ ^ (self parsePrefixExponent: substrings first) / (self parsePrefixExponent: substrings last) ]
		ifFalse: [ ^ nil ].
]

{ #category : 'parsing' }
UnitDatabase >> parseUnitExponent: string [
	"Like getUnit:, but if the expression is of the form a^b, returns (getUnit: a) pow: b."

	| substrings |
	substrings := string findTokens: '^'.
	substrings size = 1
		ifTrue: [ ^ self getUnit: string ].
	substrings size = 2
		ifTrue: [ ^ (self getUnit: substrings first) raisedTo: substrings last asInteger ]
		ifFalse: [ ^ nil ].
]

{ #category : 'parsing' }
UnitDatabase >> parseUnitExpression: string [
	"Parses a unit expression and returns the unit."

	| substrings multiplicands |
	substrings := string findTokens: ' *'.
	multiplicands := substrings collect: [ :each | self parseUnitFraction: each ].
	^ multiplicands reduce: [ :a :b | a * b ].
]

{ #category : 'parsing' }
UnitDatabase >> parseUnitFraction: string [
	"Like getUnit:, but if the expression is of the form a/b, returns (parseExponent: a) / (parseExponent: b)."

	| substrings |
	substrings := string findTokens: '/'.
	substrings size = 1
		ifTrue: [ ^ self parseUnitExponent: string ].
	substrings size = 2
		ifTrue: [ ^ (self parseUnitExponent: substrings first) / (self parseUnitExponent: substrings last) ]
		ifFalse: [ ^ nil ].
]

{ #category : 'accessing' }
UnitDatabase >> prefixes [
	"Returns the prefixes map."

	prefixes ifNil: [ prefixes := Dictionary new ].
	^ prefixes.
]

{ #category : 'adding' }
UnitDatabase >> putBaseUnits [
	"Puts the default base units into this map."

	self units at: 's' put: (LinearUnit base: 1);
	           at: 'm' put: (LinearUnit base: 2);
	           at: 'kg' put: (LinearUnit base: 3);
	           at: 'g' put: (LinearUnit base: 3) * 1e-3;
	           at: 'rad' put: (LinearUnit base: 4);
	           at: 'K' put: (LinearUnit base: 5);
	           at: 'A' put: (LinearUnit base: 6);
	           at: 'mol' put: (LinearUnit base: 7);
	           at: 'cd' put: (LinearUnit base: 8);
	           at: 'b' put: (LinearUnit base: 9).
	           
]

{ #category : 'accessing' }
UnitDatabase >> units [
	"Returns the units map."
	units ifNil: [ units := Dictionary new ].

	^ units.
]
