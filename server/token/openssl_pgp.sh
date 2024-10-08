#!/bin/bash

# Add the PGP key file
openssl pkey -in key.asc -out key.pem

# Use the PGP key to encrypt/decrypt files
openssl rsautl -encrypt -in file.txt -out file.txt.enc -pubin -inkey key.pem
openssl rsautl -decrypt -in file.txt.enc -out file.txt -inkey key.pem
