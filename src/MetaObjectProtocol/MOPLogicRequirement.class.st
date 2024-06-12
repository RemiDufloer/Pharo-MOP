"
I compose conditions logically using the 'and' and 'or' operators.
"
Class {
	#name : 'MOPLogicRequirement',
	#superclass : 'MOPRequirement',
	#instVars : [
		'left',
		'right'
	],
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'testing' }
MOPLogicRequirement class >> isAbstract [

	^ self == MOPLogicRequirement
]

{ #category : 'instance creation' }
MOPLogicRequirement class >> left: aRequirementLeft right: aRequirementRight [

	^ self new
		  left: aRequirementLeft;
		  right: aRequirementRight;
		  yourself
]

{ #category : 'accessing' }
MOPLogicRequirement >> left [

	^ left
]

{ #category : 'accessing' }
MOPLogicRequirement >> left: aRequirement [

	left := aRequirement
]

{ #category : 'accessing' }
MOPLogicRequirement >> right [

	^ right
]

{ #category : 'accessing' }
MOPLogicRequirement >> right: aRequirement [

	right := aRequirement
]
