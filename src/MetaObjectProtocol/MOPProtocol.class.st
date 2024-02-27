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
MOPProtocol >> object: anObject [

	metaObject := MOPMetaObject new
		              object: anObject;
		              yourself
]
