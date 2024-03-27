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

{ #category : #execution }
MOPInstrumentation >> execute: aRFOperation [

	^ operations do:[ :o | o apply: aRFOperation ]
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
