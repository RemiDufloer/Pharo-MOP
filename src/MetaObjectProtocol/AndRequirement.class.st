Class {
	#name : #AndRequirement,
	#superclass : #LogicRequirement,
	#category : #MetaObjectProtocol
}

{ #category : #verifying }
AndRequirement >> verify: anASTNode [

	^ (self left verify: anASTNode) and: [ self right verify: anASTNode ]
]
