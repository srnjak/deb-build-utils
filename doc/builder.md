# Script for Building and Deploying Debian Packages

`Builder.sh` is a bash script that automates the process of cleaning, preparing, packaging and deploying a Debian package to a repository.

## Usage

    ./builder.sh clean
    ./builder.sh prepare
    ./builder.sh package [-n <package_name>]
    ./builder.sh deploy -u <username> -p <password> -r <repository_url> -n <package_name>

## Commands

- `clean`: Clean the target directory
- `prepare`: Prepare the debian directory structure
- `package`: Packages the application into a .deb file. The optional `-n` flag can be used to specify the name of the .deb package to create (without extension).
- `deploy`: Deploys the .deb file to a repository. The required `-u`, `-p`, `-r` and `-n` flags must be used to specify the username, password, repository URL and package name respectively.

## Options

- `-u <username>`: The username for the repository.
- `-p <password>`: The password for the repository.
- `-r <repository_url>`: The URL of the repository to deploy to.
- `-n <package_name>`: The name of the .deb package to create (without extension).

## Examples

Clean:

    ./builder.sh clean

Prepare:

    ./builder.sh prepare

Package:

    ./builder.sh package -n mypackage

Deploy:

    ./builder.sh deploy -u myusername -p mypassword -r https://myrepo.com/debian -n mypackage
