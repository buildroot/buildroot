################################################################################
#
# python-telnetlib3
#
################################################################################

PYTHON_TELNETLIB3_VERSION = 5.0.2
PYTHON_TELNETLIB3_SOURCE = telnetlib3-$(PYTHON_TELNETLIB3_VERSION).tar.gz
PYTHON_TELNETLIB3_SITE = https://files.pythonhosted.org/packages/5a/d8/f91aaffb489997de5cb04debb4e251d9523835737935dbed6d1fb2f20a9e
PYTHON_TELNETLIB3_SETUP_TYPE = hatch
PYTHON_TELNETLIB3_LICENSE = ISC
PYTHON_TELNETLIB3_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
