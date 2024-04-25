Class {
	#name : #MOPMetaObject,
	#superclass : #Object,
	#instVars : [
		'instrumentations',
		'object',
		'protocol',
		'instrumentationInstalleur',
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

	instrumentationInstalleur := MOPInstrumentationInstaller for: self
]

{ #category : #'as yet unclassified' }
MOPMetaObject >> installOnAnnonymousClass: aRBMethod [

	| ast selfCode sourceCode |
	ast := RBParser parseMethod: aRBMethod sourceCode.
	aRBMethod ast containsReturn
		ifTrue: [
			selfCode := (RBReturnNode value: RBVariableNode selfNode)
				            formattedCode.
			sourceCode := ast formattedCode
				              copyReplaceAll: selfCode
				              with: '^ proxy' ]
		ifFalse: [ sourceCode := ast sourceCode , '. ^ proxy' ].

	object class compile: sourceCode
]

{ #category : #instrument }
MOPMetaObject >> instrument: aMethod [

	self installOnAnnonymousClass: aMethod.

	self instrumentations do: [ :instrumentation |
		| nodes |
		nodes := aMethod ast allChildren select: [ :n |
			         instrumentation requirement verify: n ].

		nodes ifNotEmpty: [
			MOPInstrumentationInstaller new
				object: object;
				install: instrumentation onMethod: aMethod ] ]
]

{ #category : #accessing }
MOPMetaObject >> instrumentations [

	^ instrumentations 
]

{ #category : #accessing }
MOPMetaObject >> object: anObject [

	object := anObject.
	anObject class newAnonymousSubclass adoptInstance: anObject.
	anObject class addSlot: #proxy => MOPProxyInstanceVariableSlot 
]

{ #category : #accessing }
MOPMetaObject >> protocol [

	^ protocol
]

{ #category : #accessing }
MOPMetaObject >> proxy: aMOPProxy [

	proxy := aMOPProxy.
	"here we put the proxy as an instance variable of the anonymous class, we do this so as not to return self in the methods of the proxied object but to return the proxy. This allows you to capture all the messages and not leave the MOP"
	MirrorPrimitives
		fixedFieldOf: object
		at: ( object class slotNamed: #proxy) index
		put: aMOPProxy
]
