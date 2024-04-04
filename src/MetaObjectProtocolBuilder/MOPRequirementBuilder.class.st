Class {
	#name : #MOPRequirementBuilder,
	#superclass : #MOPBuilder,
	#instVars : [
		'requirement'
	],
	#category : #MetaObjectProtocolBuilder
}

{ #category : #'instance creation' }
MOPRequirementBuilder >> andRequirement: aRequirement [

	self newRequirement: (requirement and: aRequirement)
]

{ #category : #'instance creation' }
MOPRequirementBuilder >> newRequirement: aRequirement [ 
	
	requirement := aRequirement.
	self pushRequirement .
	
]

{ #category : #'instance creation' }
MOPRequirementBuilder >> orRequirement: aRequirement [

	self newRequirement: (requirement or: aRequirement)
]

{ #category : #'instance creation' }
MOPRequirementBuilder >> pushRequirement [

	instrumentationBuilder requirement: requirement .
]
