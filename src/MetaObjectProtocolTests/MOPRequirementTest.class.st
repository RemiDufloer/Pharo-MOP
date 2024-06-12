Class {
	#name : 'MOPRequirementTest',
	#superclass : 'MOPTest',
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'tests' }
MOPRequirementTest >> testRequirementCheckNameMethod [

	| requirement node result name |
	name := 'testMethod'.
	node := RBMethodNode selector: name.
	requirement := MOPSelectorNameRequirement name: name .
	

	result := requirement verify: node.

	self assert: result
]
