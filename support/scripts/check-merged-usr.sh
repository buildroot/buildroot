#!/usr/bin/env bash
#
# Check if a given custom skeleton or overlay complies to the merged /usr
# requirements:
#   /bin            missing, or a relative symlink to usr/bin
#   /lib            missing, or a relative symlink to usr/lib
#   /sbin           missing, or a relative symlink to usr/sbin
#   /usr/bin/       missing*, or an existing directory; not a symlink
#   /usr/lib/       missing*, or an existing directory; not a symlink
#   /usr/sbin/      missing*, or an existing directory; not a symlink
#
# *: must be present for skeletons, can be missing for overlays
#
# Input:
#   --type TYPE     the type of root to check: 'skeleton' or 'overlay'
#   $*:             the root directories (skeleton, overlays) to check
# Output:
#   stdout:         the list of non-compliant paths (empty if compliant).
# Exit code:
#   0:              in case of success (stdout will be empty)
#   !0:             if any directory to check is improperly merged
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

if [ "${type}" = "skeleton" ]; then
	strict=true
else
	strict=false
fi

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

test_merged() {
	local type="${1}"
	local root="${2}"
	local base="${3}"
	local dir1="${4}"
	local dir2="${5}"

	if ! test -e "${root}${base}${dir1}"; then
		return 0
	elif [ "$(readlink "${root}${base}${dir1}")" = "${dir2}" ]; then
		return 0
	fi

	# Otherwise, this directory is not merged
	report_error "${type}" "${root}" \
		'%s%s should be missing, or be a relative symlink to %s\n' \
		"${base}" "${dir1}" "${dir2}"
}

test_dir() {
	local type="${1}"
	local root="${2}"
	local base="${3}"
	local dir="${4}"

	if ! test -e "${root}${base}${dir}" && ! ${strict}; then
		return 0
	elif test -d "${root}${base}${dir}" && ! test -L "${root}${base}${dir}"; then
		return 0
	fi

	# Otherwise, this entry is not a proper directory
	report_error "${type}" "${root}" \
		"%s%s should exist, be a directory, and not be a symlink\n" \
		"${base}" "${dir}"
}

is_success=true
for root; do
	first=true
	test_dir "${type}" "${root}" "/" "usr/bin"
	test_dir "${type}" "${root}" "/" "usr/lib"
	test_dir "${type}" "${root}" "/" "usr/sbin"
	test_merged "${type}" "${root}" "/" "bin" "usr/bin"
	test_merged "${type}" "${root}" "/" "lib" "usr/lib"
	test_merged "${type}" "${root}" "/" "sbin" "usr/sbin"
done

${is_success}
