Class {
	#name : 'MOPVariableReadRequirement',
	#superclass : 'MOPRequirement',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'verifying' }
MOPVariableReadRequirement >> verify: anASTNode [

	^ anASTNode isInstanceVariable and:[ anASTNode isRead] .
	
	 
]
