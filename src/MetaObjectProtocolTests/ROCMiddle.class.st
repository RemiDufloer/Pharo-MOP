Class {
	#name : #ROCMiddle,
	#superclass : #ROCTop,
	#category : #MetaObjectProtocolTests
}

{ #category : #'as yet unclassified' }
ROCMiddle >> instVarAccessInSuperCall [
	x := 1 + super instVarAccessInSuperCall.
	^x
]

{ #category : #'as yet unclassified' }
ROCMiddle >> mWithSuper [
	^super mWithSuper + 2
]

{ #category : #'as yet unclassified' }
ROCMiddle >> redefineNoSuper [

	^ super redefineNoSuper + 1
]

{ #category : #'as yet unclassified' }
ROCMiddle >> superUpToMiddleHierarchy [
	"I do not call super"
	^ 1
]
