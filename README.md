# GalterDataLabScripts

This is a place to keep scripts created for researchers who consult the Galter DataLab and DataClinic.

## _find_author_cliques.r_

This script takes a list of researchers and identifies all combinations of n persons who share publication authorship within a specified date range. Publications are taken from PubMed using the RISmed package.

An example of a single esearch for one author:

```R

# E-utilities and associated parameters: https://dataguide.nlm.nih.gov/eutilities/utilities.html#elink
search_type ='esearch'
database = 'pubmed'
min_date = '2000'
max_date = '2016'

# Perform the search and get a summary
res <- EUtilsSummary("Carson MB[au]", type=search_type, db=database, mindate=min_date, maxdate=max_date)

# Show all attributes of the search result
attributes(res)

# Download the full results of the query and show the attributes
q <- EUtilsGet(res)
attributes(q)
```
