################################################################################
#
# python-annotated-types
#
################################################################################

PYTHON_ANNOTATED_TYPES_VERSION = 0.8.0
PYTHON_ANNOTATED_TYPES_SOURCE = annotated_types-$(PYTHON_ANNOTATED_TYPES_VERSION).tar.gz
PYTHON_ANNOTATED_TYPES_SITE = https://files.pythonhosted.org/packages/5f/56/a8120250d128bed162cd73c76d45f6ef9991f3e068f62a8ee060afa3104a
PYTHON_ANNOTATED_TYPES_SETUP_TYPE = hatch
PYTHON_ANNOTATED_TYPES_LICENSE = MIT
PYTHON_ANNOTATED_TYPES_LICENSE_FILES = LICENSE

$(eval $(python-package))
