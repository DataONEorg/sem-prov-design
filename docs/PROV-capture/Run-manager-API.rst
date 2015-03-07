
DataONE Run Manager and API for Capturing Provenance in Script Executions
=========================================================================

Overview
--------

Scientists need a way to easily capture provenance for their data processing and analysis and have an automated way to upload provenance and derived data products from their analysis to a data repository such as those in the DataONE network.

Several use cases for storing provenance have been outlined: UseCases_

.. _UseCases: https://github.com/DataONEorg/sem-prov-design/tree/master/docs/use-cases/provenance

This document summarizes the session “Provenance Capture in R” at Open Science Codefest, a Community Dynamics working group meeting, and other DataONE Semantics and Provenance Working Group discussions and describes the design of a proposed run manager that will be implemented in Matlab and in R.

A way to capture provenance as conveniently for the scientist as possible is through a run manager. A run manager can capture provenance while a script is running, requiring very little extra code from the scientist. The run manager is aware of the provenance relationships and how to recognize those relationships based on the actions of the script.

To use the run manager, a user needs to start recording, such as with a function *record()*. All information recorded by the run manager can then be viewed after the script execution has ended. This allows the scientist to re-record the script execution and once satisfied, publish to a DataONE-enabled repository via a method call such as *publish()*.

Run Manager API
---------------

.. list-table:: Run Manager API
   :widths: 15 20 20 30
   :header-rows: 1

   * - Function
     - Parameters
     - Return Value
     - Description
   * - `record()`_
     - object, tag
     - DataONE data package
     - Execute program, record provenance from execution and create DataONE data package from derived products.
   * - `startRecord()`_
     - tag
     -
     - Provenance capture is started and will continue until `endRecord()`_ is called.
   * - `endRecord()`_
     -
     - DataONE data package
     - Provenance capture is stopped and a DataONE data package is created and returned to the user.
   * - `listRuns()`_
     - quiet, startDate, endDate, tags
     - object containing execution information
     - Retrieve information for all selected recorded executions and output to the display
   * - `deleteRuns()`_
     - runIdList, startDate, endDate, tags
     - list of identifiers of deleted runs
     - Delete information for all matching executions.
   * - `view()`_
     - packageID
     - None
     - Display detailed information about a data package.
   * - `publish()`_
     - packageID
     - DataONE identifier for the package
     - Upload a package to a DataONE member node.
   * - `set()`_
     - session, name, value
     - None
     - Set a configuration paramemter in the given session
   * - `get()`_
     - session, name
     - The named parameter value
     - Retrieve the value of a named configuration parameter from the given session
   * - `saveSession()`_
     - session, path
     - None
     - Save the session to disk at the given filename path
   * - `loadSession()`_
     - path
     - The saved Session
     - Load a saved session from disk using the given filename path
   * - `listSession()`_
     - session
     - the list of configuration parameters in the given session
     - Show all Session configuration parameters
     
.. _`record()`:

*record(filePath)*

The record method executes the specified script and records the files read and created by the script. 
In-memory objects need to be considered also. It's possible that a script never writes to disk, but just
creates an in-memory final product. This may be specified in a configuration API
Provenance relationships for the script execution are automatically determined based on the run 
manager’s built-in knowledge of the provenance ontology.

The record method creates and returns a DataONE DataPackage object that contains the provenance relationships and derived data 
objects for a single script invocation. 

Since record() returns the DataPackage, the DataPackage can be viewed and manipulated before publishing. For example, 
members of the package can be removed, new objects (such as scientific metadata) can be added, and relationships can be manually inserted via *insertRelationship()*.
Note: *insertRelationShip* is a method in DataPackage.R.
The *record()* method should return the runId of the recorded run, and then the Run class should allow the user to get any DataPackages produced, etc.

The following diagram shows a single invocation of record() and how provenance would be captured for reading a CSV file:

.. image:: ../use-cases/provenance/images/sequence-41.png

.. _`startRecord()`:

*startRecord(tag)*

Recording is started immediately from the current processing context. A character string *tag* can be specified that will be associated with the 
current execution. The string specified for *tag* can be any string that has meaning to the user, and can be used by other functions 
to select executions for listing, deletion or other operations.

Provenance collection will continue for this execution until the *endRecord()* call is issued.

The use of the *startRecord()* and *endRecord()* functions is an alternative to using the *record()* funciton. Using this alternative approach
may be appropriate when finer grained control is required that is provided by *record()* or for use with interpreted languages such as R where the user
is working in the console and wished to record provenance for processing performed in the console environment.

.. _`endRecord()`:
  
*endRecord()*

Recording is stopped, execution information is persisted to disk and a data package is finalized and returned to the caller. Any cached information
in memory is erased and any subsequent calls to *startRecord()* will begin a new execution.

.. _`listRuns()`:
 
*listRuns()*

The *listruns* function retrieves information for recorded script exections 
and outputs this information
to the display.

Output values:

* scriptName - the script used to invoke a run, the argument passed to *record(fileName)*
* startTime - the date and time when *record()* was called
* endTime - the date and time when *record()* ended
* publishedTime - the date and time that the package from this run was uploaded to DataONE
* runId - the unique identifier for this execution
* packageId - the unique identifier for the DataONE data package created by an execution
* errorMessage - an error message that caused processing to terminate

Below is an example of the output from the *listRuns* function:

::

  Script                 StartTime            EndTime              Published Time       Run Identifier                       Package Identifier                   Error Message
  calcISR.R              2014-01-01T09:09:09Z 2014-01-01T09:10:10Z 2014-03-01T09:10:10Z C85A188-B72E-49F1-AEF4-7BFC24DA186B  948E4B78-F5B8-444D-85CD-D3453A9F06C5
  rankshift.R            2014-1014T16:32:41Z  2014-10-14T16:32:41Z unpublished          E42EF61C-230A-44F8-A33E-D69B6F4C13E9 C1713504-1005-4BD9-A935-C7BFDC670CEF 
  speciesPlots.R         2013-12-24T01:01:01Z                      unpublished          E75D1E8-F171-4DB5-A91E-F0A4082DBFCC  8452DD63-76DC-4BBD-9672-5C99A8F075AF file species-site1.csv not found

This information will also be returned to the calling function as a data structure.

.. _`deleteRuns()`:
 
*deleteRuns(runIdList, startDateTime, endDateTime, tags, noop, quiet)*

Locally archived information for executions that match the input arguments is deleted. For *runIdList*, each execution with
a matching execution identifier is deleted. Executions after *startDateTime* and before *endDateTime* 
inclusive, are deleted. The argument *tags* can be specified using wildcard charaters, and any executions
with matching tags are deleted. The arguments *runIdList* and *tags* are processed separately, so the
relationship between them can be considered a logical AND, as it relates to the set of executions that
are deleted. Information about each deleted execution is printed to the display, unless the argument
*quiet* is TRUE.

The argument *noop* causes *deleteRuns* to display matching executions without deleting them.

.. _`publish()`:

*publish(DataPackage, Client)*

The publish function will reserve DataONE identifiers for each member of the DataPackage using the 
DataONE REST API. The DataPackage that was initially created by *record()* will be recreated using these identifiers.

If the script execution used an existing DataONE object as an input (determined 
by looking for functions such as *getD1Object()* in R), then this object will not 
be aggregated in this DataPackage, but will still be referred to in provenance relationships, such as prov:used.

The complete DataPackage will be uploaded to a repository using the specified D1Client.
A configuration API will allow the scientist to set default properties like AccessPolicy, ReplicationPolicy, etc.

It may be useful for the publish() function to include a parameter for the ID format, such as a preferred DOI prefix.
Identifier creation will be configurable so the scientist have control over the format of the identifiers that they create.
  
.. _`view()`:

*view(packakeId)*

This function can be called after *record()* and before *publish()* as an easy way to preview a DataPackage 
before publishing. Warnings and other messages can be displayed, such as “Warning: There is no 
scientific metadata in this data package.” The output of view() initially be implemented text output, but it may 
be worth considering a GUI for viewing the DataPackage, such as with Shiny in R.

The *view()* outputs:

A list of members of the DataPackage
A list of the relationships between members in the DataPackage

The following is example output from the the view() function:

::

  Package identifer: 948E4B78-F5B8-444D-85CD-D3453A9F06C5
  This package was created by run: C85A188-B72E-49F1-AEF4-7BFC24DA186B
  
  Files created from this run:
  Name                            Size            Creation Date/time
  ------------------------------- --------------- ------------------
  Quercus_lobata-20131211.png     58K             2014-10-14T15:33:10Z
  resourceMap.rdf                 76K             2014-10-14T15:33:10Z


  Files used from DataONE:
  DataONE identifier              Member Node               Creation Date/time
  ------------------------------- ------------------------- ---------------------
  knb.6271.2                      knb.ecoinformatics.org    2013-01-10T08:09:10.Z

  Local data files used:
  Name                            Size            Creation Date/time
  ------------------------------- --------------- ------------------
  speciesCounts-20131211.csv      102K            2014-10-14T15:33:10Z

  DataPackage to be published to DataONE
  ======================================

  Provenance
  ----------
  Quercus_lobata.png              was generated by        plotSpecies.R
  plotSpecies.R                   used                    speciesCounts-20131211.csv
  plotSpecies.R                   was informed by         createPlot.R

  Name                            Size            Date/time created
  ---------------                 ---------       --------------------
  Quercus_lobata-20131211.png     58K             2014-10-14T15:33:10Z
  plotSpecies.R                   19K             2014-10-14T15:33:10Z
  speciesCounts-20131211.csv      102K            2014-10-14T15:33:10Z
  QL-dist-20131210.eml            220K            2014-09-20T10:10:00Z
  resourceMap.rdf                 76K             2014-10-14T15:33:10Z

.. _`set()`:

*set(session, name, value)*

The set method sets the value of the named parameter in the given Session. Parameters names can be any string, and the values may be any serializable type supported by R (when implemented in R) or Matlab (when implemented in Matlab).  A number of categories of configuration parameters are supported, including:

+---------------------------+--------------------------------+-----------------------------------+
| Configuration Category    |        Parameter               |          Description              |
+---------------------------+--------------------------------+-----------------------------------+
| Operating System Config   | account_name                   | The OS account username           |
+---------------------------+--------------------------------+-----------------------------------+
| Science Metadata Config   | scimeta_template_path          | The file system path to a science |
|                           |                                | metadata template file. See the   |
|                           |                                | section on `templates`_.          |
|                           +--------------------------------+-----------------------------------+
|                           | scimeta_title                  | The title of the dataset          |
|                           |                                | being described. This value will  |
|                           |                                | be used to replace all            |
|                           |                                | 'SCIMETA_TITLE' placeholder       |
|                           |                                | strings in the template file.     |
|                           +--------------------------------+-----------------------------------+
|                           | scimeta_abstract               | The abstract  of the dataset      |
|                           |                                | being described. this value will  |
|                           |                                | be used to replace all            |
|                           |                                | 'SCIMETA_ABSTRACT' placeholder    |
|                           |                                | strings in the template file.     |
|                           +--------------------------------+-----------------------------------+
|                           | [More science metadata fields to be added here]                    |
+---------------------------+--------------------------------+-----------------------------------+
| DataONE Config            | member_node_base_url           | The base URL of the DataONE       |
|                           |                                | Member Node server used to store  |
|                           |                                | and retrieve files.               |
|                           +--------------------------------+-----------------------------------+
|                           | coordinating_node_base_url     | The base URL of the DataONE       |
|                           |                                | Coordinating Node server.         |
|                           +--------------------------------+-----------------------------------+
|                           | format_id                      | The default object format         |
|                           |                                | identifier when creating system   |
|                           |                                | metadata and uploading files to a |
|                           |                                | Member Node. Defaults to          |
|                           |                                | application/octet-stream          |
|                           +--------------------------------+-----------------------------------+
|                           | submitter                      | The DataONE Subject DN string of  |
|                           |                                | account uploading the file to a   |
|                           |                                | Member Node.                      |
|                           +--------------------------------+-----------------------------------+
|                           | rights_holder                  | The DataONE Subject DN string of  |
|                           |                                | account with read, write, and     |
|                           |                                | changePermission permissions for  |
|                           |                                | the file being uploaded.          |
|                           +--------------------------------+-----------------------------------+
|                           | public_read_allowed            | Allow public read access to       |
|                           |                                | uploaded files. Defaults to true. |
|                           +--------------------------------+-----------------------------------+
|                           | replication_allowed            | Allow replication of files to     |
|                           |                                | preserve the integrity of the     |
|                           |                                | data file over time.              |
|                           +--------------------------------+-----------------------------------+
|                           | number_of_replicas             | The desired number of replicas of |
|                           |                                | each file uploaded to the DataONE |
|                           |                                | network.                          |
|                           +--------------------------------+-----------------------------------+
|                           | preferred_replica_node_list    | A comma-separated list of Member  |
|                           |                                | Node identifiers that are         |
|                           |                                | preferred for replica storage.    |
|                           +--------------------------------+-----------------------------------+
|                           | blocked_replica_node_list      | A comma-separated list of Member  |
|                           |                                | Node identifiers that are         |
|                           |                                | blocked from replica storage.     |
+---------------------------+--------------------------------+-----------------------------------+
| Identity Config           | orcid_identifier               | The researcher's ORCID identifier |
|                           |                                | from http://orcid.org. Identity   |
|                           |                                | information found via the ORCID   |
|                           |                                | API will populate or override     |
|                           |                                | other identity fields as          |
|                           |                                | appropriate.                      |
|                           +--------------------------------+-----------------------------------+
|                           | subject_dn                     | The researcher's DataONE Subject  |
|                           |                                | as a Distinguished Name string.   |
|                           |                                | If not set, defaults to the       |
|                           |                                | Subject DN found in the CILogon   |
|                           |                                | X509 certificate at the given     |
|                           |                                | certificate path.                 |
|                           +--------------------------------+-----------------------------------+
|                           | certificate_path               | The absolute file system path to  |
|                           |                                | the X509 certificate downloaded   |
|                           |                                | from https://cilogon.org. The path|
|                           |                                | includes the file name itself.    |
|                           +--------------------------------+-----------------------------------+
|                           | foaf_name                      | The Friend of a friend 'name'     |
|                           |                                | vocabulary term as defined at     |
|                           |                                | http://xmlns.com/foaf/spec/,      |
|                           |                                | typically the researchers given   |
|                           |                                | and family name together.         |
+---------------------------+--------------------------------+-----------------------------------+
| Provenance Capture Config | provenance_storage_directory   | The directory used to store per   |
|                           |                                | execution provenance information. |
|                           |                                | Defaults to '~/.d1/provenance'    |
+                           +--------------------------------+-----------------------------------+
|                           | capture_file_reads             | When set to true, provenance      |
|                           |                                | capture will be triggered when    |
|                           |                                | reading from files based on       |
|                           |                                | specific read commands in the     |
|                           |                                | scripting language. Default: true |
|                           +--------------------------------+-----------------------------------+
|                           | capture_file_writes            | When set to true, provenance      |
|                           |                                | capture will be triggered when    |
|                           |                                | writing to files based on         |
|                           |                                | specific write commands in the    |
|                           |                                | scripting language. Default: true |
|                           +--------------------------------+-----------------------------------+
|                           | capture_dataone_reads          | When set to true, provenance      |
|                           |                                | capture will be triggered when    |
|                           |                                | reading from DataONE MNRead.get() |
|                           |                                | API calls. Default: true          |
|                           +--------------------------------+-----------------------------------+
|                           | capture_dataone_writes         | When set to true, provenance      |
|                           |                                | capture will be triggered when    |
|                           |                                | writing with DataONE              |
|                           |                                | MNStorage.create() or             |
|                           |                                | MNStorage.update() API calls.     |
|                           |                                | Default: true                     |
|                           +--------------------------------+-----------------------------------+
|                           | capture_yesworkflow_comments   | When set to true, provenance      |
|                           |                                | capture will be triggered when    |
|                           |                                | encountering YesWorkflow inline   |
|                           |                                | comments. Default: true           |
+---------------------------+--------------------------------+-----------------------------------+

.. _`get()`:

*get(session, name)*

The get method retrieves the value of the named parameter in the given Session. Parameters names can be any string, many of which are listed in the categories above in the `set()`_ command.

.. _`saveSession()`:

*saveSession(session, path)*

Save all of the configuration parameters in the current Session to disk, given the path to a file. The
path defaults to ~/.d1/session.json.

.. _`loadSession()`:

*loadSession(path)*

Load all of the configuration parameters from a saved Session on disk from the given path. Returns the
Session object. The path defaults to ~/.d1/session.json.

.. _`listSession()`:

*listSession()*

List all of the session parameters from the loaded session a structured object, depending on the script language.

Run Manager Provenance Capture
------------------------------

The run manager overloads functions that read input and write output in 
order to capture the objects that are used and 
generated by the script execution. For example, when a script reads in a .csv file, the 
run manager can infer the triple “script execution -> prov:used -> .csv file”. 

The following provenance relationshps will be recorded:

- wasGeneratedBy
  
  When an output is created by the script execution, the run manager can infer that the ouput “prov:wasGeneratedBy” the script execution.
  
  Detection: The run manager will overload R functions such as write.csv and createD1Object() to capture the data file the script execution generates.
- used
  
  When the script execution reads input data, it can infer that the script execution “prov:used” the input data.
  
  Detection: The run manager will overload R functions such as getD1Object() and read.csv().
- wasDerivedFrom
  
  After the “prov:wasGeneratedBy”  and “prov:used” relationships are created, we can infer that a data object 
  generated by this script execution “prov:wasDerivedFrom” the inputs the script “prov:used”
- wasInformedBy
  
  When the script initially executed by record() invokes another script, the run manager can infer 
  that the initial execution  “prov:wasInformedBy” the other script execution it triggered.
  
  Detection: The run manager will overload the R function source().

Adding Scientific Metadata to the Data Package after Recording a Script Execution
---------------------------------------------------------------------------------

.. _package: https://github.com/ropensci/EML

Since a script may not generate metadata or read it in as a data input, the scientist may have to 
explicitly add a scientific metadata file to the DataPackage. This can be done using existing 
metadata-creation tools, such as Morpho or the R EML package_ from rOpenSci.

The run manager has the potential to create minimal EML to include in the DataPackage in 
case the scientist does not add any before publishing. We will need to research automated metadata extraction tools.

Implementation
--------------
The run manager will be implemented in two phases:

Phase I

- Record
  
  Overload D1.get() functions to capture provenance
  
  Overload D1.create() functions to capture provenance
  
  Overload D1.update() functions to capture provenance
  
  Capture of script execution details - run time, run environment, etc.
  
  Wrap this all in a single API call, record()
  
- View

  Create a DataPackage and run manager view() function to output a textual representation of the DataPackage and run manager results

Phase II

- Record

  Overload read.csv() functions to capture provenance
  
  Overload write.csv() functions to capture provenance
  
- View

  Possibly - Expand the view() function to output a GUI representation of the DataPackage and run manager results


Run Manager Storage
-------------------

The Run Manager stores data objects and provenance information and execution metadata in a local directory
uniquely named for each *record* invocation, for example "~/.recordr/runs/ED6A8081-65ED-414C-93C6-29C29DF3543D".

Run Manager execution metadata will be serialized to a JSON-LD file as shown by the following example JSON-LD file:

::

  {
      "@context":
      {
          "schemaorg": "http://schema.org/",
          "foaf": "http://xmlns.com/foaf/0.1/",
          "account": "foaf:OnlineAccount",
          "description": "schemaorg:description",
          "endTime": "schemaorg:endTime",
          "executionID": "schemaorg:executionID",
          "errorMessage": "schemaorg:errorMessage"
          "hostId": "schemaorg:hostid",
          "startTime": "schemaorg:startTime",
          "moduleDependencies": "schemaorg:moduleDependencies",
          "operatingSystem": "schemaorg:operatingSystem",
          "runtime": "schemaorg:runtime",
          "SoftwareApplication": "schemaorg:SoftwareApplication"
     }
     "description": "Execution of R script rankClock.R run at 2014-09-15T13:00:00-04:00",
     "executionID": "ED6A8081-65ED-414C-93C6-29C29DF3543D",
     "account": "smith123"
     "hostId": "eos.nceas.ucsb.edu",
     "startTime": "2014-09-15T13:00:00-04:00",
     "endTime": "2014-09-15T14:10:00-05:00",
     "operatingSystem": "x86_64-apple-darwin13.1.0 (64-bit)",
     "runtime": "R version 3.1.1 (2014-07-10)",
     "SoftwareApplication": "rankClock.R",
     "moduleDependencies": [ "jsonlite_0.9.12", "dataone_2.0.0", "RCurl_1.95-4.3", "bitops_1.0-6", "stats", "graphics", "grDevices", "utils", "datasets", "methods", "base" ],
     "errorMessage": ""
  }
  
.. Note::

  This example JSON-LD file is based on a proposed schema for software executions that may be submitted to schema.org.
  

