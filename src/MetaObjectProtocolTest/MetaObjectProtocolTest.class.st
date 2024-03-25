Class {
	#name : #MetaObjectProtocolTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTest
}

{ #category : #tests }
MetaObjectProtocolTest >> testMOPCreateInstrumentation [

	| object protocol builder result |
	object := MOPTestObject new.
	protocol := object mop.
	result := 'string :'.

	builder := protocol newInstrumentation.

	builder := builder newRequirementInstallation.
	builder newRequirement:
		(SelectorNameRequirement name: 'exampleMethod:').
	builder andRequirement: (ArgumentsSizeRequirement new size: 1).

	builder newOperation  newBlockOperation: [ :o | result := result , 'op1' ].

	builder newOperation  newBlockOperation: [ :o | result := result , 'op2' ].
	
	builder push.
	object exampleMethod: 'test'.

	self assert: result equals: 'string :op1op2'
]

{ #category : #tests }
MetaObjectProtocolTest >> testMOPCreation [

	| object  dictionary result defaultClass |

	object := MOPTestObject new.
	dictionary := IdentityDictionary new.
	dictionary at: object put: 'value'.
	
	self assert: object class equals: MOPTestObject.
	
	object mop.
	
	self assert: object class superclass equals: MOPTestObject  .
	self assert: (dictionary at: object) equals: 'value'.
	
	result := object exampleMethod: 'expected'.

	self assert: result equals: 'expected'
]
