################################################################################
#
# python-daemon
#
################################################################################

PYTHON_DAEMON_VERSION = 3.1.2
PYTHON_DAEMON_SOURCE = python_daemon-$(PYTHON_DAEMON_VERSION).tar.gz
PYTHON_DAEMON_SITE = https://files.pythonhosted.org/packages/3d/37/4f10e37bdabc058a32989da2daf29e57dc59dbc5395497f3d36d5f5e2694
PYTHON_DAEMON_LICENSE = Apache-2.0 (library), GPL-3.0+ (test, build)
PYTHON_DAEMON_LICENSE_FILES = LICENSE.ASF-2 LICENSE.GPL-3
PYTHON_DAEMON_SETUP_TYPE = setuptools
PYTHON_DAEMON_DEPENDENCIES = host-python-changelog-chug host-python-docutils

$(eval $(python-package))
