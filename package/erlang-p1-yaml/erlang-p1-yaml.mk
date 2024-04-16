################################################################################
#
# erlang-p1-yaml
#
################################################################################

ERLANG_P1_YAML_VERSION = 1.0.36
ERLANG_P1_YAML_SITE = $(call github,processone,fast_yaml,$(ERLANG_P1_YAML_VERSION))
ERLANG_P1_YAML_LICENSE = Apache-2.0
ERLANG_P1_YAML_LICENSE_FILES = LICENSE.txt
ERLANG_P1_YAML_DEPENDENCIES = libyaml erlang-p1-utils

define ERLANG_P1_YAML_REMOVE_PATHS
	$(SED) "s/ -I\/usr\/local\/include//" $(@D)/rebar.config
	$(SED) "s/ -L\/usr\/local\/lib//" $(@D)/rebar.config
endef

ERLANG_P1_YAML_POST_PATCH_HOOKS = ERLANG_P1_YAML_REMOVE_PATHS

$(eval $(rebar-package))
