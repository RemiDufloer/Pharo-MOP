Class {
	#name : #BaselineOfMetaObjectProtocol,
	#superclass : #BaselineOf,
	#category : #BaselineOfMetaObjectProtocol
}

{ #category : #baselines }
BaselineOfMetaObjectProtocol >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: #DebugPoints.
		spec
			package: #MetaObjectProtocol
			with: [ spec requires: #( 'DebugPoints' ) ].
		spec
			package: 'MetaObjectProtocol-Tools'
			with: [ spec requires: #( 'DebugPoints' 'MetaObjectProtocol' ) ].
		spec package: #MetaObjectProtocolBuilder.
		spec
			package: #MetaObjectProtocolTests
			with: [ spec requires: #( 'MetaObjectProtocol' ) ] ]
]
