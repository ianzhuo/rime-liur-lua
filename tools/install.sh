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
  -l, --lua-librime - [required sudo] Swap precompiled librime with lua support at:
		 $RIME_APP/Contents/Frameworks/librime.1.dylib with a backup as
		 $RIME_APP/Contents/Frameworks/librime.1.old
  -i, --install     - Install configuration files to $RIME_CFG_PATH
  -u, --uninstall   - Remove relative files under $RIME_CFG_PATH
  -h, --help        - This message
"

function log_copy()
{
	echo "(COPY) $@"
	cp "$@"
}

function log_remove()
{
	echo "(DEL) $@"
	rm "$@"
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
	for cfgfile in $REPO_PATH/Rime/*.yaml; do
		log_copy $cfgfile $RIME_CFG_PATH
	done

	log_copy -r $REPO_PATH/Rime/opencc $RIME_CFG_PATH
}

function uninstall()
{
	for cfgfile in $REPO_PATH/Rime/*.yaml; do
		log_remove $RIME_CFG_PATH/$(basename $cfgfile)
	done

	log_remove -r $RIME_CFG_PATH/opencc
}

function replace_librime()
{
	echo "This function is not yet implemented"
}

if [[ $# -eq 0 ]]
then
	echo "$HELP_MSG"
	exit 1
fi

while (( "$#" )); do
	case "$1" in
		-l|--lua-library)
			replace_librime
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
