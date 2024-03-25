Class {
	#name : #MOPOperationBuilder,
	#superclass : #MOPBuilder,
	#category : #MetaObjectProtocolBuilder
}

{ #category : #'instance creation' }
MOPOperationBuilder >> newBlockOperation: aBlock [
	
	instrumentationBuilder addOperation: (MOPBlockOperation new block: aBlock )
]
