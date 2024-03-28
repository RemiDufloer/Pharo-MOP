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
