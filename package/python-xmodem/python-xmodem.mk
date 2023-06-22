################################################################################
#
# python-xmodem
#
################################################################################

PYTHON_XMODEM_VERSION = 0.4.7
PYTHON_XMODEM_SOURCE = xmodem-$(PYTHON_XMODEM_VERSION).tar.gz
PYTHON_XMODEM_SITE = https://files.pythonhosted.org/packages/3d/17/fd6668a09afdc46c22990172b6f65e07dfb5bcf38960d063a7a887ca926d
PYTHON_XMODEM_SETUP_TYPE = setuptools
PYTHON_XMODEM_LICENSE = MIT
PYTHON_XMODEM_LICENSE_FILES = LICENSE

$(eval $(python-package))
