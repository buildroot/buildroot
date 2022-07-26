#! /usr/bin/env python3

import sys

from ola.ClientWrapper import ClientWrapper


def show_uids(state, uids):
    if state.Succeeded():
        for uid in uids:
            print(str(uid))
    else:
        print('Error: %s' % state.message, file=sys.stderr)
    wrapper.Stop()


wrapper = ClientWrapper()
client = wrapper.Client()
universe = 0
full_discovery = True

client.RunRDMDiscovery(universe, full_discovery, show_uids)

wrapper.Run()
