################################################################################
#
# python-httpcore2
#
################################################################################

PYTHON_HTTPCORE2_VERSION = 2.13.1
PYTHON_HTTPCORE2_SOURCE = httpcore2-$(PYTHON_HTTPCORE2_VERSION).tar.gz
PYTHON_HTTPCORE2_SITE = https://files.pythonhosted.org/packages/cb/f3/1db7aa2bc2524062192bb0e0323969492d1883152a232fe36eea65f4e35c
PYTHON_HTTPCORE2_SETUP_TYPE = hatch
PYTHON_HTTPCORE2_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE2_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE2_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-uv-dynamic-versioning

$(eval $(python-package))
