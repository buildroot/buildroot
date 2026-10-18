################################################################################
#
# python-httpcore2
#
################################################################################

PYTHON_HTTPCORE2_VERSION = 2.14.0
PYTHON_HTTPCORE2_SOURCE = httpcore2-$(PYTHON_HTTPCORE2_VERSION).tar.gz
PYTHON_HTTPCORE2_SITE = https://files.pythonhosted.org/packages/30/ff/b53af1b49bb2cb5fa97c92215614b173ca5c1a99ded80e2d52f15a94fa6d
PYTHON_HTTPCORE2_SETUP_TYPE = hatch
PYTHON_HTTPCORE2_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE2_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE2_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-uv-dynamic-versioning

$(eval $(python-package))
