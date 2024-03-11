Extension { #name : #Object }

{ #category : #'*MetaObjectProtocol' }
Object >> mop [

	| proxy metaObject |
	proxy := MOPProxy basicNew.
	metaObject := MOPMetaObject new.

	"here we put the meta Object in the meta Object slot of the proxy.
We do not create setters so that the proxy knows as few messages as possible"
	MirrorPrimitives
		fixedFieldOf: proxy
		at: (MOPProxy slotNamed: #metaObject) index
		put: metaObject.


	self become: proxy.

	"After the use of the ProtoObject >> #become primitive:
 	- The references to the object are now pointing to the proxy.
 	- And the references to the proxy are now pointing to the object.
	
	MOPProxy does not know all the messages necessary to make the become, this is why the hash methods are redefined in the latter
 	
 	So, to store the object in an instance variable, we must affect it using the variable proxy."
	metaObject object: proxy.

	^ self mop
]
