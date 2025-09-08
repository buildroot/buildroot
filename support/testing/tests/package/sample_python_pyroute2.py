from pyroute2 import IPRoute


def test_ipr():
    with IPRoute() as ipr:
        lo = ipr.link('get', ifname='lo')[0]
        a = [
            dict(a['attrs'])['IFA_ADDRESS']
            for a in ipr.get_addr(index=lo['index'])
        ]
    print(repr(a))
    assert '127.0.0.1' in a


if __name__ == '__main__':
    test_ipr()
