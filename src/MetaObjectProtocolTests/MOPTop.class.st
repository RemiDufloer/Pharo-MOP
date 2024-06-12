Class {
	#name : 'MOPTop',
	#superclass : 'Object',
	#instVars : [
		'x'
	],
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'accessing' }
MOPTop >> index [

	^ -3
]

{ #category : 'accessing' }
MOPTop >> instVarAccessInSuperCall [

	^ self index
]

{ #category : 'accessing' }
MOPTop >> m [
 	x := self m2
]

{ #category : 'accessing' }
MOPTop >> m2 [

 	^self
]

{ #category : 'accessing' }
MOPTop >> mWithSuper [

	^ self index
]

{ #category : 'accessing' }
MOPTop >> redefineNoSuper [

	^ 1
]

{ #category : 'accessing' }
MOPTop >> superUpToMiddleHierarchy [
	"I do nothing"
]

{ #category : 'accessing' }
MOPTop >> x [
	 ^x
]
