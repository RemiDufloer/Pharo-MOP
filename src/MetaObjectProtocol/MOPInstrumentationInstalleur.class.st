Class {
	#name : #MOPInstrumentationInstalleur,
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
MOPInstrumentationInstalleur class >> for: aMetaObject [

	^ self new
		  metaObject: aMetaObject;
		  yourself
]

{ #category : #MetaLink }
MOPInstrumentationInstalleur >> anonymousClassForObject: anObject [

	anObject class isAnonymous ifFalse: [ 
		anObject class newAnonymousSubclass adoptInstance: anObject ].
	^ anObject 

	
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> buildSuperSendsChainFrom: method upTo: targetMethod in: methodChain [
	
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
MOPInstrumentationInstalleur >> compileSuperSendChain: methodsToInstrument [

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
MOPInstrumentationInstalleur >> compiledSelectorsMap [

	^ compiledSelectorsMap ifNil:[compiledSelectorsMap := Dictionary new]
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> findSuperSendsChainFor: aMethod [

	| selector nextMethod methodChain |
	(self isClassReachableInHierarchy: aMethod methodClass) ifFalse: [ 
		^ OrderedCollection new ].

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
MOPInstrumentationInstalleur >> initialize [ 

	installedInstrumentation := Dictionary new.
]

{ #category : #installeur }
MOPInstrumentationInstalleur >> install: aMOPInstrumentation onMethod: aRBMethod [

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
MOPInstrumentationInstalleur >> install: anInstrumentation onNode: aNode [

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
MOPInstrumentationInstalleur >> installedInstrumentation [

	^ installedInstrumentation
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> instrumentedClass [

	^ instrumentedClass
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> instrumentedClass: anObject [

	instrumentedClass := anObject
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> instrumentedObject [

	^ instrumentedObject
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> instrumentedObject: anObject [

	instrumentedObject := anObject
]

{ #category : #testing }
MOPInstrumentationInstalleur >> isClassReachableInHierarchy: aClass [

	^ self originalClass == aClass or: [ 
		  self originalClass allSuperclasses includes: aClass ]
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> metaObject [

	^ metaObject
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> metaObject: aMetaObject [

	metaObject := aMetaObject
]

{ #category : #'api - model' }
MOPInstrumentationInstalleur >> object: anObject [ 
	
	instrumentedObject := self anonymousClassForObject: anObject.
	instrumentedClass := anObject class
	
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> originalClass [

	^ instrumentedClass superclass
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> superInstrumentation: selector [

	| op instrumentation requirement |
	op := MOPSuperSendOperation selector: selector.
	instrumentation := MOPInstrumentation new addOperation: op.
	requirement := MOPSuperSendRequirement new.
	instrumentation requirement: requirement.
	^ instrumentation 
]

{ #category : #installeur }
MOPInstrumentationInstalleur >> superSendChainInstall [

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
MOPInstrumentationInstalleur >> uninstall: anInstrumentation [

	(installedInstrumentation at: anInstrumentation) do: [ :n | n links do: [:l | l uninstall]]
]
