#!/bin/bash
. config/environments.sh

help_and_usage() {
	echo "Usage: ${0##*/} [<environment>]"
	echo "Help:  ${0##*/} calls SQLCl and connects to the specified environment"
	echo "       by default, it connetcs to development environment"
	echo
	known_env

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

/Users/nikitsky/Applications/sqlcl/bin/sql -L $databaseUser/$databasePassword@$databaseUrl

#clear iTerm badge
printf "\e]1337;SetBadgeFormat=%s\a" \
→   $(echo -n "" | base64)
