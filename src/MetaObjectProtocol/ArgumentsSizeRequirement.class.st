Class {
	#name : #ArgumentsSizeRequirement,
	#superclass : #Requirement,
	#instVars : [
		'size'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
ArgumentsSizeRequirement class >> size: anInteger [ 
	
	^ self new size: anInteger 
]

{ #category : #accessing }
ArgumentsSizeRequirement >> size: anInteger [

	size := anInteger
]

{ #category : #verifying }
ArgumentsSizeRequirement >> verify: anASTNode [

	^ anASTNode arguments size = size
]
