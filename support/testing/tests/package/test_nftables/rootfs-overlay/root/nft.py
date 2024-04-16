#! /usr/bin/env python3
#
# This is a simple reimplementation of the "nft" user-space tool in
# Python, in order to test language bindings. It does not support any
# command line argument supported by the nftables "nft" tool, but
# supports all nftables commands used in the Buildroot runtime test.

import sys

import nftables


nft = nftables.nftables.Nftables()
cmd = " ".join(sys.argv[1:])
ret_code, output, error = nft.cmd(cmd)

if len(output) > 0:
    print(output.strip())
if len(error) > 0:
    print(error.strip())

sys.exit(ret_code)
