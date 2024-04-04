Class {
	#name : #MOPInstrumentationBuilder,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'instrumentation'
	],
	#category : #MetaObjectProtocolBuilder
}

{ #category : #adding }
MOPInstrumentationBuilder >> addOperation: anOperation [ 
	
	self instrumentation operation: anOperation 
]

{ #category : #adding }
MOPInstrumentationBuilder >> before: anOperation [

	self instrumentation before: anOperation
]

{ #category : #initialization }
MOPInstrumentationBuilder >> initialize [ 

	instrumentation := MOPInstrumentation new.
]

{ #category : #accessing }
MOPInstrumentationBuilder >> instrumentation [

	^ instrumentation
]

{ #category : #accessing }
MOPInstrumentationBuilder >> metaObject [

	^ metaObject
]

{ #category : #accessing }
MOPInstrumentationBuilder >> metaObject: aMetaObject [

	metaObject := aMetaObject 

	
]

{ #category : #'instance creation' }
MOPInstrumentationBuilder >> newRequirementInstallation [
	
	^ MOPRequirementBuilder new instrumentationBuilder: self ; yourself
]

{ #category : #'API - remotes' }
MOPInstrumentationBuilder >> push [
	
	self metaObject addInstrumentation: instrumentation 
]

{ #category : #accessing }
MOPInstrumentationBuilder >> requirement: aRequirement [ 
	
	instrumentation requirement: aRequirement 
]
