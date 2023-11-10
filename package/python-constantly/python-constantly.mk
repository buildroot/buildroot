################################################################################
#
# python-constantly
#
################################################################################

PYTHON_CONSTANTLY_VERSION = 23.10.4
PYTHON_CONSTANTLY_SOURCE = constantly-$(PYTHON_CONSTANTLY_VERSION).tar.gz
PYTHON_CONSTANTLY_SITE = https://files.pythonhosted.org/packages/4d/6f/cb2a94494ff74aa9528a36c5b1422756330a75a8367bf20bd63171fc324d
PYTHON_CONSTANTLY_SETUP_TYPE = setuptools
PYTHON_CONSTANTLY_LICENSE = MIT
PYTHON_CONSTANTLY_LICENSE_FILES = LICENSE
PYTHON_CONSTANTLY_DEPENDENCIES = host-python-versioneer

$(eval $(python-package))
