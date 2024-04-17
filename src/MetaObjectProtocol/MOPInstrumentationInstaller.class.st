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
	#category : #'MetaObjectProtocol-base'
}

{ #category : #'instance creation' }
MOPInstrumentationInstaller class >> for: aMetaObject [

	^ self new
		  metaObject: aMetaObject;
		  yourself
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> compileSuperSendChain: aMethodCollection [

	| methods |
	methods := DoubleLinkedList new.
	aMethodCollection isEmpty ifTrue: [ ^ methods ].

	1 to: aMethodCollection size do: [ :i |
		| method code |
		method := aMethodCollection at: i.
		code := i > 1
			        ifTrue: [
				        String streamContents: [ :s |
					        s << '_'<< i asString << '_' << method sourceCode ] ]
			        ifFalse: [ method sourceCode ].
		methods add: (instrumentedClass compile: code) ].
	^ methods
]

{ #category : #MetaLink }
MOPInstrumentationInstaller >> createAnonymousClassFor: anObject [

	anObject class isAnonymous ifTrue: [ ^ nil ].
	anObject class newAnonymousSubclass adoptInstance: anObject
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> findSuperSendsChainFor: aMethod [

	| method chain |
	chain := OrderedCollection empty.

	(aMethod methodClass isAnonymous or: [ aMethod hasSuperSends not ])
		ifTrue: [ ^ chain ].

	method := aMethod.
	chain add: aMethod.
	[ chain last hasSuperSends ] whileTrue: [
		method := method methodClass superclass lookupSelector:
			          method selector.
		chain add: method ].
	^ chain
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

	(instrumentedClass methods select: [ :m |
		 m selector = aRBMethod selector ]) isEmpty ifTrue: [
		self instrumentedClass compile: aRBMethod sourceCode ].
	
	compiledSelectors isEmpty ifFalse: [
		self superSendChainInstall: compiledSelectors ].

	methodNeedToInstall := self instrumentedClass >> aRBMethod selector.
	nodeOfMethodNeedToInstall := methodNeedToInstall ast allChildren.
	nodeOfMethodNeedToInstall do: [ :n |
		self install: aMOPInstrumentation onNode: n ]
]

{ #category : #installeur }
MOPInstrumentationInstaller >> install: anInstrumentation onNode: aNode [

	| link |
	(anInstrumentation requirement verify: aNode) ifFalse: [ ^ nil ].
	aNode hasMetaLinks ifTrue: [ self error:
		(' there is already instrumentation on this node ') ].
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
	self createAnonymousClassFor: anObject.
	instrumentedObject :=  anObject .
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
MOPInstrumentationInstaller >> superSendChainInstall: aDoubleLinkedList [

	aDoubleLinkedList linksDo: [ :link |
		link hasSuccessor ifFalse: [ ^ nil ].
		self
			install: (self superInstrumentation: link nextLink value)
			onMethod: instrumentedObject class >> link value asSymbol ]
]

{ #category : #instrumentation }
MOPInstrumentationInstaller >> uninstall: anInstrumentation [

	(installedInstrumentation at: anInstrumentation) do: [ :n | n links do: [:l | l uninstall]]
]
