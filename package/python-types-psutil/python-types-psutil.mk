################################################################################
#
# python-types-psutil
#
################################################################################

PYTHON_TYPES_PSUTIL_VERSION = 6.1.0.20241221
PYTHON_TYPES_PSUTIL_SOURCE = types_psutil-$(PYTHON_TYPES_PSUTIL_VERSION).tar.gz
PYTHON_TYPES_PSUTIL_SITE = https://files.pythonhosted.org/packages/44/8c/5f82cd554cc5bb79d137f082e4c9f8d22e85c8c08dabee4971d422a9abdd
PYTHON_TYPES_PSUTIL_SETUP_TYPE = setuptools
PYTHON_TYPES_PSUTIL_LICENSE = Apache-2.0
PYTHON_TYPES_PSUTIL_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
