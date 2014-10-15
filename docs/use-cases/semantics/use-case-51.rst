
DataONE Use Case 51 (Manual Annotation)
==========================================

User edits or adds annotations to DataONE-hosted data packages
--------------------------------------------------------------

Revisions
---------
2014-10-07: Created
2014-10-13: Updated to reflect discussion at weekly meeting

Goal
----
Using a web UI, a user can add or edit annotations about the measurement characteristics and standards used in a data package.

Scenario
--------
When viewing metadata for existing data packages, a user can easily and clearly select concepts from one [or more?] ontologies that describe the measurement 
characteristics (e.g., Temperature) and standards (e.g., Celsius) used. These concepts are the body of the annotations.

Summary
-------
The user may add annotations from scratch or edit an existing one. 
If we can constrain the list of possible concepts using recommendations from the ontology repository
given values from our existing metadata descriptions of the attributes it could be helpful, but not necessarily required especially if the UI for selecting 
concepts is easy to navigate.


Sequence Diagram
----------------
.. 
    @startuml images/uc_51_seq.png 
		database "Ontology repository" as ontrepo
		database "Object Store" as store 
		participant "Web UI" as webui
	  	actor "User" as user
		
		note left of ontrepo: e.g., BioPortal
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
	  
	  webui --> ontrepo: getConcepts()
	  ontrepo --> webui: concepts
	  note right
	  	Concept recommendations
	  	presented to user based 
	  	on metadata content and/or
	  	existing automated annotations
	  end note
	  user -> webui: annotate metadata
	  webui -> store: save(annotation)
	  note right
	  	User confirms and/or edits
	  	automated annotations
	  end note
    @enduml
   
.. image:: images/uc_51_seq.png

Actors
------
* Annotation library
* Ontology repository
* Member Node/Coordinating Node
* web UI for rendering metadata + annotations

Preconditions
-------------
* Datapackages with attribute-level metadata needs to be registered in DataONE network
* The user must have read-access to the metadata
* The user must have write access to update annotations
* The user must have write access to the CN/MN to save annotations

Postconditions
--------------
* The new/updated annotations are stored on the Coordinating Node.
* The annotations are marked as being created/edited by the user as applicable
* Annotation permission options:
	* share the same permissions as the metadata upon which they are based
	* have all permission for the creator, read-only access for everyone else

Notes
-----
We anticipate annotations be added by these three types of users:
* original datapackage owner ("owner")
* some other user of the system, perhpas someone who has used the data in their own research and would like to 
clarify the attribute-level metadata ("3rd party")
* the automated annotator process ("annotation generator")

The UI for selecting concepts needs to clearly show differences in concepts, espically for MsTMIP concepts that are similar but cann differ in 
subtle ways.

Use Case Implementation Examples
--------------------------------


