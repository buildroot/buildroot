################################################################################
#
# The Buildroot manual
#
################################################################################

MANUAL_SOURCES = $(sort $(wildcard docs/manual/*.adoc) $(wildcard docs/images/*))
MANUAL_RESOURCES = $(TOPDIR)/docs/images

$(eval $(call asciidoc-document))
