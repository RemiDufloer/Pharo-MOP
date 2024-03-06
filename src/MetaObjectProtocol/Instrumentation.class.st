Class {
	#name : #Instrumentation,
	#superclass : #Object,
	#instVars : [
		'operations',
		'requirement',
		'installedNodes'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
Instrumentation >> addOperation: anOperation [

	operations add: anOperation 
]

{ #category : #execution }
Instrumentation >> execute: aRFOperation [

	^ operations do:[ :o | o apply: aRFOperation ]
]

{ #category : #accessing }
Instrumentation >> initialize [

	operations := OrderedCollection new.
	installedNodes := OrderedCollection new.
	self requirement: NoRequirement new
]

{ #category : #MetaLink }
Instrumentation >> installOnMethod: aRBMethod [

	| nodeOfMethodNeedToInstall |
	nodeOfMethodNeedToInstall := aRBMethod ast allChildren.
	nodeOfMethodNeedToInstall removeAllFoundIn: self installedNodes.

	nodeOfMethodNeedToInstall do: [ :n | self installOnNode: n ]
]

{ #category : #MetaLink }
Instrumentation >> installOnNode: aNode [

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
Instrumentation >> installedNodes [

	^ installedNodes
]

{ #category : #accessing }
Instrumentation >> installedNodes: anObject [

	installedNodes := anObject
]

{ #category : #accessing }
Instrumentation >> operations [

	^ operations
]

{ #category : #accessing }
Instrumentation >> removeOperation: anOperation [

	operations remove: anOperation 
]

{ #category : #accessing }
Instrumentation >> requirement [

	^ requirement
]

{ #category : #accessing }
Instrumentation >> requirement: aRequirement [ 
	
	requirement := aRequirement 
]

{ #category : #installation }
Instrumentation >> uninstalAll [
	self installedNodes do: [ :n | n links do: [:l | l uninstall] ]
]
