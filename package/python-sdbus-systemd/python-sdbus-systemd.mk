################################################################################
#
# python-sdbus-systemd
#
################################################################################

PYTHON_SDBUS_SYSTEMD_VERSION = 1.0.0
PYTHON_SDBUS_SYSTEMD_SOURCE = sdbus-systemd-$(PYTHON_SDBUS_SYSTEMD_VERSION).tar.gz
PYTHON_SDBUS_SYSTEMD_SITE = https://files.pythonhosted.org/packages/e1/84/911de0ea63a0dab814dc94f73e7b916bfd4675e1e983b58a725a26a65db4
PYTHON_SDBUS_SYSTEMD_SETUP_TYPE = setuptools
PYTHON_SDBUS_SYSTEMD_LICENSE = LGPL-2.1+
PYTHON_SDBUS_SYSTEMD_LICENSE_FILES = COPYING.LESSER

$(eval $(python-package))
