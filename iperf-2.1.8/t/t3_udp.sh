#!/bin/bash -e
. $(dirname $0)/base.sh

# usage:
# run_iperf -s server args   -c client args
#
# client args should contain $ip or -V $ip6
# results returned in $results

run_iperf    \
    -s -P 1 -u -i 1 -t 3     \
    -c $ip -P 1 -u -b 10m -i 1 -t 2
