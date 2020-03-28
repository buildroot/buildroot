#!/bin/sh

if [ "$#" -gt 1 ]; then
    echo "Usage: $0 [path]"
    echo "Run this script to relocate the buildroot SDK to the current location"
    echo "If [path] is given, sets the location to [path] (without moving it)"
    exit 1
fi

cd "$(dirname "$(readlink -f "$0")")"
if [ "$#" -eq 1 ]; then
    NEWPATH="$1"
else
    NEWPATH="${PWD}"
fi

LOCFILE="share/buildroot/sdk-location"
if [ ! -r "${LOCFILE}" ]; then
    echo "Previous location of the buildroot SDK not found!"
    exit 1
fi
OLDPATH="$(cat "${LOCFILE}")"

if [ "${NEWPATH}" = "${OLDPATH}" ]; then
    echo "This buildroot SDK has already been relocated!"
    exit 0
fi

# Check if the path substitution does work properly, e.g.  a tree
# "/a/b/c" copied into "/a/b/c/a/b/c/" would not be allowed.
newpath="$(sed -e "s|${OLDPATH}|${NEWPATH}|g" "${LOCFILE}")"
if [ "${NEWPATH}" != "${newpath}" ]; then
    echo "Something went wrong with substituting the path!"
    echo "Please choose another location for your SDK!"
    exit 1
fi

echo "Relocating the buildroot SDK from ${OLDPATH} to ${NEWPATH} ..."

# Make sure file uses the right language
export LC_ALL=C
# Replace the old path with the new one in all text files
grep -lr "${OLDPATH}" . | while read -r FILE ; do
    if file -b --mime-type "${FILE}" | grep -q '^text/' && [ "${FILE}" != "${LOCFILE}" ]
    then
        sed -i "s|${OLDPATH}|${NEWPATH}|g" "${FILE}"
    fi
done

# At the very end, we update the location file to not break the
# SDK if this script gets interruted.
sed -i "s|${OLDPATH}|${NEWPATH}|g" ${LOCFILE}
