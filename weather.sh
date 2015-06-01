#!/bin/bash

if [ -f email.txt ]
  then
    rm -f email.txt
fi

echo "" >> email.txt

echo "************************************************" >> email.txt
echo "    Weather for $(date "+%m-%d-%y %H:%M:%S")    " >> email.txt
echo "************************************************" >> email.txt
echo "" >> email.txt

curl --silent -o output.json 'http://api.openweathermap.org/data/2.5/forecast/daily?id=4273837&units=imperial&cnt=1'

high=$(cat output.json | jq .list[0].temp.max)
low=$(cat output.json | jq .list[0].temp.min)
wind=$(cat output.json | jq .list[0].speed)
humidity=$(cat output.json | jq .list[0].humidity)
main=$(cat output.json | jq .list[0].weather[0].main)
descrip=$(cat output.json | jq .list[0].weather[0].description)
echo "High Temp: $high F" >> email.txt
echo "Low Temp: $low F" >> email.txt
echo "Wind: $wind MPH" >> email.txt
echo "Humidity: $humidity%" >> email.txt
echo "Main Conditions: $main" >> email.txt
echo "Description: $descrip" >> email.txt

mail -s "Daily Weather Report" ebeahan@icloud.com < email.txt
