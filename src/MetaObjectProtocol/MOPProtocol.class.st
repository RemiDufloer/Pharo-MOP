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

{ #category : #accessing }
MOPProtocol >> metaObject [
	^ metaObject
]

{ #category : #accessing }
MOPProtocol >> metaObject: aMOPMetaObject [

	metaObject := aMOPMetaObject 
]
