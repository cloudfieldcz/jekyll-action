#!/bin/bash

CURRENT_DIR=`pwd`

if [ -z "$1" ]; then    
    SOURCE="./_site"
else
    SOURCE=$1
fi

# ATTRIBUTES_OFF=$(tput sgr0)

# WEIGHT_BOLD=$(tput bold)
# DECOR_UNDERLINE=$(tput smul)
# DECOR_UNDERLINE_OFF=$(tput rmul)
# CLR_GREEN=$(tput setf 2)
# CLR_RED=$(tput setf 1)
# CLR_DEFAULT=$(tput setf 9)

function run_command {
    eval $1
}
# write a block start message ($1) in a standard format.
function start_block {        
    echo ""
    echo ""
    echo "> $1"    
}

# writes a success message ($1) in a standard format
function end_block_success {
    echo "   * $1"
}

# writes an error message ($1) in a standard format and exits the script
function end_block_failed {
    echo "   X $1"
    exit 1
}

# writes a line in a block
function block_msg {
    echo "   - $1"
}

# validates that the given environment variable name ($1) is in the environment - exits the script if not found
function check_env {
    if [ -z "${!1}" ]
    then
        end_block_failed "$1 is not set in environment. Exiting..."
    else        
        if [ "$2" = "secret" ]; then
            end_block_success "$1 found: ${!1:0:2}... "
        else
            end_block_success "$1 found: ${!1}"
        fi        
    fi     
}

# Makes sure that all the necessary environment variables are present.
function validate_environment {
    start_block "Checking for expected environment variables"
    check_env "SOURCE"

    start_block "Checking working directory for expected files(${CURRENT_DIR})"
    if test -f "_config.yml"; then
        end_block_success "Found jekyll config file"
    else
        end_block_failed "Unable to find the Jekyll config file in the current working directory."
    fi
}  

# Run the bundler install command to ensure that all dependencies are installed for 
#   the jekyll site.
function install_gems {
    start_block "Installing bundle gems (this can take up to 2 minutes)"
    bundle install > /dev/null
    end_block_success "Completed bundle install"
}

# Does a simple build of the jekyll site.
function build_site {
    start_block "Building jekyll site"
    bundle exec jekyll build > /dev/null || end_block_failed "Jekyll build failed. Exiting..."
    end_block_success "Jekyll build done"
}

chmod -R 777 .

validate_environment
install_gems
build_site

