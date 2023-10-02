#!/bin/bash

# API URL
API_URL="https://api.open-meteo.com/v1/forecast?latitude=50.939780&longitude=3.79940&hourly=temperature_2m"

get_temperatures() {
    # Make the API request using cURL and save the output to a variable
    json_data=$(curl -s "$API_URL")
}

calculate_average_temperature() {
    # Call the function to get temperatures
    get_temperatures
    
    # Extract the temperature values for tomorrow (assuming they are in the "hourly" array)
    tomorrow_temperatures=$(echo "$json_data" | jq -r '.hourly.temperature_2m[24:48]')
    echo $tomorrow_temperatures
    # Calculate the average temperature for tomorrow
    # Calculate the average temperature for tomorrow
    total=0
    count=0
    for temp in $tomorrow_temperatures; do
        #add total with temp
        echo $total
        total=$(echo "$total + $temp" | bc -l)
        echo $temp
        echo $sum
        
    done

    # Calculate the average
    average=$(bc -l <<< "scale=2; $total / $count")
    
    echo "Average temperature for tomorrow: ${average}°C"
}

# Call the function to calculate the average temperature
calculate_average_temperature
