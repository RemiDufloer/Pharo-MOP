Class {
	#name : #MetaObjectProtocolTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTests
}

{ #category : #tests }
MetaObjectProtocolTest >> testEscapeSelf [

	| object result |
	
	object := MOPBottom new.
	object mop.
	
	result := object escapeWithSelf.
	
	self assert: result hash equals: object hash.
]

{ #category : #tests }
MetaObjectProtocolTest >> testEscapeSelfProxy [

	| object protocol builder result values |
	object := MOPBottom new.
	protocol := object mop.
	values := OrderedCollection new.

	builder := protocol newInstrumentation.
	builder := builder newRequirementInstallation.
	builder newRequirement: MOPAssignementVariableRequirement new.
	builder newOperation newBlockOperationBefore: [ :o |
		values add: (o variable read: o object) ].
	builder push.
	result := object escapeWithSelf.
	result escapeWithSelf.




	self assert: values size equals: 2
]

{ #category : #tests }
MetaObjectProtocolTest >> testEscapeWithoutSelf [

	| object protocol builder result values |
	object := MOPBottom new.
	protocol := object mop.
	values := OrderedCollection new.

	builder := protocol newInstrumentation.
	builder := builder newRequirementInstallation.
	builder newRequirement: (MOPAssignementVariableRequirement new).
	builder newOperation newBlockOperationBefore: [ :o | values add: ( o variable read: o object) ].
	builder push.
	result := object escapeWithoutSelf .
	result escapeWithSelf  .



	self assert: values size equals: 2
]

{ #category : #tests }
MetaObjectProtocolTest >> testMOPCreateInstrumentation [

	| object protocol builder result |
	object := MOPTestObject new.
	protocol := object mop.
	result := 'string :'.

	builder := protocol newInstrumentation.

	builder := builder newRequirementInstallation.
	builder newRequirement:
		(MOPSelectorNameRequirement name: 'exampleMethod:').
	builder andRequirement: (MOPArgumentsSizeRequirement new size: 1).

	builder newOperation  newBlockOperationBefore:  [ :o | result := result , 'op1' ].

	builder newOperation  newBlockOperation: [ :o | result := result , 'op2' ].
	
	builder push.
	object exampleMethod: 'test'.

	self assert: result equals: 'string :op1op2'
]

{ #category : #tests }
MetaObjectProtocolTest >> testMOPCreation [

	| object  dictionary result |

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

{ #category : #tests }
MetaObjectProtocolTest >> testMOPFlatten [

	| object protocol builder result |
	object := MOPBottom new.
	protocol := object mop.

	builder := protocol newInstrumentation.
	builder := builder newRequirementInstallation.
	builder newRequirement: (MOPSelectorNameRequirement name: 'mWithSuper').
	builder newOperation newBlockOperationBefore: [ :o | nil ].
	builder push.
	result := object mWithSuper.


	self assert: result equals: 0
]

{ #category : #tests }
MetaObjectProtocolTest >> testMOPObjectCentric [

	| objectA objectB protocol builder result valueB |
	
	objectA := MOPTestObject new.
	objectB := MOPTestObject new.
	protocol := objectA mop.
	result := 'string :'.

	builder := protocol newInstrumentation.

	builder := builder newRequirementInstallation.
	builder newRequirement:
		(MOPSelectorNameRequirement name: 'exampleMethod:').
	builder andRequirement: (MOPArgumentsSizeRequirement new size: 1).

	builder newOperation newBlockOperationBefore: [ :o |
		result := result , 'op1' ].

	builder newOperation newBlockOperation: [ :o |
		result := result , 'op2' ].

	builder push.

	objectA exampleMethod: 'test'.

	valueB := objectB exampleMethod: 'test'.

	self assert: result equals: 'string :op1op2'.
	self assert: valueB equals: 'test'
]

{ #category : #tests }
MetaObjectProtocolTest >> testTwoInstrumentationOnSameNode [

	| alice collectionOfValue op requirement instrumentation expectedCollection |
	alice := Personne new
		         nom: 'Tartenpion';
		         prenom: 'alice';
		         age: 22.
	collectionOfValue := OrderedCollection new.
	expectedCollection := OrderedCollection new.

	op := MOPBlockOperation block: [ :s |
		      s class == RFSlotWrite
			      ifTrue: [ collectionOfValue add: (s variable read: s object) ]
			      ifFalse: [ collectionOfValue add: s value ] ].
	requirement := MOPVariableReadRequirement new or:
		               MOPAssignementVariableRequirement new.
	instrumentation := MOPInstrumentation new before: op.
	instrumentation requirement: requirement.
	alice mop addInstrumentation: instrumentation.

	requirement := MOPNameVariableRequirement name: 'age'.
	instrumentation := MOPInstrumentation new before: op.
	instrumentation requirement: requirement.
	alice mop addInstrumentation: instrumentation.

	self should: [ alice age: 42 ] raise: Exception.
	alice prenom.
	self should: [ alice age ] raise: Exception.

	expectedCollection add: 'alice'.


	self assertCollection: collectionOfValue equals: expectedCollection
]

{ #category : #tests }
MetaObjectProtocolTest >> testWatchPointBefore [


| alice collectionOfValue op requirement instrumentation expectedCollection |
alice := Personne new nom: 'Tartenpion' ; prenom: 'alice' ; age: 22.
collectionOfValue := OrderedCollection new .
expectedCollection := OrderedCollection new.

op := MOPBlockOperation block: [ :s | (s class == RFSlotWrite ifTrue: [ collectionOfValue add: (s variable read: s object)  ] ifFalse: [collectionOfValue add: s value])  ].
requirement :=  ((MOPVariableReadRequirement new) or: (MOPAssignementVariableRequirement new)).
instrumentation := MOPInstrumentation new before: op.
instrumentation requirement: requirement.
alice mop addInstrumentation: instrumentation.

alice age: 42.
alice prenom .
alice age.

expectedCollection add: 22; add: 'alice'; add: 42.


self assertCollection: collectionOfValue equals: expectedCollection
]

{ #category : #tests }
MetaObjectProtocolTest >> testcallstack [

	| alice collectionOfValue op requirement instrumentation expectedCollection |
	alice := Personne new
		         nom: 'Tartenpion';
		         prenom: 'alice';
		         age: 22.
	collectionOfValue := OrderedCollection new.
	expectedCollection := OrderedCollection new.

	op := MOPBlockOperation block: [ :s | collectionOfValue add: s method selector].
		
	requirement := MOPMethodsRequirement class: alice class.
	instrumentation := MOPInstrumentation new before: op.
	instrumentation requirement: requirement.
	alice mop addInstrumentation: instrumentation.

	alice age.
	alice age: 42.
	alice prenom.
	

	expectedCollection
		add: #age;
		add: #age:;
		add: #prenom.


	self assertCollection: collectionOfValue equals: expectedCollection
]
