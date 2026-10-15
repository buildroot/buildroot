################################################################################
#
# python-wrapt
#
################################################################################

PYTHON_WRAPT_VERSION = 2.5.1
PYTHON_WRAPT_SOURCE = wrapt-$(PYTHON_WRAPT_VERSION).tar.gz
PYTHON_WRAPT_SITE = https://files.pythonhosted.org/packages/04/22/89e2f3bdae5cb34e0cab0cd86d7172dbf418de4b46c9b17b9c7a560dfa44
PYTHON_WRAPT_SETUP_TYPE = setuptools
PYTHON_WRAPT_LICENSE = BSD-2-Clause
PYTHON_WRAPT_LICENSE_FILES = LICENSE

$(eval $(python-package))
