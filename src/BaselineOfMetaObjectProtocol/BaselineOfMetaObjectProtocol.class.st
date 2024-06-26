Class {
	#name : #BaselineOfMetaObjectProtocol,
	#superclass : #BaselineOf,
	#category : #BaselineOfMetaObjectProtocol
}

{ #category : #baselines }
BaselineOfMetaObjectProtocol >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #MetaObjectProtocol.
		spec 
			package: #MetaObjectProtocolBuilder.
		spec 
			package: #MetaObjectProtocolTests with: [ spec requires: #('MetaObjectProtocol')  ].
 ]
	
]
