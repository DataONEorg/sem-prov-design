LTER and DataONE: A Science Workflow Scenario for Data Discovery
=======================================================================

Improving scientific data discovery through semantics
-----------------------------------------------------------------------

1: Problem description
---------------------------
Primary production is the synthesis of organic compounds from atmospheric or aqueous carbon dioxide, and the energy produced is the basis for most of life on earth. The process is also called "carbon fixation". The stoichiometry is well known. Studying the long term patterns of primary production is one of the core research areas at every site in the Long Term Ecological Research Network (LTER, http://www.lternet.edu). One typically reported measurement is "net primary production" defined as the difference between gross primary production and autotrophic respiration(1). NPP then, is the carbon fixed that is not used by the autotroph in its own metabolism, and so available for export (e.g., use by some other organism) or sequestration (e.g., burial). The units are typically mass per area per time, e.g., grams carbon per square meter per year (g/m2/y). Biochemically-oriented studies will use moles of carbon instead of mass.

The features of each LTER siteâs measurements of NPP are determined locally and depend on the organisms being studied, e.g., their sizes, growth rates and sometimes community composition. Consequently, field methods for measuring NPP vary widely. Primary production for phytoplankton (which are microscopic and fast-growing) is usually measured by short-term uptake of radioactive carbon (C14). Primary production by algae attached to the bottom (or another substrate) is often measured by oxygen evolution in chambers by (then converted stoichiometrically to Carbon fixed). Both these methods require short time scales (hours) and are usually community-level measurements. In grasslands, NPP is measured for "annuals" by harvesting at "peak biomass" (and should be accompanied by additional data on plant carbon content). For the entire community, individual measurements would be summed. For large, slow-growing trees in a forest, algorithms are constructed which are based on growth rates (e.g., change in height), plus other allometrics and carbon content. At the ecosystem level, system CO2 flux might be measured using a flux tower, or component contributions estimated from satellite imagery. In addition to differences in scale, methods have different assumptions and limitations, so it can be difficult to compare any pair of NPP values.

LTER has a SKOS-based vocabulary which is employed in searches for any data.  NPP-related terms number fewer than 20, and are generally high level (eg, "net primary production", "soil respiration"). There are no terms describing field NPP methods.  A search for "primary production" in EML fields title, abstract, keywords returned 639 data packages from 21 of 26 sites. It is not clear how many of these actually contain data on NPP (e.g, mass carbon/time/area). In some cases, resultset data are clearly related to NPP, e.g., data are about plant carbon content (e.g., metadata records knb-lter-sbc.24 and knb-lter-pie.200) or community metabolism (e.g., metadata records knb-lter.mcr.18). Other datasets in the resultset appear to be driver data for a model which outputs NPP, such as the meteorology data in knb-lter-luq.127.

LTER's needs are predominantly discovery-related. Scientists conducting synthesis projects using LTER data need to
- accurately find data sets containing NPP with the appropriate dimensions, and
- learn enough about the methods used in different studies to evaluate their compatibility.
The challenge will be to accurately capture the features of NPP measurements in semantic structures. Quite possibly, every dataset has unique features although not all will need to be captured semantically.

2. Overlap between LTER and MsTMIP
---------------------------
MsTMIP (Multi-scale Synthesis and Terrestrial Model Intercomparison Project, http://nacp.ornl.gov/MsTMIP.shtml ) is a multi-scale comparison of carbon flux model results and observations. The overall goal is to provide feedback to the terrestrial biospheric modeling community to improve the diagnosis and attribution of carbon sources and sinks. NPP represents one of the carbon âsinksâ
 the project is primarily concerned with model results, its needs are mainly to track data provenance, and data-discovery issues are secondary.

MsTMIPâs central measurement is Net Ecosystem Exchange, (NEE), which - like primary production - is a flux, reported in units of carbon mass per area per time. Whereas NPP might be reported for only a part of the community, population or functional group (e.g., phytoplankton, grasses, algae, or fir trees), NEE refers to the entire ecosystem, usually on a regional scale. In its description of sources and sinks to NEE, MsTMIP has identified measurements which are likely to be comparable to LTER measurements. Developing semantic structure for carbon flux should meet discovery and/or provenance aspects of both.

Because MsTMIP models all output NPP, their data discovery needs differ from LTER's. Scientists using MSTMIP data will need to:
- know which MsTMIP-model produced this dataset
- find appropriate benchmark data for model evaluation

Future extensions may include
modeling/annotating the MsTMIP models themselves (although not in the first part of phase 2).
adding concepts for other CO2 cycle process, e.g., for ocean acidification.


3. Specific science scenarios for discovery
---------------------------
- Coastal marine primary production 
    - A scientist wants to know total annual net ecosystem primary production in a  coastal marine environment in southern California. This will entail discovering and processing (e.g., summing) the areal production rates for several groups of primary  producers, e.g., a) phytoplankton, b) benthic turf algae, c) seagrass  beds, d) kelp. Individual measurements required different methods due to differences in organism size and growth rate. Some measurements may be reported for  an entire community (phytoplankton, algal turf). Some may be  species-specific (kelp, seagrass, turf). The scientist expects to  discover measurements in a variety of time scales (daily to annual), and  spatial dimensions (volumetric or areal); possibly but less likely, different spatial scales (most scaled to meter).

- Processes contributing to NEE in a forest 
    - Terrestrial carbon budgets are generally constructed either by a) measuring specific sizes and changes in pools over time, b) directly measuring fluxes, or c) modeling. A scientist wants to compare the results of different methods of constructing carbon budgets in a forest, and so will need access to many different measurements, eg. mass of foliar, woody, root, litter and soil carbon, accumulation rates (for the same pools), autotoropthic, heterotrophic respiration rates, eddy  covariance (NEE) (e.g., from Table 1,  http://www.geos.ed.ac.uk/home/homes/mwilliam/Williams05a.pdf)

- Annual above-ground NPP in a grassland during droughts 
    - NOTE: this scenario was adapted from the MsTMiP scenario in use case 42, but is now for a data-discovery point of view. A scientist is studying drought recovery in grasslands. He wants to compare  the MsTMIP model output to other "benchmark" data sets, so needs data  from the MsTMIP central data repository, plus other data relating above-ground NPP to precipitation rates in grasslands. He will perform  additional data processing.

- Compare biomes
    - A scientist has a study to compare primary production rates across several biomes studied in the LTER, eg, temperate forests, grasslands, nearshore ocean and salt marshes.

- Ocean acidification and carbonate chemistry (would need a KR extension, see note)
    - The ocean has absorbed one-third to half the atmospheric CO2 produced by human fossil fuel combustion. Dissolved CO2 in the ocean becomes carbonic acid, driving the pH down and causing large shifts in seawater carbonate  chemistry speciation. A scientist wants to understand possible changes to calcium carbonate saturation states, which impact shell-forming marine  organisms (e.g., molluscs, echinoderms and corals). For this, she needs to find environmental observations on pH, alkalinity, and carbonate-system parameters. The scientists knows that given a minimum set of inputs, a suite of carbonate chemistry parameters can be calculated (concentrations, equilibrium constants, indices).

    - Note: this scenario would necessitate a KR extension. A likely extension would be to add terms related to ocean acidification and carbonate chemistry. Like research in primary production, the study of ocean acidification also addresses the effects of anthropogenic CO2. The form of CO2 found in natural water bodies is bicarbonate ion (HCO3-), and bicarbonate is consumed by phytoplankton during photosynthesis.



References
----------
