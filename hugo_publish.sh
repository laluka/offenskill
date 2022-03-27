#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Please specify commit message"
    exit
fi

# Show what we'll do
git status
read -p "Add all and publish as : $1 ?"

# Clean the published dir
/bin/rm -rf offenskill-public
git clone git@github.com:laluka/offenskill-public.git
/bin/rm -rf offenskill-public/*


# Generate static files
./hugo -d offenskill-public -b https://offenskill.com/
git add .
git status
read -p "Still sure ?"
git commit -a -m "$1"
git push

# Publish the site
pushd offenskill-public
git add .
git commit -a -m "$1"
git push
popd
