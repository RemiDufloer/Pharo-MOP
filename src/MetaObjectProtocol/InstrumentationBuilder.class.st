Class {
	#name : #InstrumentationBuilder,
	#superclass : #MOPBuilderProtocol,
	#category : #MetaObjectProtocol
}

{ #category : #initialization }
InstrumentationBuilder >> initialize [

	instrumentation := Instrumentation new.
	
]

{ #category : #accessing }
InstrumentationBuilder >> metaObject: aMOPMetaObject [

	super metaObject: aMOPMetaObject .
	aMOPMetaObject addInstrumentation: self instrumentation .
]

{ #category : #'instance creation' }
InstrumentationBuilder >> newRequirementInstallation [

	^ RequirementInstallationBuilder new
		  metaObject: metaObject;
		  instrumentation: self instrumentation;
			yourself
]
