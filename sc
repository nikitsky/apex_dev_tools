#!/bin/bash
. config/environments.sh

help_and_usage() {
	echo "Usage: ${0##*/} [<environment>]"
	echo "Help:  ${0##*/} calls SQLCl and connects to the specified environment"
	echo "       by default, it connetcs to development environment"
	echo
	known_env

}

#
# Set CLASSPATH to be canonical paths
#
function setupSQLPATH {
	#
	# resolve the folder where this script is located, traversing any symlinks
	#
	PRG="$0"
	# loop while $PRG is a symlink
	while [ -h "$PRG" ] ; do
	  # figure out target of the symlink
	  ls=`ls -ld "$PRG"`
	  link=`expr "$ls" : '.*-> \(.*\)$'`
	  # traverse to the target of the symlink
	  if expr "$link" : '/.*' > /dev/null; then
	  PRG="$link"
	  else
	  PRG=`dirname "$PRG"`"/$link"
	  fi
	done

	#
	# PROJECT_HOME is where we live.  Lets get an exact path.
	PROJECT_HOME=`dirname "$PRG"`
	PROJECT_HOME=`cd "${PROJECT_HOME}" > /dev/null && pwd`
	export SQLPATH=$PROJECT_HOME/tools/sqlcl
}

#####################################################################################################################################

environment=${1:-"dev"}

if [[ $environment == "-?" ]] ; then
	help_and_usage
	exit 1
fi

set_env $environment

#set iTerm badge
printf "\e]1337;SetBadgeFormat=%s\a" \
→   $(echo -n "$iTermBadge" | base64)

setupSQLPATH
sql -L $databaseUser/$databasePassword@$databaseUrl

#clear iTerm badge
printf "\e]1337;SetBadgeFormat=%s\a" \
→   $(echo -n "" | base64)
