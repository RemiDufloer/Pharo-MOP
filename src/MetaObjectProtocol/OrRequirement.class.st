Class {
	#name : #OrRequirement,
	#superclass : #LogicRequirement,
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
OrRequirement class >> left: aRequirementLeft right: aRequirementRight [

	^ self new
		  left: aRequirementLeft;
		  right: aRequirementRight;
		  yourself
]

{ #category : #verifying }
OrRequirement >> verify: anASTNode [

	^ (self left verify: anASTNode) or: [ self right verify: anASTNode ]
]
