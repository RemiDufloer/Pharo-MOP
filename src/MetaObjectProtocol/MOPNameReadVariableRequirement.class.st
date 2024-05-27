Class {
	#name : #MOPNameReadVariableRequirement,
	#superclass : #MOPRequirement,
	#instVars : [
		'name'
	],
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #accessing }
MOPNameReadVariableRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : #accessing }
MOPNameReadVariableRequirement >> name: aString [

	name := aString
]

{ #category : #verifying }
MOPNameReadVariableRequirement >> verify: anASTNode [

	(anASTNode isInstanceVariable and: [ anASTNode isRead ]) ifFalse: [ ^ false ].

	^ anASTNode name = name
]
