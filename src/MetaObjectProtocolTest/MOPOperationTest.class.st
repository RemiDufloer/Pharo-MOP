Class {
	#name : #MOPOperationTest,
	#superclass : #TestCase,
	#category : #MetaObjectProtocolTest
}

{ #category : #tests }
MOPOperationTest >> testApply [

	| operation value |
	
	operation := BlockOperation block: [ :v | v + 2 ].
	value := 0.

	self assert: (operation apply: value) equals: 2
]

{ #category : #tests }
MOPOperationTest >> testApplyWithBadRequirement [

	| operation node requirement exepted |
	exepted := 'test'.
	node := RBVariableNode named: exepted.
	requirement := NameVariableRequirement name: 'nil'.
	operation := BlockOperation requirement: requirement   block: [ :v | v name: 'hello' ].

	operation apply: node.


	self assert: exepted equals: node name
]

{ #category : #tests }
MOPOperationTest >> testApplyWithGoodRequirement [

	| operation node requirement exepted |
	exepted := 'good'.
	node := RBVariableNode named: 'test'.
	requirement := NameVariableRequirement name: 'test'.
	operation :=  BlockOperation requirement: requirement block: [ :v | v name: exepted ].

	operation apply: node.


	self assert: exepted equals: node name
]
