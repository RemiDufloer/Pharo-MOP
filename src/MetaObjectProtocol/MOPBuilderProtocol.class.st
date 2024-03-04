Class {
	#name : #MOPBuilderProtocol,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'instrumentation'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
MOPBuilderProtocol >> instrumentation [

	^ instrumentation
]

{ #category : #accessing }
MOPBuilderProtocol >> instrumentation: anObject [

	instrumentation := anObject
]

{ #category : #accessing }
MOPBuilderProtocol >> metaObject [

	^ metaObject
]

{ #category : #accessing }
MOPBuilderProtocol >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #'instance creation' }
MOPBuilderProtocol >> newOperation [

	^ OperationBuilder new instrumentation: self instrumentation; yourself

	
]
