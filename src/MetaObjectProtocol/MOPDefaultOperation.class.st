"
I don't redefine behavior, but rather execute the base behavior 
"
Class {
	#name : 'MOPDefaultOperation',
	#superclass : 'MOPOperation',
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPDefaultOperation >> apply: aRFOperation with: anOrderedCollection [

	^ aRFOperation value
]
