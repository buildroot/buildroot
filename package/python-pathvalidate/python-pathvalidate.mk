################################################################################
#
# python-pathvalidate
#
################################################################################

PYTHON_PATHVALIDATE_VERSION = 2.5.0
PYTHON_PATHVALIDATE_SOURCE = pathvalidate-$(PYTHON_PATHVALIDATE_VERSION).tar.gz
PYTHON_PATHVALIDATE_SITE = https://files.pythonhosted.org/packages/2e/89/7853a1ea323e848ab1e90c8930733bc19e35a935deb80d78b572c36ea33f
PYTHON_PATHVALIDATE_SETUP_TYPE = setuptools
PYTHON_PATHVALIDATE_LICENSE = MIT
PYTHON_PATHVALIDATE_LICENSE_FILES = LICENSE

$(eval $(python-package))
