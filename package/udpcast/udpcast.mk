################################################################################
#
# udpcast
#
################################################################################

UDPCAST_VERSION = 20230924
UDPCAST_SITE = http://www.udpcast.linux.lu/download
UDPCAST_DEPENDENCIES = host-m4
UDPCAST_LICENSE = BSD-2-Clause, GPL-2.0+
UDPCAST_LICENSE_FILES = COPYING
UDPCAST_TARGETS = \
	$(if $(BR2_PACKAGE_UDPCAST_RECEIVER),udp-receiver) \
	$(if $(BR2_PACKAGE_UDPCAST_SENDER),udp-sender)
UDPCAST_MAKE_OPTS = $(UDPCAST_TARGETS)

define UDPCAST_INSTALL_TARGET_CMDS
	$(foreach f,$(UDPCAST_TARGETS),\
		$(INSTALL) -D -m 755 $(@D)/$(f) $(TARGET_DIR)/usr/sbin/$(f)
	)
endef

$(eval $(autotools-package))
