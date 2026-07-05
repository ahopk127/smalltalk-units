Class {
	#name : 'BaselineOfUnits',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfUnits',
	#package : 'BaselineOfUnits'
}

{ #category : 'baselines' }
BaselineOfUnits >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'Units';
				package: 'Units-Tests' with: [ spec requires: #('Units') ].
		]
]

{ #category : 'accessing' }
BaselineOfUnits >> projectClass [
	^MetacelloCypressBaselineProject
]
