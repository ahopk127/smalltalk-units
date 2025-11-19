Extension { #name : 'Number' }

{ #category : '*Units' }
Number >> asUnit [
	"cReturns this number as a unit."

	^ self of: LinearUnit one.
]

{ #category : '*Units' }
Number >> dimension [
	"Returns this number's dimension as if it were a unit (i.e. an array of zeroes)."

	^ LinearUnit one dimension.
]

{ #category : '*Units' }
Number >> magnitude [
	"Returns this number's magnitude as if it were a unit."

	^ self.
]

{ #category : '*Units' }
Number >> of: unit [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| m2 |
	m2 := unit magnitude * self.
	^ (LinearUnit new) dimension: unit dimension; magnitude: m2.
]

{ #category : '*Units' }
Number >> of: from to: to [
	"Shorthand for (self of: from) to: to.  Converts this amount of from to the unit to."

	^ (self of: from) to: to.
]
