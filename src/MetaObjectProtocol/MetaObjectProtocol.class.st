Class {
	#name : #MetaObjectProtocol,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
MetaObjectProtocol class >> onObject: anObject [
	
	^ self new object: anObject .
]

{ #category : #accessing }
MetaObjectProtocol >> object: aMOPObjectMock [

	object := aMOPObjectMock
]
