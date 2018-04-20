# Get latitude and longitude

# Description

This script `get_lat_lon.r` does the following:

1. It takes a list of institution names from an Excel file, then...
2. queries the GeoNames Database to retrieve latitude and longitude, then...
3. merges this data with the original data frame using a 'left join', and finally...
4. writes the results to a .csv file

> *NOTE:* There will likely be a few missing lat/lon results (hence the left join option when merging data frames).You can identify these manually
> using other sources such as http://www.latlong.net
>
> Another source for lat/lon of universities is [here](https://inventory.data.gov/dataset/032e19b4-5a90-41dc-83ff-6e4cd234f565/resource/38625c3d-5388-4c16-a30f-d105432553a4).

# File Overview

## Code files

### R scripts
get_lat_lon.r


## Output

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
