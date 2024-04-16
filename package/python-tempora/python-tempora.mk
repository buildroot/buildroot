################################################################################
#
# python-tempora
#
################################################################################

PYTHON_TEMPORA_VERSION = 5.5.0
PYTHON_TEMPORA_SOURCE = tempora-$(PYTHON_TEMPORA_VERSION).tar.gz
PYTHON_TEMPORA_SITE = https://files.pythonhosted.org/packages/c9/dc/97d90b9f64dbe4f599023e19602b33a2cced68462db67a3d4805a77cf784
PYTHON_TEMPORA_LICENSE = MIT
PYTHON_TEMPORA_LICENSE_FILES = LICENSE
PYTHON_TEMPORA_SETUP_TYPE = setuptools
PYTHON_TEMPORA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
