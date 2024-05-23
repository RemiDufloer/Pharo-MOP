Class {
	#name : #MOPMessageRequirement,
	#superclass : #MOPRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #verifying }
MOPMessageRequirement >> verify: anASTNode [

	^ anASTNode isMessage 
]
