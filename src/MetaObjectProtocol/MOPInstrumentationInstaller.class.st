Class {
	#name : #MOPInstrumentationInstaller,
	#superclass : #Object,
	#instVars : [
		'installedInstrumentation',
		'instrumentedObject',
		'instrumentedClass',
		'metaObject',
		'compiledSelectorsMap'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
MOPInstrumentationInstaller class >> for: aMetaObject [

	^ self new
		  metaObject: aMetaObject;
		  yourself
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> buildSuperSendsChainFrom: method upTo: targetMethod in: methodChain [
	
	| selector nextMethod |
	selector := method selector.
	nextMethod := method.
	[ nextMethod ~~ targetMethod and: [ nextMethod hasSuperSends ] ] 
		whileTrue: [ 
			| nextClass |
			methodChain add: nextMethod.
			nextClass := nextMethod methodClass superclass 
								ifNil: [^ nextMethod ].
			nextMethod := nextClass lookupSelector: selector ].
	^ nextMethod
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> compileSuperSendChain: methodsToInstrument [

	| newSelectors originalSelector lastSelector |
	newSelectors := OrderedCollection new.
	methodsToInstrument isEmpty ifTrue: [ ^ newSelectors ].

	instrumentedClass compile: methodsToInstrument first sourceCode.
	originalSelector := methodsToInstrument first selector.
	newSelectors add: originalSelector.
	methodsToInstrument size = 1 ifTrue: [ ^ newSelectors ].

	lastSelector := originalSelector.

	2 to: methodsToInstrument size do: [ :i | 
		| method newSourceCode newSelector |
		method := methodsToInstrument at: i.

		newSourceCode := String streamContents: [ :s | 
			                 s << '_'.
			                 s << i printString.
			                 s << '_'.
			                 s << method sourceCode ].

		newSelector := instrumentedClass compile: newSourceCode.
		newSelectors add: newSelector.
		self compiledSelectorsMap at: lastSelector put: newSelector.
		lastSelector := newSelector ].
	
^newSelectors
]

{ #category : #accessing }
MOPInstrumentationInstaller >> compiledSelectorsMap [

	^ compiledSelectorsMap ifNil:[compiledSelectorsMap := Dictionary new]
]

{ #category : #MetaLink }
MOPInstrumentationInstaller >> createAnonymousClassFor: anObject [

	anObject class isAnonymous ifTrue: [ ^ nil ].
	anObject class newAnonymousSubclass adoptInstance: anObject
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> findSuperSendsChainFor: aMethod [

	| selector nextMethod methodChain |
	"(self isClassReachableInHierarchy: aMethod methodClass) ifFalse: [
		^ OrderedCollection new ]."
	
	methodChain := OrderedCollection new.
	selector := aMethod selector.
	nextMethod := self originalClass lookupSelector: selector.

	nextMethod := self
		              buildSuperSendsChainFrom: nextMethod
		              upTo: aMethod
		              in: methodChain.
	nextMethod == aMethod ifFalse: [ ^ OrderedCollection new ].
	nextMethod hasSuperSends ifFalse: [
		methodChain add: nextMethod.
		^ methodChain ].

	nextMethod := self
		              buildSuperSendsChainFrom: nextMethod
		              upTo: nil
		              in: methodChain.
	nextMethod ifNotNil: [ methodChain add: nextMethod ].
	^ methodChain
]

{ #category : #initialization }
MOPInstrumentationInstaller >> initialize [ 

	installedInstrumentation := Dictionary new.
]

{ #category : #installeur }
MOPInstrumentationInstaller >> install: aMOPInstrumentation onMethod: aRBMethod [

	| nodeOfMethodNeedToInstall methodNeedToInstall methodsToInstrument compiledSelectors |
	methodsToInstrument := self findSuperSendsChainFor: aRBMethod.
	compiledSelectors := self compileSuperSendChain: methodsToInstrument.

	self compiledSelectorsMap ifNotNil: [ self superSendChainInstall ].



	methodNeedToInstall := self instrumentedClass >> aRBMethod selector.
	nodeOfMethodNeedToInstall := methodNeedToInstall ast allChildren.
	nodeOfMethodNeedToInstall do: [ :n |
		self install: aMOPInstrumentation onNode: n ]
]

{ #category : #installeur }
MOPInstrumentationInstaller >> install: anInstrumentation onNode: aNode [

	| link |
	(anInstrumentation requirement verify: aNode) ifFalse: [ ^ nil ].

	link := MetaLink new.
	link arguments: #( operation ).
	link control: #instead.
	link metaObject: anInstrumentation.
	link selector: #execute:.
	link optionCompileOnLinkInstallation: true.

	(link checkForCompatibilityWith: aNode) ifFalse: [ ^ nil ].

	"if a user has not put enough requirements it is possible that the chosen node does not support the metaLink, if this is the case then it deactivates it"
	[ aNode link: link ]
		on: Exception
		do: [
			link disable.
			^ nil ].
		
	(installedInstrumentation
		 at: anInstrumentation
		 ifAbsentPut: [ OrderedCollection new ]) add: aNode
]

{ #category : #accessing }
MOPInstrumentationInstaller >> installedInstrumentation [

	^ installedInstrumentation
]

{ #category : #accessing }
MOPInstrumentationInstaller >> instrumentedClass [

	^ instrumentedClass
]

{ #category : #accessing }
MOPInstrumentationInstaller >> instrumentedClass: anObject [

	instrumentedClass := anObject
]

{ #category : #accessing }
MOPInstrumentationInstaller >> instrumentedObject [

	^ instrumentedObject
]

{ #category : #accessing }
MOPInstrumentationInstaller >> instrumentedObject: anObject [

	instrumentedObject := anObject
]

{ #category : #testing }
MOPInstrumentationInstaller >> isClassReachableInHierarchy: aClass [

	^ self originalClass == aClass or: [ 
		  self originalClass allSuperclasses includes: aClass ]
]

{ #category : #accessing }
MOPInstrumentationInstaller >> metaObject [

	^ metaObject
]

{ #category : #accessing }
MOPInstrumentationInstaller >> metaObject: aMetaObject [

	metaObject := aMetaObject
]

{ #category : #'api - model' }
MOPInstrumentationInstaller >> object: anObject [ 
	
	instrumentedObject := self createAnonymousClassFor: anObject.
	instrumentedClass := anObject class
	
]

{ #category : #accessing }
MOPInstrumentationInstaller >> originalClass [

	^ instrumentedClass superclass
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> superInstrumentation: selector [

	| op instrumentation requirement |
	op := MOPSuperSendOperation selector: selector.
	instrumentation := MOPInstrumentation new operation: op.
	requirement := MOPSuperSendRequirement new.
	instrumentation requirement: requirement.
	^ instrumentation 
]

{ #category : #installeur }
MOPInstrumentationInstaller >> superSendChainInstall [

	compiledSelectorsMap associationsDo: [ :assoc |
		| key value |
		key := assoc key.
		value := assoc value.
		compiledSelectorsMap removeKey: key.
		self
			install: (self superInstrumentation: value)
			onMethod: instrumentedObject class >> key asSymbol ]
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> uninstall: anInstrumentation [

	(installedInstrumentation at: anInstrumentation) do: [ :n | n links do: [:l | l uninstall]]
]
