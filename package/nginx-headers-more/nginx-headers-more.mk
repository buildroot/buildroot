################################################################################
#
# nginx-headers-more
#
################################################################################

NGINX_HEADERS_MORE_VERSION = bea1be3
NGINX_HEADERS_MORE_SITE = $(call github,openresty,headers-more-nginx-module,$(NGINX_HEADERS_MORE_VERSION))
NGINX_HEADERS_MORE_LICENSE = BSD
NGINX_HEADERS_MORE_LICENSE_FILES = README.markdown

$(eval $(generic-package))
