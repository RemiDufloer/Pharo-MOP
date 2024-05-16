Class {
	#name : #MOPProtocol,
	#superclass : #Object,
	#instVars : [
		'metaObject'
	],
	#classInstVars : [
		'mopRegistry'
	],
	#category : #'MetaObjectProtocol-base'
}

{ #category : #adding }
MOPProtocol >> addInstrumentation: anInstrumentation [ 

	metaObject addInstrumentation: anInstrumentation 
]

{ #category : #accessing }
MOPProtocol >> metaObject [
	^ metaObject
]

{ #category : #accessing }
MOPProtocol >> metaObject: aMOPMetaObject [

	metaObject := aMOPMetaObject 
]

{ #category : #'instance creation' }
MOPProtocol >> newInstrumentation [
	
	^ MOPInstrumentationBuilder new metaObject: self metaObject; yourself 
]

{ #category : #methods }
MOPProtocol >> onAnyCallDoAfter: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPMethodsRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation after: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #methods }
MOPProtocol >> onAnyCallDoBefore: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPMethodsRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation before: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #methods }
MOPProtocol >> onAnyCallDoInstead: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPMethodsRequirement new.
	instrumentation := self createInstrumentationWithRequirement: requirement .
	instrumentation operation: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarAssigneDoAfter: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPAssignementVariableRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation after: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarAssigneDoBefore: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPAssignementVariableRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation before: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarAssigneDoInstead: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPAssignementVariableRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation operation: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarDoAfter: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPVariableReadRequirement new or:
		               MOPAssignementVariableRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation after: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarDoBefore: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPVariableReadRequirement new or:
		               MOPAssignementVariableRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation before: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarDoInstead: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPVariableReadRequirement new or:
		               MOPAssignementVariableRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation operation: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarReadDoAfter: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPVariableReadRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation after: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarReadDoBefore: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPVariableReadRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation before: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onAnyVarReadDoInstead: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPVariableReadRequirement new.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation operation: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #methods }
MOPProtocol >> onCall: aSelector doAfter: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPSelectorNameRequirement name: aSelector.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation after: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #methods }
MOPProtocol >> onCall: aSelector doBefore: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPSelectorNameRequirement name: aSelector.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation before: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #methods }
MOPProtocol >> onCall: aSelector doInstead: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPSelectorNameRequirement name: aSelector.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation operation: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onVar: aString whenAssigneDoAfter: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPNameAssignementVariableRequirement name: aString.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation after: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onVar: aString whenAssigneDoBefore: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPNameAssignementVariableRequirement name: aString.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation before: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onVar: aString whenAssigneDoInstead: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPNameAssignementVariableRequirement name: aString.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation operation: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onVar: aString whenReadDoAfter: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPNameReadVariableRequirement name: aString.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation after: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onVar: aString whenReadDoBefore: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPNameReadVariableRequirement name: aString.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation before: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #variables }
MOPProtocol >> onVar: aString whenReadDoInstead: aMOPOperation [

	| instrumentation requirement |
	requirement := MOPNameReadVariableRequirement name: aString.
	instrumentation := self createInstrumentationWithRequirement:
		                   requirement.
	instrumentation operation: aMOPOperation.
	instrumentation requirement: requirement.
	self addInstrumentation: instrumentation
]

{ #category : #adding }
MOPProtocol >> understand: aMessage [

	(self class methodDictionary includesKey: aMessage selector)
		ifFalse: [ ^ false ].
	self perform: aMessage selector  withArguments: aMessage arguments .
	^ true
]
