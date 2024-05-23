"
I check if the arguments have the expected size.
"
Class {
	#name : 'MOPArgumentsSizeRequirement',
	#superclass : 'MOPRequirement',
	#instVars : [
		'size'
	],
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'accessing' }
MOPArgumentsSizeRequirement class >> size: anInteger [ 
	
	^ self new size: anInteger 
]

{ #category : 'accessing' }
MOPArgumentsSizeRequirement >> size: anInteger [

	size := anInteger
]

{ #category : 'verifying' }
MOPArgumentsSizeRequirement >> verify: anASTNode [

	(anASTNode isMethod or: [anASTNode isBlock ]) ifTrue: [ ^ anASTNode arguments size = size ].
	^ false
]
