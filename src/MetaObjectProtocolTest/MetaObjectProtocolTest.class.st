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
		(SelectorNameRequirement name: 'exampleMethod').
	builder andRequirement: (ArgumentsSizeRequirement new size: 1).

	builder := builder newOperation.
	builder newBlockOperation: [ :o | result := result , 'op1' ].

	builder := builder newOperation.
	builder newBlockOperation: [ :o | result := result , 'op2' ].


	object exampleMethod.

	self assert: result equals: 'string :op1op2'
]

{ #category : #tests }
MetaObjectProtocolTest >> testMOPCreation [

	| object  dictionary result |

	object := MOPTestObject new.
	dictionary := IdentityDictionary new.
	dictionary at: object put: 'value'.
	
	object mop.
	
	self assert: object class equals: MOPTestObject.
	self assert: (dictionary at: object) equals: 'value'.
	
	result := object exampleMethod: 'expected'.

	self assert: result equals: 'expected'
]
