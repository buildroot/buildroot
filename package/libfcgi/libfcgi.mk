################################################################################
#
# libfcgi
#
################################################################################

LIBFCGI_VERSION = 2.4.5
LIBFCGI_SITE = $(call github,FastCGI-Archives,fcgi2,$(LIBFCGI_VERSION))
LIBFCGI_LICENSE = OML
LIBFCGI_LICENSE_FILES = LICENSE
LIBFCGI_CPE_ID_VENDOR = fastcgi
LIBFCGI_CPE_ID_PRODUCT = fcgi
LIBFCGI_INSTALL_STAGING = YES
LIBFCGI_AUTORECONF = YES
LIBFCGI_CONF_OPTS = --disable-examples

$(eval $(autotools-package))
