Class {
	#name : #MOPHaltOperation,
	#superclass : #MOPOperation,
	#category : #'MetaObjectProtocol-Operation'
}

{ #category : #accessing }
MOPHaltOperation >> apply: aRFOperation with: anOrderedCollection [

	<debuggerCompleteToSender>
	| sender |
	sender := thisContext sender findContextSuchThat: [ :ctx |
		          ctx notNil and: [
			          ctx receiver isKindOf: StInspection ] ].
	sender ifNotNil: [ ^ self ].
	aRFOperation method selector = #stDisplayString ifTrue:[^self].
	self halt
]
