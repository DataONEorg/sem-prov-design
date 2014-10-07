
DataONE Use Case 50 (Automatic Annotation)
==========================================

Measurement Characteristics and Standards can be assigned automatically using existing metadata
------------------------------------------------------------------------------------------------

Revisions
---------
2014-10-07: Created

Goal
----
Using existing attribute-level metadata (column names, labels, definitions, units), a utility can automatically generate semantic annotations
for the data objects.

Scenario
--------
Given the large corpus of existing/historical metadata within the DataONE network, we want to quickly categorize the measurement characteristics and standards
used by data packages uploaded to DataONE repositories. Tying these measurements to clearly defined concepts in one or more ontologies will allow us to 
provide more precise query results while also expanding our query criteria to include subclasses of annotation concepts.

Summary
-------
Using natural language to do a "first pass" at assigning semantic annotations will help organize our holdings and [hopefully] provide better search recall.


Sequence Diagram
----------------
.. 
    @startuml images/uc_50_seq.png 
		participant "Ontology repository" as ontrepo
		participant "Annotation generator" as autoann
		participant "Object Store" as store 
		
		note left of ontrepo: e.g., BioPortal
		note left of autoann: TBD
		note left of store: e.g., CN or MN
			  
	  autoann -> store: getMetadata()
	  note right
	  	retrieve existing
	  	metadata
	  end note
	  store -> autoann: metadata
	  
	  autoann -> ontrepo: getConcepts(metadata)e
	  ontrepo -> autoann: concepts
	  note right
	  	Parse existing 
	  	metadata to find
	  	concept matches
	  end note
	  autoann -> autoann: generate annotation  
	  autoann -> store: save(annotation)
	  note left
	  	Generated annotation
	  	as OpeanAnnotation model
	  	instance (likely RDF/XML)
	  end note
    @enduml
   
.. image:: images/uc_50_seq.png

Actors
------
* Annotation generator
* Ontology repository
* Member Node/Coordinating Node

Preconditions
-------------
* Datapackages with attribute-level metadata needs to be registered in DataONE network
* The annotation generator must have read-access to the metadata
* The annotation generator must have write access to the CN/MN store. TBD.

Postconditions
--------------
* The generated annotations are stored on the Coordinating Node.
* The annotations are marked as being created by the automatic process
* The annotations share the same permissions as the metadata upon which they are based.

Notes
-----

Use Case Implementation Examples
--------------------------------


