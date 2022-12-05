################################################################################
#
# python-tempora
#
################################################################################

PYTHON_TEMPORA_VERSION = 5.0.2
PYTHON_TEMPORA_SOURCE = tempora-$(PYTHON_TEMPORA_VERSION).tar.gz
PYTHON_TEMPORA_SITE = https://files.pythonhosted.org/packages/72/2c/9aff4204a4ea5172b0cb3508f8a504ab6562ba539825ea2e33a5b4cb629b
PYTHON_TEMPORA_LICENSE = MIT
PYTHON_TEMPORA_LICENSE_FILES = LICENSE
PYTHON_TEMPORA_SETUP_TYPE = setuptools
PYTHON_TEMPORA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
