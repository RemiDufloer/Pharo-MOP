Class {
	#name : #MetaObjectProtocolTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTest
}

{ #category : #tests }
MetaObjectProtocolTest >> testMOPAddInstrumentation [

	| object result receiver selector arguments op instrumentation expectedArgument astNode requirement compteur |
	object := MOPTestObject new.


	object mop.

	compteur := 0.
	op := BlockOperation block: [ :o | compteur := compteur + 1 ].
	instrumentation := Instrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	requirement := (SelectorNameRequirement name: 'exampleMethod:') or: (NameVariableRequirement name: '#anObject').
	instrumentation requirement: requirement.

	object mop addInstrumentation: instrumentation.

	self assert: object class equals: MOPTestObject.


	result := object exampleMethod: 'expected'.

	self assert: compteur equals: 1
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
