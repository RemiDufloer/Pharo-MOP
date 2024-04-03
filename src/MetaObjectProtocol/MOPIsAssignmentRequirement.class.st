Class {
	#name : #MOPIsAssignmentRequirement,
	#superclass : #MOPRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #accessing }
MOPIsAssignmentRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : #verifying }
MOPIsAssignmentRequirement >> verify: anASTNode [

	^ anASTNode isAssignment
]
