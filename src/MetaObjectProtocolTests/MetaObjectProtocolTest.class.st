Class {
	#name : #MetaObjectProtocolTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTests
}

{ #category : #tests }
MetaObjectProtocolTest >> testAnonymousClass [


	| object |
	object := MOPBottom new.
	object mop.
	self assert: object class superclass identicalTo: MOPBottom
	
]

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

	| object protocol result values |
	object := MOPBottom new.
	protocol := object mop.
	values := OrderedCollection new.

	object mop.
	object onAnyVarAssigneDoBefore: (MOPBlockOperation block: [ :o |
			 values add: (o variable read: o object) ]).
	result := object escapeWithSelf.
	result escapeWithSelf.




	self assert: values size equals: 2
]

{ #category : #tests }
MetaObjectProtocolTest >> testEscapeWithoutSelf [

	| object result values |
	object := MOPBottom new.
	values := OrderedCollection new.
	object mop.
		object
		onAnyVarAssigneDoBefore: (MOPBlockOperation block: [ :o |
		values add: (o variable read: o object) ]).
	result := object escapeWithoutSelf.
	result escapeWithSelf.



	self assert: values size equals: 2
]

{ #category : #tests }
MetaObjectProtocolTest >> testMOPCreateInstrumentation [

	| object result |
	object := MOPTestObject new.
	result := 'string :'.
	object mop.
	object
		onCall: #exampleMethod:
		doBefore:
		(MOPBlockOperation block: [ :o | result := result , 'op1' ]).

	object exampleMethod: 'test'.

	self assert: result equals: 'string :op1'
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

	| object result |
	object := MOPBottom new.
	object mop.

	object
		onCall: #exampleMethod:
		doBefore:
		(MOPBlockOperation block: [ :o | nil ]).
		
	result := object mWithSuper.


	self assert: result equals: 0
]

{ #category : #tests }
MetaObjectProtocolTest >> testMOPObjectCentric [

	| objectA objectB result |
	objectA := MOPTestObject new.
	objectB := MOPTestObject new.
	result := 'string :'.

	objectA mop.

	objectA
		onCall: #exampleMethod:
		doBefore:
		(MOPBlockOperation block: [ :o | result := result , 'op1' ]).

	objectA exampleMethod: 'test'.
	objectB exampleMethod: 'test'.

	self assert: result equals: 'string :op1'
]

{ #category : #tests }
MetaObjectProtocolTest >> testMetaLevel [

	| object op |
	object := MOPBottom new.

	op := MOPBlockOperation block: [ :s | object callCompteur ].

	object mop.
	object onAnyCallDoBefore: op.

	self assert: object callCompteur equals: 1
]

{ #category : #tests }
MetaObjectProtocolTest >> testMethodPharoModels [

	| object op result |
	object := MOPPersonne new.
	op := MOPBlockOperation block: [ :s | 'alice' ].
	object mop.
	object onCall: #nom doInstead: op.
	result := object nom.
	self assert: result equals: 'alice'.
	result := object age.
	self assert: result ~= 'alice'
]

{ #category : #tests }
MetaObjectProtocolTest >> testMethodPharoModelsWhithMultipleOperation [

	| object op1 op2 result |
	object := MOPPersonne new.
	result := ''.
	object mop.
	op1 := MOPBlockOperation block: [ :s | result := result , 'alice' ].
	op2 := MOPBlockOperation block: [ :s |
		       result := result , 'tartenpion' ].
	object onAnyCallDoInstead: op1.
	object onAnyCallDoAfter: op2.
	object nom.
	self assert: result equals: 'alicetartenpion'
]

{ #category : #tests }
MetaObjectProtocolTest >> testTwoInstrumentationOnSameNode [

	| alice collectionOfValue op expectedCollection |
	alice := MOPPersonne new
		         nom: 'Tartenpion';
		         prenom: 'alice';
		         age: 22.
	collectionOfValue := OrderedCollection new.
	expectedCollection := OrderedCollection new.
	alice mop.

	op := MOPBlockOperation block: [ :s |
		      s class == RFSlotWrite
			      ifTrue: [ collectionOfValue add: (s variable read: s object) ]
			      ifFalse: [ collectionOfValue add: s value ] ].
	alice onAnyVarDoBefore: op.
	alice onVar: 'age' whenReadDoBefore: op.

	alice prenom.
	self should: [ alice age ] raise: Exception.

	expectedCollection add: 'alice'.


	self assertCollection: collectionOfValue equals: expectedCollection
]

{ #category : #tests }
MetaObjectProtocolTest >> testVariablePharoModels [

	| object op result |
	object := MOPPersonne new.
	op := MOPBlockOperation block: [ :s | 'alice' ].
	object mop.
	object onVar: 'nom' whenReadDoInstead: op.
	result := object nom.
	self assert: result equals: 'alice'.
	result := object age.
	self assert: result ~= 'alice' 
]

{ #category : #tests }
MetaObjectProtocolTest >> testWatchPointBefore [

	| alice collectionOfValue op expectedCollection |
	alice := MOPPersonne new
		         nom: 'Tartenpion';
		         prenom: 'alice';
		         age: 22.
	collectionOfValue := OrderedCollection new.
	expectedCollection := OrderedCollection new.
	op := MOPBlockOperation block: [ :s |
		      s class == RFSlotWrite
			      ifTrue: [ collectionOfValue add: (s variable read: s object) ]
			      ifFalse: [ collectionOfValue add: s value ] ].


	alice mop.
	alice onAnyVarDoBefore: op.


	alice age: 42.
	alice prenom.
	alice age.

	expectedCollection
		add: 22;
		add: 'alice';
		add: 42.


	self assertCollection: collectionOfValue equals: expectedCollection
]

{ #category : #tests }
MetaObjectProtocolTest >> testcallstack [

	| alice collectionOfValue op expectedCollection |
	alice := MOPPersonne new
		         nom: 'Tartenpion';
		         prenom: 'alice';
		         age: 22.
	collectionOfValue := OrderedCollection new.
	expectedCollection := OrderedCollection new.

	op := MOPBlockOperation block: [ :s |
		      collectionOfValue add: s method selector ].

	alice mop.
	alice onAnyCallDoInstead: op.

	alice age.
	alice age: 42.
	alice prenom.


	expectedCollection
		add: #age;
		add: #age:;
		add: #prenom.


	self assertCollection: collectionOfValue equals: expectedCollection
]
