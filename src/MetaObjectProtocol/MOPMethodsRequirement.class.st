Class {
	#name : #MOPMethodsRequirement,
	#superclass : #MOPRequirement,
	#instVars : [
		'class'
	],
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #'instance creation' }
MOPMethodsRequirement class >> class: aClass [ 
	
	^ self new class: aClass 
]

{ #category : #accessing }
MOPMethodsRequirement >> class: aClass [

	class := aClass
]

{ #category : #verifying }
MOPMethodsRequirement >> verify: anASTNode [
	
	
	anASTNode isMethod ifFalse: [ ^ false].
	anASTNode methodClass == ProtoObject ifTrue: [  ^ false ].
	anASTNode methodClass == Object ifTrue: [  ^ false ].
	^ true.


]
