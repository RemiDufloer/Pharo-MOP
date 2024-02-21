Class {
	#name : #Operation,
	#superclass : #Object,
	#instVars : [
		'requirement',
		'operation'
	],
	#category : #MetaObjectProtocol
}

{ #category : #creating }
Operation class >> operation: aRFOperation [

	^ self requirement: [ true ] apply: aRFOperation
]

{ #category : #creating }
Operation class >> requirement: aBlock apply: aRFOperation [

	^ self new
		  requirement: aBlock;
		  operation: aRFOperation;
		  yourself
]

{ #category : #accessing }
Operation >> apply: aRFOperation [

	requirement value ifTrue: [ ^ operation value: aRFOperation ]
]

{ #category : #accessing }
Operation >> operation: aBlock [

	operation := aBlock
]

{ #category : #accessing }
Operation >> requirement: aBlock [

	requirement := aBlock
]
