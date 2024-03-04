Class {
	#name : #OperationBuilder,
	#superclass : #MOPBuilderProtocol,
	#category : #MetaObjectProtocol
}

{ #category : #'instance creation' }
OperationBuilder >> newBlockOperation: aBlock [


	self instrumentation addOperation: (BlockOperation block: aBlock)
]
