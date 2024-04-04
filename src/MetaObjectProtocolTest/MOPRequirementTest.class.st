Class {
	#name : #MOPRequirementTest,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTest
}

{ #category : #tests }
MOPRequirementTest >> testRequirementCheckNameMethod [

	| requirement node result name |
	name := 'testMethod'.
	node := RBMethodNode selector: name.
	requirement := MOPSelectorNameRequirement name: name .
	

	result := requirement verify: node.

	self assert: result
]

{ #category : #tests }
MOPRequirementTest >> testRequirementCheckNameVariable [

	| requirement node result name |
	name := 'testVariable'.
	node := RBVariableNode named: name.
	requirement := MOPNameVariableRequirement name: name.
	

	result := requirement verify: node.

	self assert: result
]
