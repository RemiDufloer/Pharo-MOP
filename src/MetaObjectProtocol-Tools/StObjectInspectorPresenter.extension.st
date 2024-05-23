Extension { #name : 'StObjectInspectorPresenter' }

{ #category : '*MetaObjectProtocol-Tools' }
StObjectInspectorPresenter >> haltInspectedObjectOnCall [

	self inspectedObject haltOnCall
]

{ #category : '*MetaObjectProtocol-Tools' }
StObjectInspectorPresenter class >> newObjectCentricBreakpointCommandsWith: aPresenter forRootGroup: aRootCommandsGroup [

	<extensionCommands>
		aRootCommandsGroup 
		register: (CmCommandGroup forSpec
			beToolbarPopoverButton;
			name: 'MOP halts';
			icon: (aPresenter application iconNamed: #smallObjects);
			register: (StHaltOnCallCommand forSpec);
			yourself)

]
