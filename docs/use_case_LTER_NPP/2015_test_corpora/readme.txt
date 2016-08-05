this is where you create lists of ids for LTER datasets that comprise the
groups of datasets we will use in query testing

We are starting with a small group of well-known datasets for code development. 
we will add to this corpus gradually, becuase we have to know the "ground truth" 
for the entire test corpus, and so will be manally examining each dataset, and
possibly, interviewing the site IM as well (eg, if "truth" isn't clear from 
available metadata).



test_corpus_C: all datasets contributed by 1 LTER site: SBC.
used for code development.

test_corpus_D: all datasets contributed by 3 LTER sites: SBC, AND, KNZ
used for the first query test, target date, 2015-Jun-01


Basic process: 
 1. solr query to pasta for all pkgs from a site, 
 2. use bash to grep out ids and add ID shoulder
 3. use bash to cycle through list and see if that id is in cn-sandbox, with curl.
 4. tweak list manually as needed.
 
** Do this after cn-sandbox-2 is frozen, so you have the most recent revision.
 
 
 
 
