################################################################################
#
# python-telnetlib3
#
################################################################################

PYTHON_TELNETLIB3_VERSION = 5.0.1
PYTHON_TELNETLIB3_SOURCE = telnetlib3-$(PYTHON_TELNETLIB3_VERSION).tar.gz
PYTHON_TELNETLIB3_SITE = https://files.pythonhosted.org/packages/b2/6f/92e130274d84487c48b149f1c5bade54dae3cf535b4c7a5d4ca3e6579590
PYTHON_TELNETLIB3_SETUP_TYPE = hatch
PYTHON_TELNETLIB3_LICENSE = ISC
PYTHON_TELNETLIB3_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
