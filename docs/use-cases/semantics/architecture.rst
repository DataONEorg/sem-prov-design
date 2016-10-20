Semantic Architecture proposal
===================================

Author: Ben Leinfelder

Date: October, 2014: Initial draft of semantic architecture 

Updated: October 2016 to reflect curent state

Goal: Describe components to be used and/or built to support semantic annotation 

Summary:
  
This architecture attempts to re-use as many existing DataONE components as possible while also building on existing efforts in the 
annotation realm.
Much of the UI is based on the Open Knowledge Foundation's annotation tools, including: 
AnnotatorJS (http://annotatorjs.org/) and their AnnotateIt (http://annotateit.org/) storage service. 
  
  
Overview
---------------------------------------
There will be a model for storing and communicating annotations.
There will be a mechanism for storing annotations.
There will be a component for indexing and querying annotations.

Model
------------------
The OA ontology (http://www.openannotation.org/spec/core/) is attractive for capturing and transferring annotations. But the AnnotatorJS 
library does not yet support this serialization in released 1.x versions.
The serialization of annotations can take multiple forms and can be included in other objects that may already be indexed by DataONE.
Some examples include:

* Atomic OA documents that contain one or more annotations (sserialized as RDF/XML and/or) JSON-LD
* Extended ORE documents	
* Embedded OA annotations in XML metadata (e.g., EML's additionalMetadata section)

We will focus on atomic annotation documents that can be parsed queried to populate a discovery index (e.g., SOLR)

Notes:

Our actual implementation has focused on JSON-based annotations that do not fully conform to the OA model. The AnnotatorJS library
is actively pursuing a JSON-LD format that does conform to Open Annotation, but that is not mature at this point (still, in 2016)


Proposed components
--------------------

.. image:: images/semantic_architecture.png

.. 
    @startuml images/semantic_architecture.png  
	  participant "Ontology repository" as ontrepo
	  participant "Annotation generator" as autoann
	  participant "Object Store" as store
	  participant "[Semantic Indexer]" as indexer
	  participant "Index" as index  
	  participant "Web UI" as webui
	  actor "User" as user
	    
	  note left of ontrepo: e.g., BioPortal
	  note left of autoann: TBD
	  note left of store: e.g., Metacat
	  note left of indexer: Expands concepts from ontology   
	  note left of index: e.g., SOLR
	  note left of webui: e.g., MetacatUI
	
	  == Auto-generate annotations ==
	  
	  autoann -> store: getMetadata()
	  store -> autoann: metadata
	  note left
	  	retrieve existing
	  	metadata
	  end note
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
	  
	  store --> indexer
	  note left
	  	load ontology and expand annotation concepts
	  end note
	  indexer --> index: fields
	  note right
	  	to populate index
	  end note
	   
	  == Verify/Edit annotations ==
	  
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
	  
	  store --> indexer: annotation
	  indexer --> index: fields
	  note left
	  	Annotations reindexed 
	  	as before
	  end note
	  
	  == Query annotations ==
	  
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
	
	
Annotation life-cycle
---------------------
This figure attempts to show the route that annotations take throughout
the system. First, automated annotations are generated from existing metadata,
then the annotation is saved to the object store, then an indexing process loads the 
referenced ontology to use a semantic query to extract index fields
from it that are saved to the SOLR index.
Finally, the UI shows the search results and annotation details for further manual editing 
of the annotations.

.. image:: images/annotation_flow.png

.. 
    @startuml images/annotation_flow.png
				
		partition "Automated annotation" {
			"get metadata" --> "generate annotation"
			"get matching concepts" --> "generate annotation"
			-left-> "store annotation"
		}
		
		partition Indexing {
			--> "load ontology"
			--> "query model"
			--> "index semantic fields"
			--> "SOLR index"
			
		}
		
		partition "Manual annotation" {
			
			"render annotations" -> "metadata UI"
			"render metadata" --> "metadata UI"
			"metadata UI" -up-> "create/update annotation"
			-right-> "store annotation"
			
		}
		
		partition "Querying" {
			"query UI" --> "query SOLR index"
			--> "SOLR index"
			--> "render results"
			if "" then
				--> [match?]"show details"
				--> "metadata UI"
			else 
				--> "query UI"	
			endif

			

		}
	@enduml		



Annotation components
----------------------
This diagram attempts to illustrate the different components involved in 
automatically generating annotations, saving them, indexing them, querying them, 
displaying them, and then editing them manually.

.. image:: images/annotation_components.png

.. 
    @startuml images/annotation_components.png
		
		"Annotation generator" --> [getConcepts] "Ontology repository"
		
		"Ontology repository" --> [concepts] "Annotation generator"
		note left
			Recommends concepts 
			using existing attribute 
			metadata
		end note
		"Annotation generator" -->[Save annotation] "Store"
		note right
			Use member node
			as the annotation store.
			Also holds metadata documents
		end note
		
		"Web UI" --> [Save annotation] "Store"
		"Store" --> [Rendered annotation] "Web UI"			
		"Store" --> [Rendered Metadata] "Web UI"
		note left
			UI renders metadata
			and overlays annotations
			on the page
		end note
		note right
			UI creates and 
			edits annotations
			using suggestions 
			from ontology repo
		end note
		
		"Web UI" --> [getConcepts] "Ontology repository"
		"Ontology repository" --> [concepts] "Web UI"
		
		
		"Store" --> [Get annotation] "Indexer"
		note right
			When annotations are updated,
			indexer reloads and queries 
			the model for indexing
		end note
		"Indexer" --> [SPARQL query] "Ontology model"	
		"Ontology model" --> [SPARQL results] "Indexer"
		"Indexer"-->[SOLR fields] "SOLR index"
		note left
			Existing SOLR index
			includes semantic fields
			for quick searching
		end note
		"Web UI" --> [SOLR query] "SOLR index"
		"SOLR index" --> [SOLR results] "Web UI"
	
		

	@enduml	


