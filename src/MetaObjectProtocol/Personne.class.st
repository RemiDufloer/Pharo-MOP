Class {
	#name : #Personne,
	#superclass : #Object,
	#instVars : [
		'nom',
		'prenom',
		'age'
	],
	#category : #'MetaObjectProtocol-Demo'
}

{ #category : #accessing }
Personne >> age [

	^ age
]

{ #category : #accessing }
Personne >> age: anObject [

	age := anObject
]

{ #category : #accessing }
Personne >> nom [

	^ nom
]

{ #category : #accessing }
Personne >> nom: anObject [

	nom := anObject
]

{ #category : #accessing }
Personne >> prenom [

	^ prenom
]

{ #category : #accessing }
Personne >> prenom: anObject [

	prenom := anObject
]

{ #category : #accessing }
Personne >> signature [

	^ String streamContents: [ :s |
		  s << ' ' << self nom << ' ' << self prenom << ' ' << self age  ]
]
