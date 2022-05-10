################################################################################
#
# python-rfc3987
#
################################################################################

PYTHON_RFC3987_VERSION = 1.3.8
PYTHON_RFC3987_SOURCE = rfc3987-$(PYTHON_RFC3987_VERSION).tar.gz
PYTHON_RFC3987_SITE = https://files.pythonhosted.org/packages/14/bb/f1395c4b62f251a1cb503ff884500ebd248eed593f41b469f89caa3547bd
PYTHON_RFC3987_SETUP_TYPE = setuptools
PYTHON_RFC3987_LICENSE = GPL-3.0+
PYTHON_RFC3987_LICENSE_FILES = COPYING.txt

$(eval $(python-package))
