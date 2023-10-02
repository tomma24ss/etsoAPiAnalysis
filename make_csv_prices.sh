#!/bin/bash

# Directory containing XML files
XML_DIR="./prices_data_xml"

# Find the last modified XML file in the directory
LAST_XML_FILE=$(ls -t "$XML_DIR"/*.xml | head -1)

# CSV output directory
CSV_OUTPUT_DIR="./prices_data_csv"

# Ensure the CSV output directory exists
mkdir -p "$CSV_OUTPUT_DIR"

# Extract the date from the XML file name
DATE=$(echo "$LAST_XML_FILE" | grep -oP '\d{8}')

# CSV output file with date in the filename
CSV_OUTPUT_FILE="$CSV_OUTPUT_DIR/price_${DATE}.csv"

# Check if the last XML file exists
if [[ -e "$LAST_XML_FILE" ]]; then
  # Create or clear the CSV output file
  echo "Date,Hour,Price" > "$CSV_OUTPUT_FILE"

  while IFS= read -r line; do
    if [[ $line == *"<start>"* ]]; then
      date=$(echo "$line" | xmlstarlet sel -t -v "//start")
    elif [[ $line == *"<position>"* ]]; then
      hour=$(echo "$line" | xmlstarlet sel -t -v "//position")
    elif [[ $line == *"<price.amount>"* ]]; then
      price=$(echo "$line" | xmlstarlet sel -t -v "//price.amount")
      echo "$date,$hour,$price" >> "$CSV_OUTPUT_FILE"
    fi
  done < "$LAST_XML_FILE"

  echo "CSV file generated from the last found XML file: $CSV_OUTPUT_FILE"
else
  echo "Error: No XML files found in '$XML_DIR'."
fi
