# cuda-switcher

`cuda-switcher` is a Bash script for managing multiple CUDA installations on a single system. It allows users to switch between different CUDA versions easily and displays the currently active CUDA and cuDNN versions.

## Features

- Automatically detects installed CUDA versions.
- Allows sourcing the script to switch between CUDA versions.
- Displays the current CUDA version using `nvcc --version`.
- Checks for and displays the installed cuDNN version, if available.
- Supports systems with multiple CUDA installations.

## Prerequisites

- Bash shell
- NVIDIA CUDA Toolkit(s) installed in `/usr/local/cuda-<version>`
- Optionally, NVIDIA cuDNN installed in the CUDA directories

## Installation

1. Clone the repository or download the `cuda-switcher.sh` script:

   ```sh
   git clone https://github.com/ManuelWiese/cuda-switcher.git
   ```

2. Source the script in your `.bashrc` or `.bash_profile`:

   ```sh
   echo 'source /path/to/cuda-switcher/cuda-switcher.sh' >> ~/.bashrc
   source ~/.bashrc
   ```

## Usage

To switch to a specific CUDA version, use the `cuda_switch` function after sourcing the script:

```sh
cuda_switch <version>
```

For example, to switch to CUDA 11.8:

```sh
cuda_switch 11.8
```

To list available CUDA versions:

```sh
cuda_switch
```

## Contributing

Contributions to `cuda-switcher` are welcome! Please submit pull requests or create issues for any features, fixes, or enhancements.
