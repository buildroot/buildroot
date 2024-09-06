################################################################################
#
# erlang-fast-yaml
#
################################################################################

ERLANG_FAST_YAML_VERSION = 1.0.37
ERLANG_FAST_YAML_SITE = $(call github,processone,fast_yaml,$(ERLANG_FAST_YAML_VERSION))
ERLANG_FAST_YAML_LICENSE = Apache-2.0
ERLANG_FAST_YAML_LICENSE_FILES = LICENSE.txt
ERLANG_FAST_YAML_DEPENDENCIES = libyaml erlang-p1-utils

define ERLANG_FAST_YAML_REMOVE_PATHS
	$(SED) "s/ -I\/usr\/local\/include//" $(@D)/rebar.config
	$(SED) "s/ -L\/usr\/local\/lib//" $(@D)/rebar.config
endef

ERLANG_FAST_YAML_POST_PATCH_HOOKS = ERLANG_FAST_YAML_REMOVE_PATHS

$(eval $(rebar-package))
