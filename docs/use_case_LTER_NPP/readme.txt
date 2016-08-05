npp chosen at science council as the synthesis project they want to focus on.

sample query: I want to compare NPP across all the LTER sites.
need to find data with npp measurements
need to understand measurement descriptions and methods

What parts of this can dataone provide?



james made datasets (CSVs) for them. in some cases, was able to rerun christine laney's old r scripts to recreate ecotrends dataset. 
sev sent a package id, that james was able to reuse christine's rscripts on.
maybe for the jrn one, also.

they used these data at the recent meeting,

what they want to do next:
get a postdoc to do the actual work.
lno works with the postdoc to get the systhesis data into pasta.

my thought is that
1. dataone can provide the below to  move veg-e forward:
A. "In the simplest configuration, Veg-DB would primarily be an aggregation and filtering tool that draws upon data in PASTA."
[from vegDB april 2013 workshop report, bottom of page 2 (findings of workshop 1 #8) ]

B. "PASTA harvester/extractor to gather the required data", "Aggregator (time, space, taxa)"
[ first two items under "modules" p 8]


veg-E "next step"
"The next steps will be to identify the prototype sites (participant lter sites) and to agree upon the format and variables in the data sets to be created by the sites. Then the prototype sites will populate examples of these data sets and they will uploaded to PASTA so that testing of the systems functionality can begin.
[bottom of p8]

This could be what the science council just did -- (represented by the data that James sent me). Or these might be just prototype datasets, not final. But they could go into a dev-dataone.

what the network-postdoc would do is organize this corpus:
Sites would provide all the raw and supplemental data to create the value added database to PASTA. The Veg-DB system would periodically rerun the calculations to produce the value-added database and enter it into PASTA.
[from vegDB april 2013 workshop report, top of page 3 (findings of workshop 1 #8) ]


Note: James also gave me the local names for sampling location in the xls file called "ANPP data for SC.xlsx"
For these to be the corpus of datasets that are annotated, I'd need to know their packageIds (and if what I find is indeed another incarnation of .

Any existing data for npp at these locations might be retrieved by querying metadata for location names.
if we had an EML dataset template, the corpus James sent could be uploaded to a dev-dataone, until the postdoc gets the real stuff (or sites do it themselves -- ours is slated to be another lt_ts, I think.


