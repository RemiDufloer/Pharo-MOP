Class {
	#name : #MOPNameAssignementVariableRequirement,
	#superclass : #MOPRequirement,
	#instVars : [
		'name'
	],
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #accessing }
MOPNameAssignementVariableRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : #accessing }
MOPNameAssignementVariableRequirement >> name: aString [

	name := aString
]

{ #category : #verifying }
MOPNameAssignementVariableRequirement >> verify: anASTNode [

	anASTNode isAssignment variable isInstanceVariable  ifFalse: [ ^ false ].

	^ anASTNode name = name
]
