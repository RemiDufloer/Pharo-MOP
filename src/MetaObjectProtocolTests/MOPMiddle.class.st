Class {
	#name : #MOPMiddle,
	#superclass : #MOPTop,
	#category : #MetaObjectProtocolTests
}

{ #category : #'as yet unclassified' }
MOPMiddle >> instVarAccessInSuperCall [
	x := 1 + super instVarAccessInSuperCall.
	^x
]

{ #category : #'as yet unclassified' }
MOPMiddle >> mWithSuper [

	^ super mWithSuper + 2
]

{ #category : #'as yet unclassified' }
MOPMiddle >> redefineNoSuper [

	^ super redefineNoSuper + 1
]

{ #category : #'as yet unclassified' }
MOPMiddle >> superUpToMiddleHierarchy [
	"I do not call super"
	^ 1
]
