Class {
	#name : #SelectorNameRequirement,
	#superclass : #Requirement,
	#instVars : [
		'name'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
SelectorNameRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : #accessing }
SelectorNameRequirement >> name: aString [

	name := aString
]

{ #category : #verifying }
SelectorNameRequirement >> verify: anASTNode [

	anASTNode isMethod ifTrue: [ ^ anASTNode selector = name ].
	^ false
]
