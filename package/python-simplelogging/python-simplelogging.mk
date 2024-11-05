################################################################################
#
# python-simplelogging
#
################################################################################

PYTHON_SIMPLELOGGING_VERSION = 0.12.0
PYTHON_SIMPLELOGGING_SOURCE = simplelogging-$(PYTHON_SIMPLELOGGING_VERSION).tar.gz
PYTHON_SIMPLELOGGING_SITE = https://files.pythonhosted.org/packages/30/71/d6b6513598e6a4300f6142a839d1b0e10a25a4707f1b586d9a6331be91bb
PYTHON_SIMPLELOGGING_SETUP_TYPE = poetry
PYTHON_SIMPLELOGGING_LICENSE = BSD-3-Clause
PYTHON_SIMPLELOGGING_LICENSE_FILES = LICENSE

$(eval $(python-package))
