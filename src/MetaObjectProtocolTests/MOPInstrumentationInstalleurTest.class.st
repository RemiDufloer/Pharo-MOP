Class {
	#name : 'MOPInstrumentationInstalleurTest',
	#superclass : 'TestCase',
	#instVars : [
		'instrumenter',
		'testObject'
	],
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'helpers' }
MOPInstrumentationInstalleurTest >> receive: selector [
	^testObject perform: selector
]

{ #category : 'tests' }
MOPInstrumentationInstalleurTest >> setUp [
	super setUp.
	instrumenter := MOPInstrumentationInstaller new.
	testObject := Object new
]

{ #category : 'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testCompileEmptySuperSendChain [

	self assertEmpty: (instrumenter compileSuperSendChain: #(  ))
]

{ #category : 'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testCompileSuperSendChain [

	| chain compiledSelectors |
	self flag: 'bizarre de test comme ca car on a pas la classe ano ici'.
	testObject := MOPBottom new.
	instrumenter object: testObject.

	chain := {
		         (MOPBottom >> #mWithSuper).
		         (MOPMiddle >> #mWithSuper).
		         (MOPTop >> #mWithSuper) }.
	compiledSelectors := instrumenter compileSuperSendChain: chain asOrderedCollection .

	self assert: compiledSelectors size equals: chain size.
	self assert: compiledSelectors firstLink value equals: #mWithSuper.
	self assert: compiledSelectors firstLink nextLink value equals: #_1_mWithSuper.
	self assert: compiledSelectors firstLink nextLink nextLink value equals: #_2_mWithSuper.

	self
		assert:
		(testObject class >> compiledSelectors first) ast body sourceCode
		equals: (MOPBottom >> #mWithSuper) ast body sourceCode.
	self
		assert:
		(testObject class >> compiledSelectors firstLink nextLink value) ast body sourceCode
		equals: (MOPMiddle >> #mWithSuper) ast body sourceCode.
	self
		assert:
		(testObject class >> compiledSelectors firstLink nextLink nextLink value) ast body sourceCode
		equals: (MOPTop >> #mWithSuper) ast body sourceCode
]

{ #category : 'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testCompileSuperSendChainWithoutSuper [

	| chain compiledSelectors |
	self flag: 'bizarre de test comme ca car on a pas la classe ano ici'.
	testObject := MOPBottom new.
	instrumenter object: testObject.

	chain := { (MOPBottom >> #mWithSuper) }.
	compiledSelectors := instrumenter compileSuperSendChain: chain asOrderedCollection .

	self assert: compiledSelectors size equals: chain size.
	self assert: compiledSelectors first equals: #mWithSuper.

	self
		assert: (testObject class >> compiledSelectors first) sourceCode
		equals: (MOPBottom >> #mWithSuper) sourceCode
]

{ #category : 'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testFindSuperSendsChainFor [

	| method chain |
	instrumenter object: MOPBottom new.

	"Case 1: the method is reachable from Bub instances but has no super calls"
	"method := MOPMiddle >> #superUpToMiddleHierarchy.
	chain := instrumenter findSuperSendsChainFor: method.
	self assert: chain size equals: 2.
	self
		assert: chain first
		identicalTo: MOPBottom >> #superUpToMiddleHierarchy.
	self
		assert: chain last
		identicalTo: MOPMiddle >> #superUpToMiddleHierarchy.
	"
	"Case 2: the method is reachable from Bub instances and calls super up to Object"
	method := MOPMiddle >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.
	self assert: chain size equals: 2.
	self assert: chain first  identicalTo: MOPMiddle >> #mWithSuper.
	self assert: chain second identicalTo: MOPTop >> #mWithSuper.

	"Case 2 variant"
	method := MOPBottom >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.
	self assert: chain size equals: 3.
	self assert: chain first identicalTo: MOPBottom >> #mWithSuper.
	self assert: chain second identicalTo: MOPMiddle >> #mWithSuper.
	self assert: chain last identicalTo: MOPTop >> #mWithSuper
]

{ #category : 'tests' }
MOPInstrumentationInstalleurTest >> testInstrumentedClass [

	instrumenter object: testObject.
	self
		assert: instrumenter object class
		identicalTo: testObject class
]

{ #category : 'tests' }
MOPInstrumentationInstalleurTest >> testIntrumentationOfNotExistingMessage [

	| object |
	object := MOPTestObject new.
	object mop.

	self
		should: [
			
			object notExistingMessage ]
		raise: MessageNotUnderstood
]
