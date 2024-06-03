################################################################################
#
# libnetfilter_log
#
################################################################################

LIBNETFILTER_LOG_VERSION = 1.0.2
LIBNETFILTER_LOG_SOURCE = libnetfilter_log-$(LIBNETFILTER_LOG_VERSION).tar.bz2
LIBNETFILTER_LOG_SITE = https://www.netfilter.org/projects/libnetfilter_log/files
LIBNETFILTER_LOG_INSTALL_STAGING = YES
LIBNETFILTER_LOG_DEPENDENCIES = host-pkgconf libmnl libnfnetlink
LIBNETFILTER_LOG_LICENSE = GPL-2.0+
LIBNETFILTER_LOG_LICENSE_FILES = COPYING

$(eval $(autotools-package))
