Class {
	#name : #OperationBuilder,
	#superclass : #MOPBuilderProtocol,
	#instVars : [
		'operation',
		'requirement'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
OperationBuilder >> andRequirementOperation: aRequirement [

	requirement := self requirement and: aRequirement .
	self operation requirement: requirement
]

{ #category : #'instance creation' }
OperationBuilder >> newBlockOperation: aBlock [


	operation := BlockOperation block: aBlock.
	self instrumentation addOperation: operation
]

{ #category : #'instance creation' }
OperationBuilder >> newRequirementOperation:  aRequirement [

	requirement := aRequirement.
	self operation requirement: requirement
]

{ #category : #accessing }
OperationBuilder >> operation [

	^ operation
]

{ #category : #accessing }
OperationBuilder >> operation: anObject [

	operation := anObject
]

{ #category : #'instance creation' }
OperationBuilder >> orRequirementOperation: aRequirement [

	requirement := self requirement or: aRequirement.
	self operation requirement: requirement
]

{ #category : #accessing }
OperationBuilder >> requirement [

	^ requirement
]

{ #category : #accessing }
OperationBuilder >> requirement: anObject [

	requirement := anObject
]
