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
"		addBehavior:
			(ScriptBehavior new script: ' thisContext traceCr');"
		addBehavior: (ConditionBehavior new condition:
					 '(thisContext sender findContextSuchThat: [ :ctx |
	 (#(#isInspector. #isInspection. #class. #isKindOf: . #printString . #asString . #stDisplayString ) includes:
		  ctx selector) or: [
		 (ctx receiver isInspector) or: [
			 ctx receiver isInspection ] ] ]) isNil')
]
