################################################################################
#
# python-simple-pid
#
################################################################################

PYTHON_SIMPLE_PID_VERSION = 2.0.1
PYTHON_SIMPLE_PID_SOURCE = simple_pid-$(PYTHON_SIMPLE_PID_VERSION).tar.gz
PYTHON_SIMPLE_PID_SITE = https://files.pythonhosted.org/packages/78/0a/c670a4f4dea4b21c0b074b193c54698e5e047479e688c8d5495d264c9921
PYTHON_SIMPLE_PID_SETUP_TYPE = setuptools
PYTHON_SIMPLE_PID_LICENSE = MIT
PYTHON_SIMPLE_PID_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
