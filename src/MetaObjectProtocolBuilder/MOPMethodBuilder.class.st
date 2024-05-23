Class {
	#name : 'MOPMethodBuilder',
	#superclass : 'MOPProtocolBuilder',
	#category : 'MetaObjectProtocolBuilder',
	#package : 'MetaObjectProtocolBuilder'
}

{ #category : 'meta-object-protocol' }
MOPMethodBuilder >> argumentsSize: anInteger [

	requirement and: (MOPArgumentsSizeRequirement size: anInteger )
]

{ #category : 'initialization' }
MOPMethodBuilder >> initialize [

	super initialize.
	instrumentation requirement:  MOPMethodsRequirement new
]

{ #category : 'accessing' }
MOPMethodBuilder >> selector: aSelector [

	self requirement: (MOPSelectorNameRequirement name: aSelector)
]
