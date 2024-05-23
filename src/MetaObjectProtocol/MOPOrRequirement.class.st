"
I compose conditions logically using the 'and' and 'or' operators.
"
Class {
	#name : 'MOPOrRequirement',
	#superclass : 'MOPLogicRequirement',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'instance creation' }
MOPOrRequirement class >> left: aRequirementLeft right: aRequirementRight [

	^ self new
		  left: aRequirementLeft;
		  right: aRequirementRight;
		  yourself
]

{ #category : 'verifying' }
MOPOrRequirement >> verify: anASTNode [

	^ (self left verify: anASTNode) or: [ self right verify: anASTNode ]
]
