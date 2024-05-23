Class {
	#name : 'MOPTestObject',
	#superclass : 'Object',
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'testing' }
MOPTestObject >> exampleMethod [

	^ self
]

{ #category : 'testing' }
MOPTestObject >> exampleMethod: anObject [
	^ anObject
]

{ #category : 'testing' }
MOPTestObject >> isString [ 

	^ true
]
