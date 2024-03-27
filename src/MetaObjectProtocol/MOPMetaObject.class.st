Class {
	#name : #MOPMetaObject,
	#superclass : #Object,
	#instVars : [
		'instrumentations',
		'object',
		'protocol',
		'instrumentationInstalleur'
	],
	#category : #MetaObjectProtocol
}

{ #category : #adding }
MOPMetaObject >> addInstrumentation: anInstrumentation [ 
	
	anInstrumentation instrumentationInstalleur: instrumentationInstalleur.
	instrumentations add: anInstrumentation.
	
]

{ #category : #accessing }
MOPMetaObject >> giveMethodAssociatedToMessage: aMessage [

	^ object class lookupSelector: aMessage selector.
]

{ #category : #'handling DNU' }
MOPMetaObject >> handle: aMessage [

	<debuggerCompleteToSender>
	self instrumentMethod: (self giveMethodAssociatedToMessage: aMessage).
	

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

	instrumentationInstalleur := MOPInstrumentationInstalleur for: self
]

{ #category : #instrument }
MOPMetaObject >> instrumentMethod: aMethode [

	self instrumentations do: [ :inst | instrumentationInstalleur  install: inst onMethod: aMethode  ] .
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
