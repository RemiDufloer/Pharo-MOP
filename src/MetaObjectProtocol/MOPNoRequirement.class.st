Class {
	#name : #MOPNoRequirement,
	#superclass : #MOPRequirement,
	#instVars : [
		'name'
	],
	#category : #MetaObjectProtocol
}

{ #category : #verifing }
MOPNoRequirement >> verify: anASTNode [

	^ true
]
