################################################################################
#
# libfuzzer
#
################################################################################

LIBFUZZER_VERSION = cec02db916d21baa4db5b8d262d78848b3a35f4b
LIBFUZZER_SITE = $(call github,google,fuzzing,$(LIBFUZZER_VERSION))
LIBFUZZER_LICENSE = Apache-2.0
LIBFUZZER_LICENSE_FILES = LICENSE
LIBFUZZER_DEPENDENCIES = compiler-rt

define LIBFUZZER_BUILD_CMDS
	$(HOST_DIR)/bin/clang++ --sysroot=$(STAGING_DIR) \
		-fsanitize=address,fuzzer \
		$(@D)/tutorial/libFuzzer/fuzz_me.cc \
		-o $(@D)/fuzz_me
endef

define LIBFUZZER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/fuzz_me $(TARGET_DIR)/usr/bin/fuzz_me
endef

$(eval $(generic-package))
