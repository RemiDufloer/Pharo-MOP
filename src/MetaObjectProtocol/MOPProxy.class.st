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
	self primitiveFailed
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

{ #category : #accessing }
MOPProxy >> mop [

	^ metaObject protocol
]

{ #category : #'primitive failure' }
MOPProxy >> primitiveFail [
	"See ProtoObject >> #primitiveFail"

	^ self primitiveFailed
]

{ #category : #'primitive failure' }
MOPProxy >> primitiveFailed [

	"See ProtoObject >> #primitiveFailed"
	
	^ self primitiveFailed: thisContext sender selector
]

{ #category : #'primitive failure' }
MOPProxy >> primitiveFailed: selector [
	"See ProtoObject >> #primitiveFailed:"

	PrimitiveFailed signalFor: selector
]
