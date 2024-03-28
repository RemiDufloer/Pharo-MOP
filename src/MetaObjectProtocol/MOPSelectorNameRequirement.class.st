Class {
	#name : #MOPSelectorNameRequirement,
	#superclass : #MOPRequirement,
	#instVars : [
		'name'
	],
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #accessing }
MOPSelectorNameRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : #accessing }
MOPSelectorNameRequirement >> name: aString [

	name := aString
]

{ #category : #verifying }
MOPSelectorNameRequirement >> verify: anASTNode [

	anASTNode isMethod ifTrue: [ ^ anASTNode selector = name ].
	^ false
]
