Class {
	#name : #MOPInstrumentation,
	#superclass : #Object,
	#instVars : [
		'operations',
		'requirement',
		'installedNodes'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
MOPInstrumentation >> addOperation: anOperation [

	operations add: anOperation 
]

{ #category : #execution }
MOPInstrumentation >> execute: aRFOperation [

	^ operations do:[ :o | o apply: aRFOperation ]
]

{ #category : #accessing }
MOPInstrumentation >> initialize [

	operations := OrderedCollection new.
	installedNodes := OrderedCollection new.
	self requirement: MOPNoRequirement new
]

{ #category : #MetaLink }
MOPInstrumentation >> installOnMethod: aRBMethod [

	| nodeOfMethodNeedToInstall |
	nodeOfMethodNeedToInstall := aRBMethod ast allChildren.
	nodeOfMethodNeedToInstall removeAllFoundIn: self installedNodes.

	nodeOfMethodNeedToInstall do: [ :n | self installOnNode: n ]
]

{ #category : #MetaLink }
MOPInstrumentation >> installOnNode: aNode [

	| link |
	(self requirement verify: aNode) ifFalse: [ ^ nil ].

	link := MetaLink new.
	link arguments: #( operation ).
	link control: #instead.
	link metaObject: self.
	link selector: #execute:.
	link optionCompileOnLinkInstallation: true.

	(link checkForCompatibilityWith: aNode) ifFalse: [ ^ nil ].

	[ aNode link: link ]
		on: Exception
		do: [ link disable . ^ nil ].
	self installedNodes add: aNode
]

{ #category : #accessing }
MOPInstrumentation >> installedNodes [

	^ installedNodes
]

{ #category : #accessing }
MOPInstrumentation >> installedNodes: anObject [

	installedNodes := anObject
]

{ #category : #accessing }
MOPInstrumentation >> operations [

	^ operations
]

{ #category : #accessing }
MOPInstrumentation >> removeOperation: anOperation [

	operations remove: anOperation 
]

{ #category : #accessing }
MOPInstrumentation >> requirement [

	^ requirement
]

{ #category : #accessing }
MOPInstrumentation >> requirement: aRequirement [ 
	
	requirement := aRequirement 
]

{ #category : #installation }
MOPInstrumentation >> uninstalAll [
	self installedNodes do: [ :n | n links do: [:l | l uninstall] ]
]
