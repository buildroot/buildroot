################################################################################
#
# python-iptables
#
################################################################################

PYTHON_IPTABLES_VERSION = 1.0.0
PYTHON_IPTABLES_SITE = https://files.pythonhosted.org/packages/ca/6e/cba9c6f4b5a1963b7f5b015f5ed5e2eec7a94ac460570e3474177c4004d6
PYTHON_IPTABLES_SETUP_TYPE = setuptools
PYTHON_IPTABLES_LICENSE = Apache-2.0
PYTHON_IPTABLES_LICENSE_FILES = NOTICE

$(eval $(python-package))
