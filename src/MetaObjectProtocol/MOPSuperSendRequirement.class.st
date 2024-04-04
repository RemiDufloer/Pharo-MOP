"
I check if the nodes is a message and if the receiver is super 
"
Class {
	#name : #MOPSuperSendRequirement,
	#superclass : #MOPRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #verifying }
MOPSuperSendRequirement >> verify: anASTNode [

	anASTNode isMessage ifTrue: [ ^ anASTNode isSuperSend ].
	^ false
]
