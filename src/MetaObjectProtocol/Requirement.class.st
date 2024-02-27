Class {
	#name : #Requirement,
	#superclass : #Object,
	#category : #MetaObjectProtocol
}

{ #category : #controlling }
Requirement class >> and: aRequirement [

	^ AndRequirement left: self right: aRequirement 
]

{ #category : #controlling }
Requirement >> and: aRequirement [ 
	
	^ AndRequirement left: self right: aRequirement 
]

{ #category : #controlling }
Requirement >> or: aRequirement [ 
	
	^ OrRequirement left: self right: aRequirement  
]

{ #category : #verifying }
Requirement >> verify: anASTNode [

	^ self subclassResponsibility 
]
