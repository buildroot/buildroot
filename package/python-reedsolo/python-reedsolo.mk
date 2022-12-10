################################################################################
#
# python-reedsolo
#
################################################################################

PYTHON_REEDSOLO_VERSION = 1.6.0
PYTHON_REEDSOLO_SOURCE = reedsolo-$(PYTHON_REEDSOLO_VERSION).tar.gz
PYTHON_REEDSOLO_SITE = https://files.pythonhosted.org/packages/9b/10/28d1492cc82a103bc06f18cb9a9dbb3a9168ab2e4068801fa0aa0c76b231
PYTHON_REEDSOLO_SETUP_TYPE = setuptools
PYTHON_REEDSOLO_LICENSE = Public Domain
PYTHON_REEDSOLO_LICENSE_FILES = LICENSE

$(eval $(python-package))
