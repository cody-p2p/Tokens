#!/bin/bash

# Set the URL of the file to download
url="https://example.com/file.txt"

# Set the name of the file to save the download as
filename="file.txt"

# Use wget to download the file
wget -O $filename $url

# Check if the download was successful
if [ $? -eq 0 ]; then
  echo "Download successful!"
else
  echo "Download failed!"
fi
