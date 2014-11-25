
DataONE Use Case 56 (Carbon Cycle KR)
==========================================

Onotology for carbon cycle measurement concepts
-----------------------------------------------

Revisions
---------
2014-10-13: Created

Goal
----
Create ontology for carbon cycle/primay production concepts for use in annotating LTER data as well as MsTMIP model output.

Scenario
--------
Users must have a fully specified knowledge model for measurement types in the carbon cycle/ primary production realm
Given that we have found no pre-exisint comprehensive knowledge model for this domain, we will endeavor to create one.



Background
--------

1. Problem Description

Primary production is the synthesis of organic compounds from atmospheric or aqueous carbon dioxide, and the energy produced is the basis for most of life on earth. The process is also called "carbon fixation". The stoichiometry is well known. Studying the long term patterns of primary production is one of the core research areas at every site in the Long Term Ecological Research Network (LTER, http://www.lternet.edu). One typically reported measurement is “net primary production” (NPP), defined as the difference between gross primary production and autotrophic respiration(1). NPP then, is the carbon fixed that is not used by the autotroph in its own metabolism, and so available for export (e.g., use by some other organism) or sequestration (e.g., burial). The units are typically mass per area per time, e.g., grams carbon per square meter per year (g/m2/y). Biochemically-oriented studies will use moles of carbon instead of mass.

The features of each LTER site’s measurements of NPP are determined locally and depend on the organisms being studies, e.g., their sizes, growth rates and sometimes community composition. Consequently, field methods for measuring NPP vary widely. Primary production for phytoplankton (which are microscopic and fast-growing) is usually measured by short-term uptake of radioactive carbon (C14). Primary production by algae attached to the bottom (or another substract) is often measured by oxygen evolution in chambers by (then converted stoichiometrically to Carbon fixed). Both these methods require short time scales (hours) and are usually community-level measurements. In grasslands, NPP is measured for "annuals" by harvesting at "peak biomass" (and should be accompanied by additonal data on plant carbon content). For the entire community, individual measurments would be summed. For large, slow-growing trees in a forest, algorithms are constructed which are based on growth rates (e.g., change in height), plus other allometrics and carbon content. At the ecosystem level, whole-ecosystem CO2 flux might be measured. In addition to differences in scale, methods have different assumptions and limitations, so it can be difficult to compare any pair of NPP values.

LTER has a SKOS-based vocabulary which is employed in searches for any data.  NPP-related terms number fewer than 20, and are generally high level (eg, "net primary production", "soil respiration"). There are no terms describing field NPP methods.  A search for “primary production” in EML fields title, abstract, keywords returned 639 data packages from 21 of 26 sites. It is not clear how many of these actually contain data on NPP (e.g, mass carbon/time/area). In some cases, resultset data are clearly related to NPP, e.g., data are about plant carbon content (e.g., metadata records knb-lter-sbc.24 and knb-lter-pie.200) or community metabolism (e.g., metadata records knb-lter.mcr.18). Other datasets in the resultset appear to be driver data for a model which outputs NPP, such as the meteorology data in knb-lter-luq.127.

LTER’s needs are predominantly discovery-related. Scientists conducting synthesis projects using LTER data need to
a) accurately find data sets containing NPP with the appropriate dimensions, and
b) learn enough about the methods used in different studies to evaluate their compatiblity.
The challenge will be to accurately capture the features of NPP measurements in semantic structures. Quite possibly, every dataset has unique features although not all will need to be captured semantically.

2. Overlap between LTER and MsTMIP

MsTMIP (Multi-scale Synthesis and Terrestrial Model Intercomparison Project, http://nacp.ornl.gov/MsTMIP.shtml ) is a multi-scale comparison of carbon flux model results and observations. The overall goal is to provide feedback to the terrestrial biospheric modeling community to improve the diagnosis and attribution of carbon sources and sinks. NPP represents one of the carbon “sinks”. But because the project is primarily concerned with model results, its needs are mainly to track data provenance, and data-discovery issues are secondary.
 
MsTMIP’s central measurement is Net Ecosystem Exchange, (NEE), which - like primary production - is a flux, reported in units of carbon mass per area per time. Whereas NPP might be reported for only a part of the community, population or functional group (e.g., phytoplankton, grasses, algae, or fir trees), NEE refers to the entire ecosystem, usually on a regional scale. In its description of sources and sinks to NEE, MsTMIP has identified measurements which are likely to be comparable to LTER measurements. Developing semantic structure for carbon flux should meet discovery and/or provenance aspects of both.

Because MsTMIP models all output NPP, their data discovery needs differ from LTER's. Scientists using MSTMIP data will need to:
a) know which MsTMIP-model produced this dataset
b) find appropriate benchmark data for model evaluation 

Future extensions may include 
modeling/annotating the MsTMIP models themselves (although not in the first part of phase 2). 
adding concepts for other CO2 cycle process, e.g., for ocean acidification.



Summary
-------
With input from daomin experts, a compete ontology will be created to capture measurement characteristics and standards in a 
way that clarifies MsTMIP variables and allows LTER to fully describe their observational data.
The ontology should fit modelling patterns outlined in one or more of:
* OBOE
* O&M (lite)
* other (TBD)

Sequence Diagram
----------------


Actors
------

Preconditions
-------------

Postconditions
--------------
* A "complete" knowledge model that can be used to fully annotated LTER and MsTMIP datapackages.

Notes
-----
This isn't so much a use case as simply laying out the KR requirements.

Use Case Implementation Examples
--------------------------------


