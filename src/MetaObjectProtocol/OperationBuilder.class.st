Class {
	#name : #OperationBuilder,
	#superclass : #MOPBuilder,
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
OperationBuilder >> newBlockOperation: aBlock [
	
	instrumentationBuilder addOperation: (BlockOperation new block: aBlock )
]
