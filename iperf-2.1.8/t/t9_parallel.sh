#!/bin/bash -e
. $(dirname $0)/base.sh

# usage:
# run_iperf -s server args   -c client args
#
# client args should contain $ip or -V $ip6
# results returned in $results

run_iperf    \
    -s --parallel 4 -i 1 -t 3     \
    -c $ip -P 4 -i 1 -t 2
