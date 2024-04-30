Class {
	#name : #MOPWatchPointOperation,
	#superclass : #MOPOperation,
	#instVars : [
		'collection'
	],
	#category : #'MetaObjectProtocol-Operation'
}

{ #category : #accessing }
MOPWatchPointOperation class >> collection: aCollection [

	^ self new collection: aCollection ; yourself.
]

{ #category : #accessing }
MOPWatchPointOperation >> apply: aRFOperation [

	collection add: (aRFOperation class == RFSlotWrite
			 ifTrue: [
				 (aRFOperation variable read: aRFOperation object) asString
				 , ' -> ' , aRFOperation assignedValue asString ]
			 ifFalse: [ aRFOperation value asString ])
]

{ #category : #accessing }
MOPWatchPointOperation >> collection: anObject [

	collection := anObject
]
