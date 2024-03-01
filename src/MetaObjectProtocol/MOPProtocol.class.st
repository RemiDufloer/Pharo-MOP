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
MOPProtocol >> addInstrumentation: anInstrumentation on: anASTNode [

	metaObject addInstrumentation:  anInstrumentation  on: anASTNode 
]

{ #category : #accessing }
MOPProtocol >> metaObject [
	^ metaObject
]

{ #category : #accessing }
MOPProtocol >> metaObject: aMOPMetaObject [

	metaObject := aMOPMetaObject 
]
