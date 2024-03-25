Class {
	#name : #RequirementBuilder,
	#superclass : #MOPBuilder,
	#instVars : [
		'requirement'
	],
	#category : #MetaObjectProtocolBuilder
}

{ #category : #'instance creation' }
RequirementBuilder >> andRequirement: aRequirement [

	self newRequirement: (requirement and: aRequirement)
]

{ #category : #'instance creation' }
RequirementBuilder >> newRequirement: aRequirement [ 
	
	requirement := aRequirement.
	self pushRequirement .
	
]

{ #category : #'instance creation' }
RequirementBuilder >> orRequirement: aRequirement [

	self newRequirement: (requirement or: aRequirement)
]

{ #category : #'instance creation' }
RequirementBuilder >> pushRequirement [

	instrumentationBuilder requirement: requirement .
]
