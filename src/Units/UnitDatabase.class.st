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

{ #category : 'transforming' }
UnitDatabase >> getUnit: name [
	"Gets a unit from a name, which can contain prefixes."

	self units at: name ifPresent: [ :u | ^u ].
	name size - 1 to: 1 by: -1 do: [ :i || prefixName unit |
		prefixName := name copyFrom: 1 to: i.
		unit := self getUnit: (name copyFrom: i+1 to: name size).
		((self prefixes includesKey: prefixName) and: unit isNotNil)
			ifTrue: [ ^ (self prefixes at: prefixName) of: unit ].
	].

	^ nil.
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
