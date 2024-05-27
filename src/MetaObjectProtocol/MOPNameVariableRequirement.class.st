"
I check if the variable name matches the expected one
"
Class {
	#name : #MOPNameVariableRequirement,
	#superclass : #MOPRequirement,
	#instVars : [
		'name'
	],
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #accessing }
MOPNameVariableRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : #accessing }
MOPNameVariableRequirement >> name: aString [

	name := aString
]

{ #category : #verifying }
MOPNameVariableRequirement >> verify: anASTNode [

	^ (MOPOrRequirement left: (MOPNameReadVariableRequirement name: name ) right: (MOPNameAssignementVariableRequirement  name: name )) verify: anASTNode 
]
