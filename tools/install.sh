#!/bin/bash

SCRIPT_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") >/dev/null 2>&1 && pwd -P)
PROGRAM=$(basename "${BASH_SOURCE[0]}")

if [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]
then
	# TODO: Implement for Ubuntu environment
	echo "Not yet implemented for Ubuntu"
	exit 1
elif [[ "$OSTYPE" =~ ^darwin ]]
then
	RIME_CFG_PATH=$HOME/Library/Rime
	RIME_APP="/Library/Input Methods/Squirrel.app"
else
	echo "Unsupported OS"
	exit 1
fi

HELP_MSG="
Usage: ${PROGRAM} [-uh] install Open Xiami configuration for RIME framework

Options
  -u, --uninstall - Remove relative files under $RIME_CFG_PATH
  -h, --help      - This message
"
function log_copy()
{
	echo "(COPY) $(basename $1) -> $2"
	cp $1 $2
}

function log_remove()
{
	echo "(REMOVE) $1"
	rm $1
}

function install()
{
	for cfgfile in $SCRIPT_PATH/../Rime/*.yaml; do
		log_copy $cfgfile $RIME_CFG_PATH
	done
}

function uninstall()
{
	for cfgfile in $SCRIPT_PATH/../Rime/*.yaml; do
		log_remove $RIME_CFG_PATH/$(basename $cfgfile)
	done
}

if [[ $# -eq 0 ]]
then
	install
fi

while (( "$#" )); do
	case "$1" in
		-i|--install)
			install
			shift
			;;
		-u|--uninstall)
			uninstall
			shift
			;;
		-h|--help)
			echo "$HELP_MSG"
			exit 1
			;;
		-*)
			echo "Unknown flag $1"
			echo "$HELP_MSG"
			shift
			;;
		*)
			echo "Unknown argument $1"
			echo "$HELP_MSG"
			exit 1
			;;
	esac
done
