################################################################################
#
# python-wrapt
#
################################################################################

PYTHON_WRAPT_VERSION = 1.14.1
PYTHON_WRAPT_SOURCE = wrapt-$(PYTHON_WRAPT_VERSION).tar.gz
PYTHON_WRAPT_SITE = https://files.pythonhosted.org/packages/11/eb/e06e77394d6cf09977d92bff310cb0392930c08a338f99af6066a5a98f92
PYTHON_WRAPT_SETUP_TYPE = setuptools
PYTHON_WRAPT_LICENSE = BSD-2-Clause
PYTHON_WRAPT_LICENSE_FILES = LICENSE

$(eval $(python-package))
