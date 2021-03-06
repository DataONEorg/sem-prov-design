# PROV Ontology and Model


## Intro
The DataONE provenance data model will be used to describe the relationships between:
* Derived resources and the original resources used to create them
* Data resources and the activities used to create them
* Programs (e.g. software, scripts) that were implemented to create a data resource

##UI Mockups
* View Web UI Mockups in the [DataONE project in the Invision App](https://projects.invisionapp.com/d/main#/projects/1959670)
* Or [in this repository](https://github.com/DataONEorg/sem-prov-design/tree/master/docs/Web-UI-mockups).

## Diagrams
### Diagram of the PROV Model using a proposed revision of the ProvONE model
![ProvONE Model Diagram](https://github.com/DataONEorg/sem-prov-ontologies/raw/master/provenance/ProvONE/v1/uml/provone-model.png)

This data model uses the [W3C PROV Ontology and Data Model](http://www.w3.org/TR/prov-o/) to define classes of objects and the relationships between them. 

### Instance Diagram showing usage of ProvONE model classes and properties
![ProvONE Instance Diagram](https://github.com/DataONEorg/sem-prov-ontologies/raw/master/provenance/ProvONE/v1/examples/Provenance-instance-example-one-run.png)
This instance diagram illustrates the application of the ProvONE model to a typical scenario in which a set of source data sets are processed by an R script to generate a derived data product, which in turn is used to generate two visualizations.

### Example RDF for the ProvONE model diagram above
    
	Note: To Be Produced

## PROV-O Classes
##### [Activity](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Activity) 
* PROV-O definition: An activity is something that occurs over a period of time and acts upon or with entities; it may include consuming, processing, transforming, modifying, relocating, using, or generating entities.

##### [Agent](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Agent) 
* PROV-O definition: An agent is something that bears some form of responsibility for an activity taking place, for the existence of an entity, or for another agent's activity.
* DataONE may not capture information about agents during the first phase of the semantics and provenance work, but it is one of the major classes of the PROV-O ontology.

##### [Entity](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Entity)
* PROV-O definition: An entity is a physical, digital, conceptual, or other kind of thing with some fixed aspects; entities may be real or imaginary.

##### [Location](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Location) 
* PROV-O definition: A location can be an identifiable geographic place (ISO 19112), but it can also be a non-geographic place such as a directory, row, or column.

##### [Plan](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Plan) 
* PROV-O definition: A plan is an entity that represents a set of actions or steps intended by one or more agents to achieve some goals.

##### [Association](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Association)
* Qualifies: prov:wasAssociatedWith
* PROV-O definition: An Execution association is an assignment of responsibility to an agent for an activity, indicating that the agent had a role in the activity. It further allows for a plan to be specified, which is the plan intended by the agent to achieve some goals in the context of this activity.
* See the [qualified terms figure](http://www.w3.org/TR/prov-o/#qualified-terms-figure) in the PROV-O documentation for details about prov:qualifiedAssociation.
* From PROV-O:
	* Similarly in subfigure j, the prov:qualifiedAssociation property parallels the prov:wasAssociatedWith property and references an instance of prov:Association, which in turn provides attributes of the prov:wasAssociatedWith relation between the Activity and Agent. The prov:agent property is used to cite the Agent that influenced the Activity. In this case, the plan of actions and steps that the Agent used to achieve its goals is provided using the prov:hadPlan property and an instance of prov:Plan.  

##### [Usage](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Usage)
* Qualifies: prov:used
* PROV-O definition: Usage is the beginning of utilizing an entity by an activity. Before usage, the activity had not begun to utilize this entity and could not have been affected by the entity.

##### [Generation](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Generation)
* Qualifies: prov:wasGeneratedBy
* PROV-O definition: Generation is the completion of production of a new entity by an activity. This entity did not exist before generation and becomes available for usage after this generation.
		
## Model Specification

### Classes

 PROV-O Superclass | DataONE Subclass |
-------------------|------------------|
 Entity            | Data, Visualization, Program, Publication, Report	
 Activity          | Execution
 
 
#### Data class 
##### has superclass [prov:Entity](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Entity)
A Data object represents a basic unit of information consumed or generated by an Execution.
e.g. Data table
	
#### Visualization class 
##### has superclass [prov:Entity](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Entity)
A Visualization object is a visual representation of information and is generated by Executions.
e.g. figure, map

#### Program class
##### has superclass [prov:Entity](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Entity) and [prov:Plan](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Plan)
A Program object represents a unit of code or instructions that can be implemented (Execution) to consume and/or generate Data and Visualization objects. Becuase Program is a subclass of Entity, it can also be generated by an Execution.
e.g. script, software
From PROV-O
> Since plans may evolve over time, it may become necessary to track their provenance, so plans themselves are entities. Representing the plan explicitly in the provenance can be useful for various tasks: for example, to validate the execution as represented in the provenance record, to manage expectation failures, or to provide explanations.

#### Document class
##### has superclass [prov:Entity](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Entity)
A Document object represents a potenttially but not necessarily published document of scientific work.
e.g. scholarly journal article, government report

#### Execution class
##### has superclass [prov:Activity](http://www.w3.org/TR/2013/REC-prov-o-20130430/#Activity)
An Execution object represents a single implementation of a Program
e.g. script run

## ProvONE Properties

#### [prov:hadPlan](http://www.w3.org/ns/prov#hadPlan)
##### has domain: prov:Association (prov:wasAssociatedWith)
##### has range: Program
hadPlan is a property of an Association (e.g. prov:wasAssociatedWith) that points to the prov:Plan implemented by a prov:Activity.

#### [prov:used] (http://www.w3.org/ns/prov#used)
##### has domain: Execution
##### has range: Data, Program
Usage is the beginning of utilizing an entity by an activity. Before usage, the activity had not begun to utilize this entity and could not have been affected by the entity.

#### [prov:wasAssociatedWith] (http://www.w3.org/ns/prov#wasAssociatedWith)
##### has domain: Execution
##### has range: prov:Agent
prov:wasAssociatedWith is an assignment of responsibility to a prov:agent for an Execution, indicating that the agent had a role in the Execution. It further allows for a plan to be specified, which is the plan intended by the agent to achieve some goals in the context of this activity. 
An association must have at least one property: an id, an agent, a plan, or attributes. This DataONE PROV data model will include plans but will not include prov:Agents at this time.

#### [prov:wasDerivedFrom] (http://www.w3.org/ns/prov#wasDerivedFrom)
##### has domain: Data, Visualization, Program
##### has range: Data, Program
A derivation is a transformation of an entity into another, an update of an entity resulting in a new one, or the construction of a new entity based on a pre-existing entity.

#### [prov:wasGeneratedBy] (http://www.w3.org/ns/prov#wasGeneratedBy)
##### has domain: Data, Visualization, Program
##### has range: Execution
Generation is the completion of production of a new entity by an activity. This entity did not exist before generation and becomes available for usage after this generation.

#### [prov:wasInformedBy] (http://www.w3.org/ns/prov#wasInformedBy)
##### has domain: Execution
##### has range: Execution
Communication is the exchange of an entity by two activities, one activity using the entity generated by the other.

## SOLR properties for provenance indexing

- __wasDerivedFrom__
    - example: `compiledData.1.1 wasDerivedFrom data.1.1`
    - example: `figure.2.1 wasDerivedFrom data.1.1`
- __generatedByProgram__
    - inferenced via prov:wasGeneratedBy, prov:qualifiedAssociation, prov:hadPlan
    - example: `compiledData.1.1 generatedByProgram rScript.1.1`
- __generatedByExecution__
    - example: `compiledData.1.1 generatedByExecution execution.1.1`  (this is the prov:wasGeneratedBy property)
used
- __usedByProgram__, inferred via prov:used, prov:qualifiedAssociation, and prov:hadPlan
    - example: `data.1.1 usedByProgram rScript.1.1`
- __usedByExecution__, which is the inverse of prov:used
    - example: `data.1.1 usedByExecution execution.1.1`
- wasAssociatedWith has multiple fields, incuding two fields that aggregate the properties, and several for specific types of user identifiers
    - __usedByUser__
    - __generatedByUser__
    - [ ] specific fields will be
        - __usedByOrcid__
        - __usedByDataONEDN__
        - __usedByFoafName__
        - __generatedByOrcid__
        - __generatedByDataONEDN__
        - __generatedByFoafName__
    - example: `data.1.1 usedByFoafName "Matthew Jones"`
    - example: `data.1.1 generatedByOricid http://orcid.org/0000-0003-0077-4738`
- __wasExecutedBy__, which is inferred from prov:qualifiedAssociation and prov:hadPlan
    - example: `rScript.1.1 wasExecutedBy (hasExecution?) execution.1.1`
ProvONE types
- __instanceOfClass__, multivalued, defined as a string URI, 
    - similar to Ben's annotation field
    - Value would be a URI that represents an OWL class, with potential values such as the URIs for `p1:User`, `p1:Program`, `p1:Visualization`, `prov:Plan`, `prov:Entity`, `p1:Execution`, `p1:Document`


## Other Vocabulary

#### FOAF - to describe Agent subclasses
The [FOAF](http://xmlns.com/foaf/spec/) vocabulary may be useful for defining subclasses and properties of Agent. 
* Possible subclasses to use: [foaf:Person](http://xmlns.com/foaf/spec/#term_Person) (The Person class represents people.) and [foaf:Organization](http://xmlns.com/foaf/spec/#term_Organization).
* foaf:Person can be described with name properties (e.g. [foaf:firstName](http://xmlns.com/foaf/spec/#term_firstName), [foaf:lastName](http://xmlns.com/foaf/spec/#term_lastName)), online accounts (e.g. [foaf:openID](http://xmlns.com/foaf/spec/#term_openid)), online documents or webpages (e.g. [foaf:workInfoHomepage](http://xmlns.com/foaf/spec/#term_workInfoHomepage)), [foaf:publications](http://xmlns.com/foaf/spec/#term_publications), and other things that typically make up an online profile.

#### Dublin Core - to describe Entity subclasses
The [DCMI Type Vocabulary](http://dublincore.org/documents/2012/06/14/dcmi-terms/#H7) is used to categorize the nature or genre of resources.
* [dcmitype:Dataset](http://dublincore.org/documents/2012/06/14/dcmi-terms/?v=dcmitype#dcmitype-Dataset) is data encoded in a defined structure, such as lists, tables, and databases, A dataset may be useful for direct machine processing.
	* dcmitype:Dataset could be used to describe the Data subclass of prov:Entity.
* The broadest type of Visualization is a [dcmitype:Image](http://dublincore.org/documents/2012/06/14/dcmi-terms/?v=dcmitype#Image), a visual representation other than text. Examples include images, graphics, animations, diagrams, maps. dcmitype:Image has subclasses [dcmitype:MovingImage](http://purl.org/dc/dcmitype/MovingImage) and [dcmitype:StillImage](http://purl.org/dc/dcmitype/StillImage).
	* DataONE use: Could be used to describe the Visualization subclass of prov:Entity.
	* dcmitype:StillImage is a static visual representation - e.g. maps, graphics.
		* DataONE use: Could be used as a subclass of prov:Entity,Visualization.
	* dcmitype:MovingImage is a series of visual representations imparting an impression of motion when shown in succession - e.g. animations, videos, visual output from a simulation.
		* DataONE use: Could be used as a subclass of prov:Entity,Visualization.  
* [dcmitype:InteractiveResource](http://purl.org/dc/dcmitype/InteractiveResource) is a resource requiring interaction from the user to be understood, executed, or experienced.
	* DataONE use: Could be another subclass of prov:Entity since interactive graphics and interfaces can be generated by an Execution via R, for example.
	* dcmitype:InteractiveResource is **not** a subclass of dcmitype:Image.
* [dcmitype:Software](http://purl.org/dc/dcmitype/Software) is a computer program in source or compiled form.
	* DataONE use: Use as the definition for the Program subclass.

 

 

