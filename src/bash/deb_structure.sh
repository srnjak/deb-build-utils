#!/bin/bash

function usage {
    cat << EOF
Usage: $0 -p package_name root_dir
       $0 -h

Create directory structure and copy files.

Positional arguments:
 root_dir            The root directory to create the target directory in.

Optional arguments:
 -h                 Print this help message.
 -p package_name    The name of the package to create and copy files for.
EOF
}

package_name=""

while getopts ":hp:" opt; do
    case ${opt} in
        h )
            usage
            exit 0
            ;;
        p )
            package_name="$OPTARG"
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
        : )
            echo "Invalid option: -$OPTARG requires an argument" >&2
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))

root_dir=$1

# Define the copy_files function
copy_files() {
  local destinations_file="$1"
  local package_name="$2"
  local source_root="$root_dir/src"
  local destination_root="$root_dir/target/$package_name"

  # Loop through each line in the destinations file
  while IFS=':' read -r source_file destination_dir; do
    # Ignore lines that start with #
    if [[ $source_file == \#* ]]; then
      continue
    fi

    # Trim leading/trailing whitespace from source and destination file paths
    source_file=$(echo "$source_file" | awk '{$1=$1};1')
    destination_dir=$(echo "$destination_dir" | awk '{$1=$1};1')

    # Skip over lines with empty source files after trimming
    if [[ -z "$source_file" ]]; then
      continue
    fi

    # Create the target directory if it doesn't exist
    target_dir=$(dirname "$destination_root/$destination_dir")
    mkdir -p "$target_dir/"

    # Copy the source file(s) to the destination
    # shellcheck disable=SC2086
    cp -rv $source_root/$source_file "$target_dir/"
  done < "$destinations_file"
}

if [ -z "$root_dir" ]
then
    echo "Error: root directory not specified"
    usage
    exit 1
fi

if [ -z "$package_name" ]
then
    echo "Error: package name not specified"
    usage
    exit 1
fi

mkdir -p "$root_dir/target/$package_name/DEBIAN"
cp -r "$root_dir/target/DEBIAN" "$root_dir/target/$package_name"

# Copying the files
copy_files "$(realpath "$root_dir/src/debian/destinations")" "$package_name"
