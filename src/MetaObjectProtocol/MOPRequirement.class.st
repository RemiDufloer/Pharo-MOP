"
Represents the conditions for the installation or launching of instrumentation on a node.

Responsibilities:
 * - Verify that from a given node, it satisfies the specified conditions for instrumentation installation or launch.
 * - Compose with other child classes to define complex instrumentation conditions.
 * - Provides the method 'verify' to check conditions on the given AST node.
 
Internal Representation and Key Implementation Points:
 * - Utilizes composition with child classes to define specific instrumentation conditions.
 * - Implements the 'verify' method to check conditions on the AST node.
 * - Encapsulates logic for condition verification within the class.

"
Class {
	#name : 'MOPRequirement',
	#superclass : 'Object',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'controlling' }
MOPRequirement class >> and: aRequirement [

	^ MOPAndRequirement left: self right: aRequirement 
]

{ #category : 'controlling' }
MOPRequirement >> and: aRequirement [ 
	
	^ MOPAndRequirement left: self right: aRequirement 
]

{ #category : 'controlling' }
MOPRequirement >> or: aRequirement [ 
	
	^ MOPOrRequirement left: self right: aRequirement  
]

{ #category : 'verifying' }
MOPRequirement >> verify: anASTNode [

	^ self subclassResponsibility 
]
