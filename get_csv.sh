#!/bin/bash

# Directory containing XML files
XML_DIR="./data"

# CSV output file
CSV_OUTPUT_FILE="pricesall.csv"

# Create or clear the CSV output file
echo "Date,Hour,Price" > "$CSV_OUTPUT_FILE"

# Loop through each XML file in the directory
for xml_file in "$XML_DIR"/*.xml; do
  while IFS= read -r line; do
    if [[ $line == *"<start>"* ]]; then
      date=$(echo "$line" | xmlstarlet sel -t -v "//start")
    elif [[ $line == *"<position>"* ]]; then
      hour=$(echo "$line" | xmlstarlet sel -t -v "//position")
    elif [[ $line == *"<price.amount>"* ]]; then
      price=$(echo "$line" | xmlstarlet sel -t -v "//price.amount")
      echo "$date,$hour,$price" >> "$CSV_OUTPUT_FILE"
    fi
  done < "$xml_file"
done

echo "CSV file generated: $CSV_OUTPUT_FILE"
