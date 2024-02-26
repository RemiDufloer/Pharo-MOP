Class {
	#name : #Requirement,
	#superclass : #Object,
	#instVars : [
		'andRequirementCollection',
		'orRequirementCollection'
	],
	#category : #MetaObjectProtocol
}

{ #category : #verifying }
Requirement >> allRequirementVerify: anASTNode [

	| andRequirementBoolean orRequirementBoolean notRequirementBoolean|
	
	andRequirementBoolean := self andRequirementVerify: anASTNode.
	orRequirementBoolean := self orRequirementVerify: anASTNode.

	^ (((self verify: anASTNode) and: [ ^ andRequirementBoolean ]) or: [ ^ orRequirementBoolean ]) 
]

{ #category : #controlling }
Requirement >> and: aRequirement [

	andRequirementCollection add: aRequirement 
]

{ #category : #verifying }
Requirement >> andRequirementVerify: anASTNode [

	^ andRequirementCollection allSatisfy: [ :a |
		  a allRequirementVerify: anASTNode ]
]

{ #category : #initialization }
Requirement >> initialize [

	andRequirementCollection := OrderedCollection new.
	orRequirementCollection := OrderedCollection new.
]

{ #category : #controlling }
Requirement >> or: aRequirement [

	orRequirementCollection add: aRequirement 
]

{ #category : #verifing }
Requirement >> orRequirementVerify: anASTNode [

	^ orRequirementCollection anySatisfy:  [ :o |
		  o allRequirementVerify: anASTNode ].

]

{ #category : #verifying }
Requirement >> verify: anASTNode [

	^ self subclassResponsibility 
]
