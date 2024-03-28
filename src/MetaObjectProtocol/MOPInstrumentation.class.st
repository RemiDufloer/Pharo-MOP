Class {
	#name : #MOPInstrumentation,
	#superclass : #Object,
	#instVars : [
		'operations',
		'requirement',
		'instrumentationInstalleur'
	],
	#category : #MetaObjectProtocol
}

{ #category : #accessing }
MOPInstrumentation >> addOperation: anOperation [

	operations add: anOperation 
]

{ #category : #requirement }
MOPInstrumentation >> checkRequirementMethod: aMethod [

	| nodeOfMethodWantToCheck |
	nodeOfMethodWantToCheck := aMethod ast allChildren.
	^ nodeOfMethodWantToCheck anySatisfy: [ :n |
		  self requirement verify: n ]
]

{ #category : #execution }
MOPInstrumentation >> execute: aRFOperation [
	| return |
	return := OrderedCollection new.
	operations do: [ :o | return add: (o apply: aRFOperation) ].
	^ return
]

{ #category : #initialization }
MOPInstrumentation >> initialize [

	operations := OrderedCollection new.
	self requirement: MOPNoRequirement new
]

{ #category : #actions }
MOPInstrumentation >> install [
	self flag: 'todo'.
	self instrumentationInstalleur install
]

{ #category : #accessing }
MOPInstrumentation >> instrumentationInstalleur [

	^ instrumentationInstalleur
]

{ #category : #accessing }
MOPInstrumentation >> instrumentationInstalleur: anObject [

	instrumentationInstalleur := anObject
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
MOPInstrumentation >> uninstall [

	self instrumentationInstalleur uninstall: self
	
]
