Class {
	#name : 'MOPMethodsRequirement',
	#superclass : 'MOPRequirement',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'verifying' }
MOPMethodsRequirement >> verify: anASTNode [
	
	
	^ anASTNode isMethod 


]
