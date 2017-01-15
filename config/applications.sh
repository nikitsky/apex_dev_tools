#!/bin/bash
##############################################################################################################################
#  APEX applications configuration file
#  For every application alias two variables: appId and appName
#
#  the following SQL can be used to get this info:
#      select lower(ALIAS) ALIAS, APPLICATION_ID,  APPLICATION_NAME
#      from APEX_APPLICATIONS where OWNER = user;
#         /or WORKSPACE_DISPLAY_NAME='MY_WORKSPACE_NAME' /
##############################################################################################################################


known_apps() {
	echo " known application aliases:"
	echo "       home  -> Portal home"
	echo "       wcmp  -> Management portal (legacy)"
	echo "       mpm   -> Management portal"
	echo "       ptt   -> Project Time Tracker"
	echo "       amc   -> Application Management Services calculator"
	echo "       cfm   -> Cashflow management"
	echo "       wdtac -> Administrative console"
}

all_apps() {
	echo "home wcmp mpm ptt amc cfm wdtac"
}

set_appId1() {
	case "$1" in
		home)
			appId=100
			appName="Portal home"
			;;
		wcmp)
			appId=110
			appName="Management portal (legacy)"
			;;
		ptt)
			appId=120
			appName="Project Time Tracker"
			;;
		wdtac)
			appId=130
			appName="Administrative console"
			;;
		mpm)
			appId=140
			appName="Management portal"
			;;
		cfm)
			appId=0
			appName="Cashflow management"
			;;
		amc)
			appId=160
			appName="AMS calculator"
			;;
		*)
			echo Unknown application $1
			known_apps
			exit 1
	esac
}

set_appId2() {
	case "$1" in
		home)
			appId=0
			appName="Portal home"
			;;
		wcmp)
			appId=210
			appName="Management portal (legacy)"
			;;
		ptt)
			appId=220
			appName="Project Time Tracker"
			;;
		wdtac)
			appId=230
			appName="Administrative console"
			;;
		mpm)
			appId=240
			appName="Management portal"
			;;
		cfm)
			appId=250
			appName="Cashflow management"
			;;
		amc)
			appId=260
			appName="AMS calculator"
			;;
		*)
			echo Unknown application $1
			known_apps
			exit 1
	esac
}
