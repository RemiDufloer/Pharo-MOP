"
I have no requirement, i already return True

"
Class {
	#name : #MOPNoRequirement,
	#superclass : #MOPRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #verifing }
MOPNoRequirement >> verify: anASTNode [

	^ true
]
