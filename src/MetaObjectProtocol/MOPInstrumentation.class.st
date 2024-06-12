Class {
	#name : 'MOPInstrumentation',
	#superclass : 'Object',
	#instVars : [
		'operation',
		'before',
		'after',
		'requirement',
		'executing',
		'propagate'
	],
	#category : 'MetaObjectProtocol-base',
	#package : 'MetaObjectProtocol',
	#tag : 'base'
}

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
	^ propagate ifTrue:[self executingOperation: aRFOperation ] ifFalse: [ self executingWithoutPropagation: aRFOperation ] 
	
]

{ #category : 'accessing' }
MOPInstrumentation >> executing [

	^ executing
]

{ #category : 'execution' }
MOPInstrumentation >> executingOperation: aRFOperation [

	<debuggerCompleteToSender>
	| return returnDefaultOperation |
	[
	return := OrderedCollection new.

	before ifNotNil: [
		return add: (before apply: aRFOperation with: return) ].
	returnDefaultOperation := operation apply: aRFOperation with: return.
	return add: returnDefaultOperation.
	after ifNotNil: [
		return add: (after apply: aRFOperation with: return) ] ] 
ensure: [
		executing := false ].
	"set the execution to false for restart the instrumentation if we are without propagation"
	
	^ returnDefaultOperation
]

{ #category : 'execution' }
MOPInstrumentation >> executingWithoutPropagation: aRFOperation [

"if the instrumentation is executing in other part we finish first the instrumentation before executing an other, so we return the default op"
	 executing ifTrue: [
		^ aRFOperation value ].
	"set the execution to true for stop the instrumentation in this Operation"
	executing := true.
	^ self executingOperation: aRFOperation
]

{ #category : 'initialization' }
MOPInstrumentation >> initialize [

	operation := MOPDefaultOperation new.
	self requirement: MOPNoRequirement new.
	executing := false.
	propagate := false.
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
MOPInstrumentation >> propagate: aBoolean [

	propagate := aBoolean .
]

{ #category : 'accessing' }
MOPInstrumentation >> requirement [

	^ requirement
]

{ #category : 'accessing' }
MOPInstrumentation >> requirement: aRequirement [ 
	
	requirement := aRequirement 
]
