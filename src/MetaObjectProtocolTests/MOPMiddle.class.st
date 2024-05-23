Class {
	#name : 'MOPMiddle',
	#superclass : 'MOPTop',
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'accessing' }
MOPMiddle >> instVarAccessInSuperCall [
	x := 1 + super instVarAccessInSuperCall.
	^x
]

{ #category : 'accessing' }
MOPMiddle >> mWithSuper [

	^ super mWithSuper + 2
]

{ #category : 'accessing' }
MOPMiddle >> redefineNoSuper [

	^ super redefineNoSuper + 1
]

{ #category : 'accessing' }
MOPMiddle >> superUpToMiddleHierarchy [
	"I do not call super"
	^ 1
]
