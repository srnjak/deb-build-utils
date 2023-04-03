# Script for Building and Deploying Debian Packages

`Builder.sh` is a bash script that automates the process of cleaning, preparing, packaging and deploying a Debian package to a repository.

## Usage

    builder.sh clean [-d <project_root>]
    builder.sh prepare -n <package_name> [-d <project_root>]
    builder.sh package -n <package_name> [-d <project_root>] [-o <output_filename>]
    builder.sh deploy -n <package_name> -u <username> -p <password> -r <repository_url> [-d <project_root>]

## Commands

- `clean`: Clean the target directory
- `prepare`: Prepare the debian directory structure
- `package`: Packages the application into a .deb file. The optional `-n` flag can be used to specify the name of the .deb package to create (without extension).
- `deploy`: Deploys the .deb file to a repository. The required `-u`, `-p`, `-r` and `-n` flags must be used to specify the username, password, repository URL and package name respectively.

## Options

- `-u <username>`: The username for the repository.
- `-p <password>`: The password for the repository.
- `-r <repository_url>`: The URL of the repository to deploy to.
- `-n <package_name>`: The name of the package
- `-o <output_filename>`: The name of the .deb file to create
- `-d <project_root>`: The path to the root directory of the project. If this path is not set, the current directory will be taken into consideration.

## Examples

Clean:

    ./builder.sh clean

Prepare:

    ./builder.sh prepare -n mypackage

Package:

    ./builder.sh package -n mypackage

Deploy:

    ./builder.sh deploy -n mypackage -u myusername -p mypassword -r https://myrepo.com/debian
