#!/bin/sh -x

# genimage will need to find the extlinux.conf
# in the binaries directory

die() {
  cat <<EOF >&2
Error: $@

Usage: ${0} -c <console> -r <root> [-x <extra-args>]
EOF
  exit 1
}

o='c:d:l:r:x:'
O='console:,devicetree:,label:,root:,extra-args:'
opts="$(getopt -n "${0##*/}" -o "${o}" -l "${O}" -- "${@}")"
eval set -- "${opts}"
while [ ${#} -gt 0 ]; do
    case "${1}" in
    (-c|--console)
        CONSOLE="${2}"; shift 2
        ;;
    (-d|--devicetree)
        DEVICETREE="${2}"; shift 2
        ;;
    (-l|--label)
        LABEL="${2}"; shift 2
        ;;
    (-r|--root)
        ROOT="${2}"; shift 2
        ;;
    (-x|--extra-args)
        EXTRA_ARGS="${2}"; shift 2
        ;;
    (--)
        shift 1; break
        ;;
    esac
done

[ -n "${CONSOLE}" ] || die "Missing \`console' argument"
[ -n "${DEVICETREE}" ] || die "Missing \`devicetree' argument"
[ -n "${LABEL}" ] || die "Missing \`label' argument"
[ -n "${ROOT}" ] || die "Missing \`root' argument"
append="console=${CONSOLE} root=${ROOT} rw rootfstype=ext4 rootwait"
if [ -n "${EXTRA_ARGS}" ]; then
    append="${append} ${EXTRA_ARGS}"
fi

mkdir -p "${BINARIES_DIR}"
cat <<-__HEADER_EOF > "${BINARIES_DIR}/extlinux.conf"
	label ${LABEL}
	  kernel /Image
	  fdtdir /
	  devicetree /${DEVICETREE}
	  append ${append}
	__HEADER_EOF
