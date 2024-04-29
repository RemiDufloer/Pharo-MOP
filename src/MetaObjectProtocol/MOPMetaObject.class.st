Class {
	#name : #MOPMetaObject,
	#superclass : #Object,
	#instVars : [
		'instrumentations',
		'object',
		'protocol',
		'proxy'
	],
	#category : #'MetaObjectProtocol-base'
}

{ #category : #adding }
MOPMetaObject >> addInstrumentation: anInstrumentation [

	instrumentations add: anInstrumentation
]

{ #category : #'handling DNU' }
MOPMetaObject >> handle: aMessage [

	<debuggerCompleteToSender>
	(object class lookupSelector: aMessage selector) ifNotNil: [
		:selector | self instrument: selector ].

	^ MirrorPrimitives
		  withReceiver: object
		  perform: aMessage selector
		  withArguments: aMessage arguments asArray
]

{ #category : #initialization }
MOPMetaObject >> initialize [

	object := Object new.

	protocol := MOPProtocol new.
	protocol metaObject: self.

	instrumentations := OrderedCollection new.

]

{ #category : #install }
MOPMetaObject >> installOnAnnonymousClass: aRBMethod [

	| ast selfCode sourceCode instanceProxy |
	
	instanceProxy := 'proxy', object hash asString.
	ast := RBParser parseMethod: aRBMethod sourceCode.
	aRBMethod ast containsReturn
		ifTrue: [
			selfCode := (RBReturnNode value: RBVariableNode selfNode)
				            formattedCode.
			sourceCode := ast formattedCode
				              copyReplaceAll: selfCode
				              with: '^ ', instanceProxy ]
		ifFalse: [ sourceCode := ast sourceCode , '. ^ ' , instanceProxy ].

	object class compile: sourceCode
]

{ #category : #instrument }
MOPMetaObject >> instrument: aMethod [

	| instrumentationInstalleur methodNeedToInstall |
	instrumentationInstalleur := MOPInstrumentationInstaller new.
	instrumentationInstalleur object: object.
	
	self installOnAnnonymousClass: aMethod.
	instrumentationInstalleur superProblemeResolve: aMethod.
	
	methodNeedToInstall := object class >> aMethod selector.
	
	

	self instrumentations do: [ :instrumentation |
		| nodes |
		nodes := methodNeedToInstall ast allChildren select: [ :n |
			         instrumentation requirement verify: n ].

		nodes do: [ :n |
			instrumentationInstalleur install: instrumentation onNode: n ] ]
]

{ #category : #accessing }
MOPMetaObject >> instrumentations [

	^ instrumentations 
]

{ #category : #accessing }
MOPMetaObject >> object: anObject [

	| instanceProxy |
	
	instanceProxy := 'proxy', anObject hash asString.
	
	object := anObject.
	anObject class newAnonymousSubclass adoptInstance: anObject.
	anObject class addSlot: instanceProxy asSymbol  => MOPProxyInstanceVariableSlot 
]

{ #category : #accessing }
MOPMetaObject >> protocol [

	^ protocol
]

{ #category : #accessing }
MOPMetaObject >> proxy: aMOPProxy [

	| instanceProxy |
	
	instanceProxy := 'proxy', object hash asString.

	proxy := aMOPProxy.
	"here we put the proxy as an instance variable of the anonymous class, we do this so as not to return self in the methods of the proxied object but to return the proxy. This allows you to capture all the messages and not leave the MOP"
	MirrorPrimitives
		fixedFieldOf: object
		at: ( object class slotNamed: instanceProxy) index
		put: aMOPProxy
]
