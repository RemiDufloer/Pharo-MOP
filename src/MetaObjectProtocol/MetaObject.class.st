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
	(anInstrumentation requirement verify: anAstNode) ifTrue: [
		anAstNode link: (self installInstrumentationOn: anAstNode) ]
]

{ #category : #'as yet unclassified' }
MetaObject >> handle: aMessage on: aObject [

	^ MirrorPrimitives
		  withReceiver: aObject
		  perform: aMessage selector
		  withArguments: aMessage arguments asArray
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

{ #category : #'as yet unclassified' }
MetaObject >> on: aReceiver perform: aSelector withArguments: aArguments [

	^ MirrorPrimitives
		  withReceiver: aReceiver
		  perform: aSelector
		
		
		  withArguments: aArguments asArray
]
