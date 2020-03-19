#!/bin/bash

REPO_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") && cd .. && pwd -P)
PROGRAM=$(basename "${BASH_SOURCE[0]}")
PARAMS=

if [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
	# TODO: Implement for Ubuntu environment
	echo "Not yet implemented for Ubuntu"
	exit 1

elif [[ "$OSTYPE" =~ ^darwin ]]; then
	RIME_CFG_PATH=$HOME/Library/Rime
	RIME_BIN="/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel"
	INSTALL_CMD="brew cask install squirrel"
	OS="darwin"

else
	echo "Unsupported OS"
	exit 1

fi

HELP_MSG="
Usage: ${PROGRAM} [-uh] install Open Xiami configuration for RIME framework

Options
  -c, --clean     - Remove Build folder in $RIME_CFG_PATH
  -i, --install   - Install configuration files to $RIME_CFG_PATH
  -u, --uninstal  - Remove relative files under $RIME_CFG_PATH
  -h, --help      - This message
"

if [[ ! -f "$REPO_PATH/plum/rime-install" ]]; then
	echo "(GIT) [submodule] plum"
	git submodule init
	git submodule update
fi

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

function rime_install()
{
	"$REPO_PATH/plum/rime-install" $PARAMS
}

function install()
{
	if [[ ! -f "$RIME_BIN" ]]; then
		echo "(INSTALL) [homebrew-cask] Squirrel"
		$INSTALL_CMD
	fi

	echo "(INSTALL) dependencies"
	"$REPO_PATH/plum/rime-install" luna-pinyin terra-pinyin bopomofo

	for cfgfile in "$REPO_PATH/src/"{*.yaml,*.lua,opencc}; do
		log_copy $cfgfile "$RIME_CFG_PATH"
	done
}

function uninstall()
{
	for cfgfile in "$REPO_PATH/src/"{*.yaml,*.lua,opencc}; do
		log_remove "$RIME_CFG_PATH/$(basename $cfgfile)"
	done
}

function clean()
{
	log_remove "$RIME_CFG_PATH/build"
}

if [[ $# -eq 0 ]]
then
	echo "$HELP_MSG"
	exit 1
fi

while (( "$#" )); do
	case "$1" in
		-c|--clean)
			clean
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
