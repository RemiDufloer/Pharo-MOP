Class {
	#name : #MOPInstrumentationInstalleurTest,
	#superclass : #TestCase,
	#instVars : [
		'instrumenter',
		'testObject'
	],
	#category : #MetaObjectProtocolTests
}

{ #category : #helpers }
MOPInstrumentationInstalleurTest >> receive: selector [
	^testObject perform: selector
]

{ #category : #tests }
MOPInstrumentationInstalleurTest >> setUp [
	super setUp.
	instrumenter := MOPInstrumentationInstalleur for: self.
	testObject := Object new
]

{ #category : #tests }
MOPInstrumentationInstalleurTest >> testBeForObject [
	
	instrumenter beForObject: testObject.
	self assert: instrumenter instrumentedObject identicalTo: testObject.
	self assert: instrumenter instrumentedClass identicalTo: testObject class.
	self assert: instrumenter instrumentedClass isAnonymous.
	self assert: instrumenter instrumentedClass superclass identicalTo: Object.
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testBuildSuperSendsChainFromSourceMethodToHighestMethodInClassHierarchy [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := MOPBottom >> #mWithSuper.
	targetMethod := MOPTop >> #mWithSuper.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: nil in: chain.	
	
	self assert: chain size equals: 2.
	self assert: chain first identicalTo: sourceMethod.
	self assert: chain last identicalTo: (MOPMiddle >> #mWithSuper).
	self assert: lastFoundMethod identicalTo: targetMethod

	
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testBuildSuperSendsChainFromSourceMethodToTargetMethod [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := MOPBottom >> #mWithSuper.
	targetMethod := MOPMiddle >> #mWithSuper.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: targetMethod in: chain.	
	
	self assert: chain size equals: 1.
	self assert: chain first identicalTo: sourceMethod.
	self assert: lastFoundMethod identicalTo: targetMethod

	
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testBuildSuperSendsChainFromSourceMethodToTargetMethodFailure [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := MOPBottom >> #superUpToMiddleHierarchy.
	targetMethod := MOPTop >> #superUpToMiddleHierarchy.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: targetMethod in: chain.	
	self deny: lastFoundMethod identicalTo: targetMethod
	

]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testCompileEmptySuperSendChain [

	self assertEmpty: (instrumenter compileSuperSendChain: #(  ))
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testCompileSuperSendChain [

	|chain compiledSelectors|
	testObject := MOPBottom new.
	instrumenter beForObject: testObject.
	 
	chain := {MOPBottom >> #mWithSuper. MOPMiddle >> #mWithSuper. MOPTop >> #mWithSuper  }.
	compiledSelectors := instrumenter compileSuperSendChain: chain.
	
	self assert: compiledSelectors size equals: chain size.
	self assert: compiledSelectors first equals: #mWithSuper.
	self assert: compiledSelectors second equals: #_2_mWithSuper.
	self assert: compiledSelectors third equals: #_3_mWithSuper.
	
	self assert: (instrumenter compiledSelectorsMap at: compiledSelectors first) equals: compiledSelectors second.
	self assert: (instrumenter compiledSelectorsMap at: compiledSelectors second) equals: compiledSelectors third.
	self should: [(instrumenter compiledSelectorsMap at: compiledSelectors third)] raise: KeyNotFound.
	
	self assert: (testObject class >> compiledSelectors first) ast body sourceCode equals: (MOPBottom >> #mWithSuper) ast body sourceCode.
	self assert: (testObject class >> compiledSelectors second) ast body sourceCode equals: (MOPMiddle >> #mWithSuper) ast body sourceCode.
	self assert: (testObject class >> compiledSelectors third) ast body sourceCode equals: (MOPTop >> #mWithSuper) ast body sourceCode.
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testCompileSuperSendChainWithoutSuper [

	|chain compiledSelectors|
	testObject := MOPBottom new.
	instrumenter beForObject: testObject.

	chain := {MOPBottom >> #mWithSuper}.
	compiledSelectors := instrumenter compileSuperSendChain: chain.
	
	self assert: compiledSelectors size equals: chain size.
	self assert: compiledSelectors first equals: #mWithSuper.
	
	self assertEmpty: (instrumenter compiledSelectorsMap).
	
	self assert: (testObject class >> compiledSelectors first) sourceCode equals: (MOPBottom >> #mWithSuper) sourceCode
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testFindEmptySuperSendsChainFor [

	|method chain|	
	"Case 1: the method is not reachable from Bib instances"
	instrumenter beForObject: MOPMiddle new.
	method := MOPBottom >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assertEmpty: chain.
	
	"Case 2: the method is not reachable from Bub instances"
	instrumenter beForObject: MOPBottom new.
	method := MOPMiddle >> #redefineNoSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assertEmpty: chain
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testFindSuperSendsChainFor [

	|method chain|	
	
	instrumenter beForObject: MOPBottom new.
	
	"Case 1: the method is reachable from Bub instances but has no super calls"
	method := MOPMiddle >> #superUpToMiddleHierarchy.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 2.
	self assert: chain first identicalTo: (MOPBottom >> #superUpToMiddleHierarchy).
	self assert: chain last identicalTo: (MOPMiddle >> #superUpToMiddleHierarchy).
	
	"Case 2: the method is reachable from Bub instances and calls super up to Object"
	method := MOPMiddle >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 3.
	self assert: chain first identicalTo: (MOPBottom >> #mWithSuper).
	self assert: chain second identicalTo: (MOPMiddle >> #mWithSuper).
	self assert: chain last identicalTo: (MOPTop >> #mWithSuper).
	
	"Case 2 variant"
	method := MOPBottom >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 3.
	self assert: chain first identicalTo: (MOPBottom >> #mWithSuper).
	self assert: chain second identicalTo: (MOPMiddle >> #mWithSuper).
	self assert: chain last identicalTo: (MOPTop >> #mWithSuper).
]

{ #category : #tests }
MOPInstrumentationInstalleurTest >> testInstantiation [

	self assert: instrumenter metaObject identicalTo: self
]

{ #category : #tests }
MOPInstrumentationInstalleurTest >> testInstrumentedClass [

	instrumenter beForObject: testObject.
	self
		assert: instrumenter instrumentedClass
		identicalTo: testObject class
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testIsMethodReachableInHierarchy [
	
	|method|
	instrumenter beForObject: MOPMiddle new.
	self assert: (instrumenter isClassReachableInHierarchy: MOPMiddle).
	
	method := MOPBottom >> #mWithSuper.	
	self deny: (instrumenter isClassReachableInHierarchy: method methodClass).
	
	method := MOPTop >> #mWithSuper.
	self assert: (instrumenter isClassReachableInHierarchy: method methodClass).
	

	
]

{ #category : #tests }
MOPInstrumentationInstalleurTest >> testNewLinkForSelector [
	|link interceptor|
	link := instrumenter newLinkForSelector: #selector.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #execute.
	self assertEmpty: link arguments.
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector.
	self assert: interceptor metaObject equals: instrumenter metaObject.

	
	link := instrumenter newLinkForSelector: #selector:.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #executeWithArgs:.
	self assert: link arguments equals: #(arguments).
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector:.
	self assert: interceptor metaObject equals: instrumenter metaObject

	
]

{ #category : #tests }
MOPInstrumentationInstalleurTest >> testOriginalClass [

	instrumenter beForObject: testObject.
	self assert: instrumenter originalClass identicalTo: Object
]

{ #category : #'tests - instrumentation' }
MOPInstrumentationInstalleurTest >> testRedirectSuperSendsInToSelector [
	|ast superSendNode result|

	testObject := MOPBottom new.
	instrumenter beForObject: testObject.
	testObject class compile: (MOPBottom>>#mWithSuper) sourceCode.
	testObject class compile: 'testSelector x := 42. ^x'.
	ast := (testObject class>>#mWithSuper) ast.
	superSendNode := (ast sendNodes select: [ :node | node receiver isSuperVariable ]) first.
		
	instrumenter redirectSuperSendsIn: ast toSelector: #testSelector.
	
	self assert: superSendNode links notEmpty.
	
	result := testObject mWithSuper.	
	self assert: result equals: 43.
	self assert: testObject x equals: 42
]

{ #category : #'tests - method flattening' }
MOPInstrumentationInstalleurTest >> testSuperChainMethodWriteInAnonymousClassWhenInstrumentMethod [

	| testObjectClass result op instrumentation |
	testObject := MOPBottom new.
	testObjectClass := testObject class.
	instrumenter beForObject: testObject.
	result := 0.
	op := MOPBlockOperation block: [ :o | result := result + 1 ].
	instrumentation := MOPInstrumentation new addOperation: op.
	instrumentation requirement:
		(MOPSelectorNameRequirement name: 'mWithSuper').


	self should: [ testObject class >> #mWithSuper ] raise: KeyNotFound.
	self should: [ testObject class >> #_2_mWithSuper ] raise: KeyNotFound.
	self should: [ testObject class >> #_3_mWithSuper ] raise: KeyNotFound.
	
	instrumenter install: instrumentation  onMethod: (testObjectClass >> #mWithSuper) .
	
	self assert: (testObject class methodDict keys includes:  #mWithSuper)  .
	self assert: (testObject class methodDict keys includes:  #_2_mWithSuper).
	self assert: (testObject class methodDict keys includes:  #_3_mWithSuper).
	

]
