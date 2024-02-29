Extension { #name : #Object }

{ #category : #'*MetaObjectProtocol' }
Object >> mop [

	| proxy object |
	object := self class new.
	proxy := MOPProxy basicNew.
	
	1 halt


	"object becomeForward: self copyHash: false.
	self becomeForward: proxy copyHash: true.

	proxy metaObject: (MOPMetaObject new
			 object: object;
			 yourself)."


	"^ proxy mop"
]
