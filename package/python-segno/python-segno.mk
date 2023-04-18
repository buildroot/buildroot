################################################################################
#
# python-segno
#
################################################################################

PYTHON_SEGNO_VERSION = 1.5.2
PYTHON_SEGNO_SOURCE = segno-$(PYTHON_SEGNO_VERSION).tar.gz
PYTHON_SEGNO_SITE = https://files.pythonhosted.org/packages/90/2a/2fedf1023f9273d8326362df7936748ebadef92ba53ab7970d9b8df1a6c2
PYTHON_SEGNO_SETUP_TYPE = setuptools
PYTHON_SEGNO_LICENSE = BSD-3-Clause
PYTHON_SEGNO_LICENSE_FILES = LICENSE

$(eval $(python-package))
