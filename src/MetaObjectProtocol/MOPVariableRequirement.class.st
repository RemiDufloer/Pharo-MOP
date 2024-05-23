Class {
	#name : 'MOPVariableRequirement',
	#superclass : 'MOPRequirement',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'accessing' }
MOPVariableRequirement class >> name: aString [

	^ self new name: aString 
]

{ #category : 'verifying' }
MOPVariableRequirement >> verify: anASTNode [

	^ (MOPOrRequirement
		   left: (MOPVariableReadRequirement  new)
		   right: (MOPVariableAssignementRequirement new))
		  verify: anASTNode
]
