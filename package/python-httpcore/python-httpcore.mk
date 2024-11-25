################################################################################
#
# python-httpcore
#
################################################################################

PYTHON_HTTPCORE_VERSION = 1.0.6
PYTHON_HTTPCORE_SOURCE = httpcore-$(PYTHON_HTTPCORE_VERSION).tar.gz
PYTHON_HTTPCORE_SITE = https://files.pythonhosted.org/packages/b6/44/ed0fa6a17845fb033bd885c03e842f08c1b9406c86a2e60ac1ae1b9206a6
PYTHON_HTTPCORE_SETUP_TYPE = hatch
PYTHON_HTTPCORE_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
