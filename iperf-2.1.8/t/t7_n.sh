#!/bin/bash -e
. $(dirname $0)/base.sh

# usage:
# run_iperf -s server args   -c client args
#
# client args should contain $ip or -V $ip6
# results returned in $results

run_iperf    \
    -s -P 1 -i 1 -t 8     \
    -c $ip -P 1 -i 1 -n 1G
