Class {
	#name : #MetaObjectProtocolTest,
	#superclass : #TestCase,
	#category : #MetaObjectProtocolTest
}

{ #category : #running }
MetaObjectProtocolTest >> tearDown [

	[ MetaLink uninstallAll ] on: Error do: [ :e | 
		e crTrace 
	]
]

{ #category : #tests }
MetaObjectProtocolTest >> testBeforeMessageSend [

	| object receiver selector arguments expectedArgument |
	object := MOPTestObject new.
	object mop beforeMessageSend: #exampleMethod: do: [ :op |
		receiver := op receiver.
		selector := op method selector.
		arguments := op arguments ].

	expectedArgument := Object new.
	object exampleMethod: expectedArgument.

	self assert: selector equals: #exampleMethod:.
	self assert: receiver equals: object.

	self assert: arguments size equals: 1.
	self assert: arguments first equals: expectedArgument
]

{ #category : #tests }
MetaObjectProtocolTest >> testProxyCreation [

	| object proxy result expectedArgument |

	object := Object new.
	proxy := MOPProxy new
		         metaObject: MOPTestObject new;
		         object: object;
		         yourself.
	expectedArgument := 'expected'.

	result := object exampleMethod: expectedArgument.

	self assert: result equals: expectedArgument
]
