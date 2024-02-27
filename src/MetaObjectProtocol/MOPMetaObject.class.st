Class {
	#name : #MOPMetaObject,
	#superclass : #Object,
	#instVars : [
		'instrumentations',
		'object'
	],
	#category : #MetaObjectProtocol
}

{ #category : #adding }
MOPMetaObject >> addInstrumentation: anInstrumentation on: anAstNode [

	instrumentations at: anAstNode put: anInstrumentation.
	(anInstrumentation requirement verify: anAstNode) ifTrue: [
		anAstNode link: (self installInstrumentationOn: anAstNode) ]
]

{ #category : #'as yet unclassified' }
MOPMetaObject >> handle: aMessage [

	^ MirrorPrimitives
		  withReceiver: object
		  perform: aMessage selector
		  withArguments: aMessage arguments asArray
]

{ #category : #initialization }
MOPMetaObject >> initialize [ 

	instrumentations := Dictionary  new
]

{ #category : #adding }
MOPMetaObject >> installInstrumentationOn: anAstNode [

	
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
MOPMetaObject >> instrumentations [

	^ instrumentations 
]

{ #category : #accessing }
MOPMetaObject >> object: anObject [

	| proxy |
	proxy := MOPProxy new.

	object become: proxy.

	MirrorPrimitives
		fieldOf: object
		at: (MOPProxy slotNamed: #metaObject) index
		put: self
]
