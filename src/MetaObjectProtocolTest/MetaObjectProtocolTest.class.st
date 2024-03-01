Class {
	#name : #MetaObjectProtocolTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTest
}

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

{ #category : #tests }
MetaObjectProtocolTest >> testMetaObjectInstrumentationInGoodOrder [

	| metaObject instrumentation op1 op2 object compteur astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MOPMetaObject new.
	expectedArgument := Object new.
	compteur := 0.
	op1 := BlockOperation  block: [ :op | compteur := 1 ].
	op2 := BlockOperation block: [ :op | compteur := 2 ].

	
	instrumentation := Instrumentation new addOperation: op2 ; addOperation: op1.
	astNode := (object class methodNamed: #exampleMethod:) ast.
	metaObject addInstrumentation: instrumentation  on: astNode .
	object exampleMethod: expectedArgument.	
	
	self assert: compteur equals: 1.

		                   

	
]
