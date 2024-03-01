Class {
	#name : #MOPMetaObject,
	#superclass : #Object,
	#instVars : [
		'instrumentations',
		'object',
		'protocol'
	],
	#category : #MetaObjectProtocol
}

{ #category : #adding }
MOPMetaObject >> addInstrumentation: anInstrumentation [ 
	

	instrumentations add: anInstrumentation.
]

{ #category : #adding }
MOPMetaObject >> addInstrumentation: anInstrumentation on: anAstNode [

	instrumentations at: anAstNode put: anInstrumentation.
	(anInstrumentation requirement verify: anAstNode) ifTrue: [
		anAstNode link: (self installInstrumentationOn: anAstNode) ]
]

{ #category : #'as yet unclassified' }
MOPMetaObject >> handle: aMessage [

	<debuggerCompleteToSender>
	(aMessage receiver class methodNamed: aMessage selector) ast
		allChildren do: [ :n |
		self instrumentations do: [ :inst | inst installOnNode: n ] ].


	^ MirrorPrimitives
		  withReceiver: object
		  perform: aMessage selector
		  withArguments: aMessage arguments asArray
]

{ #category : #initialization }
MOPMetaObject >> initialize [

	object := Object new.

	protocol := MOPProtocol new.
	protocol metaObject: self.

	instrumentations := OrderedCollection new
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

{ #category : #'as yet unclassified' }
MOPMetaObject >> instrument: anASTNode [

	self instrumentations do: [ :inst | (inst requirement verify: anASTNode) ifTrue: [ inst installOnNode: anASTNode ] ]
]

{ #category : #accessing }
MOPMetaObject >> instrumentations [

	^ instrumentations 
]

{ #category : #accessing }
MOPMetaObject >> object: anObject [
 
	object := anObject
]

{ #category : #'as yet unclassified' }
MOPMetaObject >> protocol [

	^ protocol
]
