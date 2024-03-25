Class {
	#name : #MOPRequirement,
	#superclass : #Object,
	#category : #MetaObjectProtocol
}

{ #category : #controlling }
MOPRequirement class >> and: aRequirement [

	^ MOPAndRequirement left: self right: aRequirement 
]

{ #category : #controlling }
MOPRequirement >> and: aRequirement [ 
	
	^ MOPAndRequirement left: self right: aRequirement 
]

{ #category : #controlling }
MOPRequirement >> or: aRequirement [ 
	
	^ MOPOrRequirement left: self right: aRequirement  
]

{ #category : #verifying }
MOPRequirement >> verify: anASTNode [

	^ self subclassResponsibility 
]
