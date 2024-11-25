################################################################################
#
# python-annotated-types
#
################################################################################

PYTHON_ANNOTATED_TYPES_VERSION = 0.7.0
PYTHON_ANNOTATED_TYPES_SOURCE = annotated_types-$(PYTHON_ANNOTATED_TYPES_VERSION).tar.gz
PYTHON_ANNOTATED_TYPES_SITE = https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5
PYTHON_ANNOTATED_TYPES_SETUP_TYPE = hatch
PYTHON_ANNOTATED_TYPES_LICENSE = MIT
PYTHON_ANNOTATED_TYPES_LICENSE_FILES = LICENSE

$(eval $(python-package))
