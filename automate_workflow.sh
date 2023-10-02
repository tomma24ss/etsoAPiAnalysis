#!/bin/bash
echo "Starting workflow"

echo "Getting new data"
./get_electricity_prices.sh
echo "implementing changes"
./get_csv.sh
echo "Creating new report"
# Execute notebook
python execute_notebook.py

# Convert notebook to pdf
echo "Converting notebook to pdf"
current_date=$(date +'%Y-%m-%d')
output_filename="report_${current_date}.pdf"
output_directory="reports"
# Create the reports directory if it doesn't exist
mkdir -p "${output_directory}"
# Generate the PDF and save it in the reports directory
jupyter nbconvert --to pdf --TemplateExporter.exclude_input=True --output "${output_directory}/${output_filename}" analyse.ipynb

echo "Workflow completed"