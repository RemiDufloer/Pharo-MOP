Class {
	#name : 'MOPOperationTest',
	#superclass : 'TestCase',
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'tests' }
MOPOperationTest >> testApply [

	| operation value |
	
	operation := MOPBlockOperation block: [ :v | v + 2 ].
	value := 0.

	self assert: (operation apply: value) equals: 2
]
