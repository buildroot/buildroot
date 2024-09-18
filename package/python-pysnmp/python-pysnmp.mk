################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 7.1.3
PYTHON_PYSNMP_SOURCE = pysnmp-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/f3/0c/bb2ccb587b5e79036dd83aa5fe835c2bc460a3098c4060461e9d324c6670
PYTHON_PYSNMP_SETUP_TYPE = pep517
PYTHON_PYSNMP_LICENSE = BSD-2-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst
PYTHON_PYSNMP_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))
