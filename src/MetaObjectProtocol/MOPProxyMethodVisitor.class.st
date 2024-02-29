Class {
	#name : #MOPProxyMethodVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'indirectionIdentifier'
	],
	#category : #MetaObjectProtocol
}

{ #category : #testing }
MOPProxyMethodVisitor class >> isAbstract [

	^ self == RBProgramNodeVisitor
]

{ #category : #visiting }
MOPProxyMethodVisitor >> visitMethodNode: aMethodNode [

	aMethodNode body: (RBSequenceNode statements: { (RBMessageNode
				  receiver: (RBVariableNode named: #self)
				  selector: #doesNotUnderstand:
				  arguments: { (RBMessageNode
						   receiver: (RBVariableNode named: #Message)
						   selector: #selector:arguments:
						   arguments: {
								   (RBLiteralValueNode value: aMethodNode selector).
								   (RBArrayNode statements: aMethodNode arguments) }) }) }).

	^ aMethodNode
]
