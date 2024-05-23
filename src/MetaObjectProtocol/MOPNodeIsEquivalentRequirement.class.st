Class {
	#name : 'MOPNodeIsEquivalentRequirement',
	#superclass : 'MOPRequirement',
	#instVars : [
		'node'
	],
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'accessing' }
MOPNodeIsEquivalentRequirement class >> node: aNode [

	^ self new
		node: aNode;
		yourself
]

{ #category : 'verifying' }
MOPNodeIsEquivalentRequirement >> node: aNode [

	node := aNode 
]

{ #category : 'verifying' }
MOPNodeIsEquivalentRequirement >> verify: anASTNode [

	^ anASTNode isEquivalentTo: node
]
