Class {
	#name : 'MOPProtocol',
	#superclass : 'Object',
	#instVars : [
		'metaObject'
	],
	#classInstVars : [
		'mopRegistry'
	],
	#category : 'MetaObjectProtocol-base',
	#package : 'MetaObjectProtocol',
	#tag : 'base'
}

{ #category : 'adding' }
MOPProtocol >> addInstrumentation: anInstrumentation [ 

	metaObject addInstrumentation: anInstrumentation 
]

{ #category : 'accessing' }
MOPProtocol >> message [

	^ MOPMessageBuilder protocol: self
]

{ #category : 'accessing' }
MOPProtocol >> metaObject [
	^ metaObject
]

{ #category : 'accessing' }
MOPProtocol >> metaObject: aMOPMetaObject [

	metaObject := aMOPMetaObject 
]

{ #category : 'accessing' }
MOPProtocol >> method [

	^ MOPMethodBuilder protocol: self
]

{ #category : 'accessing' }
MOPProtocol >> variable [

	^ MOPVariableBuilder protocol: self
]
