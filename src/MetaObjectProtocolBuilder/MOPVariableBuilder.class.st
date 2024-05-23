Class {
	#name : 'MOPVariableBuilder',
	#superclass : 'MOPProtocolBuilder',
	#category : 'MetaObjectProtocolBuilder',
	#package : 'MetaObjectProtocolBuilder'
}

{ #category : 'meta-object-protocol' }
MOPVariableBuilder >> acces [

	self requirement: MOPVariableReadRequirement new
]

{ #category : 'meta-object-protocol' }
MOPVariableBuilder >> assigne [

	self requirement: MOPVariableAssignementRequirement new
]

{ #category : 'initialization' }
MOPVariableBuilder >> initialize [

	super initialize.
	instrumentation requirement:  MOPVariableRequirement new
]

{ #category : 'accessing' }
MOPVariableBuilder >> name: aString [

	self requirement: (MOPNameVariableRequirement name: aString)
]
