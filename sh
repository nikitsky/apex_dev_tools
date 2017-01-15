#!/bin/bash
. config/environments.sh

help_and_usage() {
	echo "Usage: ${0##*/} [<environment>]"
	echo "Help:  ${0##*/} secure terminal shell to an environmant"
	echo "       by default, it connects to development environment"
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

ssh $sshServer -p $sshPort -l $sshUser

#clear iTerm badge
printf "\e]1337;SetBadgeFormat=%s\a" \
→   $(echo -n "" | base64)
