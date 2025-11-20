#!/bin/bash

var="8dm7KsjU28B7v621Jls"
value="ERmFRMVZ0U2paTlJYTkxDZz09Cg"

for i in {1..40}
do
        var=$(echo $var | base64)

        #If var is equal to value plus any preceding and proceeding characters AND 
        #count(var) greater than 113450 THEN
        #echo var's last 20 characters without a new line

        if [[ $var == *"$value"* && $(echo $var | wc -m) -gt 113450 ]]
        then
                echo -n ${var: -20}
        fi
done