Class {
	#name : 'DatabaseTest',
	#superclass : 'TestCase',
	#category : 'Units-Tests',
	#package : 'Units-Tests'
}

{ #category : 'tests' }
DatabaseTest >> testExpression [
	"Tests that unit expression strings can be evaluated."

	| db watt |
	db := UnitDatabase new.
	db units at: 's' put: (LinearUnit base: 1).
	db units at: 'm' put: (LinearUnit base: 2).
	db units at: 'kg' put: (LinearUnit base: 3).
	
	watt := db parseUnitExpression: 'kg m/s^2 m/s'.
	self assert: watt class equals: LinearUnit.
	self assert: watt dimension equals: #(-3 2 1 0 0 0 0 0 0).
	self assert: watt magnitude equals: 1.0.
	
]

{ #category : 'tests' }
DatabaseTest >> testPrefixes [
	"Tests adding prefixes to units."

	| db gigametre |
	db := UnitDatabase new.
	db units at: 'metre' put: (LinearUnit base: 2).
	db prefixes at: 'kilo' put: 1e3.
	db prefixes at: 'mega' put: 1e6.
	
	gigametre := db getUnit: 'kilomegametre'.
	self assert: gigametre class equals: LinearUnit.
	self assert: gigametre dimension equals: #(0 1 0 0 0 0 0 0 0).
	self assert: gigametre magnitude closeTo: 1e9.
	
	
]
