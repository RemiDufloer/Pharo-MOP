Class {
	#name : #ROCTop,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #MetaObjectProtocolTests
}

{ #category : #'as yet unclassified' }
ROCTop >> index [

	^ -3
]

{ #category : #'as yet unclassified' }
ROCTop >> instVarAccessInSuperCall [
	^self index
	
]

{ #category : #accessing }
ROCTop >> m [
 	x := self m2
]

{ #category : #accessing }
ROCTop >> m2 [
	'coucou' crTrace.
 	^self
]

{ #category : #'as yet unclassified' }
ROCTop >> mWithSuper [
	^self index
]

{ #category : #'as yet unclassified' }
ROCTop >> redefineNoSuper [

	^ 1
]

{ #category : #'as yet unclassified' }
ROCTop >> superUpToMiddleHierarchy [
	"I do nothing"
]

{ #category : #accessing }
ROCTop >> x [
	 ^x
]
