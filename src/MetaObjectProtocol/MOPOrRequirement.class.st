Class {
	#name : #MOPOrRequirement,
	#superclass : #MOPLogicRequirement,
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
MOPOrRequirement class >> left: aRequirementLeft right: aRequirementRight [

	^ self new
		  left: aRequirementLeft;
		  right: aRequirementRight;
		  yourself
]

{ #category : #verifying }
MOPOrRequirement >> verify: anASTNode [

	^ (self left verify: anASTNode) or: [ self right verify: anASTNode ]
]
