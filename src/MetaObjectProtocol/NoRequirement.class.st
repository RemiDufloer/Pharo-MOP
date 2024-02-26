Class {
	#name : #NoRequirement,
	#superclass : #Requirement,
	#instVars : [
		'name'
	],
	#category : #MetaObjectProtocol
}

{ #category : #verifing }
NoRequirement >> verify: anASTNode [

	^ true
]
