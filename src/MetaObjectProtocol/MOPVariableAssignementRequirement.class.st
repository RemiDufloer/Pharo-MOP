Class {
	#name : 'MOPVariableAssignementRequirement',
	#superclass : 'MOPRequirement',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'verifying' }
MOPVariableAssignementRequirement >> verify: anASTNode [

	^ anASTNode isAssignment and: [ anASTNode variable isInstanceVariable ].

]
