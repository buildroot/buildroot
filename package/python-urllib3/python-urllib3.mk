################################################################################
#
# python-urllib3
#
################################################################################

PYTHON_URLLIB3_VERSION = 1.26.10
PYTHON_URLLIB3_SOURCE = urllib3-$(PYTHON_URLLIB3_VERSION).tar.gz
PYTHON_URLLIB3_SITE = https://files.pythonhosted.org/packages/25/36/f056e5f1389004cf886bb7a8514077f24224238a7534497c014a6b9ac770
PYTHON_URLLIB3_LICENSE = MIT
PYTHON_URLLIB3_LICENSE_FILES = LICENSE.txt
PYTHON_URLLIB3_CPE_ID_VENDOR = python
PYTHON_URLLIB3_CPE_ID_PRODUCT = urllib3
PYTHON_URLLIB3_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
