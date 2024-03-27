Class {
	#name : #MOPInstrumentationTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTests
}

{ #category : #tests }
MOPInstrumentationTest >> testInstall [

	| selector instrumentation receiver arguments op expectedArgument object requirement instrumentationInstalleur |
	object := MOPTestObject new.
	
	op := MOPBlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	
	instrumentation := MOPInstrumentation new addOperation: op.
	expectedArgument := Object new.
	requirement := MOPSelectorNameRequirement name: 'exampleMethod:'.
	instrumentation requirement: requirement.
	instrumentationInstalleur := MOPInstrumentationInstalleur new.
	instrumentationInstalleur object: object .


	instrumentationInstalleur install: instrumentation onMethod: MOPTestObject >> #exampleMethod:.
	object exampleMethod: expectedArgument.


	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.
	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithInstallationRequirementComposite [

	| selector instrumentation receiver arguments op expectedArgument object requirement instrumentationInstalleur |
	object := MOPTestObject new.
	op := MOPBlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := MOPInstrumentation new addOperation: op.
	expectedArgument := Object new.


	requirement := (MOPSelectorNameRequirement name: 'exampleMethod:') and:
		               ((MOPArgumentsSizeRequirement size: 1)) .
	instrumentation requirement: requirement.
	
	instrumentationInstalleur := MOPInstrumentationInstalleur new.
	instrumentationInstalleur object: object .


	instrumentationInstalleur install: instrumentation onMethod: MOPTestObject >> #exampleMethod:.

	object exampleMethod: expectedArgument.

	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.
	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithInstallationRequirementCompositeBadRequirement [

	| selector instrumentation astNode receiver arguments op expectedArgument object requirement instrumentationInstalleur |
	object := MOPTestObject new.
	op := MOPBlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := MOPInstrumentation new addOperation: op.
	expectedArgument := Object new.
	


	requirement := (MOPSelectorNameRequirement name: 'exampleMethod:') and:
		               (MOPArgumentsSizeRequirement size: 2).
	instrumentation requirement: requirement.

	instrumentationInstalleur := MOPInstrumentationInstalleur new.
	instrumentationInstalleur object: object .


	instrumentationInstalleur install: instrumentation onMethod: MOPTestObject >> #exampleMethod:.

	object exampleMethod: expectedArgument.

	self assert: selector equals: nil.
	self assert: receiver equals: nil.
	self assert: arguments equals: nil
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithOneInstallationRequirement [

	| selector instrumentation astNode receiver arguments op expectedArgument object requirement instrumentationInstalleur |
	object := MOPTestObject new.
	op := MOPBlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := MOPInstrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	requirement := (MOPSelectorNameRequirement name: 'exampleMethod:').
	instrumentation requirement: requirement.

	instrumentationInstalleur := MOPInstrumentationInstalleur new.
	instrumentationInstalleur object: object.


	instrumentationInstalleur install: instrumentation onMethod: MOPTestObject >> #exampleMethod:.

	object exampleMethod: expectedArgument.

	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.
	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MOPInstrumentationTest >> testInstrumentationWithOneInstallationRequirementNotGood [

	| selector instrumentation astNode receiver arguments op expectedArgument object requirement instrumentationInstalleur |
	object := MOPTestObject new.
	op := MOPBlockOperation block: [ :o |
		      receiver := o receiver.
		      selector := o method selector.
		      arguments := o arguments ].
	instrumentation := MOPInstrumentation new addOperation: op.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.


	requirement := MOPArgumentsSizeRequirement size: 2.
	instrumentation requirement: requirement.

	instrumentationInstalleur := MOPInstrumentationInstalleur new.
	instrumentationInstalleur object: object .


	instrumentationInstalleur install: instrumentation onMethod: MOPTestObject >> #exampleMethod:.

	object exampleMethod: expectedArgument.

	self assert: selector equals: nil.
	self assert: receiver equals: nil.
	self assert: arguments equals: nil
]

{ #category : #tests }
MOPInstrumentationTest >> testMetaObjectInstrumentationInGoodOrder [

	| instrumentation astNode result expectedArgument object op1 op2 instrumentationInstalleur |
	object := MOPTestObject new.
	result := 'string :'.
	op1 := MOPBlockOperation block: [ :o | result := result , 'op1' ].
	op2 := MOPBlockOperation block: [ :o | result := result , 'op2' ].
	instrumentation := MOPInstrumentation new
		                   addOperation: op1;
		                   addOperation: op2;
		                   yourself.
	expectedArgument := Object new.
	astNode := (MOPTestObject >> #exampleMethod:) ast.

	instrumentationInstalleur := MOPInstrumentationInstalleur new.
	instrumentationInstalleur object: object .

	instrumentationInstalleur install: instrumentation onMethod: MOPTestObject >> #exampleMethod:.

	object exampleMethod: expectedArgument.

	self assert: result equals: 'string :op1op2'
]

{ #category : #tests }
MOPInstrumentationTest >> testUninstall [

	| object op receiver instrumentation instrumentationInstalleur |
	object := MOPTestObject new.
	op := MOPBlockOperation block: [ :o | receiver := o receiver ].
	instrumentation := MOPInstrumentation new addOperation: op.
	instrumentation requirement:
		(MOPSelectorNameRequirement name: 'exampleMethod').

	instrumentationInstalleur := MOPInstrumentationInstalleur new.
	instrumentationInstalleur object: object .
	instrumentation instrumentationInstalleur: instrumentationInstalleur .
	instrumentationInstalleur install: instrumentation onMethod: MOPTestObject >> #exampleMethod.
	object exampleMethod.

	self assert: receiver equals: object.

	receiver := nil.
	instrumentation uninstall.

	object exampleMethod.

	self assert: receiver equals: nil
]
