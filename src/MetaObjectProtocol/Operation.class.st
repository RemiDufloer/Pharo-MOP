Class {
	#name : #Operation,
	#superclass : #Object,
	#instVars : [
		'requirement',
		'apply'
	],
	#category : #MetaObjectProtocol
}

{ #category : #creating }
Operation class >> apply: aRFOperation [

	^ self requirement: [ true ] apply: aRFOperation
]

{ #category : #creating }
Operation class >> requirement: aBlock apply: aRFOperation [

	^ self new
		  requirement: aBlock;
		  apply: aRFOperation;
		  yourself
]

{ #category : #accessing }
Operation >> apply [

	requirement value ifTrue: [ ^ apply ]
]

{ #category : #accessing }
Operation >> apply: aRFOperation [

	apply := aRFOperation 
]

{ #category : #accessing }
Operation >> requirement: aBlock [

	requirement := aBlock
]
