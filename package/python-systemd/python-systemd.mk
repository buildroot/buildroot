################################################################################
#
# python-systemd
#
################################################################################

PYTHON_SYSTEMD_VERSION = 235
PYTHON_SYSTEMD_SOURCE = systemd-python-$(PYTHON_SYSTEMD_VERSION).tar.gz
PYTHON_SYSTEMD_SITE = https://files.pythonhosted.org/packages/10/9e/ab4458e00367223bda2dd7ccf0849a72235ee3e29b36dce732685d9b7ad9
PYTHON_SYSTEMD_SETUP_TYPE = setuptools
PYTHON_SYSTEMD_LICENSE = LGPL-2.1
PYTHON_SYSTEMD_LICENSE_FILES = LICENSE.txt
PYTHON_SYSTEMD_DEPENDENCIES = systemd # To be able to link against libsystemd

$(eval $(python-package))
