################################################################################
#
# python-daemon
#
################################################################################

PYTHON_DAEMON_VERSION = 2.3.2
PYTHON_DAEMON_SITE = https://files.pythonhosted.org/packages/d9/3c/727b06abb46fead341a2bdad04ba4a4db5395c44c45d8ba0aa82b517e462
PYTHON_DAEMON_LICENSE = Apache-2.0 (library), GPL-3.0+ (test, build)
PYTHON_DAEMON_LICENSE_FILES = LICENSE.ASF-2 LICENSE.GPL-3
PYTHON_DAEMON_SETUP_TYPE = setuptools
PYTHON_DAEMON_DEPENDENCIES = host-python-docutils

$(eval $(python-package))
