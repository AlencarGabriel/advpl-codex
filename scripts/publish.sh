#!/bin/bash
VERSION=${1:-patch}

vsce --version
if [ ! $? -eq 0 ]
then
    echo "vsce must be installed for package generation and publishing"
    exit 1
fi

vsce package
if [ ! $? -eq 0 ]
then
    echo "Package creation failed"
    exit 1
fi

if [ ! -e ".token" ]
then
    echo "VsCode Marketplace token must be in file .token"
    exit 1
fi
TOKEN=`cat .token`

case $VERSION in
    major|minor|patch)
        echo "Building $VERSION version with token $TOKEN..."
        vsce publish -p $TOKEN $VERSION
        echo "Build finished."
        ;;
    *)
        echo "Parameter $VERSION should be major, minor or patch"
        exit 1;;
esac
