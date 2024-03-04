Class {
	#name : #RequirementInstallationBuilder,
	#superclass : #MOPBuilderProtocol,
	#instVars : [
		'requirement'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
RequirementInstallationBuilder >> andRequirement: aRequirement [

	self requirement: ( self requirement and: aRequirement ).
	self instrumentation requirement: aRequirement
]

{ #category : #'instance creation' }
RequirementInstallationBuilder >> newRequirement: aRequirement [

	requirement := aRequirement.
	self instrumentation requirement: aRequirement.
]

{ #category : #'instance creation' }
RequirementInstallationBuilder >> orRequirement: aRequirement [

	self requirement: (self requirement or: aRequirement).
	self instrumentation requirement: aRequirement
]

{ #category : #accessing }
RequirementInstallationBuilder >> requirement [

	^ requirement
]

{ #category : #accessing }
RequirementInstallationBuilder >> requirement: anObject [

	requirement := anObject
]
