################################################################################
#
# python-isodate
#
################################################################################

PYTHON_ISODATE_VERSION = 0.7.2
PYTHON_ISODATE_SOURCE = isodate-$(PYTHON_ISODATE_VERSION).tar.gz
PYTHON_ISODATE_SITE = https://files.pythonhosted.org/packages/source/i/isodate
PYTHON_ISODATE_SETUP_TYPE = setuptools
PYTHON_ISODATE_LICENSE = BSD-3-Clause
PYTHON_ISODATE_LICENSE_FILES = LICENSE

PYTHON_ISODATE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
