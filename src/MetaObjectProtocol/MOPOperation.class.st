"
Defines the behavior to be added to a node. It intercepts the base operation and decides whether to use it based on the desired behavior.

Responsibilities:
- Define additional behavior to be added to a node.
- Intercept the base operation and determine whether to utilize it based on the desired behavior.
- Provide the 'apply' method to execute the new behavior.

Public API and Key Messages:
 - apply: Executes the new behavior.

Internal Representation and Key Implementation Points:
 - Encapsulates logic for intercepting and applying behavior.
 - Utilizes MOPRequirement objects to define conditions for applying the behavior.
 - Implements the 'apply:' method to execute the new behavior.

"
Class {
	#name : 'MOPOperation',
	#superclass : 'Object',
	#instVars : [
		'requirement',
		'block'
	],
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPOperation >> apply: aRFOperation [

	^ self apply: aRFOperation with: OrderedCollection new.
]

{ #category : 'accessing' }
MOPOperation >> apply: aRFOperation with: anOrderedCollection [
   
	self subclassResponsibility
]

{ #category : 'initialization' }
MOPOperation >> initialize [ 

	self requirement: MOPNoRequirement new
]

{ #category : 'accessing' }
MOPOperation >> requirement [
	
	^ requirement 
]

{ #category : 'accessing' }
MOPOperation >> requirement: aRequirement [

	requirement := aRequirement
]
