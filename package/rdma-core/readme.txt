Testing rdma-core userspace tools
=================================

Testing rdma-core using Linux software RoCE implementation:
https://en.wikipedia.org/wiki/RDMA_over_Converged_Ethernet

Using two systems with working TCP/IP configuration, for example:
- Server IP: 192.168.123.10
- Client IP: 192.168.123.20

Make sure firewall configurations are appropriate. Routable RoCE v2
uses udp/4791. ibv_rc_pingpong uses tcp/18515 for initial
synchronization.

Note: this test can be executed in two qemu virtual machines with
bridged networking.


Kernel configuration
--------------------

The Linux Kernel needs some InfiniBand configuration. In this example
the kernel "rdma_rxe" driver is needed (CONFIG_RDMA_RXE=y). The Kernel
config fragment file used for package test can be used as a starting
point. See:

    support/testing/tests/package/test_rdma_core/linux-rdma.fragment


Buildroot package configuration
-------------------------------

For setting up a software RoCE link, the "rdma" program is needed. It
is provided by the "iproute2" package, when "libmnl" is also
selected. Make sure to have in your Buildroot configuration:

    BR2_PACKAGE_IPROUTE2=y
    BR2_PACKAGE_LIBMNL=y
    BR2_PACKAGE_RDMA_CORE=y


Setting up the rdma link
------------------------

On both server and client:

    modprobe rdma_rxe
    rdma link add rxe0 type rxe netdev eth0


Testing with rping
------------------

On the server side, run the command:

    rping -s -v

On the client side, run the command:

    rping -c -v -a 192.168.123.10


Testing with ibv_rc_pingpong
----------------------------

To test with the pingpong example using the reliable connected (RC)
transport:

On the server side, run the command:

    ibv_rc_pingpong -d rxe0 -g 1

On the client side, run the command:

    ibv_rc_pingpong -d rxe0 -g 1 192.168.123.10
