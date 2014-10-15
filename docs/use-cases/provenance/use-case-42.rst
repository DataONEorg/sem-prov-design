
DataONE Use Case 42 (Document Script)
===================================

Scientists can document a script's workflow using standardized inline comments.
------------------------------------------------------------------------------

Revisions
---------
| Created: 2014-10-14
| Revised:

Goal
----
Scientists can use simple inline comments in their analysis scripts that can be extracted to provide the derivation history of input data and output products.

.. sidebar:: Scenario
    
    "As a data analyst using R or Matlab, I want to easily document my script with standardized comments so I can understand the workflow of the script."

Summary
-------
While writing a script in R or Matlab, the analyst uses inline comments that come from a standardized vocabulary to document each of the functions in the script.  The vocabulary includes directives on what to track, what the functions take as inputs, and what they produce as outputs.  This allows anyone reading the script to understand the workflow, but it also allows a parsing tool to extract these statements for further use (for instance, see Use Case #47 (Workflow Visualization)).

*Use case diagram*



.. 
    @startuml images/use-case-42.png  
        package "Investigator's local machine" {
        actor "Investigator" as client
        usecase "42. Document Script" as document
        client -- document
        }
    @enduml

Actors
------
* Investigator
* Client Software

Preconditions
-------------
* The necessary DataONE run manager packages have been installed
* The scientist writes functions using standardized inline comments

Triggers
--------
* The scientist invokes the run manager record() function (see Use Case #41 (Track History))

Post Conditions
---------------
* The scientist has created one or more derived datasets.
* The DataONE run manager has extracted inline comments and has set configuration values programmatically

