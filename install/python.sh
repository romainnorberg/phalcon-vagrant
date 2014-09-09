#!/bin/bash

#
# Pip
#
sudo apt-get install -y python-pip python-dev build-essential

#
# Get the latest Pip
#
sudo pip install --upgrade pip

#
# Common Packages
#
sudo pip install virtualenv fabric requests
