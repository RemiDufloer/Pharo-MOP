Extension { #name : 'Object' }

{ #category : '*MetaObjectProtocol-Tools' }
Object >> haltOnCall [
	"^ Breakpoint breakOn: aSelector inObject: self"
	| protocol |
	
	protocol := self mop.
	protocol method before: (MOPDebugPointOperation object: self).
	

	
]
