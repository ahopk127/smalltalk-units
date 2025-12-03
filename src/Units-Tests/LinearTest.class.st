Class {
	#name : 'LinearTest',
	#superclass : 'TestCase',
	#category : 'Units-Tests',
	#package : 'Units-Tests'
}

{ #category : 'tests' }
LinearTest >> testDivide [
	"Tests that linear units can be divided."

	| metre second actual |
	second := LinearUnit base: 1.
	metre := LinearUnit base: 2.
	actual := second / metre.
	
	self assert: actual class equals: LinearUnit.
	self assert: actual dimension equals: #(1 -1 0 0 0 0 0 0 0).
	self assert: actual magnitude equals: 1.0.
]

{ #category : 'tests' }
LinearTest >> testMultiOperators [
	"Tests that a more complex operation can be done."

	| s m kg lb ft g ftlbf |
	s := LinearUnit base: 1.
	m := LinearUnit base: 2.
	kg := LinearUnit base: 3.
	
	ft := 0.3048 * m.
	lb := 0.45359237 * kg.
	g := 9.80665 * m / s squared.
	
	ftlbf := ft * lb * g.
	
	self assert: ftlbf magnitude closeTo: 1.35581794833.
	self assert: ftlbf dimension equals: #(-2 2 1 0 0 0 0 0 0).
]

{ #category : 'tests' }
LinearTest >> testMultiply [
	"Tests that linear units can be multiplied."

	| metre second actual |
	second := LinearUnit base: 1.
	metre := LinearUnit base: 2.
	actual := second * metre.
	
	self assert: actual class equals: LinearUnit.
	self assert: actual dimension equals: #(1 1 0 0 0 0 0 0 0).
	self assert: actual magnitude equals: 1.0.
]

{ #category : 'tests' }
LinearTest >> testNumberReturns [
	"Asserts that dividing a unit by itself creates an integer."

	| second result1 result2 result3 |
	second := LinearUnit base: 1.
	result1 := second * second reciprocal.
	result2 := second / second.
	result3 := second raisedTo: 0.
	
	self assert: result1 equals: 1.0.
	self assert: result2 equals: 1.0.
	self assert: result3 equals: 1.0.
]

{ #category : 'tests' }
LinearTest >> testPowers [
	"Tests that units can be properly exponentiated."

	| second result |
	second := LinearUnit base: 1.
	result := second raisedTo: 4.
	
	self assert: result class equals: LinearUnit.
	self assert: result dimension equals: #(4 0 0 0 0 0 0 0 0).
	self assert: result magnitude equals: 1.0.
]
