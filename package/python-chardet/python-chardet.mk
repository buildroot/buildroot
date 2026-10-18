################################################################################
#
# python-chardet
#
################################################################################

PYTHON_CHARDET_VERSION = 7.7.0
PYTHON_CHARDET_SOURCE = chardet-$(PYTHON_CHARDET_VERSION).tar.gz
PYTHON_CHARDET_SITE = https://files.pythonhosted.org/packages/47/92/3d893ac5d338b9a9af34c5b517d77492dcea8a10254254eead4215a96f3f
PYTHON_CHARDET_SETUP_TYPE = hatch
PYTHON_CHARDET_LICENSE = 0BSD
PYTHON_CHARDET_LICENSE_FILES = LICENSE
PYTHON_CHARDET_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
