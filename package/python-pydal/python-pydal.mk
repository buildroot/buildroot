################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20240906.1
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/9f/80/cbaf7c90eec1da2404b1e6d100687ec2f01e6ccfbe695922a00de882ec84
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
