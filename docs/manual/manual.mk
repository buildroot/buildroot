################################################################################
#
# The Buildroot manual
#
################################################################################

MANUAL_SOURCES = $(sort $(wildcard docs/manual/*.adoc) $(wildcard docs/images/*))
MANUAL_RESOURCES = $(TOPDIR)/docs/images

define MANUAL_INIT_SCRIPT_REF
	cp package/busybox/S01syslogd $(@D)/S01syslogd
endef
MANUAL_POST_RSYNC_HOOKS += MANUAL_INIT_SCRIPT_REF

$(eval $(call asciidoc-document))
