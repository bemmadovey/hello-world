#!/bin/bash

# 1. I have an instruction for you Ian, I want you to review this script and I want you to create a path variable
# You will create a path variable for "$directory/" and then replace all occurences in the script with that variable.

# If you run into any issues check out this link, it has helpful information on the entire manual installation process from CLI.  https://crunchify.com/setup-wordpress-amazon-aws-ec2/

# The main purpose of this script is to use Bash to install WordPress.

# After we execute this script succcessfully we will make sure create a script that takes input from a user running the script from CLI.
# We will take we learn from that and create a script to nest in a HTML5 page that will be like a QuickInstall button and run the program with sudo privileges.

# Intro terminal output for user and prompt for input. The input will be read into a variable, and this variable will be used for case statement comparison
# echo "This script will install WordPress"
read -p "Type y to proceed or N to cancel script " inputVar
echo $inputVar

# Variables stored for Case statement evaluation
install="yes"
noinstall="No"
directory="/home/$USER/public_html"

# Case statement rather than if/else statement.
# Case statements are cleaner when completing multiple evaluations.
case $inputVar in
    $install)
        # Print beginning message of script
        echo ""
        echo Starting WordPress Installation...
        echo ""
        # Make a directory for the WordPress installation
        

	# This command is commented out because your server is running Cpanel.
	# My server does not have a Cpanel license so I had to create the directory
	# commented command > mkdir -v $directory
        
        # Download the tarball of WordPress from https://wordpress.org/latest.tar.gz
        wget 'https://wordpress.org/latest.tar.gz' -P $directory
        
        # Unzip the wordpress latest.tar.gz tarball
        tar xzfv $directory/latest.tar.gz -C $directory/
        
        # Move the files into the proper directory
        mv -v $directory/wordpress/* $directory/
        
        # Clean up the directory and copy wp-config-sample.php
        rmdir -v $directory/wordpress
        rm -rfv $directory/latest.tar.gz
        
        # Print to screen that the script is complete
        echo ""
        echo ""
        echo "Your WordPress installation is complete!"
        echo "Thanks, $USER"
	
	# Renaming the wp-config-sample.php to wp-config.php
	mv -v $directory/wp-config-sample.php $directory/wp-config.php

	mysqladmin -u $USER create blog # This used the MySQL CLI to create a database named "blog" using "$USER"
	# Your database password will be the $USER password.
	
        # We now have WordPress ready for an installation on this small script.
        # Following we will make a script that will create and assign the database to the wordpress installation.
        # This will make it possible to simply go to the a browser to finish the installation
        ;;
    $noinstall)
        echo ""
        echo Canceling script
        ;;
    *)
        echo Incorrect input, Cancelling script
        ;;
esac
