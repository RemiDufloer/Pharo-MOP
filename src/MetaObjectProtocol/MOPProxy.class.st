Class {
	#name : #MOPProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'metaObject',
		'object'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'reflective operations' }
MOPProxy >> doesNotUnderstand: aMessage [

	^ metaObject perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #'link api' }
MOPProxy >> metaObject: aMetaObject [

	metaObject := aMetaObject
]

{ #category : #'link api' }
MOPProxy >> object: anObject [

	object := anObject.
	object become: self.
]
