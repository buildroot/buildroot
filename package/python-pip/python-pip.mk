################################################################################
#
# python-pip
#
################################################################################

PYTHON_PIP_VERSION = 26.1
PYTHON_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON_PIP_SITE = https://files.pythonhosted.org/packages/73/7e/d2b04004e1068ad4fdfa2f227b839b5d03e602e47cdbbf49de71137c9546
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
