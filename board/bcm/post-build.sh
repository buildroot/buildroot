#!/bin/bash
set -u
set -e

echo "Post-build: processing $@"

KEYMAP=""

for i in "$@"
do
case $i in
    -k=*|--keymap=*) #  --keymap=ir-remote:advancetv.json
    KEYMAP="${KEYMAP} ${i#*=}"
    shift # past argument=value
    ;;
    #-s=*|--searchpath=*)
    #SEARCHPATH="${i#*=}"
    #shift # past argument=value
    #;;
    *) # unknown option
    ;;
esac
done

BOARD_DIR="$(dirname $0)"

# Copy index.html page for WPE Framework
if [ -f "${BOARD_DIR}/index.html" ]; then
	mkdir -p "${TARGET_DIR}/www/"
	cp -pf "${BOARD_DIR}/index.html" "${TARGET_DIR}/www/"
fi

# copy keymaps multiple --keymap arguments can be given. 
for k in ${KEYMAP}
do
source=$(echo $k | cut -f2 -d:)
destination=$(echo $k | cut -f1 -d:).json
if [ -f "${BOARD_DIR}/${source}" ]; then
    echo "Add keymap ${source} as ${destination}"
	mkdir -p "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl"
	cp -pf "${BOARD_DIR}/${source}" "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl/${destination}"
fi
done
