################################################################################
#
# python-huepy
#
################################################################################

PYTHON_HUEPY_VERSION = 1.2.1
PYTHON_HUEPY_SOURCE = huepy-$(PYTHON_HUEPY_VERSION).tar.gz
PYTHON_HUEPY_SITE = https://files.pythonhosted.org/packages/d6/4e/2dae447d8858a31158ca6c313f5d1902bc83b8542bb5f10c0307de2973bc
PYTHON_HUEPY_LICENSE = GPL-3.0
PYTHON_HUEPY_LICENSE_FILES = LICENSE
PYTHON_HUEPY_SETUP_TYPE = setuptools

$(eval $(python-package))
