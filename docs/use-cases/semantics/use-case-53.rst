
DataONE Use Case 53 (Confirm Annotation)
==========================================

Owner confirms or refutes an annotation
--------------------------------------------------------------

Revisions
---------
2014-10-08: Created

Goal
----
Using a web UI, a user can confirm or refute existing annotations that were added either by a 3rd party or an automatic annotation process.

Scenario
--------
The owner of a given data package should have the ability to mark automatic annotations as correct (or incorrect) when reviewing the results of
automatic annotations.
Similarly, annotations from colleagues and other parties should be subject to the same review. TBD: reviews and comments about the quality of the data
rather than just the semantic concepts contained.

Summary
-------
Using a simple checkbox, 


Sequence Diagram
----------------
.. 
    @startuml images/uc_53_seq.png 
		participant "Object Store" as store 
		participant "Web UI" as webui
	  	actor "User" as user
		
		note left of store: e.g., CN or MN
	  	note left of webui: e.g., MetacatUI
		
			  
	  store -> webui: metadata
	  store -> webui: annotations
	  note right
	  	MetacatUI renders metadata;
	  	Annotations displayed with
	  	AnnotatorJS
	  end note
	  webui --> user: rendered metadata	  
	  user -> webui: confirm/refute annotation
	  webui -> store: update(annotation)
	  note right
	  	User confirms/refutes
	  	annotations
	  end note
    @enduml
   
.. image:: images/uc_53_seq.png

Actors
------
* Annotation library
* Member Node/Coordinating Node
* web UI for rendering metadata + annotations

Preconditions
-------------
* Datapackages with attribute-level metadata need to be registered in DataONE network
* The user must have write access to the object in order to approve or remove recommended annotations
* The user must have write access to the CN/MN to update annotations

Postconditions
--------------
* The updated annotations are stored on the Coordinating Node.
* The annotations are marked as being updated and verified by the user as applicable

Notes
-----

Use Case Implementation Examples
--------------------------------


