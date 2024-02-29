Class {
	#name : #MOPProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'metaObject'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'as yet unclassified' }
MOPProxy >> doesNotUnderstand: aMessage [

	^ metaObject handle: aMessage
]

{ #category : #'as yet unclassified' }
MOPProxy >> hash [

	^ self identityHash
]

{ #category : #'as yet unclassified' }
MOPProxy >> mop [ 

	^ metaObject protocol
]
