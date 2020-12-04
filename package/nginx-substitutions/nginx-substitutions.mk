################################################################################
#
# nginx-substitutions
#
################################################################################

NGINX_SUBSTITUTIONS_VERSION = b8a71ea
NGINX_SUBSTITUTIONS_SITE = $(call github,yaoweibin,ngx_http_substitutions_filter_module,$(NGINX_SUBSTITUTIONS_VERSION))
NGINX_SUBSTITUTIONS_LICENSE = BSD-3-Clause
NGINX_SUBSTITUTIONS_LICENSE_FILES = README

$(eval $(generic-package))
