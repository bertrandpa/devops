#!/bin/bash
   
HTTP_CODE=$(curl --write-out "%{http_code}\n" "http://http://localhost/departments/IRC/students" --output output.txt --silent)
echo $HTTP_CODE 