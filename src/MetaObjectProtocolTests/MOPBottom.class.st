Class {
	#name : 'MOPBottom',
	#superclass : 'MOPMiddle',
	#instVars : [
		'var1',
		'compteur'
	],
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'assignments' }
MOPBottom >> assignmentTest [
	var1 := 4 squared.
]

{ #category : 'accessing' }
MOPBottom >> callCompteur [

	^ compteur + 1
]

{ #category : 'mock' }
MOPBottom >> escapeWithSelf [

	var1 := 12.
	^ self
]

{ #category : 'mock' }
MOPBottom >> escapeWithoutSelf [

	var1 := 12.

]

{ #category : 'initialization' }
MOPBottom >> initialize [ 

	compteur := 0.
]

{ #category : 'accessing' }
MOPBottom >> mWithSuper [

	^ super mWithSuper + 1
]

{ #category : 'accessing' }
MOPBottom >> redefineNoSuper [
	^1
]

{ #category : 'accessing' }
MOPBottom >> superUpToMiddleHierarchy [
	"I call super"
	^ super superUpToMiddleHierarchy + 1
]

{ #category : 'accessing' }
MOPBottom >> var1 [

	^ var1
]

{ #category : 'accessing' }
MOPBottom >> var1: anObject [

	var1 := anObject
]
