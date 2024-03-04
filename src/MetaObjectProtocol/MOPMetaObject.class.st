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

{ #category : #accessing }
MOPMetaObject >> giveMethodAssociatedToMessage: aMessage [

	^ object class lookupSelector: aMessage selector.
]

{ #category : #'handling DNU' }
MOPMetaObject >> handle: aMessage [

	<debuggerCompleteToSender>
	self instrumentMethod: (self giveMethodAssociatedToMessage: aMessage).


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

{ #category : #instrument }
MOPMetaObject >> instrument: anASTNode [

	self instrumentations do: [ :inst | (inst requirement verify: anASTNode) ifTrue: [ inst installOnNode: anASTNode ] ]
]

{ #category : #instrument }
MOPMetaObject >> instrumentMethod: aMethode [

	aMethode ast allChildren do: [ :n |
		self instrumentations do: [ :inst | inst installOnNode: n ] ].
]

{ #category : #accessing }
MOPMetaObject >> instrumentations [

	^ instrumentations 
]

{ #category : #accessing }
MOPMetaObject >> object: anObject [
 
	object := anObject
]

{ #category : #accessing }
MOPMetaObject >> protocol [

	^ protocol
]
