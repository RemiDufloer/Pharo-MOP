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

	<debuggerCompleteToSender>

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
	proxy := MOPProxy basicNew.

	MirrorPrimitives
		fixedFieldOf: proxy
		at: (MOPProxy slotNamed: #metaObject) index
		put: self.

	anObject become: proxy.
	" 
	After the use of the ProtoObject >> #become primitive:
	- The references to the object are now pointing to the proxy.
	- And the references to the proxy are now pointing to the object.
	
	So, to store the object in an instance variable, we must affect it using the variable proxy. 
	"
	object := proxy
]
