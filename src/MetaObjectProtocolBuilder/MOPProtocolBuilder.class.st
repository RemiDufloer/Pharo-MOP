Class {
	#name : 'MOPProtocolBuilder',
	#superclass : 'Object',
	#instVars : [
		'requirement',
		'instrumentation',
		'protocol'
	],
	#category : 'MetaObjectProtocolBuilder',
	#package : 'MetaObjectProtocolBuilder'
}

{ #category : 'accessing' }
MOPProtocolBuilder class >> protocol: aMOPProtocol [

	^ self new
		  protocol: aMOPProtocol;
		  yourself
]

{ #category : 'accessing' }
MOPProtocolBuilder >> after: anOperation [

	instrumentation after: anOperation
]

{ #category : 'accessing' }
MOPProtocolBuilder >> before: anOperation [

	instrumentation before: anOperation
]

{ #category : 'initialization' }
MOPProtocolBuilder >> initialize [

	instrumentation := MOPInstrumentation new.
	
]

{ #category : 'accessing' }
MOPProtocolBuilder >> instead: anOperation [

	instrumentation operation: anOperation
]

{ #category : 'as yet unclassified' }
MOPProtocolBuilder >> propagate: aBoolean [

	instrumentation propagate: aBoolean .
]

{ #category : 'accessing' }
MOPProtocolBuilder >> protocol: aMOPProtocol [

	protocol := aMOPProtocol.
	" When the protocol is set you can now add the instrumentation, you can add the instrumentation on the start of the builder, and add information on it on the start"
	protocol addInstrumentation: instrumentation .
]

{ #category : 'accessing' }
MOPProtocolBuilder >> requirement: aMOPRequirement [

	instrumentation requirement: (instrumentation requirement  and: aMOPRequirement )
]
