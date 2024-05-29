Class {
	#name : 'MOPBreakDebugPoint',
	#superclass : 'BreakDebugPoint',
	#instVars : [
		'mop'
	],
	#category : 'MetaObjectProtocol-debug-Points',
	#package : 'MetaObjectProtocol',
	#tag : 'debug-Points'
}

{ #category : 'installing' }
MOPBreakDebugPoint >> install [

	self flag: 'shit design'.
	self target install: nil
]

{ #category : 'API' }
MOPBreakDebugPoint >> instanceVariable: aSlot accessStrategy: aSymbol [

	self flag: 'shit design'
]

{ #category : 'accessing' }
MOPBreakDebugPoint >> name [

	^ name ifNil: [ #OCMOPCallBreak ]
]

{ #category : 'API' }
MOPBreakDebugPoint >> node: aNode [

	self flag: 'shit design'
]

{ #category : 'accessing' }
MOPBreakDebugPoint >> nodes [

	self flag: 'TODO: get nodes via MOP'.
	^ self target impactedNodes
]

{ #category : 'removing' }
MOPBreakDebugPoint >> remove [

	| nodes |
	self flag: 'TODO: uninstall MOP here'.
	nodes := self link nodes copy.
	self behaviors do: [ :bh | bh remove ].
	self class remove: self.
	self link ifNotNil: [ self link uninstall ].

	DebugPointManager notifyDebugPointRemoved: self fromNodes: nodes
]

{ #category : 'removing' }
MOPBreakDebugPoint >> removeFromClass: aClass [
	"If the removed class is the class we target or one of its superclasses,
	then after that class is removed we have no reason to exist. We need to uninstall."

	self flag: 'TODO: see how to remove MOP instrumentation from a class'.
	(self targetClass = aClass or: [
		 self targetClass allSuperclasses includes: aClass ]) ifTrue: [
		self remove.
		^ self ].

	"We removed a aClass, but it is not our target class nor one of its superclasses.
	It is then one of its subclasses, we can continue to exist since the variable
	we target still exist in the target class.
	However, we need to remove the nodes of the removed class from our metalink"
	(self link nodes select: [ :n | n methodNode methodClass == aClass ])
		do: [ :n | self link removeNode: n ]
]

{ #category : 'removing' }
MOPBreakDebugPoint >> removeFromMethod: aMethod [
	"only used when editing methods with debug points"
	self flag: 'TODO: see how to remove MOP instrumentation from method'.
	self target removeFromMethod: aMethod for: self
]

{ #category : 'removing' }
MOPBreakDebugPoint >> removeNode: aRBNode [
	self flag: 'TODO'.
	self link removeNode: aRBNode
]

{ #category : 'scope' }
MOPBreakDebugPoint >> targetInstance: anObject [

	target := DebugPointMOPCallTarget new
		          proxy: anObject;
		          yourself
]
