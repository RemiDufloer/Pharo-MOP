Class {
	#name : 'MOPNodeBuilder',
	#superclass : 'MOPProtocolBuilder',
	#category : 'MetaObjectProtocolBuilder',
	#package : 'MetaObjectProtocolBuilder'
}

{ #category : 'meta-object-protocol' }
MOPNodeBuilder >> checkNode: aNode [

	self requirement: ( MOPNodeIsEquivalentRequirement node: aNode )
]

{ #category : 'initialization' }
MOPNodeBuilder >> initialize [

	super initialize.
	instrumentation requirement:  MOPNoRequirement new
]
