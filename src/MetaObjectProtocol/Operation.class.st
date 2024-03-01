Class {
	#name : #Operation,
	#superclass : #Object,
	#instVars : [
		'requirement',
		'block'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
Operation >> apply: aRFOperation [

	self subclassResponsibility 
]

{ #category : #accessing }
Operation >> requirement [
	
	^ requirement 
]

{ #category : #accessing }
Operation >> requirement: aRequirement [

	requirement := aRequirement
]
