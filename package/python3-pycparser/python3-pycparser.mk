################################################################################
#
# python3-pycparser
#
################################################################################

# Please keep in sync with package/python-pycparser/python-pycparser.mk
PYTHON3_PYCPARSER_VERSION = 2.20
PYTHON3_PYCPARSER_SOURCE = pycparser-$(PYTHON3_PYCPARSER_VERSION).tar.gz
PYTHON3_PYCPARSER_SITE = https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd
PYTHON3_PYCPARSER_SETUP_TYPE = setuptools
PYTHON3_PYCPARSER_LICENSE = BSD-3-Clause
PYTHON3_PYCPARSER_LICENSE_FILES = LICENSE
HOST_PYTHON3_PYCPARSER_DL_SUBDIR = python-pycparser
HOST_PYTHON3_PYCPARSER_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
