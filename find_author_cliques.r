#### name: find_author_cliques.r
###  author: Matt Carson
##   creation date: 20170907, first draft
# 
# This script takes a list of researchers and identifies all combinations of n persons who share
# publication authorship within a specified date range. Publications are taken from PubMed using
# the RISmed package.
# 
#
# output: a 4-column data frame containing:
# 
# Authors                                           Pub_Count   PubMed_IDs                   Query_Translation
#
# Author A [AU] AND Author B [AU] AND Author C [AU] 3           10298379|69402350|97459823  [Actual query passed to PubMed]
# Author A [AU] AND Author B [AU] AND Author D [AU] 1           98756455                    [Actual query passed to PubMed] 
# Author A [AU] AND Author C [AU] AND Author D [AU] 1           23455425                    [Actual query passed to PubMed]
# ...                                ...          ...
# ...                                ...          ...
# ...                                ...          ...

# More information about search options in PubMed: https://www.ncbi.nlm.nih.gov/books/NBK179288/
#
# See https://gist.github.com/macieksk/a139d451e8de3b71225d884671b45915 for more examples of using RISMed

# Keep track of the running time
ptm <- proc.time()

# Set location variables
TARGET_DIR = "dir_name"
INPUT_FILE = "input_file_name"
OUTPUT_FILE = 'output_file_name'

# Search settings
search_type ='esearch'
database = 'pubmed'
min_date = '2000'
max_date = '2016'

# Set working directory
setwd(TARGET_DIR)

# Install packages if necessary
# install.packages("readxl")
# install.packages("RISmed")

# Load libraries
library(readxl)
library(RISmed)

# Show the sheets in this .xlsx file
excel_sheets(INPUT_FILE)

# Examine the contents of the sheet
read_excel(INPUT_FILE, sheet = "membership_roster-3")

# Store the sheet in a list
author_list <- read_excel(INPUT_FILE, sheet = "membership_roster-3", trim_ws = TRUE,
                          col_types = c("text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text"))

# Create a 'First Initial' column
#author_list$`First Initial` <- toupper(substring(author_list$`First Name`, 1, 1))

# Create the 'Search Name' column
author_list$`Search Name` <- paste(author_list$`Last Name`, toupper(substring(author_list$`First Name`, 1, 1)))

# Create a vector 'search_names' for input to the 'combn' function
search_names <- as.vector(author_list$`Search Name`)

# create a list of all combinations of 3 authors (results in 6,099,006 combinations)
print("Creating a list of unique combinations of all authors...")
search_list <- combn(search_names, 3, function(x) paste(x[[1]],"[AU] AND",x[[2]],"[AU] AND",x[[3]],"[AU]"), simplify = FALSE)

# Alternatively, do the same for each pair of authors (results in 55,278 combinations)
# search_list <- combn(search_names, 2, function(x) paste(x[[1]],"[AU] AND",x[[2]],"[AU]"), simplify = FALSE)

print("done!!!")

# Create a round counter for testing purposes
round = 1

# Create a list to store combinations of authors with one or more shared publications
l <- list()
list_index <- 1

total_count <- length(search_list)

for (i in search_list) {

	# Perform the PubMed search
	res <- EUtilsSummary(i, type=search_type, db=database, mindate=min_date, maxdate=max_date)
	
	# Capture the number of pubs shared
	q_count = QueryCount(res)

	if (q_count > 0) {
		# Convert the res@PMID array
		PMIDs <- paste(as.character(res@PMID), collapse = "|")
		l[[list_index]] <- c(i,res@count, PMIDs, res@querytranslation)
		list_index <- list_index + 1
	}
	# For diagnostic purposes
	#if (round == 10) break
	print(paste("Round", round, "of", total_count))

	round = round + 1
}

# Create a data frame from the list of authors sharing publication authorship
df <- data.frame(matrix(unlist(l), nrow=length(l), byrow=T),stringsAsFactors=FALSE)

# Add column names to the data frame
names(df) <- c("Authors", "Pub_Count", "PubMed_IDs", "Query_Translation")

# Export reshaped file as .csv
write.csv(df, file = OUTPUT_FILE, row.names = FALSE)

# Stop the clock
proc.time() - ptm
