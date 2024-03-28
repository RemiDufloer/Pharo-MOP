Class {
	#name : #MOPTop,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #MetaObjectProtocolTests
}

{ #category : #'as yet unclassified' }
MOPTop >> index [

	^ -3
]

{ #category : #'as yet unclassified' }
MOPTop >> instVarAccessInSuperCall [
	^self index
	
]

{ #category : #accessing }
MOPTop >> m [
 	x := self m2
]

{ #category : #accessing }
MOPTop >> m2 [
	'coucou' crTrace.
 	^self
]

{ #category : #'as yet unclassified' }
MOPTop >> mWithSuper [
'top' traceCr.
	^ self index
]

{ #category : #'as yet unclassified' }
MOPTop >> redefineNoSuper [

	^ 1
]

{ #category : #'as yet unclassified' }
MOPTop >> superUpToMiddleHierarchy [
	"I do nothing"
]

{ #category : #accessing }
MOPTop >> x [
	 ^x
]
