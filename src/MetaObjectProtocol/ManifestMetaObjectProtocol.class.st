"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestMetaObjectProtocol',
	#superclass : 'PackageManifest',
	#category : 'MetaObjectProtocol-Manifest',
	#package : 'MetaObjectProtocol',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestMetaObjectProtocol class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MsOPProxy #object:metaObject: #false)) #'2024-02-19T17:04:45.732924+01:00') )
]
