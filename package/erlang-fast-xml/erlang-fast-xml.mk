################################################################################
#
# erlang-fast-xml
#
################################################################################

ERLANG_FAST_XML_VERSION = 1.1.52
ERLANG_FAST_XML_SITE = $(call github,processone,fast_xml,$(ERLANG_FAST_XML_VERSION))
ERLANG_FAST_XML_LICENSE = Apache-2.0
ERLANG_FAST_XML_LICENSE_FILES = LICENSE.txt
ERLANG_FAST_XML_DEPENDENCIES = expat erlang-p1-utils
HOST_ERLANG_FAST_XML_DEPENDENCIES = host-expat host-erlang-p1-utils
ERLANG_FAST_XML_INSTALL_STAGING = YES

ERLANG_FAST_XML_USE_AUTOCONF = YES

$(eval $(rebar-package))
$(eval $(host-rebar-package))
