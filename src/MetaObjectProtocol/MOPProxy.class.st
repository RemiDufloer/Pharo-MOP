"
Acts as a bubble around the object, intercepting messages and forwarding them to the meta-object. This is facilitated through the exchange of references using the 'become' primitive.

Responsibilities:
 - Intercept messages directed towards the object and forward them to the meta-object.
 - Exchange references with the object via the 'become' primitive to facilitate message forwarding.
 - Redefine hash methods since it does not inherit from any parent class, allowing it to provide its hash when exchanging references with the object.
 
Collaborators:
 - Meta-object: Interacts with the meta-object to forward intercepted messages and exchange references.

Internal Representation and Key Implementation Points:
 - Utilizes the 'become' primitive to exchange references with the object.
 - Redefines hash methods to provide its hash during reference exchange.
 - Encapsulates logic for intercepting and forwarding messages.

"
Class {
	#name : 'MOPProxy',
	#superclass : 'nil',
	#instVars : [
		'metaObject'
	],
	#category : 'MetaObjectProtocol-base',
	#package : 'MetaObjectProtocol',
	#tag : 'base'
}

{ #category : 'reflective operations' }
MOPProxy >> basicIdentityHash [
	"See ProtoObject >> #basicIdentityHash"

	<primitive: 75>
	self primitiveFailed
]

{ #category : 'reflective operations' }
MOPProxy >> doesNotUnderstand: aMessage [

	<debuggerCompleteToSender>
	
	^ metaObject handle: aMessage
]

{ #category : 'comparing' }
MOPProxy >> hash [

	^ self identityHash
]

{ #category : 'reflective operations' }
MOPProxy >> identityHash [
	
	"See ProtoObject >> #identityHash"

	^ self basicIdentityHash bitShift: 8
]

{ #category : 'accessing' }
MOPProxy >> mop [

	^ metaObject protocol
]

{ #category : 'primitive failure' }
MOPProxy >> primitiveFail [
	"See ProtoObject >> #primitiveFail"

	^ self primitiveFailed
]

{ #category : 'primitive failure' }
MOPProxy >> primitiveFailed [

	"See ProtoObject >> #primitiveFailed"
	
	^ self primitiveFailed: thisContext sender selector
]

{ #category : 'primitive failure' }
MOPProxy >> primitiveFailed: selector [
	"See ProtoObject >> #primitiveFailed:"

	PrimitiveFailed signalFor: selector
]
