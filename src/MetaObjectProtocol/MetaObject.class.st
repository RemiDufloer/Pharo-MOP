Class {
	#name : #MetaObject,
	#superclass : #Object,
	#instVars : [
		'instrumentations'
	],
	#category : #MetaObjectProtocol
}

{ #category : #adding }
MetaObject >> addInstrumentation: anInstrumentation on: anAstNode [

	instrumentations at: anAstNode put: anInstrumentation.
	(anInstrumentation requirement allRequirementVerify: anAstNode) ifTrue: [
		anAstNode link: (self installInstrumentationOn: anAstNode) ]
]

{ #category : #initialization }
MetaObject >> initialize [ 

	instrumentations := Dictionary  new
]

{ #category : #adding }
MetaObject >> installInstrumentationOn: anAstNode [

	
	| link |
	link := MetaLink new.
	link control: #instead.

	link metaObject: (instrumentations at: anAstNode) .
	link selector: #execute:.
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #accessing }
MetaObject >> instrumentations [

	^ instrumentations 
]
