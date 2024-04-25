Class {
	#name : #MOPBottom,
	#superclass : #MOPMiddle,
	#instVars : [
		'var1'
	],
	#category : #MetaObjectProtocolTests
}

{ #category : #'as yet unclassified' }
MOPBottom >> _2_mWithSuper [

	^ super mWithSuper + 2
]

{ #category : #'as yet unclassified' }
MOPBottom >> _3_mWithSuper [

	^ self index
]

{ #category : #assignments }
MOPBottom >> assignmentTest [
	var1 := 4 squared.
]

{ #category : #'as yet unclassified' }
MOPBottom >> escapeWithSelf [

	var1 := 12.
	^ self
]

{ #category : #'as yet unclassified' }
MOPBottom >> escapeWithoutSelf [

	var1 := 12.

]

{ #category : #'as yet unclassified' }
MOPBottom >> mWithSuper [

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
