Class {
	#name : #NameVariableRequirement,
	#superclass : #Requirement,
	#instVars : [
		'name'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
NameVariableRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : #accessing }
NameVariableRequirement >> name: aString [

	name := aString
]

{ #category : #verifying }
NameVariableRequirement >> verify: anASTNode [

	^ anASTNode name = name
]
