Class {
	#name : 'MOPInstrumentation',
	#superclass : 'Object',
	#instVars : [
		'operation',
		'before',
		'after',
		'requirement',
		'executing',
		'nodes'
	],
	#category : 'MetaObjectProtocol-base',
	#package : 'MetaObjectProtocol',
	#tag : 'base'
}

{ #category : 'adding' }
MOPInstrumentation >> addNode:  aNode [

	nodes add: aNode
]

{ #category : 'accessing' }
MOPInstrumentation >> after [

	^ after
]

{ #category : 'accessing' }
MOPInstrumentation >> after: anObject [

	after := anObject
]

{ #category : 'accessing' }
MOPInstrumentation >> before [

	^ before
]

{ #category : 'accessing' }
MOPInstrumentation >> before: anObject [

	before := anObject
]

{ #category : 'execution' }
MOPInstrumentation >> execute: aRFOperation [

	<debuggerCompleteToSender>
	| return returnDefaultOperation |
	"if the instrumentation is executing in other part we finish first the instrumentation before executing an other, so we return the default op"
	executing ifTrue: [
		^ aRFOperation value ].

	"set the execution to true for stop the instrumentation in this Operation"
	executing := true.

	return := OrderedCollection new.
	before ifNotNil: [
		return add: (before apply: aRFOperation with: return) ].
	returnDefaultOperation := operation apply: aRFOperation with: return.
	return add: returnDefaultOperation.
	after ifNotNil: [
		return add: (after apply: aRFOperation with: return) ].

	"set the execution to false for restart the instrumentation"
	executing := false.
	^ returnDefaultOperation
]

{ #category : 'accessing' }
MOPInstrumentation >> executing [

	^ executing
]

{ #category : 'initialization' }
MOPInstrumentation >> initialize [

	operation := MOPDefaultOperation new.
	self requirement: MOPNoRequirement new.
	executing := false
]

{ #category : 'accessing' }
MOPInstrumentation >> nodes [

	^ nodes

]

{ #category : 'accessing' }
MOPInstrumentation >> operation [

	^ operation
]

{ #category : 'accessing' }
MOPInstrumentation >> operation: anObject [

	operation := anObject
]

{ #category : 'accessing' }
MOPInstrumentation >> requirement [

	^ requirement
]

{ #category : 'accessing' }
MOPInstrumentation >> requirement: aRequirement [ 
	
	requirement := aRequirement 
]
