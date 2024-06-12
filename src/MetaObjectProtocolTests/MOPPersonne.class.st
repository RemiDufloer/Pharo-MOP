"
this class is a mock class for performing mop operations such as testing
"
Class {
	#name : 'MOPPersonne',
	#superclass : 'Object',
	#instVars : [
		'nom',
		'prenom',
		'age'
	],
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'accessing' }
MOPPersonne >> age [

	^ age
]

{ #category : 'accessing' }
MOPPersonne >> age: anObject [

	age := anObject
]

{ #category : 'accessing' }
MOPPersonne >> nom [

	^ nom
]

{ #category : 'accessing' }
MOPPersonne >> nom: anObject [

	nom := anObject
]

{ #category : 'accessing' }
MOPPersonne >> prenom [

	^ prenom
]

{ #category : 'accessing' }
MOPPersonne >> prenom: anObject [

	prenom := anObject
]

{ #category : 'accessing' }
MOPPersonne >> signature [
	
	self age.
	self prenom.
	^ self.
]
