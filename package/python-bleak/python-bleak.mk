################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 3.0.2
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/16/df/05a3f80ca8e3f7f5b0dba68a9e618147c909ccdba1468f07487dc8d72a9d
PYTHON_BLEAK_SETUP_TYPE = pep517
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE
PYTHON_BLEAK_DEPENDENCIES = host-python-uv-build
PYTHON_BLEAK_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
