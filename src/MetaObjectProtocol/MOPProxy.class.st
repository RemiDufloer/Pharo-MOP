Class {
	#name : #MOPProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'metaObject'
	],
	#category : #MetaObjectProtocol
}

{ #category : #comparing }
MOPProxy >> doesNotUnderstand: aMessage [

	^ metaObject handle: aMessage
]

{ #category : #accessing }
MOPProxy >> metaObject: aMOPMetaObject [

	metaObject := aMOPMetaObject
]

{ #category : #'as yet unclassified' }
MOPProxy >> mop [

	metaObject object asString crTrace.
	^ metaObject protocol
]
