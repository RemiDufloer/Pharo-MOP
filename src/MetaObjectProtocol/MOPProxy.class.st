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
MOPProxy >> object: anObject metaObject: aMetaObject [

	(object isNotNil or: [ metaObject isNotNil ]) ifTrue: [
		Error signal: 'Proxy already instanciated with an object and its meta-object.' 
	].

	object := anObject.
	metaObject := aMetaObject.

	object become: self
]
