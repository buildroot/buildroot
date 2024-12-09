################################################################################
#
# tcf-agent
#
################################################################################

TCF_AGENT_VERSION = 1.8.0
TCF_AGENT_SOURCE = org.eclipse.tcf.agent-$(TCF_AGENT_VERSION).tar.xz
TCF_AGENT_SITE = http://git.eclipse.org/c/tcf/org.eclipse.tcf.agent.git/snapshot
# see https://wiki.spdx.org/view/Legal_Team/License_List/Licenses_Under_Consideration
TCF_AGENT_LICENSE = BSD-3-Clause
TCF_AGENT_LICENSE_FILES = agent/edl-v10.html

TCF_AGENT_DEPENDENCIES = util-linux
TCF_AGENT_SUBDIR = agent

# there is not much purpose for the shared lib,
# it will not be used (unmodified) outside the tcf-agent application
TCF_AGENT_CONF_OPTS = \
	-DBUILD_SHARED_LIBS=OFF \
	-DTCF_MACHINE=$(call qstrip,$(BR2_PACKAGE_TCF_AGENT_ARCH))

# tcf-agent uses some arm instructions in case getauxval is not available.
# unfortunately the uClibc-ng implementation of getauxval uses some features
# of ld.so to work
ifeq ($(BR2_STATIC_LIBS)$(BR2_TOOLCHAIN_USES_UCLIBC)$(BR2_ARM_INSTRUCTIONS_THUMB),yyy)
TCF_AGENT_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -marm"
endif

define TCF_AGENT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/tcf-agent/tcf-agent.service \
		$(TARGET_DIR)/usr/lib/systemd/system/tcf-agent.service
endef

define TCF_AGENT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/tcf-agent/S55tcf-agent \
		$(TARGET_DIR)/etc/init.d/S55tcf-agent
endef

$(eval $(cmake-package))
