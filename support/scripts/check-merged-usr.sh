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
#   --type TYPE     the type of root to check: 'skeleton' or 'overlay'
#   $*:             the root directories (skeleton, overlays) to check
# Output:
#   stdout:         the list of non-compliant paths (empty if compliant).
# Exit code:
#   0:              in case of success (stdout will be empty)
#   !0:             if any path is improperly merged
#

opts="type:"
ARGS="$(getopt -n check-merged -o "" -l "${opts}" -- "${@}")" || exit 1
eval set -- "${ARGS}"

type=
while :; do
	case "${1}" in
	(--type)
		type="${2}"
		shift 2
		;;
	(--)
		shift
		break
		;;
	esac
done

report_error() {
	local type="${1}"
	local root="${2}"
	local fmt="${3}"
	shift 3

	if ${first}; then
		printf "The %s in %s is not properly setup:\n" \
			"${type}" "${root}"
	fi
	first=false
	# shellcheck disable=SC2059  # fmt *is* a format string
	printf "  - ${fmt}" "${@}"
	is_success=false
}

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
	local type="${1}"
	local root="${2}"
	local dir1="${3}"
	local dir2="${4}"

	if ! is_valid_merged "${root}" "${dir1}" "${dir2}"; then
		report_error "${type}" "${root}" \
			'%s should be missing, or be a relative symlink to %s\n' \
			"${dir1}" "${dir2}"
	fi
}

is_success=true
for root; do
	first=true
	test_merged "${type}" "${root}" "/lib" "/usr/lib"
	test_merged "${type}" "${root}" "/bin" "/usr/bin"
	test_merged "${type}" "${root}" "/sbin" "/usr/sbin"
done

${is_success}
