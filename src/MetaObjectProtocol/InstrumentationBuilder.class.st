Class {
	#name : #InstrumentationBuilder,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'instrumentation'
	],
	#category : #MetaObjectProtocol
}

{ #category : #adding }
InstrumentationBuilder >> addOperation: anOperation [ 
	
	self instrumentation addOperation: anOperation 
]

{ #category : #initialization }
InstrumentationBuilder >> initialize [ 

	instrumentation := Instrumentation new.
]

{ #category : #accesing }
InstrumentationBuilder >> instrumentation [

	^ instrumentation
]

{ #category : #accessing }
InstrumentationBuilder >> metaObject [

	^ metaObject
]

{ #category : #accessing }
InstrumentationBuilder >> metaObject: aMetaObject [

	metaObject := aMetaObject 

	
]

{ #category : #'instance creation' }
InstrumentationBuilder >> newRequirementInstallation [
	
	^ RequirementBuilder new instrumentationBuilder: self ; yourself
]

{ #category : #'API - remotes' }
InstrumentationBuilder >> push [
	
	self metaObject addInstrumentation: instrumentation 
]

{ #category : #accessing }
InstrumentationBuilder >> requirement: aRequirement [ 
	
	instrumentation requirement: aRequirement 
]
