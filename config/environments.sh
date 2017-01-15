#!/bin/bash

known_env() {
	echo " environments:"
	echo "       local -> local VM"
	echo "       dev   -> development"
	echo "       stage -> staging"
	echo "       prod  -> production"
}

set_env() {
	case "$1" in
		dev)
			databaseUrl="dev.database.company.com:1521:orcl"
			databaseUser="scott"
			databasePassword="tigger"
			sshServer="dev.database.company.com"
			sshPort=22
			sshUser="scott"
			iTermBadge="🔆 dev"
			;;
		stage)
			databaseUrl="stage.database.company.com:1521:orcl"
			databaseUser="scott"
			databasePassword="tigger"
			sshServer="dev.database.company.com"
			sshPort=22
			sshUser="scott"
			iTermBadge="🔆 stage"
			;;
		prod)
			databaseUrl="prod.database.company.com:1521:orcl"
			databaseUser="scott"
			databasePassword="tigger"
			sshServer="prod.database.company.com"
			sshPort=22
			sshUser="scott"
			iTermBadge="🚷PROD"
			;;
		local)
			databaseUrl="localhost:1521:orcl"
			databaseUser="val"
			databasePassword="tiggers"
			sshServer="localhost"
			sshPort=2222
			sshUser="oracle"
			iTermBadge="🔆 local"
			;;
		*)
			echo Unknown environment $1
			known_env
            exit 1
	esac
}