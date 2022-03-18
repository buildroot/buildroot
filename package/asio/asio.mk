################################################################################
#
# asio
#
################################################################################

ASIO_VERSION = 1.10.6
ASIO_SOURCE = asio-$(ASIO_VERSION).tar.gz
ASIO_SITE = https://sourceforge.net/projects/asio/files/asio/$(ASIO_VERSION)%20%28Stable%29
ASIO_LICENSE = Boost Software License
ASIO_LICENSE_FILES = LICENSE.txt
ASIO_INSTALL_TARGET = NO
ASIO_INSTALL_STAGING = YES

# version < 1.12.0 requires additional flag disabling BOOST
ASIO_CONF_OPTS += --without-boost

$(eval $(autotools-package))
