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
