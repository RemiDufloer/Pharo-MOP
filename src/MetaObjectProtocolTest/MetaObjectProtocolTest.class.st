Class {
	#name : #MetaObjectProtocolTest,
	#superclass : #TestCase,
	#category : #MetaObjectProtocolTest
}

{ #category : #running }
MetaObjectProtocolTest >> tearDown [

	[ MetaLink uninstallAll ] on: Error do: [ :e | 
		e crTrace 
	]
]

{ #category : #tests }
MetaObjectProtocolTest >> testBeforeMessageSend [

	| object receiver selector arguments expectedArgument |
	object := MOPTestObject new.
	object mop beforeMessageSend: #exampleMethod: do: [ :op |
		receiver := op receiver.
		selector := op method selector.
		arguments := op arguments ].

	expectedArgument := Object new.
	object exampleMethod: expectedArgument.

	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.

	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MetaObjectProtocolTest >> testMetaObjectInstrumentation [

	| metaObject instrumentation op1 op2 operations object receiver selector astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MetaObject new.
	expectedArgument := Object new.
	operations := LinkedList new.
	astNode := (object class methodNamed: #exampleMethod:) ast.
	op1 := Operation operation: [ :op | receiver := op receiver ].
	op2 := Operation operation: [ :op | selector := op method selector ].
	
	operations add: op2; add: op1.
	instrumentation := Instrumentation new operations: operations .
	metaObject addInstrumentation: instrumentation  on: astNode .
	object exampleMethod: expectedArgument.	
	
	self assert: receiver equals: object.
	self assert: selector equals: #exampleMethod:.
		                   

	
]

{ #category : #tests }
MetaObjectProtocolTest >> testMetaObjectInstrumentationInGoodOrder [

	| metaObject instrumentation op1 op2 operations object compteur astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MetaObject new.
	expectedArgument := Object new.
	compteur := 0.
	op1 := Operation operation: [ :op | compteur := 1 ].
	op2 := Operation operation: [ :op | compteur := 2 ].
	operations := LinkedList new.
	
	operations add: op2; add: op1.
	instrumentation := Instrumentation new operations: operations .
	astNode := (object class methodNamed: #exampleMethod:) ast.
	metaObject addInstrumentation: instrumentation  on: astNode .
	object exampleMethod: expectedArgument.	
	
	self assert: compteur equals: 1.

		                   

	
]

{ #category : #tests }
MetaObjectProtocolTest >> testProxyCreation [

	| object proxy result expectedArgument |
	object := Object new.
	proxy := MOPProxy new
		         object: object metaObject: MOPTestObject new;
		         yourself.
	expectedArgument := 'expected'.

	result := object exampleMethod: expectedArgument.

	self assert: result equals: expectedArgument
]
