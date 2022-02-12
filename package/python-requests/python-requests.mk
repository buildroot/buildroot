################################################################################
#
# python-requests
#
################################################################################

PYTHON_REQUESTS_VERSION = 2.27.1
PYTHON_REQUESTS_SOURCE = requests-$(PYTHON_REQUESTS_VERSION).tar.gz
PYTHON_REQUESTS_SITE = https://files.pythonhosted.org/packages/60/f3/26ff3767f099b73e0efa138a9998da67890793bfa475d8278f84a30fec77
PYTHON_REQUESTS_SETUP_TYPE = setuptools
PYTHON_REQUESTS_LICENSE = Apache-2.0
PYTHON_REQUESTS_LICENSE_FILES = LICENSE
PYTHON_REQUESTS_CPE_ID_VENDOR = python
PYTHON_REQUESTS_CPE_ID_PRODUCT = requests
HOST_PYTHON_REQUESTS_DEPENDENCIES = \
	host-python-certifi \
	host-python-charset-normalizer \
	host-python-idna \
	host-python-urllib3

$(eval $(python-package))
$(eval $(host-python-package))
