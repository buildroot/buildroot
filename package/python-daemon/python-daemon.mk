################################################################################
#
# python-daemon
#
################################################################################

PYTHON_DAEMON_VERSION = 3.0.1
PYTHON_DAEMON_SITE = https://files.pythonhosted.org/packages/84/50/97b81327fccbb70eb99f3c95bd05a0c9d7f13fb3f4cfd975885110d1205a
PYTHON_DAEMON_LICENSE = Apache-2.0 (library), GPL-3.0+ (test, build)
PYTHON_DAEMON_LICENSE_FILES = LICENSE.ASF-2 LICENSE.GPL-3
PYTHON_DAEMON_SETUP_TYPE = setuptools
PYTHON_DAEMON_DEPENDENCIES = host-python-docutils

$(eval $(python-package))
