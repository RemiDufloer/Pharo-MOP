"
I redirect superclass nodes to another method whose selector is provided to me.
"
Class {
	#name : 'MOPSuperSendOperation',
	#superclass : 'MOPOperation',
	#instVars : [
		'selector'
	],
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPSuperSendOperation class >> selector: aSelector [

	^ self new
		  selector: aSelector;
		  yourself
]

{ #category : 'accessing' }
MOPSuperSendOperation >> apply: aRFOperation with: anOrderedCollection [

	(requirement verify: aRFOperation) ifTrue: [
		^ aRFOperation receiver
			  perform: self selector
			  withArguments: aRFOperation arguments ]
]

{ #category : 'accessing' }
MOPSuperSendOperation >> selector [

	^ selector
]

{ #category : 'accessing' }
MOPSuperSendOperation >> selector: anObject [

	selector := anObject
]
