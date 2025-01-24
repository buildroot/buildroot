################################################################################
#
# python-hyperframe
#
################################################################################

PYTHON_HYPERFRAME_VERSION = 6.1.0
PYTHON_HYPERFRAME_SOURCE = hyperframe-$(PYTHON_HYPERFRAME_VERSION).tar.gz
PYTHON_HYPERFRAME_SITE = https://files.pythonhosted.org/packages/02/e7/94f8232d4a74cc99514c13a9f995811485a6903d48e5d952771ef6322e30
PYTHON_HYPERFRAME_SETUP_TYPE = setuptools
PYTHON_HYPERFRAME_LICENSE = MIT
PYTHON_HYPERFRAME_LICENSE_FILES = LICENSE

$(eval $(python-package))
