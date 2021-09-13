################################################################################
#
# python-aioblescan
#
################################################################################

PYTHON_AIOBLESCAN_VERSION = 0.2.8
PYTHON_AIOBLESCAN_SOURCE = aioblescan-$(PYTHON_AIOBLESCAN_VERSION).tar.gz
PYTHON_AIOBLESCAN_SITE = https://files.pythonhosted.org/packages/d2/10/b8b496903f33935c99f3602200d44ccc0b0a57b87e5fa65b89466c1b1f31
PYTHON_AIOBLESCAN_SETUP_TYPE = setuptools
PYTHON_AIOBLESCAN_LICENSE = MIT
PYTHON_AIOBLESCAN_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
