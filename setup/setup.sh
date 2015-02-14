#!/bin/bash - 
#===============================================================================
#
#          FILE: setup.sh
# 
#         USAGE: ./setup.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 02/13/2015 21:47
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function isWebDriverRunning()
{
	running=$(ps aux | grep webdriver | grep -v grep | awk '{ print $2 }');
	echo $running;
}

function isProtractorInstalled()
{
	installed=$(which protractor | grep -v found);
	echo $installed;
}

function installProtractor()
{
	installed=$(isProtractorInstalled);
	if [ -z ${installed} ]
	then
		echo "Installing Protractor...";
		npm install -g protractor;
	fi
	echo "Protractor Installed!";
}

function setupProtractor()
{
	running=$(isWebDriverRunning);

	if [ -z "$running" ]
	then
		installProtractor;
		echo "Setting Up Protractor...";
		webdriver-manager update;
		webdriver-manager start &
	fi

	echo "Protractor Set Up";
}

function main()
{
	setupProtractor;
}

main;
