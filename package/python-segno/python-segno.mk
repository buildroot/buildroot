################################################################################
#
# python-segno
#
################################################################################

PYTHON_SEGNO_VERSION = 1.6.6
PYTHON_SEGNO_SOURCE = segno-$(PYTHON_SEGNO_VERSION).tar.gz
PYTHON_SEGNO_SITE = https://files.pythonhosted.org/packages/1c/2e/b396f750c53f570055bf5a9fc1ace09bed2dff013c73b7afec5702a581ba
PYTHON_SEGNO_SETUP_TYPE = flit
PYTHON_SEGNO_LICENSE = BSD-3-Clause
PYTHON_SEGNO_LICENSE_FILES = LICENSE

$(eval $(python-package))
