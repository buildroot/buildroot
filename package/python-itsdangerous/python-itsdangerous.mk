################################################################################
#
# python-itsdangerous
#
################################################################################

PYTHON_ITSDANGEROUS_VERSION = 2.1.2
PYTHON_ITSDANGEROUS_SOURCE = itsdangerous-$(PYTHON_ITSDANGEROUS_VERSION).tar.gz
PYTHON_ITSDANGEROUS_SITE = https://files.pythonhosted.org/packages/7f/a1/d3fb83e7a61fa0c0d3d08ad0a94ddbeff3731c05212617dff3a94e097f08
PYTHON_ITSDANGEROUS_SETUP_TYPE = setuptools
PYTHON_ITSDANGEROUS_LICENSE = BSD-3-Clause
PYTHON_ITSDANGEROUS_LICENSE_FILES = LICENSE.rst docs/license.rst

$(eval $(python-package))
