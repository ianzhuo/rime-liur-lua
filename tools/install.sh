#!/bin/bash

REPO_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") && cd .. && pwd -P)
PROGRAM=$(basename "${BASH_SOURCE[0]}")
PARAMS=
SUDO=

if [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
	# TODO: Implement for Ubuntu environment
	echo "Not yet implemented for Ubuntu"
	exit 1
elif [[ "$OSTYPE" =~ ^darwin ]]; then
	RIME_CFG_PATH=$HOME/Library/Rime
	RIME_APP="/Library/Input Methods/Squirrel.app"
else
	echo "Unsupported OS"
	exit 1
fi

if [[ $EUID -ne 0 ]]; then
	SUDO="sudo bash -c"
fi

HELP_MSG="
Usage: ${PROGRAM} [-uh] install Open Xiami configuration for RIME framework

Options
  -p, --purge     - [Warning] Remove folder $RIME_CFG_PATH
  -i, --install   - Install configuration files to $RIME_CFG_PATH
  -u, --uninstal  - Remove relative files under $RIME_CFG_PATH
  -h, --help      - This message
"

function log_copy()
{
	echo "(COPY) $@"
	cp -r "$@"
}

function log_remove()
{
	echo "(DEL) $@"
	rm -r "$@"
}

function log_move()
{
	echo "(MOVE) $@"
	mv "$@"
}

function log_link()
{
	echo "(LN) $@"
	ln "$@"
}

function install()
{
	for cfgfile in $REPO_PATH/Rime/{*.yaml,*.lua,opencc}; do
		log_copy $cfgfile $RIME_CFG_PATH
	done
}

function uninstall()
{
	for cfgfile in $REPO_PATH/Rime/{*.yaml,*.lua,opencc}; do
		log_remove $RIME_CFG_PATH/$(basename $cfgfile)
	done
}

function purge()
{
	log_remove $RIME_CFG_PATH
}

if [[ $# -eq 0 ]]
then
	echo "$HELP_MSG"
	exit 1
fi

while (( "$#" )); do
	case "$1" in
		-p|--purge)
			purge
			shift
			;;
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
			PARAMS="$PARAMS $1"
			shift
			;;
	esac
done
