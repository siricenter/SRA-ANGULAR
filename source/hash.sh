#!/bin/bash - 
#===============================================================================
#
#          FILE: hash.sh
# 
#         USAGE: ./hash.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 02/25/2015 02:10
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

find . -name "*.html" | xargs -I file gsed -i 's;href="\/admin;href=";g' file

