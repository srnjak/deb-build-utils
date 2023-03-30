# Generate Control File Script

This Bash script named `generate_control_file.sh` generates a Debian control file from a template and a project properties file.
The generate_control_file.sh Bash script performs the following tasks: it creates the target/DEBIAN directory if it does not already exist, defines the paths to the template and output files, replaces values in the template file with those from the properties file, and finally, outputs the generated control file to the target directory.

## Prerequisites

The script requires the following tools to be installed:

- Bash
- sed

## Usage

To use the script, run the following command:

    ./generate_control_file.sh <project_root_directory>


Replace `<project_root_directory>` with the path to the root directory of your project.

## Configuration

The script reads the properties from the `project.properties` file in the project root directory. 
The following variables are required:

- `package`: the name of the package
- `version`: the version of the package
- `maintainer`: the maintainer of the package
- `description`: a short description of the package

## Output

The script generates a Debian control file and outputs it to the `target/DEBIAN/control` file in the project root directory. 
The generated file contains the values of the variables from the `project.properties` file.
