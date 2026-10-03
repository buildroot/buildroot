################################################################################
#
# python-traitlets
#
################################################################################

PYTHON_TRAITLETS_VERSION = 5.16.1
PYTHON_TRAITLETS_SOURCE = traitlets-$(PYTHON_TRAITLETS_VERSION).tar.gz
PYTHON_TRAITLETS_SITE = https://files.pythonhosted.org/packages/2c/2e/a7fbfe268c8a3b32546930c0297c101d65a4a14c304ad5790a9f478f0e4e
PYTHON_TRAITLETS_LICENSE = BSD-3-Clause
PYTHON_TRAITLETS_LICENSE_FILES = LICENSE
PYTHON_TRAITLETS_SETUP_TYPE = hatch

$(eval $(python-package))
