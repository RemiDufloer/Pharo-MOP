Class {
	#name : #Instrumentation,
	#superclass : #Object,
	#instVars : [
		'operations'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
Instrumentation >> operations [

	^ operations
]

{ #category : #accessing }
Instrumentation >> operations: aCollection [

	operations := aCollection 
]
