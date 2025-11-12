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

{ #category : 'accessing' }
UnitDatabase >> getPrefix: name [
	"Get a prefix, or nil if there is none with this name."

	(NumberParser isNumber: name) ifTrue: [ ^ name asNumber ].
	^ prefixes at: name ifAbsent: nil
]

{ #category : 'transforming' }
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

{ #category : 'accessing' }
UnitDatabase >> units [
	"Returns the units map."
	units ifNil: [ units := Dictionary new ].

	^ units.
]
