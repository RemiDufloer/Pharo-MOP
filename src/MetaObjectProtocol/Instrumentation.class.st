Class {
	#name : #Instrumentation,
	#superclass : #Object,
	#instVars : [
		'operations',
		'requirement'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
Instrumentation >> addOperation: anOperation [

	operations add: anOperation 
]

{ #category : #execution }
Instrumentation >> execute: aRFOperation [

	^ operations do:[ :o | o apply: aRFOperation ]
]

{ #category : #accessing }
Instrumentation >> initialize [

	operations := OrderedCollection new.
	self requirement: NoRequirement new
	
]

{ #category : #accessing }
Instrumentation >> operations [

	^ operations
]

{ #category : #accessing }
Instrumentation >> removeOperation: anOperation [

	operations remove: anOperation 
]

{ #category : #accessing }
Instrumentation >> requirement [

	^ requirement
]

{ #category : #accessing }
Instrumentation >> requirement: aRequirement [ 
	
	requirement := aRequirement 
]
