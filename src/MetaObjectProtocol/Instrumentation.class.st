Class {
	#name : #Instrumentation,
	#superclass : #Object,
	#instVars : [
		'operations'
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

	operations := OrderedCollection new
]

{ #category : #accessing }
Instrumentation >> operations [

	^ operations
]

{ #category : #accessing }
Instrumentation >> removeOperation: anOperation [

	operations remove: anOperation 
]
