Class {
	#name : #MOPProtocol,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#classInstVars : [
		'mopRegistry'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
MOPProtocol class >> mopAt: anObject [ 

	^ self mopRegistry at: anObject hash ifAbsentPut: [ self new onObject: anObject ] 
]

{ #category : #accessing }
MOPProtocol class >> mopRegistry [

	^ mopRegistry ifNil: [ mopRegistry := WeakKeyDictionary new ]
]

{ #category : #'instance creation' }
MOPProtocol class >> onObject: anObject [
	
	^ self new object: anObject .
]

{ #category : #api }
MOPProtocol >> beforeMessageSend: aMessage do: aBlock [

	| method ast |
	method := object class methodNamed: aMessage.
	ast := method ast.
	ast link: (self installLinkForMessageSendDo: aBlock)
	"messageSendNode do: [ :node |
		node link: ( self installLinkForMessageSendDo: aBlock ) ]"
]

{ #category : #'links - installing' }
MOPProtocol >> installLinkForMessageSendDo: aBlock [

	| link |
	link := MetaLink new.
	link control: #instead.

	link metaObject: aBlock.
	link selector: #value:.
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #accessing }
MOPProtocol >> object: anObject [

	object := anObject
]
