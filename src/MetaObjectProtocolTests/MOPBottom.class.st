Class {
	#name : #MOPBottom,
	#superclass : #MOPMiddle,
	#instVars : [
		'var1'
	],
	#category : #MetaObjectProtocolTests
}

{ #category : #assignments }
MOPBottom >> assignmentTest [
	var1 := 4 squared.
]

{ #category : #'as yet unclassified' }
MOPBottom >> mWithSuper [

	'bottom' traceCr.
	(super mWithSuper + 1) asString crTrace.
	^ super mWithSuper + 1
]

{ #category : #'as yet unclassified' }
MOPBottom >> redefineNoSuper [
	^1
]

{ #category : #'as yet unclassified' }
MOPBottom >> superUpToMiddleHierarchy [
	"I call super"
	^ super superUpToMiddleHierarchy + 1
]

{ #category : #accessing }
MOPBottom >> var1 [

	^ var1
]

{ #category : #accessing }
MOPBottom >> var1: anObject [

	var1 := anObject
]
