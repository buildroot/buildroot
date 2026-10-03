################################################################################
#
# python-dictdiffer
#
################################################################################

PYTHON_DICTDIFFER_VERSION = 0.10.0
PYTHON_DICTDIFFER_SOURCE = dictdiffer-$(PYTHON_DICTDIFFER_VERSION).tar.gz
PYTHON_DICTDIFFER_SITE = https://files.pythonhosted.org/packages/0c/31/84b2b2113c2c972431582bffd74f0d04b5efd9126538127b766275580950
PYTHON_DICTDIFFER_SETUP_TYPE = hatch
PYTHON_DICTDIFFER_LICENSE = MIT
PYTHON_DICTDIFFER_LICENSE_FILES = LICENSE
PYTHON_DICTDIFFER_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
