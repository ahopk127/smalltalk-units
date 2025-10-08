Class {
	#name : 'ConvertTest',
	#superclass : 'TestCase',
	#category : 'Units-Tests',
	#package : 'Units-Tests'
}

{ #category : 'testing' }
ConvertTest >> testConvert1 [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| metre kilometre actual |
	metre := LinearUnit base: 1.
	kilometre := 1000.0 of: metre.
	actual := (12345.0 of: metre) to: kilometre.
	self assert: 12.345 equals: actual.
]

{ #category : 'testing' }
ConvertTest >> testConvertInvalid [
	"ensure invalid conversions throw exceptions"

	| metre second errorThrown |
	metre := LinearUnit base: 2.
	second := LinearUnit base: 1.
	
	"test if an exception was thrown"
	errorThrown := false.
	[ second to: metre ]
			on: IncompatibleDimensionsError
			do: [ :ex | errorThrown := true ].
	self assert: errorThrown.
]
