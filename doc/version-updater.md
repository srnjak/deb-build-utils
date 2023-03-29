# Project Version Updater

This script allows you to update the version number in a project's `project.properties` file. The script provides three options for updating the version number:

1. `--release`: Strips any suffix from the current version.
2. `--new-preview`: Increases the minor part of the version and adds a "prev" suffix, unless the version already has a "prevX" suffix, in which case it will increase that number.
3. `--new-version`: Specifies a new version to use.

## Requirements

This script requires `bash` to be installed on your system.

## Usage

    $ ./version_updater.sh <project_root> --release|--new-preview|--new-version [<new_version>]

### Arguments:

- `<project_root>`: The root directory of the project, containing the `project.properties` file.
- `<new_version>` (optional): The new version to use, if `--new-version` is specified.

### Options:

- `--release`: Strip any suffix from the current version.
- `--new-preview`: Increase the minor part of the version and add a "prev" suffix, unless the version already has a "prevX" suffix, in which case it will increase that number.
- `--new-version`: Specify a new version to use.

### Example usage:

To update the version number of a project located in `/path/to/my/project` to the next preview version:

    $ ./version_updater.sh /path/to/my/project --new-preview


To update the version number of a project located in `/path/to/my/project` to version `1.2.3`:

    $ ./version_updater.sh /path/to/my/project --new-version 1.2.3
