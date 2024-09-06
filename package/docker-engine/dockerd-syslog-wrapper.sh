#!/bin/sh
"${@}" 2>&1 | while read -r LINE; do
	logger -t "$(basename "${1}")" "$LINE";
done
