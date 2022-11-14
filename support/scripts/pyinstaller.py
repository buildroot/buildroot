#!/usr/bin/env python3

import argparse
import glob
import pathlib

from importlib.machinery import PathFinder
from importlib.metadata import DistributionFinder

from installer import install
from installer._core import _process_WHEEL_file
from installer.destinations import SchemeDictionaryDestination
from installer.sources import WheelFile


def clean(source, destination):
    scheme = _process_WHEEL_file(source)
    scheme_path = destination.scheme_dict[scheme]
    context = DistributionFinder.Context(
        name=source.distribution,
        path=[scheme_path],
    )
    for path in PathFinder.find_distributions(context=context):
        # path.files is either an iterable, or None
        if path.files is None:
            continue
        for file in path.files:
            file_path = pathlib.Path(file.locate())
            if file_path.exists():
                file_path.unlink()


def main():
    """Entry point for CLI."""
    ap = argparse.ArgumentParser("python pyinstaller.py")
    ap.add_argument("wheel_file", help="Path to a .whl file to install")

    ap.add_argument(
        "--interpreter", required=True, help="Interpreter path to be used in scripts"
    )
    ap.add_argument(
        "--script-kind",
        required=True,
        choices=["posix", "win-ia32", "win-amd64", "win-arm", "win-arm64"],
        help="Kind of launcher to create for each script",
    )

    dest_args = ap.add_argument_group("Destination directories")
    dest_args.add_argument(
        "--purelib",
        required=True,
        help="Directory for platform-independent Python modules",
    )
    dest_args.add_argument(
        "--platlib",
        help="Directory for platform-dependent Python modules (same as purelib "
        "if not specified)",
    )
    dest_args.add_argument(
        "--headers", required=True, help="Directory for C header files"
    )
    dest_args.add_argument(
        "--scripts", required=True, help="Directory for executable scripts"
    )
    dest_args.add_argument(
        "--data", required=True, help="Directory for external data files"
    )
    args = ap.parse_args()

    destination = SchemeDictionaryDestination(
        {
            "purelib": args.purelib,
            "platlib": args.platlib if args.platlib is not None else args.purelib,
            "headers": args.headers,
            "scripts": args.scripts,
            "data": args.data,
        },
        interpreter=args.interpreter,
        script_kind=args.script_kind,
    )

    with WheelFile.open(glob.glob(args.wheel_file)[0]) as source:
        clean(source, destination)
        install(
            source=source,
            destination=destination,
            additional_metadata={},
        )


if __name__ == "__main__":
    main()
