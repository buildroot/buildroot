################################################################################
#
# nginx-naxsi
#
################################################################################

NGINX_NAXSI_VERSION = d714f1636ea49a9a9f4f06dba14aee003e970834
NGINX_NAXSI_SITE = $(call github,nbs-system,naxsi,$(NGINX_NAXSI_VERSION))
NGINX_NAXSI_LICENSE = GPL-3.0, BSD-3-Clause (libinjection)
NGINX_NAXSI_LICENSE_FILES = LICENSE naxsi_src/ext/libinjection/COPYING

$(eval $(generic-package))
