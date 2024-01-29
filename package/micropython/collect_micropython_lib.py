#!/usr/bin/env python3

"""
Sometime after v1.9.3, micropython-lib's directory structure was cleaned up and
enhanced with manifest files.

Though cleaner, it means it cannot be directly copied into the target.
This script is during build process to perform that conversion.

It makes use of manifestfile.py, which is normally located in micropython's
tool directory.

It also depends on the micropython-lib that is cloned in lib/micropython-lib
during build.
"""

import argparse
import manifestfile
import os
import shutil


def get_library_name_type(manifest_path: str) -> tuple[str, bool]:
    split = manifest_path.split("/")
    return (split[-2], "unix-ffi" in split)  # -1: "manifest.py", -2: library name


def get_all_libraries(mpy_lib_dir: str):
    # reuse manifestfile module capabilities to scan the micropython-lib directory

    collected_list = manifestfile.ManifestFile(
        manifestfile.MODE_FREEZE, {"MPY_LIB_DIR": mpy_lib_dir}
    )
    collected_list.freeze(mpy_lib_dir)

    for file in collected_list.files():
        if file.target_path.endswith("manifest.py"):
            yield get_library_name_type(file.full_path)


def copy_file(src: str, target: str, destination: str):
    s = target.split("/")
    s.pop()
    d = f"{destination}/{'/'.join(s)}"
    os.makedirs(d, exist_ok=True)
    shutil.copy(src, f"{destination}/{target}")


def copy_libraries(manifest, destination: str):
    for f in manifest.files():
        copy_file(f.full_path, f.target_path, destination)


def process_cmdline_args():
    parser = argparse.ArgumentParser(
        description="Prepare micropython-lib to be installed"
    )
    parser.add_argument("micropython", help="Path to micropython source directory")
    parser.add_argument("destination", help="Destination directory")

    args = parser.parse_args()
    return os.path.abspath(args.micropython), os.path.abspath(args.destination)


def main():
    micropython_dir, destination_dir = process_cmdline_args()
    mpy_lib_dir = f"{micropython_dir}/lib/micropython-lib"

    manifest = manifestfile.ManifestFile(
        manifestfile.MODE_FREEZE, {"MPY_LIB_DIR": mpy_lib_dir}
    )

    for library, is_ffi in get_all_libraries(mpy_lib_dir):
        manifest.require(library, unix_ffi=is_ffi)

    copy_libraries(manifest, destination_dir)


main()
