"
My comportement is define on a Block

"
Class {
	#name : 'MOPBlockOperation',
	#superclass : 'MOPOperation',
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'creating' }
MOPBlockOperation class >> block: aRFOperation [

	^ self requirement: MOPNoRequirement new block: aRFOperation
]

{ #category : 'creating' }
MOPBlockOperation class >> requirement: aRequirement block: aFullBlockClosure [

	^ self new
		  requirement: aRequirement;
		  block: aFullBlockClosure;
		  yourself
]

{ #category : 'accessing' }
MOPBlockOperation >> apply: aRFOperation with: anOrderedCollection [

	(requirement verify: aRFOperation) ifTrue: [
		^ block value: aRFOperation ]
]

{ #category : 'accessing' }
MOPBlockOperation >> block [
	
	^ block  
]

{ #category : 'accessing' }
MOPBlockOperation >> block: aFullBlockClosure [ 
	
	block := aFullBlockClosure
]
