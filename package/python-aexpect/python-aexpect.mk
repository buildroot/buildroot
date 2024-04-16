################################################################################
#
# python-aexpect
#
################################################################################

PYTHON_AEXPECT_VERSION = 1.7.0
PYTHON_AEXPECT_SOURCE = aexpect-$(PYTHON_AEXPECT_VERSION).tar.gz
PYTHON_AEXPECT_SITE = https://files.pythonhosted.org/packages/dd/32/738b5190adb5ed387d3e755885f646b714fbf9c22adbda7ff988db7ede49
PYTHON_AEXPECT_SETUP_TYPE = setuptools
PYTHON_AEXPECT_LICENSE = GPL-2.0+
PYTHON_AEXPECT_LICENSE_FILES = LICENSE

$(eval $(python-package))
