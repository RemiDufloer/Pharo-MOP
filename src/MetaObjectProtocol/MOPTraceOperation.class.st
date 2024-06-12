Class {
	#name : 'MOPTraceOperation',
	#superclass : 'MOPOperation',
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPTraceOperation >> apply: aRFOperation with: anOrderedCollection [
   <debuggerCompleteToSender>
	aRFOperation asString traceCr.
]
