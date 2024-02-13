################################################################################
#
# tio
#
################################################################################

TIO_VERSION = 2.7
TIO_SOURCE = tio-$(TIO_VERSION).tar.xz
TIO_SITE = https://github.com/tio/tio/releases/download/v$(TIO_VERSION)
TIO_LICENSE = GPL-2.0+
TIO_LICENSE_FILES = LICENSE
TIO_DEPENDENCIES = inih

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
TIO_CONF_OPTS +=-Dbashcompletiondir=/usr/share/bash-completion/completions
else
TIO_CONF_OPTS +=-Dbashcompletiondir=no
endif

$(eval $(meson-package))
