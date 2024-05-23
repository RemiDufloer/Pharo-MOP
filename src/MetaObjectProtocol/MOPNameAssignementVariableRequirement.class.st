Class {
	#name : 'MOPNameAssignementVariableRequirement',
	#superclass : 'MOPRequirement',
	#instVars : [
		'name'
	],
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'accessing' }
MOPNameAssignementVariableRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : 'accessing' }
MOPNameAssignementVariableRequirement >> name: aString [

	name := aString
]

{ #category : 'verifying' }
MOPNameAssignementVariableRequirement >> verify: anASTNode [

	anASTNode isAssignment ifTrue:[anASTNode variable isInstanceVariable ifFalse: [^ false ] ] ifFalse:  [ ^ false ].

	^ anASTNode variable name = name
]
