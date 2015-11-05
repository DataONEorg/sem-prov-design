MsTMIP NetCDF Data Summary
==========================

This directory contains a CSV text file that summarizes the NcML metadata produced from the MsTMIP standard model input data.  The data and metadata files were harvested, cached, and processed at https://mn-stage-ucsb-4.test.dataone.org/mstmip.  

There's also a mstmip python module containing the NcMLConverter class.  This class was used to produce the mstmip-ncml-summary.csv summary file by processing the URLs found in the mstmip-ncml-urls.txt file.  Of the 1483 files, 46 were empty, and so were not summarized.

