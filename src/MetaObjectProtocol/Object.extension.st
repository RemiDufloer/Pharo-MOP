Extension { #name : #Object }

{ #category : #'*MetaObjectProtocol' }
Object >> mop [

	| proxy |
	proxy := MOPProxyGenerator basicNew.

	MirrorPrimitives
		fixedFieldOf: proxy
		at: (MOPProxyGenerator slotNamed: #metaObject) index
		put: (MOPMetaObject new
				 object: proxy;
				 yourself).

	self become: proxy.
]
