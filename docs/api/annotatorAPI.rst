
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


annotator.getMatchingConcepts(query) -> matchedConceptsWithScores
-----------------------------------------------------------------

annotator.getMatchingConcepts describes the function that will be called whenever part of the annotation system needs to establish a match between some natural language metadata and a specific set of concepts from one or more ontologies. The API signature should take natural language metadata fields as input, and return a list of matching concepts URIs with associated scores indicating the effectiveness of the match.


**use cases**: uc50_, uc52_.


**parameters**:

- query(String): queries are composed of one or more keywords. 

	- All keywords are separate by ",". ex. snow, depth, meter,….
	- To describe the type of keywords use "()". ex. depth(thickness). 
	- Accepts multiple types, separated by ";". ex. meter(unit; length).


**return**:

	- type: ArrayList<Annotation>
	- Annotation{keyword, concept, score}



.. _uc50:https://github.com/DataONEorg/sem-prov-design/blob/master/docs/use-cases/semantics/use-case-50-Automatic-Annotation.rst
.. _uc52:https://github.com/DataONEorg/sem-prov-design/blob/master/docs/use-cases/semantics/use-case-52-Semantic-Search.rst
