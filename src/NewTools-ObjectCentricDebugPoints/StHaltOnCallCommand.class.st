Class {
	#name : 'StHaltOnCallCommand',
	#superclass : 'StDebugPointCommand',
	#category : 'NewTools-ObjectCentricDebugPoints',
	#package : 'NewTools-ObjectCentricDebugPoints'
}

{ #category : 'default' }
StHaltOnCallCommand class >> defaultDescription [

	^ 'Halts when this method is called'
]

{ #category : 'default' }
StHaltOnCallCommand class >> defaultIconName [

	^ #smallDebug
]

{ #category : 'default' }
StHaltOnCallCommand class >> defaultName [ 

	^ 'Halt on call'
]

{ #category : 'testing' }
StHaltOnCallCommand >> canBeExecuted [

	^ self appliesTo: context
]

{ #category : 'executing' }
StHaltOnCallCommand >> execute [

	^ context haltInspectedObjectOnCall
]
