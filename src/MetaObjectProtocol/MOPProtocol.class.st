Class {
	#name : #MOPProtocol,
	#superclass : #Object,
	#instVars : [
		'metaObject'
	],
	#classInstVars : [
		'mopRegistry'
	],
	#category : #MetaObjectProtocol
}

{ #category : #adding }
MOPProtocol >> addInstrumentation: anInstrumentation [ 

	metaObject addInstrumentation: anInstrumentation 
]

{ #category : #accessing }
MOPProtocol >> metaObject [
	^ metaObject
]

{ #category : #accessing }
MOPProtocol >> metaObject: aMOPMetaObject [

	metaObject := aMOPMetaObject 
]

{ #category : #'instance creation' }
MOPProtocol >> newInstrumentation [
	
	^ MOPInstrumentationBuilder new metaObject: self metaObject; yourself 
]
