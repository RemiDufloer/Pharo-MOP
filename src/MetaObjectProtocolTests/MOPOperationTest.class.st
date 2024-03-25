Class {
	#name : #MOPOperationTest,
	#superclass : #TestCase,
	#category : #MetaObjectProtocolTests
}

{ #category : #tests }
MOPOperationTest >> testApply [

	| operation value |
	
	operation := MOPBlockOperation block: [ :v | v + 2 ].
	value := 0.

	self assert: (operation apply: value) equals: 2
]

{ #category : #tests }
MOPOperationTest >> testApplyWithBadRequirement [

	| operation node requirement exepted |
	exepted := 'test'.
	node := RBVariableNode named: exepted.
	requirement := MOPNameVariableRequirement name: 'nil'.
	operation := MOPBlockOperation requirement: requirement   block: [ :v | v name: 'hello' ].

	operation apply: node.


	self assert: exepted equals: node name
]

{ #category : #tests }
MOPOperationTest >> testApplyWithGoodRequirement [

	| operation node requirement exepted |
	exepted := 'good'.
	node := RBVariableNode named: 'test'.
	requirement := MOPNameVariableRequirement name: 'test'.
	operation :=  MOPBlockOperation requirement: requirement block: [ :v | v name: exepted ].

	operation apply: node.


	self assert: exepted equals: node name
]
