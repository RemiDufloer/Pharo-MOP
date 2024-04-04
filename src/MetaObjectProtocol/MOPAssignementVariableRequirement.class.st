Class {
	#name : #MOPAssignementVariableRequirement,
	#superclass : #MOPRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #verifying }
MOPAssignementVariableRequirement >> verify: anASTNode [

	^ anASTNode isAssignment and: [ anASTNode variable isInstanceVariable ].

]
