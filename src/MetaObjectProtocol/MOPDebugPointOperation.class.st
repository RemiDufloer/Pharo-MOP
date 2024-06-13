Class {
	#name : 'MOPDebugPointOperation',
	#superclass : 'MOPOperation',
	#instVars : [
		'debugPoint'
	],
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPDebugPointOperation class >> object: anObject [

	^ self new
		  object: anObject;
		  yourself
]

{ #category : 'accessing' }
MOPDebugPointOperation >> apply: aRFOperation with: anOrderedCollection [

	debugPoint hitWithContext: thisContext
]

{ #category : 'testing' }
MOPDebugPointOperation >> isDebugPointOperation [

	^ true
]

{ #category : 'accessing' }
MOPDebugPointOperation >> object: anObject [

	debugPoint := DebugPointManager
		              installNew: MOPBreakDebugPoint
		              forMOPProxy: anObject.
	debugPoint
		addBehavior:
			(ScriptBehavior new script: 'Transcript traceCr: thisContext');
		addBehavior: (ConditionBehavior new condition:
					 '(thisContext sender findContextSuchThat: [ :ctx |
 		          
 			          ((ctx receiver isKindOf: StInspectionPresenter) or: [ ctx receiver isKindOf: StInspectorPresenter ]) or: [ #( #printString . #asString . #stDisplayString) includes: ctx selector ] ]) isNil')
]
