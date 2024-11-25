################################################################################
#
# iana-assignments
#
################################################################################

IANA_ASSIGNMENTS_VERSION = bf358dc8d89b7939557220b8055699b42a4133e9
IANA_ASSIGNMENTS_SITE = $(call github,larseggert,iana-assignments,$(IANA_ASSIGNMENTS_VERSION))

# The licensing is defined by IANA: https://www.iana.org/help/licensing-terms
# The repository we use is not a real upstream, and contains no license file.
IANA_ASSIGNMENTS_LICENSE = CC0-1.0

ifeq ($(BR2_PACKAGE_IANA_ASSIGNMENTS_PEN_REG),y)
define IANA_ASSIGNMENTS_INSTALL_PEN_REG
	$(INSTALL) -D -m 0644 $(@D)/enterprise-numbers/enterprise-numbers \
		$(TARGET_DIR)/usr/share/misc/iana/enterprise-numbers
endef
IANA_ASSIGNMENTS_POST_INSTALL_TARGET_HOOKS += IANA_ASSIGNMENTS_INSTALL_PEN_REG
endif

$(eval $(generic-package))
