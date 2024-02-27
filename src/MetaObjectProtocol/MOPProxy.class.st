Class {
	#name : #MOPProxy,
	#superclass : #nil,
	#instVars : [
		'metaObject'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'reflective operations' }
MOPProxy >> doesNotUnderstand: aMessage [

	^ metaObject handle: aMessage
]
