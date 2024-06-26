"
I compose conditions logically using the 'and' operators.
"
Class {
	#name : #MOPAndRequirement,
	#superclass : #MOPLogicRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #verifying }
MOPAndRequirement >> verify: anASTNode [

	^ (self left verify: anASTNode) and: [ self right verify: anASTNode ]
]
