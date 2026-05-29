#!/bin/sh

# prevent shift error
[ $# -lt 2 ] && exit 1

major_min="${1%.*}"
minor_min="${1#*.}"

# When running 'make show-info-all' or pkg-stats, it is possible to trigger this
# script without passing a version number. These cases are special because they
# force the reading of all packages without requiring a .config, so
# BR2_HOST_CMAKE_AT_LEAST is unset and the script is called as:
#   check-host-cmake.sh cmake cmake3
# Without validation, the integer comparisons below would produce errors like:
#   check-host-cmake.sh: line 37: [: cmake: integer expected
# The following lines checks we have a single digit number from $1 before
# continuing the script.
[ "${major_min}" -eq "${major_min}" ] 2>/dev/null || exit 1
[ "${minor_min}" -eq "${minor_min}" ] 2>/dev/null || exit 1

shift

for candidate; do

    # Try to locate the candidate. Discard it if not located.
    cmake=`which "${candidate}" 2>/dev/null`
    [ -n "${cmake}" ] || continue

    # Extract version X.Y from versions in the form X.Y or X.Y.Z
    # with X, Y and Z numbers with one or more digits each, e.g.
    #   3.2     -> 3.2
    #   3.2.3   -> 3.2
    #   3.2.42  -> 3.2
    #   3.10    -> 3.10
    #   3.10.4  -> 3.10
    #   3.10.42 -> 3.10
    # Discard the candidate if no version can be obtained
    version="$(${cmake} --version \
               |sed -r -e '/.* ([[:digit:]]+\.[[:digit:]]+).*$/!d;' \
                       -e 's//\1/'
              )"
    [ -n "${version}" ] || continue

    major="${version%.*}"
    minor="${version#*.}"

    if [ ${major} -gt ${major_min} ]; then
        echo "${cmake}"
        exit
    elif [ ${major} -eq ${major_min} -a ${minor} -ge ${minor_min} ]; then
        echo "${cmake}"
        exit
    fi
done

# echo nothing: no suitable cmake found
exit 1
