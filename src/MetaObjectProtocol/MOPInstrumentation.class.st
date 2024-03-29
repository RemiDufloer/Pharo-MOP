Class {
	#name : #MOPInstrumentation,
	#superclass : #Object,
	#instVars : [
		'operation',
		'before',
		'after',
		'requirement'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
MOPInstrumentation >> after [

	^ after
]

{ #category : #accessing }
MOPInstrumentation >> after: anObject [

	after := anObject
]

{ #category : #accessing }
MOPInstrumentation >> before [

	^ before
]

{ #category : #accessing }
MOPInstrumentation >> before: anObject [

	before := anObject
]

{ #category : #execution }
MOPInstrumentation >> execute: aRFOperation [

	| return returnDefaultOperation |
	return := OrderedCollection new.
	before ifNotNil:[ return add: (before apply: aRFOperation)].
	returnDefaultOperation := operation apply: aRFOperation.
	return add: returnDefaultOperation.
	after ifNotNil:[ return add: (before apply: aRFOperation)].
	^ returnDefaultOperation
]

{ #category : #initialization }
MOPInstrumentation >> initialize [

	operation := MOPDefaultOperation new.
	self requirement: MOPNoRequirement new
]

{ #category : #accessing }
MOPInstrumentation >> operation [

	^ operation
]

{ #category : #accessing }
MOPInstrumentation >> operation: anObject [

	operation := anObject
]

{ #category : #accessing }
MOPInstrumentation >> requirement [

	^ requirement
]

{ #category : #accessing }
MOPInstrumentation >> requirement: aRequirement [ 
	
	requirement := aRequirement 
]
