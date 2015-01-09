
annotator API
=============

Revisions
---------
2015-01-09: Created

+----------------------------------+----------------------------------+----------------------------------+ 
| Function                         | Parameters                       | return                           | 
+==================================+==================================+==================================+ 
|**annotator.getMatchingConcepts** | query       		      | matchedConceptsWithScores   	 | 
+----------------------------------+----------------------------------+----------------------------------+ 


**annotator.getMatchingConcepts(query) -> matched concepts with scores**


annotator.getMatchingConcepts describes the function that will be called whenever part of the annotation system needs to establish a match between some natural language metadata and a specific set of concepts from one or more ontologies. The API signature should take natural language metadata fields as input, and return a list of matching concepts URIs with associated scores indicating the effectiveness of the match.


**use cases**: uc50, uc52.


**parameters**:

- query(string)
	- queries are composed of one or more keywords 
	- all keywords are separate by ",". ex. snow, depth, meter,…
	- to describe the type of keywords use "()". ex. depth(thickness) 
	- accepts multiple types, separated by ";". ex. meter(unit; length)


**return**:

- ArrayList<Annotation>
	-Annotation{keyword, concept, score}

