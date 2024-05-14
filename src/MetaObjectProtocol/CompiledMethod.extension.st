Extension { #name : #CompiledMethod }

{ #category : #'*MetaObjectProtocol' }
CompiledMethod >> onCallDo: aMOPOperation onReceiver: anObject [

    | instrumentation requirement |
    instrumentation := MOPInstrumentation new.
    requirement := MOPSelectorNameRequirement name: self selector .
    instrumentation operation: aMOPOperation.
    instrumentation requirement: requirement .
    anObject mop addInstrumentation: instrumentation
]
