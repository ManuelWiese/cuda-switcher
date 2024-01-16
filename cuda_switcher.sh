#!/bin/bash

# Save the original PATH and LD_LIBRARY_PATH
ORIGINAL_PATH=$PATH
ORIGINAL_LD_LIBRARY_PATH=$LD_LIBRARY_PATH

# Detect available CUDA versions and sort by version in reverse order
cuda_versions=$(ls /usr/local | grep cuda- | sed 's/cuda-//' | sort -rV)

# Function to set CUDA environment variables for a specified version
set_cuda_version() {
    local cuda_version=$1
    # Reset PATH and LD_LIBRARY_PATH to their original state
    export PATH=$ORIGINAL_PATH
    export LD_LIBRARY_PATH=$ORIGINAL_LD_LIBRARY_PATH

    # Update PATH and LD_LIBRARY_PATH for the new CUDA version
    export CUDA_HOME=/usr/local/cuda-$cuda_version
    export PATH=$CUDA_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
    echo -e "Switched to CUDA \e[1;32m$cuda_version\e[0m"
    echo

    # Display CUDA version
    echo "Output of 'nvcc --version':"
    nvcc --version
    echo

    echo "cuDNN installation:"
    # Check for cuDNN version
    local cudnn_header="$CUDA_HOME/include/cudnn_version.h"
    if [ -f "$cudnn_header" ]; then
	echo -n "cuDNN version: "
	local major=$(grep "#define CUDNN_MAJOR" $cudnn_header | cut -d ' ' -f 3)
	local minor=$(grep "#define CUDNN_MINOR" $cudnn_header | cut -d ' ' -f 3)
	local patch=$(grep "#define CUDNN_PATCHLEVEL" $cudnn_header | cut -d ' ' -f 3)
	echo -e "\e[1;32m$major.$minor.$patch\e[0m"
    else
	echo "cuDNN not found for CUDA $cuda_version"
    fi
}

# Set the default CUDA version
default_cuda_version=$(echo $cuda_versions | cut -d ' ' -f1)
set_cuda_version $default_cuda_version

# Function to switch CUDA version or display available versions
cuda_switch() {
    if [ $# -eq 0 ]; then
        echo "Available CUDA versions:"
        echo $cuda_versions
        echo "Usage: cuda_switch [version]"
    else
        local new_version=$1
        if [[ $cuda_versions == *"$new_version"* ]]; then
            set_cuda_version $new_version
        else
            echo "CUDA version $new_version is not installed."
        fi
    fi
}

# Export the switch function for user access
export -f cuda_switch
