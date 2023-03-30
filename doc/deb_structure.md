# Creating a Debian Package File Structure

`deb_structure.sh` is a bash script that creates a directory structure and copies files. 
The script takes the root directory as input and creates a target directory with the specified package name inside it. 
It also copies files from the source directory to the target directory.

## Usage

The script requires at least one positional argument, the `root_dir`, which is the root directory to create the target directory in. 
It also accepts the following optional arguments:

- `-h`: Displays help information.
- `-p`: Specifies the name of the package to create and copy files for.

Here's an example of how to use the script:

    ./deb_structure.sh -p my_package /home/user/my_project


This command will create a target directory named `my_package` inside the `/home/user/my_project` directory and copy files from the source directory to the target directory.

## Destination File

The `deb_structure.sh` script reads a `destinations` file from the `debian` folder to determine which files to copy and where to copy them to. 
The `destinations` file is a simple text file that contains a list of source files and their corresponding destination directories, separated by a colon `:`. 
Lines starting with `#` are ignored.

The left-hand side of the colon represents the path to the source file relative to the `src/` directory created under the `root_dir` specified as the first positional argument. 
<br/>For example, if the script is executed with `./deb_structure.sh -p my_package /home/user/project`, the source directory for the package would be `/home/user/project/src/`.

The right-hand side of the colon represents the path to the destination directory relative to the package directory in the `target/` directory created under the `root_dir` specified as the first positional argument, with the package name specified using the `-p` option. 
<br/>For example, if the script is executed with `./deb_structure.sh -p my_package /home/user/project`, the destination directory for the package would be `/home/user/project/target/my_package/`.

If the `destinations` file contains the following line:

    bash/my_script.sh:usr/local/bin

The my_script.sh file located in `/home/user/project/src/bash/my_script.sh` will be copied to `/home/user/project/target/my_package/usr/local/bin/my_script.sh` after the script execution.

## Debian Control File

In addition to the destinations file, the control file is also copied from the `target/DEBIAN` folder to the `target/my_package/DEBIAN` folder.

### Wildcard in Source Path

The source path may contain a wildcard character (`*`) to match multiple files. 

For example, if the `destinations` file contains the following line:

    bash/*.sh:usr/local/bin

all `.sh` files in `/home/user/project/src/bash` will be copied to `/home/user/project/target/my_package/usr/local/bin/` after the script execution.

## Examples
### Destinations File Syntax
Here's an example of a `destinations` file:

    # This is a destinations file example
    # Lines starting with '#' are ignored
    
    # Copy the entire contents of src/foo/bin to /usr/bin
    foo/bin/*:usr/bin/
    
    # Copy the file src/foo/bar.sh to /usr/lib
    foo/bar.sh:usr/lib/
    
    # Copy all .txt files in src/foo/data/ to /usr/share/foo/data/
    foo/data/*.txt:usr/share/foo/data/

This example shows three different lines, each with a different type of source path:

- The first line uses the `*` wildcard to specify that all files and directories in the `foo/` directory should be copied to `/usr/bin/`.
- The second line specifies a single file (`bar.sh`) in the `foo/` directory that should be copied to `/usr/lib/`.
- The third line uses the `*.txt` wildcard to specify that all files with a `.txt` extension in the `foo/data/` directory should be copied to `/usr/share/foo/data/`.

### Directory Structure

Assuming the script is run with the command:

    ./deb_structure.sh -p package_name /home/user/my_project

The initial directory structure looked like this:

    /home/user/my_project/
    ├── src/
    │   └── foo/
    │       ├── bin/
    │       │   ├── foo1.sh
    │       │   └── foo2.sh
    │       ├── bar.sh
    │       └── data/
    │           ├── data1.txt
    │           ├── data2.txt
    │           └── data3.csv
    └── target/
        └── DEBIAN/
            └── control

The resulting directory structure will look like this:

    /home/user/my_project/
    ├── src/
    │   └── foo/
    │       ├── bin/
    │       │   ├── foo1.sh
    │       │   └── foo2.sh
    │       ├── bar.sh
    │       └── data/
    │           ├── data1.txt
    │           ├── data2.txt
    │           └── data3.csv
    └── target/
        └── DEBIAN/
            └── control
        └── package_name/
            ├── DEBIAN/
            │   └── control
            └── usr/
                ├── bin/
                │   ├── foo1.sh
                │   └── foo2.sh
                ├── lib/
                │   └── bar.sh
                └── share/
                    └── foo/
                        └── data/
                            ├── data1.txt
                            └── data2.txt