Class {
	#name : #MOPProxy,
	#superclass : #nil,
	#instVars : [
		'metaObject'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'reflective operations' }
MOPProxy >> basicIdentityHash [
	"See ProtoObject >> #basicIdentityHash"

	<primitive: 75>
	PrimitiveFailed signalFor: thisContext sender selector
]

{ #category : #'reflective operations' }
MOPProxy >> doesNotUnderstand: aMessage [

	<debuggerCompleteToSender>
	
	^ metaObject handle: aMessage
]

{ #category : #comparing }
MOPProxy >> hash [

	^ self identityHash
]

{ #category : #'reflective operations' }
MOPProxy >> identityHash [
	
	"See ProtoObject >> #identityHash"

	^ self basicIdentityHash bitShift: 8
]

{ #category : #'as yet unclassified' }
MOPProxy >> mop [

	^ metaObject protocol
]
