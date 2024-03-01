Class {
	#name : #MOPInstrumentationTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTest
}

{ #category : #tests }
MOPInstrumentationTest >> testInstall [

	| selector instrumentation astNode receiver arguments op expectedArgument object |
	object := MOPTestObject new.
	op := BlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := Instrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	instrumentation installOnNode: astNode.
	object exampleMethod: expectedArgument.


	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.
	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithInstallationRequirementComposite [

	| selector instrumentation astNode receiver arguments op expectedArgument object requirement |
	object := MOPTestObject new.
	op := BlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := Instrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	requirement := (SelectorNameRequirement name: 'exampleMethod:') and:
		               ((ArgumentsSizeRequirement size: 1)) .
	instrumentation requirement: requirement.
	
	instrumentation installOnNode: astNode.

	object exampleMethod: expectedArgument.

	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.
	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithInstallationRequirementCompositeBadRequirement [

	| selector instrumentation astNode receiver arguments op expectedArgument object requirement |
	object := MOPTestObject new.
	op := BlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := Instrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	requirement := (SelectorNameRequirement name: 'exampleMethod:') and:
		               (ArgumentsSizeRequirement size: 2).
	instrumentation requirement: requirement.

	instrumentation installOnNode: astNode.

	object exampleMethod: expectedArgument.

	self assert: selector equals: nil.
	self assert: receiver equals: nil.
	self assert: arguments equals: nil
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithOneInstallationRequirement [

	| selector instrumentation astNode receiver arguments op expectedArgument object requirement |
	object := MOPTestObject new.
	op := BlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := Instrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	requirement := (SelectorNameRequirement name: 'exampleMethod:').
	instrumentation requirement: requirement.

	instrumentation installOnNode: astNode.

	object exampleMethod: expectedArgument.

	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.
	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithOneInstallationRequirementNotGood [

	| selector instrumentation astNode receiver arguments op expectedArgument object requirement |
	object := MOPTestObject new.
	op := BlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := Instrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	requirement := ArgumentsSizeRequirement size: 2.
	instrumentation requirement: requirement.

	instrumentation installOnNode: astNode.

	object exampleMethod: expectedArgument.

	self assert: selector equals: nil.
	self assert: receiver equals: nil.
	self assert: arguments equals: nil
]

{ #category : #tests }
MOPInstrumentationTest >> testMetaObjectInstrumentationInGoodOrder [

	| instrumentation astNode result expectedArgument object op1 op2 |
	object := MOPTestObject new.
	result := 'string :'.
	op1 := BlockOperation block: [ :o | result := result , 'op1' ].
	op2 := BlockOperation block: [ :o | result := result , 'op2' ].
	instrumentation := Instrumentation new
		                   addOperation: op1;
		                   addOperation: op2;
		                   yourself.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.

	instrumentation installOnNode: astNode.

	object exampleMethod: expectedArgument.

	self assert: result equals: 'string :op1op2'
]

{ #category : #tests }
MOPInstrumentationTest >> testUninstall [

	self assert: false
]
