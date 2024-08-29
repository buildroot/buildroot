################################################################################
#
# erlang-stun
#
################################################################################

ERLANG_STUN_VERSION = 1.2.14
ERLANG_STUN_SITE = $(call github,processone,stun,$(ERLANG_STUN_VERSION))
ERLANG_STUN_LICENSE = Apache-2.0
ERLANG_STUN_LICENSE_FILES = LICENSE.txt
ERLANG_STUN_DEPENDENCIES = erlang-p1-tls erlang-p1-utils
ERLANG_STUN_INSTALL_STAGING = YES

$(eval $(rebar-package))
