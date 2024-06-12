Class {
	#name : 'MetaObjectProtocolTest',
	#superclass : 'MOPTest',
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'tests' }
MetaObjectProtocolTest >> testAnonymousClass [


	| object |
	object := MOPBottom new.
	object mop.
	self assert: object class superclass identicalTo: MOPBottom
	
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testBreakPointHaltOnCall [

	| object |
	object := MOPPersonne new.
	object mop method
		selector: #nom ;
		after: MOPHaltOperation new.

	self should: [ object nom ] raise: Halt
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testBreakPointHaltOnRead [

	| object op protocol |
	object := MOPPersonne new.
	op := MOPHaltOperation new.
	protocol := object mop.
	protocol variable name: 'nom' ;  acces ; instead:  op.

	self should: [ object nom ] raise: Halt
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testBreakPointHaltOnWrite [

	| object |
	object := MOPPersonne new.

	object mop variable
		name: 'nom';
		assigne;
		before: MOPHaltOperation new.

	self should: [ object nom: 'alice'] raise: Halt
	
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testEscapeSelf [

	| object result |
	
	object := MOPBottom new.
	object mop.
	
	result := object escapeWithSelf.
	
	self assert: result hash equals: object hash.
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testEscapeSelfProxy [

	| object result values |
	object := MOPBottom new.
	values := OrderedCollection new.

	object mop variable
		assigne;
		before: (MOPBlockOperation block: [ :o |
					 values add: (o variable read: o object) ]).

	result := object escapeWithSelf.
	result escapeWithSelf.




	self assert: values size equals: 2
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testEscapeWithoutSelf [

	| object result values |
	object := MOPBottom new.
	values := OrderedCollection new.

	object mop variable
		assigne;
		before: (MOPBlockOperation block: [ :o |
					 values add: (o variable read: o object) ]).
	result := object escapeWithoutSelf.
	result escapeWithSelf.



	self assert: values size equals: 2
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testMOPCreateInstrumentation [

	| object result |
	object := MOPTestObject new.
	result := 'string :'.
	object mop method
		selector: #exampleMethod:;
		before: (MOPBlockOperation block: [ :o | result := result , 'op1' ]).


	object exampleMethod: 'test'.

	self assert: result equals: 'string :op1'
]

{ #category : 'tests' }
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

{ #category : 'tests' }
MetaObjectProtocolTest >> testMOPFlatten [

	| object result |
	object := MOPBottom new.
	object mop method
		selector: #exampleMethod:;
		before: (MOPBlockOperation block: [ :o | nil ]).



	result := object mWithSuper.


	self assert: result equals: 0
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testMOPObjectCentric [

	| objectA objectB result |
	objectA := MOPTestObject new.
	objectB := MOPTestObject new.
	result := 'string :'.


	objectA mop method
		selector: #exampleMethod:;
		before: (MOPBlockOperation block: [ :o | result := result , 'op1' ]).

	objectA exampleMethod: 'test'.
	objectB exampleMethod: 'test'.

	self assert: result equals: 'string :op1'
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testMetaLevel [

	| object |
	object := MOPBottom new.


	object mop method before:
		(MOPBlockOperation block: [ :s | object callCompteur ]).

	self assert: object callCompteur equals: 1
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testMethodPharoModels [

	| object result |
	object := MOPPersonne new.

	object mop method
		selector: #nom;
		instead: (MOPBlockOperation block: [ :s | 'alice' ]).

	result := object nom.
	self assert: result equals: 'alice'.
	result := object age.
	self assert: result ~= 'alice'
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testMethodPharoModelsWhithMultipleOperation [

	| object result |
	object := MOPPersonne new.
	result := ''.

	object mop method
		instead:
			(MOPBlockOperation block: [ :s | result := result , 'alice' ]);
		after:
			(MOPBlockOperation block: [ :s | result := result , 'tartenpion' ]).


	object nom.
	self assert: result equals: 'alicetartenpion'
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testTwoInstrumentationOnSameNode [

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
	alice mop variable before: op.
	alice mop variable
		name: 'age';
		acces;
		before: op.


	alice prenom.
	self should: [ alice age ] raise: Exception.

	expectedCollection add: 'alice'.


	self assertCollection: collectionOfValue equals: expectedCollection
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testVariablePharoModels [

	| object result |
	object := MOPPersonne new.
	object mop variable
		name: 'nom';
		acces;
		instead: (MOPBlockOperation block: [ :s | 'alice' ]).
	result := object nom.
	self assert: result equals: 'alice'.
	result := object age.
	self assert: result ~= 'alice'
]

{ #category : 'tests' }
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


	alice mop variable before: op.

	alice age: 42.
	alice prenom.
	alice age.

	expectedCollection
		add: 22;
		add: 'alice';
		add: 42.


	self assertCollection: collectionOfValue equals: expectedCollection
]

{ #category : 'tests' }
MetaObjectProtocolTest >> testcallstack [

	| alice collectionOfValue expectedCollection |
	alice := MOPPersonne new
		         nom: 'Tartenpion';
		         prenom: 'alice';
		         age: 22.
	collectionOfValue := OrderedCollection new.
	expectedCollection := OrderedCollection new.



	alice mop method instead: (MOPBlockOperation block: [ :s |
			 collectionOfValue add: s method selector ]).


	alice age.
	alice age: 42.
	alice prenom.


	expectedCollection
		add: #age;
		add: #age:;
		add: #prenom.


	self assertCollection: collectionOfValue equals: expectedCollection
]
