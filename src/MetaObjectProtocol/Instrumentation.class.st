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

{ #category : #'message performing' }
Instrumentation >> perform: aRFOperation [

	operations do:[ :o | o apply]
]

{ #category : #'message performing' }
Instrumentation >> value: aRFOperation [
	^ operations do:[ :o | o apply: aRFOperation  ] 
]
