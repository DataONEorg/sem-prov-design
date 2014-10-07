
DataONE Use Case 52 (Semantic search)
==========================================

Searches for DataONE-hosted data packages that match semantic concepts
-----------------------------------------------------------------------

Revisions
---------
2014-10-07: Created

Goal
----
Query for datapackages using semantic concepts.

Scenario
--------
In addition to querying for datapackages using keywords and coverage information, users will be able to query 
datapackages that include measurements matching desired concepts for Characteristics and Standards.

Summary
-------
Additional query facets will be specified just like keywords, but will support more precise matches as well as 
subclass matching when the query specifices a broader concept.


Sequence Diagram
----------------
.. 
    @startuml images/uc_52_seq.png 
		participant "Ontology repository" as ontrepo
	  	participant "Index" as index 
		participant "Web UI" as webui
	  	actor "User" as user
		
		note left of ontrepo: e.g., BioPortal
		note left of index: e.g., SOLR
	  	note left of webui: e.g., MetacatUI
		
		webui --> ontrepo: getConcepts()
		ontrepo --> webui: concepts	
		user --> webui: select concept	  
		webui -> index: query()
		index -> webui: search results
		note right
		  	query against
		  	semantic fields 
		  	in index return 
		  	metadata document
		  	matches
		end note
		webui --> user: rendered results
	  
    @enduml
   
.. image:: images/uc_52_seq.png

Actors
------
* Discovery Index
* Ontology repository
* web UI for issuing query and displaying results

Preconditions
-------------
* Semantic annotations for the datapackage identifier must be present in the discovery index
* Concepts must to search by must be available somewhere (e.g., BioPortal)

Postconditions
--------------
* Query results returned by datapackage identifier, minimally.


Notes
-----

Use Case Implementation Examples
--------------------------------


