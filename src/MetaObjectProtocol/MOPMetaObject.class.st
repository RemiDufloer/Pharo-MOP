Class {
	#name : #MOPMetaObject,
	#superclass : #Object,
	#instVars : [
		'instrumentations',
		'object',
		'protocol',
		'instrumentationInstalleur'
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

{ #category : #instrument }
MOPMetaObject >> instrument: aMethod [

	self instrumentations do: [ :instrumentation |
		| nodes |
		nodes := aMethod ast allChildren select: [ :n |
			         instrumentation requirement verify: n ].

		nodes ifNotEmpty: [  

		MOPInstrumentationInstaller new
			object: object;
			install: instrumentation onMethod: aMethod ]]
]

{ #category : #accessing }
MOPMetaObject >> instrumentations [

	^ instrumentations 
]

{ #category : #accessing }
MOPMetaObject >> object: anObject [
 
	object := anObject.
	instrumentationInstalleur object: anObject
	
]

{ #category : #accessing }
MOPMetaObject >> protocol [

	^ protocol
]
