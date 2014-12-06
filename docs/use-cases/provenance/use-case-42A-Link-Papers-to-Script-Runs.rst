
DataONE Use Case 42A (Link Papers to Script Runs)
=================================================

Scientists can link papers to specific runs of scripts
------------------------------------------------------

Revisions
---------
| Created: 2014-09-23
| Revised: 2014-10-14

Goal
----
Scientist can provide links to scholalrly papers that were derived from particular executions of a script or model.

.. sidebar:: Scenario
    
    "As a scientist using R or Matlab, I want to link my paper to a given script run so I can document the exact process I used to derive my published data, figures, or tables."

Summary
-------
In R or Matlab, after executing a script and recording provenance information about the run, a scientist can later update the execution's provenance information by providing a link to a permanent identifier (such as a DOI) of a published document.  

*Use case diagram*

.. image:: images/use-case-42A.png

.. 
    @startuml images/use-case-42A.png
        package "Investigator's local machine" {
        actor "Investigator" as client
        usecase "42A. Link Papers to Script Runs" as record
        client -- record
        }
    @enduml

*Sequence diagram*

.. image:: images/sequence-42A.png

.. 
    @startuml images/sequence-42A.png
        !include ../plantuml.conf
        actor scientist
        == Update Run Information ==
        scientist -> "run manager" : list(search terms)
        "run manager" -> "provenance store" : list(search terms)
        "provenance store" --> scientist : package list
        note right of "scientist"
        scientist selects a package 
        to update from the list
        end note
        scientist -> "run manager" : insertRelationship(wasDerivedFrom, doi, runId)
        "run manager" -> "provenance store": insertRelationship(wasDerivedFrom, doi, runId)
    @endumld

Actors
------
* Investigator
* Client Software

Preconditions
-------------
* The necessary DataONE run manager packages have been installed in R or Matlab
  
Triggers
--------
* Scientist invokes the run manager list() function, providing search terms to select matching executions
* Scientist invokes the run manager insertRelationship() function, providing the relationship type, paper reference, and execution id

Post Conditions
---------------
* The scientist has updated the execution's provenance information
