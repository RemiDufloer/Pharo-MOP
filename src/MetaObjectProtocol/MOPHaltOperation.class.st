Class {
	#name : #MOPHaltOperation,
	#superclass : #MOPOperation,
	#category : #'MetaObjectProtocol-Operation'
}

{ #category : #accessing }
MOPHaltOperation >> apply: aRFOperation with: anOrderedCollection [
   <debuggerCompleteToSender>
	self halt.
]
