Class {
	#name : 'MOPHaltOperation',
	#superclass : 'MOPOperation',
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPHaltOperation >> apply: aRFOperation with: anOrderedCollection [

	<debuggerCompleteToSender>
	
	self halt
]
