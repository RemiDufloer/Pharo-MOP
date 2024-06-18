Extension { #name : 'Object' }

{ #category : '*MetaObjectProtocol' }
Object >> isInspection [

	^ false
]

{ #category : '*MetaObjectProtocol' }
Object >> isInspector [

	^ false
]

{ #category : '*MetaObjectProtocol' }
Object >> mop [

	| object proxy metaObject |
	object := self.
	proxy := MOPProxy basicNew.
	metaObject := MOPMetaObject new.
	"
    Here we put the meta Object in the metaObject slot of the proxy.
    We do not create setters so that the proxy knows as few messages as possible
   "
	MirrorPrimitives
		fixedFieldOf: proxy
		at: (MOPProxy slotNamed: #metaObject) index
		put: metaObject.

	self become: proxy.
	"After the use of the ProtoObject >> #become primitive:
 	- The references to the object are now pointing to the proxy.
 	- And the references to the proxy are now pointing to the object.
	
	MOPProxy does not know all the messages necessary to make the become.
	This is why the hash methods are redefined in the latter.
 	
 	The meta object must know:
	- The instrumented object, to forward the message intercepted by the proxy.
	- The proxy, to prevent the object to escape the mop's scope when message returning self are    	received."
	metaObject object: proxy.
	metaObject proxy: self.
	
	^ self mop
]
