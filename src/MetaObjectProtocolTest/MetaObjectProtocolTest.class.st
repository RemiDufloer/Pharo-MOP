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
MetaObjectProtocolTest >> testInstallMetaLink [

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
MetaObjectProtocolTest >> testInstrumentationWithInstallationRequirementComposite [

	| metaObject instrumentation op1 object receiver requirement astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MetaObject new.
	expectedArgument := Object new.
	requirement := (SelectorNameRequirement name: 'exampleMethod:') and: ((ArgumentsSizeRequirement size: 2) or: NoRequirement new ) .

	astNode := (object class methodNamed: #exampleMethod:) ast.
	op1 := BlockOperation  block: [ :op | receiver := op receiver ].

	
	instrumentation := Instrumentation new addOperation: op1.
	instrumentation requirement: requirement.
	
	metaObject addInstrumentation: instrumentation  on: astNode .
	object exampleMethod: expectedArgument.	
	
	self assert: receiver equals: object.

		                   

	
]

{ #category : #tests }
MetaObjectProtocolTest >> testInstrumentationWithInstallationRequirementCompositeBadRequirement [

	| metaObject instrumentation op1 object receiver requirement astNode expectedArgument |
	object := MOPTestObject new.
	metaObject := MetaObject new.
	expectedArgument := Object new.
	requirement := (SelectorNameRequirement name: 'exampleMethod:') and:
		               (ArgumentsSizeRequirement size: 2).
	

	astNode := (object class methodNamed: #exampleMethod:) ast.
	op1 := BlockOperation block: [ :op | receiver := op receiver ].


	instrumentation := Instrumentation new addOperation: op1.
	instrumentation requirement: requirement.

	metaObject addInstrumentation: instrumentation on: astNode.
	object exampleMethod: expectedArgument.

	self assert: receiver equals: nil
]

{ #category : #tests }
MetaObjectProtocolTest >> testInstrumentationWithOneInstallationRequirement [

	| metaObject instrumentation op1 object receiver requirement astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MetaObject new.
	expectedArgument := Object new.
	requirement := SelectorNameRequirement name: 'exampleMethod:' .

	astNode := (object class methodNamed: #exampleMethod:) ast.
	op1 := BlockOperation  block: [ :op | receiver := op receiver ].

	
	instrumentation := Instrumentation new addOperation: op1.
	instrumentation requirement: requirement.
	
	metaObject addInstrumentation: instrumentation  on: astNode .
	object exampleMethod: expectedArgument.	
	
	self assert: receiver equals: object.

		                   

	
]

{ #category : #tests }
MetaObjectProtocolTest >> testInstrumentationWithOneInstallationRequirementNotGood [

	| metaObject instrumentation op1 object receiver requirement astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MetaObject new.
	expectedArgument := Object new.
	requirement := SelectorNameRequirement name: 'blablatest' .

	astNode := (object class methodNamed: #exampleMethod:) ast.
	op1 := BlockOperation  block: [ :op | receiver := op receiver ].

	
	instrumentation := Instrumentation new addOperation: op1.
	instrumentation requirement: requirement.
	
	metaObject addInstrumentation: instrumentation  on: astNode .
	object exampleMethod: expectedArgument.	
	
	self assert: receiver equals: nil.

		                   

	
]

{ #category : #tests }
MetaObjectProtocolTest >> testMetaObjectInstrumentation [

	| metaObject instrumentation op1 op2 object receiver selector astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MetaObject new.
	expectedArgument := Object new.

	astNode := (object class methodNamed: #exampleMethod:) ast.
	op1 := BlockOperation  block: [ :op | receiver := op receiver ].
	op2 := BlockOperation block: [ :op | selector := op method selector ].
	
	instrumentation := Instrumentation new addOperation: op2 ; addOperation: op1.
	metaObject addInstrumentation: instrumentation  on: astNode .
	object exampleMethod: expectedArgument.	
	
	self assert: receiver equals: object.
	self assert: selector equals: #exampleMethod:.
		                   

	
]

{ #category : #tests }
MetaObjectProtocolTest >> testMetaObjectInstrumentationInGoodOrder [

	| metaObject instrumentation op1 op2 object compteur astNode expectedArgument|
	
	object := MOPTestObject new.
	metaObject := MetaObject new.
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

{ #category : #tests }
MetaObjectProtocolTest >> testProxyCreation [

	| object proxy result expectedArgument |
	object := MOPTestObject new.
	proxy := MOPProxy new
		         object: object metaObject: MetaObject new;
		         yourself.
	expectedArgument := 'expected'.

	result := object exampleMethod: expectedArgument.

	self assert: result equals: expectedArgument
]

{ #category : #tests }
MetaObjectProtocolTest >> testRequirementCheckNameMethod [

	| requirement node result name |
	name := 'testMethod'.
	node := RBMethodNode selector: name.
	requirement := SelectorNameRequirement name: name .
	

	result := requirement verify: node.

	self assert: result
]

{ #category : #tests }
MetaObjectProtocolTest >> testRequirementCheckNameVariable [

	| requirement node result name |
	name := 'testVariable'.
	node := RBVariableNode named: name.
	requirement := NameVariableRequirement name: name.
	

	result := requirement verify: node.

	self assert: result
]
