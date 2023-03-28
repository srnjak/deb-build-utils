# Build a deb package
Clean the target directory

    ./utils/builder.sh clean

Prepare the debian directory structure

    ./utils/builder.sh prepare

Package the application into a .deb file

    ./utils/builder.sh package
    
    # Or with a provided specific name of the package file
    ./utils/builder.sh package -n <package_name>

Deploy the .deb file to a repository (Only Nexus currently supported.)

    ./utils/builder.sh deploy -u <username> -p <password> -r <repository> -n <package_name>
