################################################################################
#
# python-pip
#
################################################################################

PYTHON_PIP_VERSION = 25.2
PYTHON_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON_PIP_SITE = https://files.pythonhosted.org/packages/20/16/650289cd3f43d5a2fadfd98c68bd1e1e7f2550a1a5326768cddfbcedb2c5
PYTHON_PIP_SETUP_TYPE = setuptools
PYTHON_PIP_LICENSE = MIT
PYTHON_PIP_LICENSE_FILES = LICENSE.txt
PYTHON_PIP_CPE_ID_VENDOR = pypa
PYTHON_PIP_CPE_ID_PRODUCT = pip
# Disputed CVE: things work as designed, and only affects the
# --extra-index-url option. This CVE will never be fixed.
PYTHON_PIP_IGNORE_CVES += CVE-2018-20225

$(eval $(python-package))
$(eval $(host-python-package))
