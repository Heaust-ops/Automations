#!/bin/bash

# This is a nodemon like utility for cmake
# Run this in the same directory as your CMakeLists
# It watches for any changes and rebuilds your project

# you must have inotify-tools for this to work

# I have this in my home dir and set an alias to it for ease of use
# like, alias cmakeWatch="~/shellUtilities/cmakeWatch.sh"

x=$(pwd)
t=bin
# I like to have my build in a dir called bin, if you want any other name, change the value of t to it

while true; do
inotifywait -e modify,create,delete -r $x && \
cd $x && if [ -d "./$t" ]; then rm -Rf ./$t; fi && mkdir $t && cd $t && cmake .. && make && cd $x

done
