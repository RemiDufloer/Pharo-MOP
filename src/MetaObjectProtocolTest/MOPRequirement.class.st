Class {
	#name : #MOPRequirement,
	#superclass : #MOPTest,
	#category : #MetaObjectProtocolTest
}

{ #category : #tests }
MOPRequirement >> testRequirementCheckNameMethod [

	| requirement node result name |
	name := 'testMethod'.
	node := RBMethodNode selector: name.
	requirement := SelectorNameRequirement name: name .
	

	result := requirement verify: node.

	self assert: result
]

{ #category : #tests }
MOPRequirement >> testRequirementCheckNameVariable [

	| requirement node result name |
	name := 'testVariable'.
	node := RBVariableNode named: name.
	requirement := NameVariableRequirement name: name.
	

	result := requirement verify: node.

	self assert: result
]
