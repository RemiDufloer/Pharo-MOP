"
I don't redefine behavior, but rather execute the base behavior 
"
Class {
	#name : #MOPDefaultOperation,
	#superclass : #MOPOperation,
	#category : #'MetaObjectProtocol-Operation'
}

{ #category : #accessing }
MOPDefaultOperation >> apply: aRFOperation [

	^ aRFOperation value
]
