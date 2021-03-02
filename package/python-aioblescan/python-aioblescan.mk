################################################################################
#
# python-aioblescan
#
################################################################################

PYTHON_AIOBLESCAN_VERSION = 0.2.7
PYTHON_AIOBLESCAN_SOURCE = aioblescan-$(PYTHON_AIOBLESCAN_VERSION).tar.gz
PYTHON_AIOBLESCAN_SITE = https://files.pythonhosted.org/packages/78/2c/c09d8f83ed6c2ca6c4f803f2e5c349698eb78b82c8d5e9302a8eed1a7480
PYTHON_AIOBLESCAN_SETUP_TYPE = setuptools
PYTHON_AIOBLESCAN_LICENSE = MIT
PYTHON_AIOBLESCAN_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
