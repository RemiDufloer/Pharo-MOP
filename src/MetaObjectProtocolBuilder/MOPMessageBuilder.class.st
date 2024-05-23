Class {
	#name : 'MOPMessageBuilder',
	#superclass : 'MOPProtocolBuilder',
	#category : 'MetaObjectProtocolBuilder',
	#package : 'MetaObjectProtocolBuilder'
}

{ #category : 'initialization' }
MOPMessageBuilder >> initialize [

	super initialize.
	instrumentation requirement:  MOPMessageRequirement new
]

{ #category : 'meta-object-protocol' }
MOPMessageBuilder >> superSend [

	self requirement:  MOPSuperSendRequirement new
]
