
DataONE Use Case 52 (Semantic search)
==========================================

Searches for DataONE-hosted data packages that match semantic measurement concepts
----------------------------------------------------------------------------------

Revisions
---------
2014-10-07: Created
2014-10-13: Updated to reflect discussion at weekly meeting
2014-11-21: added a section called "Background" which describes the LTER primary production data discovery problem

Goal
----
Query for datapackages using semantic measurement concepts about characteristics and standards.


Scenario
--------
In addition to querying for datapackages using keywords and coverage information, users will be able to query 
datapackages that include measurement annotations matching desired concepts for Characteristics and Standards.




Five Science Scenarios are included here to illustrate how scientist use data:

A. Coastal marine primary production: A scientist wants to know total annual net ecosystem primary production in a  coastal marine environment in southern California. This will entail discovering and processing (e.g., summing) the areal production rates for several groups of primary  producers, e.g., a) phytoplankton, b) benthic turf algae, c) seagrass  beds, d) kelp. Individual measurements required different methods due to differences in organism size and growth rate. Some measurements may be reported for  an entire community (phytoplankton, algal turf). Some may be  species-specific (kelp, seagrass, turf). The scientist expects to  discover measurements in a variety of time scales (daily to annual), and  spatial dimensions (volumetric or areal); possibly but less likley, different spatial scales (most scaled to meter).

Possible queries the KR will need to address: Q4, Q9
 

B. Processes contributing to NEE in a forest: Terrestrial carbon budgets are generally constructed either by a) measuring specific sizes and changes in pools over time, b) directly measuring fluxes, or c) modeling. A scientist wants to compare the results of different methods of constructing carbon budgets in a forest, and so will need access to many different measurements, eg. mass of foliar, woody, root, litter and soil carbon, accumulation rates (for the same pools), autotoropthic, heterotrophic respiration rates, eddy  covariance (NEE) (e.g., from Table 1,  http://www.geos.ed.ac.uk/home/homes/mwilliam/Williams05a.pdf)

Possible queries the KR will need to address: Q1, Q2


D. Annual above-ground NPP in a grassland during droughts [NOTE: this scenario was adapted from the MsTMiP scenario in use case 42, but is now for a data-discovery point of view. ]
A scientist is studying drought recovery in grasslands. He wants to compare  the MsTMIP model output to other "benchmark" data sets, so needs data  from the MsTMIP central data repository, plus other data relating above  ground NPP to precipitation rates in grasslands. He will perform  additional data processing.

Possible queries the KR will need to address: Q1, Q3, Q6, Q7, Q8


D. Compare biomes: A scientist has a study to compare primary production rates across several biomes studied in the LTER, eg, temperate forests, grasslands, nearshore ocean and salt marshes.  

Possible queries the KR will need to address: Q1, Q3, Q6, Q7, Q8


Lastly, this scenario would necessitate a KR extension. A likely extenstion would be to add terms related to ocean acidification and carbonate chemistry. Like research in primary production, the study of ocean acidification also addresses the effects of anthropogenic CO2. The form of CO2 found in natural water bodies is bicarbonate ion (HCO3-), and bicarbonate is consumed by phytoplankton during photosynthesis. 

E. Ocean acidification and carbonate chemistry: The ocean has absorbed one-third to half the atmospheric CO2 produced by human fossil fuel combustion. Dissolved CO2 in the ocean becomes carbonic acid, driving the pH down and causing large shifts in seawater carbonate  chemistry speciation. A scientist wants to understand possible changes to calcium carbonate saturation states, which impact shell-forming marine  organisms (e.g., molluscs, echinoderms and corals). For this, she needs to find environmental observations on pH, alkalinity, and carbonate-system parameters. The scientists knows that given a minimum set of inputs, a suite of carbonate chemisrty parameters can be calculated (concentrations, equilibrium constants, indices).

Possible queries the KR will need to address: Q5, Q10




Summary
-------
Additional query facets will be specified just like keywords, but will support more precise matches as well as 
subclass matching when the query specifies a broader concept. For example, a query for the characteristic concept
of "Mass" would return datapackages that were annoted as either having "WetMass" or "DryMass".

Typically, a user will select a concept from a list of available concepts. These could be displayed in a flat list or
using a tree structure so that relationships between parent and children are easily seen. In prior iterations of these
types of interfaces, it has been useful to show the hierarchical context for concepts and whether or not we have content 
for any one of those concepts shown.

Sequence Diagram
----------------
.. 
    @startuml images/uc_52_seq.png 
		database "Ontology repository" as ontrepo
	  	database "Index" as index 
		participant "Web UI" as webui
	  	actor "User" as user
		
		note left of ontrepo: e.g., BioPortal
		note left of index: e.g., SOLR
	  	note left of webui: e.g., MetacatUI
		
		user --> webui: enter text
		note right
			User begins by entering
			text for the concept of interest
		end note
		webui --> ontrepo: getConcepts(text)
		note left
			Query the ontology
			repository for measurement
			concepts that may match the
			entered text
		end note
		ontrepo --> webui: concepts	
		user --> webui: select concept
		note right
			User selects one of the
			suggested concepts

		end note	  
		webui -> index: query(concept)
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
* web UI for selecting concepts, issuing query, and displaying results

Preconditions
-------------
* Semantic annotations for the datapackage identifier must be present in the discovery index
* Concepts to search by must be available somewhere (e.g., BioPortal)

Postconditions
--------------
* Query results returned by datapackage identifier, minimally.

Sample Queries
---------------
Sample queries that we can support, in increasing order of complexity.  These will be divided into implementation phases.

- Queries using only oboe:Characteristic
    - List datasets with measurements of
    
        Q1: above ground net primary productivity
            SELECT ?identifier {
                ?agnpp a lter:AboveGroundNetPrimaryProduction
                lter:AboveGroundNetPrimaryProduction a oboe:Characteristic
            }
        Q2: heterotrophic soil respiration at the ecosystem level
            SELECT ?identifier {
                ?heterresp a lter:HeterotrophicSoilRespiration
                lter:HeterotrophicSoilRespiration a oboe:Characteristic
            }
            
        Q5: concentration of carbonate species in the ocean (C02, bicarbonate, carbonate)
        
        
- Queries using oboe:Characteristic and oboe:Entity
    - List datasets with measurements of
        
        Q3: the amount of carbon (grams) in soil microbial communities
            
        Q4: areal CO2 uptake rate by natural phytoplankton communities  
    
        Q6: rate of release of carbon dioxide from soil
        
        Q7: uptake of CO2 in a grassland when CO2 is experimentally added 
        
        Q8: areal rate of methane released from soil
        
        Q9: annual rate of net primary production for coastal macroalgae
        
        Q10: CO2 absorption by the ocean

Notes
-----
The current implementation plan - using the SOLR index for semantic queries - does not allow the user to specify 
[Characteristic AND Standard] for a single attribute. So in datapackages with attributes that match either of those
criteria we will get what loks like an odd result (Characteristic: Height AND Standard: Gram).

Support for querying entity is not planned (e.g., no "Height of a Tree" criteria).

Use Case Implementation Examples
--------------------------------


