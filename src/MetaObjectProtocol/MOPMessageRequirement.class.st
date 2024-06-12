Class {
	#name : 'MOPMessageRequirement',
	#superclass : 'MOPRequirement',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'verifying' }
MOPMessageRequirement >> verify: anASTNode [

	^ anASTNode isMessage 
]
