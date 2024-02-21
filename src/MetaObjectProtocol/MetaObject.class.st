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
	self installInstrumentationOn: anAstNode .
]

{ #category : #initialization }
MetaObject >> initialize [ 

	instrumentations := Dictionary  new
]

{ #category : #adding }
MetaObject >> installInstrumentationOn: anAstNode [

	(instrumentations at: anAstNode) operations do: [ :operation | self installOperation: operation on: anAstNode  ]
]

{ #category : #adding }
MetaObject >> installLinkWithOperation: AnOperation [

	| link |
	link := MetaLink new.
	link control: #instead.

	link metaObject: AnOperation apply.
	link selector: #value:.
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #adding }
MetaObject >> installOperation: anOperation on: anAstNode [ 

	anAstNode link: (self installLinkWithOperation: anOperation)
]

{ #category : #initialization }
MetaObject >> instrumentations [

	^ instrumentations 
]
