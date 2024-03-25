Class {
	#name : #MOPNameVariableRequirement,
	#superclass : #MOPRequirement,
	#instVars : [
		'name'
	],
	#category : #MetaObjectProtocol
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

	anASTNode isVariable ifTrue: [ ^ anASTNode name = name ].
	^ false
	
]
