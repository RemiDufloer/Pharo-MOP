Class {
	#name : 'DebugPointMOPCallTargetPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'target',
		'impactedNodesCache',
		'impactedMethodList',
		'codePresenter'
	],
	#category : 'MetaObjectProtocol-debug-Points',
	#package : 'MetaObjectProtocol',
	#tag : 'debug-Points'
}

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> connectPresenters [

	impactedMethodList transmitDo: [ :methodOrBlock |
		methodOrBlock ifNotNil: [ self updateCodeFromMethod: methodOrBlock ] ]
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> defaultLayout [

	^ self newPanedLayoutTopToBottom
		  add: impactedMethodList;
		  add: codePresenter;
		  positionOfSlider: 30 percent;
		  yourself
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> dialogLayout [

	^ self newPanedLayoutLeftToRight
		  add: impactedMethodList;
		  add: codePresenter;
		  yourself
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> initializeCode [

	codePresenter := self newCode
		                 beNotEditable;
		                 yourself
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> initializeMethodList [

	impactedMethodList := self newFilteringList
		                      items: {  };
		                      sortingBlock: [ :m1 :m2 |
			                      m1 methodClass name < m2 methodClass name
				                      and: [ m1 method name < m2 method name ] ];
		                      yourself
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> initializePresenters [

	self initializeMethodList.
	self initializeCode
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> target [

	^ target
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> target: aDebugPointInstanceVariableTarget [

	target := aDebugPointInstanceVariableTarget.
	self updatePresenter
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> updateCodeFromMethod: method [

	codePresenter
		text: method sourceCode;
		beForMethod: method.
	impactedNodesCache
		select: [ :node | node methodNode == method ast ]
		thenDo: [ :node |
			codePresenter addTextSegmentDecoration:
				(SpTextPresenterDecorator forHighlight
					 interval: (node start to: node stop + 1);
					 yourself) ]
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> updateImpactedNodesCache [

	impactedNodesCache := self target impactedNodes
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> updateMethodList [

	self updateImpactedNodesCache.
	impactedMethodList items:
		(impactedNodesCache collect: [ :node |
			 node methodNode compiledMethod ]) asIdentitySet
]

{ #category : 'initialization' }
DebugPointMOPCallTargetPresenter >> updatePresenter [

	self target ifNil: [ ^ self ].
	self updateMethodList
]
