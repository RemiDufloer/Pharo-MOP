"
I instrument the methods of a proxified object with metalinks.
My metalinks will redirect all self references (in parameters, message sends receivers, return nodes) to my meta-object who will perform a (set of) reflective action(s).

Currently, I am not in a final shape, for instance:
- my instrumentation API my change
- my instrumentation implementation may change
- I should be composeable depending on the object-centric instrumentation that is required (_e.g._, if two object-centric operations of different nature are demanded) 
"
Class {
	#name : #ROCProxyInstrumenter,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'instrumentedMessages',
		'instrumentedObject',
		'instrumentedClass',
		'compiledSelectorsMap'
	],
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
ROCProxyInstrumenter class >> for: aRFProxyMetaObject [

	^ self new
		  metaObject: aRFProxyMetaObject;
		  yourself
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> instrumentMethod: method selector: selector [

	| newMethod methodsToInstrument compiledSelectors |
	methodsToInstrument := self findSuperSendsChainFor: method.
	self flag:
		'Odd: can it really be empty? what about the method passed as paramter?'.
	methodsToInstrument isEmpty ifTrue: [ ^ self ].

	instrumentedMessages add: selector.
	compiledSelectors := self compileSuperSendChain: methodsToInstrument.

	compiledSelectors do: [ :cs | 
		| ast |
		ROCMetaObject log: 'Instrumenting: ' , cs printString.
		newMethod := instrumentedClass >> cs.
		ast := newMethod ast.
		"self redirectSelfArgsIn: ast."  "link for selector instead with Nil"
		self redirectMessagesSendIn: ast.
		self redirectSelfReturnsIn: ast. "link for selector after with Nil"
		self redirectVariableReadingIn: ast.
		self redirectVariableWritingIn: ast.

		self compiledSelectorsMap
			at: cs
			ifPresent: [ :redirectionSelector | 
				self redirectSuperSendsIn: ast toSelector: redirectionSelector "link for selector" ] ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> instrumentSelector: selector withArgs: args [

	| method |
	(self instrumentedMessages includes: selector) ifTrue: [ 
		ROCMetaObject log:
			'selector already instrumented: ' , selector printString.
		self flag:
			'Later we should compose instrumentation: inst var accesses, object-interaction, etc.'.
		^ self ].
	method := instrumentedClass lookupSelector: selector.
	method isPrimitive ifTrue: [ 
		method primitive = 188 ifTrue: [ 			
			method := args second.
			ROCMetaObject log: 'Primitive ' , method printString.
			self instrumentMethod: method selector: method selector.
			args removeLast.
			args addLast: (instrumentedClass lookupSelector: method selector)  ].
		^ self ].
	self instrumentMethod: method selector: selector.
	
]

{ #category : #links }
ROCProxyInstrumenter >> newInsteadLinkForAssignments [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := ROCVariableWriteInterceptor new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	link selector: #execute:.
	link arguments: #( operation ).
	"link selector: #execute:withValue:.
	link arguments: #( name value )."
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
ROCProxyInstrumenter >> newInsteadLinkForMessagesSend [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := ROCMessageSendInterceptor new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	link selector: #execute:.
	link arguments: #( operation ).
	"link arguments: #( selector receiver arguments value ).
	link optionArgsAsArray: true."
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
ROCProxyInstrumenter >> newInsteadLinkForVariableRead [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := ROCVariableReadInterceptor new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	"link selector: #execute:.
	link arguments: #( operation )."
	link selector: #execute:withValue:.
	link arguments: #( name value).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
ROCProxyInstrumenter >> newLinkForSelector: selector [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.
	
	interceptor := ROCMessageInterceptor new.
	interceptor selector: selector.
	interceptor metaObject: metaObject.
	
	link metaObject: interceptor.
	(selector notNil and: [selector isKeyword])
		ifTrue: [ 
			link selector: #executeWithArgs:.
			link arguments: #( arguments )]
		ifFalse: [ link selector: #execute ].

	link optionCompileOnLinkInstallation: true.
"	link level: 0."
	^ link
]
