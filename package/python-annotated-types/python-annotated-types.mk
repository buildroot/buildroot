################################################################################
#
# python-annotated-types
#
################################################################################

PYTHON_ANNOTATED_TYPES_VERSION = 0.6.0
PYTHON_ANNOTATED_TYPES_SOURCE = annotated_types-$(PYTHON_ANNOTATED_TYPES_VERSION).tar.gz
PYTHON_ANNOTATED_TYPES_SITE = https://files.pythonhosted.org/packages/67/fe/8c7b275824c6d2cd17c93ee85d0ee81c090285b6d52f4876ccc47cf9c3c4
PYTHON_ANNOTATED_TYPES_SETUP_TYPE = pep517
PYTHON_ANNOTATED_TYPES_LICENSE = MIT
PYTHON_ANNOTATED_TYPES_LICENSE_FILES = LICENSE
PYTHON_ANNOTATED_TYPES_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
