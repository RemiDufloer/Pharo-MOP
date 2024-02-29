Extension { #name : #Object }

{ #category : #'*MetaObjectProtocol' }
Object >> mop [

	|  proxy metaObject |
	

	proxy := MOPProxy basicNew.
	metaObject := MOPMetaObject new.

	MirrorPrimitives
		fixedFieldOf: proxy
		at: (MOPProxy slotNamed: #metaObject) index
		put: metaObject.

	self become: proxy.

	metaObject object: proxy.

	^ self mop
]
