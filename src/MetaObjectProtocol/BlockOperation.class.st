Class {
	#name : #BlockOperation,
	#superclass : #Operation,
	#category : #MetaObjectProtocol
}

{ #category : #creating }
BlockOperation class >> block: aRFOperation [

	^ self requirement: [ true ] block: aRFOperation
]

{ #category : #creating }
BlockOperation class >> requirement: aRequirement block: aFullBlockClosure [

	^ self new
		  requirement: aRequirement;
		  block: aFullBlockClosure;
		  yourself
]

{ #category : #accessing }
BlockOperation >> apply: aRFOperation [

	requirement value ifTrue: [ ^ block value: aRFOperation ]
]

{ #category : #accessing }
BlockOperation >> block [
	
	^ block  
]

{ #category : #accessing }
BlockOperation >> block: aFullBlockClosure [ 
	
	block := aFullBlockClosure
]

{ #category : #accessing }
BlockOperation >> requirement [
	
	^ requirement 
]

{ #category : #accessing }
BlockOperation >> requirement: aRequirement [

	requirement := aRequirement
]
