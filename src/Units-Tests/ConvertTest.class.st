Class {
	#name : 'ConvertTest',
	#superclass : 'TestCase',
	#category : 'Units-Tests',
	#package : 'Units-Tests'
}

{ #category : 'tests' }
ConvertTest >> testConvertAffine [
	"Tests that affine units convert properly."

	| kelvin celsius fahrenheit result |
	kelvin := LinearUnit base: 5.
	celsius := kelvin affine: 273.15.
	fahrenheit := (kelvin / 1.8) affine: 459.67.
	
	result := 50.0 of: fahrenheit to: celsius.
	self assert: 10.0 closeTo: result.
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

{ #category : 'testing' }
ConvertTest >> testConvertLinear [
	"Tests that you can convert units."

	| metre kilometre actual |
	metre := LinearUnit base: 2.
	kilometre := 1000.0 of: metre.
	actual := (12345.0 of: metre) to: kilometre.
	self assert: 12.345 closeTo: actual.
]
