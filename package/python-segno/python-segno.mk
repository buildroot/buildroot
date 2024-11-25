################################################################################
#
# python-segno
#
################################################################################

PYTHON_SEGNO_VERSION = 1.6.1
PYTHON_SEGNO_SOURCE = segno-$(PYTHON_SEGNO_VERSION).tar.gz
PYTHON_SEGNO_SITE = https://files.pythonhosted.org/packages/5d/74/3896e205306a1b43d6b88326e5838572d97b4b74df8c9cd11acfcd9db503
PYTHON_SEGNO_SETUP_TYPE = flit
PYTHON_SEGNO_LICENSE = BSD-3-Clause
PYTHON_SEGNO_LICENSE_FILES = LICENSE

$(eval $(python-package))
