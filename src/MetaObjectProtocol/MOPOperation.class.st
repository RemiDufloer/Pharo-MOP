Class {
	#name : #MOPOperation,
	#superclass : #Object,
	#instVars : [
		'requirement',
		'block'
	],
	#category : #'MetaObjectProtocol-Operation'
}

{ #category : #accessing }
MOPOperation >> apply: aRFOperation [

	self subclassResponsibility 
]

{ #category : #initialization }
MOPOperation >> initialize [ 

	self requirement: MOPNoRequirement new
]

{ #category : #accessing }
MOPOperation >> requirement [
	
	^ requirement 
]

{ #category : #accessing }
MOPOperation >> requirement: aRequirement [

	requirement := aRequirement
]
