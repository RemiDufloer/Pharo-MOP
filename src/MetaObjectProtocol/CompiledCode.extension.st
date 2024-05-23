Extension { #name : 'CompiledCode' }

{ #category : '*MetaObjectProtocol' }
CompiledCode >> hasSuperSends [

	^ self ast sendNodes anySatisfy: [ :msgNode | msgNode isSuperSend ]
]
