################################################################################
#
# python-segno
#
################################################################################

PYTHON_SEGNO_VERSION = 1.6.0
PYTHON_SEGNO_SOURCE = segno-$(PYTHON_SEGNO_VERSION).tar.gz
PYTHON_SEGNO_SITE = https://files.pythonhosted.org/packages/51/a8/960844fec8d853a4e8e91f64bdde323ea5a2a44357eca799e7f7f7bf2f1e
PYTHON_SEGNO_SETUP_TYPE = setuptools
PYTHON_SEGNO_LICENSE = BSD-3-Clause
PYTHON_SEGNO_LICENSE_FILES = LICENSE

$(eval $(python-package))
