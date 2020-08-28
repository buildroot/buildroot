#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

if [ -d /sys/kernel/mm/hugepages/hugepages-2048kB ] ; then
	echo 4 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

	mkdir /var/huge
	mount none -t hugetlbfs -o uid=1000,gid=100 /var/huge
fi

if [ -d /sys/kernel/mm/transparent_hugepage ] ; then
	echo always > /sys/kernel/mm/transparent_hugepage/enabled
	echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
fi
