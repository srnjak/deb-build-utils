#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status

# Get the directory of the script
SCRIPT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

# Default values for deployment options
DEPLOY_USER=""
DEPLOY_PASSWORD=""
DEPLOY_REPO=""
PACKAGE_NAME=""
OUTPUT_FILE=""
PROJECT_ROOT=""

# Function to print usage information
function print_usage() {
  cat << EOF

Usage:
    $0 clean [-d <project_root>]
    $0 prepare -n <package_name> [-d <project_root>]
    $0 package -n <package_name> [-d <project_root>] [-o <output_filename>]
    $0 deploy -n <package_name> -u <username> -p <password> -r <repository_url> [-d <project_root>]

Commands:
  clean      - Remove the target directory
  prepare    - Prepares the debian directory structure
  package    - Package the application into a .deb file
  deploy     - Deploy the .deb file to a repository

Options:
  -u <username>         - The username for the repository
  -p <password>         - The password for the repository
  -r <repository_url>   - The URL of the repository to deploy to
  -n <package_name>     - The name of the package
  -o <output_filename>  - The name of the .deb file to create
  -d <project_root>     - The path to the root directory of the project. If this path is not set, the current directory will be taken into consideration.
EOF
}

# Function to check if an input value is empty or not
function check_input() {
  if [[ -z "$1" ]]; then
    echo "Error: $2 is missing or empty."
    exit 1
  fi
}

command=$1
shift

# Parse command-line options
while getopts ":u:p:r:n:o:d:" opt; do
  case ${opt} in
    u )
      DEPLOY_USER=${OPTARG}
      ;;
    p )
      DEPLOY_PASSWORD=${OPTARG}
      ;;
    r )
      DEPLOY_REPO=${OPTARG}
      ;;
    n )
      PACKAGE_NAME=${OPTARG}
      ;;
    o )
      OUTPUT_FILE=${OPTARG}
      ;;
    d )
      PROJECT_ROOT=${OPTARG}
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      print_usage
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." 1>&2
      print_usage
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Check if PROJECT_ROOT variable is set. If it isn't, set it to the current directory.
if [[ -z "${PROJECT_ROOT}" ]]; then
  PROJECT_ROOT=$(pwd)
fi

echo "The project root directory is: $PROJECT_ROOT"

# The target directory
TARGET_DIR="$PROJECT_ROOT/target"

# Execute the appropriate command
case "$command" in
  clean)
    echo "Cleaning up..."
    rm -rf $TARGET_DIR
    ;;
  prepare)
    echo "Preparing..."

    # Check package name option
    check_input "$PACKAGE_NAME" "Package name"

    "$SCRIPT_DIR"/generate_control_file.sh "$PROJECT_ROOT"
    "$SCRIPT_DIR"/deb_structure.sh -p "$PACKAGE_NAME" "$PROJECT_ROOT"
    ;;
  package)
    echo "Packaging..."

    # Define the target path variable
    if [[ -z "$OUTPUT_FILE" ]]; then
      TARGET_PATH="$TARGET_DIR"
    else
      TARGET_PATH="$TARGET_DIR/$OUTPUT_FILE"
    fi

    dpkg-deb --build "$TARGET_DIR/$PACKAGE_NAME" "$TARGET_PATH"
    ;;
  deploy)
    echo "Deploying..."

    # Check deployment options
    check_input "$DEPLOY_USER" "Username"
    check_input "$DEPLOY_PASSWORD" "Password"
    check_input "$DEPLOY_REPO" "Repository URL"

    # Check package name option
    check_input "$PACKAGE_NAME" "Package name"

    # Check repository URL format
    if [[ ! "$DEPLOY_REPO" =~ ^https?:// ]]; then
      echo "Error: Invalid repository URL format. The URL should start with http:// or https://"
      exit 1
    fi

    echo "Deploying with username $DEPLOY_USER, and repository URL $DEPLOY_REPO..."
    curl -u "$DEPLOY_USER:$DEPLOY_PASSWORD" -H "Content-Type: multipart/form-data" --data-binary "@$TARGET_DIR/$PACKAGE_NAME.deb" -f "$DEPLOY_REPO"

    ;;
  *)
    echo "Invalid command. Please use one of the following commands: clean, prepare, package, deploy."
    print_usage
    exit 1
    ;;
esac

exit 0
