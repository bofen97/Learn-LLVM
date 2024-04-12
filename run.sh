#!/bin/bash

# Set the C and C++ compilers
# export CMAKE_C_COMPILER=clang
# export CMAKE_CXX_COMPILER=clang++

# Change to the project directory (replace with your actual project directory)
cd ./build

if [ -f toy ]; then
  # If it exists, delete it
  rm toy
  echo "toy file deleted"
else
  # If it doesn't exist, print a message
  echo "toy file not found"
fi

# Generate Ninja build files
# cmake -GNinja ..
cmake -GNinja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ ..

# Build the project
ninja

# Run the executable

if [ -f toy ]; then
  # If it exists, delete it
   ./toy
else
  # If it doesn't exist, print a message
  echo "compile error"
fi

