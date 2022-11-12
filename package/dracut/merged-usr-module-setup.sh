#!/bin/bash

check() {
    [ -L "${dracutsysrootdir?}/lib" ]
}

depends() {
    return 0
}

install() {
    # dracut pre-installs a set of files before calling any of
    # the modules, and dracut also messes up host vs. target
    # system, so on a non-merged-usr host, it will prepare a
    # non-merged-usr initramfs, even though the current config
    # is for a merged-usr system.
    # So undo its borkage.
    for dir in lib bin sbin; do
        mkdir -p "${initdir?}/usr/${dir}"
        if [ -d "${initdir?}/${dir}" ]; then
            mv "${initdir?}/${dir}/"* "${initdir?}/usr/${dir}"
            rm -rf "${initdir?}/${dir}"
            ln -s "usr/${dir}" "${initdir?}/${dir}"
        fi
    done
}
