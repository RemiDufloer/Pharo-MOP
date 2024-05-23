Class {
	#name : 'MOPTest',
	#superclass : 'TestCase',
	#category : 'MetaObjectProtocolTests',
	#package : 'MetaObjectProtocolTests'
}

{ #category : 'running' }
MOPTest >> tearDown [

	super tearDown .
	[ MetaLink uninstallAll ] on: Error do: [ :e | 
		e crTrace 
	]
]
