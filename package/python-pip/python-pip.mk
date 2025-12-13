################################################################################
#
# python-pip
#
################################################################################

PYTHON_PIP_VERSION = 25.3
PYTHON_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON_PIP_SITE = https://files.pythonhosted.org/packages/fe/6e/74a3f0179a4a73a53d66ce57fdb4de0080a8baa1de0063de206d6167acc2
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
