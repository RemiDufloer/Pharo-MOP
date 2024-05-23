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

{ #category : 'accessing' }
MOPDebugPointOperation >> object: anObject [

	debugPoint := BreakDebugPoint new
		              targetInstance: anObject;
		              addBehavior:
			              (ScriptBehavior new script:
					               'Transcript traceCr: thisContext');
		              addBehavior: (ConditionBehavior new condition:
					               'thisContext sender findContextSuchThat: [ :ctx |
 		          
 			          ctx receiver isKindOf: StInspectionPresenter ] isNil');
		              yourself
]
