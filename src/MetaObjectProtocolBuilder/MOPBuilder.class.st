Class {
	#name : #MOPBuilder,
	#superclass : #Object,
	#instVars : [
		'instrumentationBuilder'
	],
	#category : #MetaObjectProtocolBuilder
}

{ #category : #accessing }
MOPBuilder >> instrumentationBuilder: anInstrumentationBuilder [

	instrumentationBuilder := anInstrumentationBuilder
]

{ #category : #'instance creation' }
MOPBuilder >> newOperation [
	
	^ OperationBuilder new instrumentationBuilder: instrumentationBuilder ; yourself
]

{ #category : #'API - remotes' }
MOPBuilder >> push [

	instrumentationBuilder push
]
