
## Created by Mickey Rice
## October 8th, 2022

# Using SQL to combine datasets and extract specific values---------------------

install.packages("readxl")  # For reading Excel files
install.packages("sqldf")   # For running SQL queries
install.packages("openxlsx") # For writing xcel files


library(readxl)
library(sqldf)
library(openxlsx)


# Load the participant and screener files (replace with your actual file paths)
participants <- read_excel("/Users/mickey.rice/Desktop/Dissertation/PMD/ActualParticipants.xlsx")
screener <- read_excel("/Users/mickey.rice/Desktop/Dissertation/PMD/Screener.xlsx")

# Assuming the ID column is called 'ID' in both datasets
query <- "
  SELECT p.*, 
         s.[Q413_1] as ADHD1,
         s.[Q414_1] as ADHD2,
         s.[Q415_1] as ADHD3,
         s.[Q416_1] as ADHD4,
         s.[Q417_1] as ADHD5,
         s.[Q418_1] as ADHD6,
         s.[Q1.52] as SES1,
         s.[Q1.53q] as SES2
  FROM participants p
  JOIN screener s
  ON p.ID = s.ID
"

# Run the SQL query to combine the data
combined_data <- sqldf(query)

# View the combined data in R
head(combined_data)


# Save to a new Excel file
write.xlsx(combined_data, "/Users/mickey.rice/Desktop/combined_data.xlsx")
