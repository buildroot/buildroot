################################################################################
#
# pcm-tools
#
################################################################################

# Don't use the github helper, as pcm-tools uses git attributes that are
# replaced when gnerating the archive.
# 93fc9193a70e2f1f054be554c48f4a4791be5032 is the hash of the 202110 tag.
PCM_TOOLS_VERSION = 93fc9193a70e2f1f054be554c48f4a4791be5032
PCM_TOOLS_SITE = https://github.com/opcm/pcm
PCM_TOOLS_SITE_METHOD = git
PCM_TOOLS_LICENSE = BSD-3-Clause
PCM_TOOLS_LICENSE_FILES = LICENSE

PCM_TOOLS_EXE_FILES = \
	pcm-core pcm-iio pcm-lspci pcm-memory pcm-msr pcm-numa \
	pcm-pcicfg pcm-pcie pcm-power pcm-sensor pcm-tsx pcm

# version.h contains git attributes; replace them with the previously-known
# value.
define PCM_TOOLS_FIXUP_VERSION_H
	$(SED) 's/\$$Format:%ci ID=%h\$$/2021-10-25 16:07:54 +0200 ID=93fc9193/' \
		$(@D)/version.h
endef
PCM_TOOLS_POST_EXTRACT_HOOKS += PCM_TOOLS_FIXUP_VERSION_H

define PCM_TOOLS_BUILD_CMDS
	touch $(@D)/daemon-binaries
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) \
		CXXFLAGS="$(TARGET_CXXFLAGS) -std=c++11 -fPIC" \
		UNAME=Linux HOST=_LINUX \
		$(foreach f,$(PCM_TOOLS_EXE_FILES),$(f).x)
endef

ifeq ($(BR2_PACKAGE_PCM_TOOLS_PMU_QUERY),y)
define PCM_TOOLS_INSTALL_PMU_QUERY
	$(INSTALL) -D -m 755 $(@D)/pmu-query.py $(TARGET_DIR)/usr/bin/pmu-query
endef
endif

define PCM_TOOLS_INSTALL_TARGET_CMDS
	$(foreach f,$(PCM_TOOLS_EXE_FILES),\
		$(INSTALL) -D -m 755 $(@D)/$(f).x $(TARGET_DIR)/usr/bin/$(f)
	)
	$(PCM_TOOLS_INSTALL_PMU_QUERY)
endef

define PCM_TOOLS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_X86_MSR)
endef

$(eval $(generic-package))
