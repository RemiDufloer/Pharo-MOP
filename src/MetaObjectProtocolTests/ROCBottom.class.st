Class {
	#name : #ROCBottom,
	#superclass : #ROCMiddle,
	#instVars : [
		'var1'
	],
	#category : #MetaObjectProtocolTests
}

{ #category : #assignments }
ROCBottom >> assignmentTest [
	var1 := 4 squared.
]

{ #category : #'as yet unclassified' }
ROCBottom >> mWithSuper [
	^super mWithSuper + 1
]

{ #category : #'as yet unclassified' }
ROCBottom >> redefineNoSuper [
	^1
]

{ #category : #'as yet unclassified' }
ROCBottom >> superUpToMiddleHierarchy [
	"I call super"
	^ super superUpToMiddleHierarchy + 1
]

{ #category : #accessing }
ROCBottom >> var1 [

	^ var1
]

{ #category : #accessing }
ROCBottom >> var1: anObject [

	var1 := anObject
]
