################################################################################
#
# python-telnetlib3
#
################################################################################

PYTHON_TELNETLIB3_VERSION = 2.0.4
PYTHON_TELNETLIB3_SOURCE = telnetlib3-$(PYTHON_TELNETLIB3_VERSION).tar.gz
PYTHON_TELNETLIB3_SITE = https://files.pythonhosted.org/packages/ef/af/0fadfddd1764e627f4ba9c7381caaf121795ed459a1cc3d0fbb89a187954
PYTHON_TELNETLIB3_SETUP_TYPE = setuptools
PYTHON_TELNETLIB3_LICENSE = ISC
PYTHON_TELNETLIB3_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
