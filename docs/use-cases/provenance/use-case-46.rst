
===================
DataONE Use Case 46
===================

-------------------------------------------------------------------------------------
Scientist can record provenance information about a run in the R programming language
-------------------------------------------------------------------------------------

Revisions
---------
2014-09-15-01

Goal
----
Scientists can capture provenance information about a script execution in the R programming language.

Summary
-------
The user specifies a script for which provenance information will be collected. 
The script is executed and the input datasets, derived datasets and execution environment attributes are automatically determined 
and the provenance relationships between these objects is persisted on the local machine. 
This information can then be reviewed and sent to DataONE as detailed in use case #45.

Actors
------
* Investigator
* Client Software

The following diagram shows a script execution on a client machine where a single dataset is read, a
and the associated provenance 
relationship between the script and the input dataset is captured. This dataset is 
then used to create a derived dataset, then the provenance relationship between the script and derived dataset is recorded.

.. image:: images/sequence-46.png

Preconditions
-------------
* The necessary DataONE R packages have been installed
* The scientist has packaged their processing into one or more R scripts
  
Triggers
--------
* Scientist invokes the run manager record(), providing their R script name

Post Conditions
---------------
* The scientist has created one or more derived datasets.
* The DataONE R run manager has stored provenance information locally for the newly created derived datasets.

