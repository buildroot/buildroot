################################################################################
#
# python3-requests
#
################################################################################

# Please keep in sync with package/python-requests/python-requests.mk
PYTHON3_REQUESTS_VERSION = 2.25.0
PYTHON3_REQUESTS_SOURCE = requests-$(PYTHON3_REQUESTS_VERSION).tar.gz
PYTHON3_REQUESTS_SITE = https://files.pythonhosted.org/packages/9f/14/4a6542a078773957aa83101336375c9597e6fe5889d20abda9c38f9f3ff2
PYTHON3_REQUESTS_SETUP_TYPE = setuptools
PYTHON3_REQUESTS_LICENSE = Apache-2.0
PYTHON3_REQUESTS_LICENSE_FILES = LICENSE
HOST_PYTHON3_REQUESTS_DL_SUBDIR = python-requests
HOST_PYTHON3_REQUESTS_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
