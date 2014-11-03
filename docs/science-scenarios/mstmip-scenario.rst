MsTMIP and DataONE: A Science Workflow Scenario for Tracking Provenance
=======================================================================

Improving scientific model sharing and communication through provenance
-----------------------------------------------------------------------

The North American Carbon Program's (NACP) Multiscale Terrestrial Model Intercomparison Project (MsTMIP) is a formal model intercomparison and evaluation effort focused on improving the diagnosis and attribution of carbon exchange at regional and global scales [1].  The MsTMIP effort is being used as a concrete scientific research scenario to evaluate tools being developed within the `DataONE`_ program to track and share scientific workflows and the products that are derived from them or other scientific efforts.

The MsTMIP is a highly collaborative activity and being conducted in 4 major steps: model driver data preparation [2], model simulations, QA/QC and standardization of model output, and analysis and model run intercomparisons.

.. figure:: figures/mstmip-workflow-overview.png
   :width: 80%
   :alt: MsTMIP workflow overview diagram
   :align: center
   
   Figure 1. An overview of the MsTMIP scientific workflow, labeled with the DataONE use cases being developed to test new provenance tracking software tools.

Step 1: Preparing Driver Data
---------------------------

The MsTMIP core leadership team, with inputs from participating modeling teams, compiled and processed, and standaridzed a set of input data that different terrestrial biosphere models use as drivers to run simulations. This set of driver input data include climatology, atmospheric CO2, nitrogen deposition, soil properties, phenology, C3/C4 grass fractions and major crops distribution, and land use & land cover change history. Each category of these driver input data was prepared in two spatial scales: global half-degree and North American quarter-degree. The MsTMIP core leadership team also prepared a set of observation-based benchmark data sets that would be used for later model validation purpose.

As researchers who prepare model driver data for MsTMIP using Matlab, we want to keep track of our data input files, data output files and scripts so we can review and compare our runs using different Carbon3/Carbon4 (C3C4) calculation algorithms. The Matlab ingestion script takes 3 data sets as inputs:

- global 1/2-degree resolution land cover map
- monthly mean surface air temperature between 2000 and 2010
- monthly mean precipitation between 2000 and 2010

It will then calculate relative fractions of C3 and C4 grass in each 1/2-degree grid cell, and output the result as 3 netCDF files containingi C3 grass relative fraction, C4 grass relative fraction, and overall grass fraction.

Expected Inputs and Outputs
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Input script is MSTMIP-INPUT-SCRIPT-NAME
    - `C3_C4_map_present_Global.m`_

.. _`C3_C4_map_present_Global.m`: https://github.com/DataONEorg/sem-prov-design/blob/master/docs/use-cases/provenance/example-files/mstmip/Driver/C3C4/C3_C4_map_present_Global.m


- `Input datasets`_ are MSTMIP-INPUT-DATASET-LIST
    - global 1/2-degree resolution land cover map
    - monthly mean surface air temperature between 2000 and 2010
    - monthly mean precipitation between 2000 and 2010. 

.. _`Input datasets`: https://github.com/DataONEorg/sem-prov-design/tree/master/docs/use-cases/provenance/example-files/mstmip/Driver/C3C4/inputs

- Input derived datasets are MSTMIP-INPUT-DERIVED-DATASET-LIST
    - Not applicable in this case
    
- Input execution environment attributes are MSTMIP-INPUT-EXECUTION-ENVIRONMENT-ATTRIBUTE-LIST
    - Not applicable in this case

- `Output datasets`_ are MSTMIP-OUTPUT-DATASET-LIST
    - global 1/2-degree C3 grass relative fraction
    - global 1/2-degree C4 grass relative fraction
    - global 1/2-degree grass fraction
.. _`Output datasets`: https://github.com/DataONEorg/sem-prov-design/tree/master/docs/use-cases/provenance/example-files/mstmip/Driver/C3C4/outputs

- Output recorded script execution is MSTMIP-OUTPUT-RECORDED-SCRIPT-EXECUTION-LIST
    - The list provided by DataONE

- Output provenance relationship list is MSTMIP-PROVENANCE-RELATIONSHIP-LIST 
    - The list provided by DataONE

- Output provenance relationship visualization is MSTMIP-PROVENANCE-RELATIONSHIP-VISUALIZATION
    - The visualization provided by DataONE

- Usability: 
    - Scientist can filter MSTMIP-OUTPUT-RECORDED-SCRIPT-EXECUTION-LIST by execution date, time, input dataset, input derived dataset, output dataset, ...
    - Scientist can view relationships between items in MSTMIP-PROVENANCE-RELATIONSHIP-LIST
    - Scientist can select desired MsTMIP data products and send them to DataONE

Step 2: Instrumenting and running global/North American simulations with terrestrial biospheric models
---------------------------------------------------------------

20+ modeling teams take the standardized model driver data set and conduct various simulation scenarios defined by the MsTMIP, including reference simulation (RG1/RR1), sensitivity simulations (SG1/SR1, SG2/SR2, and SG3/SR3), and baseline simulation (BG1/BR1).

Step 3: QA/QC and standardization of model output
-------------------------------------------------

Modeling teams submit their model results to the MsTMIP central data repository. The MsTMIP core leadership team then perform quality check, harmonization, and standardization to convert outputs from all different models into a consistent and standard format.

Step 4: Analysis and model run intercomparisons
-----------------------------------------------

Researchers in the MsTMIP community access standardized model outputs and benchmark data sets from the MsTMIP central data repository, perform additional data processing as needed, analyze and compare data, and create figures and/or plots to be used in their scientific manuscripts.

A scientist is analyzing the MsTMIP global model outputs for drought recovery time research. A drought variable (DV, an index of drought severity) and effect variable (EV) are used to determine recovery time. For this research the EV is gross primary productivity (GPP) as simulated by MsTMIP models. The initial DV used here, the 1-month variant of Standardized Precipitation-Evapotranspiration Index (SPEI), is taken from the Digital.CSIC.  Both DV and EV are gridded products from 1901 to 2010 at a monthly time step. A drought event, which occurs for a given grid cell, is defined using two parameters: severity and length. For example, when mean DV is less than -1 (lower values indicate higher drought severity) for at least 3 consecutive months. Recovery time is then determined as the length of time that passes after the drought event begins before the EV reattains (meets or exceeds) its immediate pre-drought level. The severity and duration parameters as well as DV and EV are varied to assess the variability in drought recovery time.

This scientist is analyzing MsTMIP model output data using Matlab, we want to keep track of our data input files, data output files and scripts so we can review and compare our runs for different participating models/simulations. The Matlab ingestion script takes 2 data sets as inputs:

- global 1/2-degree monthly GPP model outputs in 1901-2010 from a MsTMIP model simulation
- 1-month variant of Standardized Precipitation-Evapotranspiration Index (SPEI)


Expected Inputs and Outputs
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Input script is MSTMIP-INPUT-SCRIPT-NAME
    - `DroughtTimeScale.m`_

.. _`DroughtTimeScale.m`: https://github.com/DataONEorg/sem-prov-design/blob/master/docs/use-cases/provenance/example-files/mstmip/Outputs/Drought/DroughtTimeScale.m


- Input datasets are MSTMIP-INPUT-DATASET-LIST
    - global 1/2-degree monthly GPP model outputs in 1901-2010 from a MsTMIP model simulation
    - 1-month variant of Standardized Precipitation-Evapotranspiration Index (SPEI)

- Input derived datasets are MSTMIP-INPUT-DERIVED-DATASET-LIST
    - Not applicable in this case

- Input execution environment attributes are MSTMIP-INPUT-EXECUTION-ENVIRONMENT-ATTRIBUTE-LIST
    - Not applicable in this case

- `Output datasets`_ are MSTMIP-OUTPUT-DATASET-LIST
    - global 1/2-degree drought recovery time map
    - global 1/2-degree predrought effect variable map
    - global 1/2-degree drought variable map
    - global 1/2-degree drought number map
.. _`Output datasets`: https://github.com/DataONEorg/sem-prov-design/tree/master/docs/use-cases/provenance/example-files/mstmip/Outputs/Drought/outputs

- Output recorded script execution is MSTMIP-OUTPUT-RECORDED-SCRIPT-EXECUTION-LIST
    - The list provided by DataONE

- Output provenance relationship list is MSTMIP-PROVENANCE-RELATIONSHIP-LIST
    - The list provided by DataONE

- Output provenance relationship visualization is MSTMIP-PROVENANCE-RELATIONSHIP-VISUALIZATION
    - The visualization provided by DataONE

- Usability:
    - Scientist can filter MSTMIP-OUTPUT-RECORDED-SCRIPT-EXECUTION-LIST by execution date, time, input dataset, input derived dataset, output dataset, ...
    - Scientist can view relationships between items in MSTMIP-PROVENANCE-RELATIONSHIP-LIST
    - Scientist can select desired MsTMIP data products and send them to DataONE

References
----------

[1] Huntzinger, et al.: The North American Carbon Program Multi-Scale Synthesis and Terrestrial Model Intercomparison Project – Part 1: Overview and experimental design, Geosci. Model Dev., 6, 2121-2133, doi:10.5194/gmd-6-2121-2013, 2013. `http://dx.doi.org/10.5194/gmd-6-2121-2013`_

[2] Wei, Y., Liu, S., Huntzinger, D., Michalak, A., Viovy, N., Post, W., et al. (2013). The North American Carbon Program Multi-scale Synthesis and Terrestrial Model Intercomparison Project: Part 2 - Environmental Driver Data. Geoscientific Model Development Discussions, 6, 5375-5422, doi:`10.5194/gmdd-6-5375-2013`_.

.. _`http://dx.doi.org/10.5194/gmd-6-2121-2013`: http://dx.doi.org/10.5194/gmd-6-2121-2013

.. _`10.5194/gmdd-6-5375-2013`: http://dx.doi.org/10.5194/gmdd-6-5375-2013

.. _`DataONE`: http://dataone.org
