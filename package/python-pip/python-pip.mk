################################################################################
#
# python-pip
#
################################################################################

PYTHON_PIP_VERSION = 26.3
PYTHON_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON_PIP_SITE = https://files.pythonhosted.org/packages/53/c7/f8d9e2e0e7c1ed8a22a10eeb3b5bf7860bc07d8446c7a978a882c5c8214b
PYTHON_PIP_SETUP_TYPE = flit
PYTHON_PIP_LICENSE = MIT
PYTHON_PIP_LICENSE_FILES = LICENSE.txt
PYTHON_PIP_CPE_ID_VENDOR = pypa
PYTHON_PIP_CPE_ID_PRODUCT = pip
# Disputed CVE: things work as designed, and only affects the
# --extra-index-url option. This CVE will never be fixed.
PYTHON_PIP_IGNORE_CVES += CVE-2018-20225

$(eval $(python-package))
$(eval $(host-python-package))
