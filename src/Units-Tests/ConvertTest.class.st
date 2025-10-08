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
	metre := LinearUnit new magnitude: 1.0.
	kilometre := LinearUnit new magnitude: 1000.0.
	actual := metre convertTo: kilometre value: 12345.0.
	self assert: 12.345 equals: actual.
]

{ #category : 'testing' }
ConvertTest >> testConvertInvalid [
	"ensure invalid conversions throw exceptions"

	| metre second errorThrown |
	metre := LinearUnit new dimension: { 0 . 1 }; magnitude: 1.0.
	second := LinearUnit new dimension: { 1 . 0 }; magnitude: 1.0.
	
	"test if an exception was thrown"
	errorThrown := false.
	[ metre convertTo: second value: 1.0 ]
			on: IncompatibleDimensionsError
			do: [ :ex | errorThrown := true ].
	self assert: errorThrown.
]
