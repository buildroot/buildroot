################################################################################
#
# python-hyperframe
#
################################################################################

PYTHON_HYPERFRAME_VERSION = 6.0.1
PYTHON_HYPERFRAME_SOURCE = hyperframe-$(PYTHON_HYPERFRAME_VERSION).tar.gz
PYTHON_HYPERFRAME_SITE = https://files.pythonhosted.org/packages/5a/2a/4747bff0a17f7281abe73e955d60d80aae537a5d203f417fa1c2e7578ebb
PYTHON_HYPERFRAME_SETUP_TYPE = setuptools
PYTHON_HYPERFRAME_LICENSE = MIT
PYTHON_HYPERFRAME_LICENSE_FILES = LICENSE

$(eval $(python-package))
