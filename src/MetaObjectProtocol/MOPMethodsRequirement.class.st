Class {
	#name : #MOPMethodsRequirement,
	#superclass : #MOPRequirement,
	#category : #'MetaObjectProtocol-Requirement'
}

{ #category : #verifying }
MOPMethodsRequirement >> verify: anASTNode [
	
	
	^ anASTNode isMethod 


]
