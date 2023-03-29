# Debian Build Utilities

This repository contains a set of Bash scripts that automate various tasks related to building, packaging, and deploying a project on a Debian-based system.

## Scripts

The following scripts are available:

### version-manager.sh

The `version-manager.sh` script updates the version number in a project's `project.properties` file. 
It provides three options to update the version number and prints the new version number to the console. 

For more detailed information, see the [documentation file](doc/version-manager.md).

### generate_control_file.sh

The `generate_control_file.sh` script reads variables from the project properties file, replaces them in the template file, and outputs the generated control file to the target/DEBIAN directory. 
It simplifies the process of generating a Debian control file. 

For more detailed information, see the [documentation file](doc/generate_control_file.md).

### deb_structure.sh

The `deb_structure.sh` script creates a directory structure and copies files based on the information provided in a 'destinations' file. 
The resulting target directory can be used to create a Debian package. 

For more detailed information, see the [documentation file](doc/deb_structure.md).

### builder.sh

The `builder.sh` script performs a series of operations related to the building, packaging, and deployment of a project. 
It takes command-line arguments to perform specific actions such as cleaning up the project, preparing the Debian directory structure, packaging the application into a .deb file, and deploying the .deb file to a repository. 

For more detailed information, see the [documentation file](doc/builder.md).

## License

This project is licensed under the [MIT License](LICENSE).
