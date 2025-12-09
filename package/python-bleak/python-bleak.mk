################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 2.0.0
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/ce/cb/20f3dd0498a820278c7078dce786676d18342721a3723591d5853323b363
PYTHON_BLEAK_SETUP_TYPE = poetry
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE

$(eval $(python-package))
