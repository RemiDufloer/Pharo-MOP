Class {
	#name : #MOPVariableReadRequirement,
	#superclass : #MOPRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #verifying }
MOPVariableReadRequirement >> verify: anASTNode [

	^ anASTNode isInstanceVariable and:[ anASTNode isRead] .
	
	 
]
