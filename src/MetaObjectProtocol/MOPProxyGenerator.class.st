Class {
	#name : #MOPProxyGenerator,
	#superclass : #Object,
	#instVars : [
		'metaObject'
	],
	#category : #MetaObjectProtocol
}

{ #category : #initialization }
MOPProxyGenerator class >> generate [

	<script: 'self generate'>
	| proxyClass |
	Object
		subclass: #MOPProxy
		instanceVariableNames: 'metaObject'
		classVariableNames: ''
		package: 'MetaObjectProtocol'.

	proxyClass := Smalltalk environment at: #MOPProxy.

	Object allMethods do: [ :m |
		| ast |
		ast := MOPProxyMethodVisitor new visit: m ast copy.
		proxyClass compile: ast formattedCode ].

	self methods do: [ :m |
		proxyClass addSelector: m selector withMethod: m ]
]
