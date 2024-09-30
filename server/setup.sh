#!/bin/bash

# Set the compiler and flags
COMPILER=gcc
FLAGS="-Wall -Wextra -pedantic"

# Set the source and object files
SOURCE_FILE=main.c
OBJECT_FILE=main.o

# Compile the program
echo "Compiling $SOURCE_FILE..."
$COMPILER $FLAGS -c $SOURCE_FILE

# Link the object file
echo "Linking $OBJECT_FILE..."
$COMPILER $FLAGS $OBJECT_FILE -o main

# Run the program
echo "Running the program..."
./main

# Clean up
echo "Cleaning up..."
rm -f $OBJECT_FILE
