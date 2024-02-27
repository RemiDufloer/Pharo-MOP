Class {
	#name : #LogicRequirement,
	#superclass : #Requirement,
	#instVars : [
		'left',
		'right'
	],
	#category : #MetaObjectProtocol
}

{ #category : #testing }
LogicRequirement class >> isAbstract [

	^ self == LogicRequirement
]

{ #category : #'instance creation' }
LogicRequirement class >> left: aRequirementLeft right: aRequirementRight [

	^ self new
		  left: aRequirementLeft;
		  right: aRequirementRight;
		  yourself
]

{ #category : #accessing }
LogicRequirement >> left [

	^ left
]

{ #category : #accessing }
LogicRequirement >> left: aRequirement [

	left := aRequirement
]

{ #category : #accessing }
LogicRequirement >> right [

	^ right
]

{ #category : #accessing }
LogicRequirement >> right: aRequirement [

	right := aRequirement
]
