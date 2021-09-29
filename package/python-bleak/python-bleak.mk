################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 0.11.0
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/7c/f3/817132098d57f5717f7f7dc46357e4ca2647c9addaf8e571382d12a28546
PYTHON_BLEAK_SETUP_TYPE = setuptools
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE

$(eval $(python-package))
