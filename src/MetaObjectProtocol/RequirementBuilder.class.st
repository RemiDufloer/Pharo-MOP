Class {
	#name : #RequirementBuilder,
	#superclass : #MOPBuilder,
	#instVars : [
		'requirement'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'as yet unclassified' }
RequirementBuilder >> andRequirement: aRequirement [

	self newRequirement: (requirement and: aRequirement)
]

{ #category : #'instance creation' }
RequirementBuilder >> newRequirement: aRequirement [ 
	
	requirement := aRequirement.
	self pushRequirement .
	
]

{ #category : #'as yet unclassified' }
RequirementBuilder >> orRequirement: aRequirement [

	self newRequirement: (requirement or: aRequirement)
]

{ #category : #'as yet unclassified' }
RequirementBuilder >> pushRequirement [

	instrumentationBuilder requirement: requirement .
]
