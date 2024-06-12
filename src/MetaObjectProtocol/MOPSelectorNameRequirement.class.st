"
I check if the selector matches the expected one.
"
Class {
	#name : 'MOPSelectorNameRequirement',
	#superclass : 'MOPRequirement',
	#instVars : [
		'name'
	],
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'accessing' }
MOPSelectorNameRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : 'accessing' }
MOPSelectorNameRequirement >> name: aString [

	name := aString
]

{ #category : 'verifying' }
MOPSelectorNameRequirement >> verify: anASTNode [

	anASTNode isMethod ifTrue: [^ anASTNode selector = name ].
	^ false
]
