################################################################################
#
# python-requests
#
################################################################################

PYTHON_REQUESTS_VERSION = 2.32.5
PYTHON_REQUESTS_SOURCE = requests-$(PYTHON_REQUESTS_VERSION).tar.gz
PYTHON_REQUESTS_SITE = https://files.pythonhosted.org/packages/c9/74/b3ff8e6c8446842c3f5c837e9c3dfcfe2018ea6ecef224c710c85ef728f4
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
