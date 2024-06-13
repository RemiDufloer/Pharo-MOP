Extension { #name : 'DebugPointManager' }

{ #category : '*MetaObjectProtocol-Tools' }
DebugPointManager class >> installNew: aDebugPointClass forMOPProxy: aMOPProxy [

	^ self installNew: aDebugPointClass forMOPProxy: aMOPProxy withBehaviors: {  }.
]

{ #category : '*MetaObjectProtocol-Tools' }
DebugPointManager class >> installNew: aDebugPointClass forMOPProxy: aMOPProxy withBehaviors: aCollectionOfDebugPointBehaviorClasses [

	| dp |
	dp := aDebugPointClass new
		      targetInstance: aMOPProxy;
		      yourself.

	^ self
		  installDebugPoint: dp
		  withBehaviors: aCollectionOfDebugPointBehaviorClasses
]
