Class {
	#name : #OperationBuilder,
	#superclass : #MOPBuilder,
	#category : #MetaObjectProtocolBuilder
}

{ #category : #'instance creation' }
OperationBuilder >> newBlockOperation: aBlock [
	
	instrumentationBuilder addOperation: (BlockOperation new block: aBlock )
]
