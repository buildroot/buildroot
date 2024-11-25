################################################################################
#
# erlang-xmpp
#
################################################################################

ERLANG_XMPP_VERSION = 1.8.3
ERLANG_XMPP_SITE = $(call github,processone,xmpp,$(ERLANG_XMPP_VERSION))
ERLANG_XMPP_LICENSE = Apache-2.0
ERLANG_XMPP_LICENSE_FILES = LICENSE.txt
ERLANG_XMPP_INSTALL_STAGING = YES
ERLANG_XMPP_DEPENDENCIES = erlang-fast-xml erlang-p1-stringprep \
	erlang-p1-tls erlang-p1-utils erlang-p1-zlib host-erlang-fast-xml
HOST_ERLANG_XMPP_DEPENDENCIES = host-erlang-fast-xml

$(eval $(rebar-package))
$(eval $(host-rebar-package))
