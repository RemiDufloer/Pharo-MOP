Class {
	#name : 'MOPInstrumentationInstaller',
	#superclass : 'Object',
	#instVars : [
		'installedInstrumentation',
		'object'
	],
	#category : 'MetaObjectProtocol-base',
	#package : 'MetaObjectProtocol',
	#tag : 'base'
}

{ #category : 'instance creation' }
MOPInstrumentationInstaller class >> for: aMetaObject [

	^ self new
		  metaObject: aMetaObject;
		  yourself
]

{ #category : 'instrumentation' }
MOPInstrumentationInstaller >> compileSuperSendChain: aMethodCollection [

	| methods |
	methods := DoubleLinkedList new.
	aMethodCollection isEmpty ifTrue: [ ^ methods ].
	methods add: aMethodCollection first selector.
	aMethodCollection removeFirst.
	1 to: aMethodCollection size do: [ :i |
		| method code |
		method := aMethodCollection at: i.
		code := String streamContents: [ :s |
			        s << '_' << i asString << '_' << method sourceCode ].
		methods add: (object class compile: code) ].
	^ methods
]

{ #category : 'instrumentation' }
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

{ #category : 'initialization' }
MOPInstrumentationInstaller >> initialize [ 

	installedInstrumentation := Dictionary new.
]

{ #category : 'installeur' }
MOPInstrumentationInstaller >> install: aMOPInstrumentation onMethod: aRBMethod [

	| nodeOfMethodNeedToInstall methodNeedToInstall |
	self superProblemeResolve: aRBMethod.

	methodNeedToInstall := self object class >> aRBMethod selector.

	nodeOfMethodNeedToInstall := methodNeedToInstall ast allChildren
		                             select: [ :n |
		                             aMOPInstrumentation requirement
			                             verify: n ].

	nodeOfMethodNeedToInstall do: [ :n |
		self install: aMOPInstrumentation onNode: n ]
]

{ #category : 'installeur' }
MOPInstrumentationInstaller >> install: anInstrumentation onNode: aNode [

	| link |
	aNode hasMetaLinks ifTrue: [
		self error: ' there is already instrumentation on this node ' ].
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

{ #category : 'accessing' }
MOPInstrumentationInstaller >> installedInstrumentation [

	^ installedInstrumentation
]

{ #category : 'accessing' }
MOPInstrumentationInstaller >> object [

	^ object
]

{ #category : 'api - model' }
MOPInstrumentationInstaller >> object: anObject [

	object := anObject
]

{ #category : 'instrumentation' }
MOPInstrumentationInstaller >> superInstrumentation: selector [

	| op instrumentation requirement |
	op := MOPSuperSendOperation selector: selector.
	instrumentation := MOPInstrumentation new operation: op.
	requirement := MOPSuperSendRequirement new.
	instrumentation requirement: requirement.
	^ instrumentation 
]

{ #category : 'installeur' }
MOPInstrumentationInstaller >> superProblemeResolve: aRBMethod [

	| methodsToInstrument compiledSelectors |
	methodsToInstrument := self findSuperSendsChainFor: aRBMethod.

	compiledSelectors := self compileSuperSendChain: methodsToInstrument.

	compiledSelectors isEmpty ifFalse: [
		self superSendChainInstall: compiledSelectors ]
]

{ #category : 'installeur' }
MOPInstrumentationInstaller >> superSendChainInstall: aDoubleLinkedList [

	aDoubleLinkedList linksDo: [ :link |
		link hasSuccessor ifFalse: [ ^ nil ].
		self
			install: (self superInstrumentation: link nextLink value)
			onMethod: object class >> link value asSymbol ]
]

{ #category : 'instrumentation' }
MOPInstrumentationInstaller >> uninstall: anInstrumentation [

	self flag: 'Todo'.
	(installedInstrumentation at: anInstrumentation) do: [ :n | n links do: [:l | l uninstall]]
]
