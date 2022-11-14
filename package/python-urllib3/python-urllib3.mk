################################################################################
#
# python-urllib3
#
################################################################################

PYTHON_URLLIB3_VERSION = 1.26.12
PYTHON_URLLIB3_SOURCE = urllib3-$(PYTHON_URLLIB3_VERSION).tar.gz
PYTHON_URLLIB3_SITE = https://files.pythonhosted.org/packages/b2/56/d87d6d3c4121c0bcec116919350ca05dc3afd2eeb7dc88d07e8083f8ea94
PYTHON_URLLIB3_LICENSE = MIT
PYTHON_URLLIB3_LICENSE_FILES = LICENSE.txt
PYTHON_URLLIB3_CPE_ID_VENDOR = python
PYTHON_URLLIB3_CPE_ID_PRODUCT = urllib3
PYTHON_URLLIB3_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
