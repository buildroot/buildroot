#!/usr/bin/env bash
#
# Check if a given custom skeleton or overlay complies to the merged /usr
# requirements:
# /
# /bin -> usr/bin
# /lib -> usr/lib
# /sbin -> usr/sbin
# /usr/bin/
# /usr/lib/
# /usr/sbin/
#
# Input:
#   $1:     the root directory (skeleton, overlay) to check
# Output:
#   stdout: the list of non-compliant paths (empty if compliant).
#

# The directory to check for merged-usr
root="${1}"

# Extract the inode numbers for all of those directories. In case any is
# a symlink, we want to get the inode of the pointed-to directory, so we
# append '/.' to be sure we get the target directory. Since the symlinks
# can be anyway (/bin -> /usr/bin or /usr/bin -> /bin), we do that for
# each of them.
#

is_valid_merged() {
	local root="${1}"
	local dir1="${2}"
	local dir2="${3}"
	local inode1 inode2

	inode1="$(stat -c '%i' "${root}${dir1}/." 2>/dev/null)"
	inode2="$(stat -c '%i' "${root}${dir2}/." 2>/dev/null)"

	test -z "${inode1}" || test "${inode1}" = "${inode2}"
}

test_merged() {
	local root="${1}"
	local dir1="${2}"
	local dir2="${3}"

	if ! is_valid_merged "${root}" "${dir1}" "${dir2}"; then
		printf '%s\n' "${dir1}"
	fi
}

test_merged "${root}" "/lib" "/usr/lib"
test_merged "${root}" "/bin" "/usr/bin"
test_merged "${root}" "/sbin" "/usr/sbin"
