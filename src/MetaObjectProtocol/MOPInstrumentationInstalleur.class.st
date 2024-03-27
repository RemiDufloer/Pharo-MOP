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

{ #category : #'api - model' }
MOPInstrumentationInstalleur >> beForObject: anObject [ 
	
	anObject class isAnonymous ifFalse: [ 
		anObject class newAnonymousSubclass adoptInstance: anObject ].
	instrumentedObject := anObject.
	instrumentedClass := anObject class
	
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
	
	| nodeOfMethodNeedToInstall methodNeedToInstall methodsToInstrument compiledSelectors newMethod |
	
	
	
	methodsToInstrument := self findSuperSendsChainFor: aRBMethod.
	self flag:
		'Odd: can it really be empty? what about the method passed as paramter?'.
	methodsToInstrument isEmpty ifTrue: [ ^ self ].

	compiledSelectors := self compileSuperSendChain: methodsToInstrument.
	"
	compiledSelectors do: [ :cs | 
		| ast |
		newMethod := instrumentedClass >> cs.
		ast := newMethod ast.

		self compiledSelectorsMap
			at: cs
			ifPresent: [ :redirectionSelector | 
				self redirectSuperSendsIn: ast toSelector: redirectionSelector link for selector] ]."
		
	
	
	methodNeedToInstall := self instrumentedClass >> (aRBMethod selector).
	nodeOfMethodNeedToInstall := methodNeedToInstall ast allChildren.
	nodeOfMethodNeedToInstall do: [ :n | self install: aMOPInstrumentation  onNode: n ]
]

{ #category : #MetaLink }
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

	[ aNode link: link ]
		on: Exception
		do: [ link disable . ^ nil ].
	(installedInstrumentation at:anInstrumentation ifAbsent: [installedInstrumentation at:anInstrumentation put: OrderedCollection new]) add: aNode .
	
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> installedInstrumentation [

	^ installedInstrumentation
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> instrumentMethod: method selector: selector [

	| newMethod methodsToInstrument compiledSelectors |
	methodsToInstrument := self findSuperSendsChainFor: method.
	self flag:
		'Odd: can it really be empty? what about the method passed as paramter?'.
	methodsToInstrument isEmpty ifTrue: [ ^ self ].

	compiledSelectors := self compileSuperSendChain: methodsToInstrument.

	compiledSelectors do: [ :cs | 
		| ast |
		newMethod := instrumentedClass >> cs.
		ast := newMethod ast.
		"self redirectSelfArgsIn: ast."  "link for selector instead with Nil"
		self redirectMessagesSendIn: ast.
		self redirectSelfReturnsIn: ast. "link for selector after with Nil"
		self redirectVariableReadingIn: ast.
		self redirectVariableWritingIn: ast.

		self compiledSelectorsMap
			at: cs
			ifPresent: [ :redirectionSelector | 
				self redirectSuperSendsIn: ast toSelector: redirectionSelector "link for selector" ] ]
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> instrumentSelector: selector withArgs: args [

	| method |
	method := instrumentedClass lookupSelector: selector.
	method isPrimitive ifTrue: [ 
		method primitive = 188 ifTrue: [ 			
			method := args second.
			self instrumentMethod: method selector: method selector.
			args removeLast.
			args addLast: (instrumentedClass lookupSelector: method selector)  ].
		^ self ].
	self instrumentMethod: method selector: selector.
	
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

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> newInsteadLinkForAssignments [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := Object new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	link selector: #execute:.
	link arguments: #( operation ).
	"link selector: #execute:withValue:.
	link arguments: #( name value )."
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> newInsteadLinkForMessagesSend [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := Object new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	link selector: #execute:.
	link arguments: #( operation ).
	"link arguments: #( selector receiver arguments value ).
	link optionArgsAsArray: true."
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> newInsteadLinkForVariableRead [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := Object new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	"link selector: #execute:.
	link arguments: #( operation )."
	link selector: #execute:withValue:.
	link arguments: #( name value).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> newLinkForSelector: selector [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.
	
	interceptor := Object new.
	interceptor selector: selector.
	interceptor metaObject: metaObject.
	
	link metaObject: interceptor.
	(selector notNil and: [selector isKeyword])
		ifTrue: [ 
			link selector: #executeWithArgs:.
			link arguments: #( arguments )]
		ifFalse: [ link selector: #execute ].

	link optionCompileOnLinkInstallation: true.
"	link level: 0."
	^ link
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> object: anObject [

	self instrumentedObject: anObject .
	self instrumentedClass: anObject class
]

{ #category : #accessing }
MOPInstrumentationInstalleur >> originalClass [

	^ instrumentedClass superclass
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> redirectMessagesSendIn: ast [

	| messageSendNode |
	messageSendNode := ast sendNodes reject: [ :node | node isBinary ].
	messageSendNode do: [ :node | 
		node link: (self newInsteadLinkForMessagesSend) ]
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> redirectSelfReturnsIn: ast [

	| returnNodes |
	returnNodes := ast allChildren select: [ :node | 
		               node isReturn and: [ node value isSelfVariable ] ].
	returnNodes do: [ :node | 
	
		node value link:
			((self newLinkForSelector: nil)
				 control: #after;
				 yourself) ]
]

{ #category : #installeur }
MOPInstrumentationInstalleur >> redirectSuperSendsIn: ast toSelector: aSelector [
	
	| methodName nodes  |
	methodName := ast methodNode method name.
	nodes := ast sendNodes select: [ :node | node receiver isSuperVariable ].
	nodes do: [ :node | 		
		node link: (self newLinkForSelector: aSelector) ]
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> redirectVariableReadingIn: ast [

	| variableReadNodes |
	variableReadNodes := ast variableReadNodes.
	variableReadNodes := variableReadNodes reject: [ :node | 
		                     node isSelfVariable or: [ 
			                     node isSuperVariable or: [ 
				                     node isThisContextVariable or: [ 
					                     ast hasArgumentNamed: node name ] ] ] ].
	variableReadNodes do: [ :node | 
		node link: self newInsteadLinkForVariableRead ]
]

{ #category : #instrumentation }
MOPInstrumentationInstalleur >> redirectVariableWritingIn: ast [

	| assignmentNodes |
	assignmentNodes := ast assignmentNodes.
	assignmentNodes do: [ :node | 
		node link: self newInsteadLinkForAssignments ]
]

{ #category : #'as yet unclassified' }
MOPInstrumentationInstalleur >> uninstall: anInstrumentation [

	(installedInstrumentation at: anInstrumentation) do: [ :n | n links do: [:l | l uninstall]]
]
