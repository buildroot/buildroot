################################################################################
#
# python-httpcore
#
################################################################################

PYTHON_HTTPCORE_VERSION = 1.0.9
PYTHON_HTTPCORE_SOURCE = httpcore-$(PYTHON_HTTPCORE_VERSION).tar.gz
PYTHON_HTTPCORE_SITE = https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb
PYTHON_HTTPCORE_SETUP_TYPE = hatch
PYTHON_HTTPCORE_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
