#! /usr/bin/env micropython

import gzip
import sys


def main(fname):
    with open(fname, "rb") as f:
        with gzip.GzipFile(fileobj=f) as g:
            s = g.read()
            print(s.decode("UTF-8"), end="")


if __name__ == "__main__":
    main(sys.argv[1])
