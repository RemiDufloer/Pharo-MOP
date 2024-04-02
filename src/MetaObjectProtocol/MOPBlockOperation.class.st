Class {
	#name : #MOPBlockOperation,
	#superclass : #MOPOperation,
	#category : #'MetaObjectProtocol-Operation'
}

{ #category : #creating }
MOPBlockOperation class >> block: aRFOperation [

	^ self requirement: MOPNoRequirement new block: aRFOperation
]

{ #category : #creating }
MOPBlockOperation class >> requirement: aRequirement block: aFullBlockClosure [

	^ self new
		  requirement: aRequirement;
		  block: aFullBlockClosure;
		  yourself
]

{ #category : #accessing }
MOPBlockOperation >> apply: aRFOperation [


	(requirement verify: aRFOperation) ifTrue: [
		^ block value: aRFOperation ]
]

{ #category : #accessing }
MOPBlockOperation >> block [
	
	^ block  
]

{ #category : #accessing }
MOPBlockOperation >> block: aFullBlockClosure [ 
	
	block := aFullBlockClosure
]