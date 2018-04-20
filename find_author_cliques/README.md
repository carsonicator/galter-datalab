# Find Author Cliques

# Description
Takes a list of researchers and identifies all combinations of _n_ persons who share publication authorship within a specified date range. The PubMed database is queried using the [RISmed package](https://cran.r-project.org/web/packages/RISmed/index.html) and shared PubMed IDs are returned.

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

# File Overview

## Code files

### R scripts
find_author_cliques.r


## Output
The output is a 4-column data frame containing:

| Authors                                              | Pub_Count | PubMed_IDs                  | Query_Translation               |
| ---------------------------------------------------- |:---------:|:---------------------------:| -------------------------------:|
| Author A [AU] AND Author B [AU] AND Author C [AU]    | 3         | 10298379\|69402350\|97459823  | [Actual query passed to PubMed] |
| Author A [AU] AND Author B [AU] AND Author D [AU]    | 1         | 98756455                    | [Actual query passed to PubMed] |
| Author A [AU] AND Author C [AU] AND Author D [AU]    | 1         | 23455425                    | [Actual query passed to PubMed] |
| ...                                                  | ...       | ...                         | ...                             |
| ...                                                  | ...       | ...                         | ...                             |
| ...                                                  | ...       | ...                         | ...                             |


### Codebooks
Name -- What it is, what it does, how it relates to other files.

## Other materials

# Additional Information

More information about search options in PubMed can be found [here](https://www.ncbi.nlm.nih.gov/books/NBK179288/).

For additional usage, see [more examples](https://gist.github.com/macieksk/a139d451e8de3b71225d884671b45915) of with RISMed.

## R Session Info
Output from sessionInfo()

# Citations
Author: Matt Carson
