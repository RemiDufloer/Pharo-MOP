Class {
	#name : #MOPTestObject,
	#superclass : #Object,
	#category : #MetaObjectProtocolTest
}

{ #category : #testing }
MOPTestObject >> exampleMethod [

	^ self
]

{ #category : #testing }
MOPTestObject >> exampleMethod: anObject [

	^ anObject 
]

{ #category : #testing }
MOPTestObject >> isString [ 

	^ true
]
