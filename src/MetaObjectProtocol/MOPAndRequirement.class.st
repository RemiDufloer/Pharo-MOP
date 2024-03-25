Class {
	#name : #MOPAndRequirement,
	#superclass : #MOPLogicRequirement,
	#category : #MetaObjectProtocol
}

{ #category : #verifying }
MOPAndRequirement >> verify: anASTNode [

	^ (self left verify: anASTNode) and: [ self right verify: anASTNode ]
]
