Class {
	#name : #MOPTest,
	#superclass : #TestCase,
	#category : #MetaObjectProtocolTest
}

{ #category : #running }
MOPTest >> tearDown [

	[ MetaLink uninstallAll ] on: Error do: [ :e | 
		e crTrace 
	]
]
