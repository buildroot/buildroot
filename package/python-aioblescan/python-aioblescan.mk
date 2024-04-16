################################################################################
#
# python-aioblescan
#
################################################################################

PYTHON_AIOBLESCAN_VERSION = 0.2.14
PYTHON_AIOBLESCAN_SOURCE = aioblescan-$(PYTHON_AIOBLESCAN_VERSION).tar.gz
PYTHON_AIOBLESCAN_SITE = https://files.pythonhosted.org/packages/45/15/faf503083bc5a2d81f1b17fbbe30d15f35217b6c5e944c771c8760354d59
PYTHON_AIOBLESCAN_SETUP_TYPE = setuptools
PYTHON_AIOBLESCAN_LICENSE = MIT
PYTHON_AIOBLESCAN_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
