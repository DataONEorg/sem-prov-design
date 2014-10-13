
DataONE Use Case 41
===================

Scientists can publish derived datasets and tracking information to DataONE
---------------------------------------------------------------------------

Revisions
---------
2014-09-29-01

Goal
----
In DataONE-enabled client software, investigators can easily publish new products from existing data files and provide tracking information.

Scenario
--------
"As a data analyst using R or Matlab, I want to publish my data and their history so I can share them with colleagues through an established DataONE repository."

Summary
-------
In both R and Matlab, investigators can upload derived datasets to a DataONE Member Node repository.  They can assign citable identifiers to  their dataset (e.g., a DOI), and provide traceable links to the primary datasets used to create them.  

Use Case Diagram
----------------
.. 
    @startuml images/41_uc.png       
      actor "Investigator" as client 
      usecase "12. Authentication" as authen 
      note top of authen 
        Authentication may be provided by an external service 
      end note    
      package "DataONE" { 
        actor "Coordinating Node" as CN 
        actor "Member Node" as MN 
        usecase "13. Authorization" as author 
        usecase "04. Create" as create 
        usecase "41. Publish" as publish
        usecase "06. MN Synchronize" as mn_sync 
        client -- publish
        CN -- publish
        MN -- publish 
        publish ..> author: <includes> 
        publish ..> authen: <includes> 
        publish ..> mn_sync: <includes> 
        publish ..> create: <includes>
      }       
    @enduml

.. image:: images/41_uc.png

Sequence Diagram
----------------
.. 
    @startuml images/41_seq.png 
        Actor Investigator 
        participant "Client Software" as app_client << Application >> 
        participant "MN API" as mn_api << Member Node >> 
        participant "CN API" as cn_api << Coordinating Node >>
        Investigator -> app_client: publish(runId)
        loop for each relationship
            app_client -> app_client: insertRelationship()
        end
        loop for each dataPackage member
            app_client -> mn_api: create(auth_token, member) 
        end
        mn_api -> mn_api: store()
        cn_api -> mn_api: listObjects()
        mn_api --> cn_api: object list
        cn_api -> mn_api: get(pid) mn_api --> cn_api: object
        cn_api -> mn_api: getSystemMetadata(pid) mn_api --> cn_api: systemMetadata
        cn_api -> cn_api: store() cn_api -> cn_api: index() 
        note right of cn_api 
            Relationships are 
            indexed and searchable 
        end note
        note right of Investigator
            At this point, the Investigator 
            may decide to modify their script 
            and perform the ecord() and view() 
            process again.
        end note
    @enduml
   
.. image:: images/41_seq.png

Actors
------
* Investigator
* Client software
* Member Node
* Coordinating Node

Preconditions
-------------
* The primary resource dataset needs to be registered on the Member Node.
* The Investigator needs write access to a Member Node.
* The client software must be DataONE-enabled and provenance-aware.

Postconditions
--------------
* The derived datasets are stored on the Member Node
* The data package includes formal links between the primary and derived datasets

Notes
-----

Use Case Implementation Examples
--------------------------------

* An R Client example of Use Case 41 (Scientists can provide tracking information about derived products):

    #``(… create DataONE data objects and a DataONE data package…)``

    ``insertRelationship(data.package, id.result, c(id.script), "http://www.w3.org/ns/prov",      "http://www.w3.org/ns/prov#wasGeneratedBy")``

    ``insertRelationship(data.package, id.script, c(id.data), "http://www.w3.org/ns/prov", "http://www.w3.org/ns/prov#used")``

    ``insertRelationship(data.package, id.data, c(id.data2, id.data3), "http://www.w3.org/ns/prov", "http://www.w3.org/ns/prov#wasDerivedFrom")``

    ``createDataPackage(d1client, data.package)``

