#### name: get_lat_lon.r
###  author: Matt Carson
##   creation date: 2016-06-01
# 
# This script does the following:
#
# 1) It takes a list of institution names from an Excel file, then...
# 2) queries the GeoNames Database to retrieve latitude and longitude, then...
# 3) merges this data with the original data frame using a 'left join', and finally...
# 4) writes the results to a .csv file
# 
# NOTE: There will likely be a few missing lat/lon results (hence the left join option when merging data frames).
#       You can identify these manually using other sources such as http://www.latlong.net 


# Won't work unless you type in a legit user name
options(geonamesUsername="your GeoNames database user name")

library(geonames)

# Global variables
INPUT_FILE = "infile.xlsx"
SHEET = "Sheet1"
OUTPUT_FILE = "outfile.csv"
SKIP_LINES = 1

# Read in the Excel file
library(readxl)
institutions <- read_excel(INPUT_FILE, sheet = SHEET, skip = SKIP_LINES)


# For search parameters, see:
# http://www.geonames.org/export/geonames-search.html
GeoNameSearch <- function(x) {
  res <- GNsearch(name_startsWith=x, country="USA") 
  return(res[1, ])
}

# Loop through institutions and reformat to include name, lat, and lon only
query <- sapply(institutions$Name, GeoNameSearch)
query <- do.call("rbind", query)
query <- cbind(name=row.names(query), subset(query, select=c("lat", "lng")))

# Modify names for merging
names(query) <- c("Name", "Latitude", "Longitude")

# 'Left join' to merge lat/lon with original CTSA institution list
merged_dfs <- merge(x = institutions, y = query, by="Name", all.x = TRUE)

# Some sites are usually returned without lat/lon data. For the ones that are missing, I use http://www.latlong.net as a substitute
# For the CTSA example, 50/64 institutions were found with GeoNames
#
# Another source for lat/lon of universities:
# https://inventory.data.gov/dataset/032e19b4-5a90-41dc-83ff-6e4cd234f565/resource/38625c3d-5388-4c16-a30f-d105432553a4

# Write output file
write.csv(merged_dfs, file = OUTPUT_FILE, row.names = FALSE)
