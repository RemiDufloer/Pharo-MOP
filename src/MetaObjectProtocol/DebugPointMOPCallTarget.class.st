Class {
	#name : 'DebugPointMOPCallTarget',
	#superclass : 'DebugPointTarget',
	#category : 'MetaObjectProtocol-debug-Points',
	#package : 'MetaObjectProtocol',
	#tag : 'debug-Points'
}

{ #category : 'accessing - classes' }
DebugPointMOPCallTarget class >> hitAnnouncementClass [

	^ DebugPointHit
]

{ #category : 'actions' }
DebugPointMOPCallTarget >> browse [

	self targetClass browse
]

{ #category : 'announcements' }
DebugPointMOPCallTarget >> hitAnnouncementOn: aDebugPoint inContext: aContext [

	^ self class hitAnnouncementClass
		  on: aDebugPoint
		  nodes:
		  { (aContext compiledCode sourceNodeForPC: aContext pc) parent }
			  asSet
]

{ #category : 'accessing' }
DebugPointMOPCallTarget >> impactedNodes [

	| listOfInstrumentationDebugPoint |
	listOfInstrumentationDebugPoint := self mop listOfInstrumentation
		                                   select: [ :i |
			                                   i before isDebugPointOperation
				                                   or: [
					                                   i operation
						                                   isDebugPointOperation or: [
						                                   i after isDebugPointOperation ] ] ].
	^ listOfInstrumentationDebugPoint flatCollect: [ :i | i nodes ]
]

{ #category : 'installing' }
DebugPointMOPCallTarget >> install: aLink [

	self flag: 'shit design'.
]

{ #category : 'accessing' }
DebugPointMOPCallTarget >> mop [

	^ self proxy mop
]

{ #category : 'accessing' }
DebugPointMOPCallTarget >> proxy [

	^ self target
]

{ #category : 'accessing' }
DebugPointMOPCallTarget >> proxy: aMOPProxy [

	self target: aMOPProxy 
]

{ #category : 'removing' }
DebugPointMOPCallTarget >> removeFromMethod: aMethod for: aDebugPoint [

	self flag: 'TODO: see how to remove MOP instrumentation from method'
]

{ #category : 'scope' }
DebugPointMOPCallTarget >> resetObjectScope [

	self flag: 'nonsense'
]

{ #category : 'description' }
DebugPointMOPCallTarget >> scope [

	^ self proxy
]

{ #category : 'description' }
DebugPointMOPCallTarget >> scopeString [

	^ 'obj {1}' format: { self scope }
]

{ #category : 'accessing' }
DebugPointMOPCallTarget >> targetClass [

	^ self target nonAnonymousClass 
]
