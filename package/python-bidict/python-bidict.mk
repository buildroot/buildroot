################################################################################
#
# python-bidict
#
################################################################################

PYTHON_BIDICT_VERSION = 0.24.1
PYTHON_BIDICT_SOURCE = bidict-$(PYTHON_BIDICT_VERSION).tar.gz
PYTHON_BIDICT_SITE = https://files.pythonhosted.org/packages/a8/f2/8d2dd8276ca05e1f5157b6a0d34efb2f585f47a0fbed61e8aad04b221f0b
PYTHON_BIDICT_SETUP_TYPE = pep517
PYTHON_BIDICT_LICENSE = MPL-2.0
PYTHON_BIDICT_LICENSE_FILES = LICENSE
PYTHON_BIDICT_DEPENDENCIES = host-python-uv-build
PYTHON_BIDICT_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
