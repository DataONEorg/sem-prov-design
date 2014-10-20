
DataONE Use Case 54 (Annotation conflicts)
==========================================

Conflicting annotations are shown to users
-------------------------------------------

Revisions
---------
2014-10-08: Created
2014-10-13: Updated to reflect discussion at weekly meeting

Goal
----
Identify conflicting semantic annotations using inferencing.

Scenario
--------
When multiple users or processes are generating annotations about the same objects, conflicting perspectives may arise.
Some conflicts are corrections to erroneous annotations. Others are subtle differences in interpretation. 
We can certainly show the conflicts, but we leave conflict resolution up to the owner.

Summary
-------
We see the original data package owner (SystemMetadata.rightsHolder) as having authority over the annotations 
that apply to the package for discovery purposes. The owner can always reject suggested annotations.

When multiple conflicting annotations arise, this is the order of authority when we interpret them:

1. Owner
2. 3rd party
3. automated annotator
 

Sequence Diagram
----------------


Actors
------
* Member Node/Coordinating Node
* web UI for rendering metadata + annotations (even if they conflict)

Preconditions
-------------
* Datapackages with attribute-level metadata need to be registered in DataONE network
* All current (not obsoleted/archived) annotations are available for an object/resource

Postconditions
--------------
* Multiple annotations are shown in the UI, but indicate where they came from and what their status is (e.g., rejected?)

Notes
-----
This isn't so much a use case as simply laying out the interpretation rules when multiple annotations exist on a resource.

Use Case Implementation Examples
--------------------------------


